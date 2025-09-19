Return-Path: <bpf+bounces-69013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED6B8B9C4
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC6D587277
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93AC2D97AB;
	Fri, 19 Sep 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvpaWovC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE32D8396
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323400; cv=none; b=QoAffgJasEmqvPOSuvhOQ4VVLO1E52QVKOcNJThjF2AlZtFWhlz6d8jZVUagqc7ncKuHF8WzH/ZUGdG1j4fFeRBGmyNhoHSWSdCXLVeHrSD65QkpNitwESzcj6XgAZ+e3qmGroabTOi8SbambjWOIv3p2I4pZY+0aBdB2dkKwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323400; c=relaxed/simple;
	bh=mnhFefxXBFpAxTuPQC7oZZaXYOasqtRHyRYWS3i67S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLM98USVz+3TI5t5FoX762np0z3NmaJkL/9FrUTLe0oa3D6GHHifUVSWbzjP2EZu8VC8qtUg82anGZhmEDpyrwwi7KinBe8HDXDRbI/qIdyHLmyhA9qIJlxRFJHfDsVOS55cKWR/8kdTNf6Mlik4NL6h1z6oHywtwfRPyAFvfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvpaWovC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2570bf605b1so35594115ad.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323398; x=1758928198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=YvpaWovCdBIOMR7csXr6GHiMPtxOqpv/JnIm2JoCWX1bWG6n95+PU5s+XPOf87A6H0
         21ODQUAeKyZTyKfaE9i8ibxxbCzcZK2sPoYVt0CbxiuZt1WhP8IydIMqwrABUNco8cwZ
         cMSl/dumpMFpVPDKxy/U1eoxHS1mkpqf9KrMzr18TyDgBQYEzCDFv9/BXMLZ83/vJtXl
         ZpUlWXUFqWv697Wi79X4zOVVed+X4DVbZpkVjiK1251bLbnUqUs6lWjhg/Eefe8MI23E
         eWILn1dXGsWZJYTkX0pyKeB6P2gS0c2RBYS/baBwOWVTlCPqiZaotnMm7zzHhx+kYa9W
         /+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323398; x=1758928198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=f6zM6LB761AqXTcgtdNrOVHP/Zg1OBjcSN2ITW2IwhwIeaAbto1pwPFouOYhPWRYV5
         +DjXFfdYWoiNiB6Kenmaw28Wu+cvDYo1ZgDg5YskzV7u5KuBd/XyUNdVBujCsIpDLh3t
         Ev8gRErYVNLnjDylvtaG20WVzeTySWftg1aMOOXQ5O6aQgLj2ABW+EmJvzshB8d5xrwL
         7o5rls41tKkBeFgWrqjuf8sQi7/OFmkZMe/fdT48deSqGraC7yU0JzEAGZ9+AmHWYc3e
         gaKDeyn81xUyd0fJeIXG34djziGUIkRIAYPAI64iHowJ7Sgihb69Hf0+JiVxD2NDwiTQ
         2MUA==
X-Gm-Message-State: AOJu0Yz3k/MyyJmwPomgmxl5DzbXz15sJypsMTUKL6oYtYOn028HoUvq
	8FRzJhV+MteT8R1eIny2ptxFL8jJoa0jypKmCiyZVpvkGi26zImJihCiW9tO6w==
X-Gm-Gg: ASbGncsb/idjy3H+iXhqkeCSGyiu5N0VH+GikDsxUqr47rtJhAEdcfdA+lI3eX6UCcd
	K8wFf6fm5pmhc/g0TgICfPON5hM2THT0bIsuiYY1rtrduXtfPMlz3+qA30XRbOWXzuAsZcr9pc9
	OezeWSyFIWLYtGie+8fDpabCZVl3yaAmXN9vRUWFzXwnI5tGtcJr/KCXkFXc4UMZI7nP7aXWKOX
	mGQsAibIaWSA3x/Vbb/fuN/mOSspsX8OXaBFNMxQBTkXYBOUVPMGo+N+KmkYSyNsgpmJZWC2wyt
	2cb8nLq4gj9qX/wa/TUAUw4t/WWC3Dc6Wf5srj1G2US/xW8YRbi34L7PIIta4IJ5X1yMIsEOOWi
	dwrrCrsIb3QvdTQ==
