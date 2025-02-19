Return-Path: <bpf+bounces-51917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96EAA3B365
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 09:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA6716E359
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3A1C5F01;
	Wed, 19 Feb 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c62oO+Q/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C981C5D58;
	Wed, 19 Feb 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952833; cv=none; b=vDub+7AGl9t1xog9jbaOuPD8DSW4ZIwCOF4zg7hXL/DpieLn0xc9NAH0p1NQBDGzZYqokEPI09Zc/LBqWjX1CxAKJel9dgbZeNv/Lx0YRnw5qyBlUOa7kNU8ZFEr0PFEajR3hABfR6U+zGQumrBFXLuY7/omFtVfxIEXnsUVdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952833; c=relaxed/simple;
	bh=fWlLmS3POy16CVU84u60Xhbczhhj7lwkqtmeP/FRElw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIIsk+ZOvIbiV8d/MWAYJY/BHwzzZXfwo9cBmDgn9f9EFgTjuQKHbK2D2qqnOT8pDKG/OAFsAJctK5fXKMX6SttlZmiR+TSTXhVHNxEO9b1f2P6hYQK1hBARo5xYaiEh3gTDpV3wqLJDGz6okdZDEqrYs8P400XQMnE16tTC5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c62oO+Q/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221057b6ac4so67112195ad.2;
        Wed, 19 Feb 2025 00:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739952828; x=1740557628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z32zf1WbHd7c9g9e0xi0CDK3G/5o7TlQGTq3+JD+b9A=;
        b=c62oO+Q/otr6VOeQU3OVwA8/h+jTK2v+zzxUkDqb9SbaOcOWIDIMG0fxsaU2s+EJbq
         B027jPeKDxq+FUIdJrxTjI5+SAgCRQC3fqhJdKZmzBUtIqh1wBDDncnZO4AiPHhQsXlV
         PC5FB3LyDhHsH0El+edzSNkalCjmDScBKyHukF7E6indgZbxD9SWLUYaPGzaA3htzpIS
         DsEVqSHTMNVMLbhNNo6R4d50ejx+4aqQ+jzQnGTZjzRbZLC4foJAEYS57+RhrJWwl3DJ
         WbsVsef2kthrNCKaBApqYuobpOqdiLYIMVGjaFjbeuBv/3VG0ZoVY/1+tP8pHs5yIODP
         v66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739952828; x=1740557628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z32zf1WbHd7c9g9e0xi0CDK3G/5o7TlQGTq3+JD+b9A=;
        b=iL7qoGHH84HBxNteAQDabTHHHEcfvOU4GdBgfU3bZbs3B4Da3gKsjyiwCuAeFUAw4o
         qoKQtVqKOAwuNrm/cyqkz9uGh7DIl6XPBvG7QOKcJSeg8mPdPf0zqSMtrnnM9v0F+tYz
         P9G/5zeNYeYJbSane9r4rXlYFP/txVe7AMjMpoYDSxE9EIdHoqEjEUl9pz07gdi7dJvi
         /Utt9ECc7cPIQ1DvxHjeKdXOMM9G2QyVT2+8I+Ame5qJnVuDCRq9q93Ka3esdIITKGoW
         Hd9LQPJTt6InqMOOmCNRLTGzSi3SGa/tn6VrbbqcErYzLy9D+wOhNChluKwH/MgTyvk9
         Ui0w==
X-Forwarded-Encrypted: i=1; AJvYcCXrvpeEFwPsHJTAWWgm/PPFT5onoI6dQulok3M5wfbLl1lWyJrQnCyg3RF9wvWmReZByGAS53M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4mqzGiqQataam2LY0WPkKBAarxYHPxKZWhucfkOcybKUwSyD
	ye17NKs5R1L7iXRIP3jaPSsI1gCOt3dSj0WN6GT1Vwa4tquqCDI2
X-Gm-Gg: ASbGnctOr965wYG7zEXwfIu+skq/zGY1+8KLOOa4/xje/xzxRvKPDIt+KQ412HkJiJq
	c+eq5YV30R2euXzsSr5GYvT4tPtjtJ42fCGHiaYLmLryDrn/ceOhWSQ2DKRXH4c37p0bgLH8yOz
	/+JVb5L9kXCSGfjeaQSwb9np7KC07QNemSQF9P8673FaV4TPYTIsfji+11a1WTcRle65jpJmFyQ
	6N9mdhBRR2IvsWygFZ7YX+3+YMsrnHVKRRy3SvZu9vZLoK8wUtIuT1rDFDRvil65Ud0xFGGCrQX
	hRhYqhPsbggGmOroBQWECKGIPZVsPr7adeuNEwaY55N9nA4dduLGKu9VJ+nvHSE=
X-Google-Smtp-Source: AGHT+IEY2GP2HtDxIDPMJSxFU8gnxqyUzvjLGAxVpq54gu5qQqTU7Y2HKb3u8CqyT02n+W7Xx65V8Q==
X-Received: by 2002:a05:6a00:1796:b0:725:df1a:288 with SMTP id d2e1a72fcca58-73261922bbbmr29714610b3a.24.1739952827970;
        Wed, 19 Feb 2025 00:13:47 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732642d908esm7774746b3a.159.2025.02.19.00.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:13:47 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
Date: Wed, 19 Feb 2025 16:13:31 +0800
Message-Id: <20250219081333.56378-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250219081333.56378-1-kerneljasonxing@gmail.com>
References: <20250219081333.56378-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some applications don't want to wait for too long because the
time of retransmission increases exponentially and can reach more
than 10 seconds, for example. Eric implements the core logic
on supporting rto max feature in the stack previously. Based on that,
we can support it for BPF use.

This patch reuses the same logic of TCP_RTO_MAX_MS in do_tcp_setsockopt()
and do_tcp_getsockopt(). BPF program can call bpf_{set/get}sockopt()
to set/get the maximum value of RTO.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..ffec7b4357f9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 	case TCP_USER_TIMEOUT:
 	case TCP_NOTSENT_LOWAT:
 	case TCP_SAVE_SYN:
+	case TCP_RTO_MAX_MS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
-- 
2.43.5


