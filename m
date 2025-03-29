Return-Path: <bpf+bounces-54885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ECDA753F3
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 02:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CF83B4C1E
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 01:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5121DFFC;
	Sat, 29 Mar 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4ycEgvD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1843211C;
	Sat, 29 Mar 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743212810; cv=none; b=XbSGXZy+By0aUqKT+Efl7eCNgaXJDKepZyHOTehg+9/3L7KJFfn/AIv07vKEQN2uj49iaLa4nIdSYuAGH/2ofoiLTxw092KqPbolVtkKf6/6/MHaz2fxRmZEiCQ9BFOi7YJ/cTtQo+Re56mxizMrVNaW00Gfrp3gKXTjXtUer+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743212810; c=relaxed/simple;
	bh=lhvXPa0nxJnGhN/4fxUGKhs6NI6Qmck2C4se3f0M5tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUOHC8gt/jsxm4oWVUS8moQRCbclR+rfpAkFFEmX5Ugnm3o63mXfoHynItmRi7hGT5xl3rdGKc5ONDzUeXSoOnKdBcTYZRa3Y93avuEKa3YYeen2uPW2a1dd4MnVChvPKcBynYKLOK800ScnCHlnWO1HVyg04AqhXVOpyhJDp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4ycEgvD; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7c9e9592so22680517b3.1;
        Fri, 28 Mar 2025 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743212807; x=1743817607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TncBKU6AcxksgY/OOV55sG+sFm3UTJtNKztE6kQ9ml8=;
        b=a4ycEgvDWtCiPjWGHeP3f19+bLckJ41FTmX0G93AjTr+rV/kNnuIsfNtfCLl2dsAKI
         wKyb9FRY0P8qwSxhZjA0ojJ6Ao46w+5dgXKVxJ8BQHxst4kYEOArzPw/M9SpajxGrRC4
         oUsIBRJiviqNP+3exiFgnlSw+3oVN1Ul6MR1eLecuSFR0yukhu63Su2JXZwMN5JG4+Na
         A5JBVyEdsm4zpnY6bP7jDx7LH2fl6P8x5GdVItZFOf5sa5Y1VrdU70K+JHFo5uNqMlFH
         JysN05TZ5fEFeWL0fiUFUbWZSQEjbFe5GFU6tBAtwT8b+3Egw+/gfk5Sq3lP3hFB7cn/
         ZPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743212807; x=1743817607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TncBKU6AcxksgY/OOV55sG+sFm3UTJtNKztE6kQ9ml8=;
        b=v3Uovr6jEFgQjHxjNNlBFmbjJUMIpAg6tWaAqvY6gb1UVBoS3wxF83kUfohr2osl07
         OVKNWsZyiiOPMpQjjOfWNZegQeRfPgxF5yFOf/Z9/jYrLeCz6Rixw+BGGSbODY2Xq3MP
         PhbmdB0RNV8PLhLp3kGYX49ZR4ZCxlLwf77zyfQHiVBGfyhTWS257S3yX3bXKhzm1GM2
         gLAeScS6FTVQq1Y3owd7IPLKcndFtf77Eloo7QKhR1uy6eph82zBQyWBkCTCBzVF4iST
         yNeb7QwdQOUdAlPmiFXLhZ47iiqSQMj2mi7IEbmxYrM9s6Y76s6t2TjJrDk0BGZ+Ly20
         nibA==
X-Forwarded-Encrypted: i=1; AJvYcCUD+ZnLfw/rWE5UgOkoKowpgHCtpWVXpnuGf9bAusF5jp/xh3l9cDHlHRJj0VOhSHF5Gog=@vger.kernel.org, AJvYcCVbnzZWm1rrRAbvmX8OPHfo4wza2pc8MlYN/ZHHcT2hX5m59AieAI5RF9qgdrC4O6tZcw9FXRRtnP1dCl5rzjUNRw==@vger.kernel.org, AJvYcCWQihJtGJ6xCRxmi7c8unJ9xlr0ST/6vemAxfW5878Y/iJAmuOfSvb1Ha4RJAaB/nsfrmciIUiwE9e1AL8M@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwwyi4OFbIH1REb/xwxIRm+8q6v7hoKAi/UQUKdbxd6jAl3I8G
	YSnsvr8F3LJA4FQA5B/iwMcnsqthzF/p7nNPAaFVSUK9qe/hDgiREEABCukCnrhMjBzir/STAti
	c0rGTEgfhQXp1+Y+LzcxibHaMqDI=
X-Gm-Gg: ASbGncuF0Lg8RMlhVTp8lYOUzUOUVdZNBUXLwGoV0VredzP97iUxKB/vYODLH/E3cJN
	gastH8H/Rja0xj+m1ycFKbu+eGI4N4tvUCRKWHSLO3JafVma6gRsKHB9DPr3Hr2oYBvD9TGOt8z
	HxTmufAJOCn+swuVUHO7BXZ+DP
