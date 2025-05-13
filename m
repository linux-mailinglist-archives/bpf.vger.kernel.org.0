Return-Path: <bpf+bounces-58097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C58AB4ACC
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 07:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6156E4665E2
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF21A238D;
	Tue, 13 May 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDBTZMNX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1522EE5
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113397; cv=none; b=YU/gdXIVT1a0MWikjzZ25I3kiGJDR7mT/qVvSgMrBV46aME3hI5rTNKFGhqRfizXk4F9haAHZ7FnxnSW/v1+fhSVo7TTMXQFH+qNeGbUC7Pd4m/Cs2K3MKRWIxHqJVzn0xZqgYTP+tb6JFzB0ySAfwpFatYtc1HI96p+kE8pph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113397; c=relaxed/simple;
	bh=c5HUxrg7Kegh3AYQ/e5T0eSoEA3sbgWkCzX9yuFRjfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIf6SZQOOMLmWTOZ2qR7k1nuRkDkXjaOpDQC02YFXhXTEqZPLOulPM+nN3BiHqqjofd7iya0HJwxD81ndEe9ELIHpQtx14APjdNAIaWYInYSc04wk/1QuN6k+211xSdeZ9FuDsb1YtkSwwlUZhMmACZdIi94uDhd4Oet5wGgx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDBTZMNX; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4def04c0ac1so3062017137.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747113394; x=1747718194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCfkumgiFy0MV3Y8RM+MRJ/wsBqRxVcGXPls3WuSLXc=;
        b=LDBTZMNX4fQ2ZmWnYS8SRx1Z9R6Ukw/25D6p9gQeqDmbwEYnIJqQ+4MIn7RwfCjuNx
         QAJ+H1fwkyqEnbZnSZGrJp6DyJzbzrvRGDuLyoWeKfqgHfQWVsQRUfQFflIBkiiOz1my
         BMKzt5U0K211SpI7iE+97b6Z8RmR5ta9QZ3vKKwsPUiX80LQLxRrqAobvM30nV5GzGzs
         bh953DVcapnHkMegazA71JCSt7s+w4FyUygzub0RtFrPMsObpMCLH2zTveNHB24581OY
         QU1gl/qeRKG8ljWUzB8SKtP/c9RqODttgD+4f9L45O7oy6RsbIPp4U3m+MBYTU3IYJSr
         cStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747113394; x=1747718194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCfkumgiFy0MV3Y8RM+MRJ/wsBqRxVcGXPls3WuSLXc=;
        b=GmzD8Uedgf2cIVtYiqMx0G3Z0RajNeGJ/GEbR2bhNoqVAFk18CGyG6Hjx2V3eVK1qs
         /psgl4CwgFD96NC22ET5Fu8sbhRVODJJFsYJRCvGke6UOolO/FVJo3UNOzo3mHhgB6uc
         WGYP7HuztkxDs8vRqqrw5s9cVitxxa8c0qsmXVhBUZyyH4e8Bf9kCzh3Q08TfGJE0P+h
         248f4P8ROyfhH37KTsIi9zMVu3lMnGr+YnFijnrGKZ9k5uC7SPXOy0tPhc5/a1YGu7BV
         FJOahb8S+xEp9+I8IXPmnkxDuFzqFfmpfVNZ1Z2c0uEVAQ6spgURN4sIDsXVdioGOKXA
         t2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU0rwE4EV/qwV7y9smVkKF1Bim8/g6aqSj7sOJJ2WfzuJo7wNsbg6BBJj+IhVKNXt56L9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZzBqtx3iqTjnMUPtjK6dVBxKZYMt02F0ATSrwa8Lq/rNqAwc
	nlGWTuq+CzyqjdrUtmkKkQB7O50B1eSE/zgGiDvLodtZrwyWlv0If+0TQmY9+AP4PkO73LILAJU
	qmbPnoCwCQruUNDAqJBUuIuIqLJw=
X-Gm-Gg: ASbGncv8UikuLaox+BTN9hHFW9ad1ADj72a3JaFiuV09LdGFL5Cz9jNGVIjTAE3maR2
	NQeeRwyQlFp84WBV/Ixan+tviFUcHScECZ6AF//GjPpq9I+JA08u8UEUxKsBi+Kypd6rLO39Rbs
	m5kCM1/paM3OMn3u9aBKijd+8XvAJmHksLoFv+xR3mueNpHBiWjF171/yM9ESXkMuboA==
X-Google-Smtp-Source: AGHT+IEZGaH+2JEPqKvm2VshJOhFe4566TChu5CBghe5YBTZ4FKUG8/SaSZRwssLtJin7uMnTN1ezpSajrhurTZx3s8=
X-Received: by 2002:a05:6102:3f8b:b0:4da:d874:d333 with SMTP id
 ada2fe7eead31-4df6e420fabmr1694532137.12.1747113394560; Mon, 12 May 2025
 22:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
In-Reply-To: <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 12 May 2025 22:16:23 -0700
X-Gm-Features: AX0GCFuxW7T76WdjJMJl7av7KqizfugMNyW54_XVEWgWhfotBgzMUTzfBrL5LOw
Message-ID: <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 at 17:20, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 12, 2025 at 5:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> >
> > - From verification point of view:
> >   this function is RET_VOID and is not in
> >   find_in_skiplist(), patch_generator() would replace its call with a
> >   dummy. However, a corresponding bpf_spin_unlock() would remain and th=
us
> >   bpf_check() will exit with error.
> >   So, you would need some special version of bpf_check, that collects
> >   all resources needed for program translation (e.g. maps), but does
> >   not perform semantic checks.
> >   Or patch_generator() has to be called for a program that is already
> >   verified.
>
> No. let's not parametrize bpf_check.
>
> Here is what I proposed earlier in the thread:
>
> the verifier should just remember all places where kfuncs
> and helpers return _OR_NULL,
> then when the verification is complete, copy the prog,
> replaces 'call kfunc/help' with 'call stub',
> run two JITs, and compare JIT artifacts
> to make sure IPs match.
>

This is something that we've experimented with last week
https://github.com/sidchintamaneni/bpf/commits/bpf_term/v2_exploration/.
We did the cloning part after `do_misc_fixups` and before
`fixup_call_args` inside
bpf_check().

> But thinking about it more...
> I'm not sure any more that it's a good idea to fast execute
> the program on one cpu and let it continue running as-is on
> all other cpus including future invocations on this cpu.
> So far the reasons to terminate bpf program:
> - timeout in rqspinlock
> - fault in arena
> - some future watchdog
>

Also long running interators, for example -
https://github.com/sidchintamaneni/os-dev-env/blob/main/bpf-programs-catalo=
g/research/termination/patch_gen_testing/bpf_loop_lr.kern.c
Eventhough this is just an example, this could be possible when
iterating through a map which grows unconditionally.

> In all cases the program is buggy, so it's safer
> from kernel pov and from data integrity pov to stop
> all instances now and prevent future invocations.
> So I think we should patch the prog text in run-time
> without cloning.
>

Yes, this is something that we had in mind:
1. Terminate the program on a single CPU
2. Terminate the program on all CPUs and de-link it

Single CPU termination could be useful when a BPF program is using a
per-CPU map and the map on a single CPU grows, causing the iterator to
take a lot of time.

> The verifier should prepare an array of patches in
> text_poke_bp_batch() format and when timeout/fault detected
> do one call to text_poke_bp_batch() to stub out the whole prog.
>
Do you mean creating different versions of patches and applying one of
them based on the current execution state?

> At least on x86 we always emit nop5 in the prologue,
> so we can patch it with goto exit as well.
> Then the prog will be completely gutted.

