Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC66B495D
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjCJPLs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 10:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjCJPL0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 10:11:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CB04391A
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 07:03:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l1so5565598pjt.2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678460545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb6mbWOGcIPt+M3RmYcKtIyXDFPjdIfsNrOtZYGtZLc=;
        b=RBn6t+o9XuTT/SYnWDE0xWMHbR88yzeqpPTecg/lwycmwtBW96V0qeG/O991pD0KeA
         jnZ51e1GGXGi+VifcMa5ZbLH8iJxk9K0dcO4mHIScVc0vUpexiOxnCU9aQGIWHC6eMYd
         FXHT7MMATDEWLALRTy7vaxeedLK/QHwhTnX9JdCqco90pm0TNxZed0WKh4Z5zlS9wNfv
         yZshO1bGmYMo2bSh3+YUmxDB3FBiuqF0damlvw1vh1K1G3mKsl2Si3q8o8EPtls1PG0m
         yDvYLEoB9oK/7aQRvcyfkFYCZVLYLZ9mXmrEhVNieZaRMdL0hKUcqgzUWWFbweSupsi6
         9vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb6mbWOGcIPt+M3RmYcKtIyXDFPjdIfsNrOtZYGtZLc=;
        b=IL2MNZl9Mvd7GcL3Iqcb43P34xiuNsMBRkB23/6GnpSVuXldFcRyIEeksQu2Id9qrR
         k9AqrxxcyqHnyASmvUn6MX/WXAIUQjT8lPuHow8ANNd1K/d9Y8wt5So2zc2XMc8a5HvO
         hTOexiaAGGc2qh+hJHkpoKvFm42qbaRQWVMRO5n3R/+1AK71a0AV4kvXRz19KfDdQ5n9
         mOWRRQjeexLcKgQLfiZB0UXX0vp3hUAKHvtArqzbrW4Qd2rtG4THRJnosaRIGgxjBW+R
         g4mHKSDDNczd1yOoL1nm4FQaXddx4AUaEKdIg+ZqmQLllnnpbvSMjzMNSNBR2KaKPkEb
         qFWg==
X-Gm-Message-State: AO0yUKV9LtyIjb967wb3EjDW8wjfBQFVGOjB1SlDb8OQBp5cA6TSZQoR
        7OQXzlX7CvVW4lKoiG3fhOEU35tjrfhSAg==
X-Google-Smtp-Source: AK7set/oTdTmsk46N/6zfEf+Lj8q17zUPj6b/3SShvQTsL/5njY8tfd0KU/2TnI1TD8TkB2vKcXwTg==
X-Received: by 2002:a17:902:e842:b0:19a:b4a9:9ddb with SMTP id t2-20020a170902e84200b0019ab4a99ddbmr31744043plg.49.1678460544599;
        Fri, 10 Mar 2023 07:02:24 -0800 (PST)
Received: from localhost.localdomain (212.50.246.164.16clouds.com. [212.50.246.164])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b00199193e5ea1sm166753plb.61.2023.03.10.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 07:02:24 -0800 (PST)
From:   liupan <patteliu@gmail.com>
To:     bpf@vger.kernel.org
Cc:     liupan <patteliu@gmail.com>
Subject: [PATCH] libbpf: Explicitly call write to append content to file
Date:   Fri, 10 Mar 2023 23:02:16 +0800
Message-Id: <20230310150216.922-1-patteliu@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Write data to fd by calling "vdprintf", in most implementations
of the standard library, the data is finally written by the writev syscall.
But "uprobe_events/kprobe_events" does not allow segmented writes,
so switch the "append_to_file" function to explicit write() call.

Signed-off-by: liupan <patteliu@gmail.com>
---
 tools/lib/bpf/libbpf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a557718401e4..7d865ca95c81 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9912,16 +9912,20 @@ static int append_to_file(const char *file, const char *fmt, ...)
 {
 	int fd, n, err = 0;
 	va_list ap;
+	char buf[1024];
+
+	va_start(ap, fmt);
+	n = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+
+	if (n < 0 || n >= sizeof(buf))
+		return -EINVAL;
 
 	fd = open(file, O_WRONLY | O_APPEND | O_CLOEXEC, 0);
 	if (fd < 0)
 		return -errno;
 
-	va_start(ap, fmt);
-	n = vdprintf(fd, fmt, ap);
-	va_end(ap);
-
-	if (n < 0)
+	if (write(fd, buf, n) < 0)
 		err = -errno;
 
 	close(fd);
-- 
2.20.1

