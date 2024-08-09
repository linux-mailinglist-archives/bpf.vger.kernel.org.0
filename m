Return-Path: <bpf+bounces-36786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F9594D64F
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E121F22208
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECDA15921B;
	Fri,  9 Aug 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDrUbhuM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0072F41;
	Fri,  9 Aug 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228504; cv=none; b=WTNTVt+x47DYmRxGWoocikomLbFlB2VatkYJZMPWsVbQlZSHp6d5qC6xEOd/1YYXJeXSid7w6AahmDBAT8curH3RElt2IYxX6jvWSGVfog34+MhjfnrBquAokgMXwAp5AvuiCzuww6i/jIgVGqjgfxhP+cCTa1DHQ4l2IbRe434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228504; c=relaxed/simple;
	bh=s25FPRQsxS9E9zV6gHxoZiBK+B7hZhhwWMBcvwJ8NSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTb8cpLYU5Xv8QWUF1RyGSfk8ePn+YBbgp5dH0B88SEwEcGmqcOQwvFCO6Q9hk6rjlMa8Ik72FLibV0wFMwEG5C30c18tiknfcQflCH2q1YzRdasTM0PRpxt7n1HwTo9gzt2oGqQgGykg3QHHpGwDaYcGTqFxg7siQYPa0OVxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDrUbhuM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so1920590a91.3;
        Fri, 09 Aug 2024 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723228502; x=1723833302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFERSlbiSDGcOU4j1cbonbQ142nnw8A7d0YD3FD7NwM=;
        b=PDrUbhuMYLxJmqBzMi0eYhs7MLVyb8sz4jQ7YTQ+ppO0xGJx9f2rB/rjN8yFA4uawN
         O26NzKVak+JHB8JzWu86qls24FdGlXxaoIIxllqdN8FGSf0Jokdxm/CId021u5/zSZl8
         eHNkF8hiW0IiZVwehMN1YRmUSVAdZulZ0LXLi5mOQ+9Yc0AOYOUeOClNfUe1+EUsIm6j
         d/agFkj4VCLLgXpwzWENCF096a3xUbbqHsnU+CfVtXeoSpfoXSmRUlHQNqZkMZfhvupi
         x8oAyrYYLjF+IXGD3eFcLhkG4nx4TDqLVF2pykyQ7glaJFgSb+Au7G8ebZpo8WFz6NkF
         5RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228502; x=1723833302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFERSlbiSDGcOU4j1cbonbQ142nnw8A7d0YD3FD7NwM=;
        b=M3Vcy0uoY3lMN7r0xAV2TPhWXFRJbyGuenflzODPna9a9AYpQewt+ImjrUQy3jH+nm
         MLl1NbcsiRP2Cv7uHUSzgSw5DUMkPaly2MctfOCT9S7cSDeF8jEzG2rsNjTuxDDZDUz5
         Vu9e5u6KMIJh542aWXacsOTpr4b0oWm/qKa+mTbQfvv6874GMXihaDqBXUItinqd/Ksa
         d3BiJ9RBgf8zjgH2vVEe+TMU07sCXnY/1BZUPIBNmDnkYUtxGITaOiw7b/bWZwZRiO5r
         dVRBTrzvZ1kZjk3tYgjrGjXpHRwlCUn+c10XQTmWtaZjpNLSTz1YOfwHRFOmp+a/5Mjj
         SwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKGU6N3f75gQJo0DlF13e2LwynCTgVnjdooWOtv6qcUN6s9mOzsEta1+lRk54B9oguxyb5PqL13In8S2pZt2TNY++UJtatuYIcRsir4XfUNGHZmMZNxS0bBGB3pbHz1HdLuAxC8ASuxu1VJC/sY8N99W2b4vyPjUWaPnC2yjlZWGyUdN1ZlvL1SCCxHkKxVnqQIynF2pyZmjiZRFW9CT8Rsy4cUWlqkQ==
X-Gm-Message-State: AOJu0Yy2uR41hkicasT0yZ2uYAwbbwA2pS8UbDj2b5Aq6jbCuEar597I
	OhCOf6SW8RnKi6iUjP5zhFQjgCq4GRDIPt/I32uonzEZotPASJ6uQKsJyIISUkFI5zYoxpQtgi7
	tKAwmQGjyUfzDk/UwYa7d/4ZyGsA=
