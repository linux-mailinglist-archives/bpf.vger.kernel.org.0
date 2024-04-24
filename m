Return-Path: <bpf+bounces-27719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744F8B134B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0A21F21C9B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6B22638;
	Wed, 24 Apr 2024 19:12:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E501D53F;
	Wed, 24 Apr 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985960; cv=none; b=VNHRiJs4Kw/Y3d1a1rDV8HlIEZi4LTA0kKOeLzdk+r1kqIx/BTxvsUnBlNpxJZ90RRGa4BtDzccBGS9SLYbaYfZBF9IjJCpmUcXYrlmxSMr3bVtrZai6dMSf0v2CeSKSEBoyMBrgKLqwypC7r0J1a/JCPEMBr7Ov8JqrT7p6vYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985960; c=relaxed/simple;
	bh=qyndtPG2sprHQimLpvd+FVVE3nnSCb6FDX2FQq61fFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtWyTXJI+pqjrdONmHk9RcvBhwyFs3mWq/fqYNpuch0ctfHe0GvTrzESjBm0QKeM6NOqhXHaqm/qgw0qws9ZrhocTeRHH5iF5RiM0P64LzrRtQSv5JYoXDyaR23N//wzRYMllMnqaWgCeyZuqRHUYCOlFqzbacn2taUATNUclnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so164828a12.1;
        Wed, 24 Apr 2024 12:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985958; x=1714590758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMJvpS4yYOzmD3lN/3lPYHGqlIec0fhl9asbJwOIgeo=;
        b=DOLMJ38wJUmdAzePkngKXjwLPRxgzDTEy+dY6Qh9jKAeVJ5u9TNUchlP9iHw7WO3eB
         89KHXgFdkqDkT0oBDkdTDjRMGMEd+B79zT3H7GNrLpUOOdTnUKbGQE9LU7vXzGeKJNls
         a9DbqGVfLRS13yTL0oqLrI22+e1HblgqHtTGfPG0z2oE0+1gmiewlU1ZSgsiAHNT1Wl+
         iXqT3HusgQd25F/IvylE9vN9W/fVFCdpK0pbTM2XPCzw73yWC4sXrNlOJFwjtS3hKWvs
         1Dni4SahDo9GUylPhsAljBFPLHk5dGYMlEEKU04VhstjYrNMZYX9ik6SdLDhO3ytyeq+
         bL7g==
X-Forwarded-Encrypted: i=1; AJvYcCVtpsf/PYy+NHLLl6u52DhUo///0b2mnSXyFI2OhrYhQN6Hgv1a77kiRGcEJB1y+15xEnMzigc6S3c2TCBhNP+PPxsWnFfzni6Hc+VjJ5EwmGOrWz3YyobERwUplCSuMK2v+sNFhEZKXrzkNicG7M4HufM3Jjpdfhx3zCvkWP4HwsWygg==
X-Gm-Message-State: AOJu0Yy+z3+hQjEe4yBDWfviWyclfwSMtTPSdEdj5AVLxlmDNAaIkYES
	0pMVq0Wdle2tWoeU8NWlsYwFuuH+v1BfxExM+0rfMPry5G4/GiMiJrsDH5+Fp/Bp5WRfZJP3u9f
	P1DDCdzenz2/ZBoGJUpIsZBDa/Cc=
X-Google-Smtp-Source: AGHT+IHs0dgN9nbxvoobWFjcgTWb5F8D8uMPQkYeG/mZ2DzvrgXHW0jzB4AHpcLjBihjXo8O7DTZtk16gT985W8QeCg=
X-Received: by 2002:a17:90a:d583:b0:2ad:da23:da0b with SMTP id
 v3-20020a17090ad58300b002adda23da0bmr3871882pju.34.1713985958350; Wed, 24 Apr
 2024 12:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024805.144759-1-howardchu95@gmail.com>
In-Reply-To: <20240424024805.144759-1-howardchu95@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 24 Apr 2024 12:12:26 -0700
Message-ID: <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 23, 2024 at 7:46=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
>
> Currently, off-cpu samples are dumped when perf record is exiting. This
> results in off-cpu samples being after the regular samples. Also, samples
> are stored in large BPF maps which contain all the stack traces and
> accumulated off-cpu time, but they are eventually going to fill up after
> running for an extensive period. This patch fixes those problems by dumpi=
ng
> samples directly into perf ring buffer, and dispatching those samples to =
the
> correct format.

