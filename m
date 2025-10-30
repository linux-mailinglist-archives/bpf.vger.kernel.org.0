Return-Path: <bpf+bounces-73058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE6C2180D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52C64E3E4F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CD36B985;
	Thu, 30 Oct 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eepk593v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273F368F5A
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845574; cv=none; b=Si6jKxabCCGIhW0NqBgC1Xd7GOEetR/PKheVUrqrij0Zz/yidhyUHzAOfQpY0fzdSKt9VHQjaBoFQsLc7bwdcj3GJn/Vm7AaHFCKaYbVYvMspSc0y0Nue/T3RkW5igezLSaoBhiq5y9XBmDVp6m5SQ7uKoCS24Iw3VSWIpsi4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845574; c=relaxed/simple;
	bh=o6y3cSzf1w/dTMAmlEkzjUCthI15kujL+QsU5CD7uYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEulX7m41Itpr+Zoja2wRqF+oKrFCaxLrNSOpxB7nnuo+ukyoHswSzNeBeCaaJYjhsRdViqZjhw+eIE4jk9YcZbyjbZ4xzJKa+lT0208QWjQKjQD7vjA5RtR7niQTiX/gjl/z/IIrw3Yd6bCxtV4DY77O9Zicdhz4BvBFgbcRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eepk593v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-294f3105435so11075ad.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761845572; x=1762450372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpw0BP5/ZzTxyIySHSIgM8LC06W+8PMfB6mbIG7sCAw=;
        b=eepk593vSLHNrDUunk3lacbAqjj3urILsq5qHXMJTltgXrohD47nth5zBA+cAkj1BK
         ntjZIILSAC9+rd3/Erk4lvJqY7MRIYoTtMyX9gJ/HYmpxPW1Tb4hmjtsCjAXlrIpQ7Ja
         AZcGwPuC4LZZfU0d/wsYzCvONdiZa10rGeLUSrKQcFvAzQEA8ReGeEDa6k1A/SNJCi34
         P04EG2+2rsRfnarjiiLSKXqbUHFZglHo5pFyo/hsRP0vKG7GbD11Xn3diOkruUD0IfEt
         7CLEYKQCUtByzps8hzIeXtdC2/hUa6xAsUUt3lDLqeDb4i4DPLsbS+it856qL9S4Youn
         3+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761845572; x=1762450372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpw0BP5/ZzTxyIySHSIgM8LC06W+8PMfB6mbIG7sCAw=;
        b=Am7NJhfwy2RsbRt+U0vtO43fPO0+9HhDaNS6Fd82grfhN9q3IVsYT2oDMh4xrrJdkB
         T2ndOYqLHk4991IiBceoYVzFadgRy/q7nJ11Nh0PUnQ/r/C6IpiJ2WOd22n/Kh5mFS0u
         YjJmRA1AMCq7VbtLTbg1DEYex0B+tEGmOHIvTG5aiQqx4LfXPfl/95h1C356ctIiu/5B
         6m+N8/YQITtlYza6ZEgvlYVAstX3jtj45wK+vuYYMi+/0jPbDYX4AIHSNW7tOIbIHCsm
         ALJf/UByv+5XYOhG69OL79OVH9rQgzrIhVD5AeSSvX8gnXw6tLi0uKwWwT+QwOhngxTb
         090Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnH8Pdtgo7rXQRDShg5Lbiyf/lpwgFlxreMBRK5bS/Ef/z/Nq+6ajBFTtIvnRgj7Srnlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKO4a2VsjnUg0bAbTcwhlxGeOmKOtJeAHP8Cj4RWsWrpYXOn6E
	SA9yrsaq52HBi/W9PgLc7J17Kx4UltzrHPB2DfDfszZFxEZ04ILfn5Tk6GVeORhjSEwAe1XLRaQ
	AXKLUghUGR4NPbCmqxolvuS9duGIxKfYXsDQm4RWK
