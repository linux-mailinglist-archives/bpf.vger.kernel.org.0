Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA2D6D9276
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjDFJPp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbjDFJPo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 05:15:44 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB3B55AE;
        Thu,  6 Apr 2023 02:15:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PsbFt4wRyz9v7V0;
        Thu,  6 Apr 2023 17:06:10 +0800 (CST)
Received: from [10.81.221.252] (unknown [10.81.221.252])
        by APP1 (Coremail) with SMTP id LxC2BwBX2AN_jS5k1_z9AQ--.9S2;
        Thu, 06 Apr 2023 10:15:07 +0100 (CET)
Message-ID: <841747d7-ab17-2904-ea1d-6adb3d35c711@huaweicloud.com>
Date:   Thu, 6 Apr 2023 11:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
 <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
 <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
 <5dbb9430-1e26-ec12-26a2-3718c84e33c2@schaufler-ca.com>
 <7549b624-421e-30b9-ca99-de42929354c7@huaweicloud.com>
 <CAHC9VhTsSUM6_g5+ZOqZ=P6307hCAJW+-xEc4fKQcymPs5pYjQ@mail.gmail.com>
 <83ddfcb9-b4a6-71b4-a20c-62f484c8e040@schaufler-ca.com>
 <CAHC9VhTO02CGUt0DUUmx=TUYS7Q81fas_Qy5miOFonaye0NEmw@mail.gmail.com>
 <c3751b2b-aa4b-2105-c238-29816bc85607@schaufler-ca.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <c3751b2b-aa4b-2105-c238-29816bc85607@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBX2AN_jS5k1_z9AQ--.9S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4fAr15Ar47KrW5Aw15CFg_yoWrAF47pr
        y8Ka47KF4DtF1DJrnay3W7W342krZxGr4UWws8Kr4UAF1qqr1xJr1Yyr4YkFn3Xrs7Z3WF
        vr4jqry3urn8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4eqGwABsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/5/2023 11:07 PM, Casey Schaufler wrote:
> On 4/5/2023 1:49 PM, Paul Moore wrote:
>> On Wed, Apr 5, 2023 at 4:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 4/5/2023 12:59 PM, Paul Moore wrote:
>>>> On Wed, Apr 5, 2023 at 5:44 AM Roberto Sassu
>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>> On 4/5/2023 4:08 AM, Casey Schaufler wrote:
>>>>>> On 4/4/2023 11:54 AM, Paul Moore wrote:
>>>>>>> On Fri, Mar 31, 2023 at 8:33 AM Roberto Sassu
>>>>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>> ..
>>>>
>>>>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>>>>> index cfcbb748da2..8392983334b 100644
>>>>>>>> --- a/security/smack/smack_lsm.c
>>>>>>>> +++ b/security/smack/smack_lsm.c
>>>>>>>> @@ -52,6 +52,15 @@
>>>>>>>>    #define SMK_RECEIVING  1
>>>>>>>>    #define SMK_SENDING    2
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * Smack uses multiple xattrs.
>>>>>>>> + * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>>>>>> I think it would be good to move SMACK64EXEC to its own line; it took
>>>>>>> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
>>>>>>> when I only say three comment lines ... ;)
>>>>>>>
>>>>>>>> + * SMACK64MMAP - controls library loading,
>>>>>>>> + * SMACK64TRANSMUTE - label initialization,
>>>>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>>>>> + */
>>>>>>>> +#define SMACK_INODE_INIT_XATTRS 4
>>>>>>> If smack_inode_init_security() only ever populates a single xattr, and
>>>>>>> that is the only current user of SMACK_INODE_INIT_XATTRS, can we make
>>>>>>> this '1' and shrink the xattr allocation a bit?
>>>>>> If the parent directory is marked with SMACK64_TRANSMUTE, the access
>>>>>> rule allowing the access has the "t" mode, and the object being initialized
>>>>>> is a directory, the new inode should get the SMACK64_TRANSMUTE attribute.
>>>>>> The callers of security_inode_init_security() don't seem to care.
>>>>>> I can't say if the evm code is getting SMACK64_TRANSMUTE or, for that
>>>>>> matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older system
>>>>>> allowed for multiple Smack xattrs, but I'm not clear on exactly how.
>>>>> If you like to set an additional xattr, that would be possible now.
>>>>> Since we reserve multiple xattrs, we can call lsm_get_xattr_slot()
>>>>> another time and set SMACK64_TRANSMUTE.
>>>>>
>>>>> I think, if the kernel config has CONFIG_EVM_EXTRA_SMACK_XATTRS set,
>>>>> EVM would protect SMACK64_TRANSMUTE too.
>>>> Ooookay, but can someone explain to me how either the current, or
>>>> patched, smack_inode_init_security() function can return multiple
>>>> xattrs via the security_inode_init_security() LSM hook?
>>> It can't.
>> I didn't think so.
>>
>> To be really specific, that's what we're talking about with this
>> patch: the number of xattrs that smack_inode_init_security() can
>> return to the LSM hook (and EVM, and the caller ...).  If it's only
>> ever going to be one, I think we can adjust the
>> 'SMACK_INODE_INIT_XATTRS' down to '1' and save ourselves some
>> allocation space.
> 
> Does evm have an expectation that mumble_inode_init_security() is
> going to report all the relevant attributes? It has to be getting
> them somehow, which leads me to wonder if we might want to extend
> smack_inode_init_security() to do so. Even if we did, the maximum
> value would be '2', SMACK64 and SMACK64_TRANSMUTE. Now that would
> require a whole lot of work in the calling filesystems, as setting
> the transmute attribute would be moving out of smack_d_instantiate()
> and into the callers. Or something like that.

After changing the inode_init_security hook definition to pass the full 
xattr array, this is not going to be a problem. EVM sees all xattrs that 
are going to be set when an inode is created, and adds its own too.

If you have enough information to set security.SMACK_TRANSMUTE64 in 
smack_inode_init_security(), this patch sets already allows to set both 
xattrs at the same time. We would just need to call lsm_get_xattr_slot() 
another time, assuming that we reserve two xattrs.

Roberto