X-Google-Smtp-Source: AGHT+IE1oiqY5Ipiu1K2cwfh6xvxfTXKOfgblp6ayvS6lkFXD+BR0ssyoBdFO/eOrOk/ztswX007e8ltyyrPpy+eAAQ=
X-Received: by 2002:a17:90b:2390:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2d1e804a8famr2640600a91.33.1723228501771; Fri, 09 Aug 2024
 11:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com> <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
 <a22d6d79-fa7e-62b2-0ac1-575068f176a5@huawei.com>
In-Reply-To: <a22d6d79-fa7e-62b2-0ac1-575068f176a5@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 11:34:49 -0700
Message-ID: <CAEf4BzbN-+p0cDnHQPDwhVaqs-r-_Ft-LdUwY2KHG1xfrmyjBQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Optimize the allocation of insn_slot for performance
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, 
	"oleg@redhat.com >> Oleg Nesterov" <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:16=E2=80=AFAM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/8/9 2:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huawei.c=
om> wrote:
> >>
> >> Hi Andrii and Oleg.
> >>
> >> This patch sent by me two weeks ago also aim to optimize the performan=
ce of uprobe
> >> on arm64. I notice recent discussions on the performance and scalabili=
ty of uprobes
> >> within the mailing list. Considering this interest, I've added you and=
 other relevant
> >> maintainers to the CC list for broader visibility and potential collab=
oration.
> >>
> >
> > Hi Liao,
> >
> > As you can see there is an active work to improve uprobes, that
> > changes lifetime management of uprobes, removes a bunch of locks taken
> > in the uprobe/uretprobe hot path, etc. It would be nice if you can
> > hold off a bit with your changes until all that lands. And then
> > re-benchmark, as costs might shift.
>
> Andrii, I'm trying to integrate your lockless changes into the upstream
> next-20240806 kernel tree. And I ran into some conflicts. please let me
> know which kernel you're currently working on.
>

My patches are  based on tip/perf/core. But I also just pushed all the
changes I have accumulated (including patches I haven't sent for
review just yet), plus your patches for sighand lock removed applied
on top into [0]. So you can take a look and use that as a base for
now. Keep in mind, a bunch of those patches might still change, but
this should give you the best currently achievable performance with
uprobes/uretprobes. E.g., I'm getting something like below on x86-64
(note somewhat linear scalability with number of CPU cores, with
per-CPU performance *slowly* declining):

uprobe-nop            ( 1 cpus):    3.565 =C2=B1 0.004M/s  (  3.565M/s/cpu)
uprobe-nop            ( 2 cpus):    6.742 =C2=B1 0.009M/s  (  3.371M/s/cpu)
uprobe-nop            ( 3 cpus):   10.029 =C2=B1 0.056M/s  (  3.343M/s/cpu)
uprobe-nop            ( 4 cpus):   13.118 =C2=B1 0.014M/s  (  3.279M/s/cpu)
uprobe-nop            ( 5 cpus):   16.360 =C2=B1 0.011M/s  (  3.272M/s/cpu)
uprobe-nop            ( 6 cpus):   19.650 =C2=B1 0.045M/s  (  3.275M/s/cpu)
uprobe-nop            ( 7 cpus):   22.926 =C2=B1 0.010M/s  (  3.275M/s/cpu)
uprobe-nop            ( 8 cpus):   24.707 =C2=B1 0.025M/s  (  3.088M/s/cpu)
uprobe-nop            (10 cpus):   30.842 =C2=B1 0.018M/s  (  3.084M/s/cpu)
uprobe-nop            (12 cpus):   33.623 =C2=B1 0.037M/s  (  2.802M/s/cpu)
uprobe-nop            (14 cpus):   39.199 =C2=B1 0.009M/s  (  2.800M/s/cpu)
uprobe-nop            (16 cpus):   41.698 =C2=B1 0.018M/s  (  2.606M/s/cpu)
uprobe-nop            (24 cpus):   65.078 =C2=B1 0.018M/s  (  2.712M/s/cpu)
uprobe-nop            (32 cpus):   84.580 =C2=B1 0.017M/s  (  2.643M/s/cpu)
uprobe-nop            (40 cpus):  101.992 =C2=B1 0.268M/s  (  2.550M/s/cpu)
uprobe-nop            (48 cpus):  101.032 =C2=B1 1.428M/s  (  2.105M/s/cpu)
uprobe-nop            (56 cpus):  110.986 =C2=B1 0.736M/s  (  1.982M/s/cpu)
uprobe-nop            (64 cpus):  124.145 =C2=B1 0.110M/s  (  1.940M/s/cpu)
uprobe-nop            (72 cpus):  134.940 =C2=B1 0.200M/s  (  1.874M/s/cpu)
uprobe-nop            (80 cpus):  143.918 =C2=B1 0.235M/s  (  1.799M/s/cpu)

