Return-Path: <bpf+bounces-8829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AA678A6E5
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFBF280DBA
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C310FE;
	Mon, 28 Aug 2023 07:57:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D346EC2
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF652C433C8;
	Mon, 28 Aug 2023 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209438;
	bh=uYUS+TX3YFJDNv8Iuv6Zp9bPNd1gwVtBNxShGEmP6/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ygb5pEvtv5CLH1hZg5T65jGyoGjhviTfkd3wJWblOPvQKy9dQ+LZ53G5dKoLIWPn1
	 2MdKDGTHu72KloWSZN/UH6uq6lpaZYABOvY7+gzZ7Sbo9/nGG0i1rsV8GgkTo/ncDZ
	 8mxnKF5IF3Bg6/5z4KvX1+HkloMV11fKVjXK9oDox9FIstJ9mp3aYLzukP0C7X5d0d
	 St1eq/FklDN6QxlXv2UlFKvQpqWk3yFwl+GQAkvK43PZf1ZGzz4ecGrPWCsn3cSrZE
	 38a8ohMnowA6iT5OQih1n+A8KkcGTD3bVkUMo6gNc02MteoHnSbQAJGL+gPyh3Tu45
	 ddCAxBUV3+QAg==
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
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH bpf-next 09/12] bpftool: Display missed count for kprobe_multi link
Date: Mon, 28 Aug 2023 09:55:34 +0200
Message-ID: <20230828075537.194192-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding 'missed' field to display missed counts for kprobes
attached by kprobe multi link, like:

  # bpftool link
  5: kprobe_multi  prog 76
          kprobe.multi  func_cnt 1 missed 1
          addr             func [module]
          ffffffffa039c030 fp3_test [fprobe_test]

  # bpftool link -jp
  [{
          "id": 5,
          "type": "kprobe_multi",
          "prog_id": 76,
          "retprobe": false,
          "func_cnt": 1,
          "missed": 1,
          "funcs": [{
                  "addr": 18446744072102723632,
                  "func": "fp3_test",
                  "module": "fprobe_test"
              }
          ]
      }
  ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 0b214f6ab5c8..7387e51a5e5c 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -265,6 +265,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_bool_field(json_wtr, "retprobe",
 			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
 	jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
+	jsonw_uint_field(json_wtr, "missed", info->kprobe_multi.missed);
 	jsonw_name(json_wtr, "funcs");
 	jsonw_start_array(json_wtr);
 	addrs = u64_to_ptr(info->kprobe_multi.addrs);
@@ -640,7 +641,9 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 		printf("\n\tkretprobe.multi  ");
 	else
 		printf("\n\tkprobe.multi  ");
-	printf("func_cnt %u  ", info->kprobe_multi.count);
+	printf("func_cnt %u", info->kprobe_multi.count);
+	if (info->kprobe_multi.missed)
+		printf(" missed %llu", info->kprobe_multi.missed);
 	addrs = (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
 	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
 
-- 
2.41.0


