Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31F616326
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKBMzW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 08:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiKBMzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 08:55:20 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974F9286C2;
        Wed,  2 Nov 2022 05:55:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4N2RXF2Rx5z9v7gQ;
        Wed,  2 Nov 2022 20:48:45 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXC_ipaGJjheAwAA--.42563S2;
        Wed, 02 Nov 2022 13:55:10 +0100 (CET)
Message-ID: <72e37c82754171c47415a4849ea7a1188eb718ee.camel@huaweicloud.com>
Subject: Re: Possible bug or unintended behaviour using bpf_ima_file_hash
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Isaac Matthews <isaac.jmatt@gmail.com>,
        linux-integrity@vger.kernel.org, bpf@vger.kernel.org
Cc:     isaac.matthews@hpe.com
Date:   Wed, 02 Nov 2022 13:55:02 +0100
In-Reply-To: <135f442b44af0ac2bcd239c1f11c18c740f6e641.camel@linux.ibm.com>
References: <CAFrssUQKyfZXXXQQA2vPMLR957RZtt7MN9rEG_VbLW_D0wBZ0w@mail.gmail.com>
         <e45a4736e9fa77acbe48e947f40c023d3cd71922.camel@huaweicloud.com>
         <135f442b44af0ac2bcd239c1f11c18c740f6e641.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXC_ipaGJjheAwAA--.42563S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43tF15AFW8try7KF4fAFb_yoW5WFWrpr
        WfG3WUKF4DGr10krnFv3WDXFWrK393WFy7XFyvgryrAr1qqryvqrW2gayY9FWkKrykK3WI
        qF4xG347Zryvya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4D2QQAAsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-11-02 at 07:55 -0400, Mimi Zohar wrote:
> On Wed, 2022-11-02 at 09:08 +0100, Roberto Sassu wrote:
> > On Mon, 2022-10-31 at 16:25 +0000, Isaac Matthews wrote:
> > > Using bpf_ima_file_hash() from kernel 6.0.
> > > 
> > > When using bpf_ima_file_hash() with the lsm.s/file_open hook, a
> > > hash
> > > of the file is only sometimes returned.  This is because the
> > > FMODE_CAN_READ flag is set after security_file_open() is already
> > > called, and ima_calc_file_hash() only checks for FMODE_READ not
> > > FMODE_CAN_READ in order to decide if a new instance needs to be
> > > opened. Because of this, if a file passes the FMODE_READ
> > > check  it
> > > will fail to be hashed as FMODE_CAN_READ has not yet been set.
> > > 
> > > To demonstrate: if the file is opened for write for example, when
> > > ima_calc_file_hash() is called and the file->f_mode is checked
> > > against
> > > FMODE_READ, a new file instance is opened with the correct flags
> > > and
> > > a
> > > hash is returned. If the file is opened for read, a new file
> > > instance
> > > is not returned in ima_calc_file_hash() as (!(file->f_mode &
> > > FMODE_READ)) is now false. When __kernel_read() is called as part
> > > of
> > > ima_calc_file_hash_tfm() it will fail on if (!(file->f_mode &
> > > FMODE_CAN_READ)) and so no hash will be returned by
> > > bpf_ima_file_hash().
> > > 
> > > If possible could someone please advise me as to whether this is
> > > intended behaviour, and is it possible to either modify the flags
> > > with
> > > eBPF or to open a new instance with the correct flags set as IMA
> > > does
> > > currently?
> > 
> > Hi Isaac
> > 
> > I think this is the intended behavior, as IMA is supposed to be
> > called
> > when the file descriptor is ready to use.
> > 
> > If we need to call ima_file_hash() from lsm.s/file_open, I think it
> > should not be a problem to create a new fd just for eBPF, in
> > __ima_inode_hash().
> > 
> > Mimi, what do you think?
> 
> Who/what is checking that this is a regular file and we have
> permission
> to open the file?  Are we relying on eBPF to do this?  Will opening a
> file circumvent all of the LSM checks?

Opening the file again will cause another permission request to be sent
to LSMs, and thus to the eBPF program implementing lsm.s/file_open.
Maybe it is not a good idea to use this hook.

In the future, if IMA/EVM stacking is successful, we might introduce
the file_post_open hook, which I believe could be suitable for calling 
bpf_ima_file_hash().

Roberto

> > > Alternatively, would a better solution be adding a check for
> > > FMODE_CAN_READ to ima_calc_file_hash()? I noticed in the comment
> > > above
> > > the conditional in ima_calc_file_hash() that the conditional
> > > should
> > > be
> > > checking whether the file can be read, but only checks the
> > > FMODE_READ
> > > flag which is not the only requirement for __kernel_read() to be
> > > able
> > > to read a file.
> > > 
> > > Thanks for your help.
> > > Isaac

