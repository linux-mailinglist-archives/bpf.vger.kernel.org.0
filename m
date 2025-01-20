Return-Path: <bpf+bounces-49302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA745A1732A
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 20:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24487A1D5A
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46311EF080;
	Mon, 20 Jan 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIwVh5oV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E91E0E0A;
	Mon, 20 Jan 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401915; cv=none; b=dkBQzSl8dmoC2zcRft2QEySluX5w6qVVj5+sSbkoNgnULKtKOsMvoXvTQK99PzYo9DO44N0S+DPElaZhwfONrVo3BqJSc8GXpuCbs9yWkYYvbAPz/uD+lf2+UnrjSbMUTjOXIRxrh606gqaTGD3rMfRBlxyZTHd/awxqbJLviLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401915; c=relaxed/simple;
	bh=hCiTDY9p2mC6HnGNKEiiWj1yGRANEYtrWVV8XN6GX08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu6wXriDVxjAPnOQMe44oC2EfaaI5AAP7sjT+wU3w0VICUq1MKw59bE8ZWEmKXx3ARzhU6AN86Tvwm+bd1uiyWEeCs//kNywBCacIn7oJiiTLIiCNVEWTAxcJjtXPYHF/r+zg5dMoM6ERuotKBEkjQnFPsrRGnvRIJDAmyAs9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIwVh5oV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2408836f8f.1;
        Mon, 20 Jan 2025 11:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737401912; x=1738006712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUt8rTj6Pr+3J1WmHyNNJqz+pMlZbI69TQHH8GRp3Dw=;
        b=cIwVh5oViCs0tGkEZDi56j6iWqmWUtT99pjxQwmM6zuM1QG84g1z/k+O8WQO2dExl2
         /HNDPyz8DbAVFzbboEJydgjCm4HKv5bUK8Tqw01Rvjg9Fju6oNnoO+U1RY2AqXaQP1Dk
         ntgdVxIkW7RagTDS5U0uNHf8s1o0mW7JMD2wsC65FcsiTAs/cxeQ0HQXynJ8PEbKfHLt
         j/tJ3fl0jxwFDDgas934wBs2kRrZOArl+ErYEccf5+2vd5KoI1bLhoKxXtbBYJRNiBeK
         CFAha7EpG4MaileB7RMrph737+mpoJeSZrrRjavGWWUktjAtGhuWf0wpwA8Hd5P1tSsk
         8q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737401912; x=1738006712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUt8rTj6Pr+3J1WmHyNNJqz+pMlZbI69TQHH8GRp3Dw=;
        b=b6nGFNZhNEU1We0JJzT991dl7G5IxpfetLZIeoYeIxRYar/cljqY3Rn8NGbDvw0JvY
         a03UY2P7Gupwf9MEjXQecZ5HZWNe3ndlID46sy3pFeUaxlJxLs/BbMwCxvGQExWBMulo
         Zp14JPpajYOeT4w4UkPQ5kn8Sl+bbVqhuwjTCzjnMMxFsTauKqNaKVeKp4x24Ph6Lugp
         lze2/QZqV5B8fLIGlzJdJIce0uUssWdhGWz99QazWogNJPre3KwnUq5mQHP23dj99Mel
         DPe+KEjPLOShb1aAeEau8SDXBknuWtwaGqpfefCw0JD0IfKjE971i1JG2xbCL9IfxtPK
         0KpA==
X-Forwarded-Encrypted: i=1; AJvYcCWZtgM/gJUh9RlKYmVLXNsFT4aLNJ8hmk9kEhkhp9smflOgZX5OCKF91N6xNEc+1zKuuIs=@vger.kernel.org, AJvYcCX4gwUefB0UMG2Cyec1/diO8VFIflmswL7zEI6jYWBeezEsN+M0xMU5Glud1wCUrUvxiTi8cRReeBGgFouH@vger.kernel.org
X-Gm-Message-State: AOJu0YwxuuV2HkiC95oU3Hcew49yrMpPpOaOCz0voAvJVUMyNszN0mw8
	q/EabC2hmn1dJXFLQ0ko3FKzs3oBgzPmIoNVRTU3Q7tpCNWd+2YdQlZZZ8uCqw5zCGAykFQ9g5Y
	29f6/0JCYpiaQm+nZNifKk0xp3MM=
