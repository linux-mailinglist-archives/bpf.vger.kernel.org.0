Return-Path: <bpf+bounces-71088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26218BE1FC9
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 09:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56341A60ABA
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD004302CBD;
	Thu, 16 Oct 2025 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iZI7KniK"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CE2BAF9;
	Thu, 16 Oct 2025 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600760; cv=none; b=BS1vQ8Fd9SQBm0LEp2HfKkINJ6lurfhC6RxgVZRfKoMDmvRvmD42EZLCptE2bJFBDggH5aIeBsGRbfomjcNzLArLXiZnU0f7VgdddXhrd47i65+1UXFOlv9nOqkXRCJlA6F5srK8265BGvwt4kL35JstOCAjmvzRPouZc1jOSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600760; c=relaxed/simple;
	bh=QrlqFGzpjZmAoE0WhzSb3xJxJEZ4ob+vvZgBRHaTTSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX9fT0oEm+9ID70N5UnSYG3/f8l+wTQmp3YyzdUM/1oWl5+WZ5Pif+aaGmm0U10JhWJp4oomGKWrLYquuT2rdzENthF2rys0WS7nFBxBaSSf3Y0XK2yDCoT6dmxiFkZkXRHmOn17Zw0BK7OaXajU+tFbQCSr0FGbJbcD7o1AEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iZI7KniK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B2529C03599;
	Thu, 16 Oct 2025 07:45:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2C3F6062C;
	Thu, 16 Oct 2025 07:45:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 753CB102F22B9;
	Thu, 16 Oct 2025 09:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600755; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eFjsOb3LsDj9nnNF55g5hT7ZyqAX/4ssZuJigX1uMXI=;
	b=iZI7KniKPAjXyDoDiCClLQwEFjjLhCfLGuRZDh07c3q1LCBlN3mbZjxgoyFxOQyQ51ghJw
	yalZU4C30VD7ofYyPkuxd2HdapFZ7wUrNwuDJSCeUZgEuSwAPkGF7oyIDT97hgBRnt9z3d
	0ikVDI2Kt727KU4q6ru40NMoOf7qfoHgvR9rZjvra1Sdyjfr7QSF176P8mzQFvNP5PFa3Q
	dmVWbgXnRTRaBi30hjUZZz934ByrGEL7nWfW0k4vN6HDDMre8WvmrIsscbkpcwLPOtDB36
	4woDl/PVthiq3RNYew781DY1QDJ8+ej5FhlNmUq5RWxkWi6ORp78fC7FvZZ+mQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:33 +0200
Subject: [PATCH bpf-next v5 04/15] selftests/bpf: test_xsk: fix memory leak
 in testapp_stats_rx_dropped()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-4-662c95eb8005@bootlin.com>
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
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

testapp_stats_rx_dropped() generates pkt_stream twice. The last
generated is released by pkt_stream_restore_default() at the end of the
test but we lose the pointer of the first pkt_stream.

Release the 'middle' pkt_stream when it's getting replaced to prevent
memory leaks.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
 	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
 	u32 i;
 
+	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
+		/* Packet stream has already been replaced so we have to release this one.
+		 * The newly created one will be freed by the restore_default() at the
+		 * end of the test
+		 */
+		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
+
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
 							      pkt_stream->pkts[0].len);
 	pkt_stream = test->ifobj_rx->xsk->pkt_stream;

-- 
2.51.0


