Return-Path: <bpf+bounces-52799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF746A488E4
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 20:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5583A792C
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7210326F46F;
	Thu, 27 Feb 2025 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4phlsC9p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5E26E649
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684035; cv=none; b=A7xtvQGO+/9JwBLS+tHNh6z5VkWk79gDi1bi/qm5s9q+11F5GFoFZS+LhV38lTPKpkys16LLY8xnJ+H2O3pTCddLQaHLX3HikkMF7Ubwq46HLA6sIOAeOy+dmt7pZZQyVn8maXWjfvpYEWCXo/gWY2Q+EsM2UR9+1HbM/pEMne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684035; c=relaxed/simple;
	bh=muK8R3PeeACTdWi+w57NbgOslHk1vi9AUhjFPQAv4zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pq3ZOVNfKfZPHuBInjzN6RsQwunEOGPAInxM9vMB5p3HBmCWw0hPr9H9/ANkQQg3agZQDNdJfqzeJjPHgYBHskEqBdlL1K/mVwy+O2yonNFy9ZbZi2DW02IZw+WUyT3QqUGcEIL5cM5kjBD/fJ8NcvdnSFf+3fkZhL7stLlcHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4phlsC9p; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbdf897503so425969666b.0
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 11:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740684030; x=1741288830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI22PJCjE69u15jcF6DMx11ran9huIwFOHAPNY3ci2c=;
        b=4phlsC9pVgM98GF5mIqwNtcI6haaDGJDKfizpwwlXoN9o737UEiMH229exg4pqNNnB
         FtdCFObtPQIPHErw3O69ZlIYBxWS0kps2c+3UKqBRc+WEdGWB4NyCfG75u1DiVBi5XBg
         D0Ge78gHES9684cTEPxfSvD+3xNDd5mWjhGk0F2PvkNCgQL7JMj9otBSZTSXbdbeQcAr
         M7U5JOmQxPs9/nMmGKQ8yHqUw2USo3R8gddJwu8+rwDC6K01yvtPIBD78aVToOyqawVA
         uqf5pON2CF9R7iEK/YwtY+tbRy1mSVunm3jJWmf6Wl7P97DzjUrMb7LCwpAucS8xhHiv
         gEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684030; x=1741288830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI22PJCjE69u15jcF6DMx11ran9huIwFOHAPNY3ci2c=;
        b=B+BkLqkTjvW+Fc1meB0ew/6d4HBI2LBB8rL4g9hF6a7+U+wD2dOtuU+qbc7besozYl
         rULYsOclswnxsQfHtddUdtLc/nz4EgOQh0Jk7ffrTwdaeqcEEb8l+6/HlF0Lq35UzLMn
         uip75MFZJs7i4tjDIxkWETeU/bSm0qhGz+5ELenYPcAM9HynvkBk2e/Lh7x/VguxthFf
         bDMJDP41B0wFEeM6Q6mScciBwcmZb5sp3WsYbnaxvV5Vw+uIrc3bT7PAyhVFjWdw+bk1
         7ap1Sf0pL/QMsH6g2AWmnkyXp04ECyXELF91xhKmQ2XwcBY393k8AwtH5LuubuWyZypy
         yypw==
X-Forwarded-Encrypted: i=1; AJvYcCUOUffKxQepzGrkQCaK2hIy7AwMzerz/GbykH+/B7Cb5eGYcnb+UXOaDuaPEcYyMy1n+e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBsO/duumOI4W4ZcehZQcqeQ7uY949wKguC/18oPfVSSGgYDz
	rMztqNFglQwPbm7rkU4kCLy5MyeUMDpkSC+Weoy85nCezl+qWuDz+x+cgMxocPEw1bM5f75ZNte
	lCwmWGjXOlfzj1amwA038rpOvGSe0826g1sZI
X-Gm-Gg: ASbGncuz9OGPZuapPmlroyGWbP+eTKRDOGNA6/m1+PeLQAGAtQGj51/2vBW4nux/MN1
	Af+Eb/SGh7wEe5wMSIWuVgPDbUWsRARTYChDYNVVv7YwOa9ivzE35gPdumNLsLT1u3/twLGhzrf
	Dtt9JJQKl3U62+x0J0yZ3pE30x4vmZtJdVSxXpSlE=
X-Google-Smtp-Source: AGHT+IGAaEwnUOTxtjRJRgNU0Z7h1s0Z2DCfs0P6hAUc2eXS3R+/ssd58Ppp0FCTMZtMZ97KafEUW2W/8pRABGN1kAA=
X-Received: by 2002:a17:907:9723:b0:ab7:ca6d:171e with SMTP id
 a640c23a62f3a-abf2642f5d4mr62483366b.7.1740684030160; Thu, 27 Feb 2025
 11:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227003359.732948-1-ctshao@google.com> <EB79B75A-896E-42B6-B206-314BA137E257@linux.ibm.com>
In-Reply-To: <EB79B75A-896E-42B6-B206-314BA137E257@linux.ibm.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 27 Feb 2025 11:20:18 -0800
X-Gm-Features: AQ5f1JqstDaQClrlkYVyUTD4KjucpdQq68IUyRhBPNfGp0EuxpQ4ZtKJXQSNAj0
Message-ID: <CAJpZYjUvaXfmvMH5FjpAUSj4EiEgbMd4CyOobPXKoDhpzknvJQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Tracing contention lock owner call stack
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, nick.forrington@arm.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Athira!

