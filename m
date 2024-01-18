Return-Path: <bpf+bounces-19805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115D831643
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D0D1C22D30
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDA200AA;
	Thu, 18 Jan 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ2lEl00"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870AF29A2
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571746; cv=none; b=t3tG5Uvaj8eI8O3KSMDZbRmT1tOVLKJwrel87FQ0eCvfanGl2smT3QoLA56lChAdnf7yOhU8+/Rbd9Em0d9FG/bJB8k4zQMzBDl5EOLLllvMuJiT6VtzgYvV6vzY58NeJErwXzhEm0FlYLy77OjfXaF69yW4LBYmYM4xzkzViv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571746; c=relaxed/simple;
	bh=pbl9O1iPGmdaBUO42Z8nkkyEIbLAT8n+xe5dmYktlEc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=uqbbiD5HuEAPon9OWOvFKpIzygcPLmi7dLWpp0RjfLtFBgs20VbK21u7XjnAoQSZIhVc1b/ZHPoDXMgSJUDZCMHOdBJ6hGe3N14+AeK+jhYtWaNQAFc6g4NSVao/fHf+WYeinxl0nbuZpVHRmnFoXn8kZq+PoLQ0CHToVDJVnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ2lEl00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3385C433C7;
	Thu, 18 Jan 2024 09:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571745;
	bh=pbl9O1iPGmdaBUO42Z8nkkyEIbLAT8n+xe5dmYktlEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ2lEl001puC+B/eGYUnJ8VSLF2KasCHDQ6JBsdZT7O7xUe1iybmNmthKlU5FBK5T
	 8rPvtZNPTFCCYWGd1UBtmrosdVKShQN/1BCq1bV48CZPvApwW6LuaV/Vhi1on3z0ka
	 33eidAq6ZrOGMuEoi0O3OQC+ct2a0SQzh2Cv3iEeAbLHPCTIIRqsx6b2AY492+gOwR
	 16BObltmyfCuBQecLOHtDOuc2MmvsCzZ7ncbVWIVUEj/rQpTSq76wiw31jPGoPkIBu
	 IUIfiDLbOu70yy/WymOrp1JFFt1RET/q70fkCacG1upc7mneXRf4Nts99YRmpkPJ4x
	 QZd4xn1JskKjQ==
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
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 7/8] bpftool: Display cookie for perf event link probes
Date: Thu, 18 Jan 2024 10:54:15 +0100
Message-ID: <20240118095416.989152-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118095416.989152-1-jolsa@kernel.org>
References: <20240118095416.989152-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Displaying cookie for perf event link probes, in plain mode:

  # bpftool link
  17: perf_event  prog 90
          kprobe ffffffff82b1c2b0 bpf_fentry_test1  cookie 3735928559
  18: perf_event  prog 90
          kretprobe ffffffff82b1c2b0 bpf_fentry_test1  cookie 3735928559
  20: perf_event  prog 92
          tracepoint sched_switch  cookie 3735928559
  21: perf_event  prog 93
          event software:page-faults  cookie 3735928559
  22: perf_event  prog 91
          uprobe /proc/self/exe+0xd703c  cookie 3735928559

And in json mode:

  # bpftool link -j | jq

  {
    "id": 30,
    "type": "perf_event",
    "prog_id": 160,
    "retprobe": false,
    "addr": 18446744071607272112,
    "func": "bpf_fentry_test1",
    "offset": 0,
    "missed": 0,
    "cookie": 3735928559
  }

  {
    "id": 33,
    "type": "perf_event",
    "prog_id": 162,
    "tracepoint": "sched_switch",
    "cookie": 3735928559
  }

  {
    "id": 34,
    "type": "perf_event",
    "prog_id": 163,
    "event_type": "software",
    "event_config": "page-faults",
    "cookie": 3735928559
  }

  {
    "id": 35,
    "type": "perf_event",
    "prog_id": 161,
    "retprobe": false,
    "file": "/proc/self/exe",
    "offset": 880700,
    "cookie": 3735928559
  }

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 35b6859dd7c3..b66a1598b87c 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -334,6 +334,7 @@ show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
 			   u64_to_ptr(info->perf_event.kprobe.func_name));
 	jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
 	jsonw_uint_field(wtr, "missed", info->perf_event.kprobe.missed);
+	jsonw_uint_field(wtr, "cookie", info->perf_event.kprobe.cookie);
 }
 
 static void
@@ -343,6 +344,7 @@ show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_string_field(wtr, "file",
 			   u64_to_ptr(info->perf_event.uprobe.file_name));
 	jsonw_uint_field(wtr, "offset", info->perf_event.uprobe.offset);
+	jsonw_uint_field(wtr, "cookie", info->perf_event.uprobe.cookie);
 }
 
 static void
@@ -350,6 +352,7 @@ show_perf_event_tracepoint_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
 	jsonw_string_field(wtr, "tracepoint",
 			   u64_to_ptr(info->perf_event.tracepoint.tp_name));
+	jsonw_uint_field(wtr, "cookie", info->perf_event.tracepoint.cookie);
 }
 
 static char *perf_config_hw_cache_str(__u64 config)
@@ -426,6 +429,8 @@ show_perf_event_event_json(struct bpf_link_info *info, json_writer_t *wtr)
 	else
 		jsonw_uint_field(wtr, "event_config", config);
 
+	jsonw_uint_field(wtr, "cookie", info->perf_event.event.cookie);
+
 	if (type == PERF_TYPE_HW_CACHE && perf_config)
 		free((void *)perf_config);
 }
@@ -754,6 +759,8 @@ static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
 		printf("+%#x", info->perf_event.kprobe.offset);
 	if (info->perf_event.kprobe.missed)
 		printf("  missed %llu", info->perf_event.kprobe.missed);
+	if (info->perf_event.kprobe.cookie)
+		printf("  cookie %llu", info->perf_event.kprobe.cookie);
 	printf("  ");
 }
 
@@ -770,6 +777,8 @@ static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
 	else
 		printf("\n\tuprobe ");
 	printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
+	if (info->perf_event.uprobe.cookie)
+		printf("cookie %llu  ", info->perf_event.uprobe.cookie);
 }
 
 static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
@@ -781,6 +790,8 @@ static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
 		return;
 
 	printf("\n\ttracepoint %s  ", buf);
+	if (info->perf_event.tracepoint.cookie)
+		printf("cookie %llu  ", info->perf_event.tracepoint.cookie);
 }
 
 static void show_perf_event_event_plain(struct bpf_link_info *info)
@@ -802,6 +813,9 @@ static void show_perf_event_event_plain(struct bpf_link_info *info)
 	else
 		printf("%llu  ", config);
 
+	if (info->perf_event.event.cookie)
+		printf("cookie %llu  ", info->perf_event.event.cookie);
+
 	if (type == PERF_TYPE_HW_CACHE && perf_config)
 		free((void *)perf_config);
 }
-- 
2.43.0


