Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1642DBCE
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJNOhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhJNOhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6AC061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so20205223wrc.10
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY45++CPmrGk/MF8B9SiWWaspjWPnEk5MkiCy4m/ex4=;
        b=t5oAcoGN59+bd2OGbeMTtL2zu+CI6Wf6zOmr1mj20agAklm/UNRAuSWzDKcTBkPOqL
         S2ga36y7S4g0uS7FhJxiqHetoiO8bO0S6SBwAlkNTmXJI8W5dWemGSugpqCYDDymPe+i
         MRjdohyfjqpw0uk4j3YG+ONaJ3ifQOwYr7PwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY45++CPmrGk/MF8B9SiWWaspjWPnEk5MkiCy4m/ex4=;
        b=UfYDIDMHmRLNQnkE9gezD8+cr06nGBgrfTAGj6pAflxpBWiibYNbyN2zHg22pHAMqs
         td6Q6L+1ckR7lW3dWYpZAiENWX6owMj10iALLQV8WOeXH0wtZ5FtMKkUcbA5yH7LpJul
         rnC9eUE5WYKWOwvZXzvKu7u41U8POVaKRYET5wDppN/UZ8V+Pt+/2L6c9fygZjJRJnes
         pLe+6iOytTiwbonDyM8C3Zxfo8+SUS7rUV+zyh9udsLHtLS9iUp9KXXb3jxr2ozrNXbH
         mwQB6aSRaL+5TbdBuhuhbFf/PlQgri8b4A7VDI/6RVK3KtOFEWINuEceErZb00MjY8Ux
         AhGg==
X-Gm-Message-State: AOAM531RXcVPyRhaaxnQUTGFwZoGQ9mTNEwEiEUc260XfU3LBvgrJMVN
        AEkqIrRydr9eWnD+PADSgtw2qw==
X-Google-Smtp-Source: ABdhPJw3t1ofHpHioLfxUETWA949zS4eZhZP90sS04RJRVAkz1OqRBzZPmwB1DDCT9l36V6NdH/s1A==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr6927634wri.64.1634222103782;
        Thu, 14 Oct 2021 07:35:03 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:35:03 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 9/9] libbpf: use new-style syscall args
Date:   Thu, 14 Oct 2021 15:34:36 +0100
Message-Id: <20211014143436.54470-13-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 tools/lib/bpf/bpf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 7d1741ceaa32..79a9bfe214b0 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -506,15 +506,14 @@ int bpf_map_delete_elem(int fd, const void *key)
 
 int bpf_map_get_next_key(int fd, const void *key, void *next_key)
 {
-	union bpf_attr attr;
-	int ret;
+	struct bpf_map_get_next_key_attr attr = {
+		.map_fd		= fd,
+		.key		= key,
+		.next_key	= next_key,
+	};
 
-	memset(&attr, 0, sizeof(attr));
-	attr.map_fd = fd;
-	attr.key = ptr_to_u64(key);
-	attr.next_key = ptr_to_u64(next_key);
+	int ret = sys_bpf(BPF_MAP_GET_NEXT_KEY, (union bpf_attr *)&attr, sizeof(attr));
 
-	ret = sys_bpf(BPF_MAP_GET_NEXT_KEY, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
-- 
2.30.2

