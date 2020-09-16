Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9950126C6A2
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 19:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgIPR4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgIPRy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A52C061353
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so7845796wrt.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjCcJGj2jbSvcO5ugPvqsSQEkXN07N/VLAM4UYxhIGc=;
        b=S1hEmV3J3U4bBli9HCtpediHTJQeZMeXfnKQdRHmZEY/HQP+W7nwEWfkznoPdAcFJ7
         hQODci6/8ITecofUEUYgvfmfI8Ib+KKCanr+C/14GRxwT/UIks2+wks7adE/ncfU8DrG
         3IZzGWbLoyTL7uIaQL5bVtcY4qSKvY000ir98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjCcJGj2jbSvcO5ugPvqsSQEkXN07N/VLAM4UYxhIGc=;
        b=j3WkZrghFY5JVt8T5ThNjHRtW65TYW82MeMBAsM2guHKH6lxTZ+fHpu1hfWOjFMT6d
         HE46t4zQsSMVhuJFgeL3XR5BvrCAhKR9+DV7Nj8QgGuNnm7aEASRHlBzFfVuuQ0GF+81
         EDgNtFEZsjBsVZxzRJbAqHXDVVV56jqQWGvdbNVb7BDELlCRZ4y4fxoa4/K2ucL1xQtG
         v/vj5gMpRYLE99pOUkZeOGp6y0oeWEluBu3DJ89FeaHA3/nNwA2qglYBpGYpVQ9oxccn
         djdlG/5ZLo4Yzvg8q2URbG9i/WxndyatT59Pv9TXf85ROpTGFvTgf1zQPTtPpwVIMJwb
         MgAg==
X-Gm-Message-State: AOAM533ercpgBJ4i06aVehXbr88c3Adm2Ub0yaLF9WLmqMk9T5tMyQh9
        lGm8KCJjJtuEx+OJVNC0vReJVg==
X-Google-Smtp-Source: ABdhPJyZUN+1upP2vSmVLzfWockOO2DRrIzP2w1jUTHeGGKKT13dL0I+792nXMojSlkCnGgBBBajZQ==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr30220119wrr.105.1600278822445;
        Wed, 16 Sep 2020 10:53:42 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:41 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 08/11] bpf: set meta->raw_mode for pointers close to use
Date:   Wed, 16 Sep 2020 18:52:52 +0100
Message-Id: <20200916175255.192040-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If we encounter a pointer to memory, we set meta->raw_mode depending
on the type of memory we point at. What isn't obvious is that this
information is only used when the next memory size argument is
encountered.

Move the assignment closer to where it's used, and add a comment that
explains what is going on.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d0f9ba18916..e09eedb30117 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4020,7 +4020,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 type != PTR_TO_RDWR_BUF &&
 			 type != expected_type)
 			goto err_type;
-		meta->raw_mode = arg_type == ARG_PTR_TO_UNINIT_MEM;
 	} else if (arg_type_is_alloc_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_MEM;
 		if (register_is_null(reg) &&
@@ -4109,6 +4108,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
+	} else if (arg_type_is_mem_ptr(arg_type)) {
+		/* The access to this pointer is only checked when we hit the
+		 * next is_mem_size argument below.
+		 */
+		meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MEM);
 	} else if (arg_type_is_mem_size(arg_type)) {
 		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
 
-- 
2.25.1

