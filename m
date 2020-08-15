Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05052454A9
	for <lists+bpf@lfdr.de>; Sun, 16 Aug 2020 00:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHOWfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Aug 2020 18:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgHOWfm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Aug 2020 18:35:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E458EC0045AF
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2020 12:56:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so10670884wmi.3
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2020 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0mMsAj1lSg7GPakykMGfErTBU0jbBblfsVFAwkyqoI=;
        b=JWgLDpRJOQdreIa6erqF9on6PoOKWMe4C4kAIslshQY2P6XBu+zMxwj5+5Pq7ibxRR
         SCxogfrkQchs31XL0LcGTcAtN5KKQ8eaZ3bzOW+PdATxjPY4JfTRq2kBqXwl+obf5Kbj
         5kIS8mKnY73yGnISKihXErf9iGt0zDf7hS09LODpQQqrz4QZXnvGoPUOF8LC9hjrqgBT
         kUOTNsx75eQa3xk2an9zE4Hx+dZ6b8JdBcpWKvM8QiNjV6sgWNX0J7XLzUXs9lrpkn8V
         LrY3kZ8fEDJSCyp8LQgNrkuJ/V2DQLFjJLtcPncaTK3qYHZMVbz4hYd3n41X83pUKL3p
         u4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0mMsAj1lSg7GPakykMGfErTBU0jbBblfsVFAwkyqoI=;
        b=I51OREIeXphEFfivWmkbVzeXunfBjktKNkhryc5l2YqKSXZOIAA3jQXymn61cBeJ/y
         QiUvh14PWw3+ktnQMqL7ybj5NnctEp0c4pLnpfWpJi2qlE/3zPbnu4yPPDjSyMW/0wVY
         TxQu0TDQnLCnUJgoX7TvrVvIqT7abkFvp6KoSRYmrO8hBDpjRRPE0n2qy2noFnerWXZU
         1bv/q27Igk5a8g+AtpD2kthXtX7Z0u7p7hDbOTEvFbKxqjW4UAfb+xSYbZrnNUK/yS69
         CfNO8nODDkzb6gyOeW1fcHuaKvvi7JK3lBOjTcoDbkW4fsGOtOB7DArTAyKO69MwIN0B
         g3Zw==
X-Gm-Message-State: AOAM5329zeLTwUPB5RzS5agQ328QL8xTUismvlvs42mqH+SmNItypDMt
        gt+Ar/C/ExzEa2x5Z9RyOtI=
X-Google-Smtp-Source: ABdhPJx9eYcWqBbHzgl3Sw6w1sCNQj10inTTVZNohRHnSePiZjLNQp3RPjVZtQlAcuMRRMJ9jJ775Q==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr8366526wmj.66.1597521395675;
        Sat, 15 Aug 2020 12:56:35 -0700 (PDT)
Received: from localhost.localdomain (bzq-109-67-21-91.red.bezeqint.net. [109.67.21.91])
        by smtp.googlemail.com with ESMTPSA id y142sm24168521wmd.3.2020.08.15.12.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 12:56:35 -0700 (PDT)
From:   Lior Ribak <liorribak@gmail.com>
To:     Lior Ribak <liorribak@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: [PATCH] samples/bpf: Support both enter and exit kprobes in helper
Date:   Sat, 15 Aug 2020 12:56:27 -0700
Message-Id: <20200815195627.305064-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, in bpf_load.c, the function write_kprobe_events sets
the function name to probe as the probe name.
Even though it's valid to set one kprobe on enter and another on exit,
bpf_load.c won't handle it, and will return an error 'File exists'.

Add a prefix to the event name to indicate if it's on enter or exit,
so both an enter and an exit kprobes can be attached.

Signed-off-by: Lior Ribak <liorribak@gmail.com>
---
 samples/bpf/bpf_load.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index c5ad528f046e..69102358e91a 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -184,18 +184,24 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 
 #ifdef __x86_64__
 		if (strncmp(event, "sys_", 4) == 0) {
-			snprintf(buf, sizeof(buf), "%c:__x64_%s __x64_%s",
-				is_kprobe ? 'p' : 'r', event, event);
+			if (is_kprobe)
+				event_prefix = "__x64_enter_";
+			else
+				event_prefix = "__x64_exit_";
+			snprintf(buf, sizeof(buf), "%c:%s%s __x64_%s",
+				is_kprobe ? 'p' : 'r', event_prefix, event, event);
 			err = write_kprobe_events(buf);
-			if (err >= 0) {
+			if (err >= 0)
 				need_normal_check = false;
-				event_prefix = "__x64_";
-			}
 		}
 #endif
 		if (need_normal_check) {
-			snprintf(buf, sizeof(buf), "%c:%s %s",
-				is_kprobe ? 'p' : 'r', event, event);
+			if (is_kprobe)
+				event_prefix = "enter_";
+			else
+				event_prefix = "exit_";
+			snprintf(buf, sizeof(buf), "%c:%s%s %s",
+				is_kprobe ? 'p' : 'r', event_prefix, event, event);
 			err = write_kprobe_events(buf);
 			if (err < 0) {
 				printf("failed to create kprobe '%s' error '%s'\n",
-- 
2.25.1

