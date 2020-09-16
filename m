Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC01726C693
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgIPRzP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgIPRyY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B44C061352
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so3603405wmd.5
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8mI6GHH25/RwxEPJ9d1rEplqdAhaWXBqgldUo4yRSY=;
        b=gBCJeE4vrJsXEBfkRw/rabs5lnwY+u54iy9i4lM7+6nrNw1zUJmSEqlLbA5gqa3ZPh
         T48PU+T7XC6GZhyDnEPO2y9Ny1kNfAk+58XHfarKNW82cu/NGllTV9KlUNyJcnhShJ0R
         DFLyMYpOjdVZaAUNWh/kFNa/1Xzg1OSrfs+PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8mI6GHH25/RwxEPJ9d1rEplqdAhaWXBqgldUo4yRSY=;
        b=McNvTQm7rYU6w2lS1WzILYwpRwh9Tlf877wizTvqlg6k+haLSC9xYG5FbX2YxW5GuY
         QUCgEI2CdQKQpm33tK6anap3I9oK95OOtNMmWtmLlsVq5Hr//cy/KwRfEn3jx1mZYkGK
         Ut0LyYPpVqpDlT0I3bfjfIbCdNrsJU9dDVIEPcKlh8a1rkz7va0dWRQQXIdG/FNco0Hu
         xu8o8O6fD4SowGSMjxAS9DcxNNwnDa0l2+ECAt3bcxZpBoVXkZt0neWh5K8EOtXXQa0r
         S4KUNxEwJuebEF3YcXlf3CnvuAQg/7uT8OnfTZ671Kk5gpPQxA5dyy2g7NAqIqLQco2t
         Jn2A==
X-Gm-Message-State: AOAM532nxEFDYXM6H2eYPY42vV5LZnApGyZlhtgNsrvEOp6Gq85y4tgG
        ys37U5LvFKn5NnZSsTDlw7BjiLF3kA37lw==
X-Google-Smtp-Source: ABdhPJxbStD54h3oFN985Mh5OtwGfwuNox24GGS/4eURigAq+8uygKTeEN5zIvMEkieMZ+UpPj6PcQ==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr6322189wmu.73.1600278820859;
        Wed, 16 Sep 2020 10:53:40 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:39 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 07/11] bpf: make context access check generic
Date:   Wed, 16 Sep 2020 18:52:51 +0100
Message-Id: <20200916175255.192040-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
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
index 0f7a9c65db5c..7d0f9ba18916 100644
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

