Return-Path: <bpf+bounces-75113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED70DC71588
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 23:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 887AE30349
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EE33B6CB;
	Wed, 19 Nov 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="YJTQK6bP"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129A3358D1
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592177; cv=none; b=qf07s3iEXq3zNg9LFbd9vn9GF+zKTu6+13GDPq8S+fZ00OgcPz9HO57DXHQOa557XImMItxcncKpLCmwfdISH7eAHKlnbrhhX4EeL41dmWhcfuKglXkS9cMHNu7gFSceKokCt2UqKPoUQfc6zH7ifIQSR8+STvRVU/oqUPygWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592177; c=relaxed/simple;
	bh=gAsQ1BSMJqiVR8shfZtZyu7x2+PjqZJQokKQtFZDbhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/LWMzYeqO3GPf54BmH4lBVbuBpma1X+5Rs9kgXsiecK8WLbr83l6iE7an2luPBFnKkZhMsDDI1Vpn/KsErlkk7CEexZlLcnUSwNHEHE4a+0CUduE9dmGliMlUpp2gu0dOe2h95c/zKyX7CfsH30ziLZpV0jquSb5VTSq7VRQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=YJTQK6bP; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt2-006ywi-3L; Wed, 19 Nov 2025 23:42:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=lcMHhp25wy5nbuDPLhTDVdMWQ5rl0c1LdhaGtzxA1uQ=; b=YJTQK6bPVL5ryK/U8U+yc5/0S7
	X2CDQZgd2Bl2hh7/DQY1DYXJ87uCIBxyP1QRtS2cpgwfmAjGQ6hMpMccxcUZAiHiAP96Kk5ogAcEM
	OJ3uRc9DCQEZhb9aAvZY8hHJ0s9C/1tkkiL6JFWPSOA8OeNhrK/rMAPlHBouHj0rePAnaJLyNtcHs
	5CicLzrQSL1kdLnhVCuPSPlyvbYGJ4WrwPuFzHE2IdmLkd6PJsyMTcv8wOAdMWcZwmkRFviTaP6jC
	lIYEZRBAdWWYfUrjqJ+WT0QrJSQB97sj8ieuLRllDiyxDGklAEI6Qnp+YEyEY8k72wtR7bFPvQ0Dy
	q1sS0gkA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt1-0000Dw-QT; Wed, 19 Nov 2025 23:42:51 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsk-00Fos6-Hk; Wed, 19 Nov 2025 23:42:34 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 34/44] bpf: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:30 +0000
Message-Id: <20251119224140.8616-35-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/bpf/core.c | 4 ++--
 kernel/bpf/log.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..4f9808ea51fb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1081,7 +1081,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	bpf_fill_ill_insns(hdr, size);
 
 	hdr->size = size;
-	hole = min_t(unsigned int, size - (proglen + sizeof(*hdr)),
+	hole = min(size - (proglen + sizeof(*hdr)),
 		     PAGE_SIZE - sizeof(*hdr));
 	start = get_random_u32_below(hole) & ~(alignment - 1);
 
@@ -1142,7 +1142,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 	bpf_fill_ill_insns(*rw_header, size);
 	(*rw_header)->size = size;
 
-	hole = min_t(unsigned int, size - (proglen + sizeof(*ro_header)),
+	hole = min(size - (proglen + sizeof(*ro_header)),
 		     BPF_PROG_CHUNK_SIZE - sizeof(*ro_header));
 	start = get_random_u32_below(hole) & ~(alignment - 1);
 
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index f50533169cc3..01dc13aaa785 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -79,7 +79,7 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		/* check if we have at least something to put into user buf */
 		new_n = 0;
 		if (log->end_pos < log->len_total) {
-			new_n = min_t(u32, log->len_total - log->end_pos, n);
+			new_n = min(log->len_total - log->end_pos, n);
 			log->kbuf[new_n - 1] = '\0';
 		}
 
-- 
2.39.5


