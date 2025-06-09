Return-Path: <bpf+bounces-60089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCFAD2839
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2723B0B8A
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDF9221DB0;
	Mon,  9 Jun 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6DYf9p0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FD207A20
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502655; cv=none; b=PbyfdN1uh3rEAdtblTEJHEE0BFcGstwgblTw8g97cOHyGqkSDUx0gXjKkoFuq0mF83K5fM04AVEKBLRkupdTZtUXecRzBjZzqCKLURMxjxB83k3zzP6Snq05cjKlbolbg7QFrodmifraJSP1ClULisiM4uQYdCOhspC6FpXNJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502655; c=relaxed/simple;
	bh=97pEk7Alokl3lT3etwa57FtI9tBcrsxoW2l7gvgagRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un67OSpRv6KPUb85d+OTgj9ear6EaiG/aHe3dn+sycqqMfcVd9Dpyk3UZOJwH1f2QWXRVBD5ACu6n0RiuSz+QmqloKieOkeQGw+GwpmFL0zh9G+ZK9pTdQAt9f7kJMFDMMV5g/KURHAdi5pVrIerrNO6ULERUqyE5M0KoWToYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6DYf9p0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso4937731a91.3
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749502653; x=1750107453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MBSbUByCXi61Uzy5p8SYW/g9IEEN5kSWnsMlqqWABQ=;
        b=C6DYf9p0hBYRTXmnB4Fu/10EprUHmD1wt039uwakGGCoPByCwkqmtl+CSlIuHhTwOr
         c3wJSRXDDoM/t81GDdk1PDFGLz2pZpMmD1PgFM5VpA60qpKGwLyR+7eW0ZFy5YR2nQM4
         wou25lyGiJLlz3eWeqoQVbHFKJHYxQZAoszFdWKmJ3K5zpmicoHzb+T98Lf/xd4FBsuN
         OWPsSFV1xyUxo6azoMNVhDe1ogrokoG/uJ8Z/30LxEgeOuRbEC+GIL1KUWxu54jDWJ4O
         s46SScpT7RyudxLVkgR7ZnWq87nOO8eXMG5zMp8Hw9Rxx3uVokHfHhOzSGp4E4OffmGR
         rhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749502653; x=1750107453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MBSbUByCXi61Uzy5p8SYW/g9IEEN5kSWnsMlqqWABQ=;
        b=QvzZqvjqM9L1HictCgIEIbjTuP9nFQfqTSazBiED2IelY4xCvpUTqfJW3EZvIGehGB
         Cb3mz4/l7cgT9/O15NqzZvIl+VO6A/TsEHqX+0TOreCz0vAZ1j/M6SxLdjqePeYnngR6
         GQxY5HWZ2fdT5K4QC++NwTMsUr/Yjv/Az19tdcZ2dT48hrlZmkmgV+YjVvCV7lSoejG/
         1ez5WNlrDSTVySdtH3/GaISRl2QddeB6WWLxtdfg3HCD5Y/9Ch5YHKvwG3JJYeFk1xyl
         UHJlQ93+H0faHMhZyrzytS4jrHgLgndfdaftxg33WCMeijOfDgW5jMixxOCRuUZ1wn4G
         A+6w==
X-Forwarded-Encrypted: i=1; AJvYcCXBG3rDcwfKGW9kd0YmLozheitJRBKVJqrfKcPonX2gIub6PSwQFVx2IjRUlsNB18G3Qzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJF8IEbfGoRmX2htH/0KtMvRiDZadnciiktjgDfT/Wdopirr8
	wbpPJQ2jhvg1Yt6BtNVYTEA5H0ptya85rtp4KTvm2BimqFIdPCqPCa10qUK8Y/UpQ9GNIBEewoF
	9QavC1FAeS5bdvW6ta4V2qraWeK5BnAY=
X-Gm-Gg: ASbGncsObHJcI60ng7D52uI69vWYZ0PHbErQTra3SJJnh8CrqxMcc0yLSoK9dH1KdMD
	q1UxlPcZmLBvg69uvLXGOzBkNQZiWdOdFbxP91xfF9KupqX6xDDyxkKZzcmQlBM9maxtlzVqn/u
	3RBt9wAz0GzaLjeXVv7wl+4BfH/W4mMrg2Ud5J0j4aOQ2f7Xc0ftsOYyyYocQ=
X-Google-Smtp-Source: AGHT+IHi7euOZ+j1mT1wGrM9kcneT67iKsEY1lm+oGxsoVcZS4fPh45qdSijTf2pnUlzsyNxnvUvdtTGS+Mn9mkF/bs=
X-Received: by 2002:a17:90b:1dcb:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-3134768d9cbmr20690893a91.28.1749502653084; Mon, 09 Jun 2025
 13:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605230609.1444980-1-eddyz87@gmail.com> <20250605230609.1444980-3-eddyz87@gmail.com>
 <3dd16f19-63a4-4090-abd0-9b84fb07346b@gmail.com> <efe0cc259f70b11ffd3e398441efd0de5aa98c3e.camel@gmail.com>
 <CAEf4BzY2CzZy8DMe==F7OmvEO2gkGG___SaZgu8dGDJd4LG4_Q@mail.gmail.com> <ae7b709f618ecd75214e62f2a300fe2949d9b567.camel@gmail.com>
