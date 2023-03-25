Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8B6C89CC
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 02:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCYBJC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 21:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYBJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 21:09:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76CE10CC
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 18:08:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ix20so3412121plb.3
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679706539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+RhrKrarnMEEmf+wRd26hfnVCy90LImCwtPKsNxygg=;
        b=SS+bal+5MpOn7V1HWkYGA5Gc9X2P6l/FBsZajJGbsu6WqkawrpzSGr5jfJ/ucIlYeC
         +JQJKU5lb5+QlCCS1BLonK8Wkuq+DU10IYAGSg/vbnQASvKfmRdHyDPz3MkACfWuBe7G
         1U5FhLUG81EaWFzjdcUMw+NufhinB59V5lxlSjVkwuTSmCG1h2hVvgjxchIPFNKUV4uW
         DXhIf5s9y/wPHMBBFlAm/nJnsNAr+qCS5BMsCbOX/ZmSESVKkBX8nLBiB2IHvwM9DzAu
         w/WS6IzC+uGOieQ4faS8TJVvLcb8BBAkWKFp3iGSq4j9Ka2rH/qJ3KbhtOFJ/OwSyWSy
         UqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679706539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+RhrKrarnMEEmf+wRd26hfnVCy90LImCwtPKsNxygg=;
        b=2Hy4/ZGuHNt5XXuV5VJlZG7zOjDNYefEcqMuRVk5eQCNZEk8mDltyfTFZMfybyf14q
         NbhVK/dkytq7Pc+p046RfI77UzWwsmWmAuKdan4re0wrXuLmbta0bspp2Qyet0ragLNK
         khvUnBt6ygOrqyVUWYrD3a0SyiGT5jiEDwntbAwV+P2FB2nUqvcElcCzFAj8PDFmrnC+
         1HKeacP1id9dhw3CWUVXnwgJ2UkIFTy0Yt2bwGicOHpdtWvqHr+6ELj2gfCMMSgUEnrq
         VKlo2pVU5CUigfo996Aes2X/ltBsRoG3UylUvZG6Ut3k+fLPKcVYn0ENbAhiF5BwLgyq
         yDvg==
X-Gm-Message-State: AAQBX9c47FbKoS8KAOS6gD531mGpXZ2HIyZUm4p1k64hI3U6Fq68+nta
        8Sz19tPeNT00iYAc7pK0Xn5+AACzvo0=
X-Google-Smtp-Source: AKy350bjWZ6X9wZ2FgsgnDbH2e9kVXSaytkTzxPvj8BvAiHAKdHze50oGOZfL8WgaMyvrBdoIF6WJQ==
X-Received: by 2002:a17:902:ce8e:b0:1a0:65ae:df32 with SMTP id f14-20020a170902ce8e00b001a065aedf32mr5609329plg.37.1679706539107;
        Fri, 24 Mar 2023 18:08:59 -0700 (PDT)
Received: from localhost.localdomain ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001a1ba37d06csm12509460plr.29.2023.03.24.18.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 18:08:58 -0700 (PDT)
From:   JP Kobryn <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com
Subject: [PATCH bpf-next] libbpf: synchronize access to print function pointer
Date:   Fri, 24 Mar 2023 18:08:45 -0700
Message-Id: <20230325010845.46000-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch prevents races on the print function pointer, allowing the
libbpf_set_print() function to become thread safe.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 tools/lib/bpf/libbpf.c | 9 ++++++---
 tools/lib/bpf/libbpf.h | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f6a071db5c6e..15737d7b5a28 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -216,9 +216,10 @@ static libbpf_print_fn_t __libbpf_pr = __base_pr;
 
 libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn)
 {
-	libbpf_print_fn_t old_print_fn = __libbpf_pr;
+	libbpf_print_fn_t old_print_fn;
+
+	old_print_fn = __atomic_exchange_n(&__libbpf_pr, fn, __ATOMIC_RELAXED);
 
-	__libbpf_pr = fn;
 	return old_print_fn;
 }
 
@@ -227,8 +228,10 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 {
 	va_list args;
 	int old_errno;
+	libbpf_print_fn_t print_fn;
 
-	if (!__libbpf_pr)
+	print_fn = __atomic_load_n(&__libbpf_pr, __ATOMIC_RELAXED);
+	if (!print_fn)
 		return;
 
 	old_errno = errno;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 1615e55e2e79..4478809ff9ca 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -99,6 +99,9 @@ typedef int (*libbpf_print_fn_t)(enum libbpf_print_level level,
 /**
  * @brief **libbpf_set_print()** sets user-provided log callback function to
  * be used for libbpf warnings and informational messages.
+ *
+ * This function is thread safe.
+ *
  * @param fn The log print function. If NULL, libbpf won't print anything.
  * @return Pointer to old print function.
  */
-- 
2.39.2

