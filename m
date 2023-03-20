Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2ED6C0932
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 04:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCTDHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCTDHc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 23:07:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41D61B54A
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 20:07:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so10932602pjz.1
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 20:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679281647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kg5Vif5X/yN6y3sF4oGlRb5yrLSkawXHL1PPLVWYUvc=;
        b=fKvK6spjI3vl1MDXygqxuU7Un9/V04mkXSx0pCwGNLm7FtUOhVzMDewHjjCGXB1in0
         VjOZxKZeyoPZvL3LBZJiH3UYrNPEln6lACROqvN3g88wG1Sh1BPLr8EbPqnZ9XN/7LUG
         us+IwO27jE7yPCBy2lYwF1yw7uwsHYYJvhbO9FPh7WNxk6N2B3eVP7Vwpj2MdK3ytfAE
         FWPJBVwoaZJB+l3sZL5GFIoDYyUj7rvYYq5Pr407h9t0Jb8BvFxMyy/tA4pjjSsn9LiA
         SPhqa1PbBM9S+SL5tQTuhYjT9lWkSWCB28b99Iifv8ohcHEV+s0y2NpbJ5LPwV0srGex
         ZWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679281647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kg5Vif5X/yN6y3sF4oGlRb5yrLSkawXHL1PPLVWYUvc=;
        b=ZUUzDavy1ZMMMkdzB4mcQ1N1s399EGzBbBvbixwRPC6TNdqeIIGRPwdHbYt5qQ0+1S
         +5e7lDvFzI31lzG4hpoRKOy+j9M6SU5TOhcf4bgsSdGP9VXqfnhMWfYxmvzI7ypsqLgc
         C0JpUpk1ot2PUtVt9QKUSx9/who820XJssTte/4WGA/dASvIW7TSH7kD3Jk0/ph8tqYg
         5M5rDd4g/qSzx9d0PsnItPyoc9ULWJbZMLKkKfrQafuoNcBiGDbubMIV1/ZLQlP0pjVQ
         JreS+ag1XwmLXrQv0XIWOkMrhxCkZ4t41ckBNLJJEyLs0JFhRHbRPYQK5TDPhV7UWTe1
         gbdw==
X-Gm-Message-State: AO0yUKWeLkbZctxI32PFrYtwKeRmWG66NixO6D1IO6niX0wPW5saKW8H
        gajZxZN65iHmlZfNrJWfnqiatcmjcZECCA==
X-Google-Smtp-Source: AK7set/o7K21bpmmZTgY3hNd/okOC+iuf003R9c0rpAnrnpNRgckWV9NSF/+7D7oYa79vvb33JMADQ==
X-Received: by 2002:a17:90a:5:b0:234:4187:1acc with SMTP id 5-20020a17090a000500b0023441871accmr11127166pja.19.1679281646688;
        Sun, 19 Mar 2023 20:07:26 -0700 (PDT)
Received: from localhost.localdomain (212.50.246.164.16clouds.com. [212.50.246.164])
        by smtp.gmail.com with ESMTPSA id ch7-20020a17090af40700b0023cd53e7706sm8506736pjb.47.2023.03.19.20.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 20:07:26 -0700 (PDT)
From:   Liu Pan <patteliu@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Liu Pan <patteliu@gmail.com>
Subject: [PATCH v1] libbpf: Explicitly call write to append content to file
Date:   Mon, 20 Mar 2023 11:07:20 +0800
Message-Id: <20230320030720.650-1-patteliu@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Write data to fd by calling "vdprintf", in most implementations
of the standard library, the data is finally written by the writev syscall.
But "uprobe_events/kprobe_events" does not allow segmented writes,
so switch the "append_to_file" function to explicit write() call.

Signed-off-by: Liu Pan <patteliu@gmail.com>
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

