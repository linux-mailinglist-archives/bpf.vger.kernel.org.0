Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053BF436875
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUQ6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhJUQ6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 12:58:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E1CC061348
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 09:56:23 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mj18-20020a17090b369200b001a1d3806b2eso179584pjb.5
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RQS32lyc5No32gBW187gWaXTPxI3zuq2PbNpjgSQ5IU=;
        b=PKOreFF7oNVedTQmLlP8h9Duzpzpm9l0VQ4I/RzPPb0BqogNZvo+XoQ2P8+oru+B6h
         ALRKiSHa4BTt8nfheBx5uUtwNfj49WAOPkl7/LyOnMRPmF+LHJskyraYzxsVhhRGEewk
         reaej6YTQgwRMKWpips2nHoY4pwKMYRpFeMhD3W/k4YZpzzGBSlwp9GdvRiarUzYvZKe
         uMHLCZbnW4JKfXIEbfbErhSxqQSMyYD0XfwsbUzIhIXNNAiFPzRkkI5K+eh3fLAx4plg
         I7or+nl9iQtY8Zdvq3Mwi9jiZUmz7y+d6cZ5iAtX5lpXpPSr3VdaosVUrV6+uOLtvM/7
         R7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RQS32lyc5No32gBW187gWaXTPxI3zuq2PbNpjgSQ5IU=;
        b=KykPwqOUfqdum+5phKZipqbw4a4VlCDSTm0jRUtU6KEQn63LaCeCIkinaTkY2LfbU2
         Rf8hosJvR671VY1ooFfAg6WmDD+75QMyF+sROdASRznRNfcemFhubXRG8I9qgnnkoiS6
         XcTyZiIWewR//8oq8bsj/8cdxzp/Ac2g4+BViIorpy9vCDHpudmbraa+D0R6Zb3rawDG
         lWqBAJcTtzVaBKoplVDnCxIS0AbwU79JMcUYKQo4uRGhY76lgkdeUfuY0DW7GaN/hH0v
         8Myp0XR4p0XUAktW6VhwfWfpVZicp56Gf82oa6Vz1EPChwTtO5zzqboqXCBDY5GAeVJS
         pKkA==
X-Gm-Message-State: AOAM533CTlxKn6pcWt0DgA94V+1WlOECcCNMrmlKD5pCanCkBDx/GIzd
        sC3+dj/JjNdLqFzJAZQtkxRdKA0=
X-Google-Smtp-Source: ABdhPJxOMMtuKk98wITPsj313cSZkNG1SToRUMNTJ8bYgrnhm5tbDb399SEFeLQRISyZczkJyJYRY18=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:5d22:afc4:e329:550e])
 (user=sdf job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr32842pjh.1.1634835382380; Thu, 21 Oct 2021 09:56:22 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:56:16 -0700
In-Reply-To: <20211021165618.178352-1-sdf@google.com>
Message-Id: <20211021165618.178352-2-sdf@google.com>
Mime-Version: 1.0
References: <20211021165618.178352-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next v4 1/3] libbpf: use func name when pinning programs
 with LIBBPF_STRICT_SEC_NAME
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We can't use section name anymore because they are not unique
and pinning objects with multiple programs with the same
progtype/secname will fail.

Closes: https://github.com/libbpf/libbpf/issues/273
Fixes: 33a2c75c55e2 ("libbpf: add internal pin_name")
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c        | 13 +++++++++++--
 tools/lib/bpf/libbpf_legacy.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 760c7e346603..7f48eeb3ca82 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -285,7 +285,7 @@ struct bpf_program {
 	size_t sub_insn_off;
 
 	char *name;
-	/* sec_name with / replaced by _; makes recursive pinning
+	/* name with / replaced by _; makes recursive pinning
 	 * in bpf_object__pin_programs easier
 	 */
 	char *pin_name;
@@ -614,7 +614,16 @@ static char *__bpf_program__pin_name(struct bpf_program *prog)
 {
 	char *name, *p;
 
-	name = p = strdup(prog->sec_name);
+	if (libbpf_mode & LIBBPF_STRICT_SEC_NAME)
+		name = strdup(prog->name);
+	else
+		name = strdup(prog->sec_name);
+
+	if (!name)
+		return NULL;
+
+	p = name;
+
 	while ((p = strchr(p, '/')))
 		*p = '_';
 
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index 74e6f860f703..29ccafab11a8 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -52,6 +52,9 @@ enum libbpf_strict_mode {
 	 * allowed, with LIBBPF_STRICT_SEC_PREFIX this will become
 	 * unrecognized by libbpf and would have to be just SEC("xdp") and
 	 * SEC("xdp") and SEC("perf_event").
+	 *
+	 * Note, in this mode the program pin path will be based on the
+	 * function name instead of section name.
 	 */
 	LIBBPF_STRICT_SEC_NAME = 0x04,
 
-- 
2.33.0.1079.g6e70778dc9-goog

