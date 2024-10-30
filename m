Return-Path: <bpf+bounces-43569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1CA9B6901
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E41C217CB
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3612141D3;
	Wed, 30 Oct 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bZE9v8gw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595E21314C
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305173; cv=none; b=UAUnhlopfJDYXMJ9OaEkyLMfZusHmsyjd3fwUs2gsUJSuPmCipOfO7Qk9Y+ZOI9v4RnPaMiWHuRteF/QrK5mEsgYA9jZs+UHwRJGIqiN7kFaJk0Z64kESjy/z375okPFg55i0uWcphNB/TyZAlVFMUO8ceG/qHWyCsensLdy8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305173; c=relaxed/simple;
	bh=eeQZWdi31ahE16uIhTwy9l+2wpL9Ct00lJPunzv+fjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=befQ4V2se5KxzlUY1QA5HxRvCSVoajv+4IDnG4urhGdsXxSQjGFSJRohQdT/53f3oDxVCxAlmes6gBYuD2gSmaQw0BPPhpalMJHRYrV8XN/aJDtMpYB0iBqWXEXmtDO3N3/0IrhlT44gBItMx3WRGIRJusPPqf6z+FyRbZyXGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bZE9v8gw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so474816d6.0
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730305169; x=1730909969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUVvfxTPIHmETEp/43MSCYgTLgrViAGrq3ZJ9SvLec8=;
        b=bZE9v8gwmOZnWBV415woOmxLXNLiZFj38vQCJ9LXo8WRCrIxIDxls/9oYpOvEdg5Fy
         EAdre9DxvzJUEAHZxVWOMhalAhyRomgNFfaaZbU0wYUEzeR4YqXbv4k1mxi0lPgiiLLQ
         fmL+IZI6y9OBTVm8QK1PHcBHdGXqoHE3UiAkUYX1rHegFkXuRQWfDyoc9GABDAC87ZAJ
         Q53dnvmThh+rFmGmbwtpWNOKeAs4yYdIx3WwutX00/eBYQMH5D6wn0aBiNLJcQCwQpyQ
         Jc487i48fCUo0w+05IVvjIcve7pCHX0QaPLnuieN+ZBPIWKl98l5PpRl7eiI6MUxJG5m
         Ci2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305169; x=1730909969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUVvfxTPIHmETEp/43MSCYgTLgrViAGrq3ZJ9SvLec8=;
        b=ev0aVYQ9BRA0qYwwJqVsn3U9VUNEhUj25H/HRLRSG5BAZt+J50Rot+exluH6MKkSpD
         xPNW2eZRm74+VKbW5C3UtMsoxQixG179AilmffhCm+zvJmnzbd3j6OTcYTEpLP4A1gPz
         mmzd1Faj83VInD+ljYLI7CADRcsbAG+wGjFWNMhE8wKblBJPE9V95IL2c503erJFw0cA
         rg2+ayL2D8DyXkjQVXADVE3FrjiEDMFsiG0BJr7cBTi5q6lXZLL47/byBaFADMUo2dH3
         PzKn+224iG3Ct/8TA2/AHhrKUqaCceuEJpwvO/L/oEcv1PiQ8gFHlZdSlJ/Or0YEfeZf
         ioBw==
X-Gm-Message-State: AOJu0YwUMbYXkyoafoipLr5QHCGSaODJrw/m/gu77jC/a4zhbe0rDfzI
	65qhmwYlYbkbOWV3KoH1ahiJiebEs3VTgPMsEq0jA++XBQeD49Oju5UJNU9jakCjKTIQNiygZKf
	T
X-Google-Smtp-Source: AGHT+IHRiB9YQNSNYKWdNZR79/DaQ0zIteEeGQYZxCPVwEzxZvnrEBUp07kKFDi7lrrkUH3sNaEv3w==
X-Received: by 2002:a05:6214:21cf:b0:6cb:ee9c:7045 with SMTP id 6a1803df08f44-6d34846ce3bmr52890686d6.2.1730305168917;
        Wed, 30 Oct 2024 09:19:28 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1799fd530sm53311396d6.85.2024.10.30.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:19:28 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	stfomichev@gmail.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf] bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx
Date: Wed, 30 Oct 2024 16:18:55 +0000
Message-Id: <20241030161855.149784-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

As the introduction of the support for vsock and unix sockets in sockmap,
tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
vsock and af_unix sockets have vsock_sock and unix_sock instead of
inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
pointer and cause page fault in function tls_sw_ctx_rx.

BUG: unable to handle page fault for address: 0000000000040030
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
Call Trace:
 ? __die+0x81/0xc3
 ? no_context+0x194/0x350
 ? do_page_fault+0x30/0x110
 ? async_page_fault+0x3e/0x50
 ? sk_psock_strp_data_ready+0x23/0x60
 virtio_transport_recv_pkt+0x750/0x800
 ? update_load_avg+0x7e/0x620
 vsock_loopback_work+0xd0/0x100
 process_one_work+0x1a7/0x360
 worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 kthread+0x112/0x130
 ? __kthread_cancel_work+0x40/0x40
 ret_from_fork+0x1f/0x40

v2:
  - Add IS_ICSK check

Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/net/tls.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 3a33924db2bc..61fef2880114 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
 
 static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
 {
-	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_context *ctx;
+
+	if (!sk_is_inet(sk) || !inet_test_bit(IS_ICSK, sk))
+		return false;
 
+	ctx = tls_get_ctx(sk);
 	if (!ctx)
 		return false;
 	return !!tls_sw_ctx_tx(ctx);
@@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
 
 static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
 {
-	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_context *ctx;
+
+	if (!sk_is_inet(sk) || !inet_test_bit(IS_ICSK, sk))
+		return false;
 
+	ctx = tls_get_ctx(sk);
 	if (!ctx)
 		return false;
 	return !!tls_sw_ctx_rx(ctx);
-- 
2.20.1


