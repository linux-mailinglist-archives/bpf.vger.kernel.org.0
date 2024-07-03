Return-Path: <bpf+bounces-33770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6107926194
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AF01F235E4
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC617FABD;
	Wed,  3 Jul 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjNAd6wk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19A17E907;
	Wed,  3 Jul 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012371; cv=none; b=qafX8KG2fGpQk/dGBYjwnbZpmIrGII7nouQY0LuUvtPCcUAT/kvi/fuLk0FIcMvH1moQAw2283VN0m5/3pFtteU8sDw8C3sf8begqtbLY9hfRkd9hGUmjBK7fwpwOj9OOU8Dc9lMtV4GaUL637fC6LVOR6Lb/d9crn9BdKp0YTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012371; c=relaxed/simple;
	bh=Dpy7XLJWWzjcys6dWMZxXvTZ3LboCFSAQDdvL/3fbLQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Yv19Vb/z6rjDCfj0dixbpO5TeBisNh4gz35S5Cq+rPfOU403JGYiKGhVmq1Yh5jMWw5gL8fuXy1FFRe42TQ6n9/3GCX5kE1UzM9+RsbJ69m5qKPiRm6wvqmK/HCyutEMOQffdQNEHL7Wxv0JupyjQUBrvUWE11Xvj93+tSIhHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjNAd6wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F25C4AF0E;
	Wed,  3 Jul 2024 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720012370;
	bh=Dpy7XLJWWzjcys6dWMZxXvTZ3LboCFSAQDdvL/3fbLQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=TjNAd6wkUJNKMPB/8L/EpqKAZS0h/WCJN6wc84JQfybv0irujOfXUFaJA9ajlAj9L
	 sgoolG8tS7DBdY8Qj1P01VTKt+w7fTL1pNoSzfYLUGbj+eQlHaFmCwD6pzEgRL+jbb
	 cpMU2SBKRGy0Hk37Qm756FdrRNtpVAJEoTiGdn2Qp5lmBXH5exdg78hbfRwKWm8WYZ
	 WYDq1SQCBSUqsJOpH79Qy/rtCP4AUBMa2KkJa2VsEVvglvGV/KFMniUDupBa0qgwf2
	 sVnARiwXtJuBCVEaSLhObDFxhbD3xdmKFeIPf/VhSokiN8ohK9g8NIJ0+UhLlXLV1R
	 7zNzCxG5IHesw==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v13 2/5] security: Count the LSMs enabled at compile time
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <87zfqyq07z.fsf@prevas.dk>
Date: Wed, 3 Jul 2024 15:12:45 +0200
Cc: linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 andrii@kernel.org,
 keescook@chromium.org,
 daniel@iogearbox.net,
 renauld@google.com,
 revest@chromium.org,
 song@kernel.org,
 Kui-Feng Lee <sinquersw@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F537442F-C6B5-48E7-8492-569D5C3D8B83@kernel.org>
References: <20240629084331.3807368-1-kpsingh@kernel.org>
 <20240629084331.3807368-3-kpsingh@kernel.org> <87zfqyq07z.fsf@prevas.dk>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
X-Mailer: Apple Mail (2.3774.600.62)



