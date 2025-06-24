Return-Path: <bpf+bounces-61333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14573AE5936
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D847A53FC
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5821B043F;
	Tue, 24 Jun 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMH0lzwJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45A219ED;
	Tue, 24 Jun 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728559; cv=none; b=upK82s3wf0JkHgTSx1Uw34WKloVS/zmAGNB55QP+89crtBWmce20YkacCf0TOhwSdXgspXKVra6TOPbDWxuH7uRlzdzPT2FXZEE3xtDZFC5mGDNHSlo9OIEQejcKSX7e3MUFRsOO6LVB14caOdr1FYSjKljXeWCz3WQ0o8ZTRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728559; c=relaxed/simple;
	bh=MWT+bjWZFa+bK7pyT9vbeDp9pFi/nWjEtOUDhEemeuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibay0Ma0u4v77owamSVWEO7pYBTHMZhQTh8ONlfya1tr0o5xaTsdzE8cQLXEzCKnJ7sDUX0OwrE8JKKO9UvHP0ssQX2qYSGKo2W7+j7yNz86FCbYvL11Jj6QcyJOS0ZvH900aF2+ja/igM9kHJeazJI1SsEofxCXb6r0W1PvnA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMH0lzwJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2363616a1a6so38840985ad.3;
        Mon, 23 Jun 2025 18:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750728557; x=1751333357; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7C/AvsVjKXGOCeuen0fY1kmunTzFwWn29v3UAYJXPVg=;
        b=VMH0lzwJGx2icdcgqd/dztsPCob8xXVL8MJX1uEO5fdKfLDrobXLjU5wrHu/F+/m7g
         RySsBcqx2c8z+Z6TP9bjvY1jAIZ/DsZbPKshfho1qYgFotnJmbyHKI1A7TvM6qmRRSTY
         NHOkN1Gwp4h6BEy+uRCxNbdOWBqC0S0hvlUjYfgbDm02BO8LPsG8UKTcowz/fUHPNwtq
         5BYr+sNEd17CvUrPgNs8rkfP9RM9oBoxcSieYBTFrp/1mRgbJJG0h1x5mSEXYydR5Y6Y
         SdRXsvpOKi8389TV8K/4jUTBLGQW92EPP0DJV1ffsXvMBZDAOoVORsDafkGwiLXAgH3w
         HXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750728557; x=1751333357;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C/AvsVjKXGOCeuen0fY1kmunTzFwWn29v3UAYJXPVg=;
        b=JRf4R8J5ekWJ6m/hw7B98vg+axgehwAeCZSNDqaZN/opolBBnuaAfumvWpFm1twI4s
         xbBPQvBFG2VvA61+ziJTZHznxCmxtX0KwvTPkaD1ipk6J372imJelJqDRwzhnzn8Ob1j
         jrpSAbT9mNWlU+MJ1AVMC20mSlXGZqvqNkYs80RS4G3o3VUmEZ++1AEr6oB0phsc87YM
         QQXjeknPYhNQ8KfzBOXW4ot+cr+gfApLobXh/NOhIY7pVwxKPaCUaBFb/rg/vLBTuniz
         eDytuG7tcUKYqLB8E/1vEXXagjK9vnyQiBF4iLXcdDoAeK1higrf66bhx3EqX+8d6QuB
         bSkg==
X-Forwarded-Encrypted: i=1; AJvYcCUQEH4Q2SZFRg89oi51wMKz+IDtNeSCYZG+Qg08p5DoTgqqYYn/NwbtR5/3JUDXEwMZzYrADaXU5TRK0ka6HNbY8Q==@vger.kernel.org, AJvYcCWzQUCUTQXr/Bh2F/SZxHBOLjTJ1EMtMx3tq6gB9QpIM14/6T4dZz+m+5N/1jslFJeMnf+26vT+xar4tlO4@vger.kernel.org, AJvYcCXei90yst6lqtpbMhoR2ZmLaEvhujGN5ksk1vurSnNVu4+wXUcMZy7aG4IUxW5N1cPvU3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ldnSxd4ye596ixCV5yjsQkktugZNhBMGrmdf0VEdSEp7wybu
	K+SohhuWDMGc4EOYSRg8e8AEAFl7sIyr2hEeVzptHVl1Q20Wbj3tgHC6bWBJTYs7
X-Gm-Gg: ASbGncvC557GulG55Pq4LGQjafx3Uo6yn5vZbzdFC4Z9XiAEinMYtLXspADCH7RASXq
	hVb6IvEbgOlkcwYaNJbgSKbArrXE0vCpRpyvq3ZKxHe64s5XRvhWgAUbE4GshN/PQqS37hZSFzx
	yTgRT8yXza4bvq9b1HV0WAiRtI/HxhZ0dFWHTHQc7vgFxloyesl3G8VihC9nk4AUGjKEiWPDAj7
	PcB+XrEI399n76un+jRAfM3R/K9tteKmFXHOzfu6kOLo2CaSMHsWCFbpL5Oyx/mRqyypDvA6D4s
	uWpr0uwZHpKXQhdorZIdw/qvzZRy53wjDMaDEUrYfsU=
