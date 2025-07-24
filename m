Return-Path: <bpf+bounces-64291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F5B1104B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47D83B6CA2
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5D2EB5A7;
	Thu, 24 Jul 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLveus91"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D02D97AB
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377768; cv=none; b=PyYL3LNJajW3AXbn6iI7bCnLwBRWViyRA+s507bYqgfywGXXQzSTvHi+9w3l64J7C2mOy0lHna3PqMG20srn2MfipA6zGLe+Yi2jqPkCoTnvnsT9o5voHfB4b4Ml18S/uFiH60I9XfR2RB5MbiTfTtbCPqVIfZ9bbipQvSlsuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377768; c=relaxed/simple;
	bh=iHv6FcFr9ubdNqnfE/PzII/jmlXlOCHMeiqQyuRtKBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqElENRK0Xrndal48eRXxLNBvL6nXiUdeWIUHlKm1RtxMq1mWuUrD2AJqVmFlVkb+QtMFTn7uW34Ox3H+E5YCRNt0Qe+UqnlJK7457lgfenWaT05xkBNsiUmuycP4OY1iJfkB/zA+Sy6Y34M1l0MoFYEoseP3gaxPBKdkUB5tKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLveus91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405B2C4AF09
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753377768;
	bh=iHv6FcFr9ubdNqnfE/PzII/jmlXlOCHMeiqQyuRtKBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YLveus919Jiz+6wpVXvrW/RMXmwrvYH9cnclPMpOeu6WkidDgCEhj/NRfI59kNlQL
	 ePiufOE9Mv7XD7n5GhALyT9EqdGT4AzGQ7NRZVgSF2Gy551u+FOVkV2qfVMb+qtBsp
	 39C2gEI5j91juKHL7OjN9gfkab+2ezjkZHOjJBd/kafDjAEy/DLn8XZB0UyMCLzPPv
	 EoK+w6rhUSxq5Mllx8NcjwOgyTAF6eqgBQmAZNEjZUT8Wm2x8A1O2or1w6T/fMMS7t
	 SyKCPqPg2k10u1/twpnuTp+ZjXYUoCzodMrAY1rElE/X+FbY2J17k9QmmVZfzQ9Lzx
	 pSw41LcPCrEnA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so2736448a12.3
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 10:22:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw84mIDLwjaKj8GPsTXpXZBYU7V9fDI3+nJd11dUndJmu7CU41M
	ZflPFuWJoYBaLHTsZbD5JUJy8K4KtY4zLyCGEhZPdS2h6j2KEFnS/ATk8dmQUT2fNkrC+6071z3
	ePBkmy18s78IysJyc15IxJ47cgTaqr/uLFPTENysE
X-Google-Smtp-Source: AGHT+IGRIfTM4kAibJSn6oNcZo9iTyHDOU/dXANlzSYv1+sBg7kSkBPEZA+rCTf9i2uBWVPcYtECBYeUY6b3Ob93eiU=
X-Received: by 2002:a05:6402:2353:b0:607:f513:4808 with SMTP id
 4fb4d7f45d1cf-6149b409f40mr6227925a12.1.1753377766652; Thu, 24 Jul 2025
 10:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-9-kpsingh@kernel.org>
 <c6ed224b9fb5db2cfac2620c75a49fa22cbaf617.camel@HansenPartnership.com>
In-Reply-To: <c6ed224b9fb5db2cfac2620c75a49fa22cbaf617.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 24 Jul 2025 19:22:35 +0200
X-Gmail-Original-Message-ID: <CACYkzJ79h9G1gdxtS=H8oNoCTxCqsG0d+Ox5xfXx225_OtLfHQ@mail.gmail.com>
X-Gm-Features: Ac12FXzPweP5i9EJaJM1of7IwHtvD9t_8b1buJnKLosF6lAT6MI2RoPdH3O8jeM
Message-ID: <CACYkzJ79h9G1gdxtS=H8oNoCTxCqsG0d+Ox5xfXx225_OtLfHQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] bpf: Implement signature verification for BPF programs
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 7:11=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-07-21 at 23:19 +0200, KP Singh wrote:
> [...]
>
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index fd3b895ebebf..b42c3740e053 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1607,6 +1607,16 @@ union bpf_attr {
> >                * continuous.
> >                */
> >               __u32           fd_array_cnt;
> > +             /* Pointer to a buffer containing the signature of
> > the BPF
> > +              * program.
> > +              */
> > +             __aligned_u64   signature;
> > +             /* Size of the signature buffer in bytes. */
> > +             __u32           signature_size;
> > +             /* ID of the kernel keyring to be used for signature
> > +              * verification.
> > +              */
> > +             __u32           keyring_id;
>
> This should become __s32 to match the value passed in to
> bpf_lookup_user_key().
>
> [...]
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 22fda92ab7ce..111f91a99166 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2779,8 +2779,41 @@ static bool is_perfmon_prog_type(enum
> > bpf_prog_type prog_type)
> >       }
> >  }
> >
> > +static noinline int bpf_prog_verify_signature(struct bpf_prog *prog,
> > +                                           union bpf_attr *attr,
> > +                                           bool is_kernel)
> > +{
> > +     bpfptr_t usig =3D make_bpfptr(attr->signature, is_kernel);
> > +     struct bpf_dynptr_kern sig_ptr, insns_ptr;
> > +     struct bpf_key *key =3D NULL;
> > +     void *sig;
> > +     int err =3D 0;
> > +
> > +     key =3D bpf_lookup_user_key(attr->keyring_id, 0);
> > +     if (!key)
> > +             return -ENOKEY;
>
> This still only checks against user keyrings and not system trusted
> keyrings as was pointed out in v1.  Since user keyrings are negative
> and user key serials begin at 3 or more, there's no overlap with the
> system keyring specifiers and you can just overload attr->keyring_id,
> like the below.
>
> Regards,
>
> James
>
> ---
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 111f91a99166..10fd3ea5d91f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched/signal.h>
>  #include <linux/vmalloc.h>
> +#include <linux/verification.h>
>  #include <linux/mmzone.h>
>  #include <linux/anon_inodes.h>
>  #include <linux/fdtable.h>
> @@ -2789,7 +2790,10 @@ static noinline int bpf_prog_verify_signature(stru=
ct bpf_prog *prog,
>         void *sig;
>         int err =3D 0;
>
> -       key =3D bpf_lookup_user_key(attr->keyring_id, 0);
> +       if (system_keyring_id_check(attr->keyring_id) =3D=3D 0)
> +               key =3D bpf_lookup_system_key(attr->keyring_id);
> +       else
> +               key =3D bpf_lookup_user_key(attr->keyring_id, 0);
>         if (!key)
>                 return -ENOKEY;
>

Thanks James, updated.

- KP

>