X-Google-Smtp-Source: AGHT+IFIw76mR9mPQgfOugOaVlvQZQnggALu9dgcLG9xFW76nFWLKWlblFuAGIg7dyQcSo8Rf1CoQYfRR0RsNR7S+Tc=
X-Received: by 2002:a05:690c:4c91:b0:702:5920:c3c8 with SMTP id
 00721157ae682-7025920c469mr10803737b3.8.1743212807444; Fri, 28 Mar 2025
 18:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326044001.3503432-1-namhyung@kernel.org>
In-Reply-To: <20250326044001.3503432-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 28 Mar 2025 18:46:36 -0700
X-Gm-Features: AQ5f1JoQz2LFdXwiMdZRMYs6-sRW7Fdj18A30tcOv07eNmUQedA_Id6rblbX2z0
Message-ID: <CAH0uvojPaZ-byE-quc=sUvXyExaZPU3PUjdTYOzE5iDAT_wNVA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf trace: Implement syscall summary in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Tue, Mar 25, 2025 at 9:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> When -s/--summary option is used, it doesn't need (augmented) arguments
> of syscalls.  Let's skip the augmentation and load another small BPF
> program to collect the statistics in the kernel instead of copying the
> data to the ring-buffer to calculate the stats in userspace.  This will
> be much more light-weight than the existing approach and remove any lost
> events.
>
> Let's add a new option --bpf-summary to control this behavior.  I cannot
> make it default because there's no way to get e_machine in the BPF which
> is needed for detecting different ABIs like 32-bit compat mode.
>
> No functional changes intended except for no more LOST events. :)
>
>   $ sudo ./perf trace -as --summary-mode=3Dtotal --bpf-summary sleep 1
>
>    Summary of events:
>
>    total, 6194 events
>
>      syscall            calls  errors  total       min       avg       ma=
x       stddev
>                                        (msec)    (msec)    (msec)    (mse=
c)        (%)
>      --------------- --------  ------ -------- --------- --------- ------=
---     ------
>      epoll_wait           561      0  4530.843     0.000     8.076   520.=
941     18.75%
>      futex                693     45  4317.231     0.000     6.230   500.=
077     21.98%
>      poll                 300      0  1040.109     0.000     3.467   120.=
928     17.02%
>      clock_nanosleep        1      0  1000.172  1000.172  1000.172  1000.=
172      0.00%
>      ppoll                360      0   872.386     0.001     2.423   253.=
275     41.91%
>      epoll_pwait           14      0   384.349     0.001    27.453   380.=
002     98.79%
>      pselect6              14      0   108.130     7.198     7.724     8.=
206      0.85%
>      nanosleep             39      0    43.378     0.069     1.112    10.=
084     44.23%
>      ...
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v4)
>  * fix segfault on -S  (Howard)
>  * correct some comments  (Howard)

+ if (!hashmap__find(hash, map_key->nr, &data)) {

I think you should mention the hashmap's map_key->nr update, as this
change is actually important for the feature.

>
> v3)
>  * support -S/--with-summary option too  (Howard)
>  * make it work only with -a/--all-cpus  (Howard)
>  * fix stddev calculation  (Howard)
>  * add some comments about syscall_data  (Howard)
>
> v2)
>  * Rebased on top of Ian's e_machine changes
>  * add --bpf-summary option
>  * support per-thread summary
>  * add stddev calculation  (Howard)
>
>  tools/perf/Documentation/perf-trace.txt       |   6 +
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-trace.c                    |  54 ++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf-trace-summary.c           | 347 ++++++++++++++++++
>  .../perf/util/bpf_skel/syscall_summary.bpf.c  | 118 ++++++
>  tools/perf/util/bpf_skel/syscall_summary.h    |  25 ++
>  tools/perf/util/trace.h                       |  37 ++
>  8 files changed, 577 insertions(+), 13 deletions(-)
>  create mode 100644 tools/perf/util/bpf-trace-summary.c
>  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
>  create mode 100644 tools/perf/util/trace.h
>
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documen=
tation/perf-trace.txt
> index 887dc37773d0f4d6..a8a0d8c33438fef7 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -251,6 +251,12 @@ the thread executes on the designated CPUs. Default =
is to monitor all CPUs.
>         pretty-printing serves as a fallback to hand-crafted pretty print=
ers, as the latter can
>         better pretty-print integer flags and struct pointers.
>
> +--bpf-summary::
> +       Collect system call statistics in BPF.  This is only for live mod=
e and
> +       works well with -s/--summary option where no argument information=
 is
> +       required.

It works with -S as well, doesn't it?

Anyway, I don't mind adding these details later on, so

Reviewed-by: Howard Chu <howardchu95@gmail.com>

