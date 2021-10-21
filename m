Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237C5436D0C
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhJUVuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 17:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhJUVue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 17:50:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C6C061243
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:48:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w4-20020a1709029a8400b00138e222b06aso813176plp.12
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RQS32lyc5No32gBW187gWaXTPxI3zuq2PbNpjgSQ5IU=;
        b=bDgnObism56zmIvfq4eXMlCb68gvad8CXtslgK0yzrSiRMnfkU+Nj60jVnNC2hBR7+
         7oBq8jo8rj8iVJZuKYhkYd0p9alWOsPRmxe5xtOQx96OibkxwpyIUROqD58tnfMjLRQq
         1LEAv/iF+9gjdoR9914IgQaSGqOuYUtCRcPYi2IQJ3vRGgwuHq/XxJXRVamRKP+VWI44
         z+kGLMVzMuCDCTL8aNbl7Mhs5lpBMn9wLDlZLiHl6lmhrVyL38ZkOpLMmt5wnCOAE1LQ
         6dOf2LZHFWiakDwYLVTB0N5fnfbt5jCu0IRuskY6JHE1mM2ZXZMu2LjIjzUK9aClny38
         6kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RQS32lyc5No32gBW187gWaXTPxI3zuq2PbNpjgSQ5IU=;
        b=uVQZBGIwrD/eN9bzzI5dVgbMQxJ9MMvC9cmSh5xTz9/iy/G6TdWKoaNK8nmdImZO53
         g8Fnj/P86uKQ4Im8TekjTEvRA/KUIdqMhBdBRyCjhcYbtB7sgmMpy3NUlRw1xMz/6GRH
         VfprjnD920q5LqgqmPG1zdVwGr5UqNo4NCnHqIBUBd7vo8PrD1S67/Cj6x6YlHPrJSwu
         qOHZOl1qhDuf2OV1JjrxrQ81eyTzVXH2qkCGgYZva1FTkgrI3oU45yI7WdkwbXC5O7ND
         SyaNIyeuXq8hBNk1u3UQRpGueTLcYyVhcUo9J5Rmcghs7x8GKRdeHWt1L81US7PFW1+H
         /rJw==
X-Gm-Message-State: AOAM533vbyZKd0d30GW7DzPpb5BVD6BBpxmdbOfSHLze1vgxe2b4jQc5
        6TWkJsULyWnN9KDxzhN5PgnQhxI=
X-Google-Smtp-Source: ABdhPJx9ESKfneotpv/mrpiIrb74K+X34Op+pDY0cfFdcsTD5BunVZ0CVq2OZuTfLUwf7UBX7ndtSTo=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:5d22:afc4:e329:550e])
 (user=sdf job=sendgmr) by 2002:aa7:9043:0:b0:44d:13c7:14a5 with SMTP id
 n3-20020aa79043000000b0044d13c714a5mr8279822pfo.86.1634852897970; Thu, 21 Oct
 2021 14:48:17 -0700 (PDT)
Date:   Thu, 21 Oct 2021 14:48:12 -0700
In-Reply-To: <20211021214814.1236114-1-sdf@google.com>
Message-Id: <20211021214814.1236114-2-sdf@google.com>
Mime-Version: 1.0
References: <20211021214814.1236114-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next v5 1/3] libbpf: use func name when pinning programs
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

