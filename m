Return-Path: <bpf+bounces-9507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C42C7988DA
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C63281DCB
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FEB6AA5;
	Fri,  8 Sep 2023 14:33:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ADD3D8E;
	Fri,  8 Sep 2023 14:33:35 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362B1FEB;
	Fri,  8 Sep 2023 07:32:59 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694183574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rodg2Qs/8u1G3gvVmOwF0YriTk/PhJmMWjZEE3PZmr0=;
	b=r5y/MnaSxadgP+MU5iJP05QBti9WL/bvGWM/FgY8k3fSeZSPa3L6wAItrDg7GC2ByWXOgw
	3W6uS7zOUobb/dKcOczo0i/0YrSABOLbNCSMXQPIuYDVpLBX3k1OjuIYQSQG+NinjPOUGZ
	ESiVUOVq+eoQ4fhxdibjeEqV0dzXNIWHb3SttyMOxwrMxKOpNQ8BOAyCFP5v2KVSfIlcAZ
	RH8tOYnYuqfkS1HkE6b5BoMFvk15/1yw0O/mM3mV+XeV0iuSGKd/NvgUN3JuCGKqNV3zeA
	VkQTDBd7Wc61s6MSqEY3VBMHmrO9S6mQflZ4L1Msqi+cwyDgttC+6nLRcNGzYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694183574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rodg2Qs/8u1G3gvVmOwF0YriTk/PhJmMWjZEE3PZmr0=;
	b=qfFTB3zwBaVRXDE4t7NxtLgQ+JNnYdAhVL4b73lVPwzc868fAj1h9yao+hrMrk/R0ZyA4f
	YiUjsB2UJRz4G4BA==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 2/2] bpf: Remove xdp_do_flush_map().
Date: Fri,  8 Sep 2023 16:32:15 +0200
Message-Id: <20230908143215.869913-3-bigeasy@linutronix.de>
In-Reply-To: <20230908143215.869913-1-bigeasy@linutronix.de>
References: <20230908143215.869913-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xdp_do_flush_map() can be removed because there is no more user in tree.

Remove xdp_do_flush_map().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 761af6b3cf2bc..2befb522d8565 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -981,12 +981,6 @@ int xdp_do_redirect_frame(struct net_device *dev,
 			  struct bpf_prog *prog);
 void xdp_do_flush(void);
=20
-/* The xdp_do_flush_map() helper has been renamed to drop the _map suffix,=
 as
- * it is no longer only flushing maps. Keep this define for compatibility
- * until all drivers are updated - do not use xdp_do_flush_map() in new co=
de!
- */
-#define xdp_do_flush_map xdp_do_flush
-
 void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *=
prog, u32 act);
=20
 #ifdef CONFIG_INET
--=20
2.40.1


