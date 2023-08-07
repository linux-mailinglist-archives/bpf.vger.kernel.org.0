Return-Path: <bpf+bounces-7145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B4771CBA
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 11:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88ECB280F11
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998DC8C0;
	Mon,  7 Aug 2023 09:00:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B6138E
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 09:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B249C433C7;
	Mon,  7 Aug 2023 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691398801;
	bh=QmVrBhaaZIGexEIxrVr5yQzXkZccvr/H7z/1U9RDwug=;
	h=From:To:Cc:Subject:Date:From;
	b=bRO1ebLfkc1dNdvFh5CwMNoOpEGe9B+mKKDvrvdWqQv7nlcL8gyjI4T5jgi9ffG6W
	 20z2vvLVKq6OwyADPiQXG+4lRNXyuBlh0n3cWqTLf+3rI8XmqHLCULMUtf+IdCy6G8
	 XInMJYvYKuZVdLrrxBsCQQMeueEXsYmcN3tqYFO0UO8dteS4VAY/J6pG06pKyRMWmU
	 hXesDDdRXCUXEelWcW59s3WaAgTjiz+6C1NRjjYWUzuyp1BptsVCWTQ+JcpaNVy1xn
	 rhODj9cOmysmEs8f+/QWD3UzmGudDHDEMplaoBp1ks9ylGJEkGQszSEeiV+cP6FiNn
	 q43szgTeETKEg==
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
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv3 bpf-next 0/3] bpf: Support bpf_get_func_ip helper in uprobes
Date: Mon,  7 Aug 2023 10:59:53 +0200
Message-ID: <20230807085956.2344866-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding support for bpf_get_func_ip helper for uprobe program to return
probed address for both uprobe and return uprobe as suggested by Andrii
in [1].

We agreed that uprobe can have special use of bpf_get_func_ip helper
that differs from kprobe.

The kprobe bpf_get_func_ip returns:
  - address of the function if probe is attach on function entry
    for both kprobe and return kprobe
  - 0 if the probe is not attach on function entry

The uprobe bpf_get_func_ip returns:
  - address of the probe for both uprobe and return uprobe

The reason for this semantic change is that kernel can't really tell
if the probe user space address is function entry.

v3 changes:
  - removed bpf_get_func_ip_uprobe helper function [Yonghong]

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  uprobe_get_func_ip

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com/
---
Jiri Olsa (3):
      bpf: Add support for bpf_get_func_ip helper for uprobe program
      selftests/bpf: Add bpf_get_func_ip tests for uprobe on function entry
      selftests/bpf: Add bpf_get_func_ip test for uprobe inside function

 include/linux/bpf.h                                         |  9 +++++++--
 include/uapi/linux/bpf.h                                    |  7 ++++++-
 kernel/trace/bpf_trace.c                                    | 11 ++++++++++-
 kernel/trace/trace_probe.h                                  |  5 +++++
 kernel/trace/trace_uprobe.c                                 |  7 +------
 tools/include/uapi/linux/bpf.h                              |  7 ++++++-
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/testing/selftests/bpf/progs/get_func_ip_test.c        | 25 +++++++++++++++++++++++--
 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c | 18 ++++++++++++++++++
 9 files changed, 129 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c

