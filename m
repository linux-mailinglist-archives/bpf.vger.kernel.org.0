Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFCF2A8A66
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 00:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgKEXG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 18:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgKEXG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 18:06:58 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D3BC0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 15:06:56 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so3152873wml.5
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 15:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZO1WsVXcNThD4KNpxonBQj7KL+pDl5MHxmVg0Y0eqsk=;
        b=DPSNFhUnO3TrL+auXDPON8bJqnAVZJk3NA4/IzPO866ApKvFxG170gr/XGkA06KbUR
         jdoc1f3YLQh0g4iRcz0IAROVtVE0jzzqlaPdy+sGQy57TNnKzBywjdCy5TaDOl4KLIrb
         9tpLiwK6/D2r7peDoIgkH4CXXwS4FQI6wnySE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZO1WsVXcNThD4KNpxonBQj7KL+pDl5MHxmVg0Y0eqsk=;
        b=Eb5LIFmnF5cIAS+p/WjvvsKtpNzcjB0g5x4iAoVvJG9L0lyuvT8fzrozAwYlWBgQLy
         vL4FpzOFr21TFtC1G+G51snDrRcjOuLHCbu06i57+rKAyN71qaz8RXsFYvb6f/JbevzK
         zLHbUiQrhxipWsKyEduloJsgqNZ0r3wWBjg/e9vz9/r8U2aDCbL2Eyl76PXvt+HqBzaR
         wF3kIHebQGIO3FSeo+QzgxUeV3/h+m99i+Vu1wT5liKc/l3y89K4r7s1ldJWMs/6p50D
         jCqQlTezRyun8SnJhgk6XBocPZgmMYICfZaOQsEGTOpM9G8sy4PrVm5OtiVSgatXblnP
         MwyA==
X-Gm-Message-State: AOAM533Sqy7V8dJWMVtbQYK84nGFaoUPfn6j0Qch3OXYjAZfifPvgcSB
        Mk0k7aXAVhwSIN+q0EMAtuJc7Q==
X-Google-Smtp-Source: ABdhPJzwfB5dKY+FMn+ZTmEla+9VMAGUjU1ABkMAL1elptfzxKg9dZtudab7qmtdJRd0aH5806SKhw==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr5133188wmf.111.1604617615216;
        Thu, 05 Nov 2020 15:06:55 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id c185sm4473044wma.44.2020.11.05.15.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 15:06:54 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2] bpf: Update verification logic for LSM programs
Date:   Thu,  5 Nov 2020 23:06:51 +0000
Message-Id: <20201105230651.2621917-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The current logic checks if the name of the BTF type passed in
attach_btf_id starts with "bpf_lsm_", this is not sufficient as it also
allows attachment to non-LSM hooks like the very function that performs
this check, i.e. bpf_lsm_verify_prog.

In order to ensure that this verification logic allows attachment to
only LSM hooks, the LSM_HOOK definitions in lsm_hook_defs.h are used to
generate a BTF_ID set. Upon verification, the attach_btf_id of the
program being attached is checked for presence in this set.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/bpf/bpf_lsm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 78ea8a7bd27f..56cc5a915f67 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
+#include <linux/btf_ids.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -26,7 +27,11 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
-#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
+BTF_SET_START(bpf_lsm_hooks)
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+BTF_SET_END(bpf_lsm_hooks)
 
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog)
@@ -37,8 +42,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 		return -EINVAL;
 	}
 
-	if (strncmp(BPF_LSM_SYM_PREFX, prog->aux->attach_func_name,
-		    sizeof(BPF_LSM_SYM_PREFX) - 1)) {
+	if (!btf_id_set_contains(&bpf_lsm_hooks, prog->aux->attach_btf_id)) {
 		bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
 			prog->aux->attach_btf_id, prog->aux->attach_func_name);
 		return -EINVAL;
-- 
2.29.1.341.ge80a0c044ae-goog