X-Google-Smtp-Source: AGHT+IEzZpfM7q9rR57opZGg9qPwYrln15z6WF3j6cMTSbVGYFJSxloyEh1jwTmoWiABsuY9/u+/cg==
X-Received: by 2002:a17:903:2f4b:b0:235:f70:fd44 with SMTP id d9443c01a7336-237d9870d24mr210941125ad.21.1750728556942;
        Mon, 23 Jun 2025 18:29:16 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::1707])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83937bcsm93228865ad.43.2025.06.23.18.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 18:29:16 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung Kim
 <namhyung@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Ian Rogers <irogers@google.com>,  Adrian Hunter
 <adrian.hunter@intel.com>,  Suzuki K Poulose <suzuki.poulose@arm.com>,
  Mike Leach <mike.leach@linaro.org>,  Nick Terrell <terrelln@fb.com>,
  David Sterba <dsterba@suse.com>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org,  coresight@lists.linaro.org,
  linux-arm-kernel@lists.infradead.org,  bpf@vger.kernel.org
Subject: Re: [PATCH] perf test: Change all remaining #!/bin/sh to #!/bin/bash
In-Reply-To: <20250623-james-perf-bash-tests-v1-1-f572f54d4559@linaro.org>
References: <20250623-james-perf-bash-tests-v1-1-f572f54d4559@linaro.org>
Date: Mon, 23 Jun 2025 18:29:15 -0700
Message-ID: <87bjqehqqc.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Clark <james.clark@linaro.org> writes:

> There are 43 instances of posix shell tests and 35 instances of bash. To
> give us a single consistent language for testing in, replace
> all #!/bin/sh to #!/bin/bash. Common sources that are included in both
> different shells will now work as expected. And we no longer have to fix
> up bashisms that appear to work when someone's system has sh symlinked
> to bash, but don't work on other systems that have both shells
> installed.
>
> Although we could have chosen sh, it's not backwards compatible so it
> wouldn't be possible to bulk convert without re-writing the existing
> bash tests.
>
> Choosing bash also gives us some nicer features including 'local'
> variable definitions and regexes in if statements that are already
> widely used in the tests.
>
> It's not expected that there are any users with only sh available due to
> the large number of bash tests that exist.
>
> Discussed in relation to running shellcheck here:
> https://lore.kernel.org/linux-perf-users/e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com/
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/perf-targz-src-pkg                          | 2 +-
>  tools/perf/tests/shell/amd-ibs-swfilt.sh                     | 2 +-
>  tools/perf/tests/shell/buildid.sh                            | 2 +-
>  tools/perf/tests/shell/coresight/asm_pure_loop.sh            | 2 +-
>  tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh     | 2 +-
>  tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh | 2 +-
>  tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh  | 2 +-
>  tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh    | 2 +-
>  tools/perf/tests/shell/diff.sh                               | 2 +-
>  tools/perf/tests/shell/ftrace.sh                             | 2 +-
>  tools/perf/tests/shell/lib/perf_has_symbol.sh                | 2 +-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh              | 2 +-
>  tools/perf/tests/shell/lib/setup_python.sh                   | 2 +-
>  tools/perf/tests/shell/lib/waiting.sh                        | 2 +-
>  tools/perf/tests/shell/list.sh                               | 2 +-
>  tools/perf/tests/shell/lock_contention.sh                    | 2 +-
>  tools/perf/tests/shell/perf-report-hierarchy.sh              | 2 +-
>  tools/perf/tests/shell/probe_vfs_getname.sh                  | 2 +-
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh        | 2 +-
>  tools/perf/tests/shell/record+script_probe_vfs_getname.sh    | 2 +-
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh            | 2 +-
>  tools/perf/tests/shell/record_bpf_filter.sh                  | 2 +-
>  tools/perf/tests/shell/record_offcpu.sh                      | 2 +-
>  tools/perf/tests/shell/record_sideband.sh                    | 2 +-
>  tools/perf/tests/shell/script.sh                             | 2 +-
>  tools/perf/tests/shell/stat+csv_summary.sh                   | 2 +-
>  tools/perf/tests/shell/stat+shadow_stat.sh                   | 2 +-
>  tools/perf/tests/shell/stat_all_pfm.sh                       | 2 +-
>  tools/perf/tests/shell/stat_bpf_counters.sh                  | 2 +-
>  tools/perf/tests/shell/stat_bpf_counters_cgrp.sh             | 2 +-
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh              | 2 +-
>  tools/perf/tests/shell/test_arm_coresight.sh                 | 2 +-
>  tools/perf/tests/shell/test_arm_coresight_disasm.sh          | 2 +-
>  tools/perf/tests/shell/test_arm_spe.sh                       | 2 +-
>  tools/perf/tests/shell/test_arm_spe_fork.sh                  | 2 +-
>  tools/perf/tests/shell/test_bpf_metadata.sh                  | 2 +-
>  tools/perf/tests/shell/test_intel_pt.sh                      | 2 +-
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh            | 2 +-
>  tools/perf/tests/shell/trace_btf_enum.sh                     | 2 +-
>  tools/perf/tests/shell/trace_exit_race.sh                    | 2 +-
>  tools/perf/tests/shell/trace_record_replay.sh                | 2 +-
>  tools/perf/tests/shell/trace_summary.sh                      | 2 +-
>  tools/perf/tests/tests-scripts.c                             | 2 +-
>  43 files changed, 43 insertions(+), 43 deletions(-)

Patch looks good to me.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin

