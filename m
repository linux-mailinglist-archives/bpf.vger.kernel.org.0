Return-Path: <bpf+bounces-35914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42293FDEF
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314DE1C226F1
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7032189F2C;
	Mon, 29 Jul 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQMu9MyC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23C183084;
	Mon, 29 Jul 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279602; cv=none; b=uvv1/6tNBbfbe6QL+DfhT52o1dMW50v6bXVwcK86TbvlGR8T2jiyx/xjzi3cSyPcftIZkG9qQg9B6JQrFO3jcd03nXPQcYyUNdXCdvWub6LFFrpnYN7c9eMiC7hLv76MX5Jq7hcR4kTDkBH5GRYOr4rZhHMNMaLkuczS6tTGhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279602; c=relaxed/simple;
	bh=OS2Q0eaQxwUwaEzy7Qaccb9D97CFohULH3S1KFza/LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nf9ZJlZ/gdoBB2FMa/xkQKzvrMQLPoPZGh3GluVbhfvsVEcu1Nsg+zcO9WhNhqnRcmqKrGs6jgSSs925y/FuFj6RtSDPYZzEpVVYm9RQi2P5nGMsqNvW7y/LH4FCBkLfUOQK3nreL3lr4xBAbISRECmDN+Rgcv5lv5PZ2HFBwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQMu9MyC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so2261165a91.0;
        Mon, 29 Jul 2024 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722279599; x=1722884399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYmgkteexVKn1NpZoQkkXr8Y+VFVSXunxNQiz4kSIxg=;
        b=BQMu9MyCZQUIVi+MtYgANiwi/LKMwFE318tOdUmETa6R2c4azpXdlnjJ2TdAx8OIM9
         ZnVQo4N1Cjw7yxo03QMtQyu+xHo42EEBmlKiR29ZVLgeko3/vwbKDFuaiJx+dEMJ8Zb/
         DSZew+pSvtXJpl8aWO5ciE4bnhG0dgehY3Q+4aJjhlcwDx4oL20sWc4ocsFag+lMG5mJ
         i8lr5cZQtcJGxOMv5V+vjoJLxCUvmMwZEvOn4/UaRk7/XTrhybQuEdrVi/KongN6ewg3
         KzjzbBiQ1H8kJ9zkiOk7DmvgeLBthkcv1Oz0npIN4gAeyKbOzsvluxyK/k2UcYy1NpAA
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722279599; x=1722884399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYmgkteexVKn1NpZoQkkXr8Y+VFVSXunxNQiz4kSIxg=;
        b=DFLA6lOWUNMFjD1USq0WQuWDJ+DJ2BkUZJwCK3ysjScaFdsjiiiFznG//YkI37Aphf
         vPfrjgjkkPIiZpZir5siQzcBUMpzHQw1b01cTa4Z2Bwnzo5n93USDFS8aa/GUnl2f+FN
         CoGP50MlIJ0vafJOxWVjsbcd9YBPmysW/vBEsniY/OQ4iQtlYAbp66z9lwl+xXD6vcXc
         S6od8+ZQbCear3tOLSNQGdcg6jrhdA5GGNU1MLuUGfp1CBniPtRRmXgaA83q5//cYmK5
         zeOesnbtTDFFb73firASkTo1dmnLiSIhzowRtSPVnEu8oXEdCSqWXlkJrKNNo9GZudKM
         Mx9w==
X-Forwarded-Encrypted: i=1; AJvYcCWF5IjQKn6h2Qk5YA02SobTSFswV5HoDTLVUG0sGZvMeACQFaj+gADuSkMQbVAkD4mwlsMM2DI2WPIkmLtuy0mXP6rhc55h6MYnOEWc9fmZJLLKgfGMgMZz0qMFNJ6W5qy1DrTxW6sVBFhgkG3SYQhOOe2BEfONYh10ZP2CiTpys8W76Q==
X-Gm-Message-State: AOJu0YzGsLG1+6KBxIddbzWoxqbawpaQn66t8RWLm0fq8gsqjFS67Xe9
	46rsWosVeruRXcxYZ56O1di3jLWp+Ksd1hsvwp8vodKqpds8aKzb705KFhX3mvW4xksjf2Z1VhS
	dIetKle1Ziqlj0oBbl0C7gwfJ9jE=
X-Google-Smtp-Source: AGHT+IFw+95qsHNnGa7Yog9d459Xn8FUFbux2KHIpK30TSGKAACwQyhLb5IBgclvIxrxSdS4A10ZVUPVSTdi/XHKTB8=
X-Received: by 2002:a17:90a:bb83:b0:2c9:888a:7a7b with SMTP id
 98e67ed59e1d1-2cf7e1ffa35mr6784573a91.25.1722279599093; Mon, 29 Jul 2024
 11:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
 <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
 <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com> <ZqfXd0FKtXCJ5dwH@ghost>
In-Reply-To: <ZqfXd0FKtXCJ5dwH@ghost>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 11:59:47 -0700
Message-ID: <CAEf4BzZ9B=CPuti9smOqDKD1dRvs3Ug7h9pHupr6jFeKEppJ4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] libbpf: Move opts code into dedicated header
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:55=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Mon, Jul 29, 2024 at 10:01:05AM -0700, Andrii Nakryiko wrote:
> > On Mon, Jul 29, 2024 at 9:46=E2=80=AFAM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  tools/include/tools/opts.h      | 68 +++++++++++++++++++++++++++++++=
++++++++++
> > >  tools/lib/bpf/bpf.c             |  1 +
> > >  tools/lib/bpf/btf.c             |  1 +
> > >  tools/lib/bpf/btf_dump.c        |  1 +
> > >  tools/lib/bpf/libbpf.c          |  3 +-
> > >  tools/lib/bpf/libbpf_internal.h | 48 -----------------------------
> > >  tools/lib/bpf/linker.c          |  1 +
> > >  tools/lib/bpf/netlink.c         |  1 +
> > >  tools/lib/bpf/ringbuf.c         |  1 +
> > >  9 files changed, 76 insertions(+), 49 deletions(-)
> > >
> >
> > Nope, sorry, I don't think I want to do this for libbpf. This will
> > just make Github synchronization trickier, and I don't really see a
> > point.
> >
> > I'm totally fine with libperf making a copy of these helpers, though
> > (this is not complicated or tricky code). I also don't think it will
> > change much, so there is little risk of any sort of divergence.
>
> I did this because there were two comments on the previous version of
> this patch that asked to change the functions that were copied over.  I
> had a couple of choices, have the implementations diverge, not change
> the implementation in perf to keep it the same as bpf, update both perf
> and bpf, or share the implementations. I figured the last option was the
> best to avoid immediate divergence. However, both of the comments can be
> safely ignored, and also perhaps divergence doesn't matter.
>

I mean, feel free to diverge. First and foremost the code has to make
sense to specific library and specific use case. If libperf has some
extra things that it needs to enforce or check, by all means. I just
want to avoid unnecessary code sharing, given the code isn't tricky or
complicated, but will complicate libbpf's sync story to Github (libbpf
kind of lives in two places, kernel repo and Github repo).

> - Charlie
>
> >
> > [...]

