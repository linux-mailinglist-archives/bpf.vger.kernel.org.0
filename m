Return-Path: <bpf+bounces-45753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB89DADBB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D522812BA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E16205AD8;
	Wed, 27 Nov 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dsM2BpMX"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47A2040A1;
	Wed, 27 Nov 2024 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735254; cv=none; b=T1kEIFkwgeVK7l4WG+Qs5PINvlRDQh9fiJ2z7PBOup5OmhN1eUOW+Ld47TBuuYwNPUP4DpysDm+c3rlPsQSxQ1fiTgVlJm8hYWqXxlUiZ72mm/+h5mrlzMmO+ss52LdxzdiZac2OnuM78Gtk0LYbqWghBVS7PESCZb3sGAh35vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735254; c=relaxed/simple;
	bh=uaijE66Fe3UNqo6KTVPXSOBtcXZnHjGLU0ltOFEPyPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVPRAt55BHrwfd3zzqzWrQOuuDsPoRl3SmaWI8lhGvEnQp/2NBDPQ0XYvGgVZH+qvc3ZCyGnDNrPIDwTX0WU0h0n4Zu+X3GTyWY1gmbuynyx1NCMuWmT0TT5RduCJozqwaojVnl7N6k2zHgZdfqS/9JYFEqePDyX348S3UBqRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dsM2BpMX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735251;
	bh=uaijE66Fe3UNqo6KTVPXSOBtcXZnHjGLU0ltOFEPyPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dsM2BpMXK7P/gLpFmVIYx3PjQnMbU4m44KahAfDMYgAlvHaboZro7Z+60G9Wr3hYH
	 ptbSe27SjJoZUOTFIN9Uj1Ynh2UlWLK6wdOyjFI+91ZencR7WsCGGAZYRvKr+NlqlB
	 tnC6pgRo7T20UfFmuu0IwfZoF8k/Fac9hOhVXx78=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:25 +0100
Subject: [PATCH bpf-next 6/9] bpf, net: tcp: Constify BPF ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-6-a698b8d58680@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=1437;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uaijE66Fe3UNqo6KTVPXSOBtcXZnHjGLU0ltOFEPyPU=;
 b=Qm2cJwW4/GkO4d4SaspvVMAln4+ovMuChvelp6LJdqe9MvTLEA1jzkm+NlAMwWK692WfQ1eDo
 FJ2te6sasfOBEiqOwNjIChtBhQmG+k+whvC6lJ12zAW1b49RglDM8jA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The BPF core now allows the registration of read-only ops tables,
make use of it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/ipv4/bpf_tcp_ca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index ce5012f6821d543541b13275aff87bef0abf4677..9b95dcacf3467de69e366e9196c36c4c92f78d75 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -11,7 +11,7 @@
 #include <net/tcp.h>
 #include <net/bpf_sk_storage.h>
 
-static struct bpf_struct_ops bpf_tcp_congestion_ops;
+static const struct bpf_struct_ops bpf_tcp_congestion_ops;
 
 static const struct btf_type *tcp_sock_type;
 static u32 tcp_sock_id, sock_id;
@@ -307,7 +307,7 @@ static void __bpf_tcp_ca_release(struct sock *sk)
 {
 }
 
-static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
+static const struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.ssthresh = bpf_tcp_ca_ssthresh,
 	.cong_avoid = bpf_tcp_ca_cong_avoid,
 	.set_state = bpf_tcp_ca_set_state,
@@ -323,7 +323,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.release = __bpf_tcp_ca_release,
 };
 
-static struct bpf_struct_ops bpf_tcp_congestion_ops = {
+static const struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.verifier_ops = &bpf_tcp_ca_verifier_ops,
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,

-- 
2.47.1


