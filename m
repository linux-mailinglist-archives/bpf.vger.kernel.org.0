Return-Path: <bpf+bounces-68952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6094DB8ADF0
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041E41689B9
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5626F28D;
	Fri, 19 Sep 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMB6aiKP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B726264630
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305374; cv=none; b=vDZjYJpSdZ2/75yk9uklvMU+cuPjbVsf+cxRqR3bjsxkCLyW79DaHgpkdCN01hjd5ehFIB0OfDpkKL9ClOGuABeoPMe+yhEudg5/v+CBrXuqd5r0YJH/nq4fCMSVChJMTFjzppSJ/jbzYDdhio42wh9AQs+d5WZdtMyQwp7MxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305374; c=relaxed/simple;
	bh=mnhFefxXBFpAxTuPQC7oZZaXYOasqtRHyRYWS3i67S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEaBNy7AGbTChhUGBVIeasfDqrCt8tDT927ohfCJ+/CAOq065mWgUyJUYsTMT0ynIrM0NlDdrLM4KohTgGc9WvakMJvcKoJeIKXxmFphlO/G3HokxpEOoDszAWzJzT0VZ3ajTcrGyzb2XxxgfVgsiCAnWLfnuc2fnhC4I6mmfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMB6aiKP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-267fac63459so22132355ad.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305372; x=1758910172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=QMB6aiKPLQS7dmJ/pUYWVaQeSHSDJKnRYdbS+5wGEM39FldMrgJ8dFcJYF+dMKYtTh
         NPeiLh536tcgCWQ8qoiId+6RZIOSHvINCnjNdMT5hBENzPaepuHHsHJs5PCzEgwgy+Eq
         8XrEhnqzx7xyfqZv6bwmcBTmCw1ftHuZ6e+mafGYJFFNJof3T8sT3xr2c9jb1tWtpBq+
         dnbyW+hPcV2923YELgiUQX2RUP6XwR1zGGZF1hogK1kf46PhKCIvdz1mU6LL0dvcmBIy
         ORRXKRSmMv7FKnjTRfAPcoLeiCDv1ahGt4nFQZXu6ksDI/oRcEC6FomGnjj7ihxUURqv
         hsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305372; x=1758910172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=pMQ+3IAgupbi6ONk3deZT3kJqgXJYj7FObRRCV2m+n3YLLXcRNOnZAQ+lc5/V0EKL+
         QnDpVTdl61ybO6oSh8PdvPz2cQoLiJa8KXONdWbdqD4NqYRMKtBUO8B+HKh5gpWFsBsy
         InmHWy8knTl3QQGlGzp5QMSsJdHic3SAAsRGYd6UOaauQoFBvQNax8/Y9oLpXXOq7kNl
         uTmfZYIpBPBDdOWnsTcFq1Pwi1ItGrGhnhGJujMZ09jz/BzTiMgNeg0wa0fCFmUNeuXl
         ZR1MfsW3bU+oUt0OqA9ZWH11XyJz+wklFWlQJ3A9eT+mBLKwXP6RbnqTtrZirc6WX3pm
         +/FA==
X-Gm-Message-State: AOJu0Yy2QurIE8N4oZqGRI/Lsg6C2lALVZ3t2KCahFJHr8DgJ3R3Yi8+
	3TeegVqcfJ9q3SPRaWDibha+v3oRom963Iw79hJAJ7PsNkcFb9Ken6slEuvqXg==
X-Gm-Gg: ASbGncuxtkHZ34ijdpMj++USeHYXm5UZZP9pF22BgYvSIfEDrTVhNsxI3s+886r7/Xn
	dJnht/aFi2/nzr4QqXuNeHxLAhxDCn9tM9qXrXXOcLrGBFYmGtX2nDAdMpuS4kTrRxBXLw0wiDD
	/n08iiXp1Fdqfiy4fmIOwHKxT10u1dLC6Ftertu7MZa7jTYcaYc3yrw5fPh7/sj6LexOE87+SxX
	NB/XTi13LA8mhuOT1NUwmmEWs42XYAflBSNTmjhsocKMkyofEbYlMJ0oUqN4DhQGzTKCeRTxOTt
	YjMueupOObGTsoD3piyZNQsrwmGbH6F/44P82SLyCL4HAr6jlDVFKJ8XAZJiIgF7naKeZTyzUzD
	M5RkPn+EiigYU9RR4AM09HoeH
X-Google-Smtp-Source: AGHT+IEOxYaoPTKGlkn3Kqx08q3AA8T+7eAF9tmxMyHzXxed6cIunrYp6VWh28+tRDL/P6ibU6zVdw==
X-Received: by 2002:a17:903:3884:b0:24c:82ad:a503 with SMTP id d9443c01a7336-269ba53a976mr51098275ad.41.1758305371668;
        Fri, 19 Sep 2025 11:09:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980357043sm59701505ad.138.2025.09.19.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/6] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
Date: Fri, 19 Sep 2025 11:09:24 -0700
Message-ID: <20250919180926.1760403-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
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


