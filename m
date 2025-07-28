Return-Path: <bpf+bounces-64531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEC1B13DAF
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF09189A4CB
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521DE26FA60;
	Mon, 28 Jul 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1pisBoP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2B282EB;
	Mon, 28 Jul 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714341; cv=none; b=YVO6HgEF7BQhMI/BbQlv2Kz6GGXDMKZf/hTzppf5xTdJxT54jTXuz8un0tw8f3xJdXiPJyxJw/Zo211zN8XDMqa76apWiUtWFj0yqb0/qFHbxVa0C4eHQfh9MlLGQLugyg20bCNuQbP1lCXllb9KkppN8ih4UoMMSd6t5jL5I/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714341; c=relaxed/simple;
	bh=kTRQbcgLyj+VUuMJrJexSb4xNkNCabbT9Sjs2M+Ff8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR3Ic9CVPwBHQEtQ4uRe4KheTBke3Ne5bm1oAIYDShFDRQC0teXqP7V/rVcaAs5XfjsM6dQE63Fq/J6WVrTf6zsd25E26MQf2o84NIOMybF1VAJP5LxXH7qALWG6lm8fdAMFOLl2yX2ADWenWVgb/ZXwm+S6Aq9tHixRfB+dCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1pisBoP; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso4598555276.1;
        Mon, 28 Jul 2025 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714339; x=1754319139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR5e6wlz6AVvzPEaOIlAqPusXTRc+DVg0GPemULlSoA=;
        b=O1pisBoPhcasRG2CpMoucRH1S74T9GKm3gkEZPYAXhoHYcMhj/f8rcdp7e93UFLCpN
         Fpo8qaH0kfCtzN3i39tPaeVW8L9C07uhroaGW8R4g/5oGosLjY8umY+Cba4V8tY/eLiH
         NDqZ25ysVJw/Tg+NeWwxD2nJJAn1NIWQg06pYcdPT9Yhs1epKe4k+FHYM2Nt1ZJg95Eu
         VpVf3HC3T8QG9Aegk2UWPA+TAVvCEF1w7/0S8Z9nf2V1o02AGdENuwLRa80Vmqsb/Qyw
         RuaY7dGbSNMuIT7l7Em+U/JPlMDTKz682aVF+JpWFG9OV/4tdqB1fD01+fHGE0tzviPF
         3Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714339; x=1754319139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR5e6wlz6AVvzPEaOIlAqPusXTRc+DVg0GPemULlSoA=;
        b=c3qfRQFNBG/kR7FBCmqtIBZzTexNH2eH0TwLEtDcffwQDq78RrP5aXX5CUeANGgrYQ
         cLAPT6iUnxhw0NOWuVmQheto3R4smf0GC20HkJ+aX+4TGDYH9mRf366wN3dbJssu3/qT
         6gWXIHpD7l6jzJSPk8wwoZ4Pp5zEkrLYLuEHD0H9kCGA2BS88oykK+mtLcmUTHzD3wo9
         NhPhQLHvV2fjCLhag/2pKj+0S54rfVthWEYU9yqDkEyFp4iujJRD8nqN/FIHkaSIArWi
         Z+ef1us7GYiApKIDMUOxu5h6L/tqvLuinoqIwDm/U3liOJlPES+l77xB9q9ExHjb0VGb
         a/xA==
X-Forwarded-Encrypted: i=1; AJvYcCVWO2HZkNiE0TJbsLBfSc0IciQ4GAsxply/2CZtegVTMQAA7my7muifkS7UBUUH7AJASmIS55AJTJRVcfM7@vger.kernel.org, AJvYcCWNKQEJnuFy3VqnEgpah/oNOOfzhW2c46qRS1+vS18TGOEbvkt+b8yUFe3SMnx9R+vbsBg=@vger.kernel.org, AJvYcCWRmNkRdRqIG/zS9xZ7Oos7gxj6Udue8lwyDoYETpWrsvXgivz83+NsyN1TuiF1B3b93nwTX9Fad+mgqjCvwpmW1Lea@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vYz3mQ973u2hOUvY6QzPbCmPdFs82V8nTWMxpKTu1LYwZRy+
	pRBUvXgNbm1zW3tyWDiS6mVc3sSGGl6RZAY7kUFs7+hSTq84WWcBC11+/WlH0Q290sMATeX6N9z
	tunYAFlh/QoxzIoecbuAhg5brGWViosHJtMWjk5IvOA==
