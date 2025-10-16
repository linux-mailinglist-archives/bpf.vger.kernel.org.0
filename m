Return-Path: <bpf+bounces-71094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1896BE206F
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF9CD4FF91A
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3089311593;
	Thu, 16 Oct 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TWqWXaYL"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85B2FF14D;
	Thu, 16 Oct 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600776; cv=none; b=Qlf9b6bEA0EJfCs+cJVYjTJp8piUDaj5OUc1IPY7t0ppwCrZaInQi3tCS925kQxXVzALJ3yz3aRby20FbVLssw0s8EYsviu+H/sWgxwyh9tandDwueU93hv406lyGbvadkFUa0jWo+RJ8L7piLcGp8oeZlb4RQId/p+EuJcK1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600776; c=relaxed/simple;
	bh=hDnlp3LMVT5loeyAzRD7285zejpH1G4epoBItAK9wjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyijH3ZVsZrsz5JnGrinvedySsTZeG5bTA1C1/HkpTkTl4faR+yDU2QDR9p7Jppv7W3syYINOpIFA6+LnvAt6RxbH10QLzvrUHzIXDQ6biYXU6Da1GpO18etgQBFNVUpXVpGfDLUwex37pXqR7Eszlm3/WVNm9Q47ir3Kvsxpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TWqWXaYL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 50A3A1A1415;
	Thu, 16 Oct 2025 07:46:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 264276062C;
	Thu, 16 Oct 2025 07:46:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F32C8102F22AA;
	Thu, 16 Oct 2025 09:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600771; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/3LXUnTxSB4ddUvvxQJiiPX2Yasi5zJ4vq9VaVwuag8=;
	b=TWqWXaYLG7eh8QyNkLH6ux4Hj8CN7XK/bK2t/7uqaloLGfDN0qWQHLzos4fwRQMma4ZkOG
	iLDEEZMWRz0UUzx1fDA3qxMIlFWolAe1bPQpxWnzj+UVcFSFTav2aknRsW3V+p4LwW7lwK
	88sp9DIcqp8RY1erJxyn6s+k9xd7EwaG4H/jCVCl0XeBGKFP50vQSWh5mVhe1XxHRgOBPU
	aRZuE55KKREIWduZmekBfUkmFNNRhh+csPt/Et8/AgrJYSQtKUqLDJSG8ogHGp4cvptG0p
	9U6RLGSNENPBwDZFxgYGBldesQc83kBruh5wqGFqUUycLdq6Hx/y/9xvG+VL5A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:39 +0200
Subject: [PATCH bpf-next v5 10/15] selftests/bpf: test_xsk: Don't exit
 immediately when gettimeofday fails
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-10-662c95eb8005@bootlin.com>
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

exit_with_error() is called when gettimeofday() fails. This exits the
program immediately. It prevents the following tests from being run and
isn't compliant with the CI.

Return TEST_FAILURE instead of calling exit_on_error().

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 0adb6c0b948f6216b24d0562bcda26097dbb9dbc..2c955e1099439c377cd28f5a9be2a17e65d49f78 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1096,7 +1096,7 @@ static int receive_pkts(struct test_spec *test)
 
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
 
 	timeradd(&tv_now, &tv_timeout, &tv_end);
 
@@ -1112,7 +1112,7 @@ static int receive_pkts(struct test_spec *test)
 
 		ret = gettimeofday(&tv_now, NULL);
 		if (ret)
-			exit_with_error(errno);
+			return TEST_FAILURE;
 
 		if (timercmp(&tv_now, &tv_end, >)) {
 			ksft_print_msg("ERROR: [%s] Receive loop timed out\n", __func__);
@@ -1255,13 +1255,13 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
 	timeradd(&tv_now, &tv_timeout, &tv_end);
 
 	while (xsk->outstanding_tx) {
 		ret = gettimeofday(&tv_now, NULL);
 		if (ret)
-			exit_with_error(errno);
+			return TEST_FAILURE;
 		if (timercmp(&tv_now, &tv_end, >)) {
 			ksft_print_msg("ERROR: [%s] Transmission loop timed out\n", __func__);
 			return TEST_FAILURE;

-- 
2.51.0


