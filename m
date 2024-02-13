Return-Path: <bpf+bounces-21874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFE9853A90
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C911C26341
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A191CD10;
	Tue, 13 Feb 2024 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guqeijv6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416E5FEE5;
	Tue, 13 Feb 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851383; cv=none; b=VFMGR9dIz301poeZneucNZbR25Qdgof9GNp4vEH9Tw/Qg1LSRaitEe+qNXcxXOz+9p6tGqKoPvwCYhs3tcJn+U3zPdPtlPnvzblG9/jAua7P8/msw3IVB5VMCntDJarW4SxZrfBZ+Ie9a/PME4GfaUF+6M6Cq0ItGfxhsSbVAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851383; c=relaxed/simple;
	bh=0Sm0s4Jm6aoUjproFL7WupviqfKH/hZAqv9IO+XvGAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPOOylXYrOLNHKcVjGtwLWlWLsWbYYYJ3JMziHsPsehm6OQ23StzANnFAuDeW9DIFgg1RC5B8i5j+BoKTkPWyuVJ2UP/ZstgQa8ohr7GHJOQAFvqkxGeUHPvH+rh5rtcEXuEOeVG5fo1+BdfV+Tf9tdMiCVgHnb0GpiKvoUI4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guqeijv6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e10614c276so294526b3a.3;
        Tue, 13 Feb 2024 11:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707851381; x=1708456181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XH0yWsNKcUVsDPXca62EDjD6I/EfUDEuNnbhuflgzU=;
        b=guqeijv6HVF66yiJ+xpRPALOitiZXTqt2g27B9tdsHgDnfZVUzr3jExtv/wwE2PH3L
         mZ2fM0pwsmAFQbQecZMGaxWAtoXTpyeZhLv59fsEweerXYTcHALNldAmV0WAypMX2iQQ
         kd1jV6soC9EWR9JbgEbgUmt877obUwId6A2t9hETr//dV3h66Gpp3ruzw1NVj8xL9rrM
         pv2iV881o0isIvfuXBXacWQ2PTYTIU1RuCvPDcpvGMm46/o/d5nUg5Rwj7JwaeGB1F3Y
         kAtGxfEfwDqdvKCBfpLkSiNoAvVePyv47E0vm0Y/TgiPyX9U2Aoj62ylUPyMduwVVYs5
         IWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851381; x=1708456181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XH0yWsNKcUVsDPXca62EDjD6I/EfUDEuNnbhuflgzU=;
        b=kTGodVtnXWf7FMv2az4Jpp9TaZbXb97zQNwx5HCTdZMICxR2a/ux/2hiEUKfmcUHJq
         /8wAiChtFvr+QJpOCrWEjAhmQP42Ep7mBcVvkdIT/6sAn1ONzlwCvITGZ7J5FkHRN0l1
         P6bVIGhDCyHQetJ+uFZNXSJMcJq9lqxpqok6FtM1fKGvn8ibwbNozs3qCmx4R7TiI2lm
         K5Q0Gz99uJLCWOKVzB2/N3kbsKj+NJLDwNkl8GLRcA1cyEzJSnfWyeS1Y+mSR/lscxs+
         6MyCzMDJ/0Gq8CaZ02qqb2ZkmB/0f4jP0PcXqDlLg/L8a/IGZlP8uES6r8FsRSPbpF/p
         MNWA==
X-Forwarded-Encrypted: i=1; AJvYcCXR2/hoUkTN5er7SS+fJJD6MYdnHkSjjwWHqLiQBKdIY9x8pCwaab21tKRvO1TSYdXFzTbucqVTTuOu07YJ8YuRhvIwza/cXvucVpXU
X-Gm-Message-State: AOJu0YzlDwrPNr+5fBH2vbJBm35NlW5k9wIrNv61GeFN/NZKBKf9i316
	o9tcO/iym45Y3TQBluoT9yaXNqJXaWbxyXLzBUKMt17OV+yBbYht+VRm6n8JiXxQwbyCD+mIhUZ
	//JLUvgYOauIT9zUjsdzV95B4gqQ=
X-Google-Smtp-Source: AGHT+IFoP36OoKRJ9zVIbwlja3EPSDz0aNF9S7fwol5OkJSErlvgmvH7jEEoLq/DswQV4s3syh3p23ft08bfSscIAc4=
X-Received: by 2002:a05:6a21:1c87:b0:19e:b95e:16f2 with SMTP id
 sf7-20020a056a211c8700b0019eb95e16f2mr479511pzb.25.1707851381017; Tue, 13 Feb
 2024 11:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707080349.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1707080349.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 11:09:29 -0800
Message-ID: <CAEf4Bzb8dvboBVe-qN4+KEG_=phcMxCL25dr0ysjdVx5-MentQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf, bpftool: Support dumping kfunc
 prototypes from BTF
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, andrii@kernel.org, 
	olsajiri@gmail.com, quentin@isovalent.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 1:06=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This patchset enables dumping kfunc prototypes from bpftool. This is
> useful b/c with this patchset, end users will no longer have to manually
> define kfunc prototypes. For the kernel tree, this also means we can
> drop kfunc prototypes from:
>
>         tools/testing/selftests/bpf/bpf_kfuncs.h
>         tools/testing/selftests/bpf/bpf_experimental.h
>
> Example usage:
>
>         $ make PAHOLE=3D/home/dxu/dev/pahole/build/pahole -j30 vmlinux
>
>         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | =
rg "__ksym;" | head -3
>         extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __=
weak __ksym;
>         extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym=
;
>         extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)=
 __weak __ksym;
>
> Note that this patchset is only effective after the enabling pahole [0]
> change is merged and the resulting feature enabled with
> --btf_features=3Ddecl_tag_kfuncs.
>
> [0]: https://lore.kernel.org/bpf/cover.1707071969.git.dxu@dxuuu.xyz/
>
> =3D=3D=3D Changelog =3D=3D=3D
>
> From v1:
> * Add __weak annotation
> * Use btf_dump for kfunc prototypes
> * Update kernel bpf_rdonly_cast() signature
>
> Daniel Xu (2):
>   bpf: Have bpf_rdonly_cast() take a const pointer
>   bpftool: Support dumping kfunc prototypes from BTF

I've applied patch #1 as it's a good change regardless. Please send v2
for patch #2.

>
>  kernel/bpf/helpers.c    |  4 ++--
>  tools/bpf/bpftool/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 2 deletions(-)
>
> --
> 2.42.1
>

