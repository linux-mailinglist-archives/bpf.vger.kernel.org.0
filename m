Return-Path: <bpf+bounces-58358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03669AB90E7
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECE77AA602
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5929B77F;
	Thu, 15 May 2025 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5loLf+z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223EF27A461
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341611; cv=none; b=QZ7Ywc48nEq63cpI/szLVCC1bvDcb+OqpL9oxWn0uxkURkbGuivCillZGVR9zpWfdZhncH7N8CHziwKyBABWjUWdNcukYFON+r3sQ2SlJ1XYrUu7UEbLATBC9fs3z8V6KyR1l7b+AHi5uY4R/cPy+qpOkzM5+HpW5vLirkJjhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341611; c=relaxed/simple;
	bh=ShLEHuqT5geblJv1ryyap4NMlZP/eHqDBn/zSdr5fdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmM4IOfvLsPuPOYklFQC944Jxk7baBUzuLaCanm2DW+l5kqT/RsNpHs1UqT7BG7OoXW0kzr1nrIHYpHcJheUd7m0ir5k2oqPMjYFxb+Uej64d9IU4Uf2GsVzv4rFjmLXQ97ENpbMI+5MDEtg1Icj72z8XGPnlrD9W/xPIt3LnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5loLf+z; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1169061a12.3
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747341609; x=1747946409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6UnJY3RxWVtFZLW341IkUvm1cdW4LTF/WUlAxS7bcs=;
        b=H5loLf+zfz6LfAykOCpYKVKCxobB0NOufh7pB8tnFu4NU827wbKVmN2yykeFEcWpUf
         ff2U4ol0fm60QxlapW2tS4FRljIKjbsHletgI+6iNh+jY2BYSmctO/foagxHNfKutbj0
         KjYF3u3zfuM+dyZapqOGckeX0xh60vlkNFJC0AYwwIefpEq/WE1Soghe7NMy4Frb/bys
         D+9V5Kr7pns8ORTgIFgo7c/TN7X4j71voj5Z4Xnp4MM1esRv+KCrW+vyNmMwOm2eteLA
         f0jnvHXIwnhzgto11MfiymI/4Y/qdr328+ugLeWVUE3kbryKlFG/hT+RV5Sp3FGFdlT/
         tKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747341609; x=1747946409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6UnJY3RxWVtFZLW341IkUvm1cdW4LTF/WUlAxS7bcs=;
        b=OKoKSegp8ag0Pz4Fu0RsAU+7KmFafRTphGA0Hxku5VqNsfBI7dpcp1RhufTwfg0x+d
         YJn6L4cw6CL3B7nIw75J11Ddd1ZlBI0eDEcA8SnWSIN9RTCDEzJ17s8si3MGLsWd5IrC
         MCEJ+evgoWeXcUe9NxoI1SxMCLHawyN9GgrqzQHARhWmm7JZgfdeC9Qt77Ox9IXLdopJ
         e2KzWlXVuISeJgj7R/YKohsMYl4UU4DD0H5mv3Gnry923I0W7GtT0ITpPEHBlKqJW4Nu
         F+WekL90DV80VAS8ysdbGtlUqBQj1Uhvwk15BdlttyY2VHXyklOYyIqSQl2npGqOpkat
         +Vag==
X-Gm-Message-State: AOJu0Yz2fQ5pmZVo06DtiMNGkvNb9LjAcoKObRP/S93u4ms7hIxKMLad
	+2vLSELEVcKV0nnSEZP6l+ePkE1fxaZNPNZ+tMUSzQvmB68DBk763lz6puqIzUonklY/dwCCyxO
	f5c70b1CLlIcuwTFODjDC8Hwy9D28nUU=
X-Gm-Gg: ASbGncvbD1o/aCevWOZmJbva1i5Bj62BOukF7wtY2preg3pqvj/N5ugaWpBhs8slf7N
	2qPEraTseX3tTbW2Pe/sGJ9a4WuBJeaXXCDK0Ete5bWYGFeH+TQnwsl00h8zi3oNZgqDIHBYYB7
	hgeQpzzhFJJsyQ3jd8dL6n8Bkz6THQhPRmGLV4vHONLetCc809nLGi3JHuOrA=
X-Google-Smtp-Source: AGHT+IEXpXQeKj96QS8UvMyjlZaKDEO1VTCXiI8EjyCdSeSPEjYnM0NuY03zjgZDTxC4jF0XTZfaEJnoYweBUjM3MUU=
X-Received: by 2002:a17:90a:d40d:b0:30a:883a:ea5b with SMTP id
 98e67ed59e1d1-30e7d545032mr1366587a91.17.1747341609121; Thu, 15 May 2025
 13:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508223524.487875-1-yonghong.song@linux.dev> <20250508223529.488295-1-yonghong.song@linux.dev>
In-Reply-To: <20250508223529.488295-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 13:39:54 -0700
X-Gm-Features: AX0GCFvpT6uX5NKToD3_UH_dbtdNLSTu3G4ZX6mBSA1OG6WQmPAHI_Ik9cUcJw0
Message-ID: <CAEf4BzYw-0gMuvgEHF-G4=G6V9QPCgMj_Ln7-4eeOgWMGjBGog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] cgroup: Add bpf prog revisions to struct cgroup_bpf
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:35=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> One of key items in mprog API is revision for prog list. The revision
> number will be increased if the prog list changed, e.g., attach, detach
> or replace.
>
> Add 'revisions' field to struct cgroup_bpf, representing revisions for
> all cgroup related attachment types. The initial revision value is
> set to 1, the same as kernel mprog implementations.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf-cgroup-defs.h | 1 +
>  kernel/cgroup/cgroup.c          | 5 +++++
>  2 files changed, 6 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
> index 0985221d5478..c9e6b26abab6 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -63,6 +63,7 @@ struct cgroup_bpf {
>          */
>         struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
>         u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
> +       u64 revisions[MAX_CGROUP_BPF_ATTACH_TYPE];
>
>         /* list of cgroup shared storages */
>         struct list_head storages;
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 63e5b90da1f3..260ce8fc4ea4 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2071,6 +2071,11 @@ static void init_cgroup_housekeeping(struct cgroup=
 *cgrp)
>         for_each_subsys(ss, ssid)
>                 INIT_LIST_HEAD(&cgrp->e_csets[ssid]);
>
> +#ifdef CONFIG_CGROUP_BPF
> +       for (int i =3D 0; i < ARRAY_SIZE(cgrp->bpf.revisions); i++)
> +               cgrp->bpf.revisions[i] =3D 1;
> +#endif
> +
>         init_waitqueue_head(&cgrp->offline_waitq);
>         INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
>  }
> --
> 2.47.1
>

