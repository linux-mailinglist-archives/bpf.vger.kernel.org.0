Return-Path: <bpf+bounces-14574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AC77E66C5
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E1B20B83
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135E12B7B;
	Thu,  9 Nov 2023 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciO0BGPL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83C23C8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA9AC433C7;
	Thu,  9 Nov 2023 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699522189;
	bh=P+pPEdgvwHFVa+c8e06tOkfnEhPYO+jpRUK3poe+nr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ciO0BGPLAIlA4rT5Iqvsg/AEzERebjoQ/SU1a2NAUH5SsbZSQYsyjIZISkbyCDadq
	 SdevPDK5RTTNwPElSWsKgN+8tnjCseuw0+4PR28CtdljhgldBfJRHoKdAeuGYh6C7H
	 lzj+Y4CfiDwRFFfV4DB0YtVN4d2Gc/2PBhbXkMsSHxGcG8mqI2TLTh3zgszO//JTea
	 RZN8rOJv9rhf5VzXyIjPTjOB3y4N9HXrjX2411KMZWYxLxIr+akEEyfq9AkkCIZql+
	 DrztCqB3ifmzX+G3K26TlkY7aGFqQPn8fOFgKbfevyQo6aRHZ+JB1IBDCvJMcjofgT
	 H6jIouOdmnp4g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv2 bpf-next 6/6] bpftool: Add support to display uprobe_multi links
Date: Thu,  9 Nov 2023 10:28:38 +0100
Message-ID: <20231109092838.721233-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109092838.721233-1-jolsa@kernel.org>
References: <20231109092838.721233-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to display details for uprobe_multi links,
both plain:

  # bpftool link -p
  ...
  24: uprobe_multi  prog 126
          uprobe.multi  path /home/jolsa/bpf/test_progs  func_cnt 3  pid 4143
          offset             ref_ctr_offset     cookies
          0xd1f88            0xf5d5a8           0xdead
          0xd1f8f            0xf5d5aa           0xbeef
          0xd1f96            0xf5d5ac           0xcafe

and json:

  # bpftool link -p
  [{
  ...
      },{
          "id": 24,
          "type": "uprobe_multi",
          "prog_id": 126,
          "retprobe": false,
          "path": "/home/jolsa/bpf/test_progs",
          "func_cnt": 3,
          "pid": 4143,
          "funcs": [{
                  "offset": 860040,
                  "ref_ctr_offset": 16111016,
                  "cookie": 57005
              },{
                  "offset": 860047,
                  "ref_ctr_offset": 16111018,
                  "cookie": 48879
              },{
                  "offset": 860054,
                  "ref_ctr_offset": 16111020,
                  "cookie": 51966
              }
          ]
      }
  ]

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 105 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a1528cde81ab..d198adf77d81 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -294,6 +294,37 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_end_array(json_wtr);
 }
 
+static __u64 *u64_to_arr(__u64 val)
+{
+	return (__u64 *) u64_to_ptr(val);
+}
+
+static void
+show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	__u32 i;
+
+	jsonw_bool_field(json_wtr, "retprobe",
+			 info->uprobe_multi.flags & BPF_F_UPROBE_MULTI_RETURN);
+	jsonw_string_field(json_wtr, "path", (char *) u64_to_ptr(info->uprobe_multi.path));
+	jsonw_uint_field(json_wtr, "func_cnt", info->uprobe_multi.count);
+	jsonw_int_field(json_wtr, "pid", (int) info->uprobe_multi.pid);
+	jsonw_name(json_wtr, "funcs");
+	jsonw_start_array(json_wtr);
+
+	for (i = 0; i < info->uprobe_multi.count; i++) {
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "offset",
+				 u64_to_arr(info->uprobe_multi.offsets)[i]);
+		jsonw_uint_field(json_wtr, "ref_ctr_offset",
+				 u64_to_arr(info->uprobe_multi.ref_ctr_offsets)[i]);
+		jsonw_uint_field(json_wtr, "cookie",
+				 u64_to_arr(info->uprobe_multi.cookies)[i]);
+		jsonw_end_object(json_wtr);
+	}
+	jsonw_end_array(json_wtr);
+}
+
 static void
 show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
