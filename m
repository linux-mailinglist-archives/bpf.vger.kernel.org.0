Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF75349BFFF
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 01:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiAZANq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 19:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiAZANp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 19:13:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA99C06173B
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 16:13:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a4-20020a5b0ec4000000b00615dc8c1623so7320305ybs.17
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 16:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QFRzZDPnA/0TvQFMVmNO9mTYm/ihfWre/Uu0W1MeXms=;
        b=ZY1auMlwc5qAW4ncj/+it0vmImgSe9uvoKWr/3HAQRLEy1rol47vQzI8LMqnRKX0wB
         true/3FtNnPVrFUEXia4toBVntufoS9YBUiXrxioZ6Gpci77UiJ28SrCGMWLzWXXbjqL
         2TwmzklfeJ7eVyV1aY4JshGnYhjoOSPr8eN7T+SOZ1lG3w9rSrtxEf13ECFrqbUnrsAW
         fFSCsxaWXCoppN5D4r6X6tlC/UeaDpcnBpszIXCKvZNMsJ8wbNIaPzu61Xg/NLNDxyfi
         zRq8WqwSUAS3OZl05fmjU+3Ac/5S4WOiM+tHI2TcNdL+nmXqk3KmtTi5SIbs61Afh3jE
         gHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QFRzZDPnA/0TvQFMVmNO9mTYm/ihfWre/Uu0W1MeXms=;
        b=ljOZIBk+KGdppyOcv0BNXvIWuW4WcGFTpD57kw05niPv0+zdTVYTcOUfrwPsmRhACT
         q9NeFrM+esDbo0OcjdrlAvDD1gnfc2qCq0vM1sjWfyw459FgbgBduWSgb9JV7KCirEzE
         bCAj4G+uZS/ayuq4VCaLRru+DRUpkeig0R8P7X5okHBZdUnVVqv0MFZE2wRSYIJtH5n8
         aSOfn4F7vsGbNsOXs6DSOyt8Y2Q7Zgr3Iy+oD51qeHD8h78l24h8m2g3vQK18mFzsYoW
         plwnG5AWc8W5LRyQhXdmRAGkyhybH7hMWKbSvB6rlMd49vIaHEKSlR4Y8S0Hp660f0pB
         Nxew==
X-Gm-Message-State: AOAM532Z+cyPbKXZ1VNsjCjXmi9QlOo5LZh91/Jige1vwHYmSgJ2wCH6
        othHt9MyLpReR2OlQvAWmDT+rRQ=
X-Google-Smtp-Source: ABdhPJwpfXqF2Fp2WNoXNv2YVpUEUA65IPffUln+t6g8e0uYUSz4NBAmdYIcZ3X6zTz5CbQl1dPLDvo=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f696:cb26:7b81:e8f1])
 (user=sdf job=sendgmr) by 2002:a25:acc1:: with SMTP id x1mr34626697ybd.96.1643156023204;
 Tue, 25 Jan 2022 16:13:43 -0800 (PST)
Date:   Tue, 25 Jan 2022 16:13:40 -0800
Message-Id: <20220126001340.1573649-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH bpf-next v2] bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
breaks loading of some modules when CONFIG_DEBUG_INFO_BTF is not set.
register_btf_kfunc_id_set returns -ENOENT to the callers when
there is no module btf. Let's return 0 (success) instead to let
those modules work in !CONFIG_DEBUG_INFO_BTF cases.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 57f5fd5af2f9..db8d6bb7f29f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6740,8 +6740,19 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 	int ret;
 
 	btf = btf_get_module_btf(kset->owner);
-	if (IS_ERR_OR_NULL(btf))
-		return btf ? PTR_ERR(btf) : -ENOENT;
+	if (!btf) {
+		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
+			return -ENOENT;
+		}
+		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
+			pr_err("missing module BTF, cannot register kfuncs\n");
+			return -ENOENT;
+		}
+		return 0;
+	}
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
 
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
 	ret = btf_populate_kfunc_set(btf, hook, kset);
-- 
2.35.0.rc0.227.g00780c9af4-goog

