Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94332653FB
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIJVms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgIJM7g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C98C061795
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so5547053wmi.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zn1i8UCbSwtIzHhCvaQDmN+O/hazqmOSMJfFHBYOEyo=;
        b=cuP0J+h/1FVt+WpFPwAreD8gPPLpf/+FpS50mKGN6kum6Cqd4iAWCJ7EWk7bd4ugJB
         UhH7tjAsrCW/eJxyiG6m1KyNhFqc0MZ9/ZCvM7Agz/AnMHVaxxzmM1xgKxYx6fbMhZXy
         8LWqIH7oAkX+Mx7xXwhYC/+dKpfz9sZhDrw14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zn1i8UCbSwtIzHhCvaQDmN+O/hazqmOSMJfFHBYOEyo=;
        b=BzT5eG1W8T3l1BqPU5MhNtce/ZpPFIxS18WLiiYbtCMsS2Yj4/7wDj3fjcjVVulSe5
         gMTfCp/bH+zJV3/oBdAXAfNGFR/9iJhxn3RiCm3hseZKERn928uZxqHbmIWGPS11ywMG
         3etm0+B/uqmSWxTW4P8PULmtQDfcw5YAmITM1QZeimQvRYO0v0fXUcybGmfmix4br8nx
         dsvDzEknVx83zENm5kZV/nBH8iQxu3wzGVXz5wRjM82BlskBJMVth0wLvXLI/gyGQLfF
         Et0ypskNqCZjv/pRTthwK2YILr7pA/4iPX7sGqYa8m02mj8H1BE9w+iLMRvPvx/2F+ok
         0B+A==
X-Gm-Message-State: AOAM531LTfvV4i8U5pWUKwo49Iu+7I1cT9awrJdYpomyhYolS/EaaBhK
        Fxt2Uftzx+deWHrPg7QQ1diG4oF6vCiIGQ==
X-Google-Smtp-Source: ABdhPJxUTY9ZHCOsYUcEdExRgYIq3txNFqY2IIMiWLkcATHiQmL0h3+HqOySbn9vLc7V34JD6Fb+Sw==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr8225989wmk.120.1599742644466;
        Thu, 10 Sep 2020 05:57:24 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:23 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 03/11] btf: Add BTF_ID_LIST_SINGLE macro
Date:   Thu, 10 Sep 2020 13:56:23 +0100
Message-Id: <20200910125631.225188-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a convenience macro that allows defining a BTF ID list with
a single item. This lets us cut down on repetitive macros.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Suggested-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/btf_ids.h       | 8 ++++++++
 tools/include/linux/btf_ids.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 210b086188a3..57890b357f85 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -76,6 +76,13 @@ extern u32 name[];
 #define BTF_ID_LIST_GLOBAL(name)			\
 __BTF_ID_LIST(name, globl)
 
+/* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
+ * a single entry.
+ */
+#define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
+	BTF_ID_LIST(name) \
+	BTF_ID(prefix, typename)
+
 /*
  * The BTF_ID_UNUSED macro defines 4 zero bytes.
  * It's used when we want to define 'unused' entry
@@ -140,6 +147,7 @@ extern struct btf_id_set name;
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
+#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
 #define BTF_SET_START(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_END(name)
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 210b086188a3..57890b357f85 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -76,6 +76,13 @@ extern u32 name[];
 #define BTF_ID_LIST_GLOBAL(name)			\
 __BTF_ID_LIST(name, globl)
 
+/* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
+ * a single entry.
+ */
+#define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
+	BTF_ID_LIST(name) \
+	BTF_ID(prefix, typename)
+
 /*
  * The BTF_ID_UNUSED macro defines 4 zero bytes.
  * It's used when we want to define 'unused' entry
@@ -140,6 +147,7 @@ extern struct btf_id_set name;
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
+#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
 #define BTF_SET_START(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_END(name)
-- 
2.25.1

