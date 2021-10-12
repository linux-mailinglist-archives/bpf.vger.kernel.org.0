Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B560742A92B
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhJLQRy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhJLQRx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 12:17:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54135C061570
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 09:15:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c65-20020a251c44000000b005ba81fe4944so17526874ybc.14
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hQDefVqBcVtNj8blFbQ05wqXANbAMPXIhYV5cVjAGI8=;
        b=dw1Y7/G6iqMUO5jCfpgBW+6BPyR8dTn7LtDDAz4nFL4/h3UPbCCccWyiaR9yz3EsvG
         bIMgUPV8objgiIXcSw0pLSXHL7zVje4wBXoLTaYhlEagXNGx1nUTyVmbzKjr7YLuW3so
         JMUyUe4AFK+Gl2iOMOCLeZ/LfoKvo+vozIRu3xB+VKPV+lmVzgXGlwrxfQTNxGnsGXzO
         RazhKrSnaqz+7uEvHWeAibPLW1A3uweg7SqgBBpw7OaaCd381IWfmt7oj3uKQenZuqbG
         RiMKxDslpNDMP5lXbV/t+BoA9C29GsD1E7+mj6cMhgBBy7x1amHswLlue1GC9uXWzX6Z
         sOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hQDefVqBcVtNj8blFbQ05wqXANbAMPXIhYV5cVjAGI8=;
        b=CzHyhgiwrE++5XFRBFvtPKo7UR7Cub2whpT+uScH6BC9i1kfai/O6oa3Tf6ODrsyRo
         MiCFgf+SOhKmagJ7OBoYlutHTOVNuG5stHpGrHylPTzSUugGvasssi5qKAfQJo28fyWd
         +LFKUx595ibVRjnKLcloHzCtf2aL4AKxsfLn3QnGJIK2e7tNHVySLvUvbmTabiXO/P72
         hZ+o73tA2jyaftHFQIOKm6LNvNB2V8imRE59JQlDEHNZl2hPGBDQokpVi/G/7emUvF4E
         aVE9/NMkyBpP+xq40MjqFwcIjBM3aT+V7oLUo4DYrzwqHyppRzfc5FMM1ClC4DejMV2J
         kFrA==
X-Gm-Message-State: AOAM532zCyt5OmJZ8Ho3SSk6yw6oU2R1QssB5omZP/LiWzmmvH+la6y6
        TtRFZItqDa2uIVjJsoPMRQxZD1U=
X-Google-Smtp-Source: ABdhPJxCaH5ifIWNNqql/POAJ7f7k3GjlWfho4J6GvY5rSlR8PwIZiswsX4q4spEYzprA/1FBnRHPAs=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:4060:335c:dc47:9fc2])
 (user=sdf job=sendgmr) by 2002:a25:e4c7:: with SMTP id b190mr30179861ybh.302.1634055349558;
 Tue, 12 Oct 2021 09:15:49 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:15:42 -0700
In-Reply-To: <20211012161544.660286-1-sdf@google.com>
Message-Id: <20211012161544.660286-2-sdf@google.com>
Mime-Version: 1.0
References: <20211012161544.660286-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH bpf-next v2 1/3] libbpf: use func name when pinning programs
 with LIBBPF_STRICT_SEC_NAME
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We can't use section name anymore because they are not unique
and pinning objects with multiple programs with the same
progtype/secname will fail.

Closes: https://github.com/libbpf/libbpf/issues/273
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae0889bebe32..d1646b32188f 100644
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
@@ -614,7 +614,13 @@ static char *__bpf_program__pin_name(struct bpf_program *prog)
 {
 	char *name, *p;
 
-	name = p = strdup(prog->sec_name);
+	if (libbpf_mode & LIBBPF_STRICT_SEC_NAME)
+		name = strdup(prog->name);
+	else
+		name = strdup(prog->sec_name);
+
+	p = name;
+
 	while ((p = strchr(p, '/')))
 		*p = '_';
 
-- 
2.33.0.882.g93a45727a2-goog

