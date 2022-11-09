Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698716232F8
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiKISuv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiKISub (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE8186D3
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:50:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-352e29ff8c2so171876657b3.21
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=HAbhjun7P8t/79/dqBqP+rj7CyYnqpzlHYOYz8g1nvpWXxuQZYlbqRh9LHbV8RqgbL
         uHS/oLrLpvr+aQyl134bv9P6wJamiQBmge0w+xR1tvbKtSbUiEl/4P5xNGSy9WgNLmOu
         e0GS5qQ8N9KNKNIeQn/LxUMprUnZkwBEnLjNUfxMnxm/kL6MCYkN3M0NKRK0NBPfuZoG
         D7MQqsgGpWM3iNH3CmKU/JibAvi23pTxMjWaKuLGHvOiZPJAQ8qAZaaFgKc1RHunC6od
         EdQdtmjfGgzZjdrFGBzbvDoaU+hH6HIcL1nb10UsK5Oy6++UaslT+MVj06OpPYiDjF4b
         gPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=ZxMksj/Py9UC00ID0FKI49YZKyNx0Om+2UT17LBQwkleKISNNbBjavHC+JZiEtZmDN
         EQhFj7kmuEw1juctkz1k9Iq06t5wvJHq2JDcRoiT/pMyfHThJqhEWCpcxZQX8WP3/JNI
         IXOosFedgGF/X6vrhWJzH1pEha3NgtcD+YMzLboaZwK3L+BQwRA9qPij+Alx8RuyKbDP
         KiBIOSd/yAHCxdVJeXL2wAn4kLKq32BkGUPlpC21CCrODggi0fUlNJKm1LtYmHQncrxs
         ULlcZp1OMp21Y2AJPdmNEn75VLIXQqm2/w3O+KbTFqiJ7tjDk7daAeqv0KFGnIFDzXBJ
         DNrQ==
X-Gm-Message-State: ACrzQf2rInfrJ8fzrUEEh9wwwxofDqLh2Ex34v+/77dEcDpikzTfHGFs
        YVDvf1FURLp+9eki4pNQyj1DJrmzo5qR
X-Google-Smtp-Source: AMsMyM7tKim5J0Fz3dpcQcx/D4llXsXbixQRKNPsvCvSgNnuoFw4d8N8sIGcMW/o/deoohzIfFLpecviFfba
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:dc87:0:b0:6cc:7352:b4dc with SMTP id
 y129-20020a25dc87000000b006cc7352b4dcmr1156840ybe.480.1668019824272; Wed, 09
 Nov 2022 10:50:24 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:07 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-8-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 07/14] tools lib api: Add missing install headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Headers necessary for the perf build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 6629d0fd0130..3e5ef1e0e890 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -103,7 +103,10 @@ install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,cpu.h,$(prefix)/include/api,644); \
 		$(call do_install,debug.h,$(prefix)/include/api,644); \
-		$(call do_install,io.h,$(prefix)/include/api,644);
+		$(call do_install,io.h,$(prefix)/include/api,644); \
+		$(call do_install,fd/array.h,$(prefix)/include/api/fd,644); \
+		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644);
+		$(call do_install,fs/tracing_path.h,$(prefix)/include/api/fs,644);
 
 install: install_lib install_headers
 
-- 
2.38.1.431.g37b22c650d-goog

