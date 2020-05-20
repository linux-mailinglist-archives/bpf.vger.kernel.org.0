Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00161DB441
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETM4Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgETM4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 08:56:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C0C061A0E
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 05:56:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so3011270wrt.9
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRf0IXb8hQkrdaL1fqV3l4f1s2bF25mDJk/8LzKBDyk=;
        b=FcM3iKpmGOIcheIq2sv7UBjccYXgY5UfnFjB4xNjwyYn/tsB62nOO1DlESb5YDOJW0
         sqFXADpYAoyt8FhrnVZr8S0nV8jXbRhFgVllGSXhkdtwDwjB2N1piQYgke2bBl7yz4Cu
         VYa9mPs5vM6n6ad8Zc7RtsTFPTTusIOL3Oj7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRf0IXb8hQkrdaL1fqV3l4f1s2bF25mDJk/8LzKBDyk=;
        b=G/JBR3O9HSN2NQIUFXateLJco+Wp/rlrTZ+zmQ+XPRG6mSYlbTmtFi7MCjBYUOpNJt
         gfC4qrNEooZn48iUZLAbL2jSrpINE+IV1Hp36+/ms/GbKqmpx9AtHU6MK9ZEtTxwfBtk
         SbhNBTTcYi/+HT4TTJr9yZ9GTEX2TbapgZzQcgIqi2DSqf6sXKWuXMGsQrTtrOwy5gZt
         X6g/2aRcZ2QUGUrIE0apkasQmntCyNKUYgwMtq7kA+hTIxPqL1uQrTOaI6HxH/7KM7sE
         UXEZzT/2r5uiJGqX3QmgM8Kv2O+C96N1O21KRk9of6BeIxiUSAPYzaZl/dD97WXjZjwT
         pKwg==
X-Gm-Message-State: AOAM530eCmCrcUOhkQW32iPKPuCfOMpR71iRwemsDqTT1z8wN7m23Eaz
        5dZ7WIBYttk2jlbNVdFgfnMFbQ==
X-Google-Smtp-Source: ABdhPJzZTIkt68m48X0Gd2mSWXMTScvuAo6k7MEMXpKVIa3O8ND+TYDMoHIr5dtTngUw3l1H6DOPPg==
X-Received: by 2002:adf:e703:: with SMTP id c3mr4169330wrm.252.1589979382402;
        Wed, 20 May 2020 05:56:22 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id i11sm2961978wrc.35.2020.05.20.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 05:56:21 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
Date:   Wed, 20 May 2020 14:56:16 +0200
Message-Id: <20200520125616.193765-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

secid_to_secctx is not stackable, and since the BPF LSM registers this
hook by default, the call_int_hook logic is not suitable which
"bails-on-fail" and casues issues when other LSMs register this hook and
eventually breaks Audit.

In order to fix this, directly iterate over the security hooks instead
of using call_int_hook as suggested in:

https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/security.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index 7fed24b9d57e..51de970fbb1e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1965,8 +1965,20 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
-				seclen);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Currently, only one LSM can implement secid_to_secctx (i.e this
+	 * LSM hook is not "stackable").
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
+		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(secid_to_secctx);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-- 
2.26.2.761.g0e0b3e54be-goog

