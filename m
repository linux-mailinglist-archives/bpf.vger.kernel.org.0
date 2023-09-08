Return-Path: <bpf+bounces-9505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA279883B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2601C208B7
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE4134D9;
	Fri,  8 Sep 2023 13:58:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABE125A6;
	Fri,  8 Sep 2023 13:58:01 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F971BF5;
	Fri,  8 Sep 2023 06:58:00 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694181479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDmUPAeW4CUFwvGNZZf+Y/8buEalFOTqf/KOWGRWSAs=;
	b=0yDMz0gir+qi/hNhG31yIvHtnYwsrI5/toPSLQEyHKG4Xi6k4rlnTnTM6vQtOBUmlMAPdl
	+lyZ1/dUNVMe9TKdpZX6vbFs2zlFIawjr0bBcpF2aB5pxe+mpYHEJU+/3F/0RS1emKmlCF
	PTxhpt2eAqXiODymfUO/UhuMQiPtPEIDFMQUIhGGFTR7flBC7kY/bm9fnP4d4pXBG7rGzU
	SmC77qnKDS3GYwU/jqlyXeAVyLtikIw2XDZ/h5ikxw9QILttUxJ9b2kdZ99/RXHOMcLRoS
	vD/wg6pj5t5LrZSTlarBmACtA5hcI+MlqBKvYpJ4lf8ib5m3Y0/mhStMAhu4rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694181479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDmUPAeW4CUFwvGNZZf+Y/8buEalFOTqf/KOWGRWSAs=;
	b=0iLvnp+f+za9kQ0fZ7x9NKxPirY4+8PCAWEj2PubSOrnXR0MNNMEIdvFZk8cUG+EOgbyKG
	48L9GR7pv45HN4Dw==
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH net 4/4] bpf, cpumap: Flush xdp after cpu_map_bpf_prog_run_skb().
Date: Fri,  8 Sep 2023 15:57:48 +0200
Message-Id: <20230908135748.794163-5-bigeasy@linutronix.de>
In-Reply-To: <20230908135748.794163-1-bigeasy@linutronix.de>
References: <20230908135748.794163-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xdp_do_flush() should be invoked before leaving the NAPI poll function
if XDP-redirect has been performed.

There are two possible XDP invocations in cpu_map_bpf_prog_run():
- cpu_map_bpf_prog_run_xdp()
- cpu_map_bpf_prog_run_skb()

Both functions update stats->redirect if a redirect is performed but
xdp_do_flush() is only invoked after the former.

Invoke xdp_do_flush() after both functions run and a redirect was
performed.

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Fixes: 11941f8a85362 ("bpf: cpumap: Implement generic cpumap")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/cpumap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index e42a1bdb7f536..f3ba11b4a732b 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -248,12 +248,12 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_en=
try *rcpu, void **frames,
=20
 	nframes =3D cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
=20
-	if (stats->redirect)
-		xdp_do_flush();
-
 	if (unlikely(!list_empty(list)))
 		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
=20
+	if (stats->redirect)
+		xdp_do_flush();
+
 	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
=20
 	return nframes;
--=20
2.40.1


