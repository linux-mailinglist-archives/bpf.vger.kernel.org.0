Return-Path: <bpf+bounces-31259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D498D8B50
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B5C1F24383
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E113B5AF;
	Mon,  3 Jun 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3QYqkXz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66B12DD9B;
	Mon,  3 Jun 2024 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448956; cv=none; b=aq+kKELmj1kr9V0DV9BD4yrwKPv5KWzOQYQCk4A7CrVH8BTPwSH/Q1HTyZuUsBUQEa+Uwe4RsXW2xL67p3M1b/P/rLGqL3xBM8WkCh0l3JFZe+lNLCgGSO/LU/QgT1eHEwiphy9T2M6A/vFaKc2ucVfOQ/8AV8LQJwvQOjJsJ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448956; c=relaxed/simple;
	bh=FYMKuCZBNDGCJKtAN5IjD+OzRu9w9AkloL6NPNOIgJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luxcCxi+fYBEvmvu/RBFk+xGAszf+/URfG9FWscW+NIr0JSLOfLHjFLdWpnqwoACXAxw/1FZ7sHWzdYdjAdctwO6iRg2av7Yx9xRG9wV7vREaFf8im+cYl46bsm7YreAkEgb7L0AuCtCjfrO+Tj0xrx2Q07qcepe5pMLhGpLUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3QYqkXz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c7bf648207so2011443a12.0;
        Mon, 03 Jun 2024 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717448954; x=1718053754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8FuhmBlBhWpMWq8F+ZJQOzO498/a/MW4e39UXkeSyY=;
        b=Z3QYqkXzy0lgIZvm1lZKQOq719pMXP9dtAd458tBGct+dkKB/oG2BfyvJ79HSn+g+7
         Tuf/ttHoO4o6mLOdzph34DCqLhdGWW14d/0wcC4NDIylf6oMubqhl7df3RVo0CkPawjP
         bj1w/LP5GihqoLya4XJ6Sz9T5IU/Ky83l5mYsb8NXd1Wr5F6WRnHngffmn12nbp5ICqb
         ezsqpjIcyD+FWZAI8zHWx/7xlm8zZR9bg9mQqXpWVW1wpRWYSK6jJyQSgRrDQpAh+gRc
         n9pYoRmuZzC3D888yghH47gcf/uYyEAZS5+EkCFJ9EOXLFhV2vKRhdAp1Ucd2JXWtq5T
         133w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717448954; x=1718053754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8FuhmBlBhWpMWq8F+ZJQOzO498/a/MW4e39UXkeSyY=;
        b=kHzhWVtPQvbC5Dx+ZhOUfWQ7OJ5tzBFaCdjeLdespBhNxkAfuRFxRLJ2kn/qNuDQQo
         EKLuyRG3R++7FiAA43+nW+32FTIKSV3/Ix575ffz/Il74WgDp0PKGr9XMYCh+ukyvGro
         f9N5qzh0GGh0Wk+HXA51CF7CoJFtRs/FfIuhmXZVUDBfC8Fju8tQ70WRKsEUN95wGk++
         fdQrBjxNM3o4SxjZwabfHxx6A7wW1bBw3OC3jO6DGJt0UtZdZWUf8SeNzTeRtq+JK6H+
         +iV0jDKvnog70h/ZUbNQNrDoB5ZUU24mRE4DtOJPCPdr2IQ4Pp/mHBzbQk0Ebn5fI/rU
         PDCw==
X-Forwarded-Encrypted: i=1; AJvYcCVD6QcrhqlksowvHeu2iFqqD2ELq//6LUVqSYe2luXvE0R/MNeHh4tagcp0en4ANlv6zysuTZnO/sc8stTcBSqxuh6hAhAbvY5vfa1aO3ESVGwwoOY+JvBoWHzBlDZw0LINO/iOjw==
X-Gm-Message-State: AOJu0YxwPgtmhwd2J9g3sReFPp7DUNxKia3yMp6Dy56KsaJB1eMbnJy0
	FrH6eS8Nyt19q9crjFMYYmc9+EXk60Q7kHJwpyMXQ+b6FWlDAmyfntqOuPx1raWqrU88Oeph7Nl
	wZMEPO5/SHbVIY7NmTt4k2wCFkio=
X-Google-Smtp-Source: AGHT+IFuhoFUoqSTzvg6xQH0NPagQC4ex8JcR5NVISkIk+0LbYt4WFhHfjLE9pCgQaE483MWlyAy+ZeHAd9EYSQudxs=
X-Received: by 2002:a17:90b:a4d:b0:2c1:a77c:6673 with SMTP id
 98e67ed59e1d1-2c1dc5c0e68mr9908568a91.38.1717448954505; Mon, 03 Jun 2024
 14:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522013845.1631305-1-andrii@kernel.org>
In-Reply-To: <20240522013845.1631305-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Jun 2024 14:09:02 -0700
Message-ID: <CAEf4BzZLG43F_phpTFJB7CHZkxJt8es1R_vXT6vpVpyaZnz9gw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix user stack traces captured from uprobes
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, x86@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 6:38=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This patch set reports two issues with captured stack traces.
>
> First issue, fixed in patch #2, deals with fixing up uretprobe trampoline
> addresses in captured stack trace. This issue happens when there are pend=
ing
> return probes, for which kernel hijacks some of the return addresses on u=
ser
> stacks. The code is matching those special uretprobe trampoline addresses=
 with
> the list of pending return probe instances and replaces them with actual
> return addresses. This is the same fixup logic that fprobe/kretprobe has =
for
> kernel stack traces.
>
> Second issue, which patch #3 is fixing with the help of heuristic, is hav=
ing
> to do with capturing user stack traces in entry uprobes. At the very entr=
ance
> to user function, frame pointer in rbp register is not yet setup, so actu=
al
> caller return address is still pointed to by rsp. Patch is using a simple
> heuristic, looking for `push %rbp` instruction, to fetch this extra direc=
t
> caller return address, before proceeding to unwind the stack using rbp.
>
> Patch #4 adds tests into BPF selftests, that validate that captured stack
> traces at various points is what we expect to get. This patch, while bein=
g BPF
> selftests, is isolated from any other BPF selftests changes and can go in
> through non-BPF tree without the risk of merge conflicts.
>
> Patches are based on latest linux-trace/probes/for-next.
>
> v1->v2:
>   - fixed GCC aggressively inlining test_uretprobe_stack() function (BPF =
CI);
>   - fixed comments (Peter).
>
> Andrii Nakryiko (4):
>   uprobes: rename get_trampoline_vaddr() and make it global
>   perf,uprobes: fix user stack traces in the presence of pending
>     uretprobes
>   perf,x86: avoid missing caller address in stack traces captured in
>     uprobe
>   selftests/bpf: add test validating uprobe/uretprobe stack traces
>
>  arch/x86/events/core.c                        |  20 ++
>  include/linux/uprobes.h                       |   3 +
>  kernel/events/callchain.c                     |  43 +++-
>  kernel/events/uprobes.c                       |  17 +-
>  .../bpf/prog_tests/uretprobe_stack.c          | 186 ++++++++++++++++++
>  .../selftests/bpf/progs/uretprobe_stack.c     |  96 +++++++++
>  6 files changed, 361 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uretprobe_stac=
k.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uretprobe_stack.c
>
> --
> 2.43.0
>

Friendly ping. This is a real issue in practice that our production
users are eager to be fixed, please help to get it upstream. Thanks!

