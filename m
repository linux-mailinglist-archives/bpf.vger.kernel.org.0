Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5E5C0477
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 18:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIUQoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 12:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiIUQnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 12:43:37 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8628FA033D
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:32:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXkNj53bvz9xFmn
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 00:28:05 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnY16TPCtjagZmAA--.23049S2;
        Wed, 21 Sep 2022 17:32:25 +0100 (CET)
Message-ID: <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Date:   Wed, 21 Sep 2022 18:32:16 +0200
In-Reply-To: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnY16TPCtjagZmAA--.23049S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fKF1UGr15JFWxWw45Jrb_yoW8Kw13pF
        Z3KFnxuF1kAa429Fs29ayxWr4IyFsavay7W390yryrX398XFyav348XF45AFy3GFs2kw1j
        qr4j9ry5Z3yjyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBF1jj4NRzQABso
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-09-15 at 11:30 +0100, Lorenz Bauer wrote:
> Hi list,
> 
> Here is a summary of the talk I gave at LPC '22 titled "Closing the
> BPF map permission loophole", with slides at [0].
> 
> Problem #1: Read-only fds can be modified via a BPF program
> 
> 1. Craft a BPF program that executes bpf_map_update_elem(read-only
> fd, ...)
> 2. Load the program & execute it
> 
> The reason is that the verifier only checks bpf_map->map_flags in
> resolve_pseudo_ldimm64, but ignores fd->f_mode.
> 
> Fixing this problem is complicated by the fact that a user may use
> several distinct fds with differing permissions to refer to the same
> map, but that the verifier internally only tracks unique struct
> bpf_map. See [1].

Hi Lorenz

thanks for the detailed report. Unfortunately, I could not attend your
presentation at Linux Plumbers, and the recording is not yet available.
So, I rely on this and your slides.

I saw your fix #2, even if I didn't fully understand it. What do you
think instead about converting the fd modes to map flags (e.g.
BPF_F_RDONLY -> BPF_RDONLY_PROG), and we rely on the existing verifier
behavior for the _PROG counterparts? In this way, it will be the
verifier enforcing the decision made by security_bpf_map().

> Problem #2: Read-only fds can be "transmuted" into read-write fds via
> map in map
> 
> 1. BPF_MAP_UPDATE_ELEM(map in map fd, read-only fd)
> 2. BPF_MAP_LOOKUP_ELEM(map in map fd) = read-write fd
> 
> This was pointed out by Stanislav Fomichev during the LPC session.
> I've not yet tried this myself.

Didn't look into it yet.

> Problem #3: Read-only fds can be transmuted into read-write fds via
> object pinning
> 
> 1. BPF_OBJ_PIN(read-only fd, /sys/fs/bpf/foo)
> 2. BPF_OBJ_GET(/sys/fs/bpf/foo) = read-write fd
> 
> The problem is with BPF_OBJ_PIN semantics: regardless of fd->f_mode,
> pinning creates an inode that is owned by the current user, with mode
> o=rw. Even if we made the inode o=r, a user / attacker can still use
> chmod(2) to change it back to o=rw.

Maybe I'm missing something, but I consider pinning more like adding a
new reference to an eBPF object (like the ID).

You are still subject to access control decision by security_bpf_map(),
as for BPF_MAP_GET_FD_BY_ID().

Now, the security model is limited to two permissions (read, write). If
we want to add a new one to decide whether or not a new reference can
be added, we could revisit this.

Roberto

