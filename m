Return-Path: <bpf+bounces-10493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E057A8E88
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B361C208C9
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4EA405ED;
	Wed, 20 Sep 2023 21:32:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBA3CCF5
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 21:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2056C433CB;
	Wed, 20 Sep 2023 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695245565;
	bh=f9VNCmW1WWQYXdcHFtIiN0r638jkUiUI9ykSjimIqjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ch5VHqL6E8X80Ujx2I8w3T9SC7Ove0NQoLHHXjAj65WDJF2uLVkSkVZihNbZ4hztf
	 EEtBCfF8/GranTkAJzd0NtQPIvgWuNZq6V73QitybTfzOiuhQT/cFHfA6C9m4ETHeY
	 KX8n13ZONtW47nAb8kdBrIPDz8nzhYcwOPPajnUbPih4dfrf/FbnlYp62ofBI7W/dy
	 pgOoqul71m2gimx4QyyTzsVXegsnnM9b10sdvImR+698S399g2ESZ1D1GJZbJXOK1C
	 iHFBy0KyBNyzWDU5vbRbi1ROF5FAHkW2WPmPt9hlfFzQjFLKmFmQzaQnql21Yv588l
	 gWC1nETEIb7Qw==
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
Subject: [PATCHv3 bpf-next 5/9] bpftool: Display missed count for kprobe_multi link
Date: Wed, 20 Sep 2023 23:31:41 +0200
Message-ID: <20230920213145.1941596-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213145.1941596-1-jolsa@kernel.org>
References: <20230920213145.1941596-1-jolsa@kernel.org>
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


