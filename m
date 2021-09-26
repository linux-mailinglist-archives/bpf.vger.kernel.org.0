Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7C4188E8
	for <lists+bpf@lfdr.de>; Sun, 26 Sep 2021 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhIZM5p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Sep 2021 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhIZM5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Sep 2021 08:57:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6FBC061570
        for <bpf@vger.kernel.org>; Sun, 26 Sep 2021 05:56:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k17so13197454pff.8
        for <bpf@vger.kernel.org>; Sun, 26 Sep 2021 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nc1PQKV8z+TD4YUNfkfw0SyfgPKahgHeXxrW4JMWJGg=;
        b=eQucCqQv2JA2C2k6rCgW+Vrm1TSxVCPo4jLLxrFqLTS13hGDVafx4PSLlnf2G5+cNA
         4Tb9XJMUFFHE0aWm2PiwZ6Ueic27TZgbwkmUN9voZodMXSA9TGLUY+j5WvehdwHtFRxw
         3bb1vPHJq5LMsQ3ljNlQG5BSJaPeLKp5jl59qF87RFmmxaOidLXxYSCVZeBt94BkIoQU
         /VYTTvmlL70TtXNynmInq6cq+ikfz9mJJ2A2A8mlitwYKjhNcpnXtzGJ5rPxIHiUvITt
         IYnGWrhJJK971NtfjiTkyC/fJ9nscQvwbhquYcW0lQkuGSMsyxq/VXeAty3CJpBg6PZS
         lizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nc1PQKV8z+TD4YUNfkfw0SyfgPKahgHeXxrW4JMWJGg=;
        b=GGhHDJmT9ggb/Gp6RfWHdyFTy3WIJ3LQ5PhqLfWLPmi5D27HKtAggO2zyXDlUiFqK6
         NS/mac65P5/ZsvXrhM2KO2/9QZA4tQHD98JCYX748o7qRoOkHWv0cocbCAtz/4anyuZu
         zIHDfnA8RQeohdCsNygB+tXHPNzKbtlVfpDoPkbo6zflTruJWzt4j241O66Ikt8qant7
         JPHO1MTUrKBMZsYkh3eAANoBJyhAQjOPPtsiM8bLpxIdIKrniKsuxQ1am7bphuWFDZUg
         gdkjhZcAajDhgAMy7VxemGHCpocSD84K9923AICKvCBLIFXPNqoqT0ACD+g4tOSVM0Lm
         uU2g==
X-Gm-Message-State: AOAM530y8SVF7BugoMt0W1EXkXXknyYJcHdoMgNHNiMQrGjFSo5J+xVy
        QeUEJ7bE9oaPlu7NKKRUB50yqDxDcZAr7A==
X-Google-Smtp-Source: ABdhPJzp138tlZN9J3RigWJfmZJ92dIVSun74ZekursBY9p+7Jfc2faEe7HHlY7AohOyZ/Ap5NWT0A==
X-Received: by 2002:a63:a74a:: with SMTP id w10mr12028443pgo.213.1632660968079;
        Sun, 26 Sep 2021 05:56:08 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id e24sm13964773pfn.8.2021.09.26.05.56.07
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 05:56:07 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next] samples: bpf: avoid name collision with kernel enum values
Date:   Sun, 26 Sep 2021 18:26:05 +0530
Message-Id: <20210926125605.1101605-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In xdp_redirect_map_multi.bpf.c, on newer kernels samples compilation
fails when vmlinux.h is generated from a kernel supporting broadcast for
devmap. Hence, avoid naming collisions to prevent build failure.

Fixes: a29b3ca17ee6 (samples: bpf: Convert xdp_redirect_map_multi_kern.o to XDP samples helper)
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/xdp_redirect_map_multi.bpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp_redirect_map_multi.bpf.c
index 8f59d430cb64..c6361e70c829 100644
--- a/samples/bpf/xdp_redirect_map_multi.bpf.c
+++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
@@ -6,8 +6,8 @@
 #include "xdp_sample_shared.h"

 enum {
-	BPF_F_BROADCAST		= (1ULL << 3),
-	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
+	__BPF_F_BROADCAST	= (1ULL << 3),
+	__BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
 };

 struct {
@@ -43,7 +43,8 @@ static int xdp_redirect_map(struct xdp_md *ctx, void *forward_map)
 	NO_TEAR_INC(rec->processed);

 	return bpf_redirect_map(forward_map, 0,
-				BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
+				__BPF_F_BROADCAST |
+				__BPF_F_EXCLUDE_INGRESS);
 }

 SEC("xdp")
--
2.33.0