uretprobe-nop         ( 1 cpus):    1.987 =C2=B1 0.001M/s  (  1.987M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.766 =C2=B1 0.003M/s  (  1.883M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.638 =C2=B1 0.002M/s  (  1.879M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.275 =C2=B1 0.003M/s  (  1.819M/s/cpu)
uretprobe-nop         ( 5 cpus):    9.124 =C2=B1 0.004M/s  (  1.825M/s/cpu)
uretprobe-nop         ( 6 cpus):   10.818 =C2=B1 0.007M/s  (  1.803M/s/cpu)
uretprobe-nop         ( 7 cpus):   12.721 =C2=B1 0.014M/s  (  1.817M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.639 =C2=B1 0.007M/s  (  1.705M/s/cpu)
uretprobe-nop         (10 cpus):   17.023 =C2=B1 0.009M/s  (  1.702M/s/cpu)
uretprobe-nop         (12 cpus):   18.576 =C2=B1 0.014M/s  (  1.548M/s/cpu)
uretprobe-nop         (14 cpus):   21.660 =C2=B1 0.004M/s  (  1.547M/s/cpu)
uretprobe-nop         (16 cpus):   22.922 =C2=B1 0.013M/s  (  1.433M/s/cpu)
uretprobe-nop         (24 cpus):   34.756 =C2=B1 0.069M/s  (  1.448M/s/cpu)
uretprobe-nop         (32 cpus):   44.869 =C2=B1 0.153M/s  (  1.402M/s/cpu)
uretprobe-nop         (40 cpus):   53.397 =C2=B1 0.220M/s  (  1.335M/s/cpu)
uretprobe-nop         (48 cpus):   48.903 =C2=B1 2.277M/s  (  1.019M/s/cpu)
uretprobe-nop         (56 cpus):   42.144 =C2=B1 1.206M/s  (  0.753M/s/cpu)
uretprobe-nop         (64 cpus):   42.656 =C2=B1 1.104M/s  (  0.666M/s/cpu)
uretprobe-nop         (72 cpus):   46.299 =C2=B1 1.443M/s  (  0.643M/s/cpu)
uretprobe-nop         (80 cpus):   46.469 =C2=B1 0.808M/s  (  0.581M/s/cpu)

uprobe-ret            ( 1 cpus):    1.219 =C2=B1 0.008M/s  (  1.219M/s/cpu)
uprobe-ret            ( 2 cpus):    1.862 =C2=B1 0.008M/s  (  0.931M/s/cpu)
uprobe-ret            ( 3 cpus):    2.874 =C2=B1 0.005M/s  (  0.958M/s/cpu)
uprobe-ret            ( 4 cpus):    3.512 =C2=B1 0.002M/s  (  0.878M/s/cpu)
uprobe-ret            ( 5 cpus):    3.549 =C2=B1 0.001M/s  (  0.710M/s/cpu)
uprobe-ret            ( 6 cpus):    3.425 =C2=B1 0.003M/s  (  0.571M/s/cpu)
uprobe-ret            ( 7 cpus):    3.551 =C2=B1 0.009M/s  (  0.507M/s/cpu)
uprobe-ret            ( 8 cpus):    3.050 =C2=B1 0.002M/s  (  0.381M/s/cpu)
uprobe-ret            (10 cpus):    2.706 =C2=B1 0.002M/s  (  0.271M/s/cpu)
uprobe-ret            (12 cpus):    2.588 =C2=B1 0.003M/s  (  0.216M/s/cpu)
uprobe-ret            (14 cpus):    2.589 =C2=B1 0.003M/s  (  0.185M/s/cpu)
uprobe-ret            (16 cpus):    2.575 =C2=B1 0.001M/s  (  0.161M/s/cpu)
uprobe-ret            (24 cpus):    1.808 =C2=B1 0.011M/s  (  0.075M/s/cpu)
uprobe-ret            (32 cpus):    1.853 =C2=B1 0.001M/s  (  0.058M/s/cpu)
uprobe-ret            (40 cpus):    1.952 =C2=B1 0.002M/s  (  0.049M/s/cpu)
uprobe-ret            (48 cpus):    2.075 =C2=B1 0.007M/s  (  0.043M/s/cpu)
uprobe-ret            (56 cpus):    2.441 =C2=B1 0.004M/s  (  0.044M/s/cpu)
uprobe-ret            (64 cpus):    1.880 =C2=B1 0.012M/s  (  0.029M/s/cpu)
uprobe-ret            (72 cpus):    0.962 =C2=B1 0.002M/s  (  0.013M/s/cpu)
uprobe-ret            (80 cpus):    1.040 =C2=B1 0.011M/s  (  0.013M/s/cpu)

uretprobe-ret         ( 1 cpus):    0.981 =C2=B1 0.000M/s  (  0.981M/s/cpu)
uretprobe-ret         ( 2 cpus):    1.421 =C2=B1 0.001M/s  (  0.711M/s/cpu)
uretprobe-ret         ( 3 cpus):    2.050 =C2=B1 0.003M/s  (  0.683M/s/cpu)
uretprobe-ret         ( 4 cpus):    2.596 =C2=B1 0.002M/s  (  0.649M/s/cpu)
uretprobe-ret         ( 5 cpus):    3.105 =C2=B1 0.003M/s  (  0.621M/s/cpu)
uretprobe-ret         ( 6 cpus):    3.886 =C2=B1 0.002M/s  (  0.648M/s/cpu)
uretprobe-ret         ( 7 cpus):    3.016 =C2=B1 0.001M/s  (  0.431M/s/cpu)
uretprobe-ret         ( 8 cpus):    2.903 =C2=B1 0.000M/s  (  0.363M/s/cpu)
uretprobe-ret         (10 cpus):    2.755 =C2=B1 0.001M/s  (  0.276M/s/cpu)
uretprobe-ret         (12 cpus):    2.400 =C2=B1 0.001M/s  (  0.200M/s/cpu)
uretprobe-ret         (14 cpus):    3.972 =C2=B1 0.001M/s  (  0.284M/s/cpu)
uretprobe-ret         (16 cpus):    3.940 =C2=B1 0.003M/s  (  0.246M/s/cpu)
uretprobe-ret         (24 cpus):    3.002 =C2=B1 0.003M/s  (  0.125M/s/cpu)
uretprobe-ret         (32 cpus):    3.018 =C2=B1 0.003M/s  (  0.094M/s/cpu)
uretprobe-ret         (40 cpus):    1.846 =C2=B1 0.000M/s  (  0.046M/s/cpu)
uretprobe-ret         (48 cpus):    2.487 =C2=B1 0.004M/s  (  0.052M/s/cpu)
uretprobe-ret         (56 cpus):    2.470 =C2=B1 0.006M/s  (  0.044M/s/cpu)
uretprobe-ret         (64 cpus):    2.027 =C2=B1 0.014M/s  (  0.032M/s/cpu)
uretprobe-ret         (72 cpus):    1.108 =C2=B1 0.011M/s  (  0.015M/s/cpu)
uretprobe-ret         (80 cpus):    0.982 =C2=B1 0.005M/s  (  0.012M/s/cpu)


-ret variants (single-stepping case for x86-64) still suck, but they
suck 2x less now with your patches :) Clearly more work ahead for
those, though.


  [0] https://github.com/anakryiko/linux/commits/uprobes-lockless-cumulativ=
e/


> Thanks.
>
> >
> > But also see some remarks below.
> >
> >> Thanks.
> >>
> >> =E5=9C=A8 2024/7/27 17:44, Liao Chang =E5=86=99=E9=81=93:
> >>> The profiling result of single-thread model of selftests bench reveal=
s
> >>> performance bottlenecks in find_uprobe() and caches_clean_inval_pou()=
 on
> >>> ARM64. On my local testing machine, 5% of CPU time is consumed by
> >>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() tak=
e
> >>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> >>>
> >>> This patch introduce struct uprobe_breakpoint to track previously
> >>> allocated insn_slot for frequently hit uprobe. it effectively reduce =
the
> >>> need for redundant insn_slot writes and subsequent expensive cache
> >>> flush, especially on architecture like ARM64. This patch has been tes=
ted
> >>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftest
> >>> bench and Redis GET/SET benchmark result below reveal obivious
> >>> performance gain.
> >>>
> >>> before-opt
> >>> ----------
> >>> trig-uprobe-nop:  0.371 =C2=B1 0.001M/s (0.371M/prod)
> >>> trig-uprobe-push: 0.370 =C2=B1 0.001M/s (0.370M/prod)
> >>> trig-uprobe-ret:  1.637 =C2=B1 0.001M/s (1.647M/prod)
> >
> > I'm surprised that nop and push variants are much slower than ret
> > variant. This is exactly opposite on x86-64. Do you have an
> > explanation why this might be happening? I see you are trying to
> > optimize xol_get_insn_slot(), but that is (at least for x86) a slow
> > variant of uprobe that normally shouldn't be used. Typically uprobe is
> > installed on nop (for USDT) and on function entry (which would be push
> > variant, `push %rbp` instruction).
> >
> > ret variant, for x86-64, causes one extra step to go back to user
> > space to execute original instruction out-of-line, and then trapping
> > back to kernel for running uprobe. Which is what you normally want to
> > avoid.
> >
> > What I'm getting at here. It seems like maybe arm arch is missing fast
> > emulated implementations for nops/push or whatever equivalents for
> > ARM64 that is. Please take a look at that and see why those are slow
> > and whether you can make those into fast uprobe cases?
>
> I will spend the weekend figuring out the questions you raised. Thanks fo=
r
> pointing them out.
>
> >
> >>> trig-uretprobe-nop:  0.331 =C2=B1 0.004M/s (0.331M/prod)
> >>> trig-uretprobe-push: 0.333 =C2=B1 0.000M/s (0.333M/prod)
> >>> trig-uretprobe-ret:  0.854 =C2=B1 0.002M/s (0.854M/prod)
> >>> Redis SET (RPS) uprobe: 42728.52
> >>> Redis GET (RPS) uprobe: 43640.18
> >>> Redis SET (RPS) uretprobe: 40624.54
> >>> Redis GET (RPS) uretprobe: 41180.56
> >>>
> >>> after-opt
> >>> ---------
> >>> trig-uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >>> trig-uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >>> trig-uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >>> trig-uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >>> trig-uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >>> trig-uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>> Redis SET (RPS) uprobe: 43939.69
> >>> Redis GET (RPS) uprobe: 45200.80
> >>> Redis SET (RPS) uretprobe: 41658.58
> >>> Redis GET (RPS) uretprobe: 42805.80
> >>>
> >>> While some uprobes might still need to share the same insn_slot, this
> >>> patch compare the instructions in the resued insn_slot with the
> >>> instructions execute out-of-line firstly to decides allocate a new on=
e
> >>> or not.
> >>>
> >>> Additionally, this patch use a rbtree associated with each thread tha=
t
> >>> hit uprobes to manage these allocated uprobe_breakpoint data. Due to =
the
> >>> rbtree of uprobe_breakpoints has smaller node, better locality and le=
ss
> >>> contention, it result in faster lookup times compared to find_uprobe(=
).
> >>>
> >>> The other part of this patch are some necessary memory management for
> >>> uprobe_breakpoint data. A uprobe_breakpoint is allocated for each new=
ly
> >>> hit uprobe that doesn't already have a corresponding node in rbtree. =
All
> >>> uprobe_breakpoints will be freed when thread exit.
> >>>
> >>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>> ---
> >>>  include/linux/uprobes.h |   3 +
> >>>  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++-----=
--
> >>>  2 files changed, 211 insertions(+), 38 deletions(-)
> >>>
> >
> > [...]
>
> --
> BR
> Liao, Chang

