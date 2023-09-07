Return-Path: <bpf+bounces-9400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4B797074
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 09:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8772C2814FF
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150C1116;
	Thu,  7 Sep 2023 07:14:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FF1103
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 07:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A230C43397;
	Thu,  7 Sep 2023 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694070859;
	bh=2Gal9YY4w+v6bXzG62x8DTxB8s/+kBykYRSPovkr24I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SODymRU8NJAixYyJWG/Z60aS50hNGFdZwY3MrN92L7xHW6QCFfTeRZYpo+wbLQOMA
	 pIxQehqlPoJdS+cfWU7cekfMnenWZcO+zCgJqsb6a5eH/bp8UhejCSTvLs22/VhRbt
	 rbqzIxuf/FytyNEe5a1idUwjeqc22w26Fj7DmBykfOPQj88GepcJSIZkPvtmQJZIoc
	 5Ng9iovP2hXuGW3DmxALkiyeEkDI/tf/ezMJ9d17vusnwS23BhsykjySGdFkaACpPZ
	 KIAx+WJK76NlBxT7srgMDQelL2qVbuFmiNEZY+fbj9xLVCs6Crb52O/6iUIl5iE6Pq
	 6DtbHvXewFbqQ==
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
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv2 bpf-next 6/9] bpftool: Display missed count for kprobe perf link
Date: Thu,  7 Sep 2023 09:13:08 +0200
Message-ID: <20230907071311.254313-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907071311.254313-1-jolsa@kernel.org>
References: <20230907071311.254313-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding 'missed' field to display missed counts for kprobes
attached by perf event link, like:

  # bpftool link
  5: perf_event  prog 82
          kprobe ffffffff815203e0 ksys_write
  6: perf_event  prog 83
          kprobe ffffffff811d1e50 scheduler_tick  missed 682217

  # bpftool link -jp
  [{
          "id": 5,
          "type": "perf_event",
          "prog_id": 82,
          "retprobe": false,
          "addr": 18446744071584220128,
          "func": "ksys_write",
          "offset": 0,
          "missed": 0
      },{
          "id": 6,
          "type": "perf_event",
          "prog_id": 83,
          "retprobe": false,
          "addr": 18446744071580753488,
          "func": "scheduler_tick",
          "offset": 0,
          "missed": 693469
      }
  ]

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index d15d74cd1bed..4b1407b05056 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -302,6 +302,7 @@ show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_string_field(wtr, "func",
 			   u64_to_ptr(info->perf_event.kprobe.func_name));
 	jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
+	jsonw_uint_field(wtr, "missed", info->perf_event.kprobe.missed);
 }
 
 static void
@@ -686,6 +687,8 @@ static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
 	printf("%s", buf);
 	if (info->perf_event.kprobe.offset)
 		printf("+%#x", info->perf_event.kprobe.offset);
+	if (info->perf_event.kprobe.missed)
+		printf("  missed %llu", info->perf_event.kprobe.missed);
 	printf("  ");
 }
 
-- 
2.41.0


