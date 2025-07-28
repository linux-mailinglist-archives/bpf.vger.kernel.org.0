Return-Path: <bpf+bounces-64528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA5B13D59
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D11A3A8257
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3B225D53B;
	Mon, 28 Jul 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxiGvI90"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D401DDC23;
	Mon, 28 Jul 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713415; cv=none; b=ufC+4yMWXP2cPRtH3iscXOxBQGu4j5oV15Dl+hOgLGEh++xiYcJo8b4Fy2T6FmOYjy6mM8TnH+gZkfoJCJ2//m1o/4LNB0FA5CTzliLgJa/2aQ0ND0RmIswozD8R06BMxyAbLlLR5SRi5Oj1NeUO15stG2nyIN7Ep5MhjHIN3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713415; c=relaxed/simple;
	bh=QnrsrJuP1GBoHq8sg/d50wmv19fU3Un35JYEo0d8vCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8FyhQGeIgvfQPX27mGVZ+3uA7jtZO+1gVn78b+5xixDRTJqd4GODmycx2qAkKrIx+vRzB9H4yRhg/9g3tUtoDQrFKN0ShSf7BdDuYZsCu5sSaUd2JhiUSNGB7gKpCTaOUi7xyXOD0oeFeEGEM51ZKUKnABpcuuYTPQRcdbK36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxiGvI90; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e8e0fb4a2d2so923682276.1;
        Mon, 28 Jul 2025 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753713413; x=1754318213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQF8OLdFRkuLmNOLZ0xTeHW70hzSwwUMXvMZUwqZwwE=;
        b=DxiGvI90xBiLsC3Asxp/uLORTMISoWHCPwRW/rWzPUD1Kb4aBIbOOdODSu3WVS54Hw
         3HvvwtyO2JIQRJgytYsI6AKbtYS7ufOCRgV/LE98wV5Wpfbxch9uIlCsaYpVw+fyg1hU
         nFPLvqMzPxWcUAXQ+JL7+uZa7lvuNqE/mmESwRWVxAXqdtXb6P1CEfGozBuPQN2i2WY/
         gAUZ2IN6wUUS+6XvLTYQdG4khhGcoAdbR76VCQz9FJf8por8SaJzLjt9ZbimzJKNfPQw
         6//y52OYrfxuxIKu/q12F/eKmG2xnlFzEBxNU7U5ZMZVXIu2ZHB9y4LPcAR329ajto0m
         jBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713413; x=1754318213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQF8OLdFRkuLmNOLZ0xTeHW70hzSwwUMXvMZUwqZwwE=;
        b=HPDwix3zdcaYlbE1+jCvJ9NaZRCnz3AIuEMiKv9xhFDKBJ+elfxNWoOXjMtWWNhQJw
         eC+UAL32Ybv6g4uatZZ55hN4LzTUsyD6/7Uc1O67bCMgzseTOlzGCmfRSY+fOoWJOQL9
         SVqkyy6rsjQtG09l5JTX2dNF9knATz2IZkBWx2y+QNDVy7rqSsdjHm4Yr7Nt6ggc6Ixh
         aE0g8Dohh3ORdbtdM5xk7xzcEeKUpYDH/qVmMOXMQ7QRPBWRYF1Ba8rOR2tlQo2cLO9/
         AVvv1kN04oXsqI3ovEWCjcfU8CPj79UZiF84hwchR0XOlM6tSu6JyixjrvrcyAhhvFtm
         b3qA==
X-Forwarded-Encrypted: i=1; AJvYcCUojwFTP7jq+BbO0YQUQazUFgGP3htOSfXyEAG8Ut0zT1K9x2e4K2O0piCswuDf32rZXK8=@vger.kernel.org, AJvYcCUxAr7oqXK1J7QdFa+tXwTDga7izf3a6vwFZTdo1eotYXWGkpotGmpW1tMFE++S30SzEaWzCCQSuaN+GsUk@vger.kernel.org, AJvYcCXlx2KNFq+TjjvuwMRo2ugq5TkW4SmLz2F7r61eDdTkSSSzUQ5y8E7pm26WvaOd5gWMeI/OXTBYsMJyVM3bKjzkmYWj@vger.kernel.org
X-Gm-Message-State: AOJu0YyT/qQqQmAUjQoHI0fWjaD4bxYusADXOCdasf9reBnajaAa90/b
	jd6O27NjqyxfDBxvwG+hgxA2H4FF0ovgwTFpbzeYaKAtvlnBzs4Adw4rn7qzySBp6r3F+Q12ZQ9
	yYBBWh3x+RiGebS5ogssL2XbCb44ESwE=
X-Gm-Gg: ASbGncsmNB3zKrhingH9ypsmrfmKnH6HcdgdYH0wKTcxs7WqlWNAHz/4wcQeH1PaEps
	axA23YEB4WTWx3NyZi/LDvX1/fYRFH386dqvpZyN3ghOZEqMKPzy/8Op93vjkF3Ca9PRlnS0UY8
	PSeLne6Xw3wKBi+nfARvNUGI58j/RGIP8S2nNVReka5mnrIFqGlkLKNy9Qj2sN9gXrmoDIXoMO0
	ZXKdkU=