X-Gm-Gg: ASbGnctcpfAZkPB4gLKhUuSuXDT+7auKQSOoPRJwWTc9cjXLk5xoswMZvBzRMemMf8u
	H/dKrHfGoiRPb5iNq/ZV1Mn9WliQgmXPHhB9Y4EF2c5ZzyJdKgRP2QeGN43U4MF1SHbI=
X-Google-Smtp-Source: AGHT+IGVvm0LksI8PU6KzU80/3rY69veGh7Xit+qNWVVlR5RughH0y/oU2tLhycJ8CTyv7K8pIWFwgDiZUhCoFb/Ieg=
X-Received: by 2002:a05:6000:1b82:b0:385:e3b8:f331 with SMTP id
 ffacd0b85a97d-38bf5663bd7mr11312829f8f.14.1737401911504; Mon, 20 Jan 2025
 11:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119153343.116795-1-leo.yan@arm.com> <ee0b3bb3-476b-4792-84e1-c53fa4dbabee@iogearbox.net>
 <20250120185033.GA261349@e132581.arm.com>
In-Reply-To: <20250120185033.GA261349@e132581.arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Jan 2025 11:38:18 -0800
X-Gm-Features: AbW1kvYJHsv4t4rsgec8Hwcw4bK5Q6oYG4AecNARzWM_oFJ2tapPe02VZ3cLB_g
Message-ID: <CAADnVQKrOi1cJrFUXuwacmbWCxR-oKRr_tTiyQJP0=jvnkXO3A@mail.gmail.com>
Subject: Re: [PATCH v1] samples/bpf: Add a trace tool with perf PMU counters
To: Leo Yan <leo.yan@arm.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, James Clark <james.clark@linaro.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 10:50=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Daniel,
>
> On Mon, Jan 20, 2025 at 05:18:23PM +0100, Daniel Borkmann wrote:
> >
> > Hi Leo,
> >
> > On 1/19/25 4:33 PM, Leo Yan wrote:
> > > Developers might need to profile a program with fine-grained
> > > granularity.  E.g., a user case is to account the CPU cycles for a sm=
all
> > > program or for a specific function within the program.
> > >
> > > This commit introduces a small tool with using eBPF program to read t=
he
> > > perf PMU counters for performance metrics.  As the first step, the fo=
ur
> > > counters are supported with the '-e' option: cycles, instructions,
> > > branches, branch-misses.
> > >
> > > The '-r' option is provided for support raw event number.  This optio=
n
> > > is mutually exclusive to the '-e' option, users either pass a raw eve=
nt
> > > number or a counter name.
> > >
> > > The tool enables the counters for the entire trace session in free-ru=
n
> > > mode.  It reads the beginning values for counters when the profiled
> > > program is scheduled in, and calculate the interval when the task is
> > > scheduled out.  The advantage of this approach is to dismiss the
> > > statistics noise (e.g. caused by the tool itself) as possible.
>
> [...]
>
> > Thanks for this work! Few suggestions.. the contents of samples/bpf/ ar=
e in process of being
> > migrated into BPF selftests given they have been bit-rotting for quite =
some time, so we'd like
> > to migrate missing coverage into BPF CI (see test_progs in tools/testin=
g/selftests/bpf/). That
> > could be one option, or an alternative is to extend bpftool for profili=
ng BPF programs (see
> > 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")).
>
> Thanks for suggestions!
>
> The naming or info in the commit log might cause confuse.  The purpose
> of this patch is to measure PMU counters for normal programs (not BPF
> program specific).  To achieve profiling accuracy, it opens perf event
> in thread mode, and support function based trace and can be userspace
> mode only.
>
> My understanding for bpftool is for eBPF program specific.  I looked
> into a bit the commit 47c09d6a9f67, it is nature for integrating the
> tracing feature for eBPF program specific.  My patch is for tracing
> normal userspace programs, I am not sure if this is really wanted by
> bpftool.  I would like to hear opinions from bpftool maintainer before
> proceeding.
>
> My program mainly uses eBPF attaching to uprobe.  selftest/bpf has
> contained the related functionality testing, actually I refered the
> test for writing my code :).  So maybe it is not quite useful for
> merging the code as a test?
>
> If both options are not ideal, I would spend time to land the
> feature in perf tool - the perf tool has supported eBPF backend for
> reading PMU counters, but it is absent function based profiling.

We don't add tools to kernel repo. bpftool is an exception
because it's used during the selftest build.
'perf' is another exception for historical reasons.

This particular feature fits 'perf' the best.

