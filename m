Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3EB34D4E3
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 18:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhC2QYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhC2QYT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED4FC061756
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 09:24:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c17so1295526ybs.0
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eHOx3PCFf++2TSEv++5lGe2LoVcdpp0PLZ4xmLu3+uk=;
        b=FQSBKm1Jb+H2p/xGU3x0uOjxbJi9p3gjYaU1keQmNPQdFOQIEIUoAAUnUlBgEkpPt3
         pR7Sk6mlltIVgv0Dp+x6TwJYLhM3bfnnYcT3edZ6MKRZRJhdgMgLQkWzmtbBbh8PcG5g
         wcdE4sBqy5kin2zKtwGfbBZl4mNxtg/pp9WDuo3L/97Znuw9jy9k+02MczY2SOqfOzFA
         IfVon68tMH0CXT55RzUL8vce1lroIcvsMpIaCacpTsADPam86y3qj8hRIRo4h0QgA3ho
         35GMgNXUMt/itrtjn6RERbRCCalxpMkwDZgtzMW2wT3fzAUcmPRhSGHzj2J+n46rI0r8
         AHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eHOx3PCFf++2TSEv++5lGe2LoVcdpp0PLZ4xmLu3+uk=;
        b=LNylLnhTnxf+h9aVODsNXKYYjTwou0oFKFAHY3XDXf4i8fqatLB3GYrHmKopWhDbIV
         To1n5/NVLf/1WNjWLUGvcwqkAqjOVUetef2ksgsOBTeABtYQydwjzUFXqIthBATt4i4x
         rP79C6wdwJ/hEl7xRp4YfyZ0rIXgQ32ANaV/eQ4o1Z1AI6vi/vhVHExKF1auLkC0qZut
         fXDwutCH4dYmr+Lyyw0tiNif51YyPjHI3zqIerb8NheeV6sCqU94n0zZ3pXyvpSI7Ovr
         8Bzyi2gcmd56e9ul381mttKJu5CukEOfGADTPAVl2oAXIMdhC62onAySUT3P1GIJx9GJ
         c91w==
X-Gm-Message-State: AOAM533L1YtHpAGXP7hhwWZHPDoOTU9MB5he4PmYkdPUyQTInRTYvKED
        s7p2p6QZHcX48ore83dnajOZ2NQ=
X-Google-Smtp-Source: ABdhPJzI8CwSR+idKXKEWu0e2tOX9ZohLD4wRBk/vochX9KSQcieruWh7BkCECh2AJ65kO3FZI2x1Ck=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:ede7:5698:2814:57c])
 (user=sdf job=sendgmr) by 2002:a25:188b:: with SMTP id 133mr38770810yby.65.1617035058589;
 Mon, 29 Mar 2021 09:24:18 -0700 (PDT)
Date:   Mon, 29 Mar 2021 09:24:16 -0700
Message-Id: <20210329162416.2712509-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH bpf-next] tools/resolve_btfids: Fix warnings
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* make eprintf static, used only in main.c
* initialize ret in eprintf
* remove unused *tmp

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/resolve_btfids/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 80d966cfcaa1..a650422f7430 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -115,10 +115,10 @@ struct object {
 
 static int verbose;
 
-int eprintf(int level, int var, const char *fmt, ...)
+static int eprintf(int level, int var, const char *fmt, ...)
 {
 	va_list args;
-	int ret;
+	int ret = 0;
 
 	if (var >= level) {
 		va_start(args, fmt);
@@ -403,7 +403,7 @@ static int symbols_collect(struct object *obj)
 	 * __BTF_ID__* over .BTF_ids section.
 	 */
 	for (i = 0; !err && i < n; i++) {
-		char *tmp, *prefix;
+		char *prefix;
 		struct btf_id *id;
 		GElf_Sym sym;
 		int err = -1;
-- 
2.31.0.291.g576ba9dcdaf-goog

