Return-Path: <bpf+bounces-45749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30949DADAE
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43928B23FDF
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E02036F5;
	Wed, 27 Nov 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jFMJYZsw"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC58200B95;
	Wed, 27 Nov 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735251; cv=none; b=kIvABfJdRYRHd2w9ZyJcXnkWumpfSyKwcJ59QJfBFH33cm8+UZK0rwzxi+mYblUxWjpepK8rA3g12xiZU7tBy4ut6I7jANs4HwndBvT5dckloBUZyyP0EZ2t57LE1ynSQpWheWchqQsGd8ZbsyLQdMY3i1urHJv136u9nhjvZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735251; c=relaxed/simple;
	bh=KtwbEqFpnwCczek16OOedUheaLXyXVIfozidQrI0uUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzuCGfN2S2Ow3ukQmvuNYe/gEJrYG49WdqLS7wfs/3LjPLaWqANCw78IBbHEXO6zJdkoSU8buVFP5kfgERwK/nuPw+CHQx6AI27eYm92yLcGCWNucRIMWhBy9Ai3US1qGX4bS1ajUxddkeN5SePrfZrqIzJUvWfq19IB26q+ZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jFMJYZsw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735246;
	bh=KtwbEqFpnwCczek16OOedUheaLXyXVIfozidQrI0uUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jFMJYZswpV72PsYnBLk9fA0ivlsvcxSLmKiej9qOQ9tbfsnNAmgryDG60B9Ed42Qp
	 H6jkH4PnoIBpYN6VlX9h1KzmmX6ktBYiCrxjmE9N9Rxs0ZDlS5U46uujAUnqhGY8Y5
	 qT6Hb4SRVe+kP/PvifyXuUC3r7kB41qOeXD/9YwM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:24 +0100
Subject: [PATCH bpf-next 5/9] bpf: Allow registration of const cfi_stubs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-5-a698b8d58680@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=1514;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KtwbEqFpnwCczek16OOedUheaLXyXVIfozidQrI0uUw=;
 b=KpuXC0mLiHk4BoFEt+TSl42FiwTEq/ap2yVY3heLEigxFb2I0wUKPZJZkINMI1AopeGtO6wnI
 2Oev6Ufy0VwDveY03Cs721MrPZ83t+7IyUUQv9ly1zWAYM/J1rBehAB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The BPF core does not need to modify the cfi_stubs.
Reflect this in the API so users can move their structures into
read-only memory.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/bpf.h         | 2 +-
 kernel/bpf/bpf_struct_ops.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a9267af9671b2bc8961cde24d2f79f473ab227d7..fbe5ae7c2b380fdb624ea1f04fdf56e4f6710f14 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1795,7 +1795,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata, struct bpf_link *link);
 	int (*update)(void *kdata, void *old_kdata, struct bpf_link *link);
 	int (*validate)(void *kdata);
-	void *cfi_stubs;
+	const void *cfi_stubs;
 	struct module *owner;
 	const char *name;
 };
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 967f0914d473fcde4a6ce3bb6ac976345daf8e88..2a9b9c39f1e7c2c22dc83ad68766b522117f3979 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -778,7 +778,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops_desc->func_models[i],
-						*(void **)(st_ops->cfi_stubs + moff),
+						*(void *const *)(st_ops->cfi_stubs + moff),
 						&image, &image_off,
 						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
 		if (err)

-- 
2.47.1


