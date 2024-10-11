Return-Path: <bpf+bounces-41723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF3999E13
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 09:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2FB212FD
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957320ADCC;
	Fri, 11 Oct 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TDyRRgnH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9C209F4D;
	Fri, 11 Oct 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632236; cv=none; b=LyaH2SFxk8Q+XqOOHTOrbHbvTSSg8WqgIirLGRRhL+QFz+gsivpXQYyigBVKuWV7SE6gYcUPqYGHDLThWDoG3cGLz3DbJWK6DfgeuxNOP7pEvHi4SrQdEPE4AhGfR8hKb8MJ9MwuX7cm4o5IjGMutb7AD090T8Ct5nUlEpwS+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632236; c=relaxed/simple;
	bh=a7kbOY4bHJu1rLRmVz3SN2W1jQ5ky54AQ0Pja37EvPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQPevsXjBkVbgNeALmYBkDkuFK4w0v9Lh//jvblU2Uu82wSMQtsa5+v4UFYjGZ9VNWYg4jge3QovYIUz5XgkKp/ibP/upmzaWQOUrfGvvVxdnT4S+ACSf4/AVW7YCKB4DkSXgMV/zGYuy8X1Yp57MsTz+5xBIXY7SjiavwLImWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TDyRRgnH; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 967D53F1E8;
	Fri, 11 Oct 2024 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728632225;
	bh=1UMhcgZbU9zce5GQB2psJSMAZetEYbDg+BFWhu9C/E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=TDyRRgnHhYw6Kndbw6MRSaLwO0KnBkYm7px2OFE6R1z3W3faEla/sREV79n4QR/lo
	 jMH88f/hd3kxZ0h8CxRMAdz7zHwxCRQH2wZJwUoP3aWP/x6EZMOCjsz+3vGO0mo0Bj
	 LbrINP1DVukQprqjTzGWPXntpWpFb1Z7mYyvgdJpM0YBdAsw7KwSQ1sV92PWJZmN4u
	 rjsf3Cpi7PGnmUT5MYgvShgw++nO2Ad5928Umc95y/efiBR5025hM3Lzp9IJUxeNde
	 yeawGqeSq0NWT1KBtBy+oqiJiFNG6DFKliW/dxbk/GDitefrra8weDQQi3pPU9vbSj
	 PFFxgrBX/NScw==
Message-ID: <3ca7f932-df55-44c5-86c4-0785fd15c50f@canonical.com>
Date: Fri, 11 Oct 2024 00:36:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] LSM: Add the lsm_prop data structure.
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org
References: <20241009173222.12219-1-casey@schaufler-ca.com>
 <20241009173222.12219-2-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20241009173222.12219-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 10:32, Casey Schaufler wrote:
> When more than one security module is exporting data to audit and
> networking sub-systems a single 32 bit integer is no longer
> sufficient to represent the data. Add a structure to be used instead.
> 
> The lsm_prop structure definition is intended to keep the LSM
> specific information private to the individual security modules.
> The module specific information is included in a new set of
> header files under include/lsm. Each security module is allowed
> to define the information included for its use in the lsm_prop.
> SELinux includes a u32 secid. Smack includes a pointer into its
> global label list. The conditional compilation based on feature
> inclusion is contained in the include/lsm files.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: John Johansen <john.johansen@canonical.com>

> Cc: apparmor@lists.ubuntu.com
> Cc: bpf@vger.kernel.org
> Cc: selinux@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>   include/linux/lsm/apparmor.h | 17 +++++++++++++++++
>   include/linux/lsm/bpf.h      | 16 ++++++++++++++++
>   include/linux/lsm/selinux.h  | 16 ++++++++++++++++
>   include/linux/lsm/smack.h    | 17 +++++++++++++++++
>   include/linux/security.h     | 20 ++++++++++++++++++++
>   5 files changed, 86 insertions(+)
>   create mode 100644 include/linux/lsm/apparmor.h
>   create mode 100644 include/linux/lsm/bpf.h
>   create mode 100644 include/linux/lsm/selinux.h
>   create mode 100644 include/linux/lsm/smack.h
> 
> diff --git a/include/linux/lsm/apparmor.h b/include/linux/lsm/apparmor.h
> new file mode 100644
> index 000000000000..612cbfacb072
> --- /dev/null
> +++ b/include/linux/lsm/apparmor.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * AppArmor presents single pointer to an aa_label structure.
> + */
> +#ifndef __LINUX_LSM_APPARMOR_H
> +#define __LINUX_LSM_APPARMOR_H
> +
> +struct aa_label;
> +
> +struct lsm_prop_apparmor {
> +#ifdef CONFIG_SECURITY_APPARMOR
> +	struct aa_label *label;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_APPARMOR_H */
> diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
> new file mode 100644
> index 000000000000..8106e206fcef
> --- /dev/null
> +++ b/include/linux/lsm/bpf.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * BPF may present a single u32 value.
> + */
> +#ifndef __LINUX_LSM_BPF_H
> +#define __LINUX_LSM_BPF_H
> +#include <linux/types.h>
> +
> +struct lsm_prop_bpf {
> +#ifdef CONFIG_BPF_LSM
> +	u32 secid;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_BPF_H */
> diff --git a/include/linux/lsm/selinux.h b/include/linux/lsm/selinux.h
> new file mode 100644
> index 000000000000..9455a6b5b910
> --- /dev/null
> +++ b/include/linux/lsm/selinux.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * SELinux presents a single u32 value which is known as a secid.
> + */
> +#ifndef __LINUX_LSM_SELINUX_H
> +#define __LINUX_LSM_SELINUX_H
> +#include <linux/types.h>
> +
> +struct lsm_prop_selinux {
> +#ifdef CONFIG_SECURITY_SELINUX
> +	u32 secid;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_SELINUX_H */
> diff --git a/include/linux/lsm/smack.h b/include/linux/lsm/smack.h
> new file mode 100644
> index 000000000000..ff730dd7a734
> --- /dev/null
> +++ b/include/linux/lsm/smack.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * Smack presents a pointer into the global Smack label list.
> + */
> +#ifndef __LINUX_LSM_SMACK_H
> +#define __LINUX_LSM_SMACK_H
> +
> +struct smack_known;
> +
> +struct lsm_prop_smack {
> +#ifdef CONFIG_SECURITY_SMACK
> +	struct smack_known *skp;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_SMACK_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b86ec2afc691..555249a8d121 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -34,6 +34,10 @@
>   #include <linux/sockptr.h>
>   #include <linux/bpf.h>
>   #include <uapi/linux/lsm.h>
> +#include <linux/lsm/selinux.h>
> +#include <linux/lsm/smack.h>
> +#include <linux/lsm/apparmor.h>
> +#include <linux/lsm/bpf.h>
>   
>   struct linux_binprm;
>   struct cred;
> @@ -152,6 +156,22 @@ enum lockdown_reason {
>   	LOCKDOWN_CONFIDENTIALITY_MAX,
>   };
>   
> +/* scaffolding */
> +struct lsm_prop_scaffold {
> +	u32 secid;
> +};
> +
> +/*
> + * Data exported by the security modules
> + */
> +struct lsm_prop {
> +	struct lsm_prop_selinux selinux;
> +	struct lsm_prop_smack smack;
> +	struct lsm_prop_apparmor apparmor;
> +	struct lsm_prop_bpf bpf;
> +	struct lsm_prop_scaffold scaffold;
> +};
> +
>   extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>   extern u32 lsm_active_cnt;
>   extern const struct lsm_id *lsm_idlist[];


