Return-Path: <bpf+bounces-26328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64E89E5A7
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0CCB222B1
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD0158D97;
	Tue,  9 Apr 2024 22:29:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C246158A2B;
	Tue,  9 Apr 2024 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701776; cv=none; b=fELYEZFvmJCMaymMy5bjDGTcKrUgZgseQK3C0s1Jx19tnpda2nuGXR7wAjIknkI8Ag4eZ3DwTfPFMEM9ZEUC18ojGBYC73GFDblQwkjVfH6j0QBsVOzeNZhjbzyPdVZFQJmr0tqKVKtL/0IOtt8M96XQa77pr1J0w+PaT+/kWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701776; c=relaxed/simple;
	bh=b0H/amPHHksimk86o1QnVAoGtJK2xTBcOHzFeNUPX+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPfDh6+FTpTf8LGczJlIF3JRABY5kEJ8K+dlRgLVDDSCELI41v1Fp4RTN9TkAJSwBuJj5bpKxPbnu1kwwD3o47Vjx/a+08ezvstoJlSEtkFXt1NzRypFt7h/OcACcSfoi7+Ttb32z8Gw37yUx5S/JfixRnZkIg9L3T8L3zZG6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so8151635ad.1;
        Tue, 09 Apr 2024 15:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712701774; x=1713306574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6DTozpE9GkFZUHw98n4xWKR6LXmFpO2uEODuiiWHyU=;
        b=TQAjfWTXW5NH/6VCznnU7E9pxxDyWJ3kCf9qgPRA4x2h1IkPJ1HbcKumLz+dXWsL9h
         HWJXMVclhSM9EsLgl282oSDBEWRTXvmd/aIFQIaB06Rt+VtdxCuGn/aiXtb9ddo8gQP3
         IiowM6D0K8aRNjru24eO9m8NsOyG7g6DKK0flxne6bumaT0uu3duXmdixs5XoM+vJAxf
         apSa5ZvWtwscI2Qiidb3y4vVf0jQttQbDj4jKwJElEfQB7etBI/raXuPwMwDYtag8GK2
         nFSziDIMy+qK2v41e/Wgo1qCElE3nux6ola/7NHCmzrdN1fACuMactB3d8owHXBsZvTe
         GEsA==
X-Forwarded-Encrypted: i=1; AJvYcCURsukU57uOmcxk67IUzsK9MC7pf+IyUWkWNz9Pk52ZejCCKBEs+I5zv/JoSD3L/ur6w4fu3o59QEuSBG3q7Q4/jD/r1vh56mg3GIj8SfpxV/hsVj0+3fweNT4jH48aiTnKA+r+fawOUFSPDkd15lYutGQvEUlyV4BnuyVegO5cdn8FcA==
X-Gm-Message-State: AOJu0YzWoCzDC95KM+NNJei773hPAQSmERLVZT7lss8Cg6JAL2/RsVmB
	CnorDCSZ3H+nl0MG7y4lx2BkUcIx5KSpMSNP8Z/KGKhTNJpqzpfqRCpObIB9+Cp1Q8mtVDOy6Qq
	29Q+kUIn5H4Bjovb1Lyc+YOwLeUk=
X-Google-Smtp-Source: AGHT+IHUa83TqHnJ0da6WQeqT27lQpuAaXPbGxW4kXiHblvJSkibfHnVvMRtFkOGa9Zo+/j9Q0dK08P3R37a4i1Q9ZU=
X-Received: by 2002:a17:902:e944:b0:1e3:e093:b5f0 with SMTP id
 b4-20020a170902e94400b001e3e093b5f0mr1160661pll.8.1712701773667; Tue, 09 Apr
 2024 15:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402184543.898923-1-namhyung@kernel.org> <ZgxgRJdFlwfESwKF@x1>
 <CAM9d7ci7a2dbn1cz-OBkYF7P1fFA3yoBMuTzXRx=KP-yEnyfnQ@mail.gmail.com> <Zgx6mMda_X4pcAj6@x1>
In-Reply-To: <Zgx6mMda_X4pcAj6@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 15:29:22 -0700
Message-ID: <CAM9d7cjegWoDE_q3nNydpdyjCvger0_nGWcNCinSWNiXOepe3A@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Add a missing NULL check
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 2:37=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Apr 02, 2024 at 01:42:05PM -0700, Namhyung Kim wrote:
> > On Tue, Apr 2, 2024 at 12:45=E2=80=AFPM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> > > Are you going to have this merged into perf-tools?
>
> > > A Fixes: tag isn't perhaps needed as it worked in the past?
>
> > Fixes: 1811e82767dcc ("perf lock contention: Track and show siglock
> > with address")
>
> > It was introduced in v6.4 and it should be fine to have this
> > even without the error.  I'll queue it to perf-tools.
>
> ok, better, people trying the tool with a recent kernel will experience
> this, so its the right thing to get it thru perf-tools.

Hmm.. it was not sufficient.  I've got another report of failure on loading
the BPF program.  It seems the verifier treated the NULL check and
the later loading separately.

I'll send v2 soon.

Thanks,
Namhyung


; curr =3D bpf_get_current_task_btf();
264: (85) call bpf_get_current_task_btf#158
   ; frame1: R0_w=3Dtrusted_ptr_task_struct(off=3D0,imm=3D0)
; if (curr->sighand && &curr->sighand->siglock =3D=3D (void *)lock)
265: (79) r1 =3D *(u64 *)(r0 +2624)
   ; frame1: R0_w=3Dtrusted_ptr_task_struct(off=3D0,imm=3D0)
      R1_w=3Drcu_ptr_or_null_sighand_struct(off=3D0,imm=3D0)
; if (curr->sighand && &curr->sighand->siglock =3D=3D (void *)lock)
266: (15) if r1 =3D=3D 0x0 goto pc+5
   ; frame1: R1_w=3Drcu_ptr_sighand_struct(off=3D0,imm=3D0)
267: (b7) r1 =3D 0                      ; frame1: R1_w=3D0
; if (curr->sighand && &curr->sighand->siglock =3D=3D (void *)lock)
268: (79) r2 =3D *(u64 *)(r0 +2624)
   ; frame1: R0_w=3Dtrusted_ptr_task_struct(off=3D0,imm=3D0)
      R2_w=3Drcu_ptr_or_null_sighand_struct(off=3D0,imm=3D0)
269: (0f) r2 +=3D r1
R2 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it first
processed 166 insns (limit 1000000) max_states_per_insn 0
 total_states 15 peak_states 15 mark_read 5
-- END PROG LOAD LOG --
libbpf: prog 'contention_end': failed to load: -13
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
Failed to load lock-contention BPF skeleton
lock contention BPF setup failed

