Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1082633F6
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIRMr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbgIIRMO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928D1C061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so3037467wmi.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJ6Ia/nxwA6IFCDwNi/FcI78++T9H2DA89f3kqeHTi8=;
        b=AFC1NngdJPQbZFbnfqYA0nKW+IoHt0mutOMGaxPTHWh4BSCwrEPWeBgu54q4ZHWklx
         Fa4+kZTAdJS+HDFySJyjbKddeQp2LDcvBE0IHhK/49ZgrWhum/uDQOiFZMXDevArafNi
         4ImBHEQH41409n54Aq12z8wETG9K2z1PFKEJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJ6Ia/nxwA6IFCDwNi/FcI78++T9H2DA89f3kqeHTi8=;
        b=NiVNG+g4mDVF3OE/2A0ycQE3KxFJGa+ZmEbSJKHT+Zg9ot8ffy5UehWKmQOruoqNwN
         4ZJ2gfmr3VkMkPxo1AD5yvo0Q2L7s68TEAG1zyrALIMX4qt+2JYl2K2wqAoGpwjLY5On
         +uRk89loC4aTWR9qHIkgwKbKBncUk+h2tl/+wQJ+7yKsmSzuEIbQI9x3uFtFPlPJWm4q
         c22BuCEgiItZM1tfwOla2vXpLCSZ2PTZLu1dMR9GznOkxkd+b4WEMtsDhGy/dFzsEf8w
         xm/0AL1rqmHacvBA6j8ikhbQBZR7eAEqf1jh02s/daQqxR5R4S6orrgSR5+AE54FPLCr
         8lYQ==
X-Gm-Message-State: AOAM532VfaHyGufy/8/4VfRSo4PiVXTeGPyoqEE5ONiqmi/0cwQP+pMM
        H/8DLQZkqYjag5s9FKJgxHSzd0f1jnlkew==
X-Google-Smtp-Source: ABdhPJxbQe8FzzMP65dbBrhvn8J3vFHS1YfOkCggC2limewO0xil9v1QVeeg192+YarelA6sDa4A1w==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr4354888wmj.138.1599671532276;
        Wed, 09 Sep 2020 10:12:12 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:11 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 08/11] bpf: set meta->raw_mode for pointers close to use
Date:   Wed,  9 Sep 2020 18:11:52 +0100
Message-Id: <20200909171155.256601-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
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
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41643e179e14..e0ab3b8c489d 100644
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

