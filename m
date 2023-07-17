Return-Path: <bpf+bounces-5084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B177756156
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 13:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AC82814AE
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 11:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B14AD2B;
	Mon, 17 Jul 2023 11:17:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE95A94B
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 11:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011AFC433C8;
	Mon, 17 Jul 2023 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689592667;
	bh=y3PeLR2fwL0TlM1nNgnR6UnmIoOvaflqfJvrX6HLf8M=;
	h=From:To:Cc:Subject:Date:From;
	b=BfksSPGnWIU0GFZHGlEK5HZoZFOfrEXyb/ZB0pK4pFKtoCmwndTSxltx/f2rBzj3P
	 gFf2TSxEnA5JAEXX+Ga9KPBDhgbFduVqJDsoQqRYqmzjen+TsMhtC+KXn183a5jYdy
	 NLpEMYiOdIlw3IJJexJuF0qvPupp32RMJcb+AHj4FJTOX2Vjk/5OnxeD6ttFfN3ASv
	 ywiVlCI+CgjYrQCQ7/+nKSjZZGnATtQ50IDmd7lBdLCPK0EK714th8+uzGRxeQIGJq
	 yuIi8EXu/2I3atat8DGA1+fBhhD3AN1JDoPQhxk/eOMKlXGQmOyiWN6A/wGCk66Q1c
	 WTakUuHHLF54A==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCH/RFC 0/2] bpf: Disable preemption in bpf_perf_event_output
Date: Mon, 17 Jul 2023 13:17:40 +0200
Message-ID: <20230717111742.183926-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we got report of kernel crash [1][3] within bpf_event_output helper.

The reason seems to be the nesting protection code in bpf_event_output
that expects disabled preemption, which is not guaranteed for programs
executed by bpf_prog_run_array_cg.

I managed to reproduce on tracing side where we have the same problem
in bpf_perf_event_output. The reproducer [2] just creates busy uprobe
and kprobe which call bpf_perf_event_output helper a lot.

Eventually the code will be preempted within nesting protection and
cause crash like:

  kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
  BUG: unable to handle page fault for address: ffffffff82be3eea
  ...
  Call Trace:
   <TASK>
   ? __die+0x1f/0x70
   ? page_fault_oops+0x176/0x4d0
   ? exc_page_fault+0x132/0x230
   ? asm_exc_page_fault+0x22/0x30
   ? perf_output_sample+0x12b/0x910
   ? perf_event_output+0xd0/0x1d0
   ? bpf_perf_event_output+0x162/0x1d0
   ? bpf_prog_c6271286d9a4c938_krava1+0x76/0x87
   ? __uprobe_perf_func+0x12b/0x540
   ? uprobe_dispatcher+0x2c4/0x430
   ? uprobe_notify_resume+0x2da/0xce0
   ? atomic_notifier_call_chain+0x7b/0x110
   ? exit_to_user_mode_prepare+0x13e/0x290
   ? irqentry_exit_to_user_mode+0x5/0x30
   ? asm_exc_int3+0x35/0x40

I did not come up with reproducer for bpf_event_output case and have no
way to reproduce or test it so far, hence I'm sending patch 2 as RFC for
discussion. However it seems to me it suffers the same issue as
bpf_perf_event_output on tracing side.

thanks,
jirka


[1] https://github.com/cilium/cilium/issues/26756
[2] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf_output_fix_reproducer&id=8054dcc634121b884c7c331329d61d93351d03b5
[3] slack:
    [66194.378161] BUG: kernel NULL pointer dereference, address: 0000000000000001
    [66194.378324] #PF: supervisor instruction fetch in kernel mode
    [66194.378447] #PF: error_code(0x0010) - not-present page
    ...
    [66194.378692] Oops: 0010 [#1] PREEMPT SMP NOPTI
    ...
    [66194.380666]  <TASK>
    [66194.380775]  ? perf_output_sample+0x12a/0x9a0
    [66194.380902]  ? finish_task_switch.isra.0+0x81/0x280
    [66194.381024]  ? perf_event_output+0x66/0xa0
    [66194.381148]  ? bpf_event_output+0x13a/0x190
    [66194.381270]  ? bpf_event_output_data+0x22/0x40
    [66194.381391]  ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
    [66194.381519]  ? xa_load+0x87/0xe0
    [66194.381635]  ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
    [66194.381759]  ? release_sock+0x3e/0x90
    [66194.381876]  ? sk_setsockopt+0x1a1/0x12f0
    [66194.381996]  ? udp_pre_connect+0x36/0x50
    [66194.382114]  ? inet_dgram_connect+0x93/0xa0
    [66194.382233]  ? __sys_connect+0xb4/0xe0
    [66194.382353]  ? udp_setsockopt+0x27/0x40
    [66194.382470]  ? __pfx_udp_push_pending_frames+0x10/0x10
    [66194.382593]  ? __sys_setsockopt+0xdf/0x1a0
    [66194.382713]  ? __x64_sys_connect+0xf/0x20
    [66194.382832]  ? do_syscall_64+0x3a/0x90
    [66194.382949]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
    [66194.383077]  </TASK>


---
Jiri Olsa (2):
      bpf: Disable preemption in bpf_perf_event_output
      bpf: Disable preemption in bpf_event_output

 kernel/trace/bpf_trace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

