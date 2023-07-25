Return-Path: <bpf+bounces-5806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D131760D56
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E492814BF
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E311C99;
	Tue, 25 Jul 2023 08:42:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D18F6B
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 08:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE81AC433C7;
	Tue, 25 Jul 2023 08:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690274531;
	bh=jL35qBlbc1pyOltazMa+6Sji+dLK6Y+csQzfg2ZInQI=;
	h=From:To:Cc:Subject:Date:From;
	b=G0P5ujeUr1A/x1GWi7E4wlkMjoy+2aB3XTBb7TVkk8Hlitz1UuA1r/QSSTFagzIiD
	 EIAxTNoAg09HpaAPW62BydQrDQ7Zr/QUljE/Hn5pQduPfPCYmDa1xvd3sZ9Yg+C745
	 0EPwWBB54gMsmzPVALaLR6/4rXQC6TtSXdWm3YN6RqKVeMgjGEZlEQ/PyKAhb0Hte4
	 Jv5vzGZICS5E59ByZ7pDqFqfPJ1ld5XcSRIu1PypSZgW5Fw0ryND9u/yF9XqCbTN74
	 IeRTiukF/P+imwY1QC9dqg/MWgZAZS3ALHZWwVdDUFp7iJqKwaPtU0DwbJyy6J0b8I
	 S+82ECw2btjbw==
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
	Hou Tao <houtao1@huawei.com>
Subject: [PATCHv3 bpf 0/2] bpf: Disable preemption in perf_event_output helpers code
Date: Tue, 25 Jul 2023 10:42:04 +0200
Message-ID: <20230725084206.580930-1-jolsa@kernel.org>
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

The reason is the nesting protection code in bpf_event_output that expects
disabled preemption, which is not guaranteed for programs executed by
bpf_prog_run_array_cg.

I managed to reproduce on tracing side where we have the same problem
in bpf_perf_event_output. The reproducer [2] just creates busy uprobe
and call bpf_perf_event_output helper a lot.

v3 changes:
  - added acks and fixed 'Fixes' tag style [Hou Tao]
  - added Closes tag to patch 2

v2 changes:
  - I changed 'Fixes' commits to where I saw we switched from preempt_disable
    to migrate_disable, but I'm not completely sure about the patch 2, because
    it was tricky to find, would be nice if somebody could check on that

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

