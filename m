Return-Path: <bpf+bounces-35607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5433293BBF9
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 07:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0AA286287
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 05:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7801CA8A;
	Thu, 25 Jul 2024 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjusaka.me header.i=@manjusaka.me header.b="MqwJykL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MeQWXQT+"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBF29CA;
	Thu, 25 Jul 2024 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721884544; cv=none; b=QGDjbWCFurCodLfLbadtw+yb5GNQiKJwAitJchfuRF6a5yGXpm8/KmtOwu0l7f/WHQ2BLoviWCndagBkoSAM3cLMUd/4I+uOFdEWRndgHkoF9Kj44MRo9RGg29ZfuideeJi2RyrfxxpralDJYQan18ncqQCIaqPT33VNhL65A3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721884544; c=relaxed/simple;
	bh=ugClgkqp3o25GQZQ2zOKkXMz+zp9JFfCDQC6cbyBDpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KEbsViW7ZOSD8B6EZmBhB4QmSJWevEwMi7zSbw9fDvaCGsc8gAC4CovMgOIwJk6QU+QW5sCblyiBQ61Zi8t76eifutEUe4TpJDCXxqXI0ueQdX4QW3KGJHnh695b8C5M73Kz/6cOMr/O6pxUnGmTbj9eeH2+TaD2PR4PG8r7QfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manjusaka.me; spf=pass smtp.mailfrom=manjusaka.me; dkim=pass (2048-bit key) header.d=manjusaka.me header.i=@manjusaka.me header.b=MqwJykL8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MeQWXQT+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manjusaka.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjusaka.me
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E037811401EC;
	Thu, 25 Jul 2024 01:15:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 25 Jul 2024 01:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1721884540; x=1721970940; bh=uhItQUTfSvaoSBISN9Ydg
	QVPePTnvG2hT1BbYLXVSik=; b=MqwJykL8VezW91SHbn9oa/6C1P3g9Z7iU1qmU
	lgIZVGfIYeUqUuklDEFfm7N0YOyh/xzail9BvFbrx42BIdlr+qBVJVMGDFY2jHrN
	+Yyx7giy+zPwmaI/p0SnfL4u3RZTGkwR3im5YRl4CKtK+Ler5raA3H6/mAW19Hqj
	lyFZ53APREsKBJQDRO29sXVPBWXnDmNJpYH7OB3gx5Fi8Ojerlc6qHkzW7QbS6Ux
	0YOBDB4hNtWX5JIauzQGOZbuxXXCnJnGaFScHyANnS2RduQGUt/Lsau33HYDI7yz
	3ncPVe860bxm1J75Z5mfT5E5UjILS9pk0NX514XKWtCB66vmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721884540; x=1721970940; bh=uhItQUTfSvaoSBISN9YdgQVPePTn
	vG2hT1BbYLXVSik=; b=MeQWXQT+C2Vde9wxGAPAuLMQDyLmD4YJhIe4dhQ0feSn
	qAbZ55dMAnzexQJtJe4G1RyTS/PhfGEKpEO9IVZkiq91AxuRaT8MkicT+6NuGDoE
	j5aVlQe1611N+kRBEYA0a3KnoPcHzmTUHVvgeEM+04F5hEyFJOkXbyDR62lx8wFp
	rXEum13gXgyrJq3XiQwcEqHSbvxQQm9jtIIPGDfkaxq6iSp7NVJhK8lLAjSSh+T6
	yA2DQeZuP4fg5a47U2SalNP8mlXfuAUSfhkC1lpKbG9S2LG/caBNC/cWhvb5W+m9
	/6BkXq2KK+OHBWAPjj71l2luNCvlc90iFNinimfRCg==
X-ME-Sender: <xms:fN-hZmRbQZPsyusIdVejJx7PWfBZWz7f4sdTFrz9OEvXqpg6JmgehQ>
    <xme:fN-hZrzdFavOce9n6jKYEiEuqr3iGx5IzXrGzuyRu_UP76yuEVOTEmPjfmGbrRGH8
    K44kg1X0HDT0G_MOLM>
