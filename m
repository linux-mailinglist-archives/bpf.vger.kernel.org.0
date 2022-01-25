Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023A849A8B4
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 05:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380788AbiAYDK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 22:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415460AbiAYBqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 20:46:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F691C06179A
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 16:38:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e130-20020a255088000000b006126feb051eso38352201ybb.18
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 16:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AE42NXyGuF++OsviAYaBM/aTmpTPsKa7gHXSQEZykMk=;
        b=epqnPUKasiEtVVChbxwzoIKZvsEye6JpyuSU3+3TTjN6k+SwW/3ePaZzTsoMMIKl7a
         smbzhVEuKtL+O7FpT8UhKnSYwfd2IOxl5sQYEMIdtPqj7GR6EETLVOzJ+id/rbL5cfpX
         +0PWD4TSsL5dXEXsG2q/jLVwx6WbZ6UawAQzhFOekBDUfUEl93AexIEJPqkfeZi/a168
         tYGCif8PANqr6Tjf/cYay9ZjfFjeKDzh7mvGHozh6UEHXYGV5bvrZgj9FqXd2n+RvH48
         xqeiQzjWSnO0tD2GpNkb+bUYmxSBXLfZjJB/bu6GeeR/R6Jz69TU9+2Cn1xUj1BmTMnf
         XlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AE42NXyGuF++OsviAYaBM/aTmpTPsKa7gHXSQEZykMk=;
        b=2SFPMtg9DE8kYP9CfMeRT2HN5BL7AD+ixlYLigxIVXQCRfuev0+sB0eIUippILNTUA
         jXJKse0GhGDDAnIMR7GYN3J0RkedZjs/QFR8gXnzOsss0RTDUBdEf+er0LA7GonYnjzQ
         Olg8ko8Vi/aKPQBrp5xlTNHpWYrbPAHN7+mnUnAuU4OQlT2NqQgwzEIhMmSd5cY/KJhX
         y+jqh9jwWOlXvq/kTLAc8n2DibAIcNHHegQxAkPRiEkBvE1T7o9KQgmKQ0R2peNBrwrz
         esTyZ0iJLa1jyjds71XOheiqtyLRzS6/jssgRYvmWv4bpql+zW6pPVUC4JHHvVNi0v3r
         tw7w==
X-Gm-Message-State: AOAM532QA3QHmMWe6IJ9C39DZitPTCakYAoAqd74DhZggo4PVkSYv/Ep
        YXSnPD4uUByHvyThPro6cTGgdlo=
X-Google-Smtp-Source: ABdhPJygJaFOA7hjd6Q/A1ZwXd9SVSFn5POPN1pc7ztOjwG/0r9GVBFJUKADFz0f7LuhzSjy+h+j+XA=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:2b4e:2e9:6635:b685])
 (user=sdf job=sendgmr) by 2002:a0d:d701:0:b0:2ca:287c:6bb4 with SMTP id
 00721157ae682-2ca287c6e03mr2441197b3.89.1643071128462; Mon, 24 Jan 2022
 16:38:48 -0800 (PST)
Date:   Mon, 24 Jan 2022 16:38:45 -0800
Message-Id: <20220125003845.2857801-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH bpf-next] bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF
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

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 57f5fd5af2f9..24205c2d4f7e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6741,7 +6741,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 
 	btf = btf_get_module_btf(kset->owner);
 	if (IS_ERR_OR_NULL(btf))
-		return btf ? PTR_ERR(btf) : -ENOENT;
+		return btf ? PTR_ERR(btf) : 0;
 
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
 	ret = btf_populate_kfunc_set(btf, hook, kset);
-- 
2.35.0.rc0.227.g00780c9af4-goog

