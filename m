Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D85FF0B2
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJNO5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJNO5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 10:57:16 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3811946C5
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 07:57:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Mpq9F60tQz9xGYt
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 22:52:01 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAH_5K+eEljD2LCAA--.17435S2;
        Fri, 14 Oct 2022 15:57:05 +0100 (CET)
Message-ID: <fb72bce5610434dd4c8742e3f1f6838d4795c64d.camel@huaweicloud.com>
Subject: -EBUSY in __bpf_arch_text_poke() for fmod_ret program
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     bpf@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:56:59 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAH_5K+eEljD2LCAA--.17435S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3ZrWxKw1rtryxGF18uFg_yoW8Jw48pF
        yIq348Z398GFs7WF4UGw42v39a9rs3Xw13Gay8t34rC3s2grnrZ3W8Kr4Ykr90k348WrWI
        yFn8t343Xan3JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4Q-yAABsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone

I want to introduce a kfunc() whose implementation is done in an eBPF
program, which injects the result.

This is what I did:

int noinline
_bpf_verify_pgp_signature(struct bpf_dynptr_kern *data_ptr,
                          struct bpf_dynptr_kern *sig_ptr,
                          struct bpf_key *trusted_keyring)
{
        return -EBADMSG;
}
ALLOW_ERROR_INJECTION(_bpf_verify_pgp_signature, ERRNO);

int bpf_verify_pgp_signature(struct bpf_dynptr_kern *data_ptr,
                             struct bpf_dynptr_kern *sig_ptr,
                             struct bpf_key *trusted_keyring)
{
[...]

        return _bpf_verify_pgp_signature(data_ptr, sig_ptr,
                                         trusted_keyring);
}

This is the sample of eBPF program doing the work:

SEC("fmod_ret/_bpf_verify_pgp_signature")
int BPF_PROG(pgp_sig_parse, struct bpf_dynptr *data_ptr,
             struct bpf_dynptr *sig_ptr,
             struct bpf_key *trusted_keyring, int ret)
{
        return 0;
}

However, the program fails to auto attach:

libbpf: prog 'pgp_sig_parse': failed to attach: Device or resource busy
libbpf: prog 'pgp_sig_parse': failed to auto-attach: -16

Not sure what is the cause, but the failure is here:

static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
				void *old_addr, void *new_addr)
{

[...]

	ret = -EBUSY;
	mutex_lock(&text_mutex);
	if (memcmp(ip, old_insn, X86_PATCH_SIZE))

Any ideas?

Thanks

Roberto