X-ME-Received: <xmr:fN-hZj2pNubr2jmKEcAOiBdCw1Vd4msGKG9XYO9i3GUkKbuWkgkLkrCS8t-KU0e97gNKVMmSJccgQ9wqoME9dQCcX8kRpSQ7HfNbnLBXC-yFpcYY00B1cgbAKDPXgIg6UgR_Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedvgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpegkhhgvrghoucfn
    ihcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgvqeenucggtffrrghtthgvrhhnpefgudejve
    ettdekhfejhedufeefvdffkeffteevheeitdehkeekledttefhieeifeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesmhgrnhhjuhhsrghkrgdrmhgv
    pdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:fN-hZiBJclDCt-RBpYHWcVlIQc86WwAN0nVjBxNAtNf6Sg7IqCmYlA>
    <xmx:fN-hZvimH1QL3odg79vCg-fPxHgRQ9P9pDi97rcbbh0vqIKgk7-uog>
    <xmx:fN-hZuqDA79hhnoVkAaaqWjprRWBSIE2PclGCIS7WnSarkF5yckztQ>
    <xmx:fN-hZij4WHdpgYOXzrdWl-eLJBEiQyozx8ol9-BQDpMdHFYbzoiH5A>
    <xmx:fN-hZuRAOdA64BcOuf8PTps7ndb1bnJrsvnnvm0U0shns3EaOEEq0xQy>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 01:15:38 -0400 (EDT)
From: Zheao Li <me@manjusaka.me>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Zheao Li <me@manjusaka.me>,
	Leon Hwang <hffilwlqm@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog method to output failure logs to kernel
Date: Thu, 25 Jul 2024 05:15:11 +0000
Message-Id: <20240725051511.57112-1-me@manjusaka.me>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v2 patch, previous Link: https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me/T/#u

Compare with v1:

1. Format the code style and signed-off field
2. Use a shorter name bpf_check_attach_target_with_klog instead of
original name bpf_check_attach_target_with_kernel_log

When attaching a freplace hook, failures can occur,
but currently, no output is provided to help developers diagnose the root cause.

This commit adds a new method, bpf_check_attach_target_with_klog,
which outputs the verifier log to the kernel.
Developers can then use dmesg to obtain more detailed information about the failure.

For an example of eBPF code,
Link: https://github.com/Asphaltt/learn-by-example/blob/main/ebpf/freplace/main.go

Co-developed-by: Leon Hwang <hffilwlqm@gmail.com>
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
Signed-off-by: Zheao Li <me@manjusaka.me>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/syscall.c         |  5 +++--
 kernel/bpf/trampoline.c      |  6 +++---
 kernel/bpf/verifier.c        | 19 +++++++++++++++++++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cea15c81b8a..8eddba62c194 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -848,6 +848,11 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
+int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
+					    const struct bpf_prog *tgt_prog,
+					    u32 btf_id,
+					    struct bpf_attach_target_info *tgt_info);
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 869265852d51..bf826fcc8cf4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3464,8 +3464,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
-					      &tgt_info);
+		err = bpf_check_attach_target_with_klog(prog, NULL,
+							      prog->aux->attach_btf_id,
+							      &tgt_info);
 		if (err)
 			goto out_unlock;
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400..8862adaa7302 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -699,9 +699,9 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	u64 key;
 	int err;
 
-	err = bpf_check_attach_target(NULL, prog, NULL,
-				      prog->aux->attach_btf_id,
-				      &tgt_info);
+	err = bpf_check_attach_target_with_klog(prog, NULL,
+						      prog->aux->attach_btf_id,
+						      &tgt_info);
 	if (err)
 		return err;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f5302fb0957..4873b72f5a9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21643,6 +21643,25 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
+					    const struct bpf_prog *tgt_prog,
+					    u32 btf_id,
+					    struct bpf_attach_target_info *tgt_info);
+{
+	struct bpf_verifier_log *log;
+	int err;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
+	if (!log) {
+		err = -ENOMEM;
+		return err;
+	}
+	log->level = BPF_LOG_KERNEL;
+	err = bpf_check_attach_target(log, prog, tgt_prog, btf_id, tgt_info);
+	kfree(log);
+	return err;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
-- 
2.34.1