X-Gm-Gg: ASbGnctOBOfcuvflYXmRl073y23JMR3zoyuO3+5ynGh8fkPwA2nQnZxwcBTssEA6VGY
	IBVxoR4FkG3Iw2zKSlxNvfS0K7TLzKf4AiCcIwekdB5qeMuknHUjJOQqFILmZRriNXD2TBSuuTU
	kVRow/FWa6f5KAqbYmTe8cefuH5KcodfN22QuGNpA6FyAq57TPnmMO7yIC8gRyZGeoayYyOBshy
	t4VGOxrv4v1khrE4YVrl61vJY84Q44re2TJsIKLqWIwsfKms4YNffa5dTS8ZI+8q+/36+TjLw71
	24bW8omebrw27A==
X-Google-Smtp-Source: AGHT+IEZ/XuvUh4Pfc8TZEIT/XpCOGKsDHcvvo0a03Cba9wl9ismbj8nWmssEItMOyR2UpCaVJqHUMI+4tyrg3KSmMU=
X-Received: by 2002:a17:903:41cd:b0:294:e585:1f39 with SMTP id
 d9443c01a7336-2951e712296mr166825ad.14.1761845571153; Thu, 30 Oct 2025
 10:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
 <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
 <fc75b170-86c1-49b6-a321-7dca56ad824a@linux.alibaba.com> <eed27aaf-fd0a-4609-a30b-68e7c5c11890@linux.alibaba.com>
In-Reply-To: <eed27aaf-fd0a-4609-a30b-68e7c5c11890@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 10:32:39 -0700
X-Gm-Features: AWmQ_bk7tOF4s6AC5WJe-Q9QRXRXoirQ2SSsbTQkJYvIz4kH-3l4XMLuqNsKtvQ
Message-ID: <CAP-5=fVLGRsn7icH1cgmb==f5_D6Vr2CbzirAv7DY4Afjm4O2A@mail.gmail.com>
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org, 
	james.clark@arm.com, leo.yan@linaro.org, mingo@redhat.com, 
	baolin.wang@linux.alibaba.com, acme@kernel.org, mark.rutland@arm.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 5:55=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/10/24 10:45, Shuai Xue =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2025/10/24 00:08, Ian Rogers =E5=86=99=E9=81=93:
> >> On Wed, Oct 22, 2025 at 6:50=E2=80=AFPM Shuai Xue <xueshuai@linux.alib=
aba.com> wrote:
> >>>
> >>> When using perf record with the `--overwrite` option, a segmentation =
fault
> >>> occurs if an event fails to open. For example:
> >>>
> >>>    perf record -e cycles-ct -F 1000 -a --overwrite
> >>>    Error:
> >>>    cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interr=
upts. Try 'perf stat'
> >>>    perf: Segmentation fault
> >>>        #0 0x6466b6 in dump_stack debug.c:366
> >>>        #1 0x646729 in sighandler_dump_stack debug.c:378
> >>>        #2 0x453fd1 in sigsegv_handler builtin-record.c:722
> >>>        #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
> >>>        #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-eve=
nts.c:1862
> >>>        #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-event=
s.c:1943
> >>>        #6 0x458090 in record__synthesize builtin-record.c:2075
> >>>        #7 0x45a85a in __cmd_record builtin-record.c:2888
> >>>        #8 0x45deb6 in cmd_record builtin-record.c:4374
> >>>        #9 0x4e5e33 in run_builtin perf.c:349
> >>>        #10 0x4e60bf in handle_internal_command perf.c:401
> >>>        #11 0x4e6215 in run_argv perf.c:448
> >>>        #12 0x4e653a in main perf.c:555
> >>>        #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
> >>>        #14 0x43a3ee in _start ??:0
> >>>
> >>> The --overwrite option implies --tail-synthesize, which collects non-=
sample
> >>> events reflecting the system status when recording finishes. However,=
 when
