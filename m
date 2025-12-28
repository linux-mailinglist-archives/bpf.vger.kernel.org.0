Return-Path: <bpf+bounces-77457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C53AFCE0373
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 01:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A7153011EE8
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 00:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADDD14AD0D;
	Sun, 28 Dec 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWqq5o+J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B50125B2
	for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881364; cv=none; b=JxfQo9X79gvCVUkre0aOavo7LegvfWOMPWLoejxwoqwPO+/kUGbhReVohTzecPgmouu/5Xr7aaCs1wBk+3FQHac2Vj9kLWp5wSBNrqVFxewMBquhve41mWxOOE4F68GJhGzj+s/rzZ7RnGQt7YEJjCkAJtKLt0yw5yKrho/rcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881364; c=relaxed/simple;
	bh=YhNn4w1ECKW/lyR2/aN/YzV+rzqMtr3UUzPAsYAzA1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmyv2hFUg/nmW+rulGaCmYMW+hYA52zajHtJEUwVACMwmQ+k7VAZDncm7M44pu4ju2KAzMnGz2kN5ke5XuEiZrnRR0qvg5GtdddNj7AERLxOui0O/0R6v2oyi2ZmqnRQvOvWLt09K7fbDeo8A8YJiwPPWuLHiIp/yueL70/IeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWqq5o+J; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a102494058so44778695ad.0
        for <bpf@vger.kernel.org>; Sat, 27 Dec 2025 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881362; x=1767486162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBRm9tUjprzPhPnPDp8sMp7may6BpHKIeb7XrKLfEso=;
        b=jWqq5o+JCeVn7ERc3PxZMnWBOGbVt9/zwKAKFwCRB15omr0mXtTNEztc5jpONKDys0
         rRG37cfu6qzW4cusjnA4FLVgKQ3NMisv9++l1lCt5/oIK9IFQqhh/wdN1YL871oiuXab
         eSHmfzej34Y+jwFO72/bwJ+6kly1A2r3xRuheOFvzKTHQyIMc8ohYh6CHvbAADMkqtHH
         de22D9Hj8ZFJ+S6ZLuIXawUnPe0xRdgBxLDYbpiDrMVz5u92fQ25ua5KBblHBJue/AM+
         9hx5G+DzFhPyqUCU9tcETA/P8lvqyIeg8cyhzGEJgLgGRV1FcPLJatKbItEeFWPfvjOe
         oc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881362; x=1767486162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBRm9tUjprzPhPnPDp8sMp7may6BpHKIeb7XrKLfEso=;
        b=Fv4Be3QZyijp0cS304B/M8hoUBXl3A3NSRg3vmVpoKpxi7Mt0TbXadUnDhmTl+Yng8
         5m7wtmWJYw25/deKiLIzpsEFqRvcKdCfyLUpNloNq3rBavZGp6e3tVV5uBpmDm1Qn5zH
         YHw6Qz3EjaFagkp7ekFYxUWBni6ENdT3bM1UoFR9N59GTdPQgFDj/H3bMT0YAiBBL/Rk
         hllYB+C4muUYODQAhZf+BFm1XAlw3RCevgmjg0nfTI4uTehZWNqnelPgHov6VEYhZuUw
         wRiM4h1au7Xga9LANWyao60NKxtVNEmM3IgvFBOGNvmr9Oz8Bk/Pe5IEHTnwj5cnYmaU
         RB3g==
X-Forwarded-Encrypted: i=1; AJvYcCV8T6vK9dPRpmLYVWqmQq/bN/3/5qaqbPBE5phv3+w5Z2BVPm8mifWzAjTBohZoE7Erj84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmww65Ap45sJN7y0GRvKtcOsDOjtrMk+h2SG0K++EN2c2Pajen
	OMfOQRPWNJU3Lwd+UiJkd3mN43Kqv6/gduF4k7m9t90yeFRUuDrup16g
X-Gm-Gg: AY/fxX6VdTQQa7MvGK4UKZ/mcXplvMjn4sMEeKWQD13AEooMcajdp7w3XSm8h2M4TT6
	dp3c7uuk9U1m4burkcbqfYJUIg56ocWEXr6hEhQ2eEUgBTPOgQUyTfb9F3Tsjq+m1PNCrTm1DQO
	MM1IBFrZ8G+FI77MDTS5aEX5K0baUcJnBnVeeWpFxH0S0DgpfO5xL/BhNlpDQSfI2FpF9oeSLsD
	GxJO8qvXLFvDPgbax9wgq7AdR3BO+OYiwQJbiDdvdUakTPivEbLkZrGUo02CMiIjm1exv2JrWVh
	C9EE1o8K9ZSwfqAtRKgPrRHvS6kgG6whhpgxeNB4ps2iD7GvETdSLQjm2bYXEk5fWOaNV8wPF7/
	N4K+toBMoCxn5QIH66gtLJIeXFtVBJf+5cXoi5nJeJ1xMh+1lpEo6os233vK3wT+r7KBw8ylxTT
	UIpqWoBfTtBTR9bQBR
X-Google-Smtp-Source: AGHT+IETJfXdkKE0rml3lHAR3nUgRFVPNZNBjCIoz0gYzb9VwwEPw3nJv5rIgJ073jgVuKmhTKDQ/A==
X-Received: by 2002:a17:902:d54a:b0:2a0:9934:a3f3 with SMTP id d9443c01a7336-2a2cab4fda7mr263935185ad.24.1766881361880;
        Sat, 27 Dec 2025 16:22:41 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:41 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v5 3/4] skmsg: save some space in struct sk_psock
Date: Sat, 27 Dec 2025 16:22:18 -0800
Message-Id: <20251228002219.1183459-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patch aims to save some space in struct sk_psock and prepares for
the next patch which will add more fields.

psock->eval can only have 4 possible values, make it 8-bit is
sufficient.

psock->redir_ingress is just a boolean, using 1 bit is enough.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 61e2c2e6840b..99ef5d501b8f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,8 +85,8 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
-	u32				eval;
-	bool				redir_ingress; /* undefined if sk_redir is null */
+	u8				eval;
+	u8 				redir_ingress : 1; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
-- 
2.34.1


