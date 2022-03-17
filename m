Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1184DBCCE
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 03:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiCQCEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 22:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiCQCEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 22:04:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67776E0EA
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 19:03:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c11so1550420pgu.11
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 19:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ekTMY6F4h6ArMecy5uGDZFphafSGHBpZ7GuDqFFi9I=;
        b=LKKG5d8gb1tuAm7dti0eAc4/zuJ40c/eRIeOAiwoj+KvIocMbV0uGeltgGhDJSsfrw
         yhE+AfnHKeggizvGKy/JykhzOlL+qXShC1Jy0vJQwY5wWaXHjDowr4oCOkoq10nUM7nr
         XKJhyrgGK3/qvviAIBEuSoD665ns6u0lIUlLf0SHH0bjxZhMTSChbEjRguMe6W92Pr3C
         cSuUtZOuPW7Hs6jZflz94vQTxFXFSfOtzHTtWH3oBwM6HJnLWujTNJpMbtrNDvaVI2mD
         aZpSWbEG4VBrS74grtq55rzNvVP1RxQRMOx3grQ0j0/Gle+7A3UZc/lk4sLd80zMXM7A
         Voeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ekTMY6F4h6ArMecy5uGDZFphafSGHBpZ7GuDqFFi9I=;
        b=wCG+oKagFISyz9LEKLxNCC5Jx5hqgU5uUKgH931hZ48ofnBZ1NlHUHoQMJ9TGofBPh
         KKZFBeIMYDbTiVpyG3ohZ1MdvwiRFn08zYpNqmO9BpgOXIB1I0Kzt/3eUzeCyQZE++Md
         bg0/ZFeLbuzf6N9CfGGC2W6E5FhGc4dblBOV6+e+VQUybgv3QCigW0OICAs6T7lxTt/U
         9Rwm8Zm4N9giZ4pEzwpASC/sAdoMparRQWMos+O/WpP78eB6DAxY9Ojm7nrDh+yhe5KY
         KXBWQ5cvN8OtVs+n3duB7rBJIGXNVDS6js8guRIZ07qGY9Nm8qonNCPyxs/XUhxDoq3W
         N5dQ==
X-Gm-Message-State: AOAM5320k6h8DW1w/qVb0EpHJh3ra7x/KVDZpTpbJMaCvcI1MAzSUq1l
        JuPK7mZoB+bxrnzwLxxWycvPTNvjVmk=
X-Google-Smtp-Source: ABdhPJzciOFJX3iYD161dW/IVU3qhYTT1SpCPQ6r/x2O9/x1lLI5Qrwa/bmLaeiNNzPnTkqXOLnFlw==
X-Received: by 2002:a65:61a2:0:b0:380:caf8:cbb3 with SMTP id i2-20020a6561a2000000b00380caf8cbb3mr1874623pgv.249.1647482602634;
        Wed, 16 Mar 2022 19:03:22 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id m7-20020a056a00080700b004f6ff260c9dsm4909565pfk.154.2022.03.16.19.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 19:03:22 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: Close fd in bpf_object__reuse_map
Date:   Thu, 17 Mar 2022 10:03:01 +0800
Message-Id: <20220317020301.2680432-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pin_fd is dup-ed and assigned in bpf_map__reuse_fd. Close it
after reuse successfully.

Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF objects")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 43161fdd44bb..10ad500f1d6e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4804,6 +4804,7 @@ bpf_object__reuse_map(struct bpf_map *map)
 		close(pin_fd);
 		return err;
 	}
+	close(pin_fd);
 	map->pinned = true;
 	pr_debug("reused pinned map at '%s'\n", map->pin_path);
 
-- 
2.25.1