> >>> evsel opening fails (e.g., unsupported event 'cycles-ct'), session->e=
vlist
> >>> is not initialized and remains NULL. The code unconditionally calls
> >>> record__synthesize() in the error path, which iterates through the NU=
LL
> >>> evlist pointer and causes a segfault.
> >>>
> >>> To fix it, move the record__synthesize() call inside the error check =
block, so
> >>> it's only called when there was no error during recording, ensuring t=
hat evlist
> >>> is properly initialized.
> >>>
> >>> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
> >>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >>
> >> This looks great! I wonder if we can add a test, perhaps here:
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-ne=
xt.git/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n435
> >> something like:
> >> ```
> >> $ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep 0=
.1
> >> ```
> >> in a new test subsection for test_overwrite? foobar would be an event
> >> that we could assume isn't present. Could you help with a test
> >> covering the problems you've uncovered and perhaps related flags?
> >>
> >
> > Hi, Ian,
> >
> > Good suggestion, I'd like to add a test. But foobar may not a good case=
.
> >
> > Regarding your example:
> >
> >    perf record -e foobar -a --overwrite -o /dev/null -- sleep 0.1
> >    event syntax error: 'foobar'
> >                         \___ Bad event name
> >
> >    Unable to find event on a PMU of 'foobar'
> >    Run 'perf list' for a list of valid events
> >
> >     Usage: perf record [<options>] [<command>]
> >        or: perf record [<options>] -- <command> [<options>]
> >
> >        -e, --event <event>   event selector. use 'perf list' to list av=
ailable events
> >
> >
> > The issue with using foobar is that it's an invalid event name, and the
> > perf parser will reject it much earlier. This means the test would exit
> > before reaching the part of the code path we want to verify (where
> > record__synthesize() could be called).
> >
> > A potential alternative could be testing an error case such as EACCES:
> >
> >    perf record -e cycles -C 0 --overwrite -o /dev/null -- sleep 0.1
> >
> > This could reproduce the scenario of a failure when attempting to acces=
s
> > a valid event, such as due to permission restrictions. However, the
> > limitation here is that users may override
> > /proc/sys/kernel/perf_event_paranoid, which affects whether or not this
> > test would succeed in triggering an EACCES error.
> >
> >
> > If you have any other suggestions or ideas for a better way to simulate
> > this situation, I'd love to hear them.
> >
> > Thanks.
> > Shuai
>
> Hi, Ian,
>
> Gentle ping.

Sorry, for the delay. I was trying to think of a better way given the
problems you mention and then got distracted. I wonder if a legacy
event that core PMUs never implement would be a good candidate to
test. For example, the event "node-prefetch-misses" is for "Local
memory prefetch misses" but the memory controller tends to be a
separate PMU and this event is never implemented to my knowledge.
Running this locally I see:

```
$ perf record -e node-prefetch-misses -a --overwrite -o /dev/null -- sleep =
0.1
Lowering default frequency rate from 4000 to 1750.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
Error:
Failure to open event 'cpu_atom/node-prefetch-misses/' on PMU
'cpu_atom' which will be removed.
No fallback found for 'cpu_atom/node-prefetch-misses/' for error 2
Error:
Failure to open event 'cpu_core/node-prefetch-misses/' on PMU
'cpu_core' which will be removed.
No fallback found for 'cpu_core/node-prefetch-misses/' for error 2
Error:
Failure to open any events for recording.
perf: Segmentation fault
   #0 0x55a487ad8b87 in dump_stack debug.c:366
   #1 0x55a487ad8bfd in sighandler_dump_stack debug.c:378
   #2 0x55a4878c6f94 in sigsegv_handler builtin-record.c:722
   #3 0x7f72aae49df0 in __restore_rt libc_sigaction.c:0
   #4 0x55a487b57ef8 in __perf_event__synthesize_id_index
synthetic-events.c:1862
   #5 0x55a487b58346 in perf_event__synthesize_id_index synthetic-events.c:=
1943
   #6 0x55a4878cb2a3 in record__synthesize builtin-record.c:2150
   #7 0x55a4878cdada in __cmd_record builtin-record.c:2963
   #8 0x55a4878d11ca in cmd_record builtin-record.c:4453
   #9 0x55a48795b3cc in run_builtin perf.c:349
   #10 0x55a48795b664 in handle_internal_command perf.c:401
   #11 0x55a48795b7bd in run_argv perf.c:448
   #12 0x55a48795bb06 in main perf.c:555
   #13 0x7f72aae33ca8 in __libc_start_call_main libc_start_call_main.h:74
   #14 0x7f72aae33d65 in __libc_start_main_alias_2 libc-start.c:128
   #15 0x55a4878acf41 in _start perf[52f41]
Segmentation fault
```

Thanks,
Ian

> Thanks.
> Shuai
>

