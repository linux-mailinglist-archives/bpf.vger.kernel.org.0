Return-Path: <bpf+bounces-45399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52D9D5258
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E338FB2758E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC331AA1D4;
	Thu, 21 Nov 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UacUysrG"
X-Original-To: bpf@vger.kernel.org
Received: from sonic313-22.consmr.mail.bf2.yahoo.com (sonic313-22.consmr.mail.bf2.yahoo.com [74.6.133.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FA188717
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212485; cv=none; b=u709ivJhbbFGKXQS53QWsKG0zDVYpWYgUg9SZv3d8SjweLqXvyJA5MhFcm+deR7ycoka8ZNTA28AfQWJhdsJq86ZiqS3w6KhbtGPpZo9B4PAQ7Yg8ozepSzOQ+00KvRedZ9pnz4ncg26AIqPCV9P85OhCwtg8OlHSMmnC7U/gvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212485; c=relaxed/simple;
	bh=1nJPrORecUy9aErlkXc7diFWNOLRy4mY85TL66J12KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPgq2sSiNfuSQn9lM29uPUECaanoKXtCIcekd+7sdUgHzPChYzQbI05O550Bgw6Az4TynMNNeXaUnxy3iYYOkrUUt6ymxwQq4oHCuMD2ivxuOEvq8zZHWLclm7jW+sIId8ruDczTw6orPmPm0l0Wn0G1pr68E3EF7QbYWBY5UYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UacUysrG; arc=none smtp.client-ip=74.6.133.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732212483; bh=EdrPSyL442ItgVmRGJmr9cZU2LuODB87mu487HPxUuk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UacUysrGQ8fQF7snFNR2+gzUcNdhknDujA19v4fyQAybSWAjHx51lMhmIF0JBkX1RPBO4eUmVZTezkwOPp1itFD2h2OthhJlXzP+rK0xR29EDhhVtwbFXwdSlidThuSY7+5RO0O6gXSL6jEPRTnVDhASWyXtxrlDwxhUyzvn90KCVTV0dueBiGASWJKiiuc5LSCxjAbGRnDDU1+Gpykb+bakETT7HhKqAbQaSE7GwxXDV5XF6k8a+0lymg6Cp2412LXFh/LPpo0t2tnYKI3MKN/YRGk1iZYoHsGxQaQxeMKJtz5vjjN5w/48WrU85IfEs01HPxI6cTd4d65pvV71lA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732212483; bh=x4CnRZs8fYDno46uM/km1SeBfOvxnMRI0rRroIL7EhC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pdtu2U6RaFttRqYSd1H3NPPwJ83sEne9NqUh6srrvdXNZJAmQv0PAleBxu6Z79DBwOiLzG8PxlCUl2A4SO1HvabbFJnmHLFKk7ODcY+6uBoL3h2V3i4+T+YeokjsK7q6m9MOe03lJImHbxLRZrcyk0VnKr8OXwE9XxHYnJwg3DkhJ44c5rWyajc4oMb6JnmEHK5JIdiUwVEA5vm717CSDwt7gjkkTyaoyMOfOAIMGoiFiMqDY1egNlx3Z5IUGWqLvDunXbBvYgcMpXheMCDO7fjSIUzgzpYzK02A0/MGEwRUEldkkHmONJSLiBxyIZU2/JyXNT4BkuBS/C7yCVNiNA==
X-YMail-OSG: 6TEUD8QVM1lZm51Lkjdit6WAWg2I3gCVCoI5_UcJq5yicKZzg6U.dgxiI3JQ3zf
 SlglxMTk_jsrjEdp.OhqBJTggNEaU3foxKNCbOvGUFf_cj_DTPyfPQLeoDZsJJpn7OOe3YFggBOS
 lYtBNgssX.XODjTh.pyr0.gO5C_digkAP7.Sc96pc45KjiYaq3Q3oQaKjdmKITQJXJPWw.VYEPOe
 dKfm2YC6F1IV4JQkp6UXTsvujKChBSyVwzpWrlAlbJVsmUaSisPS_BfA8xoAILT5iB8wR0rZyL07
 pMD2MpK6STD1yeB4kSAf1nF2xdW4PrsIdyIqDtm1vCQs3IgcCjuF0sxLoQLmEqHWZ35heGr6Is8k
 1c6UiT8z1GwqAsCn9n66VH7bHmJcxSa4ug6KrX8aPpWTFCUCT85wZg8aiKO_JCZNnrfm.I6.5Tsn
 MzH7UcKSFrER2yTvsVmYGYGJddFrsenEpCPcMNUBJIUEKfEg6bxHdjLBsEnJdf_RTgVUfwPEfrWy
 7KhXvNXkSpcZ64Kvg509Yie4oAGuhi7EtvxgbuTj1A3EV5pmhTaoMSkzOamOIgAqF_wtgXaZ52bb
 5rU.SRuw_X5MjBK2cqVsNlc5v04QH4E6aiJ1HU2nT6JhuWCT1xlME9MPoyhW_w3IO5fWSbERPr9P
 wrkNJY.Re.nHkQiI9tYvV_AWFEEDltD_u1PVhXNjqxUXxeKBdTj36RfdvsrMSWei4ZR4_q8tT2Lo
 o6TPbYC_W_Mg6Euk63z.6b5U6Z3zlfxKOni4Y4ve8fSeRX0Qge0jmiorCAqYppCxWdkREUkNznZj
 KGJQSDp2D.GE5yg0xkvSpt073PU3Xn5ZXCFESVQeCHK.YrVTG2Ac9chiFD.KUWfWFwdrdn5sk1yM
 BaO8KUdl9r24s4Yl2ClfCx1pRx47e8.aFGnzwey42Hhi3QWovcVpacqbuWc5Xz3pZg6b9Dl9EqFZ
 mh_Su2T5O8ZCBHSq5pU1Xk4PZVqAMUeiiVWK4s7uG6mXz9iulElz0KevGaKXGDEtnA6fN9dMsY9S
 q6l3keyHtvYnrOtg5dDu.r8pXHf38P16DL9xZUFWfXg9mxDfCw3kTrQ6B4b1phPhylawqWkzPIUe
 ZAXXV4yBaKl6R19Ij0wNL_p_DOCTcKGXFYKagKe7wLdGlaSUmjWUyVUH8bSlfLkdxqDOad3vZsYH
 C0zm5Yn2Gu8uNY04lANmQrK5kepFod097XE5Isy3tVqamgdlhDPbEyMpXaficV5NPf1ibOwc03mG
 0EBZ0HwRrJAtyM41izEVHy0X49mAa6SkN2Qg4Nf3SXY0w1qfto.fh6O6C_DPy7hYe.dvRb4hJScb
 MEhMfXbfgcxyJ6LkWEzmfWvXDC2DlZCGLMhejybjamuBMh9rUUQ4T3r8ANVkdK67lzW1mFIDGGt3
 vCrOkB_dkWJT2CAD7zxvNRQT0ML8E6tINfE2hRvdwuKyjhrT5_yFy4SsZXyTX4z5gJdtI6nZlYpP
 DJ3WiFbVEeVkS9o0mfa7Ymdz2LpR3FDLIn4spU0p6OSgeVEvpmy8hCYEY.SM326.wA4Kwo_RYbNN
 tSNRNqTtSrq8SuFIYA_6krV3GRm4Cx_T7.ghnUe.xL6WcHri3afhA.DVfVIpOX9dePnav5J1fMfs
 HDUhlmLiMoR0K9clkFwylAT7CMeG76C8.6NssAKL9XFo0SAokq7UTN1lezNBFpd1rLg0ooEo0mfk
 a1imFJkX_DdjYHTM4oPo2jIXL4i5sLVqjWljr7XAuWAzobYYRPXVou1k0KKhBdVP6hYktUu0IhE6
 ijLlCoSeD1Rot89g.diWrDSlfeAO2ehrybsWGSeEKCmc3.ui3lMeX2YZwieIZm9vM26YpHfgT92a
 jObjkAABBy9HhZg.P.rPKsGqDftQvYSbjl2PLzB62A9OeNLD_UfqIxDL16nAcClB0vwbXK.rayYb
 QCrZuudvcVj9jfbKQMKwdKM7i.mAEXW3rCQ9Ig4qUf1QuG9IiCtbWBmlwMeohjQerEFaQPRJdhOt
 YlqtmI828b3.N9L5M18frpUaA7lNtayA5bJTrRTktoKplVDR6mQAzXRQAqycTL4jqJwM19hR.jNl
 Gl0jHHYmvBB07aAnFWlYoQOctmh_KCCA01GIH1cCbPpbu1rjxtPEeVt0b..NoRcMniipAGAds9K_
 RgbhVzM0WlSkZb7MXee3ggaHuk5yEJmUGtybJAo5SGhJpovKzZLBERoYAb2ZdkySd6kA0cJFbmRK
 eWvJvxyeR0RWWXWuedpCiJ9brsxLWzFqHUsXhyG7e66gNQNZGK35yFHzbH9ROGErYI7GiKYtzWYN
 cug--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b3fc884e-23b1-4fbb-ac7c-8fd641c8110e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Thu, 21 Nov 2024 18:08:03 +0000
Received: by hermes--production-gq1-5dd4b47f46-bwg5p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a4874166160859949530f5aeaf2c67e;
          Thu, 21 Nov 2024 17:47:42 +0000 (UTC)
Message-ID: <9d020786-fca5-4e96-9384-fa1fc50bfa44@schaufler-ca.com>
Date: Thu, 21 Nov 2024 09:47:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: Song Liu <songliubraving@meta.com>, "Dr. Greg" <greg@enjellic.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>,
 Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "repnop@google.com" <repnop@google.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>,
 "gnoack@google.com" <gnoack@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
 <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
 <20241120165425.GA1723@wind.enjellic.com>
 <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/21/2024 12:28 AM, Song Liu wrote:
> Hi Dr. Greg,
>
> Thanks for your input!
>
>> On Nov 20, 2024, at 8:54 AM, Dr. Greg <greg@enjellic.com> wrote:
>>
>> On Tue, Nov 19, 2024 at 10:14:29AM -0800, Casey Schaufler wrote:
> [...]
>
>>>> 2.) Implement key/value mapping for inode specific storage.
>>>>
>>>> The key would be a sub-system specific numeric value that returns a
>>>> pointer the sub-system uses to manage its inode specific memory for a
>>>> particular inode.
>>>>
>>>> A participating sub-system in turn uses its identifier to register an
>>>> inode specific pointer for its sub-system.
>>>>
>>>> This strategy loses O(1) lookup complexity but reduces total memory
>>>> consumption and only imposes memory costs for inodes when a sub-system
>>>> desires to use inode specific storage.
>>> SELinux and Smack use an inode blob for every inode. The performance
>>> regression boggles the mind. Not to mention the additional
>>> complexity of managing the memory.
>> I guess we would have to measure the performance impacts to understand
>> their level of mind boggliness.
>>
>> My first thought is that we hear a huge amount of fanfare about BPF
>> being a game changer for tracing and network monitoring.  Given
>> current networking speeds, if its ability to manage storage needed for
>> it purposes are truely abysmal the industry wouldn't be finding the
>> technology useful.
>>
>> Beyond that.
>>
>> As I noted above, the LSM could be an independent subscriber.  The
>> pointer to register would come from the the kmem_cache allocator as it
>> does now, so that cost is idempotent with the current implementation.
>> The pointer registration would also be a single instance cost.
>>
>> So the primary cost differential over the common arena model will be
>> the complexity costs associated with lookups in a red/black tree, if
>> we used the old IMA integrity cache as an example implementation.
>>
>> As I noted above, these per inode local storage structures are complex
>> in of themselves, including lists and locks.  If touching an inode
>> involves locking and walking lists and the like it would seem that
>> those performance impacts would quickly swamp an r/b lookup cost.
> bpf local storage is designed to be an arena like solution that works
> for multiple bpf maps (and we don't know how many of maps we need 
> ahead of time). Therefore, we may end up doing what you suggested 
> earlier: every LSM should use bpf inode storage. ;) I am only 90%
> kidding. 

Sorry, but that's not funny. It's the kind of suggestion that some
yoho takes seriously, whacks together a patch for, and gets accepted
via the xfd887 device tree. Then everyone screams at the SELinux folks
because of the performance impact. As I have already pointed out,
there are serious consequences for an LSM that has a blob on every
inode.