> On 3 Jul 2024, at 11:44, Rasmus Villemoes <rasmus.villemoes@prevas.dk> =
wrote:
>=20
> KP Singh <kpsingh@kernel.org> writes:
>=20
>> These macros are a clever trick to determine a count of the number of
>> LSMs that are enabled in the config to ascertain the maximum number =
of
>> static calls that need to be configured per LSM hook.
>>=20
>> Without this one would need to generate static calls for the total
>> number of LSMs in the kernel (even if they are not compiled) times =
the
>> number of LSM hooks which ends up being quite wasteful.
>=20
> [snip]
>=20
>> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
>> new file mode 100644
>> index 000000000000..73c7cc81349b
>> --- /dev/null
>> +++ b/include/linux/lsm_count.h
>> @@ -0,0 +1,128 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Copyright (C) 2023 Google LLC.
>> + */
>> +
>> +#ifndef __LINUX_LSM_COUNT_H
>> +#define __LINUX_LSM_COUNT_H
>> +
>> +#include <linux/args.h>
>> +
>> +#ifdef CONFIG_SECURITY
>> +
>> +/*
>> + * Macros to count the number of LSMs enabled in the kernel at =
compile time.
>> + */
>> +
>> +/*
>> + * Capabilities is enabled when CONFIG_SECURITY is enabled.
>> + */
>> +#if IS_ENABLED(CONFIG_SECURITY)
>> +#define CAPABILITIES_ENABLED 1,
>> +#else
>> +#define CAPABILITIES_ENABLED
>> +#endif
>> +
>> +#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
>> +#define SELINUX_ENABLED 1,
>> +#else
>> +#define SELINUX_ENABLED
>> +#endif
>> +
> [snip]
>> +
>> +#if IS_ENABLED(CONFIG_EVM)
>> +#define EVM_ENABLED 1,
>> +#else
>> +#define EVM_ENABLED
>> +#endif
>> +
>> +/*
>> + *  There is a trailing comma that we need to be accounted for. This =
is done by
>> + *  using a skipped argument in __COUNT_LSMS
>> + */
>> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)
>> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
>> +
>> +#define MAX_LSM_COUNT \
>> + COUNT_LSMS( \
>> + CAPABILITIES_ENABLED \
>> + SELINUX_ENABLED \
>> + SMACK_ENABLED \
>> + APPARMOR_ENABLED \
>> + TOMOYO_ENABLED \
>> + YAMA_ENABLED \
>> + LOADPIN_ENABLED \
>> + LOCKDOWN_ENABLED \
>> + SAFESETID_ENABLED \
>> + BPF_LSM_ENABLED \
>> + LANDLOCK_ENABLED \
>> + IMA_ENABLED \
>> + EVM_ENABLED)
>> +
>> +#else
>> +
>> +#define MAX_LSM_COUNT 0
>> +
>> +#endif /* CONFIG_SECURITY */
>> +
>> +#endif  /* __LINUX_LSM_COUNT_H */
>=20
> OK, so I can tell from the other patches that this isn't just about
> getting MAX_LSM_COUNT to be a compile-time constant, it really has to =
be
> a single preprocessor token representing the right decimal value. That
> information could have been in some comment or the commit log. So
>=20
> #define MAX_LSM_COUNT (IS_ENABLED(CONFIG_SECURITY) + =
IS_ENABLED(CONFIG_SECURITY_SELINUX) + ...)
>=20
> doesn't work immediately. But this does provide not just a =
compile-time
> constant, but a preprocessor constant, so:
>=20
> Instead of all this trickery with defining temporary, never used =
again,
> macros expanding to something with trailing comma or not, what about
> this simpler (at least in terms of LOC, but IMO also readability)
> approach:
>=20
> /*
> * The sum of the IS_ENABLED() values provides the right value, but we
> * need MAX_LSM_COUNT to be a single preprocessor token representing
> * that value, because it will be passed to the UNROLL macro which
> * does token concatenation.
> */
>=20

I actually prefer the version we have now from a readability =
perspective, it makes it more explicit (the check about the CONFIG_* =
being enabled and counting them). let's keep this as an incremental =
change that you can propose :) once the patches are merged.

- KP


> #define __MAX_LSM_COUNT (\
>  IS_ENABLED(CONFIG_SECURITY) /* capabilities */ + \
>  IS_ENABLED(CONFIG_SECURITY_SELINUX) + \
>  ... \
>  IS_ENABLED(CONFIG_EVM) \
>  )
> #if   __MAX_LSM_COUNT =3D=3D 0
> #define MAX_LSM_COUNT 0
> #elif __MAX_LSM_COUNT =3D=3D 1
> #define MAX_LSM_COUNT 1
> #elif
> ...
> #elif __MAX_LSM_COUNT =3D=3D 15
> #define MAX_LSM_COUNT 15
> #else
> #error "Too many LSMs, add an #elif case"
> #endif
>=20
> Rasmus


