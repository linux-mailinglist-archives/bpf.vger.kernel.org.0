Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93559571087
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 04:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiGLC57 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLC56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 22:57:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F5F2B600
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 19:57:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso6645722pjk.3
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 19:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWnDkySDYP4SdpuFv/hytec7Q9XjXfbzhoKgSrQMZLI=;
        b=TgIbBmmrP3b0Jg1PA2nT1OXlEPfq5VwzPm5qlJX8YWATQrMSfoAqUmJFXf4wEmu/uo
         0o/0gBe3Np4Bp3lLpHaVjqoYKTN4BfmPT2Zn6dQxtxYoTLCxUT6WJXVblAlYWviF05ni
         MwNxPVgCUwkhc8N5fo7Bf4ZyuTemgu7rfy4DUZ3PF7TZ71cea2wxMJQ6amS1JWi1aJpp
         +cznT4uO3reVWZE+5aVxefP6faRLmn1/6s0fQG3ImUB7Hrh+lgi4nH0v7CI5i6jMwfZU
         sQlAqlOVy6cawCGzp5a0yiRKbCLa1b6JdF2ZD/TS/AYBPmJH/iXW6Z46FK2x8OWlPd9k
         SinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWnDkySDYP4SdpuFv/hytec7Q9XjXfbzhoKgSrQMZLI=;
        b=FIXnhu7thfssitnXbDxnO4wo3CK6UWzL7HJ4vFbTNzAuabkfuTrmSfy7pVKNM+52Gi
         QKxNZb4wdV94lOOHuNOlTowQyAv6bAgQYjslESvsJTTuO9UUUoZoVIoePzQ68ujTDROn
         mInAQWMGBuq9BcVNGKGYMgN8WDnMoBfYRQ/1Xc9YSRKBB7zM2yl7I6DXQcgnFcNl3kPv
         iKr59Qt6hw2NOECFpI9fzPaijhxtYozXCkm0KJf7xWJnIx3CIb0irvr1vQ8JUXcLSOMm
         A21ivHopCRsh6XXSkUaGhetWC5nUMRDLVRe0pPfRoh+YI0wqY+kKn9cucODja4cKJNxK
         hkyw==
X-Gm-Message-State: AJIora9U2oDRhL+LJAERRDXtxt0wyJGlj/oWux2CX7EyBuy6JOos9rC2
        rmIbu3T1HCH3Vo/e7U7zmkolLboNST8=
X-Google-Smtp-Source: AGRyM1tZ81hpj+p6TKZMKeQtbpODMC/zPWi31/Bvs5QyRzbkdu5eAZZvLAl8r35UblNoXEaa5wugRw==
X-Received: by 2002:a17:902:d707:b0:16b:e35e:abd4 with SMTP id w7-20020a170902d70700b0016be35eabd4mr21068287ply.111.1657594677512;
        Mon, 11 Jul 2022 19:57:57 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902ea1200b00162529828aesm5480039plg.109.2022.07.11.19.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:57:57 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: Error out when binary_path is NULL for uprobe and USDT
Date:   Tue, 12 Jul 2022 10:57:45 +0800
Message-Id: <20220712025745.2703995-1-hengqi.chen@gmail.com>
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

binary_path is a required non-null parameter for bpf_program__attach_usdt
and bpf_program__attach_uprobe_opts. Check it against NULL to prevent
coredump on strchr.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb49408eb298..72548798126b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10545,7 +10545,10 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);

-	if (binary_path && !strchr(binary_path, '/')) {
+	if (!binary_path)
+		return libbpf_err_ptr(-EINVAL);
+
+	if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, full_binary_path,
 					sizeof(full_binary_path));
 		if (err) {
@@ -10559,11 +10562,6 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (func_name) {
 		long sym_off;

-		if (!binary_path) {
-			pr_warn("prog '%s': name-based attach requires binary_path\n",
-				prog->name);
-			return libbpf_err_ptr(-EINVAL);
-		}
 		sym_off = elf_find_func_offset(binary_path, func_name);
 		if (sym_off < 0)
 			return libbpf_err_ptr(sym_off);
@@ -10711,6 +10709,9 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 	}

+	if (!binary_path)
+		return libbpf_err_ptr(-EINVAL);
+
 	if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
 		if (err) {
--
2.30.2
