Return-Path: <bpf+bounces-44541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC3B9C4621
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEAC28356F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6E2AEE0;
	Mon, 11 Nov 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwSCkS3g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936A13B58A
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354410; cv=none; b=Jk116iJbkPcLhab4FN59qKJ6pXC0xl/ulmLt5AZCs2jRc/ePvmaOD+IbO36/0VtJJylN8BewzPqkJsqw8fN6RkJ/CG0TyFgqAljEjrvLefsj6itnNWpGWiDPbVvz1RovQdo1RGM+HBGBtZTv2D5p6lhaKe1fcyWHMs77kOBj2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354410; c=relaxed/simple;
	bh=SVD/D1neY/VMzCUafgxPxYWWoSXIv9EEnzkncaGe/f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt6cyUaP9mg3aisYnYIFuC/Bads2zcsjr/A9ZjLalpYIsV/m13jyNcIo2Op5BAVpERgMqaHDFJB7cMIPkTT8InUUnpIAPT9U9VCTjXfiHbA6DkRcG+WvIStPTSxg13WCFQD8oVO7n8xrfrLMp7j7r/0rePrSYNZkztLqrjOH62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwSCkS3g; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c87b0332cso31975ad.1
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731354408; x=1731959208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb/lRtOScrkbHEVqeEiNru9i+NEX9M9BCRiwMog+ERw=;
        b=MwSCkS3gWyEZWgTrC0O8WdnNURPdIQN+4foMKL5wkrt7g8uh5KUB0Ew0LFrmy787Tz
         4P1YMXL1+tbU8XIQFZT73RcNGk6Cl9OxvkfwehpdWQ8+EtcaAVwc5hbqjGwxB3BDXyPE
         +tmrlgvgaloHgwdpQB9zhpxK3GBri/7DyjV4U/o3yL2fby2t6SSpjkkaGgoyB1rmtrWC
         cu3dfQjHWPTi182oaARP3xGr2NW/8Yt0AUW5PRL5gNNszq4wFyg24HhwJGA8ukGf4DiT
         6UypoFodUDAy+Bo4S24O+HGluFj7qVWQuVwflWpGy38rpMcltnP1YcT1ZC85YPsji5IU
         qNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354408; x=1731959208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb/lRtOScrkbHEVqeEiNru9i+NEX9M9BCRiwMog+ERw=;
        b=PgM/GPscyura66HneCghUHsN6mk9P86xQP9eIL5W/tsffVhdrrH4onlh6q8BiI4oZ4
         Qm3KFXK0a+xtVgMXE9FSarcHKNupqIgIQuSE+SLnfVAGRlaCxu70vUrD5ojU1K9Zvf7a
         f3Pcn9ZPVNKtLpI9eog1J0M/dYN540PhQRn7x1rwCpGZyZxOiIecf45O6g8ncLZIsYF8
         6Ja0yqlfaMnR4WywLOWqSRwijLMMIoVGQ15cuZcidxDiVXBMlrXGsH1fABrab0ae9dOR
         nNcsixYJoWqb0JIM4YQDp38TWe+zh2fw75SYsCMwTV1JNQ9GCYafkbSHajBCVNDsFkGL
         DV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEyWNaPrgDjQ7kHr8PAPssH8ChnOr450Dz60On+qMUfnGigSvZRRG3CRng2+u3tS+VeDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2M/RvRJ1JNExReOHZWPxsPteEOXV8PQ1DoB7GkvMbSWWCuVe
	/xi0nzWiGYYbeLPIu/NdvArpe6Yle4tvib6pb6KjI68c5l2ess8O2IJBMfEkB4d2XCgt0jjBVg4
	X2zUQsYTzWY3s0JJy5xLn53boMjslLuYMTaZa
X-Gm-Gg: ASbGncs6eAJEp0aILYqa6k7rwpwFvOOE1QwqO05f+MGOMa90qWUVokPeIvgW4K4m05d
	iF6SoELjGEuJsgJ/xY4EeQjrq/Kb+X2lF9c6gVpyeCUS8GnMqmgr7RAENTNJ6sB8=
