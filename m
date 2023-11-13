Return-Path: <bpf+bounces-14967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36D7E958D
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0091C209C1
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 03:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E938BF6;
	Mon, 13 Nov 2023 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XyVmSmrN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF388BE1
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 03:35:15 +0000 (UTC)
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 19:35:12 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF7FC1727;
	Sun, 12 Nov 2023 19:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qzuze
	q5RZunEw9MzxOVC0ZJUq2k7xF8cGjQbiU3w6Ng=; b=XyVmSmrNOIocnF1EPnFY7
	d/6AXrh90j2d9cq0etvYpTjXrzQ8TIPMd5TKTYWzNFgIfZkvR2qiglQY2LlK56t3
	I+xdsbeZUcpLnaEWFVEUQfL+Tu4hmK/8uSTpEkpiuUnWoFkFYJCvBU/lwDWjITw1
	5DBV2HuqGFuRTyKvBE2by8=
Received: from hrt-workstation-l4hl6.hrt-tessos.compute.slcaz03.tess.io. (unknown [216.113.160.77])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDnDup8lVFloOCsCg--.49567S2;
	Mon, 13 Nov 2023 11:18:23 +0800 (CST)
From: Wenli Xie <xwlpt@126.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenli Xie <wlxie7296@gmail.com>
Subject: [PATCH] bpf: Get the program type by resolve_prog_type() directly
Date: Mon, 13 Nov 2023 03:18:12 +0000
Message-Id: <20231113031812.3639430-1-xwlpt@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDup8lVFloOCsCg--.49567S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4DKFW8Zr18uw45Gw4kZwb_yoWkWwb_A3
	Wjgw4xGw4DGFyfKa1UCFWfWF1j9ryFqFn7urn0vryDCF15Jw4jyr18uFZIqFykZrn7JrWS
	yF9Yva4rtrWfXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb_Ma5UUUUU==
X-Originating-IP: [216.113.160.77]
X-CM-SenderInfo: h0zo13a6rslhhfrp/1tbiegMnBlpEG1mnGQAAs6

From: Wenli Xie <wlxie7296@gmail.com>

The bpf program type can be get by resolve_prog_type() directly.

Signed-off-by: Wenli Xie <wlxie7296@gmail.com>
---
 kernel/bpf/btf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..b8ac96906bc5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6963,7 +6963,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 {
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_prog *prog = env->prog;
-	enum bpf_prog_type prog_type = prog->type;
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	struct btf *btf = prog->aux->btf;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
@@ -7001,8 +7001,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 		bpf_log(log, "Verifier bug in function %s()\n", tname);
 		return -EFAULT;
 	}
-	if (prog_type == BPF_PROG_TYPE_EXT)
-		prog_type = prog->aux->dst_prog->type;
 
 	t = btf_type_by_id(btf, t->type);
 	if (!t || !btf_type_is_func_proto(t)) {
-- 
2.34.1