@@ -465,6 +496,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_json(info, json_wtr);
 		break;
+	case BPF_LINK_TYPE_UPROBE_MULTI:
+		show_uprobe_multi_json(info, json_wtr);
+		break;
 	case BPF_LINK_TYPE_PERF_EVENT:
 		switch (info->perf_event.type) {
 		case BPF_PERF_EVENT_EVENT:
@@ -674,6 +708,33 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 	}
 }
 
+static void show_uprobe_multi_plain(struct bpf_link_info *info)
+{
+	__u32 i;
+
+	if (!info->uprobe_multi.count)
+		return;
+
+	if (info->uprobe_multi.flags & BPF_F_UPROBE_MULTI_RETURN)
+		printf("\n\turetprobe.multi  ");
+	else
+		printf("\n\tuprobe.multi  ");
+
+	printf("path %s  ", (char *) u64_to_ptr(info->uprobe_multi.path));
+	printf("func_cnt %u  ", info->uprobe_multi.count);
+
+	if (info->uprobe_multi.pid != (__u32) -1)
+		printf("pid %d  ", info->uprobe_multi.pid);
+
+	printf("\n\t%-16s   %-16s   %-16s", "offset", "ref_ctr_offset", "cookies");
+	for (i = 0; i < info->uprobe_multi.count; i++) {
+		printf("\n\t0x%-16llx 0x%-16llx 0x%-16llx",
+			u64_to_arr(info->uprobe_multi.offsets)[i],
+			u64_to_arr(info->uprobe_multi.ref_ctr_offsets)[i],
+			u64_to_arr(info->uprobe_multi.cookies)[i]);
+	}
+}
+
 static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
 {
 	const char *buf;
@@ -807,6 +868,9 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_plain(info);
 		break;
+	case BPF_LINK_TYPE_UPROBE_MULTI:
+		show_uprobe_multi_plain(info);
+		break;
 	case BPF_LINK_TYPE_PERF_EVENT:
 		switch (info->perf_event.type) {
 		case BPF_PERF_EVENT_EVENT:
@@ -846,8 +910,10 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 
 static int do_show_link(int fd)
 {
+	__u64 *ref_ctr_offsets = NULL, *offsets = NULL, *cookies = NULL;
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
+	char path_buf[PATH_MAX];
 	__u64 *addrs = NULL;
 	char buf[PATH_MAX];
 	int count;
@@ -889,6 +955,39 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type == BPF_LINK_TYPE_UPROBE_MULTI &&
+	    !info.uprobe_multi.offsets) {
+		count = info.uprobe_multi.count;
+		if (count) {
+			offsets = calloc(count, sizeof(__u64));
+			if (!offsets) {
+				p_err("mem alloc failed");
+				close(fd);
+				return -ENOMEM;
+			}
+			info.uprobe_multi.offsets = ptr_to_u64(offsets);
+			ref_ctr_offsets = calloc(count, sizeof(__u64));
+			if (!ref_ctr_offsets) {
+				p_err("mem alloc failed");
+				free(offsets);
+				close(fd);
+				return -ENOMEM;
+			}
+			info.uprobe_multi.ref_ctr_offsets = ptr_to_u64(ref_ctr_offsets);
+			cookies = calloc(count, sizeof(__u64));
+			if (!cookies) {
+				p_err("mem alloc failed");
+				free(cookies);
+				free(offsets);
+				close(fd);
+				return -ENOMEM;
+			}
+			info.uprobe_multi.cookies = ptr_to_u64(cookies);
+			info.uprobe_multi.path = ptr_to_u64(path_buf);
+			info.uprobe_multi.path_size = sizeof(path_buf);
+			goto again;
+		}
+	}
 	if (info.type == BPF_LINK_TYPE_PERF_EVENT) {
 		switch (info.perf_event.type) {
 		case BPF_PERF_EVENT_TRACEPOINT:
@@ -924,8 +1023,10 @@ static int do_show_link(int fd)
 	else
 		show_link_close_plain(fd, &info);
 
-	if (addrs)
-		free(addrs);
+	free(ref_ctr_offsets);
+	free(cookies);
+	free(offsets);
+	free(addrs);
 	close(fd);
 	return 0;
 }
-- 
2.41.0