X-Google-Smtp-Source: AGHT+IG3Voeoea9hH7MagKOMnVkHeysRZ87ScGQtbCyWe5pD36B+XNBUQSB/AHysZ4FWUFGnwuCGsdWTmHyzBa4M8Q4=
X-Received: by 2002:a17:902:e541:b0:20c:79f1:fee2 with SMTP id
 d9443c01a7336-211ab6fd382mr58045ad.10.1731354408310; Mon, 11 Nov 2024
 11:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108061500.2698340-1-namhyung@kernel.org>
In-Reply-To: <20241108061500.2698340-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 11:46:37 -0800
Message-ID: <CAP-5=fWqE6bM=MVQy7P0tTSWW-ZBXY4in_bfQYFK-C4h6L-Ykw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf lock contention: Symbolize locks using slab
 cache names
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This is to support symbolization of dynamic locks using slab
> allocator's metadata.  The kernel support is in the bpf-next tree now.
>
> It provides the new "kmem_cache" BPF iterator and "bpf_get_kmem_cache"
> kfunc to get the information from an address.  The feature detection is
> done using BTF type info and it won't have any effect on old kernels.
>
> v2 changes)
>
>  * don't use libbpf_get_error()  (Andrii)
>
> v1) https://lore.kernel.org/linux-perf-users/20241105172635.2463800-1-nam=
hyung@kernel.org
>
> With this change, it can show locks in a slab object like below.  I
> added "&" sign to distinguish them from global locks.

I know the & is intentional but I worry it could later complicate
parsing of filters. Perhaps @ is a viable alternative. Other than
that:

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>     # perf lock con -abl sleep 1
>      contended   total wait     max wait     avg wait            address =
  symbol
>
>              2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498 =
  &task_struct (mutex)
>              1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538 =
  &task_struct (mutex)
>              4      1.12 us       354 ns       279 ns   ffff9d5e841ca800 =
  &kmalloc-cg-512 (mutex)
>              2       859 ns       617 ns       429 ns   ffffffffa41c3620 =
  delayed_uprobe_lock (mutex)
>              3       691 ns       388 ns       230 ns   ffffffffa41c0940 =
  pack_mutex (mutex)
>              3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0 =
  text_mutex (mutex)
>              1       409 ns       409 ns       409 ns   ffffffffa41b4cf8 =
  tracepoint_srcu_srcu_usage (mutex)
>              2       362 ns       239 ns       181 ns   ffffffffa41cf840 =
  pcpu_alloc_mutex (mutex)
>              1       220 ns       220 ns       220 ns   ffff9d5e82b534d8 =
  &signal_cache (mutex)
>              1       215 ns       215 ns       215 ns   ffffffffa41b4c28 =
  tracepoint_srcu_srcu_usage (mutex)
>
> The first two were from "task_struct" slab cache.  It happened to
> match with the type name of object but there's no guarantee.  We need
> to add type info to slab cache to resolve the lock inside the object.
> Anyway, the third one has no dedicated slab cache and was allocated by
> kmalloc.
>
> Those slab objects can be used to filter specific locks using -L or
>  --lock-filter option.  (It needs quotes to avoid special handling in
> the shell).
>
>     # perf lock con -ab -L '&task_struct' sleep 1
>        contended   total wait     max wait     avg wait         type   ca=
ller
>
>                1     25.10 us     25.10 us     25.10 us        mutex   pe=
rf_event_exit_task+0x39
>                1     21.60 us     21.60 us     21.60 us        mutex   fu=
tex_exit_release+0x21
>                1      5.56 us      5.56 us      5.56 us        mutex   fu=
tex_exec_release+0x21
>
> The code is available at 'perf/lock-slab-v2' branch in my tree
>
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf lock contention: Add and use LCB_F_TYPE_MASK
>   perf lock contention: Run BPF slab cache iterator
>   perf lock contention: Resolve slab object name using BPF
>   perf lock contention: Handle slab objects in -L/--lock-filter option
>
>  tools/perf/builtin-lock.c                     |  39 ++++-
>  tools/perf/util/bpf_lock_contention.c         | 140 +++++++++++++++++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  70 ++++++++-
>  tools/perf/util/bpf_skel/lock_data.h          |  15 +-
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   8 +
>  tools/perf/util/lock-contention.h             |   2 +
>  6 files changed, 267 insertions(+), 7 deletions(-)
>
> --
> 2.47.0.277.g8800431eea-goog
>

