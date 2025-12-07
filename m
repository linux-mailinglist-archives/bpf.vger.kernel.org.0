Return-Path: <bpf+bounces-76226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E14CAB2F2
	for <lists+bpf@lfdr.de>; Sun, 07 Dec 2025 10:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2513039E84
	for <lists+bpf@lfdr.de>; Sun,  7 Dec 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A7B2E9ED6;
	Sun,  7 Dec 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utZoG72q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016F1B983F
	for <bpf@vger.kernel.org>; Sun,  7 Dec 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765098621; cv=none; b=thCHJFn3mT18cFVxd+7kyGPP2G4ap4uBfPME/c1UyvADQ2cSTPFYVnOlFogZ8ML6Yog2pD1X8lEvWolLgjbd7y8I+ZRCwxATHKjJYWhmqjO2o/aHwzIfPxRyRRz61qPzd9yFuzWx9I2EGH0m9M3WyLrc7aJ/iimIVYrLSBSOAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765098621; c=relaxed/simple;
	bh=3X51e/PLx9pRaXll0p33nxnXcI5pavWIxLJpda/hLMk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gxpNY9qpZGZgRQTQ+6Vsph0qTwAl9Vsrbc7NcgelWq+s/N2VZkd/Q1anBBGC5V4tKgprpt5bfD7nA3wON6ip7dJiCPN5l9lAcqb9Ae3xNw8smaiVnGu1cAipJgDoYPJwFafOHzSH0xMBfcTb/TdJUH+1Jt9JYT1BlKjCqE0NuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utZoG72q; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-341cd35b0f3so3957152a91.0
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 01:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765098620; x=1765703420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k0w54J/D7tk8ERI1t+RCpJMj6NhOxsVKjUyHkTyyj0A=;
        b=utZoG72q8jH4ayimSrlex+9Y7kFUVi9rlTenHLFD0EvU4S2yY0P2Tp/hoNcUgRDHCf
         evQp4pkkoOrKH+0Wcz+Ci8Zx+f0TGF3LzHoDIC+yS97saoyipnikbqQ8rO4F5CbF/TVD
         mb2Itn2/pz22dT+3UWKq5g1WxhEr8W0+ZhlT+nunnYTLOk+moKRSCffN9mvpJAf6sTID
         B0bA0PMDguG7fjHxZZ/KYhRcJrJQ8pNq+RJpqlWhlSrKSL/c/Ll24DD4Wnoo/N53HFwZ
         10ZLL+nkjTuaiD/QoxcjyFr7PXEXecmsAY8idwNJZY3Wz6fGnHUmi6tYBGmrx3d7ASwi
         ZHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765098620; x=1765703420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0w54J/D7tk8ERI1t+RCpJMj6NhOxsVKjUyHkTyyj0A=;
        b=fglAcNdKay/VNQ2xK2ES/Xae+1p5W+t84EaUjvzvLOr4ohcgEN/GCxdPpZeL0OU6s4
         MGtfxFwRs8o+HWgHsd10/Iw3663JeO77ys5bRH5PDJZ4vqau+b66AvFdB81Pu2drQRW4
         dY4bUy5iR0nb7XST/5sxQPKIaI3v7CbRyiGgdZ37v7StwrY4A5vSf3QNbbmOrMIZudfb
         74qYKSNpA0OKG+UOhUg1IoWji2zMTrK/XA/XkITmg5rhKXgApaAy3xlpzfY693uLXtN2
         DY6o1CkUEnBbZqF98/yfhf7vvYHh1xQjZqaoETxGCf3CAtwWm6neslPdsLh8iEPrW+33
         KPzw==
X-Forwarded-Encrypted: i=1; AJvYcCXnE+3yEly7Sx9ZMY2L1zvbK6tkyV8h3n2Sthikbk08mzFt1YC7gdXKF489GBBtBd5yJW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzyDwpYzHSccc7YFGwKL7FXUXTqZ3vJwDzxSahC5RzkuRFEck
	wdNKMIYic9Ejt90ZgdvBL6NazjwAwQJYpXf66S/SR58Jt4GnsKkHXP+EebfZZ7C87GYG4iuKS8y
	pypFqCez6YLm2bFKnTw==
X-Google-Smtp-Source: AGHT+IEA9c/vQqklr7rg0AQhku5hwNj/p7P2v07s4ffd9N63M+Jqq6JNBxDWStOAToMNXB1xkqPXr2qAsPbTtMM=
X-Received: from pjbbf17.prod.google.com ([2002:a17:90b:b11:b0:33b:dccb:b328])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:164d:b0:343:43bf:bcd7 with SMTP id 98e67ed59e1d1-349a1ca6494mr4105830a91.13.1765098619862;
 Sun, 07 Dec 2025 01:10:19 -0800 (PST)
Date: Sun,  7 Dec 2025 01:10:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251207091005.2829703-1-tjmercier@google.com>
Subject: [PATCH bpf-next] bpf: Fix bpf_seq_read docs for increased buffer size
From: "T.J. Mercier" <tjmercier@google.com>
To: menglong.dong@linux.dev, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit af65320948b8 ("bpf: Bump iter seq size to support BTF
representation of large data structures") increased the fixed buffer
size from PAGE_SIZE to PAGE_SIZE << 3, but the docs for the function
didn't get updated at the same time. Update them.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/bpf_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index eec60b57bd3d..4b58d56ecab1 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -86,7 +86,7 @@ static bool bpf_iter_support_resched(struct seq_file *seq)
 
 /* bpf_seq_read, a customized and simpler version for bpf iterator.
  * The following are differences from seq_read():
- *  . fixed buffer size (PAGE_SIZE)
+ *  . fixed buffer size (PAGE_SIZE << 3)
  *  . assuming NULL ->llseek()
  *  . stop() may call bpf program, handling potential overflow there
  */
-- 
2.52.0.223.gf5cc29aaa4-goog


