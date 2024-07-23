Return-Path: <bpf+bounces-35453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD693AA01
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 01:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2ECC282EC4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 23:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F2149C61;
	Tue, 23 Jul 2024 23:49:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B551428E5;
	Tue, 23 Jul 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721778545; cv=none; b=pUvJ3cI+7vgC+vHeFIiq6KerP9VGFBmTsDrlkrHZ5ZsbIQpR3V5yQg4DAQrpJ6Pl1u1v0UtiJBVOnqaCOIY+whoLcxzwVibHUO/YFSjcIKCZSGy3D9ijV2gIOAeNWc93hGXRXI62jPONViQmvpRxqSbAUnsUg6XUwis3gKZH/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721778545; c=relaxed/simple;
	bh=eiKPaDJVI8thbirsTj9moPAtpHQhk5vhl9tlBHetZg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS6dddSTySJf1gaXpckpj3fF1GqrzyGzPfFwVedZkevHbpVcAg0vtzDs7Kfk/ZSssOErPVfiyciD6eX0Nejva/k1UiiSZb9gYBjbVk85vwzc0l4zSgAfkBO3TVbpznCZJKuUN/HVs0Jzy+kwZRrzhamM9DlrAIDBuHYB2blxkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso247127a91.1;
        Tue, 23 Jul 2024 16:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721778543; x=1722383343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=780s1sloRo3IdLarrsTsBd2s1gD1Kv22T8WvzKSt8os=;
        b=ii/O/u/42ndqO2GwydtIX3gRnENFxaCIz1aeC0j4BAoJPL7a/0CVz49ceaiYkJaspu
         Tz8wCNA/3FDCLXAL41YlPb4hHHQg3iZpIVEuax/LwbR6vzRyM64SOR2u3SheIOxLKe6G
         ArbjGcofiYmSgufDXC7I8vbB+1sXRSNY6UwZrWtSQpKYW06BfAwKcgz4RtEwbXPpH36K
         NgaUFrLl8DtAbzo1r1sWFeR/CEZ06e96wz8SBkNQ/4DhKDL2RPhZO0DIMn+K1tR2LXSV
         w/ik+s4KLKPVDw9yQlbsvyf7RERv7d6UkNv6mIfZ6eDawnq1FnkE2ownDx4ePt+Bsh2z
         B9cA==
X-Forwarded-Encrypted: i=1; AJvYcCVWFosvdj1TaJNEmCBdX2/iCHw4nEiRqhp6WyAsMO5GxDJN+6O54Ek4eqpB01TYP2HaFCO3M2LIlBkQjznSh5s/kRpbAaXNDIpUbMKs4rjBxcUEVA+PEmI/3jVow7w98L6srl/wLhYDqDOhui2quFseHulO7+Uefj/yYkMZnM9LeFd20g==
X-Gm-Message-State: AOJu0Ywa6iDifwjSvDVIKoUtZdN9Wv1BGuxnA+wOo2lcPJW5p2FQBh1D
	LdGE82d+obZItvszsrVUJ/fUWhwVYos3DCYLKCS/o7BMsvm/dG3ieHGrzlTIdmHcah1Fr3nCxCF
	2sKMo1Js49gGGMx47MEKJrF+zv1k=
X-Google-Smtp-Source: AGHT+IGdtAur4DGnenUkt7vmFCXHfRn8bdNsNj+zwg5QMRyVb6UQ1FmJcE0kIkHeUurc1jYSAUhgS42w/Unm2kSvCqE=
X-Received: by 2002:a17:90b:3841:b0:2c8:8bf8:4e24 with SMTP id
 98e67ed59e1d1-2cdb93bcc00mr343439a91.8.1721778543299; Tue, 23 Jul 2024
 16:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703223035.2024586-1-namhyung@kernel.org>
In-Reply-To: <20240703223035.2024586-1-namhyung@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Jul 2024 16:48:51 -0700
Message-ID: <CAM9d7cidaC5ZCjpaF=HuDza_W4HtzRp--LA48iEy8jSznS0EmA@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/8] perf record: Use a pinned BPF program for filter
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping!

On Wed, Jul 3, 2024 at 3:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> This is to support the unprivileged BPF filter for profiling per-task eve=
nts.
> Until now only root (or any user with CAP_BPF) can use the filter and we
> cannot add a new unprivileged BPF program types.  After talking with the =
BPF
> folks at LSF/MM/BPF 2024, I was told that this is the way to go.  Finally=
 I
> managed to make it working with pinned BPF objects. :)
>
> v3 changes)
>  * rebased onto latest perf-tools-next
>
> v2 changes)
>  * rebased onto Ian's UID/GID (non-sample data based) filter term change
>  * support separate lost counts for each use case
>  * update the test case to allow normal users (if supported)
>
>
> This only supports the per-task mode for normal users and root still uses
> its own instance of the same BPF program - not shared with other users.
> But it requires the one-time setup (by root) before using it by normal us=
ers
> like below.
>
>   $ sudo perf record --setup-filter pin
>
> This will load the BPF program and maps and pin them in the BPF-fs.  Then
> normal users can use the filter.
>
>   $ perf record -o- -e cycles:u --filter 'period < 10000' perf test -w no=
ploop | perf script -i-
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.011 MB - ]
>         perf  759982 448227.214189:          1 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214195:          1 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214196:          7 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214196:        223 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214198:       9475 cycles:u:  ffffffff8ee012a=
0 [unknown] ([unknown])
>         perf  759982 448227.548608:          1 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>         perf  759982 448227.548611:          1 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>         perf  759982 448227.548612:         12 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>         perf  759982 448227.548613:        466 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>
> It's also possible to unload (and unpin, of course) using this command:
>
>   $ sudo perf record --setup-filter unpin
>
> The code is avaiable in 'perf/pinned-filter-v3' branch at
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (8):
>   perf bpf-filter: Make filters map a single entry hashmap
>   perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
>   perf bpf-filter: Split per-task filter use case
>   perf bpf-filter: Support pin/unpin BPF object
>   perf bpf-filter: Support separate lost counts for each filter
>   perf record: Fix a potential error handling issue
>   perf record: Add --setup-filter option
>   perf test: Update sample filtering test
>
>  tools/perf/Documentation/perf-record.txt     |   5 +
>  tools/perf/builtin-record.c                  |  23 +-
>  tools/perf/builtin-stat.c                    |   2 +-
>  tools/perf/builtin-top.c                     |   2 +-
>  tools/perf/builtin-trace.c                   |   2 +-
>  tools/perf/tests/shell/record_bpf_filter.sh  |  13 +-
>  tools/perf/util/bpf-filter.c                 | 406 +++++++++++++++++--
>  tools/perf/util/bpf-filter.h                 |  19 +-
>  tools/perf/util/bpf_skel/sample-filter.h     |   2 +
>  tools/perf/util/bpf_skel/sample_filter.bpf.c |  75 +++-
>  tools/perf/util/evlist.c                     |   5 +-
>  tools/perf/util/evlist.h                     |   4 +-
>  12 files changed, 483 insertions(+), 75 deletions(-)
>
> --
> 2.45.2.803.g4e1b14247a-goog
>
>

