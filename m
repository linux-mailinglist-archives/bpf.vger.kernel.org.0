Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AF42DBC6
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNOhD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhJNOhD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29CC061753
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so20137757wrv.9
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxuhbka69vrglXWqMLAHUMctSCrOk9pl2oGisWfG9dE=;
        b=kAtH8Y4626311OtVPgztu2m2i4C5rxeXbSZ0+rKfn30ppC9cpjPdupqla5ghzJzkYT
         KN0O4r0ULf7LCu10e3fEU+sidFm8LZrPi/QjE/ED8RCqwH6f3u1nspUqlzu0AqUf3f+1
         yN58rBU94nL20g+rdPVm3sKxMxaUYTHcqIWRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxuhbka69vrglXWqMLAHUMctSCrOk9pl2oGisWfG9dE=;
        b=TiIy8q5VbjbDxNoI69G+cxppMGUv9pOzbGsqWyZThTs3WFpUgCXbVK3hUctqPz80TS
         zu3xPqE5LhVBIxuK7olSOa/o7aMLm3+xsnec1IdMpdJsRuFV5L9jWKjDquJt++ggvQYV
         96s/uiIOfIlPN8x6IqQ6wcuTjr9H4yRiltJe2qYCNlAmD7Ja9b7+zhFz5Ab0Uc568TMn
         0o5N5vamev8IErvDa8f26xnKZKrPjviqq0UUmE+aqAYPBi03YY5nP5af6vjaFjsqBKLb
         v1nSNXmY5vOMXDd0JFDGZyaKVPm+vjqZ/2u5SZ28vL50zBje6fQhrk6Fh6q3Ta5xyRYq
         4fTA==
X-Gm-Message-State: AOAM530YzwD3HpzOFzOl2njxZG4c7wRDhF7kbQFH7XpqvuhO/RWONqWf
        mGttY2LmFDbVqqx7SbJywdHvdw==
X-Google-Smtp-Source: ABdhPJw2PycVz6I8/hpvZMZGZYX0zwTyQM/VDoCth311twhMwHc5QeX46/4w5En4xEAzu6iWUv9BQg==
X-Received: by 2002:adf:a31d:: with SMTP id c29mr6997189wrb.381.1634222096957;
        Thu, 14 Oct 2021 07:34:56 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:34:56 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 3/9] bpf: move up __bpf_md_ptr
Date:   Thu, 14 Oct 2021 15:34:27 +0100
Message-Id: <20211014143436.54470-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/uapi/linux/bpf.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 211b9d902006..dec062fa0604 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -49,6 +49,12 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define __bpf_md_ptr(type, name)	\
+union {					\
+	type name;			\
+	__u64 :64;			\
+} __attribute__((aligned(8)))
+
 /* Register numbers */
 enum bpf_reg {
 	BPF_REG_0 = 0,
@@ -5285,12 +5291,6 @@ enum {
 	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
 };
 
-#define __bpf_md_ptr(type, name)	\
-union {					\
-	type name;			\
-	__u64 :64;			\
-} __attribute__((aligned(8)))
-
 /* user accessible mirror of in-kernel sk_buff.
  * new fields can only be added to the end of this structure
  */
-- 
2.30.2

