Return-Path: <bpf+bounces-61063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F390AE01D2
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B93177F3C
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386C21D3FD;
	Thu, 19 Jun 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGck4IyE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E361D9A54;
	Thu, 19 Jun 2025 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325907; cv=none; b=F+QUl+yw40t5o8inn7CRB4MvZ7/kJUXCEPKs71uZI3/X2d8EZ4FtlHrBpniaVCzx1irV6719dmwtfwSgHWavO9DuMHq/ADYZSdCxHk1AQGCkohnjKYJvBPa/lZHocrFyNpnl4Mh0EGLskdBCW8bCoh9NpPTkHvwFJgoNKv35u7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325907; c=relaxed/simple;
	bh=KLKRYvVaEBlMMIwnNFT9MCa4uPrERj6jrU+CDNwkM8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pOTmz+gjg5jnojSixPZgejK/HtRPm4dkGfoSqcABWMW5jlvEq7hb1RjRb3qiQ06M1oo1gHSmHvZDBKJ/NL+gE6z2AUz+oYHEiCrPKKIK+pVqbgh2zuMwfwEPgxHPFAJ9wqe8ZLozxir8e4JfaKJiZ3k4nliWo3GrDrlgoTCRzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGck4IyE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso434655b3a.0;
        Thu, 19 Jun 2025 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750325905; x=1750930705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PinCl0B0GdBzlEv7WwLDggwxT66ZmaTkkrZuqcrKs+Y=;
        b=WGck4IyEf+5U51t5ZfXmAw/Ul4Br3iOeyjPkrPduzIMDTYDF6v+e5GYv9HnZjUPkdl
         gowlwjipKtZCKgNLtZeeBdZ3LVuswhs3e1qNpttnZhn6M7z6UIRXPeQG1DZ9DgGarFY2
         gcSJKeZhpjP0vo8YinQGJUbaXymUxIUFHvS0Lb0ec1ep1/DWkJdbnwpxttYPVtQyc31d
         rA+Q+rbGwvRsze/2mYBzUurkI10w/E2nrpigFZntZd/wExn446J4PnnLBQ4OU1h6axHP
         DJZvM6mU43nQ/XGwtx9sL4nQw4ISJQGbFtYbYqXis1bZdPzr7HC8+zCjZcga26qDtpXZ
         gETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750325905; x=1750930705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PinCl0B0GdBzlEv7WwLDggwxT66ZmaTkkrZuqcrKs+Y=;
        b=InWXC59pWyj6Unp5BvErMfB2lCi0LaFk31NGvkarYsH0u6aavVfmfDCYjc8TCG3Y7V
         6JKOv92W+05l1Q6MWlDiWrkUwaJKavJQ5XcgxxeG25BeeQaQj5MG7YDcTQ3N28yKvWGp
         ji208EmcqPTVKw+H1GoZTxaWFmrTHtAvs7Y87Qs1zyRJysMYS/t5ExMGtrQOAFiQaGmR
         40WEjGO9CuKFsVLvveSJtj+q2+ZjV7pWA4CZG6BYCnBoiMthVPExYG8DKK8qA7RdcKki
         qFYL6Yur6gYUYk6DY5pEcePBRRRvU9H2nFG/wpgBrqcbumU6G0DdHG3EItrr/5MIGmGF
         5Ckg==
X-Forwarded-Encrypted: i=1; AJvYcCX9wwumZoycx779uS+s8iY35YHie45eQhtS9BkUzWnexDQuKQBafw1q/LXlzTjpUDkugism3dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlP7t084iOh5o1aOVRhLUZyjOhlmM3k0V81mJiRB85BlGTfz7a
	ZF9qIavaY0NzFig0o6VipdNV0sqXiCgXVKm0udHatZejWWBj001HrYZE
X-Gm-Gg: ASbGncsl/ygpK/1tgym0VJyXK2fo07AWjPinlXcnP2kJTSNTPAWgXsseG+wlNopKlv5
	9bjzlv5/Vc89smgOg0hJLuCGYCSqSN8iEdI1zGds8vU+Nv5SAFsEgx9TE9xTFkciSRvEftXae/n
	BmUTEGghZvs82FuT0oHxwLECx8y5DoXTjWB/r2ZRXIi4eCirC6P+ta8XyLs8TsCFAJM/FIdUBqD
	4WY1upk6Gu4Mm93w2Wb1CLdgd53SiRUCVQFRRbfWYW/kjoSp/u5nQ0WqtZHKB9vSPQGSW8i7rz2
	gT/Rop83GS/Uyqc882ifv9lD3NvHjaf8yHfASzuhGYvzHdTI8+3PxwiU27eO0E/wyx5q09l84zC
	trELcGtwFiPVIOKTMhSnHQHH3nAoTzNJ7Hg==
X-Google-Smtp-Source: AGHT+IHG6jT+kJ7Yzc1ajmMNbCHMwqzlSFbQg8gVUuYFTMiCxTB6FO9Ehvq8rUigAQcoiyB5oDVO+Q==
X-Received: by 2002:a05:6a20:e609:b0:216:1ea0:a526 with SMTP id adf61e73a8af0-21fbd5ddde0mr35713387637.40.1750325905045;
        Thu, 19 Jun 2025 02:38:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489000749csm13241453b3a.68.2025.06.19.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 02:38:24 -0700 (PDT)
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
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] net: xsk: update tx queue consumer immdiately after transmission
Date: Thu, 19 Jun 2025 17:36:41 +0800
Message-Id: <20250619093641.70700-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For afxdp, the return value of sendto() syscall doesn't reflect how many
descs handled in the kernel. One of use cases is that when user-space
application tries to know the number of transmitted skbs and then decides
if it continues to send, say, is it stopped due to max tx budget?

The following formular can be used after sending to learn how many
skbs/descs the kernel takes care of:

  tx_queue.consumers_before - tx_queue.consumers_after

Prior to the current patch, the consumer of tx queue is not immdiately
updated at the end of each sendto syscall, which leads the consumer
value out-of-dated from the perspective of user space. So this patch
requires store operation to pass the cached value to the shared value
to handle the problem.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7c47f665e9d1..3288ab2d67b4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -856,6 +856,8 @@ static int __xsk_generic_xmit(struct sock *sk)
 	}
 
 out:
+	__xskq_cons_release(xs->tx);
+
 	if (sent_frame)
 		if (xsk_tx_writeable(xs))
 			sk->sk_write_space(sk);
-- 
2.43.5


