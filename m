Return-Path: <bpf+bounces-56769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD1A9D940
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA78D465021
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377892512E6;
	Sat, 26 Apr 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sny8U/Xy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255A1922D4;
	Sat, 26 Apr 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745655230; cv=none; b=Slc1ap7016Z9kgliDJT9xyD+igJnyT8d++dWzVG31vIg+CkQOwTQtPsP5D4shcdlr7ndHYhkdpbbbRD5zpdDOxSY0PK+k9IBu3JfnFVd3U1tnWjSgwpNaujhvkyVnF1gIVaZ8tIp8GZNI82ARbCDgQInohg5mNLdpY9YkAKYRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745655230; c=relaxed/simple;
	bh=ZeOC/0bQwfUlXkNbSV+sIEvhEwR9r8ilFBcxOuW5p6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is6ZAECtLilj6kGHkChTH13PW0yBI9JKgmfqinJxgWB3H2kK7/pKSON+TDRvp7tbgt7Nuc9RTQwRveC5PgOUV9PtdCl9Uex7i1+9T+PxRcCfvJl571cEZvMRRdR2oOvjOyPG/HoO7XivnSdJ4yVCW4Y15YVJzH6Gi58MwzbJx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sny8U/Xy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b98acaadso3059065b3a.1;
        Sat, 26 Apr 2025 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745655227; x=1746260027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQXT5ONSAgbfp0TWcRRQZWRBJSmPHnOLUU8DG8CZBfg=;
        b=Sny8U/XymFHbRB+k3RnIRc/7oV+OgZjWUXQUZnz0rDKpZPjtGcfk7P/Pp2yY7+hK6X
         kyNCOh5jJrDdA4BvZkMI4ZnXqfjCJkFwr5bka7caLvvaWWZKp42lacC0CbPNu4ue8nOt
         cH0riVHr5deRzujgbVABZJB8Iw3OZI3ZNA1gsn681Zjq7nT1a6Nyu0pVSocsj/yfhDGA
         VoJSUjqAO/bI6S6fe2Hfs+4JjGkCvrK3+SIoSJ+cFp58se8xbf2Q6itDcpBhtSzBXzRb
         sFDpiDZUILpb0Oh7OQp6Pv2EnJAFs3xeWUn6uvBR4wdOA5LCeNW+ICn3y/8lzKMOjSQ8
         m9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745655227; x=1746260027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQXT5ONSAgbfp0TWcRRQZWRBJSmPHnOLUU8DG8CZBfg=;
        b=k5J8tEefGHsfarVhh/t2c48/Owf3/osqRbC1DC+TgwkRe75K4Uoma3O44JfMz2J/EW
         W15mygzVC8OpWztm8LiuRggUwNt0UqWByIgQeSFcxnVpaaXoGvlWnbE5U4TwoyqyUqbY
         Fb37DYCSw94V2/lqC61ZtDD+Eg8aTDz3oDuoaslVk5cSQEpxxYOQgPJY56EAH9+liTLi
         hphteS51QaBryt9XXNebyuHp5gOVKzpE1CaFtrDrR6xQC6VBxr0vHfsV0uIRxuoI46nQ
         Lv6E7P55ZwKv6xBzRND2nJo2KJ6BkQMSB9N0MtXg8vEy+rYRdV8yb+/pGFHQTNxc2CXA
         6FeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcjReCOMGVFsu8IY7E/mVAxXaj3oAOTfD5JbbhhMWW4tOJKDkmtOzknKGqyndJyNxXZRxAJg1oDeNg3jId@vger.kernel.org, AJvYcCXyrioIQQkzgg2OHd+tISoq46oLPMU8ENLdpFFxRt/XuH04StzaoRDEvTrMXr342yLdm+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBaw5kVE2pqDrLdx3cUoC/iWpwn0+ebA3H0KViAIUicX9vJY+
	fBecOddglSjM/uWfYBMo8VeSvOOpB9JfEVU8u2sFb/s/5slGgNg4wuhE9fQQ
X-Gm-Gg: ASbGncsoOUpNWMFFN+dH1/F/puaHzmoB7M8drrM/fKQ+peVVN27/U8Iyfmy4rrDRCv4
	kVNLXPqbywTgiG+nEmSGiRx9ohmLJt7NkYadk+Zd2cS0kFCsJtAHlbtZIo3z6e46Cbs71sxsqDe
	aXpQbNvjr6ZxQ2cDH9eo8RHqaXyLWGtKpcpWBlWfSw0ID3m/Hu2SPbN6EaqvonNUJTF6b5+QIyt
	JSuUicXRULkV48seoOfvV1/QCieejFxDeFp9SZjpmPTNoN/7owRLTjUG0AwJIyjFijUqNynWnz8
	jMIXl4yIQjOuSlKFTuiVZSqbFUPUY9qYWAXmcOYiAIcvKr8oTJQDyKAx
X-Google-Smtp-Source: AGHT+IHKhaO9DT5JfKbjsMYuC7mapSx6vcuJwzV/0QqWB5mqu381bMPLef/vCjbQRlxoXzzQ0i8zIw==
X-Received: by 2002:a05:6a21:10f:b0:1f5:6c94:2cd7 with SMTP id adf61e73a8af0-2045b9fdbd6mr7097430637.42.1745655227562;
        Sat, 26 Apr 2025 01:13:47 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52b1:1f45:145e:af27])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bf7sm4503700b3a.68.2025.04.26.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 01:13:47 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net-next v2 1/2] xsk: respect the offsets when copying frags
Date: Sat, 26 Apr 2025 15:12:19 +0700
Message-ID: <20250426081220.40689-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426081220.40689-1-minhquangbui99@gmail.com>
References: <20250426081220.40689-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb
conversion"), we introduce a helper to convert zerocopy xdp_buff to skb.
However, in the frag copy, we mistakenly ignore the frag's offset. This
commit adds the missing offset when copying frags in
xdp_copy_frags_from_zc(). This function is not used anywhere so no
backport is needed.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 net/core/xdp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index ea819764ae39..89111c68e545 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -698,7 +698,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 	nr_frags = xinfo->nr_frags;
 
 	for (u32 i = 0; i < nr_frags; i++) {
-		u32 len = skb_frag_size(&xinfo->frags[i]);
+		const skb_frag_t *frag = &xinfo->frags[i];
+		u32 len = skb_frag_size(frag);
 		u32 offset, truesize = len;
 		netmem_ref netmem;
 
@@ -708,8 +709,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 			return false;
 		}
 
-		memcpy(__netmem_address(netmem),
-		       __netmem_address(xinfo->frags[i].netmem),
+		memcpy(__netmem_address(netmem) + offset,
+		       __netmem_address(frag->netmem) + skb_frag_off(frag),
 		       LARGEST_ALIGN(len));
 		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);
 
-- 
2.43.0


