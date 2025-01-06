Return-Path: <bpf+bounces-47940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24002A02087
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065071635FB
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB01D6DB1;
	Mon,  6 Jan 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovf+6V3k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DAD4A04;
	Mon,  6 Jan 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151625; cv=none; b=H9sYJBZNAM9ttHKlzl02deLOOrwLq3OzmkTelwL8tn+ELi5xUZBobV5a4jBOqZAyq9W4pnCWtekcJmS9VVrqWkphj2bSF2+nI1j5RdyRoTj1mF2LVOwmh/zSHQ9SxSHXxPVUzZG6INbVopH3RSVD6r1b1iNmtS1x2Wq91CsSZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151625; c=relaxed/simple;
	bh=6GixmoG+3+b+D0THHE18JyNslvfoVFs48o9nkhfIygY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRSGHUhrf1cO5VHN1cFp/rODqX7QBksOP5mnSLyQA8H7IWWCrnHxJazuVPWIskhi8AXmcQVa6k3cJo1r7+H2B/GM97DN5sRjZJRNifOz6Ad76CGMpEcNkGScSzO2of9MhzA4AkIvnLlaRjEJH1zO7983Ad/QA+lIU31P1T/zD3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovf+6V3k; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3fd6cd9ef7so19403135276.1;
        Mon, 06 Jan 2025 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736151623; x=1736756423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A162jcE+dcZbXBQ3NVUikao2g+sNPSwsAqt9k6Pv4f0=;
        b=Ovf+6V3kUrewOUCUnDMEvK17gJl7IqLDchAg8i5HRqA7+DBxxTjq0dzOB9KIduVlaB
         LHZDswaqr4+SQEzyi+rNnBd8U79Ud9cjhFGmScieRejTOv6DyyQhtnsYI1MaJwsKo/iV
         Nm5XbBy/NE594Jusko/PXYrujxmL4rxXGWuPcXGOvCf9ey3LN0bT8kId4e9tti1+l+pU
         ONsq8DN8gQV1e3zSjTD2+kp1cuPhH/gk/4kbqsU2WsS5hdtGK0ODeLcgsi7XCxQ6SP83
         mOuQ427xAM/e6iB91IAzFjTGwRkInBE+cwJ/o4zqSkIx0JJgpSaP8QUc30LogtLrne5w
         ZJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736151623; x=1736756423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A162jcE+dcZbXBQ3NVUikao2g+sNPSwsAqt9k6Pv4f0=;
        b=S4E9bwCNlkgttD4thTA5PmtEo2dU6VdCSPmTCTY9MorQRnSAzv4g8n7mEGG2tMie8O
         LdzgKrq1FTn6yplZ+YUZX8Urz0+D5FVdb18plaP9x9Ts/qEEum7zBFK/6v8cv2xcCAjZ
         dagnNLNvcWJ4IBgTLCdWte/CvpYSGkwNb/JrGvn4sXv3SGL6y+FsXy+rAy0fE2CLeZJw
         oR/KrbsVY6+8wTMwR7gG/Dr3+BCl5ouIZxpmP9tJcVjasD1CtOXkYgaYOzLZYXLmrHiv
         +mY4s5rezLBO6JqzfQNqLWFkoBL8Ysni4PrfTth7I/+oRxZthV7xUlk19LQeCy7uX4fk
         XG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOig2HrtBZJuO6nTY5iUvv2CsvH5goa7Aovj756m/tWd0Nfrcbu2I/M/CfeMkS+1X+Xpw=@vger.kernel.org, AJvYcCWuQFNQ0WHzH5ly5CWlH1SFlZWRk1KTyovyVof6jmc1tkhpnDwaHtKx1k8ggfrOjTRPqrgNs4geHGZvLt+O@vger.kernel.org, AJvYcCXwqgojB3z8bhvTNcXGd1h4WgXjiGOncy/4PE+rRQgr/p6EF93AQRDmGaOhNxQfhKYvL7QZaz8LGd6tIemN6nkmQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuj3zNhxzKiwhKmLjv8iVEWrSjTa9rKoZDb4YUiuUGpYgoXCj3
	Qo7GnzUo1+2u6yHNXYYeXFflMH1EtJZRpN+cRk7WlfLDeD2TpKffFimfT2nFS3YBRLG0FRTFG7C
	GNxUnWX2gnLlN++G6gDp+aYEkQe8=
