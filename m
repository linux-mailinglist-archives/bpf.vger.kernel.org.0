Return-Path: <bpf+bounces-31746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD5902A74
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E2D1C219E8
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55F555897;
	Mon, 10 Jun 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FSbpHbeJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8051879;
	Mon, 10 Jun 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053939; cv=none; b=LVVKsgTj+b6XItx7Wd1nUlx34Jeg3dTNRt4FYGO7gyEdGAMzcOu7Tmp3NJoRyAAEfEMUYROkGCL6wIIRz0JlQYcXz/1vtyCGPTID3yiikEyaugazNOmC2WVYZoQBwpqpMR8ZmW2Yie2rpe9rxKUoKOqqPePyqy/orMFlLUE0E7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053939; c=relaxed/simple;
	bh=L6idWEylvQppgYHhQF7YKp4UwnmESQ6eDx18yypSxo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwCqnCpuQPyrxRaWQGHoELnMYYYqLm1Q8f7Ow9FtaLusrnBhzYihjDw0pxhCeXYZ7cMslXask/l+uSIwqApr/pTD9rZVRBeH4TU7d8M3p483SYh1XpYgAMPyOF320BeIxN/4uCjh79pDhhXdQD2vQDgLsuAP2huJEDoZtfhF8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FSbpHbeJ; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.83] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EA0BE40FC9;
	Mon, 10 Jun 2024 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718053927;
	bh=0+CsIHZM4SguLeaiX+nC4gxIoEzogxF06SwIBnAaJt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=FSbpHbeJ0qs8ahd0/RIZF8ZdBAdo315IAdFQ9tI7YpABFM9GR8ENuv/wcQaY5ALTy
	 4O/iscNJCO9tCrEPM2U+Smpe0vkPzg2buaPqVAY7XIwhb+pZ/cSd+rLmysOdEreLNB
	 tlVCs88sRtTcqCBA654FwfvPgsU4csCpEKSjUwFz0JNx6m4B2HMn2ZKHXxkYnj3Tbn
	 Yl4FBS+yDxThTxFsiU0mnSWBYBNkS731+cmrGfN1/HQTY2Br1SKtR9bsm0j5XEiFgk
	 1UJEVB91SFy9PbHey6QQiLkSQISQ9wTOVHt/r4tK38CMpGHxQSu3TxK2hzOhYcx+/o
	 yrBNYQC0MnuUQ==
Message-ID: <4cfca86d-ceb7-4abe-8b6b-35194fc55565@canonical.com>
Date: Mon, 10 Jun 2024 14:12:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] capability: introduce new capable flag
 CAP_OPT_NOAUDIT_ONDENY
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org
Cc: linux-block@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Christian Brauner <brauner@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 apparmor@lists.ubuntu.com, selinux@vger.kernel.org, bpf@vger.kernel.org
References: <20240315113828.258005-1-cgzones@googlemail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/15/24 04:37, Christian Göttsche wrote:
> Introduce a new capable flag, CAP_OPT_NOAUDIT_ONDENY, to not generate
> an audit event if the requested capability is not granted.  This will be
> used in a new capable_any() functionality to reduce the number of
> necessary capable calls.
> 
> Handle the flag accordingly in AppArmor and SELinux.
> 
> CC: linux-block@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: John Johansen <john.johansen@canonical.com>

> ---
> v5:
>     rename flag to CAP_OPT_NOAUDIT_ONDENY, suggested by Serge:
>       https://lore.kernel.org/all/20230606190013.GA640488@mail.hallyn.com/
> ---
>   include/linux/security.h       |  2 ++
>   security/apparmor/capability.c |  8 +++++---
>   security/selinux/hooks.c       | 14 ++++++++------
>   3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 41a8f667bdfa..c60cae78ff8b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -70,6 +70,8 @@ struct lsm_ctx;
>   #define CAP_OPT_NOAUDIT BIT(1)
>   /* If capable is being called by a setid function */
>   #define CAP_OPT_INSETID BIT(2)
> +/* If capable should audit the security request for authorized requests only */
> +#define CAP_OPT_NOAUDIT_ONDENY BIT(3)
>   
>   /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
>   #define SECURITY_LSM_NATIVE_LABELS	1
> diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
> index 9934df16c843..08c9c9a0fc19 100644
> --- a/security/apparmor/capability.c
> +++ b/security/apparmor/capability.c
> @@ -108,7 +108,8 @@ static int audit_caps(struct apparmor_audit_data *ad, struct aa_profile *profile
>    * profile_capable - test if profile allows use of capability @cap
>    * @profile: profile being enforced    (NOT NULL, NOT unconfined)
>    * @cap: capability to test if allowed
> - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
> + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NOAUDIT_ONDENY bit determines whether audit
> + *	record is generated
>    * @ad: audit data (MAY BE NULL indicating no auditing)
>    *
>    * Returns: 0 if allowed else -EPERM
> @@ -126,7 +127,7 @@ static int profile_capable(struct aa_profile *profile, int cap,
>   	else
>   		error = -EPERM;
>   
> -	if (opts & CAP_OPT_NOAUDIT) {
> +	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NOAUDIT_ONDENY) && error)) {
>   		if (!COMPLAIN_MODE(profile))
>   			return error;
>   		/* audit the cap request in complain mode but note that it
> @@ -143,7 +144,8 @@ static int profile_capable(struct aa_profile *profile, int cap,
>    * @subj_cred: cred we are testing capability against
>    * @label: label being tested for capability (NOT NULL)
>    * @cap: capability to be tested
> - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
> + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NOAUDIT_ONDENY bit determines whether audit
> + *	record is generated
>    *
>    * Look up capability in profile capability set.
>    *
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3448454c82d0..1a2c7c1a89be 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1624,7 +1624,7 @@ static int cred_has_capability(const struct cred *cred,
>   	u16 sclass;
>   	u32 sid = cred_sid(cred);
>   	u32 av = CAP_TO_MASK(cap);
> -	int rc;
> +	int rc, rc2;
>   
>   	ad.type = LSM_AUDIT_DATA_CAP;
>   	ad.u.cap = cap;
> @@ -1643,11 +1643,13 @@ static int cred_has_capability(const struct cred *cred,
>   	}
>   
>   	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
> -	if (!(opts & CAP_OPT_NOAUDIT)) {
> -		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
> -		if (rc2)
> -			return rc2;
> -	}
> +	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NOAUDIT_ONDENY) && rc))
> +		return rc;
> +
> +	rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
> +	if (rc2)
> +		return rc2;
> +
>   	return rc;
>   }
>   


