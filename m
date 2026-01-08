Return-Path: <bpf+bounces-78187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C8D00B38
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4AF2305D91B
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB682C08A1;
	Thu,  8 Jan 2026 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+gxs4JB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE22773FC
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839215; cv=none; b=SrY3jg4iClj1vQTTjaBJUb2rUsr+TUl/ojZIDlE++ir4gj9TU/1o2ss2/+dMDT62NEeIgeTg1oeLbN62BM9hPjkF3CZ9ZvBlh5i5AGfaHetT+qfPGiUxGCiaxG+GbVBvXuI0fQeDdghttsvqiOBpa+wjCpM2ffIIsVTjaxB8vw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839215; c=relaxed/simple;
	bh=agW6uKNys5gOeoTrVORTjBOaAxozAsYVc4VUeEIRBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU/8RswQSHk2ovF/OjuvVQgTnBzsT5wbeCHB2I7CUp+eZOh3qvdIt00yx29ixYeCoKHVXqisDAFqPfwiDxB9psnbmrpd19N2A+CwYm71ARvyDn3I/4hGn2e7szwZZ6CRKyrZNg5J2nuRItSckQu55rfZ9Ak5vfa+b/SbPzBbuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+gxs4JB; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64661975669so2896713d50.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839213; x=1768444013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=D+gxs4JBvmPohLOa6xu+ek9dPGh0LUhzNzFdNUgnNa0a7WUf/hKIlxq7lWziQIzJTG
         +36N2C6K6TWODC4YakBQfQvN4Jqmza1UmsB5rn8O4iLBpmQPvkBQM7iZWSckkpRbGGTp
         D6k7R3vRny/Fw0wj1QqjEmxLKqytBwUb+KP4APYecMNDSaYIFoccw4pZqln8sWTucRgs
         UcpKIsOrTWVHhAMRvOYpxZ4FZa0fwAxBTIZVDnvq/KFci/5HenC0d81+1YytnBNUZPkC
         bMOtcBWV1E/R8Vv0SY70JVZgsQI7iB3Xqt9KVvmy+aeEBxjDGRelbPXrIq/HJLetJ86W
         T2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839213; x=1768444013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=f8hyV6Pn5wW87WGQIaCj3+hSsRBJd8HTJ+IpL3KmWnoHDAVSWkMrUP9xfLxlV2lkxh
         y0PAE4X/3qeKZHWZhJyx/J3DZd5DHyQaoXPom2iXMnbtzplCwS1laEaDh24YOsbJkoIq
         V2WiX9NGA39gaooOKU2eURfvhSl8PXU/9tZXfCgz58w9zhOVvY4VDkh3+e+b1ruoiI8f
         JhY76k1u8ki1U/6MH9/xX7oCb1pINaUMSIKT6ICrPDuCQM/ZJX/p9Jn6JngyMXbTTaIG
         gu4MlfYQ/cdzau7GmtQ6tAriZxu3Poj2uiXbL1fPVb8jo6bsAZeGOZvHwUFyaWEQ/DEh
         BIyw==
X-Forwarded-Encrypted: i=1; AJvYcCULXNTtyOX4o8sONaUquVHAd8Lvl1wEcGIkNFfc7wJ0xWosqQ2Waptm9xqsu06cdvz7vsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQLReZW82CHCp7/BXn3mGq5NdY70opJlZwYEAu2CfyaBvB2Tx
	c0940DyEtOzhYjj+TfbA+xM4yUdfxcHgN3om+qoY0UCeMS3zCPz+bFYb
X-Gm-Gg: AY/fxX5zaSoZzmS59zBvBQfMJlqXZHlNqAzS75pDgcw3yEbb5Soy302cZDu3UrjAoyK
	wpvO0zF9CW+In9WcrXt8PpFRvjRVU/AC/4aBiC9N0CDMLYV9DDeqdnre0QvEZk0Wu1NwS70Sz9X
	2OWVON0i63S1QzWXdajXkSPHwJZb63iG3/EYDtaZsWJj3GQZDmWuCOp17V0MUR5K6ahmLzC2Kup
	CkGwsXmTWNai0CCBIA6+QPNJ8N5+TX9cSY0FBdsHIoSWSOi9EFD5OkA5/f2alkKZb3DAIAa2ZtA
	ujnDx4DXSpDgwBd1cuA7KWxMJNjDyV4UoInCS3e96lelRS6ux5bgZveeLV/30Kkhn07aTe3gmtm
	CYU6wJjfo+PrlgPQvr2CfYrpbDQZJP/Na1VR+l24PDSkx6OdnsFCE+LDoplTYr2pi2D2z5JwKvW
	hhyav2DeE=
X-Google-Smtp-Source: AGHT+IHzDlEVf8/d6QbnaKBb4bXfG6njhvfNqB2OjCcNdUEx2bLbQR8avY4Ht9YmtBQ9rseOaNNR2A==
X-Received: by 2002:a05:690e:1c1b:b0:647:101f:cc90 with SMTP id 956f58d0204a3-64716c392f0mr4161680d50.53.1767839212841;
        Wed, 07 Jan 2026 18:26:52 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:52 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 11/11] selftests/bpf: test fsession mixed with fentry and fexit
Date: Thu,  8 Jan 2026 10:24:50 +0800
Message-ID: <20260108022450.88086-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 85e89f7219a7..c14dc0ed28e9 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


