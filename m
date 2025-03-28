Return-Path: <bpf+bounces-54871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE6CA75084
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 19:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56751176742
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971651E130F;
	Fri, 28 Mar 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT2Cepiq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799691531C5;
	Fri, 28 Mar 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187527; cv=none; b=uMRUsIxsW9g7CU+dTE0Bhf8VrOSz3IL3nrYr98qW+E85MAh167ekxVLMZXwYqpmjq0zKwCj072JqT/zKUbD/nymJhk6OhebcYRgMmTjQSvjj+20SgT7FbbzdNdL6IeG6+zK3CRxXkEH+vFQ16ZqvqszZdhzN8U3AgkmqpRlzB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187527; c=relaxed/simple;
	bh=dmw/5m7IZXzUnE3b4KRIPY1KfLGFwtYZiQxylVjG4gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmEIOrTOnzGn8B1DUF1sJVNDJUlL7A5EVSH/IGzo8CGBWNkaIqDTRA5Tl6oe4xHZ1pbsz/GN83gVZ2VlOI7D/8H40WVTlJgi4DvsxLsqxFtzH68WsNcm2dn5WoaAkxZ6lNBXWzQXMYF1K2Zz0rZWEnoaz9PQSbmFqMd00gLbnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT2Cepiq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948021a45so24744405e9.1;
        Fri, 28 Mar 2025 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743187524; x=1743792324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv4obcckIMgIj8vAEDgrTtvOBA95aNakLopowEYoBPk=;
        b=jT2CepiqK46pYLQTIPXyn9YDLkqxfWjeDgix3I4ODXQKL0zV1TkSCFqWss7gW2Dtfi
         qPgzOhib7Cl3AIhpp/CT3rVW8X7UrEi4Zj/O9SNMixJ91NqxrTMfEcOH0VNBZtlwET87
         K0vH1oCWL+dA7TH446+T8j+haaNSA0xv/quE2YyR5hI/+fXpLve9SMtafYakmmjHBS8M
         7vsXcruVW8RAoaMiP+B6fMPtxcjziZtWTv+vr5hxhQUSk3A/qS5ykKOG0Kuu6KTf2oEz
         MntEsyU6s27o3EeX4+AIy1lhfvFXQr6GvT0hD4IcvPjTCAx2vP54ZeCh5o+czQmbjoi/
         6LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187524; x=1743792324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pv4obcckIMgIj8vAEDgrTtvOBA95aNakLopowEYoBPk=;
        b=dMekMwyfVsnBHR7/DhOFbn19Kh7bA5TYj1Ag2qxIjptCMI8nekmU4pY8wBJIQwlGYd
         ZXRSb/ACpiiJE9iIhC/+tAwstXY0THi8KnKn3mZWKGuLt+KV4PJuZICqHE9xUf4zkpDY
         WkP+6+0OJ/eJ/yol5qgBHyaDrtod/fpyUN7Bkgcx+fHeSgJYYe4K6vefzHX2H5BiDZJ5
         QdFCMYyEgEAb3Iaa/YzGQ1qFitBrcCVlM6NwSeU5KKIfvDJy+s8Gqfb7qEUhH48nAttF
         zQutOZKaMoMlYgmmVgxoNdxV98SIuo6ysjh0Krtdo0jXjoAaTS5bMiLRivz/H3RKS8Cw
         jwmw==
X-Forwarded-Encrypted: i=1; AJvYcCV2GTZbBdQhfLekMbLk0RZ9x/ye1YOnhS0JoWZTokdUGu0sJG7oCObBEMYzfDKuozZIeQg=@vger.kernel.org, AJvYcCX7aK1LJC/7apLxBmQORSyXYb/RMMN7oM1kxmx9c5d2ue+7SDPdEe39dVWTQPnoWvcrjiHB8nyN@vger.kernel.org
X-Gm-Message-State: AOJu0YwNB/P1o+9uzhayWtOuoSOA9Zwlcmbq9mfZk4EOrA2kpWRKHoCe
	8xpmIaWpLy4H620YjdRaFy/WOAoGjwhw14mfbXvZdpx1+usezumyTVBAvhVzQXZ2RHBBGRSMg/S
	/8cFmdD1QGUEvO5TbEiyq0tZ/8YA=
