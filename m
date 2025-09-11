Return-Path: <bpf+bounces-68186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D21B53CD2
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 22:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD021760EC
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 20:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043919D06B;
	Thu, 11 Sep 2025 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNmc2FAa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB372DC784
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620951; cv=none; b=d9r0bmO87rKS5kx/5Q4prHzRRF/pSwsQfUNi6eLJSQ73b6R1KxVhb9/mSzc4icvXHgm3RTE+X/NlS7gr1twjJb5RaK4r6m1sHZUnReoxjAyXBizgwr760axpJ/vyJlX0osAYwxdyfyxjgl7sJCJps+qw4KoWBfWBEG/8151jND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620951; c=relaxed/simple;
	bh=tihjBluIsFj0uMYLQ2J9BU/I73lJXL0/pvOa3EsqY10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLTAvnKVGRdyyyJ9uNTGutHpuyDfRfgZ5hEccMgUAAS24RKVmNAcJgXGo9ONz4J126dHd1aWiuP3i0LloZhwjP1rUla2VAPJKknveQ9fnCs8ykEbc0dF0zbb72mXemvHBENHqaJpmxhcdWX50lfMuEjk9LDjYRJKgQ7mZPJHVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNmc2FAa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e75fb6b2e2so1239801f8f.3
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757620948; x=1758225748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmDtE4iIH6H8nKxoopvw/Ix+3Rg2oLqjjTkOrNuI3Zo=;
        b=nNmc2FAayomt6DHdl4u4PBrrlvtMTfXF0DtqmAP0tT3yLThEcCGLRXrUsxMW6A6WLn
         /vIhxrk9T2xHWMbYPAN4oQsNsUzg+eCaGhKD4fZwhP6gCKRuzfLudv16o5lACBA1Hvs4
         +1nQP4uUzkeZYCP4HMFN9i7n1k863QV4soNz7c2oBNHoWecVbAWQIEzqxHxJ+xjsGNxY
         cbGyAvHAnv4KlbNBjzr5jMlAWowkXWhuNi4FXC27XOXHeToVSF65IF5RweSRzExP0Vx9
         wsbtdvT0ySgFSOOFcT3M1r0SeUKLof+kvuH9vAnVmyTb87935qFs07jNRV92ob2nvEUG
         pAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757620948; x=1758225748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmDtE4iIH6H8nKxoopvw/Ix+3Rg2oLqjjTkOrNuI3Zo=;
        b=pyfkyPn4PAvNydz3/RvpHntv8yqQU1ZGFwj64rt2TqqvnmQA861PwTrnRLjMCQojq2
         yKBo5mtplPGiVOSX/mG/TLababrpsgeCyfLWbSP2YPUo0e7DzfvCHtnPv/GlDVjHTZXp
         lvoPQV4MZmQhanP6G+JIlDZoAMh7AoL6IQEzMwTaA1+J47rPDJELbsYEwEDFR1rd5FyC
         Xo64mN2b09EIjmjAd087leNzsUkuhhaOx/W5LcL+elXpNGPurb/j38UL8p90b9gkySv+
         BezApc/iLEHBNrDu49u7JlYDCUp6L4GxrZBuFDS9ev4oKz1rRAKoqoAkpbD0b6KGroKD
         NBrA==
X-Forwarded-Encrypted: i=1; AJvYcCVrxtI+HkohTLedHxt6DkbPXlQuEZjPF0jRpAk/+aYn/Z2ZCheMEiENi4wA3vc0eew3sLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPwzwdUAO322auQJpiL8JtLO/Sj8DF/o8qJNUagulvPsyAhONU
	WsigvEoss/OG07Kiitq9P9FVFAG9/QdHrPv829FvP5P1pp20H1J/ScAz55Koa4HmxTXwCb9Y4X+
	k9lorvWIWr2MIoyHk8NQJTZWBibteGCs=
X-Gm-Gg: ASbGnctqlcLauwRzDYW18PU5YskFapTZg45k/FOocuKylD8rX0Y+Evmdsl5jvI5be+0
	FriYOU7mA1KPkR9eayZPDlXxE51rd4X+3IrYNn9qlK/bbh/shg72Y3PNEAsG2WZUZY6k//X0swB
	Qb7GEKZwe4RJRniV+wfj2co/SY00V0NlfdmGrTHEpaAjGFBW+nQ30UTSraSr5kMozOc82A2yXPX
	dj7VCSEnDGTKQXbx2MM1TVLyqhPd+6j/A==
X-Google-Smtp-Source: AGHT+IHdGDRmKw669b3TMcx8CxolvS65qa6bmJGpgefInPjZP19eJaGte+Y6Y10aIBFaSggSO4BDmrzmS1IsaVozsxg=
X-Received: by 2002:a05:6000:2389:b0:3e7:632b:e622 with SMTP id
 ffacd0b85a97d-3e765a22d42mr572063f8f.56.1757620948206; Thu, 11 Sep 2025
 13:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911145808.58042-1-puranjay@kernel.org> <20250911145808.58042-7-puranjay@kernel.org>
 <137b87da5a7393602ec77d51cfd6398406cda9fb.camel@gmail.com>
In-Reply-To: <137b87da5a7393602ec77d51cfd6398406cda9fb.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 13:02:14 -0700
X-Gm-Features: AS18NWB3Fj_VHCdgeWjbgOooFPsCSC8Mb9Fc3mQVQkMZ-s9eLmynAvUXZ4MZCqI
Message-ID: <CAADnVQ+UuA_cXBhHxyiW-SSU5N7OYGTtC19JMCcgp-fdQP2Yew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 6/6] selftests/bpf: Add tests for arena fault reporting
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2025-09-11 at 14:58 +0000, Puranjay Mohan wrote:
> > Add selftests for testing the reporting of arena page faults through BP=
F
> > streams. Two new bpf programs are added that read and write to an
> > unmapped arena address and the fault reporting is verified in the
> > userspace through streams.
> >
> > The added bpf programs need to access the user_vm_start in struct
> > bpf_arena, this is done by casting &arena to struct bpf_arena *, but
> > barrier_var() is used on this ptr before accessing ptr->user_vm_start;
> > to stop GCC from issuing an out-of-bound access due to the cast from
> > smaller map struct to larger "struct bpf_arena"
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>
> [...]
>
> > +SEC("syscall")
> > +__arch_x86_64
> > +__arch_arm64
> > +__success __retval(0)
> > +__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
> > +__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
> > +__stderr("Call trace:\n"
> > +"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> > +"|[ \t]+[^\n]+\n)*}}")
>
> Nit: here and in other tests, the regex is a bit hard to read.
>      How wrong would it be to write it down as follows:
>      __stderr("Call trace:")
>      __stderr("bpf_stream_stage_dump_stack+0x{{.*}}/0x{{.*}}")
>      ?
>      (or at-least add a comment).

Applied as-is.
Please send a follow up for this one.

