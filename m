Return-Path: <bpf+bounces-17039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D1480920D
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1C1281AA5
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23AA4F8B9;
	Thu,  7 Dec 2023 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jDs5idTg"
X-Original-To: bpf@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE421710
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701979554; bh=2vIBjQ6c5xsdyPwgowuEmLGRFGRA+K0326reMW6mRSg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jDs5idTg0CkqtlzpAAvAKczdDjH0VotayNrM6tuJpS3h0nerPZkAKbmIG02pKc9alzdSzQGtymoXBJehI/NDQp8//ZWjzVKqGOmyW5U3UPBg86U6E41N5kzIat2F6xJ2lRjZAZfwFaTdQzOqHK8H9rjDzcbuhnYNBz1rRrwd6UZZdB+VSu4sxZA9ttQDRvaT2cKLRUojhyw+VN5cE90oOvgXrTzGMvKslpCDB6laGsQTR0r5CXj3XmoUJnWcF+NNrbnNWGpKxXboD5lPlTSgVHxjKbJ3Ja+vgch4OnkwT4c2vSzZjIsH4IXqLrGSIXtD6R84qin90zCvqVVX4GCo3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701979554; bh=AaIex4BnQUSuiJI+ZBs79PKFWlwVLgV75XKrnBqFnAh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tNKa3WdlJpuJdN41g/hH38rtEnO9pDYxcs5aTiE3iCdrpAJpd9lisKXT5r3Q8DsW3UYMe8/zWwLSYyBbZArzbNJAHhpHgHsIYOwkZ0rM336iigmcJIclT/s0KMkZozSFkk/ULl0N8UGbQ3WUa55vTR76/8s1T4bT+FyVhTcEpG+PwpffE+xVgJCE6M3lJPGh8jlHNqPLNhCHzSA53kPmPZMfyVqQnq9PP20XPAlOWDRcPXu66GXwg4qPp/hzFXJWTBazHtb4cLn9rsECgE+vuZ6Bv9WGbJdklZdcWnsXGusvM+Xs3KrnqdjDJ9TMiZ4H5fy0pdg0i4Votqf11DzNdA==
X-YMail-OSG: jc9L4kQVM1laSGIcjZxC5H7Ko6HUymRcgejmpGnjGFhuo69N1kUE9NyxclbJvuy
 w1RTniCilEOBLmaCkirjFBQjOlSIZu_w1HYJMSvHA3mgZ.Ey6hXqKsGAn2ZdTAxC9wEfQsfuO6GR
 7omtg3aISk9fdozLUCN8YiaDIlqMgDnjBV1DwyeIqCktTqhVyE6iro6CJ82RtaLdyM0WyxKPTRVX
 b3va7qWJgbt8aqmBpTrMDubP0GHsX41qYc06.vAsrRGPqRgLwoGbxcPGdNJxPg4phlv1bYlBxUE_
 GxFiHgyH3Og79aS9oZQ6RWad.kApDeNKUpiu5WsF1UQ4OLz9rL..72wCKKPGwLvzpqHlMjq5372i
 4mQUUqoy2XwmbWs5Hk4bNNZq9ykB30skW.9mOcioSkuG9gXqSHrldw8A9cjCzugR7Su4U_NNm1fv
 bO02nUfPu4BOgRvNyhSvER1VsuB7GcSIgAXvGiJUEhKeWshL9z25i.0MFul2MpBW2nX5oAEs61qR
 rH.3QqXprNbodzk4GtD.LFQ_Of7KexjkaMzMYdlKhYrwRbPQlgapDOE4GBIiWOw2kFvAr07HmciM
 w7Xsj0oMb3RcOj28FJQwujH9dG3bxgTBBRZ.BMNcS1ItHebHO04eNphLJMiwY2lNo4xH9QXuEI1I
 sHaT_VRVoiW9wV.S.jMhqkryuOKyCQ93cXxUbOnf_10dFc5WOPNtL0vyKd23ihMF2gYUJ2aN2GF9
 DGW7KQlSLBCKZDALTYI6wQCL1GYfsrD.BnqKMmmQ2Tx0USxDiVbL.xdslk1vpiy0Jg56Dc33UtEA
 ShyLXVL1nZcMurneBhNCDVUuYvlw6IcqXa4zXMxpG1URYg_Xfi0XnHIRnKNWeAWhy8CyDNw.Rigq
 9qN_HG_PkW_64XALV3Mr2v8mOK4wR1Pea2RvsS.64tlQdUkn4bEXxP8RgX6bWEc9RDueq0oSJOVd
 tMiMkAzb1uCFc08nWwt_ys6psRJVtES77Ab3NNYPSPO9oaKqC7dVTv1132LlWGN5ia9BHZSXrsP4
 vO7AjtOV2.B.AxOHlhZXv8N7jjdMugigAgsH6B0agDneqUfM_xG4Cd7dSyXxwN1uYQbtFgP44UQV
 ilIFgmCoal1wvNXkes0sdQLCq9vJNw_VElcdLcqMbIrV6F.rHlX.ssXWJc4lX2S_HCpzN8As8T83
 ypj6MuMoX4fbqnpeSedVCl9P9tDFa2jgGqAFLl.OTMppDVPjQImvLEBCTnCUKOXr5PTbZziCdZX6
 .FNV158SpF2P4E8t8rMahs7O3H9sPaGzApnxz6ouQ_IUFMm1yIwzU60agRdu51Gyogh88S4zHVLc
 msIO9_z_rDqg563ImhKD7hVHvzgO2PDt7KnKBY1RA3OXMYCNmq7GYDkFQAYtjstwi7tjTukCeg7f
 G1qjW.MfarSVyRL7k1hf4.OOc2UQfumksV4B6Dq96SZK3Gr8LPbM3iejdWMZ46Teqb6Xls5PXgOI
 rkYZWBVyGVXHsaUaeR7ec0wbxDuSKjiGSnuWMbVXKWxcns0tdw.gdxhXMBQ2seCr5NDUatvSPOmI
 z9bih_ov5kZM_RnsZ3MA8SOLk7FYRrwljuP2KIn5dD1aQGdrpvTMw46in3rp.D3m4a1rul1nCysb
 YiiEEB8h0zEJkpPg6gk00tViQ3iA3wBbxX61b4OMQ305_HaZZuoT2_4b44o5MdpoxlWDTixQ_u32
 L0q3TTLziP9FOSEbeRbEXDQP3IfK3I1cRpltRGssPNX78AM0SkBZVa6u89vHnq3xYUv0FXVxvzVn
 iOSXR5ZjT63DxKT3dNCERP3.8P4kBsqusRqidnachubgZP3F9D3yZQxoLAW7Z.KpTRbkBAs3GRVk
 hsvhSX_rbRrzrqpuRtAze2wV4YJxWoKyIprMtoRxXaQLS7cf5K4CiE1K3r_fAFeygChraLaEX7f4
 DbPswoJYTvwJHk4EOqR.H3TPp6bpemcAzy0nr70..ed0mYgsX2WGT0Hm3mE7al4Cid8lTtAoM1np
 Il6wsR70AGkj4mPp4DUvagwXJgqsh7oS_.3e5CZK1RXaUoi.jP2Mq.vxy2R9qUcbP0vYH8TjqX_d
 vJvYaTdDPxExQooTp.LsU0ysG7n_akqaUQXjVFVTDFfDOPVGvYxMwyrlwnEgoIujfqaue4vxrzln
 umVlOsIIh2q3o5CE9aXaVqNdYdxzqVhuBdCW..4bt0cYWegnMShIaaJGeacuAW7it9igTyPAWndp
 HNV7q5d9UN3eIfTnSbbcylNUs0PCqyV1W0hQzVfnXPj6FWKkR.BKKInhdGtzjpaeOnXiUweCjv3.
 5lw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 12d689c9-e4b5-498b-925f-5c4ace69434b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Dec 2023 20:05:54 +0000