X-Gm-Gg: ASbGnctqZ3+vufNKyGYpraYuTzohWA2aC4mDrDwjZobUnFRlCBIyXX9bNXd9wCW4Zk5
	nzV1JXTDBZTSpl9QHLGTWyiC/0Gmc8pPUh6/h/5fndc5Ohhl6KTtNLXJLKFhfFEKzhLKgcl3QKp
	h/NOyl6UVppEy4uqfFbOQjhHtLBJg1ueYUepCwNSwXHyeS/cEAC0wY
X-Google-Smtp-Source: AGHT+IFyGnmq01FY0vYdjQzcrW7fmUD0RP5pkxyNqhytNeXUEYYAG5ibHD6g8NurkU/lZ8xYIaSoBZ/H/rlBD1Fvwvc=
X-Received: by 2002:a05:600c:5108:b0:43c:f629:66f3 with SMTP id
 5b1f17b1804b1-43db624be12mr4594605e9.18.1743187523423; Fri, 28 Mar 2025
 11:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327185528.1740787-1-song@kernel.org> <CAEf4BzagkTArcqnvqgu7kNq31QFsATM36OGPLs4-GFOo0TDxsg@mail.gmail.com>
 <8536CB49-0091-4019-839A-B460847995C2@fb.com>
In-Reply-To: <8536CB49-0091-4019-839A-B460847995C2@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Mar 2025 11:45:11 -0700
X-Gm-Features: AQ5f1Jqy_AJHDe8puoTrgHj1M2MYjACC1XVuYIZoez7xDk7dMtJXSEhEcUypv9A
Message-ID: <CAADnVQ+dbiBVOuPXY6N8EjQh=7wtQt-mCXP3Ujd1xFfD5rLbew@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix tests after change in struct file
To: Song Liu <songliubraving@meta.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 10:57=E2=80=AFAM Song Liu <songliubraving@meta.com>=
 wrote:
>
>
>
> > On Mar 28, 2025, at 10:30=E2=80=AFAM, Andrii Nakryiko <andrii.nakryiko@=
gmail.com> wrote:
> >
> > On Thu, Mar 27, 2025 at 11:55=E2=80=AFAM Song Liu <song@kernel.org> wro=
te:
> >>
> >> Change in struct file [1] moves f_ref to the 3rd cache line. This make=
s
> >> deferencing file pointer as a 8-byte variable invalid, because
> >> btf_struct_walk() will walk into f_lock, which is 4-byte long.
> >>
> >> Fix the selftests to deference the file pointer as a 4-byte variable.
> >>
> >> [1] commit e249056c91a2 ("fs: place f_ref to 3rd cache line in struct
> >>                          file to resolve false sharing")
> >> Reported-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >> tools/testing/selftests/bpf/progs/test_module_attach.c    | 2 +-
> >> tools/testing/selftests/bpf/progs/test_subprogs_extable.c | 6 +++---
> >> 2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/=
tools/testing/selftests/bpf/progs/test_module_attach.c
> >> index fb07f5773888..7f3c233943b3 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_module_attach.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
> >> @@ -117,7 +117,7 @@ int BPF_PROG(handle_fexit_ret, int arg, struct fil=
e *ret)
> >>
> >>        bpf_probe_read_kernel(&buf, 8, ret);
> >>        bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
> >> -       *(volatile long long *)ret;
> >> +       *(volatile int *)ret;
> >
> > we already have `*(volatile int *)&ret->f_mode;` below, do we really
> > need this int casting case?.. Maybe instead of guessing the size of
> > file's first field, let's just remove `*(volatile long long *)ret;`
> > altogether?
>
> I was assuming the original test covers two cases:
>   1) deref ret itself;
>   2) deref a member of ret (ret->f_mode);
>
> Therefore, instead of doing something like
>
>    *(volatile long long *)&ret->f_ref;  /* first member of file */
>
> I got current version.
>
> If we don't need the first case, we sure can remove it.

The idea of the patch was to test the load from the address
returned from bpf_testmod_return_ptr() twice.
Once as that exact value and another with some offset,
since JIT processing logic is different whether insn->off is zero.
Doing &ret->f_lock /* first member of file */
sort-of works, but the comment will be stale eventually.
I think the current fix is the best:
-       *(volatile long long *)ret;
+       *(volatile int *)ret;

This way the load will have guaranteed insn->off =3D=3D 0,
and when file layout changes we will notice the breakage right away.
Like happened this time.

So I'm thinking of applying this patch as-is when bpf-next is ready.

