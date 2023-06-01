Return-Path: <bpf+bounces-1560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236BC7190B2
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 04:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E5628161B
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 02:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12A1FA9;
	Thu,  1 Jun 2023 02:49:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF71390
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 02:49:12 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB6D101
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:49:10 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6af93a6166fso411097a34.3
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685587750; x=1688179750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxLmPWSnGEJp9jYQrAzo0Lj6e0Kr/zNbCeEBhHwKB60=;
        b=hu/4HijiVBPYn82So3d2DaA499ZATcXicSwjIkrBMNR0Lk2sKY9WB21AprHj8KQXKG
         9E+2/YML/Kq6o1Mpkh+HBCl3vYvL6//hOEI+tayubuF11vdspkFlo7nHzy0CTkWhTSmG
         jAj5eQeYbPbM/bnoCAfzwfENSQjaloxM1xrGdpE/jRra48tNV7z1TvoH/rgXqsB85yIF
         +hLtls15XjMRLXhZiVLh5XY/1Hd7PTd1PhN8F2bDoszjgoHY+snJBzB+ntsXGF4cwHF5
         HrvflSqIjJJ+fAy/TLGxHYvGWLTOHsFxwqCng7tGo65geJYLjdXIYx9jv5N7VLE5NZXS
         vAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587750; x=1688179750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxLmPWSnGEJp9jYQrAzo0Lj6e0Kr/zNbCeEBhHwKB60=;
        b=LGMHgXlhRIuPJ/4wdE81V/jvXtuAMxdU3cz3RZU05GVc1k2z/NrEica9oUNF4hFtw8
         nZnXXSGTdouodlnIfS3H5QpsRuc5Uu1CWMiY0qf33qyZCr3A05mapWUSEmlvDS5fQx8w
         RFyI06c6QxIgKRnT7XhWz8zrx6cZZQo/Mno3VLu6OAUQrLIy6bor8KAtclBZoEbZjzb2
         xz24wG3lFwr/PHuJ1O+TCOqrRedSpq+ZcafDfPC6pOP9UPBLLmk58ukk20mN6ts9AdfG
         kmRabkOt+3puRZHiCUOUFhki6Lcgjw9wDu4wO8j+zyN9F78BmhUlTZQSaWqx8z4/bMRk
         Ceug==
X-Gm-Message-State: AC+VfDxBOcTecHwQLKAeT60Mz0CmPpgjOYICkwzuGLYLoAMaUTL3bcSW
	8AEpq+smBVno8BQbzIZysuURRA==
X-Google-Smtp-Source: ACHHUZ4hGZuAkPLf2CHpFCdNg5z7eUawxXSFiEr8KIx8HvRyXkXOk9OZG3ApdnVSdfBM+swzkXqi2w==
X-Received: by 2002:a05:6830:3a1a:b0:6af:7143:3b3c with SMTP id di26-20020a0568303a1a00b006af71433b3cmr4665495otb.9.1685587749871;
        Wed, 31 May 2023 19:49:09 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id e10-20020a62ee0a000000b0064d5b82f987sm4076564pfi.140.2023.05.31.19.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 19:49:09 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next] bpf: getsockopt hook to get optval without checking kernel retval
Date: Thu,  1 Jun 2023 10:49:00 +0800
Message-Id: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Remove the judgment on retval and pass bpf ctx by default. The
advantage of this is that it is more flexible. Bpf getsockopt can
support the new optname without using the module to call the
nf_register_sockopt to register.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..ebad5442d8bb 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1896,30 +1896,21 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (max_optlen < 0)
 		return max_optlen;
 
-	if (!retval) {
-		/* If kernel getsockopt finished successfully,
-		 * copy whatever was returned to the user back
-		 * into our temporary buffer. Set optlen to the
-		 * one that kernel returned as well to let
-		 * BPF programs inspect the value.
-		 */
-
-		if (get_user(ctx.optlen, optlen)) {
-			ret = -EFAULT;
-			goto out;
-		}
+	if (get_user(ctx.optlen, optlen)) {
+		ret = -EFAULT;
+		goto out;
+	}
 
-		if (ctx.optlen < 0) {
-			ret = -EFAULT;
-			goto out;
-		}
-		orig_optlen = ctx.optlen;
+	if (ctx.optlen < 0) {
+		ret = -EFAULT;
+		goto out;
+	}
+	orig_optlen = ctx.optlen;
 
-		if (copy_from_user(ctx.optval, optval,
-				   min(ctx.optlen, max_optlen)) != 0) {
-			ret = -EFAULT;
-			goto out;
-		}
+	if (copy_from_user(ctx.optval, optval,
+				min(ctx.optlen, max_optlen)) != 0) {
+		ret = -EFAULT;
+		goto out;
 	}
 
 	lock_sock(sk);
-- 
2.20.1


