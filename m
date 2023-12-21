Return-Path: <bpf+bounces-18570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A432181C1E7
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71411C24F31
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1DA7AE68;
	Thu, 21 Dec 2023 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+vjpzfC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEA7995A;
	Thu, 21 Dec 2023 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4006b2566so9711025ad.0;
        Thu, 21 Dec 2023 15:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703201013; x=1703805813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIDhSXU72ufOCSNS4Jhi/nn4DUZAV20AxMwH9mUdxFQ=;
        b=i+vjpzfCl16g3jwFc8TMnPNiW9dXDFT0DbzmwAO3agR+s4e8RdNfb4P/I1Oy+ZBe8a
         NoSlHNOGfBN/MAFZJrsfdJHz5QHJvl86CvtqkFdN9J5lDHiKFa9Y7QkqkpA+9i87SCHB
         D/fOGSqKZaPN9UCyS5adIxP6pAy1AbMPQ2tPH2cKRv4hrvTIE+Fc7ZlaEUsNQ6Kid3gp
         kXLRBIvWxK72fjQ14hZpGKO8SjA98JcoR58fk/xlGDoIByf8ToQbjgJOEOr4BVNgYnqU
         7pQDMhOYnRtRyoFwRKRTZ6u9aWkrW+34kIADfG0kbsAAk6as88HnWvqGc8AV6xZNrz7A
         Qt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201013; x=1703805813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIDhSXU72ufOCSNS4Jhi/nn4DUZAV20AxMwH9mUdxFQ=;
        b=JSALOg0QCSbnRGR2bjBYZJ5E133UF/XLOwIiz+BvYmk6lO34UPBFcE96BOJv2DkJT1
         2dzlX+KreHUo6Q4FmerfsG0Lto+IULj/Aojd9DZyagpHJZGqxlX+af2DfblDBbLvCGj7
         HkVTi46q1BE2E3kd/zm0YfCLlnldoMm0vtOANxHvpSGNKh+/e4diSBp2BmqFZIVNP8Aq
         LGyIGar59oGpvdqzURLR5mkq2BQUhXybBVfk30VcKiYx/2xHflUtX3YUMtCA1R1UgrHp
         RHyEXNPpw84NVO5P0zFErkeklHK9djQ/hSGIFYVCW7T59M4fdcByj/68kTbbUol4MeKH
         azKQ==
X-Gm-Message-State: AOJu0YwB1b9qP05cDOXaPsirGuMU0XmeKECLe/VRzsujA/TABnc+MMY4
	YNatB0RCF/izykzpXYfUq4o=
X-Google-Smtp-Source: AGHT+IHSpwqwpGl18k2ksrteewYySCIroa1U7wGmZ0lM/9C31F0QYYjG3RQvGJPmuDuKuyLrL4H4wg==
X-Received: by 2002:a17:902:da8b:b0:1d3:f43a:a2d4 with SMTP id j11-20020a170902da8b00b001d3f43aa2d4mr423431plx.114.1703201013469;
        Thu, 21 Dec 2023 15:23:33 -0800 (PST)
Received: from john.rmac-pubwifi.localzone (fw.royalmoore.com. [72.21.11.210])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d3e33a73d5sm2139641plq.279.2023.12.21.15.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:23:32 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	rivendell7@gmail.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 2/5] bpf: sockmap, added comments describing update proto rules
Date: Thu, 21 Dec 2023 15:23:24 -0800
Message-Id: <20231221232327.43678-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231221232327.43678-1-john.fastabend@gmail.com>
References: <20231221232327.43678-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a comment describing that the psock update proto callbback can be
called multiple times and this must be safe.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/skmsg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c953b8c0d2f4..888a4b217829 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -100,6 +100,11 @@ struct sk_psock {
 	void (*saved_close)(struct sock *sk, long timeout);
 	void (*saved_write_space)(struct sock *sk);
 	void (*saved_data_ready)(struct sock *sk);
+	/* psock_update_sk_prot may be called with restore=false many times
+	 * so the handler must be safe for this case. It will be called
+	 * exactly once with restore=true when the psock is being destroyed
+	 * and psock refcnt is zero, but before an RCU grace period.
+	 */
 	int  (*psock_update_sk_prot)(struct sock *sk, struct sk_psock *psock,
 				     bool restore);
 	struct proto			*sk_proto;
-- 
2.33.0