X-Google-Smtp-Source: AGHT+IFuLlM8aFTKXtZCHE01Rw33LzfydoorwmiFO/dtCvKUrTwP3n/9EIW3CbMiMrJ+3KRlp6BU8Q==
X-Received: by 2002:a17:903:3c30:b0:25c:6159:8ec0 with SMTP id d9443c01a7336-269ba552d35mr62357125ad.51.1758323398035;
        Fri, 19 Sep 2025 16:09:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803184d3sm64056585ad.116.2025.09.19.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 5/7] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
Date: Fri, 19 Sep 2025 16:09:50 -0700
Message-ID: <20250919230952.3628709-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To test bpf_xdp_pull_data(), an xdp packet containing fragments as well
as free linear data area after xdp->data_end needs to be created.
However, bpf_prog_test_run_xdp() always fills the linear area with
data_in before creating fragments, leaving no space to pull data. This
patch will allow users to specify the linear data size through
ctx->data_end.

Currently, ctx_in->data_end must match data_size_in and will not be the
final ctx->data_end seen by xdp programs. This is because ctx->data_end
is populated according to the xdp_buff passed to test_run. The linear
data area available in an xdp_buff, max_data_sz, is alawys filled up
before copying data_in into fragments.

This patch will allow users to specify the size of data that goes into
the linear area. When ctx_in->data_end is different from data_size_in,
only ctx_in->data_end bytes of data will be put into the linear area when
creating the xdp_buff.

While ctx_in->data_end will be allowed to be different from data_size_in,
it cannot be larger than the data_size_in as there will be no data to
copy from user space. If it is larger than the maximum linear data area
size, the layout suggested by the user will not be honored. Data beyond
max_data_sz bytes will still be copied into fragments.

Finally, since it is possible for a NIC to produce a xdp_buff with empty
linear data area, allow it when calling bpf_test_init() from
bpf_prog_test_run_xdp() so that we can test XDP kfuncs with such
xdp_buff. This is done by moving lower-bound check to callers as most of
them already do except bpf_prog_test_run_skb().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/bpf/test_run.c                                       | 9 +++++++--
 .../selftests/bpf/prog_tests/xdp_context_test_run.c      | 4 +---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..0cbd3b898c45 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -665,7 +665,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 	void *data;
 
-	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
+	if (user_size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
 	size = SKB_DATA_ALIGN(size);
@@ -1001,6 +1001,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
+	if (size < ETH_HLEN)
+		return -EINVAL;
+
 	data = bpf_test_init(kattr, kattr->test.data_size_in,
 			     size, NET_SKB_PAD + NET_IP_ALIGN,
 			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
@@ -1246,13 +1249,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	if (ctx) {
 		/* There can't be user provided data before the meta data */
-		if (ctx->data_meta || ctx->data_end != size ||
+		if (ctx->data_meta || ctx->data_end > size ||
 		    ctx->data > ctx->data_end ||
 		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
 			goto free_ctx;
 		/* Meta data is allocated from the headroom */
 		headroom -= ctx->data;
+
+		size = ctx->data_end;
 	}
 
 	max_data_sz = PAGE_SIZE - headroom - tailroom;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 46e0730174ed..178292d1251a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -97,9 +97,7 @@ void test_xdp_context_test_run(void)
 	/* Meta data must be 255 bytes or smaller */
 	test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0, 0);
 
-	/* Total size of data must match data_end - data_meta */
-	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
-			       sizeof(data) - 1, 0, 0, 0);
+	/* Total size of data must be data_end - data_meta or larger */
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
 			       sizeof(data) + 1, 0, 0, 0);
 
-- 
2.47.3


