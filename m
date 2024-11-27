Return-Path: <bpf+bounces-45747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE04A9DADA5
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC57B232EA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5196202F7F;
	Wed, 27 Nov 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mXXNK4Bp"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682791FF7AA;
	Wed, 27 Nov 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735251; cv=none; b=cj+K0zZmbZ//hzLz7QeRET3kEoVzY3C62V2zvWSUDH4Af7d6Ce2G8CXOG8PoH/Xno27rnJIptRYpZn5h/0XvWIQCjyqsqSr834wQGLbHG4hTQqVZdJI9KkI0XdU6AnUgJm3kOCbbecr4FHrud5t77zuCagvB1jR64fsT2pLfB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735251; c=relaxed/simple;
	bh=j+Y13MSIpYC9IMfunH7OOKMb4F7xuB+1KU8yNntWscA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VE5DANU24Td1vMToxK3cwNsNcJBor5r6uBA/LwlZ8/8HrerBbKAT26BX/kCMhwz/04C2uBZ8i6rYJM+HBQrQMbl4XJ5fGL06SK4ylqmcbhxabxLzdWbA0zWi3wA/z1/ZW+sYvcJMi1s3y5eELrbG2OmJlqpjVInzz45tT4JSPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mXXNK4Bp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735245;
	bh=j+Y13MSIpYC9IMfunH7OOKMb4F7xuB+1KU8yNntWscA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mXXNK4BpTRDyul0Yyyh+2TgWb4YZnsqvI4bGeVRlCnmUAJWZOJzL0kB2MV7Ci7N+W
	 WSPiB4tzpKZySb+VCjTXh6L4ty3V99gzGECWZvrqEl1V4JRsQR7ntFYGcgPw0iDC0G
	 1MGQF58Isit24zn0O4WkBqsnQ/G6Qt5MHtYuUArQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:21 +0100
Subject: [PATCH bpf-next 2/9] bpf: Move func_models from bpf_struct_ops to
 bpf_struct_ops_desc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-2-a698b8d58680@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=3668;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=j+Y13MSIpYC9IMfunH7OOKMb4F7xuB+1KU8yNntWscA=;
 b=qf3rhqnd/jR5IPIOWFkhYUOSIKFWy2kJxY+Qsb9QXA8GibI1+LPwRaJaQxEPBo2c297pFfmw/
 sxd7IMK0WK/A4U7ARq4JdXzG/LGlLeLLiboLL7G2qtyT3UgMNP61EY/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The func_models are the only member of struct bpf_struct_ops which are
modified by the BPF core.
Moving it into bpf_struct_ops_desc allows the static definitions of
bpf_struct_ops throughout the tree being moved into read-only memory.

The dummy ops don't have access to a bpf_struct_ops_desc.
For them declare a dedicated static variable for the func_members.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/bpf.h            | 4 ++--
 kernel/bpf/bpf_struct_ops.c    | 4 ++--
 net/bpf/bpf_dummy_struct_ops.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ace0d6227e3cb70dd75bdc6afa52870dee250f1..b734543b7a2b48e717d4f1be765e0198114b4f0a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1779,7 +1779,6 @@ struct btf_member;
  * @type: BTF type.
  * @value_type: Value type.
  * @name: The name of the struct bpf_struct_ops object.
- * @func_models: Func models
  * @type_id: BTF type id.
  * @value_id: BTF value id.
  */
@@ -1799,7 +1798,6 @@ struct bpf_struct_ops {
 	void *cfi_stubs;
 	struct module *owner;
 	const char *name;
-	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
 /* Every member of a struct_ops type has an instance even a member is not
@@ -1825,6 +1823,8 @@ struct bpf_struct_ops_desc {
 
 	/* Collection of argument information for each member */
 	struct bpf_struct_ops_arg_info *arg_info;
+
+	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
 enum bpf_struct_ops_state {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 606efe32485a985b854aa7e96e1a7f7cfd5057d3..7ee7c25d21d480d46b40b23ff8aec9d12ea81f68 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -397,7 +397,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 
 		if (btf_distill_func_proto(log, btf,
 					   func_proto, mname,
-					   &st_ops->func_models[i])) {
+					   &st_ops_desc->func_models[i])) {
 			pr_warn("Error in parsing func ptr %s in struct %s\n",
 				mname, st_ops->name);
 			err = -EINVAL;
@@ -777,7 +777,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
-						&st_ops->func_models[i],
+						&st_ops_desc->func_models[i],
 						*(void **)(st_ops->cfi_stubs + moff),
 						&image, &image_off,
 						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index f71f67c6896b3de862a556d6f1e959a378cbda96..3a675227074e546e6a02e80db3841ed72d5bbff8 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -129,7 +129,7 @@ extern const struct bpf_link_ops bpf_struct_ops_link_lops;
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr)
 {
-	const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
+	static typeof_member(struct bpf_struct_ops_desc, func_models) func_models;
 	const struct btf_type *func_proto;
 	struct bpf_dummy_ops_test_args *args;
 	struct bpf_tramp_links *tlinks = NULL;
@@ -175,7 +175,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	op_idx = prog->expected_attach_type;
 	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
-						&st_ops->func_models[op_idx],
+						&func_models[op_idx],
 						&dummy_ops_test_ret_function,
 						&image, &image_off,
 						true);

-- 
2.47.1


