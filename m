Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38A615D5D
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 09:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKBII7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 04:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBII6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 04:08:58 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F3DA6;
        Wed,  2 Nov 2022 01:08:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4N2KBh70whz9xGY8;
        Wed,  2 Nov 2022 16:03:08 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHpXGIJWJjLiQwAA--.64703S2;
        Wed, 02 Nov 2022 09:08:44 +0100 (CET)
Message-ID: <e45a4736e9fa77acbe48e947f40c023d3cd71922.camel@huaweicloud.com>
Subject: Re: Possible bug or unintended behaviour using bpf_ima_file_hash
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Isaac Matthews <isaac.jmatt@gmail.com>,
        linux-integrity@vger.kernel.org, bpf@vger.kernel.org
Cc:     isaac.matthews@hpe.com
Date:   Wed, 02 Nov 2022 09:08:30 +0100
In-Reply-To: <CAFrssUQKyfZXXXQQA2vPMLR957RZtt7MN9rEG_VbLW_D0wBZ0w@mail.gmail.com>
References: <CAFrssUQKyfZXXXQQA2vPMLR957RZtt7MN9rEG_VbLW_D0wBZ0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAHpXGIJWJjLiQwAA--.64703S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy5tFW8uFyfGFW7tF1UWrg_yoW8ur4Dpr
        W3GF10kFs0kr10kF9F9a1UWFWFk393ZFy5XFWv9ryrAr4DXrWvqrWYga45WrW8KrykKF18
        XF4fW347JF1kKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4DweAABs6
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-10-31 at 16:25 +0000, Isaac Matthews wrote:
> Using bpf_ima_file_hash() from kernel 6.0.
> 
> When using bpf_ima_file_hash() with the lsm.s/file_open hook, a hash
> of the file is only sometimes returned.  This is because the
> FMODE_CAN_READ flag is set after security_file_open() is already
> called, and ima_calc_file_hash() only checks for FMODE_READ not
> FMODE_CAN_READ in order to decide if a new instance needs to be
> opened. Because of this, if a file passes the FMODE_READ check  it
> will fail to be hashed as FMODE_CAN_READ has not yet been set.
> 
> To demonstrate: if the file is opened for write for example, when
> ima_calc_file_hash() is called and the file->f_mode is checked
> against
> FMODE_READ, a new file instance is opened with the correct flags and
> a
> hash is returned. If the file is opened for read, a new file instance
> is not returned in ima_calc_file_hash() as (!(file->f_mode &
> FMODE_READ)) is now false. When __kernel_read() is called as part of
> ima_calc_file_hash_tfm() it will fail on if (!(file->f_mode &
> FMODE_CAN_READ)) and so no hash will be returned by
> bpf_ima_file_hash().
> 
> If possible could someone please advise me as to whether this is
> intended behaviour, and is it possible to either modify the flags
> with
> eBPF or to open a new instance with the correct flags set as IMA does
> currently?

Hi Isaac

I think this is the intended behavior, as IMA is supposed to be called
when the file descriptor is ready to use.

If we need to call ima_file_hash() from lsm.s/file_open, I think it
should not be a problem to create a new fd just for eBPF, in
__ima_inode_hash().

Mimi, what do you think?

Thanks

Roberto

> Alternatively, would a better solution be adding a check for
> FMODE_CAN_READ to ima_calc_file_hash()? I noticed in the comment
> above
> the conditional in ima_calc_file_hash() that the conditional should
> be
> checking whether the file can be read, but only checks the FMODE_READ
> flag which is not the only requirement for __kernel_read() to be able
> to read a file.
> 
> Thanks for your help.
> Isaac

