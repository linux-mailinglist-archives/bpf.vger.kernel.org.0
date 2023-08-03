Return-Path: <bpf+bounces-6831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA4B76E4FA
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73E828205B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08415ACB;
	Thu,  3 Aug 2023 09:52:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A47E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 09:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87923C433C7;
	Thu,  3 Aug 2023 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691056344;
	bh=yIwX5lADO/zK+2VzgiX/jMzQwbGHYSnf2bFr2E16Rds=;
	h=From:To:Cc:Subject:Date:From;
	b=c2UWuae8nV6ldV1iegh3c/Ij0/nxIpBmYkuV7vPAJVhQFsmy0y0jxNL5kwPqoUeR2
	 uAM8kiO0Eszgf3sEPVpj8/M29h6zSrk68ccVfSS5xBmB4DFSXdDrrs1U4ogxhr6UOQ
	 w6aTirzepJsMKUheZ3iuLoSraCnYOJb/p6jHyPwDqOlDJeC5R7U5vgcc8oNSIPcfnh
	 Skao35IXLrwduWt4xn+9MFv5leE1HrEt7h9hmpiIYCzQgnqQOjK1Y6PD6zqG9Rr0lP
	 RBUrESWosTGkUY0XvyNNzoviJL1pfUB3YClOtnhOz0V0mKUsG7FZGWboERupXquOQB
	 rAfyLd2g8sB8A==
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
Subject: [PATCHv2 bpf-next 0/3] bpf: Support bpf_get_func_ip helper in uprobes
Date: Thu,  3 Aug 2023 11:52:16 +0200
Message-ID: <20230803095219.1669065-1-jolsa@kernel.org>
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

v2 changes:
  - renamed bpf_prog_run_array_sleepable to bpf_prog_run_array_uprobe [Yafang Shao]
  - return -EOPNOTSUPP in bpf_get_func_ip_uprobe for !CONFIG_UPROBES [Alan]
  - added Tested-by [Alan]

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

 include/linux/bpf.h                                         |  5 +++++
 include/uapi/linux/bpf.h                                    |  7 ++++++-
 kernel/trace/bpf_trace.c                                    | 21 ++++++++++++++++++++-
 kernel/trace/trace_probe.h                                  |  5 +++++
 kernel/trace/trace_uprobe.c                                 |  5 -----
 tools/include/uapi/linux/bpf.h                              |  7 ++++++-
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c        | 25 +++++++++++++++++++++++--
 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c | 18 ++++++++++++++++++
 9 files changed, 133 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c

