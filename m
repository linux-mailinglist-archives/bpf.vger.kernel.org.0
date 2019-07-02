Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CFA5CD82
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2019 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGBKZv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jul 2019 06:25:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41013 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGBKZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jul 2019 06:25:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so16329568ota.8
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2019 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dn3a4srJGS7NUWBTCy05NkcHicDxkX+ax+mSbJwndrI=;
        b=vyMoOT23xKhLQvjqP8sORQ8ZfeC0NzbS4beg29Xqg3JsR7tMHOeccymgBym3QeukJP
         lzU7igM+t91nvt2mnCcoVHwvmqAO+znPhqDCEXl3EqhqmY/YDDFus70TJwN+N8sYUL/L
         D89fRzTKxBhHAyS6ur5nmgEcmFbZyjEwppSk8ieGrTaslX+bxriBg52uMyoMGIdycy6U
         5+D/DjgS2jtC0vePzT0yNXGwQ+HDP4GQfSOwwtPrOeJQ+5ILKF+aqBK1e+9GdmGGwM/F
         T8hpZLRxNTvBub7STYpW/SfYL52wslDLCijX2Bxdk1bYg4ylF8IQ+/5t57943VDBPkou
         Tqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dn3a4srJGS7NUWBTCy05NkcHicDxkX+ax+mSbJwndrI=;
        b=SOArZWwkVP5tpJprz73cTkwZRmfO9WQK81IG2z3UAUkXJW2w+iPg1UGyThaSvGx8Pd
         uU3K1MU1Z72CvsnH2ZcXfHDQtWQ3ILeo7N7UdlOhnWsBrKjw4wj1E93JD3AaVYUYFKYD
         63IR2gNiAtlGkpwtHquGlyTVjGmmlq9TcH4rTpHGdDyLQXpk+f1zP+UM4nQ6uT5X0Gbx
         zHY7RrasgSLqqZnKGmUZ8eKcp2fVdR/dRFFS1CBEov6HK5veF7OT9CyIqfAb6wrKrWwA
         aNszJM40RzHPo8j0ibOZEapVQDn0wfuE856gsevYQXSpwMtloIEVgR2OIGrluLl7GYNA
         AI5A==
X-Gm-Message-State: APjAAAV+I5r8Zm2LzLVGQWJYzwKlj5GUfSOP7grogeqAPIfyjha6eT9t
        PDRh7/qI92MiE4DgNUTqST3qKw==
X-Google-Smtp-Source: APXvYqytzmvI5JRZPKcQdv+sq5spB99V79PgnpLs9OdtX9GllBOPxbdZFk1Bq+gxkb4B63NYwNNAHg==
X-Received: by 2002:a9d:7c83:: with SMTP id q3mr24074170otn.273.1562063150413;
        Tue, 02 Jul 2019 03:25:50 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id r130sm2681760oib.41.2019.07.02.03.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:25:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] bpf, libbpf: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:25:31 +0800
Message-Id: <20190702102531.23512-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/lib/bpf/libbpf.c:3493
  bpf_prog_load_xattr() warn: variable dereferenced before check 'attr'
  (see line 3483)

3479 int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
3480                         struct bpf_object **pobj, int *prog_fd)
3481 {
3482         struct bpf_object_open_attr open_attr = {
3483                 .file           = attr->file,
3484                 .prog_type      = attr->prog_type,
                                       ^^^^^^
3485         };

At the head of function, it directly access 'attr' without checking if
it's NULL pointer.  This patch moves the values assignment after
validating 'attr' and 'attr->file'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/bpf/libbpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 197b574406b3..809b633fa3d9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3479,10 +3479,7 @@ int bpf_prog_load(const char *file, enum bpf_prog_type type,
 int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 			struct bpf_object **pobj, int *prog_fd)
 {
-	struct bpf_object_open_attr open_attr = {
-		.file		= attr->file,
-		.prog_type	= attr->prog_type,
-	};
+	struct bpf_object_open_attr open_attr;
 	struct bpf_program *prog, *first_prog = NULL;
 	enum bpf_attach_type expected_attach_type;
 	enum bpf_prog_type prog_type;
@@ -3495,6 +3492,9 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 	if (!attr->file)
 		return -EINVAL;
 
+	open_attr.file = attr->file;
+	open_attr.prog_type = attr->prog_type;
+
 	obj = bpf_object__open_xattr(&open_attr);
 	if (IS_ERR_OR_NULL(obj))
 		return -ENOENT;
-- 
2.17.1

