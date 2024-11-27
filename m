Return-Path: <bpf+bounces-45745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDE9DADA3
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E0165DFF
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2E202F6F;
	Wed, 27 Nov 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ffDLLbXM"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADE83A17;
	Wed, 27 Nov 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735251; cv=none; b=vCNEG5j1ZCkpZVSJI2U4C3hYTlDf0vo9SZ5LrmybKyQdl1ZrJcDOs9oiJzNneYVu7kBf0k84jFEtiqSQK04/v8yyCWv8FPF41x1YsE1bJnz2clAgBlw28OgyOVonzBLHOq9Tl943vGj9ZwZyE21B6fbmNRivvq68Y0TZzJQH3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735251; c=relaxed/simple;
	bh=SPP5A1FLuqjp7YWIjzGFzkMuvaLaozdDJfexWQfvdfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iK42B7hDoBhSwD/4dVu9zDsXUUZcrA+Eu7N64Kusto1bvBfYpVoZEgrQMListnNJAtG8+fNQOm220EDfqV4pHGn7VK88oNBckHIJe5inGA2CpWXkjn7EP9flzJIaleeP2xsdD9+DJP+k+V2XNA2MZKWfDmfUXXhQf0is0ZqSyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ffDLLbXM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735245;
	bh=SPP5A1FLuqjp7YWIjzGFzkMuvaLaozdDJfexWQfvdfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ffDLLbXMINI3aaTSl45JsazDmUpbn4W+EfqQTkrzumTBybsKHHwAYup9HVu8d6SX0
	 3icCN2XAHfFFuw//q6SzsoiyxOrocRnMORBXvb09SarMlo+qK2kJ1FS5DxSp3MCsHP
	 vzVJI4FwQY/6wQTXt2w6ldnRHEweHPd3IrxUuA58=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:20 +0100
Subject: [PATCH bpf-next 1/9] bpf: tcp: Remove inaccurate comment about
 extern
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-1-a698b8d58680@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=782;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SPP5A1FLuqjp7YWIjzGFzkMuvaLaozdDJfexWQfvdfA=;
 b=KN/aWxe/VChXuEDXwVRvceUnWWLhuyTogCfxgTBGVFF0Y/k72S+3+6FI1HX5L6DeNfT3TvlK5
 Zx+f01lMb9QBRVgzGOkguEDk+x7e0ZuqvNuEpWW66CBHCe0oOJBWMwH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The "extern" qualifier which the comment refers to was removed.
Also remove the comment.

Fixes: f6be98d19985 ("bpf, net: switch to dynamic registration")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/ipv4/bpf_tcp_ca.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 554804774628e4b3d03bc3b19b96d717a581439e..ce5012f6821d543541b13275aff87bef0abf4677 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -11,7 +11,6 @@
 #include <net/tcp.h>
 #include <net/bpf_sk_storage.h>
 
-/* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
 static struct bpf_struct_ops bpf_tcp_congestion_ops;
 
 static const struct btf_type *tcp_sock_type;

-- 
2.47.1


