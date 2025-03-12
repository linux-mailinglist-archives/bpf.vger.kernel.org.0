Return-Path: <bpf+bounces-53894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F84A5E08C
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7508B189C873
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F048E253F3B;
	Wed, 12 Mar 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbYj9a7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438785C5E;
	Wed, 12 Mar 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793800; cv=none; b=RZOjI11Y7xDOmuqjHxf2DGDCuo7gK+bIes01zEOGO9Zxf6r6nqzrRhcSnv2Eysxlyg44vLKZ/+MFMRgBV93IpJoCtmD/BP+fntvqSSXEYnDITtmbh1R4ngTVMGZnPIR1BUcCl7ix1cXeADsWPfUlnk03JWMmU19B7W9/GiGmYMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793800; c=relaxed/simple;
	bh=h/qpJhm6WBwQPPhZti+136AvuC9RZxbfa5gLe8KVBJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgWH7XsYyU2/HEZODK9bvKqzJVcRd1bD+t829uO4Ncf/iEpWEV89klugZjt+g9eagfRRWVDMLsRXI9bf44Pm8fGd0HLqqpGj+S83mW7r4HOJ6v3+38FB8NW8LUaNsQXoc6Ro3bXX54SQAUkzMYV3C3BNJgP8/n8aLJTceGOJAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbYj9a7I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2241053582dso43886095ad.1;
        Wed, 12 Mar 2025 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793798; x=1742398598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZoX/yl9uKTfonCNbRpf/6ZuVn8/WYqszsSvh9S9In8=;
        b=KbYj9a7IjMasDCrC85ilactYiK5O/YI7+Kx6LEazDmiZLSOOOM4E/DM+UPAze13KX4
         Y46rOidprNZNHizFmqGUcmHx2DYiDY+bGSju5W7ljjuCX+O3kjamUAUlPO2igiczKkST
         HS7i1rxRQzclMdEgWyPRaK3NabfpJFWkp0Dri9+C1aspDuAOQBTLI3BXtx6oBmEkld0q
         0YhLncUy7dP6ZLBdj9/W3kkmT3ivzftlKChrkYaUiBhwXy1QN0AESiD9Zgu3lHmkYa/6
         xfR6ql+l41IDrYNof+TGb5Hu/wx/J7/nP0Wl/ylN87Or5Uh8ln9ecjwcViGnJBJdCoNa
         9zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793798; x=1742398598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZoX/yl9uKTfonCNbRpf/6ZuVn8/WYqszsSvh9S9In8=;
        b=plzORW6clWrOEx8tXkJDeiZKhAeKM/lq9GH9sGIfsqphyH804c2Ro5f+8tg+8ltL9R
         dCcawkSoX9EoVECC21yYlwFh2LbksCG+4QUmRP/P+uwg+zXzIz5zKe93U/n0fstNvala
         1jGA4tm9rJkSF6PS9kQ5x7DVCYwp4YIxH/OE7d1RIC14bKdD2+oG00IJkAC7G++pD7ui
         cDw9IqCGm06pms7Tbt9Kwi+EyuP4xibvGpD2bEgkqb9TQhmVly0+n7F/4WQh5X4pLo0c
         yGLQf4I0hgpS4xVH9cP/LkjzMvedpbUQN6c5QysWtl76kzEhmnOtLA099btV+IejJs5Z
         4OKw==
X-Forwarded-Encrypted: i=1; AJvYcCVbW5dG8lWJqb/sP+R6aubyfEdpL8m9RS0yhqOdDh3gmzEumzPNzaP7iTWZhsXQubp74Gp75yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/Sfx5KPMJXaofSWrPU1Z4+FkQszqBz+P3H3zmr80isLadfDX
	zOCvGmqn7QOX+ZvD2PUJHswtaKMW8H+RNH6vhi7lTMxfs8qgKih1
X-Gm-Gg: ASbGncsCt6Vuw1Nrh7uqo1qugBraTF4vOKuGrEGYuyxTMnpy7WRVApQJGck+wJfct0U
	XKRD4rDVRcfsP/JvXEClixWHnfpI+2tOyGmNCkfur2iK7+Y4lp4Zdd5PMMPqZT+1EkemNu8Trb/
	EisQY6YD6rMyh8UQ2xg0EFZe5q+ALOPHsyqeV1pjL4tSuqYrmA+OwiEk335dPse4lKQd8AKR+ZT
	cd7hagXBzxCxkDoIK2mCCXh7PTVitCart4F70FoouGeqpxyDH2NwzHIVNaLik45S6ixkvN+bqSW
	p1YmnR8uKYiwwTOSsP5HL1MStdc6P/uM+VnWWEC1fSbhLOU7NoVoGBI1d8oGk/1h43cJ+Hx1yAr
	V8mBqs3+ftZBABIP11NgF
X-Google-Smtp-Source: AGHT+IEVNAqE3/RHlCzgLHbAC1bEQfyHfMTiAKQFqaNcO/7zUYqdlWXKCGqJ41Zqh9T7xdsH2qVzDQ==
X-Received: by 2002:a05:6a00:987:b0:736:46b4:bef2 with SMTP id d2e1a72fcca58-736aa9dbf8emr31534336b3a.6.1741793798329;
        Wed, 12 Mar 2025 08:36:38 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.244.131.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ab812cb0sm10813562b3a.164.2025.03.12.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:36:38 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
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
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v3 4/4] selftests: add bpf_set/getsockopt() for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN
Date: Wed, 12 Mar 2025 16:35:23 +0100
Message-Id: <20250312153523.9860-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250312153523.9860-1-kerneljasonxing@gmail.com>
References: <20250312153523.9860-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN BPF socket
cases.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 tools/testing/selftests/bpf/progs/setget_sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 106fe430f41b..0107a24b7522 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -61,6 +61,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
 	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
 	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, },
+	{ .opt = TCP_BPF_DELACK_MAX, .new = 30000, .expected = 30000, },
+	{ .opt = TCP_BPF_RTO_MIN, .new = 30000, .expected = 30000, },
 	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
 	{ .opt = 0, },
 };
-- 
2.43.5


