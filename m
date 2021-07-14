Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D3D3C85DB
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhGNOSo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbhGNOSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 10:18:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC9C061762
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w13so1684378wmc.3
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fjmBoiBuTHHSOG8QbLHOu0AmN8x1dRxJVG9Qi9Evvo=;
        b=K+FIJQ6iPKBsM2PKaE5Hrwf75+Z8Tjs+fvChg4WHywd7BzucRYhZf9HqNiUsb3SX9d
         GGyn0YRdRQdU6mnYaizkUxTbkMApnB4EnZkzDZIYkgBHwyZI6JU6/1e6V5MvTvvGKFty
         dzNch8XxxIRO7WuDw95GtMocrFb7JBT9z/rGtceSBcgX3ZV9nRzY9BtgVsJ17OOgAFTj
         qIbFxdQDp/Q1GMjilDBPvCxIRmHDWxaVRBOEXHyXUMsqXEE60JU0uL4VR5inhcmBRova
         faFPETtT2MeToOfF8NEuDb2b5FsS1/zQBO+JUXnIHQt1ZRtWt9Fvab794I5K4tmU09gJ
         xilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fjmBoiBuTHHSOG8QbLHOu0AmN8x1dRxJVG9Qi9Evvo=;
        b=d7lwUWwGaL47oyLAeIxdUVnZF/vy/IqEWha9kck1C27DCuFgahT5EjhjQp5zpUEbiU
         AuLOMNO/pes1f1GDnuZ8V/XiTwIrpg88vnuN+Tw47jJ2Go1t2i0wLMwKSi58G/g8Vkva
         Jej8Cgy29dcAaRutZGzVCsjHsyXyXFhv1ipvqaL738HZ/JmwgXAOvmfb2HhV/k3TMPrz
         COhgyq0iIwVRDx/cl+7/5zvv0C2q9lkUL/QdXH50ajj258kAp3SkaevEAxmxZJQiHMdu
         CygiPt/2xyTVJYHbRDlMAIIcN5Q9xLLgaNRHtX1PsG6IyaRFdHkPnzsiEAUpZsCelYiq
         Easg==
X-Gm-Message-State: AOAM532amywpQ3Wg04pCw1c2dSKHpxRR+G8D+ZcTrV3zpuBpi/r9KLab
        D4+ilE1z0bBpImF2y+NsJC99Ww==
X-Google-Smtp-Source: ABdhPJxi+X4Uch5463AWnLf6YB2IWCQDTHY9O6teuJIqKNcdqi6eTSEJ2dsK8uMHBC0h064SrRIFvw==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr11598264wmb.162.1626272150180;
        Wed, 14 Jul 2021 07:15:50 -0700 (PDT)
Received: from localhost.localdomain ([149.86.90.174])
        by smtp.gmail.com with ESMTPSA id a207sm6380037wme.27.2021.07.14.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:15:49 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 5/6] libbpf: add split BTF support for btf__load_from_kernel_by_id()
Date:   Wed, 14 Jul 2021 15:15:31 +0100
Message-Id: <20210714141532.28526-6-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714141532.28526-1-quentin@isovalent.com>
References: <20210714141532.28526-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new API function btf__load_from_kernel_by_id_split(), which takes
a pointer to a base BTF object in order to support split BTF objects
when retrieving BTF information from the kernel.

Reference: https://github.com/libbpf/libbpf/issues/314

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/btf.c      | 10 ++++++++--
 tools/lib/bpf/btf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 05b63b63083a..15967dd80ffb 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1383,7 +1383,8 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 	return btf;
 }
 
-int btf__load_from_kernel_by_id(__u32 id, struct btf **btf)
+int btf__load_from_kernel_by_id_split(__u32 id, struct btf **btf,
+				      struct btf *base_btf)
 {
 	struct btf *res;
 	int err, btf_fd;
@@ -1393,7 +1394,7 @@ int btf__load_from_kernel_by_id(__u32 id, struct btf **btf)
 	if (btf_fd < 0)
 		return libbpf_err(-errno);
 
-	res = btf_get_from_fd(btf_fd, NULL);
+	res = btf_get_from_fd(btf_fd, base_btf);
 	err = libbpf_get_error(res);
 
 	close(btf_fd);
@@ -1407,6 +1408,11 @@ int btf__load_from_kernel_by_id(__u32 id, struct btf **btf)
 int btf__get_from_id(__u32, struct btf **)
 	__attribute__((alias("btf__load_from_kernel_by_id")));
 
+int btf__load_from_kernel_by_id(__u32 id, struct btf **btf)
+{
+	return btf__load_from_kernel_by_id_split(id, btf, NULL);
+}
+
 int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 			 __u32 expected_key_size, __u32 expected_value_size,
 			 __u32 *key_type_id, __u32 *value_type_id)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 522277b16a88..62291d3cc9c6 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -71,6 +71,8 @@ LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API LIBBPF_DEPRECATED("the name was confusing and will be removed in the future libbpf versions, please use btf__load_from_kernel_by_id() instead")
 int btf__get_from_id(__u32 id, struct btf **btf);
 LIBBPF_API int btf__load_from_kernel_by_id(__u32 id, struct btf **btf);
+LIBBPF_API int btf__load_from_kernel_by_id_split(__u32 id, struct btf **btf,
+						 struct btf *base_btf);
 LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 				    __u32 expected_key_size,
 				    __u32 expected_value_size,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a687cc63cd80..f8420a6d7872 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -379,5 +379,6 @@ LIBBPF_0.5.0 {
 LIBBPF_0.6.0 {
 	global:
 		btf__load_from_kernel_by_id;
+		btf__load_from_kernel_by_id_split;
 		btf__load_into_kernel;
 } LIBBPF_0.5.0;
-- 
2.30.2

