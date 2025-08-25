Return-Path: <bpf+bounces-66396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A3B3429B
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5635E1D40
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717B2FABFF;
	Mon, 25 Aug 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoLBa7Ys"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AD2FABEE;
	Mon, 25 Aug 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130087; cv=none; b=Mof20q8OxEJqAzBFqgOI8q1MU4MIiq6+mSja90olghfDvWg/WLqErVTDf75pNCVVLQjdxC++jeDk7EzEVjs931v1nRNI8KU44FdqbR+l3/I3YsxLaPU5EdmES2lTyTZfhzZRtReZiJ3vSdt7jw2ut59xARX5WLBdo+tu+w0APkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130087; c=relaxed/simple;
	bh=PiggFtItD+AHE/oXklUg4qYjFt1XGBkp0GF6f6wP840=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5A0MusCXWQRuKU3yo2Oo3xPYAtB4Qw4NzEpW4WbA4AVAZemLJ5R+km6X86jOHuKnN7qfg6KjwZaFE4YM1xqpeFkgYLTPPmSEt5G6XuMjplBiFoPnKGIr6sb7i58V7z7N4Tp3JMBqut0mNK8MMJh2CceNyX/rJkXL5iVvjwQG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoLBa7Ys; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e7af160f1so3017973b3a.1;
        Mon, 25 Aug 2025 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130084; x=1756734884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9TfjALSE7HAArW2x8R1CzL9Ijda2Nc9ypEDVvquFIw=;
        b=JoLBa7YsEv3evlAXYt+0xbIfqTmbKBk+8O3pGYf0qiRTZsuAKqBXnIaCC4+lFiK56R
         hY1tEF0sVK1Dcy5iwuqe50zES7MbvGQPebZIkg+wR0ZgRKnuJr6Y0kMyMWHp6xHTHeoD
         Cf5eLGvklTy/mldQ08r+EFT7umlzCOdFvQngawGrE3Rp1G8/libJRSeWLARWlfv5vwvY
         VMUWa6Wm8XGZEuSbhhk8X6Cs/dR3FhLcuX92QmCJ6UmzGZikrA9LXMXIox2gvveGdg3/
         ziRs+Qa2wu0Kfe2NR16iDMZV1lI1774uRDhUU6hJLXLm29s2h+j6fLbPFDlIA6yheV76
         d2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130084; x=1756734884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9TfjALSE7HAArW2x8R1CzL9Ijda2Nc9ypEDVvquFIw=;
        b=kpE5TwJ1AWsMJFY12MHyssVGwkjABS9b9P6l6GXSh4bjnXca69hvyNefpahYGXk4U7
         CPh5ghKmhOoikt5i772to6PDow4PfuhYl6sNIVi9XjRkstfVwRN3w785sS0kdvr1Xqn8
         mn2r7wTKqG2jvvZG713nPS1klSuZnR9WvHcbBpA93ibij/ktjqL62vKc6g0n6dHNaxYt
         s7HTU/APc5CChoALkusFFUMO2n3YXOk0BaF7ShqwVI5pKQ3krFah1s//Hrlsow5od7q5
         gh3DgOuM1U/8aqWhpCDNCbGl0p2qEXFdYDYbVWuIYYF7C5edwtmsnzJPlpkJCF9d2I+U
         VYmg==
X-Forwarded-Encrypted: i=1; AJvYcCX5NQDRINovIMQo+sd+S1iWMAnt7ykY7B9otjz9kdNgjN9s7nPw00/t7KMxNdmk9rEOXtULc6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHC6kIGc2N2Y7QKqkVuhkZyFr0U8KJkRg9v9+vJKCY0pridOQK
	EbBwIENKUWxxrZvs7br9ZKkSZxw4kiYeIE9J4HhVMboB7vV7jVjmClE8
X-Gm-Gg: ASbGncsmMU7a7WIKl2xfhAw4BIX6SEKJ335dupl0YaFfr2APcOx6N+dtRPkOrMb2JMW
	vXFzWncfPbYAniywlad5obT8BZXMZcoOB4iId1YMzUpBJlkTzLFWNaHI/rX9LeBqDDG9JCGhZ4K
	M1QC1Fx7l+3cvCuq5RZPXqWc71Pu+uD1fHSdtbsz+/RyQa1zf63kPhrosjOOe32tr0R1AQZXKGw
	syab7O/R+Bw5qOvKsP27mthgrEagvhPdBWhY+O9+O47iPw/dN98CJY3wyJJPvZxdglicXOWTgXE
	Su8iCBHfetP8yht/5J5w5HFiKg+k7PdqzJhiWQnNR4epxl81BGFLUFk/1GZAaieOWDBg9Yw+af6
	ddpL4bVvjF8INAHcTvRKl2iSjzogHEAjWZpUUetxmPouIRuKlwHfnd0hhaOee0hcgG1DHiw==
X-Google-Smtp-Source: AGHT+IHU3C5SyreFrJdHsqpex1uiFD/ljo+QN3fi76O4FspG/Ummanlzpi0NtQu6+dn1h9wCnSjSqA==
X-Received: by 2002:a05:6a20:a110:b0:240:763:797e with SMTP id adf61e73a8af0-24340b8a6a0mr18076405637.25.1756130084034;
        Mon, 25 Aug 2025 06:54:44 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 8/9] xsk: support generic batch xmit in copy mode
Date: Mon, 25 Aug 2025 21:53:41 +0800
Message-Id: <20250825135342.53110-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Move xs->mutex into xsk_generic_xmit to prevent race condition when
  application manipulates generic_xmit_batch simultaneously.
- Enable batch xmit eventually.

Make the whole feature work eventually.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 90089a6e78b2..34fd54ad4768 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -803,8 +803,6 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	u32 max_batch, expected;
 	int err = 0;
 
-	mutex_lock(&xs->mutex);
-
 	/* Since we dropped the RCU read lock, the socket state might have changed. */
 	if (unlikely(!xsk_is_bound(xs))) {
 		err = -ENXIO;
@@ -902,21 +900,17 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	if (sent_frame)
 		__xsk_tx_release(xs);
 
-	mutex_unlock(&xs->mutex);
 	return err;
 }
 
-static int __xsk_generic_xmit(struct sock *sk)
+static int __xsk_generic_xmit(struct xdp_sock *xs)
 {
-	struct xdp_sock *xs = xdp_sk(sk);
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
 	u32 max_batch;
 	int err = 0;
 
-	mutex_lock(&xs->mutex);
-
 	/* Since we dropped the RCU read lock, the socket state might have changed. */
 	if (unlikely(!xsk_is_bound(xs))) {
 		err = -ENXIO;
@@ -991,17 +985,22 @@ static int __xsk_generic_xmit(struct sock *sk)
 	if (sent_frame)
 		__xsk_tx_release(xs);
 
-	mutex_unlock(&xs->mutex);
 	return err;
 }
 
 static int xsk_generic_xmit(struct sock *sk)
 {
+	struct xdp_sock *xs = xdp_sk(sk);
 	int ret;
 
 	/* Drop the RCU lock since the SKB path might sleep. */
 	rcu_read_unlock();
-	ret = __xsk_generic_xmit(sk);
+	mutex_lock(&xs->mutex);
+	if (xs->generic_xmit_batch)
+		ret = __xsk_generic_xmit_batch(xs);
+	else
+		ret = __xsk_generic_xmit(xs);
+	mutex_unlock(&xs->mutex);
 	/* Reaquire RCU lock before going into common code. */
 	rcu_read_lock();
 
-- 
2.41.3


