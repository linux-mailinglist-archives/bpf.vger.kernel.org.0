Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E940D4715C1
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhLKTgg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 14:36:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229642AbhLKTgg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Dec 2021 14:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639251395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S3ukbNaa7Ocjbf8Z9trc2gR15CmHzngyLPAQDh53QQo=;
        b=eEJytp1cfvqyAG02Kms2tQbCA30OUviWGPjtFdNaW0Y4WnGQFTwYplGt2I830kio1Fetis
        Gj8MdSJnL1gn6HAO2Tk1vUd/ZKp50jV+y5EBeyV+MG3SgcEUt+r5A/nBeuCvI07ebXm2jU
        +I62wZ0beQZN1swfiIwNmgUHmiYHgrU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-m7Ir6fsfPDG4ENUWzvYOeA-1; Sat, 11 Dec 2021 14:36:34 -0500
X-MC-Unique: m7Ir6fsfPDG4ENUWzvYOeA-1
Received: by mail-ed1-f71.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso10787244edb.15
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 11:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S3ukbNaa7Ocjbf8Z9trc2gR15CmHzngyLPAQDh53QQo=;
        b=UBOh1b8aky2TE+Lve8mU3IFSJfyxMl1nrSZyRMA8GAUBh0D/YnSa3KLlcvxs/BFgBm
         LHeD0UQkBnZ3XziAJfQj69x5K+w8Ls2GvzMLN2+/ywRS+hVqqNr8mVlCLXmx1yPcsgyL
         sNrsOVcrLVingVeZQmOrpt1Hv26mBZZ0XNdp4JzNPqOrL6jyco7ue9pcbhd8mtQUd/O3
         t7dHsdL3aGX7yL6NrmbnasdorXOpa7DZdxtBsjBQo2mCt8ksGyL65o53ctH3eeOWiGR8
         DDnB4Gi22GHX2zdpQXKysotPwN6KKbltlNACDU6olat/hfCz0IKSBKbevzMyFBjiHwCn
         rVvQ==
X-Gm-Message-State: AOAM533JCS7WQSUljyvOGMmJuWAO5EHNxrA7B2/cdt4WNz5Jxb8ErHVT
        Pxc/fJmGaS/w4QmN+zwa0dDjvWRwEr7vUXNq3rNnhBjVEN09dVvnoGo1CR+jn5g3EJyTiWgV3bG
        KRaMO6AsNIsSN
X-Received: by 2002:a17:906:3a4a:: with SMTP id a10mr32539171ejf.253.1639251391657;
        Sat, 11 Dec 2021 11:36:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzu0j74RZxWMt3G5rn6VoVmo3ynaEQJdLcdMa8otWZCbq8+eMX2pvfIua2fCGwZ0hbcpZFseQ==
X-Received: by 2002:a17:906:3a4a:: with SMTP id a10mr32539103ejf.253.1639251390857;
        Sat, 11 Dec 2021 11:36:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id eg8sm3493196edb.75.2021.12.11.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:36:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 836A1180471; Sat, 11 Dec 2021 20:36:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
In-Reply-To: <20211210201333.896276-2-andrii@kernel.org>
References: <20211210201333.896276-1-andrii@kernel.org>
 <20211210201333.896276-2-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 11 Dec 2021 20:36:29 +0100
Message-ID: <87ilvvue6a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
> one of the first extremely frustrating gotchas that all new BPF users go
> through and in some cases have to learn it a very hard way.
>
> Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
> dropped the dependency on memlock and uses memcg-based memory accounting
> instead. Unfortunately, detecting memcg-based BPF memory accounting is
> far from trivial (as can be evidenced by this patch), so in practice
> most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
>
> As we move towards libbpf 1.0, it would be good to allow users to forget
> about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
> automatically. This patch paves the way forward in this matter. Libbpf
> will do feature detection of memcg-based accounting, and if detected,
> will do nothing. But if the kernel is too old, just like BCC, libbpf
> will automatically increase RLIMIT_MEMLOCK on behalf of user
> application ([0]).
>
> As this is technically a breaking change, during the transition period
> applications have to opt into libbpf 1.0 mode by setting
> LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
> libbpf_set_strict_mode().
>
> Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
> with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
> nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
> called before the first bpf_prog_load(), bpf_btf_load(), or
> bpf_object__load() call, otherwise it has no effect and will return
> -EBUSY.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/369
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

The probing approach breaks with out-of-order backports, I suppose.
Hopefully no one will do those for that particular patch, though (it's
not really a bugfix), and at least for RHEL we did backport them
together.

Can't think of any better ways of doing the detection either, but maybe
something to be aware of in the future (i.e., "don't change things in a
way that can't be detected from userspace")?

Anyway, with the nits below:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 6b2407e12060..7c82136979bf 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[...]

> +	/* attempt loading freplace trying to use custom BTF */
> +	memset(&attr, 0, bpf_load_attr_sz);
> +	attr.prog_type =3D BPF_PROG_TYPE_TRACING;
> +	attr.expected_attach_type =3D BPF_TRACE_FENTRY;

This comment also seems to be disagreeing with the code it's commenting
on?

[...]

> +static bool memlock_bumped;
> +static rlim_t memlock_rlim_max =3D RLIM_INFINITY;
> +
> +int libbpf_set_memlock_rlim_max(size_t memlock_max)
> +{
> +	if (memlock_bumped)
> +		return libbpf_err(-EBUSY);
> +
> +	memlock_rlim_max =3D memlock_max;
> +	return 0;
> +}
> +
> +int bump_rlimit_memlock(void)
> +{
> +	struct rlimit rlim;
> +
> +	/* this the default in libbpf 1.0, but for now user has to opt-in expli=
citly */
> +	if (!(libbpf_mode & LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK))
> +		return 0;
> +
> +	/* if kernel supports memcg-based accounting, skip bumping RLIMIT_MEMLO=
CK */
> +	if (memlock_bumped || kernel_supports(NULL, FEAT_MEMCG_ACCOUNT))
> +		return 0;
> +
> +	memlock_bumped =3D true;
> +
> +	/* zero memlock_rlim_max disables auto-bumping RLIMIT_MEMLOCK */
> +	if (memlock_rlim_max =3D=3D 0)
> +		return 0;
> +
> +	rlim.rlim_cur =3D rlim.rlim_max =3D memlock_rlim_max;
> +	if (setrlimit(RLIMIT_MEMLOCK, &rlim))
> +		return -errno;
> +
> +	return 0;
> +}
> +

"rlim_max" seems to imply this will only ever increase the limit, but if
I'm reading the code correctly it could actually end up lowering the
effective limit?

-Toke

