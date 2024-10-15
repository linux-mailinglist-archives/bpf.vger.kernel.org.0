Return-Path: <bpf+bounces-41982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8903399E278
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6951F233AD
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A91DD880;
	Tue, 15 Oct 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5BL3BsL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC471DD885
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983456; cv=none; b=BJGZ+3O0hbDkw0iALB7MwAdsTIz2JQBRj47D4iN5NEXhkgkOH95m6xsmzABMteIAZAlRQ9zypK7zdq3Q1L5ww4hxtFcwx0ShzROe1XwVbzKle0zIR9Kvk8qzPk1wmO+11R6MhMqBKVC9zSGcvndEBE0hQspSog+OXDUkB8Vw5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983456; c=relaxed/simple;
	bh=cQGNtKItGMv5mDp5NI4g3VtpplNIJ98zxo70Pq0NMJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/Rp5DkAD1/oqKoYOH4TBZrn2U6GcD2gOP5sSwsXZyh8uloSpipWNWe9lX3NHewKycfODj/3Cv0P/Y1iOFiyThtQvz9BlqYtGIHKXNj/+xyeH9AadrDQOku6wlbyfUA1K6uMnR6dplqkrMhy3Z05KE0A6fSnjVv07wBwULa4gMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5BL3BsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F64C4CEC7;
	Tue, 15 Oct 2024 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983455;
	bh=cQGNtKItGMv5mDp5NI4g3VtpplNIJ98zxo70Pq0NMJw=;
	h=From:To:Cc:Subject:Date:From;
	b=T5BL3BsLRiP+sXzZvGwmU09KNyeWanzh0H5VvHPmhUVkSWC688vK1uURhg5Br60ob
	 B/cKOc9ImCW3q5u4AhZq+AUSAAWH5GIErGpESUfDSn27BEza4iAqwTub/1G4RzVV8r
	 cA00xiTkUU7F/CDR3UrqDGPxoSsH4R9XO9VYdCJfoVffNE49PZY+2c1iJU8P68T0vE
	 wdzZ2NsNgWy37O0pNuZ2odZENWs9ImiS0i+RoTIzM+cTItFHH8GvfGj6BaAmEVsbiy
	 FAc34T6da2JID7RPSLM48OvtzV0FbfPq+E+xARcyle3tZwV+g/K79g5/0D/oUflaS1
	 KSOaWsvM3rF4Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv7 bpf-next,perf/core 00/15] uprobe, bpf: Add session support
Date: Tue, 15 Oct 2024 11:10:35 +0200
Message-ID: <20241015091050.3731669-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset is adding support for session uprobe attachment and
using it through bpf link for bpf programs.

The session means that the uprobe consumer is executed on entry
and return of probed function with additional control:
  - entry callback can control execution of the return callback
  - entry and return callbacks can share data/cookie

On more details please see patch #2.

The patchset is based on Peter's perf/core [1] tree merged in bpf-next/master.

There's an proposal from Andrii how to get this merged in [2]:

> I think uprobe parts should stay in tip/perf/core (if that's where all
> uprobe code goes in), as we have a bunch of ongoing work that all will
> conflict a bit with each other, if it lands across multiple trees.
> 
> So that means that patches #1 and #2 ideally land in tip/perf/core.
> But you have a lot of BPF-specific things that would be inconvenient
> to route through tip, so I'd say those should go through bpf-next.
> 
> What we can do, if Ingo and Peter are OK with that, is to create a
> stable (non-rebaseable) branch off of your first two patches (applied
> in tip/perf/core), which we'll merge into bpf-next/master and land the
> rest of your patch set there. We've done that with recent struct fd
> changes, and there were few other similar cases in the past, and that
> all worked well.
> 
> Peter, Ingo, are you guys OK with that approach?


v7 changes:
  - added acks [Andrii, Oleg]
  - merged patch 14/15 into one change, plus another small change [Andrii]

thanks,
jirka


[1] git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
[2] https://lore.kernel.org/bpf/CAEf4BzY8tGCstcD4BVBLPd0V92p--b_vUmQyWydObRJHZPgCLA@mail.gmail.com/
---
Jiri Olsa (15):
      uprobe: Add data pointer to consumer handlers
      uprobe: Add support for session consumer
      bpf: Allow return values 0 and 1 for kprobe session
      bpf: Force uprobe bpf program to always return 0
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      libbpf: Add support for uprobe multi session attach
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test
      selftests/bpf: Add uprobe session verifier test for return value
      selftests/bpf: Add kprobe session verifier test for return value
      selftests/bpf: Add uprobe session single consumer test
      selftests/bpf: Add uprobe sessions to consumer test
      selftests/bpf: Add threads to consumer test

 include/linux/uprobes.h                                            |  25 ++++++-
 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 ++-
 kernel/bpf/verifier.c                                              |  10 +++
 kernel/events/uprobes.c                                            | 148 +++++++++++++++++++++++++++++--------
 kernel/trace/bpf_trace.c                                           |  63 +++++++++++-----
 kernel/trace/trace_uprobe.c                                        |  12 ++-
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  19 ++++-
 tools/lib/bpf/libbpf.h                                             |   4 +-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c              |   2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c         |   2 +
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 336 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c          |  31 ++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c         |   6 +-
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  71 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c    |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c          |  31 ++++++++
 21 files changed, 808 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

