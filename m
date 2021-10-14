Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312CE42DBC7
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhJNOhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhJNOhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53497C061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k7so20043177wrd.13
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQabridDJcxeHhJlqAL6rkEjPMj/u95x0d5LXwe3wWg=;
        b=lROIab4YS6lecpzl7WZjBMphUPNLCcsv67XtZ7/3+tgIf+GxqQuZrECRAfuRuWODJo
         9/psa47rYCCi92Z3QOLOhRntcEvZUvuFtXrP7M3bMi/Kdtp/ZjmbLEFs30nQuDRVAEj5
         w3Mb8bXc7zTMEXc1etErYxGcNinGokvr7jJTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQabridDJcxeHhJlqAL6rkEjPMj/u95x0d5LXwe3wWg=;
        b=YQhdieczBAq4kGbXErudMZOn6ac8xS/h+P4MQPtdS94C5Gb+ZIhcZRluy+kvOz2HV1
         3MVwbOF8xGou5HVPsOi1K7XEtPguyX9PNvET9QfsI7t7Fk2V0ep5y+IbSx2EPVjptGxY
         EDBwJ7O45VYEMMA3dWKkdhrKKCGKGleSpDxr163qbrjktBQusqqaiphq3ieVIntT0+dn
         tIQobfcNUwGYBteK/N+WTkIsD/Ycng5XbrIM8hNNFJ0NhqQdNbsPT7bj9hzt++lZvtjp
         4FSNUHnSP7Jm+HRB2pL4vIMnfvnrH5qp8a4f+7KY/pGwl28NyVAZpWYlctPFLCNdFYY6
         3cGA==
X-Gm-Message-State: AOAM530TD6dRrAxg/50ARBAp4QGJj0r+AicBkg4N4JKHg+19if2PThmC
        iJ5psOj6vaKnwwCb2Ao3ZKivaOqPgugbCQ==
X-Google-Smtp-Source: ABdhPJwrpfIUUgMYilMmO3RYkKsBoI7L2X1VoqqI5KiqCweQ7NPUzvHq8G27oUgFYoCPtku8TLxcRA==
X-Received: by 2002:a1c:a747:: with SMTP id q68mr20205127wme.139.1634222097786;
        Thu, 14 Oct 2021 07:34:57 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:34:57 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 4/9] bpf: name __u64 member of __bpf_md_ptr
Date:   Thu, 14 Oct 2021 15:34:28 +0100
Message-Id: <20211014143436.54470-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index dec062fa0604..c1b1ce0e26a6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -52,7 +52,7 @@
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
-	__u64 :64;			\
+	__u64 name##_u64;		\
 } __attribute__((aligned(8)))
 
 /* Register numbers */
-- 
2.30.2

