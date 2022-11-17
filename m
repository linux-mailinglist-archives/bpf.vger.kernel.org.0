Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937762CFFC
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 01:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiKQApv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 19:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiKQAp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 19:45:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03E6DCE5
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 16:44:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so139903ybr.0
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 16:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l37iz2975hiUXVicXVT7NKOBiZU0GCzUGISmaxBrPSE=;
        b=YEtTk8qH0jtvKJSEHhcLiPsmaqCVOUM78La82OlOJzpwzja6CkpMYWydiYo/iH3/6f
         pqrgqraNl8eW4ZCAZCrPfhjyY+Gmgfllofnsle+j6KjtKN1sB2PdqOOY0VHg34xdlnhg
         u+g+YvTV3juXHyMYp4lJKzWpX7SKUv2s0Mnv7CsYKPoPiQAy/fKeLN63CBbjme7ymu7l
         dWQB/Fq+qMH7WcfU4gD6jIGoP4nBNcjmaZRjNoYpRFLJFYmjRTbqNTAgk4twdv8GQTEW
         LXoTbQRmM95iql1Kr2Lhq+45T72RppqBzBPFOikBnHojLDObupSlWib16ZIy/zQmXYov
         XFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l37iz2975hiUXVicXVT7NKOBiZU0GCzUGISmaxBrPSE=;
        b=skAvLDief7VIfe9Lt7LljxXHw9t8VI+/wiIZsm09IScBT/eEng0e0msIyiULkRPPDI
         MCD76mI+Wx8CV2OMcR24gBWaRm9uNg3smP6gnomLTjh5Qja1Ttkl+Zv/tBNnyBPRiKtB
         tApQQMezohYve/kaEYW3jKaMcc6iwl/Hd4f6TvwFF8H2wyxJYckEFu3PbefVrgg1sIPQ
         1k4y9cH3mAyvZ60xsIhWUHS+04AfjMTZVStl3tJiLDwotver/ibSjFNXTfFNEbhwHTl5
         QFgJ5/Ion0N7bjWbCWLTn9HbQ30UL4XQFl1Jz2LX61E8lNdXNLzcmF86nFQnwUqgJHE/
         gJ7g==
X-Gm-Message-State: ANoB5pnBEazxI3cCFFobAUvO60kcdzDSJ6lJ92sFuid1cFPQP7gFOBcw
        I+rYyw4moL7Ei/aloi3RfwccpsRxyCdC
X-Google-Smtp-Source: AA0mqf4QChD4efywo1GyOLQSyHOZbW7thg0+t7VgEZ0tk8VKSYAD0O+aXxgO5KVqtsXVltD2KxrwhqBcj66F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a81:3803:0:b0:380:c83a:35a5 with SMTP id
 f3-20020a813803000000b00380c83a35a5mr5ywa.496.1668645893816; Wed, 16 Nov 2022
 16:44:53 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:56 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-7-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 6/6] tools lib traceevent: Make install_headers clearer
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add libtraceevent to the name so that this install_headers build
appears different to similar targets in different libraries. Add ;
after kbuffer.h install target for consistency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/traceevent/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index c874c017c636..98dfd4badea3 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -234,11 +234,11 @@ install_pkgconfig:
 		$(call do_install_pkgconfig_file,$(prefix))
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, traceevent_headers) \
 		$(call do_install,event-parse.h,$(includedir_SQ),644); \
 		$(call do_install,event-utils.h,$(includedir_SQ),644); \
 		$(call do_install,trace-seq.h,$(includedir_SQ),644); \
-		$(call do_install,kbuffer.h,$(includedir_SQ),644)
+		$(call do_install,kbuffer.h,$(includedir_SQ),644);
 
 install: install_lib
 
-- 
2.38.1.431.g37b22c650d-goog

