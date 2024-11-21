Return-Path: <bpf+bounces-45428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D799D566A
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02D11F238EB
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB01CB506;
	Thu, 21 Nov 2024 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcyQRln4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692219F410
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233097; cv=none; b=utte7b7FVipZhzgYsFx2Po0CadLKQjxBXJbvlqVERgVSb/1BIPkc30QhyH66IcAcxDmtZiu+8avAzsQEsw02nXPOkT0xYAyxPvMaTTMkHAkV+DWIQMQ/UkSAkUvdkO1fZTr1YTWwzSpAhTdHpg7nhXcOW8vv6gSuyHyY0cwPGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233097; c=relaxed/simple;
	bh=IvFLfzoC9Ck6HpOvuV+jHCgRa1JJnswlLZ7Z931uo5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQ1tC+iPPe4Z5M00/aUIKrHcDGqslAnBebeFNm4+Yxar7Q5dRhI6ehTBDFmcNdz/e7chHB2lyOPIt0WxUDTMZ5yHdarNPe1VQEpt5ah3arXXrGfhpHI1QRoM7l7yzkcPkBRyM5po5gsMZai/h6nrDhdGkXXLWds6ZtnJBZxtzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcyQRln4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so1953009b3a.1
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732233095; x=1732837895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6li+epEmzmXdvk3itdJEPmhNQxD5/xunMdkTnarzCd0=;
        b=gcyQRln4LlVwxZpf1NJhqH3BAMxKrcqKa1cxqaPKauJyYgyHduMWGjPbNn3cNE4Ax4
         AOzqiUgKaciP8VxR0wPI/KZp7OqnCwxJws6Hu8kHVTjA8UeXs5PdqZ+ghQn0ypDRqbhh
         ijkCmRGJ+OxuDk/CUaPmj8xaO/3TCyD32CN0HjBnYrkfiqVkvuTr76+34U/iQZbOuMme
         x2AfD22LOqcfyAdNKlnlXNMEMSouJpzDKRrsAdvPE9GHdTvYmdlsP3Nay5ptN6FPfMQ2
         dldw696GCbYKPd8sXfaFJsC67CtbGq3P2YKntuxTuVEaSQVj7aqincxOI6iPndhMWnTc
         IGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233095; x=1732837895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6li+epEmzmXdvk3itdJEPmhNQxD5/xunMdkTnarzCd0=;
        b=jvx44gqk/hqhRkNZjziN8VhastXTkgPq7RkelQpFoDGrAMCM0HUvT2J6NlAAQJWT4L
         cBLnKQb8M5W0N7IEt1ToLCwFuGrlkqTqTPeF1Lw3PjNdPWt524lrQmoJQjS2gKHyw4jY
         phcUGmekQ3R2poXZa+YCNx4Kzijz61DglezDI/qRExbpNlDdaLcMbF9qaS8n+OtZasMC
         gkko16ZjvJukcmItkPEbXZNDw8n+m2a3gzmsd2ZkNJc0ZV2tTDfCFAs6di4l4HZ5IDxB
         mTlF8+279zxcF0uhgVEx1RtYjlMSv2eO5R51FiLNWcPUo05H6bi1yNIuZnzo6UuDhJDw
         xlDA==
X-Forwarded-Encrypted: i=1; AJvYcCURajk1tWcnZc84+iGZhvFW+tVrHzYxC7WVfb6g29ZmLT6/DiwW2OvsPRCWM87aAcS7WeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkSw0FykNEpjMWGzYPmL6pk0A+avZhc1kOkrWpghe3t57fdMk
	DZPv7xzgD+a7qHlEkMBL0TYz4JpEXMtQXhAouwPmkqFOJtlw/9j8hRJAp4s89NgVrqKtclT8w7Z
	aNBvDMNVFiyidQHmvC0emmE2A+ts=
X-Gm-Gg: ASbGncvaGkC2E3fAQKTK3KjN4rdBvMyfoEjAQ43AgGkP7wSi4on01s77/poKgwQudBT
	FQFUg08YZLQM4V9sECelM1A5x1/Shc6g4JXx0M1bFSv3QqnM=
X-Google-Smtp-Source: AGHT+IH+lQf1H6/JWHDhqURKbAPxnQSSjvfsc74vMkGEM7JmvKF2fiFBnZ718G3cS1zNcuYEiqt+yrwRqROs4UwXMjQ=
X-Received: by 2002:a17:90b:1c03:b0:2ea:6aa8:c4b7 with SMTP id
 98e67ed59e1d1-2eb0c9de7acmr1632412a91.3.1732233095610; Thu, 21 Nov 2024
 15:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121000814.3821326-1-vadfed@meta.com> <20241121000814.3821326-2-vadfed@meta.com>
 <20241121113202.GG24774@noisy.programming.kicks-ass.net> <482d32d5-2caa-4759-b3b1-765678ac42a2@linux.dev>
 <20241121153334.GN39245@noisy.programming.kicks-ass.net>
In-Reply-To: <20241121153334.GN39245@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Nov 2024 15:51:23 -0800
Message-ID: <CAEf4BzZtph98_qR1CFpj5Fh_wVg=XaZQ75G44dS-oigLExUHSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/4] bpf: add bpf_get_cpu_time_counter kfunc
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko <vadfed@meta.com>, 
	Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>, 
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 21, 2024 at 06:35:39AM -0800, Vadim Fedorenko wrote:
> > On 21/11/2024 03:32, Peter Zijlstra wrote:
> > > On Wed, Nov 20, 2024 at 04:08:11PM -0800, Vadim Fedorenko wrote:
> > > > New kfunc to return ARCH-specific timecounter. For x86 BPF JIT conv=
erts
> > > > it into rdtsc ordered call. Other architectures will get JIT
> > > > implementation too if supported. The fallback is to
> > > > __arch_get_hw_counter().
> > >
> > > Still not a single word as to *WHY* and what you're going to do with
> > > those values.
> > >
> > > NAK
> >
> > Did you have a chance to read cover letter?
>
> Cover letter is disposable and not retained when applying patches, as
> such I rarely read it.

It's not disposable for BPF trees. We preserve them as part of the
merge commit for the patch set, e.g. [0]. Both bpf and netdev
maintainers use a set of scripts to apply patches (pw-apply,
specifically), that does all that automatically.

Vadim,

Please do another careful pass over commit messages and cover letter.
I'd suggest moving the version history into cover letter (see other
multi-version cover letter for an example). You can use an example
from your BPF selftests as an intended use case (measuring the
duration of some BPF piece of logic), and I'd also mention that this
is useful to measure the duration of two related BPF events. E.g.,
uprobe entry and exit, of kprobe entry/exit. kprobe.session and
uprobe.session programs are especially well suited for that, as they
allow to capture initial timestamp, store it in session cookie, then
retrieve it in return probe and calculate the difference.

Please also update all the "cycles" references to "time counter",
stuff like that.

pw-bot: cr


  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/comm=
it/?h=3Dbpf-next-6.13&id=3D379d5ee624eda6a897d9e1f7f88c68ea482bd5fa
  [1] https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/pw.git/

