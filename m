Return-Path: <bpf+bounces-9399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4D797073
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 09:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA2B28157D
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A4110E;
	Thu,  7 Sep 2023 07:14:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7331103
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 07:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB512C43391;
	Thu,  7 Sep 2023 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694070849;
	bh=f9VNCmW1WWQYXdcHFtIiN0r638jkUiUI9ykSjimIqjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeVuchSfW3WWaeFLZdO0Y/qSupqqDYBHW0D+AlMrutnmR1BRiDp5Uk1zP101BucCt
	 oIFnPwKnqsxI0T8OFv2jgauqdMjHX2i114gUSjVctf48VmQCYHLP5d21YyXLL4KzcX
	 k3r7483NWTOGXyWgl5m7NMHwRXdvtTHRUXq1HuxVFpZoDPV1FTBM3EY4mDDAx1p9oD
	 dYX+pN35hgB7IdAUkGT8qlPGp/Rk7N0PN6Mf3aiRsGZnBOZobIVWvwvaG99zGH0dL2
	 6qzfvgSS6MeDW/Pg608xz/H1KpyoJrKjTG59KciQejZGI50vDRMuwA2RDVUlTlZPSd
	 HN9CluVz8itww==
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
Subject: [PATCHv2 bpf-next 5/9] bpftool: Display missed count for kprobe_multi link
Date: Thu,  7 Sep 2023 09:13:07 +0200
Message-ID: <20230907071311.254313-6-jolsa@kernel.org>
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
attached by kprobe multi link, like:

  # bpftool link
  5: kprobe_multi  prog 76
          kprobe.multi  func_cnt 1  missed 1
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

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2e5c231e08ac..d15d74cd1bed 100644
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
@@ -641,6 +642,8 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 	else
 		printf("\n\tkprobe.multi  ");
 	printf("func_cnt %u  ", info->kprobe_multi.count);
+	if (info->kprobe_multi.missed)
+		printf("missed %llu  ", info->kprobe_multi.missed);
 	addrs = (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
 	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
 
-- 
2.41.0


