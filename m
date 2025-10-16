Return-Path: <bpf+bounces-71132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F90BE50FE
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD84F1F45
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F822D4C3;
	Thu, 16 Oct 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG+67SFR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A91E1C22
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639431; cv=none; b=GTmn8yhzW2NUidtV3Q1vUUaULYPzXnMb5DBxUxghr+PC1R7LdPXsZmi+BxZVXZMNG6OWqbLl+YHTaiF5btkNHZrsYAOBgjyrqbb+XzcLRQXGkBR2sJNI9ZRa5WvuRCtCcgqYVzp7i+IVwL5AGGhKMloejihcjv06PyNwVtRrcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639431; c=relaxed/simple;
	bh=o2z1ArA9Kxpub+/twKzioolnjDc5hsW3+fNM+hfXWrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa+VlhsMjxvDuMWzZ/3kTR/XyUIR5x2JarGEFRvrlE2zoRhuM8JGFHJSs1DfTOG7YmE8oPk+mp9L2uOQ8dYpsBpjnoNuJGob8xVYtJFOF+hEBZ+VjymySQclbR/ZdCCRuamLP6fxMPPVjgIzq/+3m1Ejq0QQWomBK36JwvG/PfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG+67SFR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-780fe76f457so13083617b3.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639428; x=1761244228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iYTsLnDfIngNG7GSv1C6wHFacu5SKsdDKjK/W6U1to=;
        b=iG+67SFRq1T3G7MuNdcMOdnqoF0K90Qxo6BGDfB93tiRCKm6I6D20/fmrCASEcVGFz
         aD0wlG/Qu4g2BSeyBt4jdOP33gPAkqyItWCon2XRKO3mjbIvxxtyipLwch5FZ58ZqpyN
         yg+9dWzKwpCTzTKL+uKVZ+EwgV7EFwSUtKT4UV9CrMr9C25lK0ns/CedAkgSW2KyZgrG
         MgRE1+kyyfSPsW7MRKkq2WqwNXUU2MZvTrmquofaPn55ZavGWBUpWfH0LsFQGXfAv0xU
         Q3panwO0xnCmvCxq1Rm26wB/XFZH8gq3+NgYKfQqvxeT9fGW29CXpPkR+vY4OptPdkoO
         yEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639428; x=1761244228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iYTsLnDfIngNG7GSv1C6wHFacu5SKsdDKjK/W6U1to=;
        b=o7hndg07iW1ra2Nqt1JKw3jfAJsJuDZhb0ZGF2I4ycVKA7fe2gJZKqmtmvN8eVo6bX
         iYe20KwxmYDIqfNTGIpDICpcs+wNm4pfslH7mqDQsN8ZO1qFI8onXNr3N5jPWD+m41AG
         Lh+NCrbyLuAHPHArNCqhiURdZkd1nlk2FwPgoEBqfdHv8hDjVSipLQgvVAoWDgp6Zf/F
         Yi0yjjATEJSttmZKTe6tTJn0UY1CWvbxk75ALRwlP1VvNNT8S2rngFixFYqHbtxRcWHW
         EL2AuGPnLbLvJavgbBzpREVGiOEjswIjndJxz1p+MCbDfCDWYClNHxG5Q12dJL8gjtJM
         v9mg==
X-Gm-Message-State: AOJu0Yz6qYFM8Y/JMUfYhczM5N9eRudmzCGGVJTxJr1pXTwwH9nVfjEI
	PMpD4K59apekTYSRRWmBzxaVgwoZ5rSSG7WkBjykuPR3FfJRHMY3xyJhH142ly3DR3sLOuYt+CW
	cUBIFxNF5tWIp2b2lfo1hJGJCtHrnswM=
X-Gm-Gg: ASbGncuMO66fqAHEZyp2e3CV64H2n7G16XcAtimNM3VqTGZb/0OfrJSf0Hcrvi0022j
	Xs43U/ZVNcHUd4CQNjAc4c4D4WHNN5ux3VcCZ92Uri4i2ZGtbufzKNoBLctynqGEKjSdAYy+bOC
	+TRxpcOiwLTTcjS4Va7YAkiqsBeZuAZLBO6ZGLXn0Lkrm94/1bjC+UsKyEIsA7EOm2N/CTCslD2
	ikW30/2rlCzdYyXsHWdsMOx5qfkvZt3643phLac7LmssibXy/gZ5nQdVQG8vxKyXE4c+VpqXYcX
	pfOJ7FN/5fc=
