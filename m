Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386EF25D747
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgIDL3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38654C0611E0
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so6332418wrl.12
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owpNQQ+uIJCQXVSt0+1sgwOe70+wghAb9TxeyhOSzdA=;
        b=LQLaK3E4hhgF0sqaa0xcxlqC4hcBE8zEPudcwELM/WbxI905d8LURtEJjAXPqG+q47
         b6yOTtoRGYqonMVvHroDJW+iavdF/IQ8n4XQqHeu/AxzXXyJalJAPvrl1UZYCkzGPl+X
         1nZgnwHgh0euMJFvEWXHynGxVt4J43Rq2eizo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owpNQQ+uIJCQXVSt0+1sgwOe70+wghAb9TxeyhOSzdA=;
        b=Myn5anc0nb37YB3nV03FwavCMOMU5PL8MHcRjYO7J/hHbay0mCAb/lmHQuj+6iCDO+
         Tmpk3gmT+2/S7Am0ZVff5ZQsHIy1imCYf3M0Rjyn63maxRPzXOoSbdb0pV2RdTnj7Rof
         YzW8N2KAAlNTuD1c1nGAmuYxCsbJqs6axnFHorK5lLkHfi5zBLXchiuwtenvRkheYQdH
         gMbIN698CqBP0QXld7BIUHZpwGOAoyLJ31V4ZymRj/5jqUsOmb48GDTD6I2bymNYFjdR
         Oz0Guq/tw5iJzqY9c6OoynSYX6hJMe/stVosGeorzEmrIisAzb/wb3oandP6PuMcVTgM
         w5oQ==
X-Gm-Message-State: AOAM532spqdVlRaQaffxEHa+sEITU9diNh7+DK6Ngn8Z6odtQrBhuWrn
        N5d4xysYALMJywyHSzVKQBeeMQ==
X-Google-Smtp-Source: ABdhPJyRYozlZl96pAlyrtGQZ0j5cFKkqb1QRVHAHa/ObAd1annJ6d+ETPAwRDlJQ5te7Eb7L37ccA==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr7121008wra.21.1599218655945;
        Fri, 04 Sep 2020 04:24:15 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:15 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 03/11] btf: make btf_set_contains take a const pointer
Date:   Fri,  4 Sep 2020 12:23:53 +0100
Message-Id: <20200904112401.667645-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bsearch doesn't modify the contents of the array, so we can take a const pointer.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c6d9f2c444f4..6b72cdf52ebc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1900,6 +1900,6 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
 struct btf_id_set;
-bool btf_id_set_contains(struct btf_id_set *set, u32 id);
+bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f9ac6935ab3c..a2330f6fe2e6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4772,7 +4772,7 @@ static int btf_id_cmp_func(const void *a, const void *b)
 	return *pa - *pb;
 }
 
-bool btf_id_set_contains(struct btf_id_set *set, u32 id)
+bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 {
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
-- 
2.25.1

