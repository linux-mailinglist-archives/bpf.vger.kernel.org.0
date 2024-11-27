Return-Path: <bpf+bounces-45754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF89DADC0
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938AFB25C7A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10B205E1C;
	Wed, 27 Nov 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Dq2Z1Bc0"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9B204090;
	Wed, 27 Nov 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735255; cv=none; b=UeSTfTn0rGt3tPJ9P+VUAknn2kZ2M3w45z0uDI70E0Aazo3OSJp5iUFWC8kuZI56/xE2AD3bQQg8Oej+bmOqzfmSDb6BGZLofXBPzDPFe1XnGNSJxBYr6xYn8DdWTxbcqAeYyNeUhv8+z0c/oz5pojsUGN+Xn4mXUrN/I5qeyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735255; c=relaxed/simple;
	bh=JU12z5rzuDuGYgEeHlT+HyoAu3E4JCuKXMHid87TuTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJrK+5qoGcZq/ScqXmtFN53bJWWpg5ztGNbgsnMrWb1qWQJ9q39Zhy+ocs6PyzWHP5OA8r3jEXzS76sqQTZ11mAZujIm3ckJLGBfbR522LHbLvA8Z8kSZzYv4aeqZi0kILWLhVLhgzFKrhaqbqUEr3Sgtd2O3zNLa+vp8tZh0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Dq2Z1Bc0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735246;
	bh=JU12z5rzuDuGYgEeHlT+HyoAu3E4JCuKXMHid87TuTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dq2Z1Bc0N+mMBm+xuOWCk+4pqOO71TH3uul5yo2vJAWu+4lq62GkvOe0/iEB+57oq
	 GS0d4cd0LsXI85+bW+I3B4Ymv/NLaKSi/8A4mmF8K8xTAviH0DUxX/Lc0Q7M+iTYaT
	 iDmMKKXKt9BJvTZna2fYE5h68wYTy2xP671fup1U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:26 +0100
Subject: [PATCH bpf-next 7/9] bpf, net: dummy_ops: Constify BPF ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-7-a698b8d58680@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=1414;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JU12z5rzuDuGYgEeHlT+HyoAu3E4JCuKXMHid87TuTc=;
 b=X7Jn4w2by4ezsk3zFqrGQVObmVC43mtETN0abDpQwXFZr7P4ri9iVD/phbu2o7dKGkYVBFmzF
 luLnFIbfcs8D8fAns2NOKxhI9ALI8pOA3NpMiHoanSAQE7nizqnHfhr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The BPF core now allows the registration of read-only ops tables,
make use of it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/bpf/bpf_dummy_struct_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 3a675227074e546e6a02e80db3841ed72d5bbff8..b0f3d90f153b34d46fbf37964cc3caf4bec9a4af 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -7,7 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 
-static struct bpf_struct_ops bpf_bpf_dummy_ops;
+static const struct bpf_struct_ops bpf_bpf_dummy_ops;
 
 /* A common type for test_N with return value in bpf_dummy_ops */
 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
@@ -297,13 +297,13 @@ static int bpf_dummy_test_sleepable(struct bpf_dummy_ops_state *cb)
 	return 0;
 }
 
-static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
+static const struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
 	.test_1 = bpf_dummy_ops__test_1,
 	.test_2 = bpf_dummy_test_2,
 	.test_sleepable = bpf_dummy_test_sleepable,
 };
 
-static struct bpf_struct_ops bpf_bpf_dummy_ops = {
+static const struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.verifier_ops = &bpf_dummy_verifier_ops,
 	.init = bpf_dummy_init,
 	.check_member = bpf_dummy_ops_check_member,

-- 
2.47.1


