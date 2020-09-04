Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7A25D745
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgIDL3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49054C0619C5
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so5718509wmh.4
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55VGPuW8E1FFOJXYmazHOmmDWGJoPY4/0mNdm6zV/ZQ=;
        b=KnR2n4I0ZBE+/DEJ0TXHS9GIUnsm5gt1Lwpi1BBrWqg9RRQFefOGWueZJScxPHyhpe
         M/EZuVKnY785pXOfSlHppv3hcy0BxqOi9zaiM/vjHsJ6oLgEhLxfo/08l5P5THlrZfYU
         V4KKV0GlYkQxYGcKUfB0C3UD9A2S+jlYBoOUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55VGPuW8E1FFOJXYmazHOmmDWGJoPY4/0mNdm6zV/ZQ=;
        b=mQi5Sx2JCggPNMkoAfDOsh1wvzeNyN+HDggyUXgp0pGFpFTusailszK40bfgH1/iwh
         dJZLL6mmiGYGzDzUCUYyNbhv6bgyXvriqgKOkZ4ypn7E5WGHKS6Ys1jxufsYawRRti67
         Iy26cnm3Edp38V3/33qmE7SIdOhpM3yKUaI8/v2YCxLXO26uPmIbuvPcEZ3WgAvCKl3L
         ZX7fH1jHoltHb5ul89FDEIaXzzW5ZpzbYwlnnzbl0p548hiBeaYoTDAUz+xXvr0w5AMh
         P+FJy5CYU10AZMgMSNVE4/ycmqAxAwAPLnvNPS0banWmAhDxjYTxLrvk9lX1fKQIKUwn
         Zi2Q==
X-Gm-Message-State: AOAM5300Plykx0jPo8IrLulADi1L1cW8/5GpWHfb4qZEYg+zpB1L8jns
        0t17QKhAAZ+CgU+mjSNdnhiTGudHR1LpFg==
X-Google-Smtp-Source: ABdhPJzUS5ogQZmPtTU0+pOrqs/97OQzVwfd6J2wgxTDd9aLgq4Rf9gi12qss+/erQ76heEc3EmRXg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr6889037wmk.47.1599218660995;
        Fri, 04 Sep 2020 04:24:20 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:20 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 07/11] bpf: always check access to PTR_TO_CTX regardless of arg_type
Date:   Fri,  4 Sep 2020 12:23:57 +0100
Message-Id: <20200904112401.667645-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Always check context access if the register we're operating on is
PTR_TO_CTX, rather than relying on ARG_PTR_TO_CTX.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7df4ccad8e2..ba710a702cae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3979,9 +3979,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		      arg_type == ARG_PTR_TO_CTX_OR_NULL)) {
 			if (type != expected_type)
 				goto err_type;
-			err = check_ctx_reg(env, reg, regno);
-			if (err < 0)
-				return err;
 		}
 	} else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
 		expected_type = PTR_TO_SOCK_COMMON;
@@ -4081,6 +4078,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->ref_obj_id = reg->ref_obj_id;
 	}
 
+	if (type == PTR_TO_CTX) {
+		err = check_ctx_reg(env, reg, regno);
+		if (err < 0)
+			return err;
+	}
+
 	if (arg_type == ARG_CONST_MAP_PTR) {
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
 		meta->map_ptr = reg->map_ptr;
-- 
2.25.1

