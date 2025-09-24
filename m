Return-Path: <bpf+bounces-69551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE0B9A5A6
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 16:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2C01B2740B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC830E0DB;
	Wed, 24 Sep 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XNg8TocZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F030CB22
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725417; cv=none; b=gF/IrUJIImFXV7UTvz6fVaZPv/E/vV15Lm/lnoekfHw56B89PjhCuf1tEeJmyNt8Rz2AQsVhTTz2H63tHENEJgF+CgTjOxRgulGiE4may8k8zXt3DTeYj5NipxKxLBhTt0iaEYHnWmkT9mQ7xim3Iy5tvrpNXDQanYUx53b52GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725417; c=relaxed/simple;
	bh=p5/Ue/EDWrCLygK9OUD9Vn8dsndfDHqeLNBvRGglxCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4si8o3/9DdC+U2Bp1ZIjXUFYkLiJufWW4BasXswjToyGg05VFaLN9BXARmHlbb/KL9iLub/VQoMKdttLzt+0vHzM8GRST042ucOvXd7Losgc4dVmtEiUpxBBJNs9n6jF/QinYMvf7sESGwxS9+XM1s2gkZWEfHfGXIMMQVolh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XNg8TocZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6EDAEC011C7;
	Wed, 24 Sep 2025 14:49:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A75860634;
	Wed, 24 Sep 2025 14:50:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAE84102F18D8;
	Wed, 24 Sep 2025 16:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ez1VzhqefwOv/TLGGLfSuvB3WSc3tsfGzKqORDO0iCU=;
	b=XNg8TocZoYR9DFgkjwpAElOvJVPmjc7W/W1zUUMJ2EVgqJrDlSWIpXHoxPn+WBeGeCrAAW
	On8bhnSmDzwe28+vCD2iaaBDVV3y81EQ+W/awfc+Nl+Aav8hODfllJWgRIvv9dqJ+i4ecI
	i92iHcChbaqHyRSvaLl9/zw3M8ymJ08olWkJt9JNOuayiHdsVryDF1txplfVflzar/U/6r
	xbhKQ2SOX9AJnTScTaNp/yExhJ5ex6R2NiYTIvywrkSs5eggFMudnQ61fn3T0RgKwhwNUo
	6agJRT9MY9sLVILNGGbxLUtF8tQHIGPvwK9KcZOY62yrSZ1YM7fihddAu2PViw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:40 +0200
Subject: [PATCH bpf-next v4 05/15] selftests/bpf: test_xsk: fix memory leak
 in testapp_xdp_shared_umem()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-5-20e57537b876@bootlin.com>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
In-Reply-To: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

testapp_xdp_shared_umem() generates pkt_stream on each xsk from xsk_arr,
where normally xsk_arr[0] gets pkt_streams and xsk_arr[1] have them NULLed.
At the end of the test pkt_stream_restore_default() only releases
xsk_arr[0] which leads to memory leaks.

Release the missing pkt_stream at the end of testapp_xdp_shared_umem()

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index eb18288ea1e4aa1c9337d16333b7174ecaed0999..d7cb2821469c62abd0d532821e836336a2177eb5 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -570,6 +570,22 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
 	}
 }
 
+static void release_even_odd_sequence(struct test_spec *test)
+{
+	struct pkt_stream *later_free_tx = test->ifobj_tx->xsk->pkt_stream;
+	struct pkt_stream *later_free_rx = test->ifobj_rx->xsk->pkt_stream;
+	int i;
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		/* later_free_{rx/tx} will be freed by restore_default() */
+		if (test->ifobj_tx->xsk_arr[i].pkt_stream != later_free_tx)
+			pkt_stream_delete(test->ifobj_tx->xsk_arr[i].pkt_stream);
+		if (test->ifobj_rx->xsk_arr[i].pkt_stream != later_free_rx)
+			pkt_stream_delete(test->ifobj_rx->xsk_arr[i].pkt_stream);
+	}
+
+}
+
 static u64 pkt_get_addr(struct pkt *pkt, struct xsk_umem_info *umem)
 {
 	if (!pkt->valid)
@@ -2043,6 +2059,7 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 {
 	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	int ret;
 
 	test->total_steps = 1;
 	test->nb_sockets = 2;
@@ -2053,7 +2070,11 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 
 	pkt_stream_even_odd_sequence(test);
 
-	return testapp_validate_traffic(test);
+	ret = testapp_validate_traffic(test);
+
+	release_even_odd_sequence(test);
+
+	return ret;
 }
 
 int testapp_poll_txq_tmout(struct test_spec *test)

-- 
2.51.0


