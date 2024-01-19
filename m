Return-Path: <bpf+bounces-19893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D752E832854
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB48B20F9E
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455514C617;
	Fri, 19 Jan 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBG/3iyp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64371D690
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662399; cv=none; b=dg0kMkqJMgptz2SwxROkhcXhpO+m5r7kL88hUWUvc3BwLVBDzo6n8lxU1ApmFiGOpYETMZl+iYWdxzsbG6EQum/2MYgW5YSorkuXKPQorx3mCSie1odP+urZlc6RQmEQlXQGUt06Zm9AZM2Q+IpEMFSffPueSduPgu2USOAYeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662399; c=relaxed/simple;
	bh=NLlaV3XE02nasKkwRmkOaj+YLOJt0lLnGlzXiXBtrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1DkcNA+883/4NzC0DMqKPlYp+HvJEfNGqqfQboZbWt6+qh/RExQuq4k3W7hly5iaJSA4oTWPX8hguwda7YgSwzfSZZlgRoTWNL7USH7so76OymG5XialE6kwV1vTNuvJcysfPcT8moZ+wVF/GJRizUpsjQD7fZGylJM/JMWrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBG/3iyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CF6C43390;
	Fri, 19 Jan 2024 11:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705662399;
	bh=NLlaV3XE02nasKkwRmkOaj+YLOJt0lLnGlzXiXBtrsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBG/3iypH+OZl+yllfLempiSz+8noZOFW/U1RAU51s5uCfRPKVJ7QivKSF2pjaKD3
	 rwLVVmpMAFsuf2LMeqz3FhMq9sRUyDC403lrXcgYk7vbuSbAOPbvvZFhEZNl2EGzMm
	 6JTSi65cR7u3ii+P3QPghXl409YbW6q5ZxO9eTSXEzYW+rDmdf/9AV84lO1JKC/Ty4
	 erxKpHQu9QZ4uuE7KxZSRaqOKeYLeTgXAkdhJ7Mi7GVaQp9orLd41cv7V/mZ0nyEYF
	 319hIeHnTjJvsoBGXnFp+cDNHCQq8rNC7avfbdaoe/tMiB/z/TboI5NNUMgYRzPHxJ
	 IONaKGB1aykzg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv2 bpf-next 7/8] bpftool: Display cookie for perf event link probes
Date: Fri, 19 Jan 2024 12:05:04 +0100
Message-ID: <20240119110505.400573-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
References: <20240119110505.400573-1-jolsa@kernel.org>
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

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
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


