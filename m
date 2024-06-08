Return-Path: <bpf+bounces-31650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99403901125
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291A528327B
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89A14B098;
	Sat,  8 Jun 2024 09:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E963D6A
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717839344; cv=none; b=e4FIDd2eKr5vpe8YUeMPiamF62khToIdVwfQ7VPzvl3TZxNelD3rJk/zKApbgXoeFYswDv4kgaU8XjA38grcvK6D5iAYZ8JBHUVwn5MwgZl71EFaT2VTTJVhy4IdiLzlopDEV0Jk7AJEgC1Il2di9Gh4aRSJrnTbgOHdpexskxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717839344; c=relaxed/simple;
	bh=1C4RlKMo/+9t+yvyY0bweVqsfy4KjDIj6BZ+EqViTxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uk7GmyUdb5FO4wRdP4SoD83Zc0jaaa2VOQP/UiZxG0YdvBX6B+SWH8KWJr/vUPsotdbb+mXlgWAaLI2Tayym8Zwv1g1Np+VEIZDCh/AfrOCzzIGkYlIqHLKugRYCcsyz9qaSTQaS7WMOa5iHKLiuI+JFQW2UD0ehJSfwav3Zvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next] bpf: Return EINVAL instead of NULL for map_lookup_elem of queue
Date: Sat,  8 Jun 2024 11:29:12 +0200
Message-ID: <20240608092912.11615-1-dev@der-flo.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Programs should use map_peek_elem over map_lookup_elem for queues. NULL is
also not a valid queue return nor a proper error, that could be handled.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/queue_stack_maps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index d869f51ea93a..85bead55024d 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -234,7 +234,8 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 /* Called from syscall or from eBPF program */
 static void *queue_stack_map_lookup_elem(struct bpf_map *map, void *key)
 {
-	return NULL;
+	/* The eBPF program should use map_peek_elem instead */
+	return ERR_PTR(-EINVAL);
 }
 
 /* Called from syscall or from eBPF program */
-- 
2.45.2


