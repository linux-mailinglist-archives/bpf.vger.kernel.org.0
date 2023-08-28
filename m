Return-Path: <bpf+bounces-8828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEA78A6E4
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4471C2085F
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA110FE;
	Mon, 28 Aug 2023 07:57:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09610F4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D69C433C8;
	Mon, 28 Aug 2023 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209427;
	bh=ehoRvjd6YaHiAMaY8tFo1WToljCq5k1J3fsGx6EdIio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROtr0xd0uqOo6jQm7urJJcbxOuKPZ4FvdvpEalQUaWcQ2T05BpwsefAsBCGW1zmp0
	 jhTGvsQp7U4JBk4hAskjoJ3bvdwidh1LgLAzeOCMAkj9rLmBL3IdAMO04NBsTmwFcL
	 JE0Z1KwJ337lo/i4/7IVLOy/4dxyv0OW0B5tB6HdjjFPGBcne/uOIvus0Mqe5TaaDh
	 XrS3Bcv3iECDUGDIiuu6UisVBICh/aFfllPUnR7nixXrH8l+Ti2Z4RhXdDJ0VRXPII
	 ZQeY9PpdX71EznnEB8/CWW732qoxQ3gbAMftqGaU6Uq4z8N/c1oq6N153LQ/zi/gjz
	 XGnZU2ZlSfNAA==
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
Subject: [PATCH bpf-next 08/12] bpf: Count run stats in bpf_prog_run_array
Date: Mon, 28 Aug 2023 09:55:33 +0200
Message-ID: <20230828075537.194192-9-jolsa@kernel.org>
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

Count runtime stats for bf programs executed through bpf_prog_run_array
function. That covers kprobe, perf event and trace syscall probe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 478fdc4794c9..732253eea675 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2715,10 +2715,11 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 		   const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
-	const struct bpf_prog *prog;
+	struct bpf_prog *prog;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
+	u64 start;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
 
@@ -2732,7 +2733,9 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.bpf_cookie = item->bpf_cookie;
+		start = bpf_prog_start_time();
 		ret &= run_prog(prog, ctx);
+		bpf_prog_update_prog_stats(prog, start);
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
-- 
2.41.0