X-Gm-Gg: ASbGnctwgOksIPckuUDM8Wh0i3IU7mMfmKexVH/KPZAsMLAM+5qxwBVU/qUUf7+EZLa
	Fg8H7e9OE3+lHEs22LlauPUcS7BR9feH5c38V
X-Google-Smtp-Source: AGHT+IEYAJMaykbg1DUSBx3whgCODzUTMb02CArEp3mxJe5MnRzaAxUAt9ecr3Z+Ybu9+xQmFDb64GdR/wIQwMV2478=
X-Received: by 2002:a05:690c:3687:b0:6f0:301:5fea with SMTP id
 00721157ae682-6f3e2ac4f92mr405375757b3.12.1736151622856; Mon, 06 Jan 2025
 00:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102201248.790841-1-namhyung@kernel.org>
In-Reply-To: <20250102201248.790841-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 6 Jan 2025 00:20:11 -0800
Message-ID: <CAH0uvogzMcLXmr9KLT8CzmC0u4UgQ_2QGrpdOCzWWDjQbCL=Uw@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix unaligned access for augmented args
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

Thanks for the fix, and sorry for the delay and for making you do
this. I should've done it myself earlier. This bug is present in the
commit without the whole BTF thing.

Here is the commit before '45a0c928e7aa perf trace: BTF-based enum
pretty printing for syscall args'

$ git log --oneline
bfa54a793ba7 (HEAD) driver core: bus: Fix double free in driver API
bus_register()

perf $ UBSAN_OPTIONS=3Dprint_stacktrace=3D1 ./perf trace -- sleep 1
builtin-trace.c:1715:35: runtime error: index 6 out of bounds for type
'syscall_arg_fmt [6]'
    #0 0x5d0994789a74 in syscall__alloc_arg_fmts
/root/hw/linux-perf/tools/perf/builtin-trace.c:1715
    #1 0x5d099478b72c in trace__read_syscall_info
/root/hw/linux-perf/tools/perf/builtin-trace.c:1868
    #2 0x5d099478e571 in trace__syscall_info
/root/hw/linux-perf/tools/perf/builtin-trace.c:2179
    #3 0x5d099479ac81 in trace__init_syscall_bpf_progs
/root/hw/linux-perf/tools/perf/builtin-trace.c:3333
    #4 0x5d099479c28c in trace__init_syscalls_bpf_prog_array_maps
/root/hw/linux-perf/tools/perf/builtin-trace.c:3466
    #5 0x5d09947a0098 in trace__run
/root/hw/linux-perf/tools/perf/builtin-trace.c:3932
    #6 0x5d09947aa62d in cmd_trace
/root/hw/linux-perf/tools/perf/builtin-trace.c:5073
    #7 0x5d09947b6eed in run_builtin /root/hw/linux-perf/tools/perf/perf.c:=
350
    #8 0x5d09947b7518 in handle_internal_command
/root/hw/linux-perf/tools/perf/perf.c:403
    #9 0x5d09947b77ef in run_argv /root/hw/linux-perf/tools/perf/perf.c:447
    #10 0x5d09947b7d5e in main /root/hw/linux-perf/tools/perf/perf.c:561
    #11 0x7ec47642a1c9 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #12 0x7ec47642a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #13 0x5d0994615d34 in _start
(/root/hw/linux-perf/tools/perf/perf+0x4bdd34) (BuildId:
791904aaae2afa7e7ad7e3aa80a32b71e824abcf)

         ? (         ): sleep/180215  ... [continued]: execve())
                                    =3D 0
     0.039 ( 0.002 ms): sleep/180215 brk()
                                    =3D 0x604c45ccb000
     0.075 ( 0.005 ms): sleep/180215 mmap(len: 8192, prot: READ|WRITE,
flags: PRIVATE|ANONYMOUS)           =3D 0x7ff6de94d000