On Thu, Feb 27, 2025 at 3:11=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 27 Feb 2025, at 5:58=E2=80=AFAM, Chun-Tse Shao <ctshao@google.com> w=
rote:
> >
> > For perf lock contention, the current owner tracking (-o option) only
> > works with per-thread mode (-t option). Enabling call stack mode for
> > owner can be useful for diagnosing why a system running slow in
> > lock contention.
> >
> > Example output:
> >  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex -E16 perf bench=
 sched pipe
> >   ...
> >   contended   total wait     max wait     avg wait         type   calle=
r
> >
> >         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_=
read+0x57
> >                          0xffffffffac6318e7  pipe_read+0x57
> >                          0xffffffffac623862  vfs_read+0x332
> >                          0xffffffffac62434b  ksys_read+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >          36    193.71 us     15.27 us      5.38 us        mutex   pipe_=
write+0x50
> >                          0xffffffffac631ee0  pipe_write+0x50
> >                          0xffffffffac6241db  vfs_write+0x3bb
> >                          0xffffffffac6244ab  ksys_write+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           4     51.22 us     16.47 us     12.80 us        mutex   do_ep=
oll_wait+0x24d
> >                          0xffffffffac691f0d  do_epoll_wait+0x24d
> >                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
> >                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           2     20.88 us     11.95 us     10.44 us        mutex   do_ep=
oll_wait+0x24d
> >                          0xffffffffac691f0d  do_epoll_wait+0x24d
> >                          0xffffffffac693943  __x64_sys_epoll_wait+0x73
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           1      7.33 us      7.33 us      7.33 us        mutex   do_ep=
oll_ctl+0x6c1
> >                          0xffffffffac692e01  do_epoll_ctl+0x6c1
> >                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           1      6.64 us      6.64 us      6.64 us        mutex   do_ep=
oll_ctl+0x3d4
> >                          0xffffffffac692b14  do_epoll_ctl+0x3d4
> >                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >
> >  =3D=3D=3D owner stack trace =3D=3D=3D
> >
> >           3     31.24 us     15.27 us     10.41 us        mutex   pipe_=
read+0x348
> >                          0xffffffffac631bd8  pipe_read+0x348
> >                          0xffffffffac623862  vfs_read+0x332
> >                          0xffffffffac62434b  ksys_read+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >  ...
> >
> > v8:
> >  Fix compilation error found by Athira Rajeev and Namhyung Kim.
>
> Tested with v8 and compiles fine, thanks for addressing the issue.
>
> Tested-by: Athira Rajeev <atrajeev@linux.ibm.com>
>
> >
> > v7: lore.kernel.org/20250224184742.4144931-1-ctshao@google.com
> >  Remove duplicate contention records.
> >
> > v6: lore.kernel.org/20250219214400.3317548-1-ctshao@google.com
> >  Free allocated memory in error patch.
> >  Add description in man page.
> >
> > v5: lore.kernel.org/20250212222859.2086080-1-ctshao@google.com
> >  Move duplicated code into function.
> >  Remove code to retrieve undesired callstack at the end of `contention_=
end()`.
> >  Other minor fix based on Namhyung's review.
> >
> > v4: lore.kernel.org/20250130052510.860318-1-ctshao@google.com
> >  Use `__sync_fetch_and_add()` to generate owner stackid automatically.
> >  Use `__sync_fetch_and_add(..., -1)` to workaround compiler error from
> >    `__sync_fetch_and_sub()`
> >  Remove unnecessary include headers.
> >  Dedicate on C-style comment.
> >  Other minor fix based on Namhyung's review.
> >
> > v3: lore.kernel.org/20250129001905.619859-1-ctshao@google.com
> >  Rename/shorten multiple variables.
> >  Implement owner stackid.
> >  Add description for lock function return code in `contention_end()`.
> >  Other minor fix based on Namhyung's review.
> >
> > v2: lore.kernel.org/20250113052220.2105645-1-ctshao@google.com
> >  Fix logic deficit in v1 patch 2/4.
> >
> > v1: lore.kernel.org/20250110051346.1507178-1-ctshao@google.com
> >
> > Chun-Tse Shao (4):
> >  perf lock: Add bpf maps for owner stack tracing
> >  perf lock: Retrieve owner callstack in bpf program
> >  perf lock: Make rb_tree helper functions generic
> >  perf lock: Report owner stack in usermode
> >
> > tools/perf/Documentation/perf-lock.txt        |   5 +-
> > tools/perf/builtin-lock.c                     |  56 +++-
> > tools/perf/util/bpf_lock_contention.c         |  85 +++++-
> > .../perf/util/bpf_skel/lock_contention.bpf.c  | 245 +++++++++++++++++-
> > tools/perf/util/bpf_skel/lock_data.h          |   7 +
> > tools/perf/util/lock-contention.h             |   7 +
> > 6 files changed, 372 insertions(+), 33 deletions(-)
> >
> > --
> > 2.48.1.658.g4767266eb4-goog
> >
> >
>

