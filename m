Return-Path: <bpf+bounces-65956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BEB2B699
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 04:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9648626CA1
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 02:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AC286422;
	Tue, 19 Aug 2025 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIl8Oplz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59B1DF25C;
	Tue, 19 Aug 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568885; cv=none; b=EPkWW39VDOQhOXkEMe+p4Au5Vgg0Fbjecwx2G4Vte5mOcxipT0ZLB2AMHvr+TfEVnUw9WGLsmg65eSKvs7UKSxnNIFEY8t/JHZJ+J5nadR94S0haPzW+0F6bvii6wUWt9ensmyY1xInJxDtgZ+UG+R54FAUypgy9Aawym35356w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568885; c=relaxed/simple;
	bh=ZppeKEbfffVe+Tni3Nb3bzwPEPS/RXb7Oc4oIouausc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPktebV7lXslpnINGRr/4nbbcCdIUjW9iHTLPp1Wo9hhJhyd68AyJF6CUdidevumSjM0P9t4TG51I3gHMbxefz0vo6fzgkJLuzF2WC+qu07L9H7jQTYlJpDj99Tl+TlKNL/Z4nlL9NErjvvRwkDmXmWQXvA5xIEASrcpTHXySvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIl8Oplz; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71e6f84b77eso25708567b3.2;
        Mon, 18 Aug 2025 19:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568882; x=1756173682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=socW1ebOcAKeVLO/DQtGX8j4HLH2PjpuuKFyQH+HcME=;
        b=XIl8OplzRppwIjIXdu2aibc037czTm5A2OsC4Cv5pORi0kt0nRZ0+SNJPToKMbK2vG
         5p17iG33Jp40AgoS7aopxvR1dHi2y8+1AR5Tmny4vDnrDsvph6UvZdCh5jj8GMwimTAA
         6XuIoWDiqht1DSzIUg6mh5SPaQP1XCJDRXn5GXteo0OAYkV9adL/WA87WQAYrVwH3dSm
         mQcyFZEL0CARj+3n6xXZ7LyGSaC1VKyxXgPD9P5JSUz8VwTc1C0gDiknoBO8VQxbhWQL
         GhBU7Qy2eeLcgYVgQJZDkyOcDyEwBuw0YpxlXnUzhzz3YpWVmF241uHiscCAcaVUzM9Z
         mA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568882; x=1756173682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=socW1ebOcAKeVLO/DQtGX8j4HLH2PjpuuKFyQH+HcME=;
        b=a5S0akWDhjOsDNbSI8r0lTfLu0hx6ZQnWj/sP5UlGVSQuYb9sMLR+vf3KpV/tEYjMb
         GorAtF1oNe6p7QPQNcgFBNbRHM0TCOo8TDfJqBKj/EpdwglLvSYWLq8ONxXvwjn5j8sz
         INRjSFG9g0ubElIfKWwWRxgPbuakqgk0J+QUP9/QGJtwvh5fw8RPHDH2y5PG3+3tNmwF
         voImIL4WCzaZM2masD99ba+/sm7ExpHR/taKgytl/aTTxGNlPUjDr4r82K4x0pYVMvV6
         /1Lwss3Mh6WmW1sTRCPedM8ib1Ypb1o7uwGR7FQItc5jk2DUbZuL4oX/sNJFzTFk98tA
         fixQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDqySxNj88UIhuqFSHgda/EyTCxRpxH95jVkDeiDdpg4YF+hCaCmnecPb0uYzR5zWWQjXJ5XU4Wh2vAm3u@vger.kernel.org, AJvYcCUM6wwyZCkIEAGlIHc/eM8h9ZNTK6pRkwbt6HkZOGBUTX3KpLcyO/smwZeRKCwaSOdRvhU=@vger.kernel.org, AJvYcCVuZK9ad/RpIku6DybVD3u8UIgbBZWNTV1VqzZpeCgiXdGy26YXfAro9P/TDkcOE2pR4hkyRq4USIhiAe+6Ki9w8uUi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sWlZK5T4oUItl1N/2cq4u7ApxP5QtmsYXm/ZgeRn/l1qgcV1
	qytTp6hf0J/aMJaasp0sH2qhfxcvaKZCcx/+nNQ4Q6y85BhljYsxFvh8UP6PXOr1v4hNOCm/Vq9
	h6rXaXBvK7rQYhCzBZRCOHk6s5Rp49jY=
X-Gm-Gg: ASbGnctKxcsYxCLxB6rajxOpHtl6ovDLDntVbNd8kY4GxDKRnWYmIokqzVc4cim6njG
	uuqtlExdJ0zwU0/DAHv4YNjdDfOnnkCb0AztmUXqmERWSRAGrFGmOdNWWT9v66A8FCrTKIypemk
	Ci9WB3D1UD55zpr5YhZ2vbZ3AEyFeqAKkmBg96zkvjwa6Mg/qAyCbOS2F85i1rJFWY2je2jjCNy
	XnlUdk=
X-Google-Smtp-Source: AGHT+IGxxYpD0Jics5XL1RW7b+nr3eSRQWeY1D2sYwoWcAu68uyc5xEYq0TTqq3tiTF54Zpi3na41+5CVLQxbRPDfKE=
X-Received: by 2002:a05:690c:62c3:b0:71c:4091:3c61 with SMTP id
 00721157ae682-71f9d64ed55mr11251807b3.22.1755568882248; Mon, 18 Aug 2025
 19:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817024607.296117-1-dongml2@chinatelecom.cn> <20250819104850.1a903746f2eca854490e770b@kernel.org>
