Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A684CEE28
	for <lists+bpf@lfdr.de>; Sun,  6 Mar 2022 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiCFWfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Mar 2022 17:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCFWfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Mar 2022 17:35:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C794457B8
        for <bpf@vger.kernel.org>; Sun,  6 Mar 2022 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646606051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNde7WrV2e/jpBdIIKy9XtPA41qQOji4MxpvjqoSM84=;
        b=BFFDJL60zHUkoshwhw8Wh8sG+9M2rFHStwrx3daOut7R12In5H/l/bWoFrGlIYU46fJM96
        rNkvzHbWvoM1EfO6EMjjidshTExwam8dtxbjLYx0a3VF4h6y4nFFw0jkafGsi/6pMtBxZv
        dp0sPRm53fn0ucMnSKr0q0T9vsltKGE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-5sv6BqJGNT6DjJr9yw5gsg-1; Sun, 06 Mar 2022 17:34:10 -0500
X-MC-Unique: 5sv6BqJGNT6DjJr9yw5gsg-1
Received: by mail-ed1-f71.google.com with SMTP id co2-20020a0564020c0200b00415f9fa6ca8so3960345edb.6
        for <bpf@vger.kernel.org>; Sun, 06 Mar 2022 14:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNde7WrV2e/jpBdIIKy9XtPA41qQOji4MxpvjqoSM84=;
        b=BhakcU8ssf+QeJAT138mg2e9JcCLaJJlUuS6XeOSNzxRNMDt3nIDTYUKVrbEd5m1md
         sJFHZo5jgwmbJWBSRHVL1AdqFHvVUygGTFV6JOU0vLYl07FrD7rCFKwP+uXLN+aWSLMM
         3dbd+HSrbguDYtOdQBZ+BMF1FkmlvwI+WJTNawKS/6vk4h6FLzxwGSLhAejD3od/AQci
         rhLnuMu9n5LE5BU4bERIpjHHU2090Qmc2AaMVsS7lq2gPmkYG6sJRd6lPzHnBVVMhLST
         MZA1roF7vhY6xGdNZUwdEJcqKhj8rjKrbpAFD/ilNbyhIdBKpX6ntQRlf5HIlNGlECg8
         kuTw==
X-Gm-Message-State: AOAM531jbBsqxtXSGWILcLQYRWAPBFHgexBpe0kdBUM+T9vNDnmpH9fx
        AjrhUqPf3gTKDMthfsu3wfAq7MscNGDJrX1kQm29oGfL6RSzoFdLGgudbesllNwJLA2iiMMPVUJ
        6pBIzLIow60GM
X-Received: by 2002:a05:6402:358c:b0:412:e44e:f62c with SMTP id y12-20020a056402358c00b00412e44ef62cmr8465628edc.206.1646606049325;
        Sun, 06 Mar 2022 14:34:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGbExezdxM2ZvbFqBDeTjMO0cOLJqAoibCU1AmfVBV15DRDDGJrrB0r33g08ajuoofBwxISQ==
X-Received: by 2002:a05:6402:358c:b0:412:e44e:f62c with SMTP id y12-20020a056402358c00b00412e44ef62cmr8465602edc.206.1646606048962;
        Sun, 06 Mar 2022 14:34:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i4-20020a1709061e4400b006db370920bbsm24669ejj.90.2022.03.06.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:34:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DB401131DF1; Sun,  6 Mar 2022 23:34:07 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v9 3/5] libbpf: Support batch_size option to bpf_prog_test_run
Date:   Sun,  6 Mar 2022 23:34:02 +0100
Message-Id: <20220306223404.60170-4-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220306223404.60170-1-toke@redhat.com>
References: <20220306223404.60170-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for setting the new batch_size parameter to BPF_PROG_TEST_RUN
to libbpf; just add it as an option and pass it through to the kernel.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/bpf.c | 1 +
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 418b259166f8..e2ec93c2c7c4 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -994,6 +994,7 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 
 	memset(&attr, 0, sizeof(attr));
 	attr.test.prog_fd = prog_fd;
+	attr.test.batch_size = OPTS_GET(opts, batch_size, 0);
 	attr.test.cpu = OPTS_GET(opts, cpu, 0);
 	attr.test.flags = OPTS_GET(opts, flags, 0);
 	attr.test.repeat = OPTS_GET(opts, repeat, 0);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 16b21757b8bf..5253cb4a4c0a 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -512,8 +512,9 @@ struct bpf_test_run_opts {
 	__u32 duration;      /* out: average per repetition in ns */
 	__u32 flags;
 	__u32 cpu;
+	__u32 batch_size;
 };
-#define bpf_test_run_opts__last_field cpu
+#define bpf_test_run_opts__last_field batch_size
 
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
-- 
2.35.1

