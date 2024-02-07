Return-Path: <bpf+bounces-21413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8B84CE26
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 16:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A31F26943
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFC7FBBA;
	Wed,  7 Feb 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj1lgaEg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BF7F7D9
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320156; cv=none; b=kJCKUqfUH4pt0L6/s2qYJ+izpZ1XAQ28WSQDZiGQrDNQM2xENv1j+xYkPb7DI6jk4GmEcpZQ8BE7M805G5ZCysEku6p1TA+0u9IxjQs2flFYT2cT0E22PvtI9pzlZva9y6Ip7znorcMDX+QzQwUTtNGIlOgW2WLjfOFRnmDaUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320156; c=relaxed/simple;
	bh=fO8dh5NgXri+isCuFtHI7ZcjXGcJguqTacrUI+/xj80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWmCFnb+U6WP+xqUolAAsF4h8NyXJ/gROmGZCWsunCgJzRjdGlqP7SBsb6L2Y5sMEWxDko/x14FaO3IxW0wrbBt054BKa1Y3jq676c2CCbtoBi2FOw8imX97HbH5C8fIYfF3kHLOiQoseXyUEHgKDHFfVJ0IDXXBrt7VLvf7/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj1lgaEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172F8C433C7;
	Wed,  7 Feb 2024 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707320156;
	bh=fO8dh5NgXri+isCuFtHI7ZcjXGcJguqTacrUI+/xj80=;
	h=From:To:Cc:Subject:Date:From;
	b=Uj1lgaEg6L5XaQMWqZIUkUZ0B4jeFCp02aA8bbbMtcYOyYQiYhCPLeQFw/m36poUq
	 8yEwyHYPE9ojYdvqutSRd2xtOvorkPSf4H50AYbVUvthrj98UkLYAJohR5EzaocCkJ
	 pOpgNFwPczXa2lMufMRWSGJYNoIkLTW8JZJcF+pgcnWSbc5+Wvy84QVmT4dgyyweA0
	 cPS3YpWo7OvOs9X+Hz2mglfXFGeBhAlOlsNXKD24nLNsp/SMu7hHRpEwlvU/m0nbh+
	 pPqBNyXCOWi+E4lKPuU977RkWFeMXCYTW7h34pzCX5OdEUVo4z8tdPhp5PBSyV9l3a
	 q90xJv95zjouA==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog in kprobe multi
Date: Wed,  7 Feb 2024 16:35:46 +0100
Message-ID: <20240207153550.856536-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding support to attach both entry and return bpf program on single
kprobe multi link.

Having entry together with return probe for given function is common
use case for tetragon, bpftrace and most likely for others.

At the moment if we want both entry and return probe to execute bpf
program we need to create two (entry and return probe) links. The link
for return probe creates extra entry probe to setup the return probe.
The extra entry probe execution could be omitted if we had a way to
use just single link for both entry and exit probe.

In addition it's possible to control the execution of the return probe
with the return value of the entry bpf program. If the entry program
returns 0 the return probe is installed and executed, otherwise it's
skip.

I'm still working on the tetragon change, so I'll be sending non-RFC
version once that's ready, meanwhile any ideas and feedback on the
approach would be great.

The change in bpftrace [1] using the new interface shows speed increase
with tracing perf bench messaging:

  # perf bench sched messaging -l 100000

having system wide bpftrace:

  # bpftrace -e 'kprobe:ksys_write { }, kretprobe:ksys_write { }'

without bpftrace:

  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 119.595 [sec]

   Performance counter stats for 'perf bench sched messaging -l 100000':

     102,419,967,282      cycles:u
   5,652,444,107,001      cycles:k
   5,782,645,019,612      cycles
      22,187,151,206      instructions:u                   #    0.22  insn per cycle
   2,979,040,498,455      instructions:k                   #    0.53  insn per cycle

       119.671169829 seconds time elapsed

        94.959198000 seconds user
      1815.371616000 seconds sys

with current bpftrace:

  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 221.153 [sec]

   Performance counter stats for 'perf bench sched messaging -l 100000':

     125,292,164,504      cycles:u
  10,315,020,393,735      cycles:k
  10,501,379,274,042      cycles
      22,187,583,545      instructions:u                   #    0.18  insn per cycle
   4,856,893,111,303      instructions:k                   #    0.47  insn per cycle

       221.229234283 seconds time elapsed

       103.792498000 seconds user
      3432.643302000 seconds sys

with bpftrace using the new interface:

  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 157.825 [sec]

   Performance counter stats for 'perf bench sched messaging -l 100000':

     102,423,112,279      cycles:u
   7,450,856,354,744      cycles:k
   7,584,769,726,693      cycles
      22,187,270,661      instructions:u                   #    0.22  insn per cycle
   3,985,522,383,425      instructions:k                   #    0.53  insn per cycle

       157.900787760 seconds time elapsed

        97.953898000 seconds user
      2425.314753000 seconds sys

thanks,
jirka


[1] https://github.com/bpftrace/bpftrace/pull/2984
---
Jiri Olsa (4):
      fprobe: Add entry/exit callbacks types
      bpf: Add return prog to kprobe multi
      libbpf: Add return_prog_fd to kprobe multi opts
      selftests/bpf: Add kprobe multi return prog test

 include/linux/fprobe.h                                       |  18 ++++++++++------
 include/uapi/linux/bpf.h                                     |   4 +++-
 kernel/trace/bpf_trace.c                                     |  50 ++++++++++++++++++++++++++++++++-----------
 tools/include/uapi/linux/bpf.h                               |   4 +++-
 tools/lib/bpf/bpf.c                                          |   1 +
 tools/lib/bpf/bpf.h                                          |   1 +
 tools/lib/bpf/libbpf.c                                       |   5 +++++
 tools/lib/bpf/libbpf.h                                       |   6 +++++-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c   |  53 +++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 226 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c

