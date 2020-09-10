Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412EA264687
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgIJNEu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbgIJM7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A2C06179A
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so6593426wrn.6
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtvnCyDwB1lVP2vStSoy+HHWl1PndciwI2/ThH4w12I=;
        b=q67DdXRUPM1GjQDapEXoRDXdv5hZ+amW+US5cr1BCK9tGcjjskT3ZxdxxrzIp1mQvw
         GfGM8gge+oUevFu2ylKdM1D6rs0GQk86Zghb9C9ow3GqDXM4HQ+VT6WkpxNlQebMmedW
         f4hKvgFlxp2Wg9BviVeGvuCIjV0lEwdk4GlhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtvnCyDwB1lVP2vStSoy+HHWl1PndciwI2/ThH4w12I=;
        b=D3IOVWPK4uI+yBLp2jtc71aHtLEulDaUzIPx1llhgZS3d+3ArWzY24vSFN4S6O4FUg
         ppg8xJhyBK04jrKmJSaDfqqdkP46IHJ3d1AgGFxKi4U3Mk54U/AoHwHxBBii7NnjN265
         rcBWusZR/TnaNEquY7t7KodaNBob4GCSRGhcziuaUdYCE6plRZ5SfCA5KrGeh7AdJkei
         gYcpjPB23aPKhlxPTYhXqnfgkjLtn1FBtBKrDmrMcswOrJ4L9AYVVEi6pUSsz9er6dt9
         Q1r9v2ud1GnUg3C+r6tGSdKT5gkeJMzU3cqRAuody3pUjH0Zw32Gbv95UofTsyGhg6EL
         ARzw==
X-Gm-Message-State: AOAM530MS8vAjgkMhRRoYaVImo2zp+4uh4l1ROTEbdupl1spGfRg2BXu
        O5ln9zWtF9mBxm57MyPJdPkNoFC7gqyN4Q==
X-Google-Smtp-Source: ABdhPJxm49Zb2Ubd32h4AwythwrOW/KDOP5McHI2/s1XdolBJoaiyXg67tdcnPgZiIqr/hhAlDHGTQ==
X-Received: by 2002:adf:e481:: with SMTP id i1mr8750630wrm.391.1599742650823;
        Thu, 10 Sep 2020 05:57:30 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:30 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 07/11] bpf: make context access check generic
Date:   Thu, 10 Sep 2020 13:56:27 +0100
Message-Id: <20200910125631.225188-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Always check context access if the register we're operating on is
PTR_TO_CTX, rather than relying on ARG_PTR_TO_CTX. This allows
simplifying the arg_type checking section of the function.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dc68690fb5f4..b11f1ec31078 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3974,9 +3974,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		      arg_type == ARG_PTR_TO_CTX_OR_NULL)) {
 			if (type != expected_type)
 				goto err_type;
-			err = check_ctx_reg(env, reg, regno);
-			if (err < 0)
-				return err;
 		}
 	} else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
 		expected_type = PTR_TO_SOCK_COMMON;
@@ -4060,6 +4057,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				regno);
 			return -EACCES;
 		}
+	} else if (type == PTR_TO_CTX) {
+		err = check_ctx_reg(env, reg, regno);
+		if (err < 0)
+			return err;
 	}
 
 	if (reg->ref_obj_id) {
-- 
2.25.1