In-Reply-To: <ae7b709f618ecd75214e62f2a300fe2949d9b567.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Jun 2025 13:57:21 -0700
X-Gm-Features: AX0GCFsJIPZTakQ00KotEuc9ZiMBpW475fCFxhRdd3LjD-tQNGy3avFDUyn-aqc
Message-ID: <CAEf4BzYHvPBcG+eUFh4+Rbhzfw=_937BgCv7ZGKcbABhrjYCZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 1:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-06-06 at 11:19 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > Looking at memory_peak_write() in mm/memcontrol.c it looks reasonable
> > and should have worked (we do reset pc->local_watermark). But note if
> > (usage > peer_ctx->value) logic and /* initial write, register watcher
> > */ comment. I'm totally guessing and speculating, but maybe you didn't
> > close and re-open the file in between and so you had stale "watcher"
> > with already recorded high watermark?..
> >
> > I'd try again but be very careful what cgroup and at what point this
> > is being reset...
>
> The way I read memcontrol.c:memory_peak_write(), it always transfers
> current memcg->memory (aka memory.current) to the ofp->value of the
> currently open file (aka memory.peak). So this should work as
> documentation suggests: one needs to keep a single fd for memory.peak
> and periodically write something to it to reset the value.
>
> ---
>
> I tried several versions with selftests and scx BPF binaries:
> - version as in this patch-set, aka "many cg";
> - version with a single control group that writes to memory.reclaim
>   and then to memory.peak between program verifications (while holding
>   same FDs for these files), aka "reset+reclaim", implementation is in [1=
];
> - version with a single control group same as "reset+reclaim" but
>   without "reclaim" part, aka "reset only", implementation can be
>   trivially derived from [1].
>
> Here are stats for each of the versions, where I try to figure out the
> stability of results. Each version was run twice and generated results
> compared.
>
> |                                    |         |        one cg |     one =
cg |        |
> |                                    | many cg | reclaim+reset | reset on=
ly | master |
> |------------------------------------+---------+---------------+---------=
---+--------|
> | SCX                                |         |               |         =
   |        |
> |------------------------------------+---------+---------------+---------=
---+--------|
> | running time (sec)                 |      48 |            50 |         =
46 |     43 |
> | jitter mem_peak_diff!=3D0  (of 172)  |       3 |            93 |       =
  80 |        |
> | jitter mem_peak_diff>256 (of 172)  |       0 |             5 |         =
 7 |        |
> |------------------------------------+---------+---------------+---------=
---+--------|
> | selftests                          |         |               |         =
   |        |
> |------------------------------------+---------+---------------+---------=
---+--------|
> | running time (sec)                 |     108 |           140 |         =
90 |     86 |
> | jitter mem_peak_diff!=3D0  (of 3601) |     195 |          1751 |       =
1181 |        |
> | jitter mem_peak_diff>256 (of 3601) |       1 |            22 |         =
14 |        |
>
> - "jitter mem_peak_diff!=3D0" means that veristat was run two times and
>   results were compared to produce a number of differences:
>   `veristat -C -f "mem_peak_diff!=3D0" first-run.csv second-run.csv| wc -=
l`
> - "jitter mem_peak_diff>256" is the same, but the filter expression
>   was "mem_peak_diff>256", meaning difference is greater than 256KiB.
>
> The big jitter comes from `0->256KiB` and `256KiB->0` transitions
> occurring to very small programs. There are a lot of such programs in
> selftests.
>
> Comparison of results quality between many cg and other types (same
> metrics as above, but different veristat versions were used to produce
> CSVs for comparison):
>
> |                                    |          many cg |       many cg |
> |                                    | vs reset+reclaim | vs reset-only |
> |------------------------------------+------------------+---------------|
> | SCX                                |                  |               |
> |------------------------------------+------------------+---------------|
> | jitter mem_peak_diff!=3D0  (of 172)  |              108 |            70=
 |
> | jitter mem_peak_diff>256 (of 172)  |                6 |             2 |
> |------------------------------------+------------------+---------------|
> | sleftests                          |                  |               |
> |------------------------------------+------------------+---------------|
> | jitter mem_peak_diff!=3D0  (of 3601) |             1885 |           942=
 |
> | jitter mem_peak_diff>256 (of 3601) |               27 |            11 |
>
>
> As can be seen, most of the difference in collected stats is not
> bigger than 256KiB.
>
> ---
>
> Given above I'm inclined to stick with "many cg" approach, as it has
> less jitter and is reasonably performant. I need to wrap-up parallel
> veristat version anyway (and many cg should be easier to manage for
> parallel run).

As I mentioned in offline discussion, this 256KB jitter seems minor
and is not on the order of "interesting memory usage", IMO. So I'd go
with a single cgroup approach with reset and keep runtime quite
significantly faster. Mykyta is working on a series to further speed
up veristat's mass verification by relying on bpf_object__prepare()
and bpf_prog_load() for each program, instead of re-opening and
re-parsing the same object file all over again. So it would be good to
not add extra 18 seconds of runtime just for creation of cgroups.

FWIW, we can count mem_peak in megabytes and the jitter will be gone
(and we'll probably still get all the useful signal we wanted with
this measurement), if that's the concern.

>
> ---
>
> [1] https://github.com/eddyz87/bpf/tree/veristat-memory-accounting.one-cg
>
> P.S.
>
> The only difference between [1] and my initial experiments is that I
> used dprintf instead of pwrite to access memory.{peak,reclaim},
> =C2=AF\_(=E3=83=84)_/=C2=AF.
>
>

