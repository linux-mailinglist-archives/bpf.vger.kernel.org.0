Return-Path: <bpf+bounces-267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163876FD32B
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 01:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1DE1C20C44
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A0168B2;
	Tue,  9 May 2023 23:56:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7F1990C
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 23:56:33 +0000 (UTC)
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108F4EDD
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683676587; bh=PE4ukglw5R2Z8gir3deVV56GHYBEBRfVnCYXv6R3fHA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rkHS3p2WPel6DcT12+4qY4RumnvYjWeWLjeiolPQI3Z4fJRFBYtV1QT9yKj9Epm3MD4izoT2PbpTP23wxVwZ3pLni8uNXpEB/hk7arh4I0clSV8/iLcWSr104BiS6VtokWcONT4AstxBHJMX25hS29KqGporJZRHYfMeMl9vrv+Uew/bynWR916v35+XZ9BsBoXw4QP1prezJz+PNQF37p4t3IKjXE/s9N/k5Xh90VuHaKN4gzBpCAXz2xcMQhX1yuPibhKQZeSZ1fI0xssnQl2SHmK2zGAXc5rCZgO44YQGF03Y3oDlhb8XR4iXJMGbrTWBMLrtfJB7tVhYfKwxUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683676587; bh=2nRiJwUTinbuXCQ+CO7ooTNbZ1hZmymPyEkL8w9+Jhx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bMq8Fgdhi3UN79uJ313WG+6IOS6+24YNf600TeMGrvap3G3074ZNqreQtDvGbjt20IlbDtsEGWLh7mj0q9HA7WIx/hrUsIdadsaUjCUH+D7yCFDwQRDHrJF3ETypMk2pXHu7NcmmYXAEJgq5hIr6MM6Gv9MGzFM+8LsUlGtQUvByyajY6RJGLSy18gDGBtBOEdwVq8IAW9IcU3erbAa0pUGbPcREhvJkzXS18dspLXV7g+Y+O+/1VrSks1k3RXTLxWcvzeBoxtIITaW4UTUws1+TBT8hQoYv5g/0SI1r47AmUJ4usGy7p4NSSZnz2/PkFzGQ5ZQfotvB8i/Gvp1c5w==
X-YMail-OSG: J0jQIWUVM1mpMp3DFOnSpr8aTsF5EXheJUoHs1x9REHrkRTiejYLgM6HWiG9m1z
 Kou0n8pdi_XlPo_SGEJKaq5PapXv10pB0mTvKlNlqAla1yDi2Avk7L9mc4ORQLNCKfUCLdkCCkfW
 yOFd3Fh2Z6p7YbFksigvfAupQUJ2OiCDweN.A45v.J0fe7bhYGmTotTs4k1x4CZ8g07uWFtwehmV
 .bzdrGkn4zTCy9MJmCx2PnEQ_lt2j66U82ET_W9_ShzqzhT9W2htS2BVbwkX4eb.4wxGOTv9AMae
 s4yq_8eOUcW4zd08GdileF6F06_5dV1m8N6cfDhIQJy.ONKebK_hq_K4Xf59LhRZK3_yMwysNwUt
 P0FBkeGsOe8T1MGRiarBTaiU2pqDuDSoBWoF5LV5QuB.DwWofduDVRDDnMHm3RxnR3T5KQ07nSnQ
 Nqjpleq1yLuJasZcgjiP_ESzN81AD4SwL1e5lHdauNlicXAV5MxYF.wLgCK.gGl3cHObPCW3C8fO
 3p8jbUpuZODFwQevmfggjlL76zOXhtjpb.q9Vrk.Y5T97_2rI3f1ZxHN5d2DaVbW8hcWo6CNfDhM
 SgIFu57R5M99DIqU1rKVvOElpnPWRytyBcOaftxlwFZk.c6kAWtnq.P.zT3vY5uDirxSnB_Qr7zp
 c6.snuGG28_lyzhjvmvvdVlxgoFwCOo0ADkW33Z5IFRWGsX25lWtLT4xoP_4l0FGKn9D08aUIdJa
 4_otMdB2mhSUpQroucESPpt0MCStR8HGyksO8iiMj6Ji5LHfL5u.IPyHzbmtq9jMrSsuJbFFnDK7
 3cB3SOSxGoKrZS2y8_NUuUdgeZWKW5FeaqLOGj.B9fV5RZb3PxEjKc7phm19HydHU9yRKO5wdoMR
 i9tcLCb.lrVwUTksywbu5Zst8hfmtTO_3ojo_AI2twHxXH9PIgyGIXPStj4VUzS.MvC07dsFKe4k
 Hj7nO3ZSOeV8sVv8CQpfx8yQ3pNwlcfYFhTftV.g3IFoorfaMeVHotvO87wcFjCtB6Xwlfui5coU
 I8TQDJe0loYhalM2lz8MfEu0Ua9EFivUtcvoNUef_d.mvOaBdwcg46SuTrt_Q180vXWSTWbdhySJ
 4qutaS2_Z3qpRvo2YwPXCGsD2at4CxCs7Ii96Ape4lOGVqGwVH7LejymI26Mi8NxzqXYfF_qXZOB
 3ASqkg0B3z8b83oPssxRDeyISlDi1frMtHcVXPemL1WpodhdTXeox2NjkMcwctLcIHe5LfSP0YVf
 us_RJGKzJwJKOqjIjLOxFcPgTIFjKvwkGvrrfTOOBKaK4Sv.gD.05zz7A8obMCK0.2zaNj7HSU8R
 p.DAtKOMSYfyti3GfZlN1l8iQIVlTrYKeZ68zmmz9F966TRJhNt1s4Kx8Tblg2Q7sSmaCeqO9FMJ
 RXS66c.aiC7OCzhY8E_.4PxBieytr7AIgigTt4LZYVtUMqtohCW_G22_Cz19uiW97EyVNWfyxwiC
 PvTQL0xcSBXaJVCBFFCxKwivFH7l.t07oihy1neu86PAtN7YBKy96eWqYn.rPC8paSKDpTtAgzPd
 KSWNAE0AgKNXxeV5JxSG2dTJEU4QtMcCOjl4TthhOoeuMS9G6ZgtgNoBdW1V5efs0mV2HSt7rI.V
 9DzIAHgdKxocBai.xnHgX_hxOXHgt0phiGAM0LszUGSQrTTfubnwE3Ph8cP2pbNVV_KceBVxHeWB
 31NGxaBHjGSh87wJWqSkQv6IwIEV.cJfBnhRp8DZrhL0YZctqjlmZ6cyEMN4GhLDLHbhUpUMcQp_
 ck.MJhqD8_hUYKR1AuOsFXZlKJsoNFn3PBE0XBJ0r21a5yC6O5iBQ7gdCGAjK6nbdFQfboWhlmw8
 XhEBBdvIq.2pBcaZGZFMC8O8heun4cXwkx6iHtmqEWu7tMJ1G5tBtd1cjJhn4QVNKYfqjkNTswHL
 ge4dgaqFGGs5LST2KDgBx1ASd9FpeChAb8W3g3WYBhMPJ.RcR_cK6ejXdLODWDDUiBfRyQ3qVDmD
 hAgkR1mLFpNAJJRrF9DJ7CrX4Wkq30HW5RjO7S9la_TvzIHcD5bIIhXkm_nmqVaXnsXEjU8b.Efn
 k_AJeRp78ElZd84.GTCGD1ifsEfa8q5MsSE9Lp2_b8SyHMT7tlNTdLU39uY15R544KFKqFS4DQ_z
 jIM6nS75r3JrE3wRyWeDrJDLtHyVkCwSg8g9.dxYxBf7FssQ.saoG2PmTfxLzOYchbFra.Mle9eI
 qhAkveJbLqLGTyyyxmVoaQiSZFQaUr9ZK32KovtAzgGFPnhMeID_6xD71yC6Izh9g
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 94f3610d-01e1-4368-8bd4-d8177de95430
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 May 2023 23:56:27 +0000
Received: by hermes--production-bf1-5f9df5c5c4-dxcv9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5dfc5eb642c7e6cd8f0e65490552cae4;
          Tue, 09 May 2023 23:56:22 +0000 (UTC)