X-Google-Smtp-Source: AGHT+IGeN+k6JtxfaVsjKsQjPZ3o2DNPY6XeuC0XCOYJJK23ij6GMk/HJTa/jWfufuqRZ25CYPykiYQ46nFkOIL1SbM=
X-Received: by 2002:a05:690c:6f09:b0:717:ca51:d781 with SMTP id
 00721157ae682-7836d1c4bdcmr17813637b3.17.1760639427922; Thu, 16 Oct 2025
 11:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <CAEf4BzZhRtswXo_x0Oks-VvcmCLHUdKPKGtELPSECDtxyAEoKg@mail.gmail.com>
In-Reply-To: <CAEf4BzZhRtswXo_x0Oks-VvcmCLHUdKPKGtELPSECDtxyAEoKg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 Oct 2025 11:30:16 -0700
X-Gm-Features: AS18NWBt_RnLOdiSczBeofdSZLLQ4YBeRQJx9H1rOSADbrevfmtbStqMiCb197Q
Message-ID: <CAMB2axPuO-6iVatRp6-0GfcGubcspL_6zFeqE0scSjeCtPWejA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 0/4] Support associating BPF programs with struct_ops
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > This patchset adds a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to
> > the bpf() syscall to allow associating a BPF program with a struct_ops.
> > The command is introduced to address a emerging need from struct_ops
> > users. As the number of subsystems adopting struct_ops grows, more
> > users are building their struct_ops-based solution with some help from
> > other BPF programs. For exmample, scx_layer uses a syscall program as
> > a user space trigger to refresh layers [0]. It also uses tracing progra=
m
> > to infer whether a task is using GPU and needs to be prioritized [1]. I=
n
> > these use cases, when there are multiple struct_ops instances, the
> > struct_ops kfuncs called from different BPF programs, whether struct_op=
s
> > or not needs to be able to refer to a specific one, which currently is
> > not possible.
> >
> > The new BPF command will allow users to explicitly associate a BPF
> > program with a struct_ops map. The libbpf wrapper can be called after
> > loading programs and before attaching programs and struct_ops.
> >
> > Internally, it will set prog->aux->st_ops_assoc to the struct_ops
> > struct (i.e., kdata). struct_ops kfuncs can then get the associated
> > struct_ops by adding a "__prog" argument. The value of the speical
> > argument will be fixed up by the verifier during verification.
> >
> > The command conceptually associates the implementation of BPF programs
> > with struct_ops map, not the attachment. A program associated with the
> > map will take a refcount of it so that st_ops_assoc always points to a
> > valid struct_ops struct. However, the struct_ops can be in an
> > uninitialized or unattached state. The struct_ops implementer will be
> > responsible to maintain and check the state of the associated
> > struct_ops before accessing it.
> >
> > We can also consider support associating struct_ops link with BPF
> > programs, which on one hand make struct_ops implementer's job easier,
> > but might complicate libbpf workflow and does not apply to legacy
> > struct_ops attachment.
> >
> > [0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/=
src/bpf/main.bpf.c#L557
> > [1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/=
src/bpf/main.bpf.c#L754
> >
> > Amery Hung (4):
> >   bpf: Allow verifier to fixup kernel module kfuncs
> >   bpf: Support associating BPF program with struct_ops
> >   libbpf: Add bpf_struct_ops_associate_prog() API
> >   selftests/bpf: Test BPF_STRUCT_OPS_ASSOCIATE_PROG command
> >
>
> please also drop RFC from the next revision

Thanks for the review. I will drop the RFC tag in the next respin.


>
> >  include/linux/bpf.h                           |  11 ++
> >  include/uapi/linux/bpf.h                      |  16 +++
> >  kernel/bpf/bpf_struct_ops.c                   |  32 ++++++
> >  kernel/bpf/core.c                             |   6 +
> >  kernel/bpf/syscall.c                          |  38 +++++++
> >  kernel/bpf/verifier.c                         |   3 +-
> >  tools/include/uapi/linux/bpf.h                |  16 +++
> >  tools/lib/bpf/bpf.c                           |  18 +++
> >  tools/lib/bpf/bpf.h                           |  19 ++++
> >  tools/lib/bpf/libbpf.map                      |   1 +
> >  .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
> >  .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
> >  .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
> >  .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
> >  14 files changed, 357 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_=
ops_assoc.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.=
c
> >
> > --
> > 2.47.3
> >