X-Google-Smtp-Source: AGHT+IHTfterZh5K4FP62ikSM7yGnUdWojT8JqO/9s3TbF8LqdAE99foIreTsqNrhp3xLTH4bUnKCYSh3cETfn2htCs=
X-Received: by 2002:a05:6902:2587:b0:e8e:c03:75ac with SMTP id
 3f1490d57ef6-e8e0c037aa5mr6564522276.7.1753713412859; Mon, 28 Jul 2025
 07:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728041252.441040-1-dongml2@chinatelecom.cn> <aId3tjPnh_NyRLSv@krava>
In-Reply-To: <aId3tjPnh_NyRLSv@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 28 Jul 2025 22:36:42 +0800
X-Gm-Features: Ac12FXxyq9CpApNUdOi_nWDdjQ0ZtYIEVhqRonl51lRO2MPXFG0Olnk9FumpTvM
Message-ID: <CADxym3brzU=npXwSNUA7x1bCwyyyqgR49LwUzgxeka6ss6Jzrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] fprobe: use rhashtable for fprobe_ip_table
To: Jiri Olsa <olsajiri@gmail.com>
Cc: alexei.starovoitov@gmail.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:14=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jul 28, 2025 at 12:12:47PM +0800, Menglong Dong wrote:
> > For now, the budget of the hash table that is used for fprobe_ip_table =
is
> > fixed, which is 256, and can cause huge overhead when the hooked functi=
ons
> > is a huge quantity.
> >
> > In this series, we use rhashtable for fprobe_ip_table to reduce the
> > overhead.
> >
> > Meanwhile, we also add the benchmark testcase "kprobe-multi-all", which
> > will hook all the kernel functions during the testing. Before this seri=
es,
> > the performance is:
> >   usermode-count :  875.380 =C2=B1 0.366M/s
> >   kernel-count   :  435.924 =C2=B1 0.461M/s
> >   syscall-count  :   31.004 =C2=B1 0.017M/s
> >   fentry         :  134.076 =C2=B1 1.752M/s
> >   fexit          :   68.319 =C2=B1 0.055M/s
> >   fmodret        :   71.530 =C2=B1 0.032M/s
> >   rawtp          :  202.751 =C2=B1 0.138M/s
> >   tp             :   79.562 =C2=B1 0.084M/s
> >   kprobe         :   55.587 =C2=B1 0.028M/s
> >   kprobe-multi   :   56.481 =C2=B1 0.043M/s
> >   kprobe-multi-all:    6.283 =C2=B1 0.005M/s << look this
> >   kretprobe      :   22.378 =C2=B1 0.028M/s
> >   kretprobe-multi:   28.205 =C2=B1 0.025M/s
> >
> > With this series, the performance is:
> >   usermode-count :  897.083 =C2=B1 5.347M/s
> >   kernel-count   :  431.638 =C2=B1 1.781M/s
> >   syscall-count  :   30.807 =C2=B1 0.057M/s
> >   fentry         :  134.803 =C2=B1 1.045M/s
> >   fexit          :   68.763 =C2=B1 0.018M/s
> >   fmodret        :   71.444 =C2=B1 0.052M/s
> >   rawtp          :  202.344 =C2=B1 0.149M/s
> >   tp             :   79.644 =C2=B1 0.376M/s
> >   kprobe         :   55.480 =C2=B1 0.108M/s
> >   kprobe-multi   :   57.302 =C2=B1 0.119M/s
> >   kprobe-multi-all:   57.855 =C2=B1 0.144M/s << look this
>
> nice, so the we still trigger one function, but having all possible
> functions attached, right?

Yes. The test case can be improved further. For now,
I attach the prog bench_trigger_kprobe_multi to all the kernel
functions and triggers the benchmark. There can be some noise,
as all the kernel function calling can increase the benchmark
results. However, it will not make much difference.

A better choice will be: attach an empty kprobe_multi prog to
all the kernel functions except bpf_get_numa_node_id, and
attach bench_trigger_kprobe_multi to bpf_get_numa_node_id,
which can make the results more accurate.

>
> thanks,
> jirka
>
>
> >   kretprobe      :   22.265 =C2=B1 0.023M/s
> >   kretprobe-multi:   27.740 =C2=B1 0.023M/s
> >
> > The benchmark of "kprobe-multi-all" increase from 6.283M/s to 57.855M/s=
.
> >
> > Menglong Dong (4):
> >   fprobe: use rhashtable
> >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> >   selftests/bpf: add benchmark testing for kprobe-multi-all
> >   selftests/bpf: skip recursive functions for kprobe_multi
> >
> >  include/linux/fprobe.h                        |   2 +-
> >  kernel/trace/fprobe.c                         | 144 ++++++-----
> >  tools/testing/selftests/bpf/bench.c           |   2 +
> >  .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
> >  tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> >  8 files changed, 351 insertions(+), 282 deletions(-)
> >
> > --
> > 2.50.1
> >
> >

