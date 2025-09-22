Return-Path: <bpf+bounces-69293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC0B93981
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333A82A0FBE
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA89D303A2A;
	Mon, 22 Sep 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt7l7Jg7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB44303A08
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584045; cv=none; b=OvFeAH0wYSzxo02fK74PWOjAHf/Qt6MqyLJEfWBozmvW5/gE5sYeRM8Jc48RF0daEXXhp/jCpuskhUS6/XtwSUzaH2G57wBCiW/lPOCt/TQOqFe9J9GPrkh9K9noMqitdLM062+5pG7DVrWwziedZLtlKxmBwBAp3OJS4Mmbg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584045; c=relaxed/simple;
	bh=CvB7wAHfgdBul3PQ6i0ELroLROtA5DthQR3Ag7xVOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAFDU50W3nGnkuMNyEPxIrCaE8brs/N0OHMlxn7cu8huiL8+1BmAMtgGeCg/DHKyrYmimytEmJ3cgrOjiN1mUcGQjwAqrxkjb2XMxKI6KK9+NkLuiaYRZ0k9wOlooz4r+ophMKvehTwqrjjnZf6YYiDU4C2dZUD6XVO/ptogsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt7l7Jg7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f3405c38aso1494159b3a.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584043; x=1759188843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wWAVfIussNCxUuvbxqrgV61kFlD4I6iuv1vcANKXfE=;
        b=dt7l7Jg7HqW5EuBVpVJRmhPlb85eGJnVnQwBlDbbepB3LqPB+8fQlVSX7uXt1iWzzx
         DdrKoHfXDgfPVyakgUljV4/dQ/0IeGn/pMG/bpytNfiUP0LGZJAMeCBuUYFGUQx4JvRH
         k/JrfJgRbvEzvZ+MHzLHt1fL2HVYl98JnnBZqb2217/wIOqpJwWlLXU6QpC95CPUHmH6
         KlG7LVShsiqh5n+0EzeVOZN7YiZ3CKCZvpTF8hKuOhyw27tfcfKDUAIvMBKalSRLu/lu
         BRZm+aHWn+/HtovkupC1e1ASaMEo68UP3yhd32soNZkG0wyyDkGashyA7VLGndBqaZgq
         q25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584043; x=1759188843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wWAVfIussNCxUuvbxqrgV61kFlD4I6iuv1vcANKXfE=;
        b=Gy0pZyltb4F3igdq+luz5ILzVS1N2+oFkydNR0skwZ+jBK/udtBVIbkeHATgtwHoo4
         86h7xMKkhJBY4U0jqKvXBet53YtRYSEOSZSjGlplfhf9Y3NOg246Mhq+29N4Jj287miL
         un+Z2YyhJAIv5iJB1dgkEMr66jK2SQy2ldulx4H8PeF83f3Bi9Pk1yxzqBmmTDEVpbA/
         KY4Ny/OSHp4RFaUHZMsz2gxc6rpG3rADBv2/5APuh3eLtqMUp9PMIpy5bff98eTk6lHt
         6woMEuw9/yn8PWCoF34bRMyueMleMpY2aNaR2vEuhvFKZK9EoyRV0N1dZ9qDrBe5UJvK
         KyeA==
X-Gm-Message-State: AOJu0YwuYDy6wfe3gN13BQGTYtOvqs7J1W3QL/m2kaBhZDSDwt5S+PaX
	BOf5D86quW9qXIxIVFmx0VkOrj/+06Ikr16M0DX2dDzLpwsLiMcRqc/7gIP7oQ==