In-Reply-To: <20250819104850.1a903746f2eca854490e770b@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 19 Aug 2025 10:01:11 +0800
X-Gm-Features: Ac12FXyWCPLHmUdA7bQHM3WBWpkRuIsRmUomDSr7lEmV_3k5KboIQu-Z9XUuTJ8
Message-ID: <CADxym3a2C9y=DUQQFdRp5sBArTm5Z+Wd0RmCqPQTaypTv5P_AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/4] fprobe: use rhashtable for fprobe_ip_table
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, hca@linux.ibm.com, 
	revest@chromium.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:48=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Sun, 17 Aug 2025 10:46:01 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > For now, the budget of the hash table that is used for fprobe_ip_table =
is
> > fixed, which is 256, and can cause huge overhead when the hooked functi=
ons
> > is a huge quantity.
> >
> > In this series, we use rhltable for fprobe_ip_table to reduce the
> > overhead.
> >
> > Meanwhile, we also add the benchmark testcase "kprobe-multi-all" and, w=
hich
> > will hook all the kernel functions during the testing. Before this seri=
es,
> > the performance is:
> >   usermode-count :  889.269 =C2=B1 0.053M/s
> >   kernel-count   :  437.149 =C2=B1 0.501M/s
> >   syscall-count  :   31.618 =C2=B1 0.725M/s
> >   fentry         :  135.591 =C2=B1 0.129M/s
> >   fexit          :   68.127 =C2=B1 0.062M/s
> >   fmodret        :   71.764 =C2=B1 0.098M/s
> >   rawtp          :  198.375 =C2=B1 0.190M/s
> >   tp             :   79.770 =C2=B1 0.064M/s
> >   kprobe         :   54.590 =C2=B1 0.021M/s
> >   kprobe-multi   :   57.940 =C2=B1 0.044M/s
> >   kprobe-multi-all:   12.151 =C2=B1 0.020M/s
> >   kretprobe      :   21.945 =C2=B1 0.163M/s
> >   kretprobe-multi:   28.199 =C2=B1 0.018M/s
> >   kretprobe-multi-all:    9.667 =C2=B1 0.008M/s
> >
> > With this series, the performance is:
> >   usermode-count :  888.863 =C2=B1 0.378M/s
> >   kernel-count   :  429.339 =C2=B1 0.136M/s
> >   syscall-count  :   31.215 =C2=B1 0.019M/s
> >   fentry         :  135.604 =C2=B1 0.118M/s
> >   fexit          :   68.470 =C2=B1 0.074M/s
> >   fmodret        :   70.957 =C2=B1 0.016M/s
> >   rawtp          :  202.650 =C2=B1 0.304M/s
> >   tp             :   80.428 =C2=B1 0.053M/s
> >   kprobe         :   55.915 =C2=B1 0.074M/s
> >   kprobe-multi   :   54.015 =C2=B1 0.039M/s
> >   kprobe-multi-all:   46.381 =C2=B1 0.024M/s
> >   kretprobe      :   22.234 =C2=B1 0.050M/s
> >   kretprobe-multi:   27.946 =C2=B1 0.016M/s
> >   kretprobe-multi-all:   24.439 =C2=B1 0.016M/s
> >
> > The benchmark of "kprobe-multi-all" increase from 12.151M/s to 46.381M/=
s.
> >
> > I don't know why, but the benchmark result for "kprobe-multi-all" is mu=
ch
> > better in this version for the legacy case(without this series). In V2,
> > the benchmark increase from 6.283M/s to 54.487M/s, but it become
> > 12.151M/s to 46.381M/s in this version. Maybe it has some relation with
> > the compiler optimization :/
> >
> > The result of this version should be more accurate, which is similar to
> > Jiri's result: from 3.565 =C2=B1 0.047M/s to 11.553 =C2=B1 0.458M/s.
>
> Hi Menglong,
>
> BTW, fprobe itself is maintained in linux-trace tree, not bpf-next.
> This improvement can be tested via tracefs.
>
> echo 'f:allfunc *' >> /sys/kernel/tracing/dynamic_events
>
> So, can you split this series in fprobe performance improvement[1/4] for
> linux-trace and others ([2/4]-[4/4]) for bpf-next?
>
> I'll pick the first one.

OK! I'll resend the first patch to linux-trace alone, and make
2-4 a series to the bpf-next.

>
> Thank you,
>
> >
> > Changes since V4:
> >
> > * remove unnecessary rcu_read_lock in fprobe_entry
> >
> > Changes since V3:
> >
> > * replace rhashtable_walk_enter with rhltable_walk_enter in the 1st pat=
ch
> >
> > Changes since V2:
> >
> > * some format optimization, and handle the error that returned from
> >   rhltable_insert in insert_fprobe_node for the 1st patch
> > * add "kretprobe-multi-all" testcase to the 4th patch
> > * attach a empty kprobe-multi prog to the kernel functions, which don't
> >   call incr_count(), to make the result more accurate in the 4th patch
> >
> > Changes Since V1:
> >
> > * use rhltable instead of rhashtable to handle the duplicate key.
> >
> > Menglong Dong (4):
> >   fprobe: use rhltable for fprobe_ip_table
> >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> >   selftests/bpf: skip recursive functions for kprobe_multi
> >   selftests/bpf: add benchmark testing for kprobe-multi-all
> >
> >  include/linux/fprobe.h                        |   3 +-
> >  kernel/trace/fprobe.c                         | 151 +++++++-----
> >  tools/testing/selftests/bpf/bench.c           |   4 +
> >  .../selftests/bpf/benchs/bench_trigger.c      |  54 ++++
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
> >  .../selftests/bpf/progs/trigger_bench.c       |  12 +
> >  tools/testing/selftests/bpf/trace_helpers.c   | 233 ++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> >  9 files changed, 398 insertions(+), 286 deletions(-)
> >
> > --
> > 2.50.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