Thanks for working on this.

But the problem of dumping all sched-switch events is that it can be
too frequent on loaded machines.  Copying many events to the buffer
can result in losing other records.  As perf report doesn't care about
timing much, I decided to aggregate the result in a BPF map and dump
them at the end of the profiling session.

Maybe that's not a concern for you (or smaller systems).  Then I think
we can keep the original behavior and add a new option (I'm not good
at naming things, but maybe --off-cpu-sample?) to work differently
instead of removing the old behavior.

Thanks,
Namhyung

>
> Before, off-cpu samples are after regular samples
>
> ```
>          swapper       0 [000] 963432.136150:    2812933    cycles:P:  ff=
ffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
>          swapper       0 [000] 963432.637911:    4932876    cycles:P:  ff=
ffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
>          swapper       0 [001] 963432.798072:    6273398    cycles:P:  ff=
ffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
>          swapper       0 [000] 963433.541152:    5279005    cycles:P:  ff=
ffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> sh 1410180 [000] 18446744069.414584:    2528851 offcpu-time:
>             7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)
>
>
> sh 1410185 [000] 18446744069.414584:    2314223 offcpu-time:
>             7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)
>
>
> awk 1409644 [000] 18446744069.414584:     191785 offcpu-time:
>             702609d03681 read+0x11 (/usr/lib/libc.so.6)
>                   4a02a4 [unknown] ([unknown])
> ```
>
>
> After, regular samples(cycles:P) and off-cpu(offcpu-time) samples are
> collected simultaneously:
>
> ```
> upowerd     741 [000] 963757.428701:     297848 offcpu-time:
>             72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)
>
>
>       irq/9-acpi      56 [000] 963757.429116:    8760875    cycles:P:  ff=
ffffffb779849f acpi_os_read_port+0x2f ([kernel.kallsyms])
> upowerd     741 [000] 963757.429172:     459522 offcpu-time:
>             72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)
>
>
>          swapper       0 [002] 963757.434529:    5759904    cycles:P:  ff=
ffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> perf 1419260 [000] 963757.434550: 1001012116 offcpu-time:
>             7274e5d190bf __poll+0x4f (/usr/lib/libc.so.6)
>             591acfc5daf0 perf_evlist__poll+0x24 (/root/hw/perf-tools-next=
/tools/perf/perf)
>             591acfb1ca50 perf_evlist__poll_thread+0x160 (/root/hw/perf-to=
ols-next/tools/perf/perf)
>             7274e5ca955a [unknown] (/usr/lib/libc.so.6)
> ```
>
> Here's a simple flowchart:
>
> [parse_event (sample type: PERF_SAMPLE_RAW)] --> [config (bind fds,
> sample_id, sample_type)] --> [off_cpu_strip (sample type: PERF_SAMPLE_RAW=
)] -->
> [record_done(hooks off_cpu_finish)] --> [prepare_parse(sample type: OFFCP=
U_SAMPLE_TYPES)]
>
> Changes in v2:
>  - Remove unnecessary comments.
>  - Rename function off_cpu_change_type to off_cpu_prepare_parse
>
> Howard Chu (4):
>   perf record off-cpu: Parse off-cpu event, change config location
>   perf record off-cpu: BPF perf_event_output on sched_switch
>   perf record off-cpu: extract off-cpu sample data from raw_data
>   perf record off-cpu: delete bound-to-fail test
>
>  tools/perf/builtin-record.c             |  98 +++++++++-
>  tools/perf/tests/shell/record_offcpu.sh |  29 ---
>  tools/perf/util/bpf_off_cpu.c           | 242 +++++++++++-------------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 163 +++++++++++++---
>  tools/perf/util/evsel.c                 |   8 -
>  tools/perf/util/off_cpu.h               |  14 +-
>  tools/perf/util/perf-hooks-list.h       |   1 +
>  7 files changed, 344 insertions(+), 211 deletions(-)
>
> --
> 2.44.0
>