X-Gm-Gg: ASbGncvcHL9HAicFdXHQ+Ac23333IYtd45VfYEXRXjpNLBdT9RZMC4NnmAYFrH/Z9jD
	IKY2erjXEBvBHhnb5i47Z/22SNuhuwKizsB0NrRj5H1FitfBUJR2xY2mdPPZVaY92yxtSK9fRdf
	xkBfm6m+hFv8jHCJDxsrjrYqhNAzrG+VL9WRG4QICRPE5cqvgZfgBYtsKLryyEEUY5csMgfqhTI
	lzBGQYUZay01sP3jH5KPFLrl1YtKfl7gJsFnUyL6D6EGds/as/kyWuedvoygPmMnUFvmJ4BZ1+r
	EocS7jAzwZALKtd1VdgjIqYaEdf87HUbnSJQPWqxPqVOVQdMIV00BdF6I0OlZUmX4/WiFp4npTh
	au+jshu5eKNc2
X-Google-Smtp-Source: AGHT+IE/eyo0JlUPSZyJvi1ko3Bies00TZjmSQwidW85KrZRfQB+rl2jl4h3uE8hV44UgYbgvPHi5g==
X-Received: by 2002:a05:6a00:1790:b0:776:1de0:4617 with SMTP id d2e1a72fcca58-77f538b5d05mr620784b3a.11.1758584042546;
        Mon, 22 Sep 2025 16:34:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2fdfbffesm5076728b3a.73.2025.09.22.16.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:34:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 5/8] bpf: Make variables in bpf_prog_test_run_xdp less confusing
Date: Mon, 22 Sep 2025 16:33:53 -0700
Message-ID: <20250922233356.3356453-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the variable naming in bpf_prog_test_run_xdp() to make the
overall logic less confusing. As different modes were added to the
function over the time, some variables got overloaded, making
it hard to understand and changing the code becomes error-prone.

Replace "size" with "linear_sz" where it refers to the size of metadata
and data. If "size" refers to input data size, use test.data_size_in
directly.

Replace "max_data_sz" with "max_linear_sz" to better reflect the fact
that it is the maximum size of metadata and data (i.e., linear_sz). Also,
xdp_rxq.frags_size is always PAGE_SIZE, so just set it directly instead
of subtracting headroom and tailroom and adding them back.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/bpf/test_run.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..2a0af50f177e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1207,9 +1207,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 {
 	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	u32 retval = 0, duration, max_linear_sz, size;
+	u32 linear_sz = kattr->test.data_size_in;
 	u32 batch_size = kattr->test.batch_size;
-	u32 retval = 0, duration, max_data_sz;
-	u32 size = kattr->test.data_size_in;
 	u32 headroom = XDP_PACKET_HEADROOM;
 	u32 repeat = kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
@@ -1246,7 +1246,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	if (ctx) {
 		/* There can't be user provided data before the meta data */
-		if (ctx->data_meta || ctx->data_end != size ||
+		if (ctx->data_meta || ctx->data_end != kattr->test.data_size_in ||
 		    ctx->data > ctx->data_end ||
 		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
@@ -1255,30 +1255,30 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		headroom -= ctx->data;
 	}
 
-	max_data_sz = PAGE_SIZE - headroom - tailroom;
-	if (size > max_data_sz) {
-		/* disallow live data mode for jumbo frames */
-		if (do_live)
-			goto free_ctx;
-		size = max_data_sz;
-	}
+	max_linear_sz = PAGE_SIZE - headroom - tailroom;
+	linear_sz = min_t(u32, linear_sz, max_linear_sz);
+
+	/* disallow live data mode for jumbo frames */
+	if (do_live && kattr->test.data_size_in > linear_sz)
+		goto free_ctx;
 
-	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
+	data = bpf_test_init(kattr, linear_sz, max_linear_sz, headroom, tailroom);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto free_ctx;
 	}
 
 	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
-	rxqueue->xdp_rxq.frag_size = headroom + max_data_sz + tailroom;
+	rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
 	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
-	xdp_prepare_buff(&xdp, data, headroom, size, true);
+	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
 	sinfo = xdp_get_shared_info_from_buff(&xdp);
 
 	ret = xdp_convert_md_to_buff(ctx, &xdp);
 	if (ret)
 		goto free_data;
 
+	size = linear_sz;
 	if (unlikely(kattr->test.data_size_in > size)) {
 		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 
-- 
2.47.3