Received: by hermes--production-gq1-64499dfdcc-n9q5p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 086ad280866278b9c0561f092de55781;
          Thu, 07 Dec 2023 20:05:52 +0000 (UTC)
Message-ID: <e01701ef-99c4-4b51-a8b6-6d9ad4d4c5a9@schaufler-ca.com>
Date: Thu, 7 Dec 2023 12:05:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPF LSM prevent program unload
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Yafang Shao <laoar.shao@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, jmorris@namei.org,
 "Serge E. Hallyn" <serge@hallyn.com>, kpsingh@kernel.org,
 revest@chromium.org, jackmanb@chromium.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <ZW+KYViDT3HWtKI1@CMGLRV3>
 <CALOAHbANu2tq73bBRrGBAGq9ioTixqKgzpMyOPS3NMPXMg+pwA@mail.gmail.com>
 <ZXCNC8nJZryEy+VR@CMGLRV3>
 <CALOAHbAfixyvA5HpOXgqS32G-5p4Z=OXRso7_isz2fNKk76mmg@mail.gmail.com>
 <CAHC9VhSRdXLeJvS3tOmAAat+h8G7_cvAYnFvbrTwgG+sC+PRYg@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSRdXLeJvS3tOmAAat+h8G7_cvAYnFvbrTwgG+sC+PRYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/7/2023 9:34 AM, Paul Moore wrote:
> On Wed, Dec 6, 2023 at 9:28 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>> On Wed, Dec 6, 2023 at 11:02 PM Frederick Lawler <fred@cloudflare.com> wrote:
>>> On Wed, Dec 06, 2023 at 10:42:50AM +0800, Yafang Shao wrote:
>>>> On Wed, Dec 6, 2023 at 4:39 AM Frederick Lawler wrote:
>>>>> Hi,
>>>>>
>>>>> IIUC, LSMs are supposed to give us the ability to design policy around
>>>>> unprivileged users and in addition to privileged users. As we expand
>>>>> our usage of BPF LSM's, there are cases where we want to restrict
>>>>> privileged users from unloading our progs. For instance, any privileged
>>>>> user that wants to remove restrictions we've placed on privileged users.
>>>>>
>>>>> We currently have a loader application doesn't leverage BPF skeletons. We
>>>>> instead load BPF object files, and then pin the progs to a mount point that
>>>>> is a bpf filesystem. On next run, if we have new policies, load in new
>>>>> policies, and finally unload the old.
>>>>>
>>>>> Here are some conditions a privileged user may unload programs:
>>>>>
>>>>>         umount /sys/fs/bpf
>>>>>         rm -rf /sys/fs/bpf/lsm
>>>>>         rm /sys/fs/bpf/lsm/some_prog
>>>>>         unlink /sys/fs/bpf/lsm/some_prog
>>>>>
>>>>> This works because once we remove the last reference, the programs and
>>>>> pinned maps are cleaned up.
>>>>>
>>>>> Moving individual pins or moving the mount entirely with mount --move
>>>>> do not perform any clean up operations. Lastly, bpftool doesn't currently
>>>>> have the ability to unload LSM's AFAIK.
> If you haven't already, I would suggest talking with KP Singh as he is
> the BPF LSM maintainer; I see him on the To/CC line so I'm sure he'll
> comment when he has the chance to do so.
>
>>>>> The few ideas I have floating around are:
>>>>>
>>>>> 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the functions
>>>>>    security_sb_umount(), security_path_unlink(), security_inode_unlink().
>>>>>
>>>>>    Both security_path_unlink() and security_inode_unlink() handle the
>>>>>    unlink/remove case, but not the umount case.
> I'm not a BPF expert, but this seems like the most obvious solution,
> although as Tetsuo already mentioned you probably don't want to block
> all unmount operations as that would be bad for obvious reasons.  I'm
> guessing that a BPF LSM would have access to things like the current
> task credentials and enough of the mounted filesystem's state (BPF
> prog pinning?) to make a reasonable decision about granting or denying
> the umount operation request.
>
>>>>> 3. Leverage SELinux/Apparmor to possibly handle these cases.
> SELinux has support for restricting unmount operations as well BPF
> program loading.  I see that AppArmor also has controls around
> unmount, but I am less familiar with how that works.  It is also worth
> mentioning that Tomoyo and Landlock provide unmount hook
> implementations although both LSMs are fairly unique so I can't say if
> they would be a good fit for your proposed use case.
>
>>>>> 4. Introduce a security_bpf_prog_unload() to target hopefully the
>>>>>    umount and unlink cases at the same time.
> At first glance that seems reasonable, but I guess we would need to
> see it discussed a bit before I could promise to commit to that.
>
> As a FYI, we have some documented guidelines on creating new LSM
> hooks; it's worth a quick read if you haven't seen it already.
>
> https://github.com/LinuxSecurityModule/kernel?tab=readme-ov-file#new-lsm-hook-guidelines
>
>>>> All the above programs can also be removed by privileged users.
>>>>
>>> I should probably clarify the "BPF or otherwise" a bit better. Even a
>>> compiled in LSM module? If so, where can I find a bit more information
>>> about that?
> I'm not quite sure what you are asking about here, but we don't
> currently support "unloading" built-in LSM modules and I don't see us
> changing that anytime soon.  The closest one could get would be with a
> LSM that supports runtime configuration of its security policy; one
> could go from a restrictive or an allow-all, permissive policy
> effectively disabling the LSM from an access control standpoint.
>
> I don't want to speak for all the LSMs here, but at least SELinux has
> the ability to restrict policy loading so that one could prevent
> replacing a relatively strict policy with a more permissive policy.
> Although it is worth noting that enabling this restriction has a
> number of caveats, i.e. policy updates require a reboot, and isn't
> something I would recommend for a general purpose system.

You can prevent Smack from making policy changes using the "onlycap"
mechanism. It restricts what process labels can use CAP_MAC_ADMIN,
which is required to update Smack rules. As with SELinux, it isn't
recommended for general use.