Message-ID: <d193ea1d-71f1-fed6-a96a-24f51bd38649@schaufler-ca.com>
Date: Tue, 9 May 2023 16:56:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
Content-Language: en-US
To: Mengchi Cheng <mengcc@amazon.com>, roberto.sassu@huaweicloud.com
Cc: bpf@vger.kernel.org, dmitry.kasatkin@gmail.com, eparis@parisplace.org,
 jmorris@namei.org, kamatam@amazon.com, keescook@chromium.org,
 kpsingh@kernel.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
 nicolas.bouchinet@clip-os.org, paul@paul-moore.com,
 reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
 selinux@vger.kernel.org, serge@hallyn.com, stephen.smalley.work@gmail.com,
 yoonjaeh@amazon.com, zohar@linux.ibm.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <2d0abd075d6c67e72e3fb88a4c163fb0dd28f72e.camel@huaweicloud.com>
 <20230509234412.3073389-1-mengcc@amazon.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230509234412.3073389-1-mengcc@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/9/2023 4:44 PM, Mengchi Cheng wrote:
> On Mon, 2023-05-08 12:29:42 +0000, Roberto Sassu wrote:
>> On Thu, 2023-04-20 at 10:48 +0200, Roberto Sassu wrote:
>>> On Wed, 2023-04-19 at 12:25 -0700, Mengchi Cheng wrote:
>>>>> I got some errors during xattr removal, so not sure if my patch was
>>>>> working properly or not (it happened also without it, didn't
>>>>> investigate more).
>>>>>
>>>>> However, I saw another discussion related to transmute:
>>>>>
>>>>> https://lore.kernel.org/linux-security-module/20230419002338.566487-1-mengcc@amazon.com/
>>>>>
>>>>> I add the people in CC.
>>>>>
>>>>> The steps described were so easy to understand and executed, I tried
>>>>> without and with overlayfs.
>>>>>
>>>>> Without:
>>>>>
>>>>> # echo "_ system rwxatl" > /sys/fs/smackfs/load2
>>>>> # mkdir /data
>>>>> # chsmack -a "system" /data
>>>>> # chsmack -t /data
>>>>> # mkdir -p /data/dir1/dir2
>>>>> # chsmack /data/dir1
>>>>> /data/dir1 access="system" transmute="TRUE"
>>>>> # chsmack /data/dir1/dir2
>>>>> /data/dir1/dir2 access="system" transmute="TRUE"
>>>>>
>>>>> It seems to work, right?
>>>>>
>>>>> With overlay fs it didn't work, same result as the one Mengchi
>>>>> reported. Since Mengchi's solution was to set SMK_INODE_CHANGED, and I
>>>>> want to get rid of it, I thought to investigate more.
>>>>>
>>>>> Looking at smack_dentry_create_files_as(), I see that the label of the
>>>>> process is overwritten with the label of the transmuting directory.
>>>>>
>>>>> That causes smack_inode_init_security() to lookup the transmuting rule
>>>>> on the overridden credential, and not on the original one.
>>>>>
>>>>> In the example above, it means that, when overlayfs is creating the new
>>>>> inode, the label of the process is system, not _. So no transmute
>>>>> permission, and also the xattr will not be added, as observed by
>>>>> Mengchi.
>>>>>
>>>>> Hopefully I undertood the code, so in this particular case we would not
>>>>> need to override the label of the process in smack_dentry_create_files_
>>>>> as().
>>>>>
>>>>> If you see smack_inode_init_security():
>>>>>
>>>>> 	struct smack_known *skp = smk_of_current();
>>>>> 	struct smack_known *isp = smk_of_inode(inode);
>>>>> 	struct smack_known *dsp = smk_of_inode(dir);
>>>>>
>>>>> [...]
>>>>>
>>>>> 		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>>>>> 		    smk_inode_transmutable(dir)) {
>>>>> 			isp = dsp;
>>>>> [...]
>>>>>
>>>>> 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>>>>>
>>>>> This code is telling, if there is a transmute rule, and the directory
>>>>> is transmuting, set the label of the new inode to the label of the
>>>>> directory. That should be already the result that we wanted to obtain.
>>>>>
>>>>> The current code should have been doing it by overriding the label of
>>>>> the process in smack_dentry_create_files_as() with the label of the
>>>>> parent directory, and letting the inode being created with the
>>>>> overridden label of the process. The transmute xattr is not set due to
>>>>> the problem described above.
>>>>>
>>>>> So, as a quick test, I kept this patch with the change to xattr2->name, 
>>>>> and skipped the label override in smack_dentry_create_files_as(). It
>>>>> worked, I get the same result as without overlayfs. Wondering if the
>>>>> process label override is necessary in other cases.
>>>> If I understand correctly, removing the if block below is what you suggested.
>>> Yes, more or less is what I did.
>>>
>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>> index cfcbb748da25..a867288e9de9 100644
>>>> --- a/security/smack/smack_lsm.c
>>>> +++ b/security/smack/smack_lsm.c
>>>> @@ -4769,8 +4769,8 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
>>>>                  * providing access is transmuting use the containing
>>>>                  * directory label instead of the process label.
>>>>                  */
>>>> -               if (may > 0 && (may & MAY_TRANSMUTE))
>>>> -                       ntsp->smk_task = isp->smk_inode;
>>>> +//             if (may > 0 && (may & MAY_TRANSMUTE))
>>>> +//                     ntsp->smk_task = isp->smk_inode;
>>>>         }
>>>>         return 0;
>>>>  }
>>>>
>>>> This way will have issue in the following situation on the vanila kernel.
>>>> data in the lowerdir has "_" label before overlay and dir1 is already
>>>> created in the lowerdir.
>>>> # chsmack /data
>>>> /data access="_"
>>>> # chsmack /data/dir1
>>>> /data/dir1 access="system" transmute="TRUE"
>>>> Apply overlay on data directory and set the smack rule in the same way.
>>>> data has the same smack label.
>>>> # chsmack /data
>>>> /data access="system" transmute="TRUE"
>>> I'm using an older kernel, but I get _ instead of system.
>>>
>>>> After that, remove dir1 and mkdir dir1 again. dir1 did not get the correct
>>>> label.
>>>> # rm -r /data/dir1
>>>> # mkdir -p /data/dir1
>>>> # chsmack /data/dir1
>>>> /data/dir1 access="_"
>>> Unfortunately, it cannot work:
>>>
>>> Thread 3 hit Breakpoint 1, smack_inode_init_security (...) at security/smack/smack_lsm.c:959
>>> 959	{
>>> (gdb) p dir->i_ino
>>> $12 = 9169116
>>> (gdb) p dsp
>>> $13 = (struct smack_known *) 0xffffffff831fc0a0 <smack_known_floor>
>>>
>>>
>>> ls -i /home/root/data_work/
>>> 9169116 work
>>>
>>> So, transmuting is decided on the working directory.
>> Actually, after studying the code better, this is
>> what security_dentry_create_files_as() is useful for.
>>
>>  * Compute a context for a dentry as the inode is not yet available and set
>>  * that context in passed in creds so that new files are created using that
>>  * context. Context is calculated using the passed in creds and not the creds
>>  * of the caller.
>>
>> And Smack is doing:
>>
>> 		if (may > 0 && (may & MAY_TRANSMUTE)) {
>> 			ntsp->smk_task = isp->smk_inode;
>>
>> The new inode will be created with the label of the current task, that
>> was replaced with the label of the parent directory (see above) in smac
>> k_dentry_create_files_as().
>>
>> I think the reason why Mengchi was not obtaining the desired label when
>> replacing /data/dir1 was because /data is incorrectly labeled.
>>
>> To ensure that /data has label 'system' and transmute is true, I added
>> smackfstransmute=system to the mount options.
>>
>> However, at the beginning, it seemed that it didn't work:
>>
>> # mount -t overlay overlay -o lowerdir=/data,upperdir=/home/root/data,workdir=/home/root/data_work,smackfstransmute=system /data
>> # chsmack /data
>> /data access="system"
>>
>> I found that the reason for this is that smack_inode_getsecurity()
>> retrieves metadata from the inode only for SMACK64, and the rest from
>> xattrs (which would not work for mount options). I just made a patch to
>> handle SMACK64TRANSMUTE too.
>>
>> With the patch applied, I correctly get:
>>
>> # mount -t overlay overlay -o lowerdir=/data,upperdir=/home/root/data,workdir=/home/root/data_work,smackfstransmute=system /data
>> # chsmack /data
>> /data access="system" transmute="TRUE"
>>
>> With the root inode correctly labeled, I get:
>>
>> # mount -t overlay overlay -o lowerdir=/data,upperdir=/home/root/data,workdir=/home/root/data_work,smackfstransmute=system /data
>> # rm -Rf /data/dir1
>> # mkdir /data/dir1
>> # chsmack /data/dir1
>> /data/dir1 access="system"
>>
>> This is partially correct, transmute="TRUE" is missing.
>>
>> Judging from smk_task, we cannot determine in smack_inode_init_security
>> () if transmuting was successful in smack_dentry_create_files_as(). We
>> need an extra information.
>>
>> Mengchi's solution was to add the new inode as parameter
>> to security_dentry_create_files_as(), so that SMK_INODE_CHANGED can be
>> set in smk_flags, and SMACK64TRANSMUTE is set in smack_d_instantiate().
>>
>> One concern could be that preallocating the inode maybe is overlayfs-
>> specific? A comment also says that we might not use that one:
> security_dentry_create_files_as() is only referred in the fs/overlayfs/dir.c.
> inode is for sure preallocated in this case.
> I am glad you find a way without modifying security api. I did some tests
> with your patch on our system. It works as expected. I am ok to drop mine.

Excellent. Thank you for verifying the patches. I have a few tests of my
own to complete, but I expect to move it into next shortly.

>
> Best,
> Mengchi
>
>> 	err = ovl_create_or_link(dentry, inode, &attr, false);
>> 	/* Did we end up using the preallocated inode? */
>> 	if (inode != d_inode(dentry))
>>
>> We could achieve the same goal without adding a new parameter to security_dentry_create_files_as() and, instead, by adding a new field
>> in the task_smack structure, smk_transmuted, that is set to smk_task
>> when transmuting is successful.
>>
>> Then, if smk_task == smk_transmuted, smack_inode_init_security() would
>> set SMK_INODE_CHANGED. On top of that, I would instead just provide the
>> second xattr SMACK64TRANSMUTE, in addition to SMACK64.
>>
>> Will send the patches for upstream first, and then switch to providing 
>> SMACK64TRANSMUTE in smack_inode_init_security(), in a new version of
>> the EVM patch set.
>>
>> Thanks
>>
>> Roberto
>>
>>> If I do:
>>>
>>> # chsmack -a system -t /home/root/data_work/work/
>>> # mkdir /data/dir1
>>> # chsmack /data/dir1
>>> /data/dir1 access="system" transmute="TRUE"
>>>
>>> I obtain the expected result. However, this problem is due to how overlayfs works:
>>>
>>> static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
>>> 				    struct ovl_cattr *cattr)
>>> {
>>>
>>> [...]
>>>
>>> 	newdentry = ovl_create_temp(ofs, workdir, cattr);
>>> 	err = PTR_ERR(newdentry);
>>> 	if (IS_ERR(newdentry))
>>> 		goto out_dput;
>>>
>>>
>>> The good news seems to be that, once you set the label to the correct
>>> directory, transmuting works with the changes I proposed.
>>>
>>> Roberto
>>>
>>>> Since I am not very familiar your change. Could you help check with your
>>>> patch will this issue also happen? 
>>>>
>>>>
>>>> Best,
>>>> Mengchi
>>>>
>>>>>  
>>>>> Roberto
>>

