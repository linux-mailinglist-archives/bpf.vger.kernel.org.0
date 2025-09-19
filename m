Return-Path: <bpf+bounces-68961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57BB8AE62
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ACD1CC4B2F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796A278E67;
	Fri, 19 Sep 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7oba5H9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAA274B46
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306069; cv=none; b=DIwKgbxGKC9xr1IrL+uNyY4AuodAwkTrc2IS1bySBguIBDVCjrWeDndtPtmDzWQg2pC9aROKM0OWbtwQDOCW/v0J/pkh2h18tR8uHVWu+Wxx5a6qP9na1dRfDZV/clA+aqeuBtlM/9eDczsOiinzAbT3h4K3Dn2IQcTFFONP+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306069; c=relaxed/simple;
	bh=mnhFefxXBFpAxTuPQC7oZZaXYOasqtRHyRYWS3i67S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emeIwpRlkGJaQ8bCItUnXDZyEXQStD+oaqbeZo5DILpHELFqxoij/jdSyR0S2dbBZXFjMDjK2R6H+orxjAAGWJNJcSzA7pb9y9WiMhjSmW7qIt3UcUjUGzSwcfPfnpuvT5CA40zh9V7C0agXACaSpmPwdh1FWs7jpyHG9PzljyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7oba5H9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso2294899b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306066; x=1758910866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=X7oba5H9dCMd3fJv2P/F+YfyYaMFZS9fx5Cem54/ih/KXtLX+f5ItusvStttjXLD2G
         YrYu2/771k38xTCO2WXZbSIVhTw5NmkP7e8brVD4idCjeb0BhisRgodTF0viqiQi95kr
         BCwMrB0I+u9MKBHzGIftC6IM6OuWtKlzMpI2mZDmPwNmoV8VNEjqrJsw5sekTs8HsjwE
         6vRKVGFcLJwojFIKZsPYZpaEpbt3Y5j1UINee6kLiAHPnR8FAvNejBh6bWzb07e2gUh3
         b6vd3IjIioNnqscu/6EwpKDMqp6NFV8sNxGPyyhdUKllzqJU4rGhWeGFKYXEv6fxXakV
         QQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306066; x=1758910866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=WOf+Nk9NwNLhoAUer03tKRqNW1cnDF+VVntntoi1oPPlGAO5PRjf7/Q3r9UCnMka9s
         8juoE0J2z5vKHUma87PrZ8E/xUFBa+1Rja60H7b4962ssqkiw3GXYtv+oXnrgyfhJsqH
         kJbxCaZqIVckAoanEF8f4QurWO8dZXyapsB0EbqnjFO2H2/OpABYsnUQVoMzTVXnEsLe
         MVZGkHQe+jgdkqhgxfD3hqPEywXmu4buWwA8fH+pPeoOwgEqL4OuvmJSj/ARy4/4Z/jh
         eAMpm6H5qHm+YsoRmHNASr16elcTh4wh02AfwtJNL00croak8KQG2hj6S8lqqo5bka8h
         05Wg==
X-Gm-Message-State: AOJu0YyZ34ZrSEHKU/yxilo2FIdcY77QTRpK1adjaTzBLYx65/x59ffy
	32iU02j97DJJyRZ2qtzYNrXEicxi8elDURyW6fh7cf5gY+gel+bs5X2iShRg7Q==
X-Gm-Gg: ASbGncssXdWkd3LzXFMmX5LiQ560unSm53elU0pes0mvcCFeJBn3hVPrbhBCso5I0gF
	B3r8XjH9x2NYTBFZ/vO8wYBWBSkehTqIs6MF4u72xwx60zveTRulm2c14IjtI2UFh18CTYNmEIx
	HuZc2EXxncevAJaTNRZP0vwQdH+7cG1xxoXNCCrrflKWnJxyuAW1anUmpu4vB4rUi1mR23NaIiH
	hHzYwvh+nWc7yA9jVHJvuXNs3Csc88VS86QpFPYpDRH2rtlEtv0h9o1b+FA/CKtBXiDbdb6Xdjv
	8BkvX6PjccMRdUXny1Sf/ZsEwUyUmzHWn8SLfkSRnF7LfY3U1hgWblIiVyOXd3eBJv1bP5Wd7Mo
	QYFx/MC+CfD56B+Zw3z5OgNGy
X-Google-Smtp-Source: AGHT+IEL2q1zK8GhmmRCXb9psH+uPSYX4ed6O7jKtZUypz4D8Yn1UwrbNe6vFQbOxam/8IMT48LBDg==
X-Received: by 2002:a05:6a20:a10b:b0:24a:a45d:7a26 with SMTP id adf61e73a8af0-2927277a9abmr6160006637.48.1758306066557;
        Fri, 19 Sep 2025 11:21:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c05sm5863283b3a.4.2025.09.19.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 5/7] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
Date: Fri, 19 Sep 2025 11:20:58 -0700
Message-ID: <20250919182100.1925352-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
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