X-Gm-Gg: ASbGncsV8+K0dUvIDwE8o9c2aNKYs1mfU5OWjdoc/qUj/Bi0ac2TDhQMsLN0MwtHS3B
	bin9WDo2me/q9Ywo84X0Kc1oXQq7tKBfL33c0kH9lNVh65gL2h8kyztq0BkXTNJYHlpguVxrOZV
	D00T/kEjR23nnxkhSD0ZDCNqxglAnNTX1MPnDTw1GYVT72IipAmkXDwuR1vbXJDGthK8n/BR2Fp
	2hEAMBD97rqitkkkA==
X-Google-Smtp-Source: AGHT+IEJ+MbNyihtp+y3X0o//CRISdwd0P3r79GZY1d1LCu5rmd63vQG25kotL9DOxstM3NqiH1CncGK8N6v/9QM7NY=
X-Received: by 2002:a05:6902:4203:b0:e8e:187:c237 with SMTP id
 3f1490d57ef6-e8e0187c7e5mr8627313276.20.1753714338866; Mon, 28 Jul 2025
 07:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn> <aIeCXbpno1y3Aio1@krava>
In-Reply-To: <aIeCXbpno1y3Aio1@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 28 Jul 2025 22:52:08 +0800
X-Gm-Features: Ac12FXxV4A8XVDQJos8i1CZqd-Y32v0lK_Pq8bjGXT8ngNVst3H9HYsa8hDzmjg
Message-ID: <CADxym3ZgqgAv1zkU6=+8OShxd_d8gHrikvNG=YeGFsUYUdHaUw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 0/4] fprobe: use rhashtable for fprobe_ip_table
To: Jiri Olsa <olsajiri@gmail.com>
Cc: alexei.starovoitov@gmail.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:00=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Mon, Jul 28, 2025 at 03:22:49PM +0800, Menglong Dong wrote:
> > For now, the budget of the hash table that is used for fprobe_ip_table =
is
> > fixed, which is 256, and can cause huge overhead when the hooked functi=
ons
> > is a huge quantity.
> >
> > In this series, we use rhltable for fprobe_ip_table to reduce the
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
> >   usermode-count :  902.387 =C2=B1 0.762M/s
> >   kernel-count   :  427.356 =C2=B1 0.368M/s
> >   syscall-count  :   30.830 =C2=B1 0.016M/s
> >   fentry         :  135.554 =C2=B1 0.064M/s
> >   fexit          :   68.317 =C2=B1 0.218M/s
> >   fmodret        :   70.633 =C2=B1 0.275M/s
> >   rawtp          :  193.404 =C2=B1 0.346M/s
> >   tp             :   80.236 =C2=B1 0.068M/s
> >   kprobe         :   55.200 =C2=B1 0.359M/s
> >   kprobe-multi   :   54.304 =C2=B1 0.092M/s
> >   kprobe-multi-all:   54.487 =C2=B1 0.035M/s << look this
>
> I meassured bit less speed up, but still great
>
> kprobe-multi-all:    3.565 =C2=B1 0.047M/s
> kprobe-multi-all:   11.553 =C2=B1 0.458M/s

BTW, the mitigations is disabled in my testing to show
the overhead distinction. With mitigations enabled,
all the performance suffers from it, and the overhead is
not obvious :/

I'll add the "mitigations is disabled" information to the
commit log too.

>
> could you add kretprobe-multi-all bench as well?
>
> thanks,
> jirka
>
>
> >   kretprobe      :   22.381 =C2=B1 0.075M/s
> >   kretprobe-multi:   27.926 =C2=B1 0.034M/s
> >
> > The benchmark of "kprobe-multi-all" increase from 6.283M/s to 54.487M/s=
.
> >
> > The locking is not handled properly in the first patch. In the
> > fprobe_entry, we should use RCU when we access the rhlist_head. However=
,
> > we can't use RCU for __fprobe_handler, as it can sleep. In the origin
> > logic, it seems that the usage of hlist_for_each_entry_from_rcu() is no=
t
> > protected by rcu_read_lock neither, isn't it? I don't know how to handl=
e
> > this part ;(
> >
> > Menglong Dong (4):
> >   fprobe: use rhltable for fprobe_ip_table
> >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> >   selftests/bpf: skip recursive functions for kprobe_multi
> >   selftests/bpf: add benchmark testing for kprobe-multi-all
> >
> >  include/linux/fprobe.h                        |   2 +-
> >  kernel/trace/fprobe.c                         | 141 ++++++-----
> >  tools/testing/selftests/bpf/bench.c           |   2 +
> >  .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
> >  tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> >  8 files changed, 348 insertions(+), 282 deletions(-)
> >
> > --
> > 2.50.1
> >
> >

