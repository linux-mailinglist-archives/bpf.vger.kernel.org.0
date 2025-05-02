Return-Path: <bpf+bounces-57242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0FAA76F1
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92074E31B9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB225DCF8;
	Fri,  2 May 2025 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="1RQcOA5j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D04255F51
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202539; cv=none; b=YGWj80q2l7QU/NxxboI/yH+JXphWHf4ibPGpEs3UOqiKa0VRjL86TzXjaIuxvm2wd6X8+tzsLTEifq4+ocfFLH097UUDH/UObiZEtSKSbmoPqdudwNMqSte0A02q8AMxE8tmcKmnB6HXbDBj2j64h4n9Al6mfSSGulLO9l8oRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202539; c=relaxed/simple;
	bh=0K881L74U7bYvvdXN0+69csdt06AemHwLvp1HDC8jxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkPWt4bc7DFoSaRA77SN9v/Xd1X3UCsJI1gX75d7tLdqh1IHsviyhD9NnoYH9/FY7kAhCI5K3ErHHn7OCq+4B09Y1PSmSfn5gI4y1SxSsVBzojN1l2BAXQl5kYliJKr4Gd/fkiNTHP8YL3R/dzLqcWOolvEa1sIfc18K5s5BUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=1RQcOA5j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fd44daf8so4229135ad.2
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202537; x=1746807337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXF8c7fWh50nxaBovQJDy07kpqb+C38tl5eUnuOLhaQ=;
        b=1RQcOA5j4OB5iLHJLhOSqZ3E9TZxA/StIhGFeBdFjL2l1wYOv453DePYx1KgRgAK6D
         7MQrVQ87IOydFDzKgPk3mf/BPFka4xuuTvL700nLipUYaeHLFZGEjUa+17CKuDLtODhs
         XdjwC3ra+wz34+D3e14CxmOv3ZsQ7l4aR9yIFC4jIEStYDmV1wKi1/OAAPliJEWrvNBg
         HLK/SuD0dNwkFkWWILV5apI27o5z5HOeX8YpHO+mKvklJaxO9hr38oJ9hTKvY/dlLEnU
         e0ASWu7e6fBkfJoIGJFzjVQ0/n6cD/oFpD86siyxGMoZxaRe9mjyCcDTm5YY1QqQ3R2w
         mVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202537; x=1746807337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXF8c7fWh50nxaBovQJDy07kpqb+C38tl5eUnuOLhaQ=;
        b=PcGcI/cBN18Ytv6Y72mGc2Uo8LMLeVlWg9Hk/HmRXS1+OOqrjXOMqjDXOFXKCxUkzG
         AbsZWjdGQP5jyEhO6R9xy0PquaypZd8OduuB4YuGPS+6aDGMm5mXEAQeQmkKkopvTTlH
         n6u7oWupl3i+cp12bmf/+wtq69wuC+59c6MIN1jkCiF56iLxxqOVPKeJ/z6Z2oPok9oj
         3eUzG3Zrr/bzuXWwfU28nWfwD5y1jwjeV8rYkBml835ZpTtENaTVlvQPR+/exH8LL3gx
         Bemyyd/7N+DzOmFu+/ik5V47KKR7mJNpluTiYQf5nOs7Okm8iVgQlCZsL9s4ScXzK2h7
         XhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSJ5pyTRpechQ1nFo0THvz0PqtZXLzsBT0Wp8awlb0ZmST3L+lhAlKofb0LFedZH3GIxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjWfIRESeIRf9YWB2NsQ9S4HpW/iajfUvS//l7gGYWebruhX8
	dIZVI3CmdOTWJdMddT3y4ESJn1xxRsT69GKNnjqUurhcMO8xXSmJcS2ucFEE2XSF/jZS2kxlVeY
	k5gM=
X-Gm-Gg: ASbGncsJTff8wEQIRZ1BR0VypMfDVI4HuB+r0hIZJSwucYvsMHN/KS5rQk06kf14LKh
	yBvalpcF6i5QqYeYCop2dWV3Hs4eDQt9F3QrHc7FOMSVhFySdUgJsoMCqNs+FUlpB6g3N5wB5uf
	MqLvxiV/tRzFnF2Cj23yetlj6K/1c/hpYTAUwNypTgemKD+ncHugw8XEomnfQOmHGujhnf57Oq8
	FVUWa+n73MzvOhGbdlRSO86RyrEWKYuhMVYRa2S5pJruynMj+libQESkmjXH936KKC1XwGhhQaU
	YnqHIQyRFEHGGSyGdhOJ8qJ3sskA3A==
X-Google-Smtp-Source: AGHT+IGIBhdyH0LCnt3a+G1gksyDPFu2aJ2gq3b2jxlpjr2Q+iqAeP8wdeOaWzpRq7ngR0KZWVnsMQ==
X-Received: by 2002:a17:902:c947:b0:221:751f:dab9 with SMTP id d9443c01a7336-22e103958e7mr20596455ad.14.1746202537166;
        Fri, 02 May 2025 09:15:37 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm9572135ad.68.2025.05.02.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:15:36 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v7 bpf-next 1/7] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Fri,  2 May 2025 09:15:20 -0700
Message-ID: <20250502161528.264630-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502161528.264630-1-jordan@jrife.io>
References: <20250502161528.264630-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_udp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2742cc7602bb..6a3c351aa06e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3401,7 +3401,7 @@ struct bpf_udp_iter_state {
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz);
+				      unsigned int new_batch_sz, int flags);
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
@@ -3477,7 +3477,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
@@ -3831,12 +3832,12 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, int flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
-				   GFP_USER | __GFP_NOWARN);
+				   flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3859,7 +3860,7 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		return ret;
 
-	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
-- 
2.43.0


