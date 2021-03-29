Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542334D55C
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC2Qpv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2Qpo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 12:45:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C85C061574
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 09:45:44 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p24so11392585pff.8
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oAB+Nl4FFFMz/nqI5DhEiAQ9QgS+G5IVSXiy+W8aIAs=;
        b=Ub4qL+G0TFMmpt8I9Y0leGAVswWqNSISZsn/M04pjYwpXOHGwaro/4CnljdEszm6zT
         h5Co5ifTcvMp0xu29wzemGPLvWLXRbi1jBrf98sregWcgPruScjtiV18ZDWrO3QtAon5
         ULqMbWZ36LIsJSVp1WVt7fVhLKQgwRSXpTpeJJYGCBdoCeTn9A319VAuKqvD1vpKVCBM
         9DhcF+F6B58+9qreGjrRuOhel8H4/zIV1aOetH/r+gLEIYXJdxYa8lKPk7EMHywWNdEL
         LWCQwxzJW4bK/eb9LbhnN2oXDeX2Cf9T/mjIHfp8tCc9FN05k9Q/3Mfj3R+FXX38YQ0G
         hs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oAB+Nl4FFFMz/nqI5DhEiAQ9QgS+G5IVSXiy+W8aIAs=;
        b=BwHRfYHVWXM7Xqv/4ENrnl/AAQV43FHFBQFxWpbG3sV6L2/qR+2Zd2Vjp77YvHsdEl
         KlANeEwLng0dsKobKxFm5F95qapW91Q53SSURJV/85CW3pYa8+1hjFMhLaPbqs9/Ixd/
         ef0rvKTjbWlHqrnTxi2UaKOr7lLaUAix01rxQIpXxcJ83hild+wARoFYN4aDqlopbP6j
         wvS55CHqvNukMgasSzvmfxRfqCvYOWGb5koVNINBNsz2zTOvefcba7BwFWkrs5IgyZvq
         mj5o6NxMzuTiAjTaO5QFNacgADD+PkPftd+SXlmHlAatd2sV9pttO4z3MhP/0Fu3lINF
         hc4A==
X-Gm-Message-State: AOAM5337bidcJ31h6o09VVdsbh8FIplDy1JHUud8EPd76yxx95j9EahO
        dOdu47W7ikniGKKjSDKu2IJka1I=
X-Google-Smtp-Source: ABdhPJyZWEOxE+3z9VOFN/LKiQwo35hSdBfgqnhe/G3qVNN7DD7U4N4W6xk1VmjB5uDp2Dh3yWoHlVA=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:ede7:5698:2814:57c])
 (user=sdf job=sendgmr) by 2002:aa7:8e8f:0:b029:1f1:5a1a:7f82 with SMTP id
 a15-20020aa78e8f0000b02901f15a1a7f82mr26356990pfr.52.1617036343555; Mon, 29
 Mar 2021 09:45:43 -0700 (PDT)
Date:   Mon, 29 Mar 2021 09:45:41 -0700
Message-Id: <20210329164541.3240579-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 bpf-next] tools/resolve_btfids: Fix warnings
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
* remove unused 'int err = -1'

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/resolve_btfids/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 80d966cfcaa1..be74406626b7 100644
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
@@ -403,10 +403,9 @@ static int symbols_collect(struct object *obj)
 	 * __BTF_ID__* over .BTF_ids section.
 	 */
 	for (i = 0; !err && i < n; i++) {
-		char *tmp, *prefix;
+		char *prefix;
 		struct btf_id *id;
 		GElf_Sym sym;
-		int err = -1;
 
 		if (!gelf_getsym(obj->efile.symbols, i, &sym))
 			return -1;
-- 
2.31.0.291.g576ba9dcdaf-goog

