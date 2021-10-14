Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24742DBC9
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhJNOhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhJNOhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E2C061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o20so20242086wro.3
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72gZKBrfKgoUWtA0MnfSD+/RstckYUJrfeUTl4UgLDo=;
        b=HVe0CwSM1P6u6k+sxY2TScbVu5Lk71VNRI6Th7azltZ+5dprvp63zYsl7IM3r4iZov
         EULo52P1jDUehBEBbkpvFXLUvM/tglhVd1bONEQp3vP6poQQn7Oy8nBSktvfco6xoGZy
         LKW0OfZFT9wb/sMSu+u5tXxhQJ2wJjrp/QSbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72gZKBrfKgoUWtA0MnfSD+/RstckYUJrfeUTl4UgLDo=;
        b=44PhoB6PkofBAslL6PT9qIJbmhAzpL+5hqBcNz/6N4//qUvXUtsCI3HwWv3/UMNpHv
         J/ne9dCbYm+iSSFi3ndKQFo9KLqxtqtfMtAL98e5CBtBjYoQLvZ0MrdBN+cGiAiR5AV9
         NIk6gJ8r13mF/ceKdr4Y3LLKKM0bb5QpIraK2HAn2QgqpN8Ra/bYJNg5WpOQ6jPChHul
         +vQPd97KAfILKalbN3Ctl/IJopMZMxsJPRVUymBbSbG5OTknAlMrif2zQ8Wo2Io1yvcG
         QETooQHhbfMe5ZpmTOYHdSHFNSsUoI7m661uaWUAXWkpOaiSmkhL+kgPDtKjwrI3LE/H
         yxSA==
X-Gm-Message-State: AOAM5336cnD9+G8/wws+Sh6wxqVFIQrpTw/hJz+U/rgiCKw+GFeB5T+W
        h9zSPvIhvSU7ob1BbxYitPWkJqjydgrNjQ==
X-Google-Smtp-Source: ABdhPJyGW8+bfFwP6QhUtxzCloWYizy4RdCNwXYuf2h8Wh0ZYSJ/2SH8yGRK8yQH7DP03GRB7RWbXw==
X-Received: by 2002:a1c:9d97:: with SMTP id g145mr6116544wme.78.1634222099136;
        Thu, 14 Oct 2021 07:34:59 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:34:58 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 5/9] bpf: introduce CHECK_ATTR_TAIL
Date:   Thu, 14 Oct 2021 15:34:30 +0100
Message-Id: <20211014143436.54470-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 kernel/bpf/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..14c2cfe6ef38 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -719,6 +719,10 @@ int bpf_get_file_flag(int flags)
 		   offsetof(union bpf_attr, CMD##_LAST_FIELD) - \
 		   sizeof(attr->CMD##_LAST_FIELD)) != NULL
 
+#define CHECK_ATTR_TAIL(attr, field) \
+	(memchr_inv((void *)(attr) + offsetofend(typeof(*attr), field), 0, \
+		    sizeof(*(attr)) - offsetofend(typeof(*attr), field)) != NULL ? -EINVAL : 0)
+
 /* dst and src must have at least "size" number of bytes.
  * Return strlen on success and < 0 on error.
  */
-- 
2.30.2

