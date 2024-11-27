Return-Path: <bpf+bounces-45748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0849DADAD
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C3828477A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139032036EE;
	Wed, 27 Nov 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I6pQFHuR"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1016A8D2;
	Wed, 27 Nov 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735251; cv=none; b=Wg7yWmwtQ0QaZEE8vRYmKMcgsnJh0C7V+zsaDu0bKg/nVLkrKlmyaxHgm4QtbY2WrAzEI2KtP8YOalBVvfSITZJo4KaURFZ6VhF50kvRlQ4TCpF0YNOzhT4WaJupHyRqh1mfCZV+E55XAafvbx+R4ITIMyazvLkxfUUsKxDnSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735251; c=relaxed/simple;
	bh=FSIdOPI7G71E81SlPJ31/CYJakCYciP1NuGPqiBf6ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+f94P8mnIkTxT1mw1WA0cnF2gjZEBR15rshp21LkSKVJUgWsOu4/ERKqary3A1L8xp1anFOUWcALo2qkFo4Clve/swdYlMcakPSU8zDEakMlgol6q8C91RGOsO8OM+7fnQv+ZxNeADAwQYZfCzS0YyDrBA8PrVHOoBb3FVuJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I6pQFHuR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735245;
	bh=FSIdOPI7G71E81SlPJ31/CYJakCYciP1NuGPqiBf6ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I6pQFHuRsMWz+nzxgY5drDkP68HgKXd+aWd9/pBgEYyRyX/ErDpqsU8wUnzr6cq/r
	 YDisRnXWXx7Le2sDwQJeAJDFVde/P5a5CwLLnZ18+j9M9rzkrLKR4Tct84bcYsHw9y
	 /is+W8VI3svs8i089MDIHSVyE8ACTL2U9XvyFru8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:22 +0100
Subject: [PATCH bpf-next 3/9] bpf: Allow registration of const struct
 bpf_struct_ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-3-a698b8d58680@weissschuh.net>
References: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net>
In-Reply-To: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
 Kui-Feng Lee <thinker.li@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Tejun Heo <tj@kernel.org>, 
 David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=3024;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FSIdOPI7G71E81SlPJ31/CYJakCYciP1NuGPqiBf6ns=;
 b=BJolLI/HSp5zIdyovEjzP9haUQNeQtMfAuKZzuqRexsJKhlQLDcJESuCetrloLZ+5ElnmmXOI
 tGmg7p3EYXDBjnLfzFE4MviBreoiQuz8G6K9/esh2CoF3PeFLkRrbXu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The BPF core does not need to modify instances of struct bpf_struct_ops
anymore. Reflect this in the API so users can move their instances into
read-only memory.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/bpf.h         | 2 +-
 include/linux/btf.h         | 2 +-
 kernel/bpf/bpf_struct_ops.c | 2 +-
 kernel/bpf/btf.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b734543b7a2b48e717d4f1be765e0198114b4f0a..a9267af9671b2bc8961cde24d2f79f473ab227d7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1814,7 +1814,7 @@ struct bpf_struct_ops_arg_info {
 };
 
 struct bpf_struct_ops_desc {
-	struct bpf_struct_ops *st_ops;
+	const struct bpf_struct_ops *st_ops;
 
 	const struct btf_type *type;
 	const struct btf_type *value_type;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c916861462e45e98690fcf461c05ca737..87a5ddef9fdc4b7f09d375ec5959abd6d07533a9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -519,7 +519,7 @@ struct bpf_verifier_log;
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 struct bpf_struct_ops;
-int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
+int __register_bpf_struct_ops(const struct bpf_struct_ops *st_ops);
 const struct bpf_struct_ops_desc *bpf_struct_ops_find_value(struct btf *btf, u32 value_id);
 const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 #else
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 7ee7c25d21d480d46b40b23ff8aec9d12ea81f68..967f0914d473fcde4a6ce3bb6ac976345daf8e88 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -314,7 +314,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log)
 {
-	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
+	const struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	struct bpf_struct_ops_arg_info *arg_info;
 	const struct btf_member *member;
 	const struct btf_type *t;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9331d0acb17a88a4ebf641509c050..e3be8b7d6cbb268cf389bac9d3f889dbfd664a2e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9155,7 +9155,7 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
 #ifdef CONFIG_BPF_JIT
 static int
-btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
+btf_add_struct_ops(struct btf *btf, const struct bpf_struct_ops *st_ops,
 		   struct bpf_verifier_log *log)
 {
 	struct btf_struct_ops_tab *tab, *new_tab;
@@ -9242,7 +9242,7 @@ bpf_struct_ops_find(struct btf *btf, u32 type_id)
 	return NULL;
 }
 
-int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+int __register_bpf_struct_ops(const struct bpf_struct_ops *st_ops)
 {
 	struct bpf_verifier_log *log;
 	struct btf *btf;

-- 
2.47.1


