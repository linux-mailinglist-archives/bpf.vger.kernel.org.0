Return-Path: <bpf+bounces-68721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF1B82352
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 00:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B3B2A876D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DFF3128A3;
	Wed, 17 Sep 2025 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiNQ4Obk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636733126AB
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149720; cv=none; b=VRxFJ/FqGD1Rt3bCWkEZU55iHEZklCjOd8QX7PbIUnUGS6wNytt1lxn0Nes3FVkdhzdQfI+abwx4F5eIzG6vjSivOQspuoJu3W37HtlALQMjrusiadjJgY7MDrgbtX6LRf1iQIlM7Q0i+ya+XZhavnYxM3yaGNxxClt1Wy/H0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149720; c=relaxed/simple;
	bh=mnhFefxXBFpAxTuPQC7oZZaXYOasqtRHyRYWS3i67S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqhnjr3b02EsTG7WRrVy3lAoKCdqiZydiXP21DfHFn4JnQf5tvNxi7hw2Y6lwfWSewZBa8l6SYeZyDfe8ED6JgwIUaTZdk162JgfOGfGPjCk2vgD2gF6aAz9Rb9VKbjWRype6D6h1gegG2ELxJEu/9jrrJ/TXXmX9lyyY1E85a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiNQ4Obk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5488c409d1so226343a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149718; x=1758754518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=YiNQ4ObkGiavUOD/wLScIoSnQABI/CBjIQLh4S2Fvv1fmnkDACOPvNH0H3T2U3ejBf
         yDFJsm5X2AwarJyQq1nb2p+IxoFmljCjMQDyZJEqm+zFHeEWq/lw9wfY5wF4KBxlbyvW
         OUzj8BtiLz2JA1VNyBE82sXXyzprh6d1pNmpj9vzsp6WvY9XLnNyXVJ+uAzd37/1Gbi1
         Z6CHz2Ko3IAAcj5O+0NrHtCbf5/SiXY/s0EjchdjzdZbiVWcspL4CbGhXZAe0AiohKWG
         hU49IWkM+XaCZ/EiDZBYKQCW2ENFmkIuvaQqj/JoqtE1drip/RXRR5s1NGhXn+q3KgYd
         K5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149718; x=1758754518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=F5ePmIK+99Ni3VYwNfXzb97vGPEyZkyJl4zxu/9aD8/H/vcZc8fMj26BaLpI8WHLUy
         hmvQFSQoLCgedJkBqCyyiFkf3n5vvN7gM2k/m5f+mRo2WOvPKpwjxMdGxFOrsJe+rNKp
         q4tIdsF1AXti6ZzSzdrHf8BBm/ABCnYhq0lOZ7r1b6uYS94+GUrvXfYWQRhBLYZd0Dex
         HbstMZIMAEuufALQusYCarJJMwX92FXCMfYfLK9Q9CvVNJcsmDGm3uBkSRbzZ4Jg80yx
         jLphuzqd8tolB86KAhyWfD1872CyjHwQnb5qgzh/SLm/sE2aixDlbKQ/oQzZ9iILEBLq
         0z2g==
X-Gm-Message-State: AOJu0Yzu6oV2nqMRqAvu70ruTkgkyMWOf+uEx6RFuIkWNJ8Jk/sI6WTu
	0r5wGSrHWlOU4yjG/hjI95XFzNE/i5DtwNM1ghlKMSxbo2bW6tl2Gy8cFoAW3g==
X-Gm-Gg: ASbGnctDXv5sFg7JvZK2lYa292zvlwIr0NH6qxLcGnWhIpIw4y+qpZ+qXdm42KHJhcE
	FLLtuhRgpG+v3Y18KCDNn6naIWIyOhYV8BwmAbnh/7q6Tw4HqTc9scZxCtX1Y5Zpl4VN3jgMXIY
	xyHzmBXViPYgGTpFwvxmZaeVob3WYYYytlIa5vzNdJPaaNlkUKvSHdKnG7DypP6PjOm6XvqapGz
	6sASN7BF1cshPDAtC+MZv5yjt7sIcTQMk9tDveDopWhaJPgLeOt1pawuN191ePtuQ4JcSzBEsTd
	SEqeI5sPMEQf6tDp3GcOfxe3bgJGhrBfQ6GORavARjEW+QsE7cWyU94LdVGJwR+fuZ+HMlStkAs
	6VKfCjn6JGIRAFMsXsdLc7KLPi/Skwp6j
X-Google-Smtp-Source: AGHT+IHwJofSlLE8tsYTGbZKBEyHNYww/lQb2tjN2R7RrgWm1z7waF8RSUKyKN0OhHIyfd68B0K3Cw==
X-Received: by 2002:a17:903:3888:b0:24c:bdf5:d74b with SMTP id d9443c01a7336-26811e884a0mr53577445ad.19.1758149718459;
        Wed, 17 Sep 2025 15:55:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:11::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803587absm5822755ad.137.2025.09.17.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:18 -0700 (PDT)
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
Date: Wed, 17 Sep 2025 15:55:11 -0700
Message-ID: <20250917225513.3388199-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917225513.3388199-1-ameryhung@gmail.com>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
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