builtin-trace.c:1531:55: runtime error: member access within
misaligned address 0x7ec47192343c for type 'struct augmented_arg',
which requires 8 byte alignment
0x7ec47192343c: note: pointer points here
  f6 7f 00 00 13 00 00 00  2f 65 74 63 2f 6c 64 2e  73 6f 2e 70 72 65
6c 6f  61 64 00 00 00 00 00 00
              ^
    #0 0x5d0994788527 in syscall_arg__scnprintf_augmented_string
/root/hw/linux-perf/tools/perf/builtin-trace.c:1531
    #1 0x5d09947887ca in syscall_arg__scnprintf_filename
/root/hw/linux-perf/tools/perf/builtin-trace.c:1545
    #2 0x5d099478d436 in syscall_arg_fmt__scnprintf_val
/root/hw/linux-perf/tools/perf/builtin-trace.c:2044
    #3 0x5d099478dd8b in syscall__scnprintf_args
/root/hw/linux-perf/tools/perf/builtin-trace.c:2106
    #4 0x5d0994790c44 in trace__sys_enter
/root/hw/linux-perf/tools/perf/builtin-trace.c:2387
    #5 0x5d0994799ba5 in trace__handle_event
/root/hw/linux-perf/tools/perf/builtin-trace.c:3198
    #6 0x5d099479d3eb in __trace__deliver_event
/root/hw/linux-perf/tools/perf/builtin-trace.c:3635
    #7 0x5d099479d6c9 in trace__deliver_event
/root/hw/linux-perf/tools/perf/builtin-trace.c:3662
    #8 0x5d09947a0cc4 in trace__run
/root/hw/linux-perf/tools/perf/builtin-trace.c:4010
    #9 0x5d09947aa62d in cmd_trace
/root/hw/linux-perf/tools/perf/builtin-trace.c:5073
    #10 0x5d09947b6eed in run_builtin /root/hw/linux-perf/tools/perf/perf.c=
:350
    #11 0x5d09947b7518 in handle_internal_command
/root/hw/linux-perf/tools/perf/perf.c:403
    #12 0x5d09947b77ef in run_argv /root/hw/linux-perf/tools/perf/perf.c:44=
7
    #13 0x5d09947b7d5e in main /root/hw/linux-perf/tools/perf/perf.c:561
    #14 0x7ec47642a1c9 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #15 0x7ec47642a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #16 0x5d0994615d34 in _start
(/root/hw/linux-perf/tools/perf/perf+0x4bdd34) (BuildId:
791904aaae2afa7e7ad7e3aa80a32b71e824abcf)

     <snip>

trace/beauty/timespec.c:12:9: runtime error: member access within
misaligned address 0x7ec4719264b4 for type 'struct timespec', which
requires 8 byte alignment
0x7ec4719264b4: note: pointer points here
  00 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  00 00 00 00 00 00 00 00
              ^
    #0 0x5d09947b02e7 in syscall_arg__scnprintf_augmented_timespec
trace/beauty/timespec.c:12
    #1 0x5d09947b0417 in syscall_arg__scnprintf_timespec
trace/beauty/timespec.c:18
    #2 0x5d099478d436 in syscall_arg_fmt__scnprintf_val
/root/hw/linux-perf/tools/perf/builtin-trace.c:2044
    #3 0x5d099478dd8b in syscall__scnprintf_args
/root/hw/linux-perf/tools/perf/builtin-trace.c:2106
    #4 0x5d0994790c44 in trace__sys_enter
/root/hw/linux-perf/tools/perf/builtin-trace.c:2387
    #5 0x5d0994799ba5 in trace__handle_event
/root/hw/linux-perf/tools/perf/builtin-trace.c:3198
    #6 0x5d099479d3eb in __trace__deliver_event
/root/hw/linux-perf/tools/perf/builtin-trace.c:3635
    #7 0x5d099479d6c9 in trace__deliver_event
/root/hw/linux-perf/tools/perf/builtin-trace.c:3662
    #8 0x5d09947a0cc4 in trace__run
