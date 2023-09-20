Return-Path: <bpf+bounces-10489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45117A8E7C
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23FB1C20940
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 21:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CB93FB22;
	Wed, 20 Sep 2023 21:32:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CF41A88
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 21:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FEEC433C9;
	Wed, 20 Sep 2023 21:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695245521;
	bh=UMTrM9XnNht4A3+onFhhbJCd8JqAZC1qSPoJL2HYpaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9zjSHufj8ejwG/Oj629cWz1octsRruE3Jaz3QEZGQA7J1+vKWJgRQDzd2JNXPTu4
	 kO9uT2KOQnbBH28o+uxTyLuCTpGitUfFa0nU6tIQeiRh6xZPX2oMzgvFB8kAiRNJNc
	 7EAWxzK7uuOSVqWfaUBxJuUCuty9XxK36N/VcmjuCsyaY4zopFhd0SSU/txvX49UdL
	 1ftFYYoPM5gyXO9RNi77KF66zdmIjpAcf+YYAAdJxp3BRG9onjlgqnxWWFqMA5trPI
	 8TcTpdzbMmiOtryfwg9yi8WVmNvF7cDxVZDsM186hRJ2tgB3uV7mYbF3fzUR3HZZco
	 c0lCIO4et9qxQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>,
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
Subject: [PATCHv3 bpf-next 1/9] bpf: Count stats for kprobe_multi programs
Date: Wed, 20 Sep 2023 23:31:37 +0200
Message-ID: <20230920213145.1941596-2-jolsa@kernel.org>
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

Adding support to gather missed stats for kprobe_multi
programs due to bpf_prog_active protection.

Reviewed-and-tested-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a7264b2c17ad..279a3d370812 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2710,6 +2710,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
+		bpf_prog_inc_misses_counter(link->link.prog);
 		err = 0;
 		goto out;
 	}
-- 
2.41.0


