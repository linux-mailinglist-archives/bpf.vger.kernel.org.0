Return-Path: <bpf+bounces-69477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1269AB976E5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 22:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5534C2E50B6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C830AD0B;
	Tue, 23 Sep 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5X82eTK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE01ACEDF
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657647; cv=none; b=SjoZRBcMoRzbgc0VUVcVCvcpBtAuuUzDTA2QPScoWqUdYVHQIQEGZFFPN3fhTXzZIiD4bV8O97MKt65S86cJwfZ82JM1CFvLtME8vG3c0z0aRnSl3IY5kCQzqyi9fBMVXDSecZKCyNOXk9t/g7jHL6IptORJxubYbMbCXbdGoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657647; c=relaxed/simple;
	bh=yC887JdsZIuNAU3KH0iM0jpa/sF+QL795+nxAjAlvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmGlYsIAHIo82lX2ZV/1sg06B7pr0AFWu9rnptLbdSbXLtK6oEiGiDMtTpsnY6dD3ZLpTy1dNzwkZGs2XuFxNF1QjfEa+yZEOtdDZA/FYvntPtxjcHtKx7tmfYPyy+GyhiavLSAZfcSy/y0Jn5iTYLOgL7lSyWZbHKvFZ0UbzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5X82eTK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2a55c5ddadso46058366b.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657645; x=1759262445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kxnKEunBUq6lbDqWLItziPs2zbuhFcil+VxDU1uLZ8=;
        b=O5X82eTK2Ic9pgW05Mpn9VtUYSRhRrD5rv8wLaoL5KvlQwIptkBt3mDTMWiU38R6wB
         v9a2MFTMc+e4hIZtXJnkHHAQXsE8IYw8QaRMHV4jeZ37YmLN5uWArwXGGSAgIxrrn3d/
         O/z36Sa2X7NOPsTnPuBKzigDBDVfFIghVVxNdi4ANvaScoOUA3S4VszsD8wNxl1dWFE/
         BDulN5aO7QCT+obG5cABp2M14IAyrJdwURTQ8JdZak6x0lflIV92fw6NykI8rouycb9P
         T3km9rpRd1jQmbiLZk+UUV86EBE23sGtvrwKJyZIFZVqRSg0ng67T8NY9AwVIMDc026Y
         vAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657645; x=1759262445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kxnKEunBUq6lbDqWLItziPs2zbuhFcil+VxDU1uLZ8=;
        b=d1D8J70DOes0tkVh7zb7kKGfbCc+vQrWdrBJAKYqblDvbQNkHTwndd9NhgwrNI76Vu
         jMmvuuc4/o17YUO16ydNTCOY/s5qrebCG/pgb0g6B4TIWqXG/brbAk8NZXFjIwiu88b2
         ZxgynsHKWDbbnE30FlubjVZaqP6wlT8kWRT0y73z1msye3FMBecrFJspIaU85m8MOF5h
         Z60h1CH2C5Pxr4kkOgkiTqBIGbw+2uyaVD9jA0PuD0eJdgEgzaH75AEV48noAdS0uEQT
         r7ZML/oSOyx3dr/TCs7v2JYI6A30pAiK7QDQXgHOixp9ErHhSHdZdTNZCVUKKzjOafRh
         W2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWEbzJ6xRICuH+LOmlokSEci+mU7PYknLk2cESe09ChFrygLW+7twvAhanVUZia1mGf5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKsw2wz7XJagN7hgdZVKxgLf49aOt8ixNXv4RXjrd+O3/IWom
	m1ogV/K6GckvSY0oWkXX5eWODCkYaTYRd+UKVXVwuvpg9Onisrqqkwse
X-Gm-Gg: ASbGncvYZgMl7qASpaHyOoyRv5RkEFqyOQ3dtGPXskI8/XKYDT9jtqVz3zYQy/xLyCO
	wPeLafQJcJf0bubBQL/ZtAAMUFYQHywNcq/6GTx96GmLDjpEgYeMYyuf4LJxNh941HVAZpvQ1e3
	abwPYlA0+4uk359QQ5b277sQXzGrN1ivq32EyljLV2ofQjVOkmQC2BxqBdkScpG73cshpmXVX9e
	bpXn/AHftsXi5+S0SnNTrcVCgVJ1xVOL0gXEeK1W9g0np/VhKTu5rkm8bjS/aObbIYjN/4uP8Kz
	3hUqzcRDKw6yyg7cuXFL4HmGyUb35+9YP0ZftnqcxwrkQJdHZo19cT9Wm7H5zyk8wyfAs3J/PZN
	5JuFzxLq/LXMie/sh8NclT1MrJEUq7vx8tWqfHfMuaXU=
X-Google-Smtp-Source: AGHT+IH0sk2UMFhq8ILkVNhalVb23fPwThZEi+o2vb0yPrbkfalsoc549TsjUa62bG1KSNKQmFvZBw==
X-Received: by 2002:a17:907:3ea1:b0:ad8:8c0c:bb3d with SMTP id a640c23a62f3a-b302745d8acmr203295566b.3.1758657644360;
        Tue, 23 Sep 2025 13:00:44 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:44 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 1/4] netlink: specs: Add XDP RX queue index to XDP metadata
Date: Tue, 23 Sep 2025 22:00:12 +0100
Message-ID: <20250923210026.3870-2-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices will be able to communicate received packets
queue index with bpf_xdp_metadata_rx_queue_index().

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 Documentation/netlink/specs/netdev.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c035dc0f64fd..25fe17ea1625 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -61,6 +61,11 @@ definitions:
         doc: |
           Device is capable of exposing receive packet VLAN tag via
           bpf_xdp_metadata_rx_vlan_tag().
+      -
+        name: queue-index
+        doc: |
+          Device is capable of exposing receive packet queue index via
+          bpf_xdp_metadata_rx_queue_index().
   -
     type: flags
     name: xsk-flags
-- 
2.51.0