/root/hw/linux-perf/tools/perf/builtin-trace.c:4010
    #9 0x5d09947aa62d in cmd_trace
/root/hw/linux-perf/tools/perf/builtin-trace.c:5073
    #10 0x5d09947b6eed in run_builtin /root/hw/linux-perf/tools/perf/perf.c=
:350
    #11 0x5d09947b7518 in handle_internal_command
/root/hw/linux-perf/tools/perf/perf.c:403
    #12 0x5d09947b77ef in run_argv /root/hw/linux-perf/tools/perf/perf.c:44=
7
    #13 0x5d09947b7d5e in main /root/hw/linux-perf/tools/perf/perf.c:561
    #14 0x7ec47642a1c9 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #15 0x7ec47642a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #16 0x5d0994615d34 in _start
(/root/hw/linux-perf/tools/perf/perf+0x4bdd34) (BuildId:
791904aaae2afa7e7ad7e3aa80a32b71e824abcf)

As seen above, I encountered the same runtime error of misalignment as
you did in https://lore.kernel.org/all/Z2STgyD1p456Qqhg@google.com/,
not just in time_spec.c, but also in the access of augmented_arg in
builtin-trace.c.

On Thu, Jan 2, 2025 at 12:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Some version of compilers reported unaligned accesses in perf trace when
> undefined-behavior sanitizer is on.  I found that it uses raw data in the
> sample directly and assuming it's properly aligned.
>
> Unlike other sample fields, the raw data is not 8-byte aligned because
> there's a size field (u32) before the actual data.  So I added a static
> buffer in syscall__augmented_args() and return it instead.  This is not
> ideal but should work well as perf trace is single-threaded.
>
> A better approach would be aligning the raw data by adding a 4-byte data
> before the augmented args but I'm afraid it'd break the backward
> compatibility.

Can you explain backward compatibility? Do you mean the 'perf trace
record' and its perf data file?

With your patch attached:

perf $ UBSAN_OPTIONS=3Dprint_stacktrace=3D1 ./perf trace -e
clock_nanosleep -- sleep 1
builtin-trace.c:1966:35: runtime error: index 6 out of bounds for type
'syscall_arg_fmt [6]'
    #0 0x577f3fc3d18c in syscall__alloc_arg_fmts
/root/hw/linux-perf/tools/perf/builtin-trace.c:1966
    #1 0x577f3fc3f0c1 in trace__read_syscall_info
/root/hw/linux-perf/tools/perf/builtin-trace.c:2129
    #2 0x577f3fc422ff in trace__syscall_info
/root/hw/linux-perf/tools/perf/builtin-trace.c:2466
    #3 0x577f3fc51b30 in trace__init_syscalls_bpf_prog_array_maps
/root/hw/linux-perf/tools/perf/builtin-trace.c:3927
    #4 0x577f3fc5591c in trace__run
/root/hw/linux-perf/tools/perf/builtin-trace.c:4365
    #5 0x577f3fc5fd48 in cmd_trace
/root/hw/linux-perf/tools/perf/builtin-trace.c:5532
    #6 0x577f3fc6c697 in run_builtin /root/hw/linux-perf/tools/perf/perf.c:=
351
    #7 0x577f3fc6ccc2 in handle_internal_command
/root/hw/linux-perf/tools/perf/perf.c:404
    #8 0x577f3fc6cf99 in run_argv /root/hw/linux-perf/tools/perf/perf.c:448
    #9 0x577f3fc6d503 in main /root/hw/linux-perf/tools/perf/perf.c:560
    #10 0x72edf8a2a1c9 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #11 0x72edf8a2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #12 0x577f3fac12c4 in _start
(/root/hw/linux-perf/tools/perf/perf+0x4e82c4) (BuildId:
bca8e50b69a43c91b4d187140c12c6608770d99e)

     0.000 (1000.225 ms): sleep/330971 clock_nanosleep(rqtp: {
.tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7fff11ba9dc0) =3D 0

No more misalignment, and I'll fix the index-out-of-bound bug.

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks
Howard

