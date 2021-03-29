Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA14334DBF1
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 00:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhC2WeQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 18:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhC2Wbq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 18:31:46 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA6C061765
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 15:31:46 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w8so6322251qtk.3
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q8YC7QsT68djr+5X1MBcYOtPJh4z8UQj3GHMhPlwj6U=;
        b=iah82HS24X7ki+RXgfuxNHUXLmyc+TuCsp9oZHppVxCwiTZnDhUBZvV82m5R8LDrTh
         oc9rvXzlZtdHnFStzAOssn2oB6yl2X8ZYXvJFmdYtKAR1a0e9gHoyOLT2Y+JmNhakoRE
         0K+LXFMC1GrSW3H1CqTR80vUhNA4o/qhu4gkc7QbxBhO0PvwJbwkz5YEZSUrxu7jHtVm
         tDOjMbKK4BRQGMYHwocZqL/6IKiiKo2vVDYrBR/oQUwXaLIhHLMHD4Nm0sKjtcatmZ88
         1zRMItQTI1SLDks07kEolUpPgqB9yXFhEOeHqNTQ6aBWFsrz0QBgXgaxCQ9fLC1zK7/e
         UDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q8YC7QsT68djr+5X1MBcYOtPJh4z8UQj3GHMhPlwj6U=;
        b=MSIDXXxUanX0FM+OYmA5TG3d+mdPyj7XT/IUAKbuUREXKxepAzOlmChuldhjL8TErm
         6vBz3GXTsx5ObnOIx92WHm15CUpgOijNgh1CImpqOgbNDvX5VAUg8dJNl+2Cdukqkry5
         lM3MrIRqwlffmD2zp11HJvnfw/V2DQd4q1SfQSoyLmAc0w2TCANBU8UGDTHiLiZMtbCQ
         zKXPBtDSdNJqXkwkIbcGNLu0xC/p/O6mJHWfeSgYFPxaqcDeMNESAQhbY14GGLKlrXHh
         EBYSoqi2Tw4k+1WRYEkkHE6eNUws6k7UhTOowdNJc/fHDadKM5uZ+Hzm83jY0DUofdef
         WWbA==
X-Gm-Message-State: AOAM530UyMtKQU0haEfuLXMsJT9TIEZ0XEuIts+bCL/owaV4AHPqq0XE
        hPo3KvZPhUNEHG2sLhE3s1GIaTc=
X-Google-Smtp-Source: ABdhPJwJYPovPdrVaVUoTstb8My5EfnOOkvSEnX/CQNx4ThkDPXrKKpBt/wwD1tyG0oYyTojvcv8v6A=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:ede7:5698:2814:57c])
 (user=sdf job=sendgmr) by 2002:ad4:528c:: with SMTP id v12mr27335404qvr.54.1617057105299;
 Mon, 29 Mar 2021 15:31:45 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:31:43 -0700
Message-Id: <20210329223143.3659983-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 bpf-next] tools/resolve_btfids: Fix warnings
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* make eprintf static, used only in main.c
* initialize ret in eprintf
* remove unused *tmp

v3:
* remove another err (Song Liu)

v2:
* remove unused 'int err = -1'

Cc: Song Liu <song@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/resolve_btfids/main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 80d966cfcaa1..7550fd9c3188 100644
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
@@ -385,7 +385,7 @@ static int elf_collect(struct object *obj)
 static int symbols_collect(struct object *obj)
 {
 	Elf_Scn *scn = NULL;
-	int n, i, err = 0;
+	int n, i;
 	GElf_Shdr sh;
 	char *name;
 
@@ -402,11 +402,10 @@ static int symbols_collect(struct object *obj)
 	 * Scan symbols and look for the ones starting with
 	 * __BTF_ID__* over .BTF_ids section.
 	 */
-	for (i = 0; !err && i < n; i++) {
-		char *tmp, *prefix;
+	for (i = 0; i < n; i++) {
+		char *prefix;
 		struct btf_id *id;
 		GElf_Sym sym;
-		int err = -1;
 
 		if (!gelf_getsym(obj->efile.symbols, i, &sym))
 			return -1;
-- 
2.31.0.291.g576ba9dcdaf-goog

