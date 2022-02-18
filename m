Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A584BBEB2
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiBRRu6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 12:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiBRRux (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 12:50:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 447BD5BD37
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645206636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNde7WrV2e/jpBdIIKy9XtPA41qQOji4MxpvjqoSM84=;
        b=QcJB6Q2E+Ps7uLwqMHvfzhr2mvYFTbPNzC9f8rz2NNKMXw+hfSxLZBp2DOa9D/TyYFd28v
        fqHjDtOD2/4B7xRsN/LhHAVuSbdffQ6pdjXzIb7HYmY6Zcxdx6M8usk4eK8Z2h2uHa32bu
        tzwqjmibUBOgEyhGX1nX/Vu2ERwbq7Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-ZYqCmgFjOP21atLGE6kytQ-1; Fri, 18 Feb 2022 12:50:34 -0500
X-MC-Unique: ZYqCmgFjOP21atLGE6kytQ-1
Received: by mail-ed1-f71.google.com with SMTP id eq13-20020a056402298d00b00412cfa4bb0eso1121317edb.7
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 09:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNde7WrV2e/jpBdIIKy9XtPA41qQOji4MxpvjqoSM84=;
        b=asZ/NsxSQx/rgIOcd70+E2BcFkqdj5DtbpMhsLIlCy+OaBnSNW2d2QA393qSXbNTM9
         wye6TWCGIcPnW68CH0zq6/yYPY6zjjRQkshHS1vQHqIU1p4bCtc13UhCSWp+3Mu4kU5M
         pk040xubWjg336uCoeF8avja1xho+Scpd3gADnw+r9Lq2onx2QomxNJUC/QJbVvY+kD4
         qmdC1T6GcgJLgKSO8JWA+uv6x9IyxrPYTogEcrWT6QYaJYs5sEbZPLoudpFWVZq20qVG
         J5BRjHJMy7OSlG8asJC4vXPFsVspqXI7Kc8vZ/MxSuZFxXxmQiKSq0cXkP58DxgxJWb6
         KEWQ==
X-Gm-Message-State: AOAM532+quHgTsGmfdLJrpox8QMzPZiAV0S1lCrp8DaBb0VHX2WYwrUp
        DQ+iZDzLsNVP+R0gNuwrSKLXNmehH7o8UGVTBVUyEoCpp3NhGWUXv0/7cSFtjGE+6VxzZl+6CKb
        JGAHiFDelpzPD
X-Received: by 2002:a50:9559:0:b0:410:9f7d:9f68 with SMTP id v25-20020a509559000000b004109f7d9f68mr9122557eda.437.1645206633601;
        Fri, 18 Feb 2022 09:50:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyx279reMGRrU5kRWdZN6MUoIlt9MHgddUOawj/wSXiTG84OW1hcmnuqRentYIkBkzFNLsuFQ==
X-Received: by 2002:a50:9559:0:b0:410:9f7d:9f68 with SMTP id v25-20020a509559000000b004109f7d9f68mr9122529eda.437.1645206633250;
        Fri, 18 Feb 2022 09:50:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g15sm71919edb.11.2022.02.18.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:50:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9A5D6130240; Fri, 18 Feb 2022 18:50:31 +0100 (CET)
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
Subject: [PATCH bpf-next v8 3/5] libbpf: Support batch_size option to bpf_prog_test_run
Date:   Fri, 18 Feb 2022 18:50:27 +0100
Message-Id: <20220218175029.330224-4-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218175029.330224-1-toke@redhat.com>
References: <20220218175029.330224-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

