Return-Path: <bpf+bounces-66442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C8B34B07
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4D217C8F4
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AA28751B;
	Mon, 25 Aug 2025 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhAbIW19"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCF28688C;
	Mon, 25 Aug 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150768; cv=none; b=rd1hEI/LE57V+63QH3YjJLMZZzU0SjrECGRLKeSwovta9ggPG1B7Lral6nHA6MzSqEgwGMStUmXGRssv+IhJExDiYwcTNzYPvcTVS/7I3jELF/sxPL9lJ4+BpctnfSMjx8KpoUEKLrYrtSrDYLDglfa3VfOqkt7eV07Hfn6yCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150768; c=relaxed/simple;
	bh=LdaMV1zM5sLcfZna5vbVGHTEiv59pyyxWvgREEICnfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0KQqwwQmlZXieOPvwbQXhpGEKQ03c/TQeRmysyp+pkePmMjs0S/BhTpG0FZISYoZAK2IC3g/dW/TqRXqK3JyXXfza8X1GPvvCDxscLKRgfY7+GetwTfwNoKuY/1PkEMAYBNovg8q2Mqzy2x5euZAZNg8n86BMDRVpTOfeWDeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhAbIW19; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7718408baf7so1674716b3a.3;
        Mon, 25 Aug 2025 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150766; x=1756755566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSxe6qfE1MYAKSnf2YkWYvthJRajo5d7tk0VRwbMl9w=;
        b=OhAbIW19JUmXSZoxOTFFM1hfnCeQ9TxatYopFZtKrHUqkzaoM28tG84oOVhjkeUxk4
         duXBhwBSc2LJ8Ev67PVwX6jteLgmRj8Khkj2Wzrkcepv2GSIfDyuUoeMifhTUkBSM85H
         5yeTy1oeHDWEqvydpTofGc2ZXZGcMNd28a1fGnetD/9JXjMPBCZnTNMtVVXtITtIR51l
         jKGYOmAJG2MorGzoojFFX2uVbTRUFJnw0Blub35k0ABJOptTiK+BANUrQg9H3JwF/c3R
         dzaXUROQmKCzIARHKjhsbhnmNhXFCNqLOdF5RFcLJm/x/URMgELJ2VPfVZZVqEc0TRoA
         aToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150766; x=1756755566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSxe6qfE1MYAKSnf2YkWYvthJRajo5d7tk0VRwbMl9w=;
        b=TnBwfOe1Kv54D847Kcnns7UyYi5D75dcIbO89hWMOZpugQcuDHpFwSNtRoC5n+2am3
         VtOgYwS/Mc36a3WeCJCGLw8O8iY6LCDao+gA6kjbaMBRCCj6lmqPtA4Kc0Yo9NsxK/9r
         OV8MffHpKntanRCMYByP1AoaqSqkMhuOQ3XgCTVXryAc+2oyQHdZTt1dmbp9umqadCKa
         4ls2FWV0CoIozzZ544dkEzkyRlsG8HiPnnESRhrwJCQlJfO2EPP2OyRTwCw5OaFjn4NS
         KR8p8A2E3+/TheWnfs7mjuXgnZ9DoGqqmqLN8ePgTXjF7x8b9geNCpMekknhI/YTCPhB
         bsTw==
X-Gm-Message-State: AOJu0YwJf9V/af13zPaZnIeyTeY36sREGJM1RDCVPTOmHfRWXHt6Xc8r
	vdtilSYVwKwhtgFwPRu0OxVf3gAzsIULgnEHm1Kz64nywhrA88/qYk9oz5Vd1w==
X-Gm-Gg: ASbGncsakoVrglXkxdI5XzDNjU+mFao5qwlRo3ow5Uzm79tHV/DvrEMxvrYBGNpxMhe
	1nbYupG9dwhoObl0MCBP/3NworwX3wZ7DwRu83heQddNoW3u2i/dDbjiIX6XChJc9/olJh5LttT
	8nUP2sIbUMUX41R6yZdvXfk8ywCj4CeitlDW8H3DedNFsqQYk/OBTH04Vqr4s5t63xFXMUIucX/
	nJMyqje6qpURITMCCCBfEwJ+HyMjXqoT583TXWz0Ze/evcIEE4wd3nAKAiE2iLJHeTiD4cT84tq
	UEpOJDI5sGtlFqkpQFu8F8jBdTXaIsLpRgdYcpI/t3Os5KKtOcQ6lJzxBVB8KxZRv0pr8Tz+ERc
	ByFZ8uJV+3EiAFFvcfL/+mDAM
X-Google-Smtp-Source: AGHT+IEwNfUdpBf9cdC7zdFGrJ6teRclVINdICzyA4qkIIzIlsp5wOBIY/ULXs7FsNZnUXr1mHKxMQ==
X-Received: by 2002:a05:6a00:a8c:b0:749:ad1:ac8a with SMTP id d2e1a72fcca58-7702fa49552mr14847659b3a.11.1756150766242;
        Mon, 25 Aug 2025 12:39:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm8406843b3a.75.2025.08.25.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 5/7] bpf: Support specifying linear xdp packet data size in test_run
Date: Mon, 25 Aug 2025 12:39:16 -0700
Message-ID: <20250825193918.3445531-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/bpf/test_run.c                                       | 9 +++++----
 .../selftests/bpf/prog_tests/xdp_context_test_run.c      | 4 +---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..1a0d0bc35ad5 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1207,8 +1207,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 {
 	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	u32 retval = 0, duration, max_data_sz, data_sz;
 	u32 batch_size = kattr->test.batch_size;
-	u32 retval = 0, duration, max_data_sz;
 	u32 size = kattr->test.data_size_in;
 	u32 headroom = XDP_PACKET_HEADROOM;
 	u32 repeat = kattr->test.repeat;
@@ -1246,7 +1246,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	if (ctx) {
 		/* There can't be user provided data before the meta data */
-		if (ctx->data_meta || ctx->data_end != size ||
+		if (ctx->data_meta || ctx->data_end > size ||
 		    ctx->data > ctx->data_end ||
 		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
@@ -1256,11 +1256,12 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 
 	max_data_sz = PAGE_SIZE - headroom - tailroom;
-	if (size > max_data_sz) {
+	data_sz = (ctx && ctx->data_end < max_data_sz) ? ctx->data_end : max_data_sz;
+	if (size > data_sz) {
 		/* disallow live data mode for jumbo frames */
 		if (do_live)
 			goto free_ctx;
-		size = max_data_sz;
+		size = data_sz;
 	}
 
 	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
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


