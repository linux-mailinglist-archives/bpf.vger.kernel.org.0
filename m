Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECED6D9249
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 11:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjDFJJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 05:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjDFJI4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 05:08:56 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA019D;
        Thu,  6 Apr 2023 02:08:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Psb6J4Y4nz9xFGh;
        Thu,  6 Apr 2023 16:59:36 +0800 (CST)
Received: from [10.81.221.252] (unknown [10.81.221.252])
        by APP1 (Coremail) with SMTP id LxC2BwA3l+L_iy5kl_j9AQ--.11S2;
        Thu, 06 Apr 2023 10:08:30 +0100 (CET)
Message-ID: <4d5b98a2-64a0-2126-08de-64a8c4b46884@huaweicloud.com>
Date:   Thu, 6 Apr 2023 11:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
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
Content-Language: en-US
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <83ddfcb9-b4a6-71b4-a20c-62f484c8e040@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwA3l+L_iy5kl_j9AQ--.11S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48Jr18tw1xCw4UGw45ZFb_yoW5Kw1rpF
        ykKa47tr4DtF1UJr9aya17Wa429rW3GF4UWws8Kr18ZF1qqr1xJr1Ykr4Y9rnxXr4xArna
        qrWqqr9xurn0v37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4eqDwABsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/5/2023 10:43 PM, Casey Schaufler wrote:
> On 4/5/2023 12:59 PM, Paul Moore wrote:
>> On Wed, Apr 5, 2023 at 5:44 AM Roberto Sassu
>> <roberto.sassu@huaweicloud.com> wrote:
>>> On 4/5/2023 4:08 AM, Casey Schaufler wrote:
>>>> On 4/4/2023 11:54 AM, Paul Moore wrote:
>>>>> On Fri, Mar 31, 2023 at 8:33 AM Roberto Sassu
>>>>> <roberto.sassu@huaweicloud.com> wrote:
>> ..
>>
>>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>>> index cfcbb748da2..8392983334b 100644
>>>>>> --- a/security/smack/smack_lsm.c
>>>>>> +++ b/security/smack/smack_lsm.c
>>>>>> @@ -52,6 +52,15 @@
>>>>>>    #define SMK_RECEIVING  1
>>>>>>    #define SMK_SENDING    2
>>>>>>
>>>>>> +/*
>>>>>> + * Smack uses multiple xattrs.
>>>>>> + * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>>>> I think it would be good to move SMACK64EXEC to its own line; it took
>>>>> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
>>>>> when I only say three comment lines ... ;)
>>>>>
>>>>>> + * SMACK64MMAP - controls library loading,
>>>>>> + * SMACK64TRANSMUTE - label initialization,
>>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>>> + */
>>>>>> +#define SMACK_INODE_INIT_XATTRS 4
>>>>> If smack_inode_init_security() only ever populates a single xattr, and
>>>>> that is the only current user of SMACK_INODE_INIT_XATTRS, can we make
>>>>> this '1' and shrink the xattr allocation a bit?
>>>> If the parent directory is marked with SMACK64_TRANSMUTE, the access
>>>> rule allowing the access has the "t" mode, and the object being initialized
>>>> is a directory, the new inode should get the SMACK64_TRANSMUTE attribute.
>>>> The callers of security_inode_init_security() don't seem to care.
>>>> I can't say if the evm code is getting SMACK64_TRANSMUTE or, for that
>>>> matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older system
>>>> allowed for multiple Smack xattrs, but I'm not clear on exactly how.
>>> If you like to set an additional xattr, that would be possible now.
>>> Since we reserve multiple xattrs, we can call lsm_get_xattr_slot()
>>> another time and set SMACK64_TRANSMUTE.
>>>
>>> I think, if the kernel config has CONFIG_EVM_EXTRA_SMACK_XATTRS set,
>>> EVM would protect SMACK64_TRANSMUTE too.
>> Ooookay, but can someone explain to me how either the current, or
>> patched, smack_inode_init_security() function can return multiple
>> xattrs via the security_inode_init_security() LSM hook?
> 
> It can't.
> 
>>    I'm hoping
>> I'm missing something really obvious, but I can only see a single
>> Smack xattr being returned ...
> 
> Smack is setting the transmute attribute in smack_d_instantiate().
> The exec and mmap attributes are always set explicitly.
> 
> I don't know how the "extra" Smack attributes were obtained by evm
> before, and I haven't been looking at how they're doing it now.
> I have assumed that CONFIG_EVM_EXTRA_SMACK_XATTRS does something
> meaningful.

EVM has a list of xattrs to protect. Without 
CONFIG_EVM_EXTRA_SMACK_XATTRS, EVM protects only security.SMACK64. With 
it, also the other Smack xattrs.

EVM calculates the HMAC of xattrs from that list at inode creation time 
(during the execution of security_inode_init_security(), after other 
LSMs) and during set/remove xattrs operations on the VFS.

Currently, Smack provides only security.SMACK64, so I agree with Paul 
that we should reserve as many xattr as we use. If in the future, we add 
security.SMACK_TRANSMUTE64, we can increase the number of reserved 
xattrs to 2.

Roberto

