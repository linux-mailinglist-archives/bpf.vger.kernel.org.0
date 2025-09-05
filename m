Return-Path: <bpf+bounces-67594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619DB46043
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2078B5C6135
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC8A37C0EC;
	Fri,  5 Sep 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfR5Ig9S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BF37426B;
	Fri,  5 Sep 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093641; cv=none; b=SpZX8A8E9fs7DPNslwL/A3K8HWnrLMD5T5OWiXrX8AdhcJk4Eal3BoJzWudEBWgK+lSRF7hLEUSo+eSZ8ljyEnNQsadNZnqBNoLn2nTW8b2CziFv6lxTiYm7Sg1TRO8eP2W151YcuSvFP2a7tAFJRDUFTT7k5I6nhQuDPnZwsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093641; c=relaxed/simple;
	bh=LdaMV1zM5sLcfZna5vbVGHTEiv59pyyxWvgREEICnfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fK/jb9Bs8YCZa9oc5HGyi0g/cCtOPCG+OMLbq0MyCVwd0e3AaVdUPZAz1HkRGrCodYs0ZMfxNvxIKxrN2/b1Ed4Q57vQCV90FnuIvGyhfHY7TnXMsl8r5EYPCp6bp8yPm2sTr49snKJGi1PACzKChLsyTd3ufGh9T7B5Ic6a8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfR5Ig9S; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c7848519bso22887855ad.1;
        Fri, 05 Sep 2025 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093638; x=1757698438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSxe6qfE1MYAKSnf2YkWYvthJRajo5d7tk0VRwbMl9w=;
        b=JfR5Ig9SiPFBzYD5/M/WJrMFSF6wz5jcgYHw4TsMOhwGOLe6FwE23o52Sr6hG45BZd
         SvpoFgYmnmcFXdCesZOYsWwgASEEqruRCwl552ocCEdHds8lWfJMC8XZ89gbMPK6iiyu
         lYXabgiHUCZHGwqiZHOqjbDI0Kx+Lp4Lw7uQL9C+WtEUdLYY5T0y8bZoa/DmO8CIp+iH
         leK6JtRod8EYvfHaAw3CPwav5PjbAlRVOvnC2fncU1WbNyS8JY6ukxKc4OZcskLmWNkA
         pWyCsmd7LXBA/tXmOR9Dp8g5jqMU+VazZeaSaACzRWe35nyXTqQq7ZSfbpZFkvBrWeW4
         d/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093638; x=1757698438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSxe6qfE1MYAKSnf2YkWYvthJRajo5d7tk0VRwbMl9w=;
        b=HfANpTKHtk0wPZQqmCjRi8R/fmbO9THqAv4wrQxeJfkxDiVNwg6MhNF/s0tvgrMw75
         6uq7j++JrfHt/a6SD0CqppLBaUdQ7VPGh2TEFMFmAf7iy27kBjIQM+WRsaO7ng9pLLRG
         ZdnD2NX8r95DD2YiqEA6SD1lCdoC5vmO98llPUFTSw0MMhqDuFSIGuqFMSQj9f2RVg/I
         LdxsvHCw/ALdJMVywgV+Ja/xtDxrwBETvFRZcCSoWIjBy/lBfKmXLrJqCNmD3Q4ZXb81
         DNyuRVxZwjuyGjhSnxFpqrDr0UA9SCKkb26fOS7p23cEMfZwX6liPqsBcWVfng6Hr0iP
         oXQA==
X-Gm-Message-State: AOJu0YwRYaKps1IfOi5kwkHSBtxn9t3dnw1EgFJl7P4QNyO+tVOMndQx
	BRjjF+zu36lOvWUeRbKzLttYFgl2PlGmFXN76DgdTxf3cvu+JrMADADm24mBTQ==
X-Gm-Gg: ASbGncsME6umnCfLN+V7nLDvpKDo84n9KlekOYgI1MD+cCiGRP6CwttZe3D58QHl+mS
	BnYZzy4dlP2p9ftWrDI/lRsXyOwzfvoxKyYmC4MfbTr6Bh4eDoGIbJ/j67a/LuyX582oCEyVeLx
	ZaflGNxNsCk/101DgdNoG/ZP4RIeP2nxwr0V1+5rpeLClXTyBRduHS3rQbEiTJIXGIlRT5OnqY8
	ZLm/Z9tSLBVqc2FSwl8qwX9cCzkyzuWkC2Di0oq/FpgdaW5p+xksIvmFL5JVmJWqHKBqopO0vcE
	YIEYyan+kUC6fB1Uc8+QT1Hy70xUI9aa4Lj//74kDGdQ5YzQYNaiX3j/6noEGsi989iC7ymOw5J
	8lAKsTfpZ6UgB5w==
X-Google-Smtp-Source: AGHT+IGeVvKv/rEDDMgWBW7VRaF1g8zcuO59m7wknIwxRhIqPCwBhGmQUv985PN7BjKaHL+jyvm9ew==
X-Received: by 2002:a17:903:15c3:b0:24c:cae9:77bd with SMTP id d9443c01a7336-24ccae97aa1mr109141155ad.54.1757093638443;
        Fri, 05 Sep 2025 10:33:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7d2dcd2csm86854475ad.145.2025.09.05.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v2 5/7] bpf: Support specifying linear xdp packet data size in test_run
Date: Fri,  5 Sep 2025 10:33:49 -0700
Message-ID: <20250905173352.3759457-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905173352.3759457-1-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
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


