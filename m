Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40762CFF3
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 01:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiKQAo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 19:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiKQAol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1D830F44
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 16:44:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-360b9418f64so3988097b3.7
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvCSVmgPzSHRqmw4ao0rkGS2JaSHBM4HPOCpMgiqjz8=;
        b=W2oWY4rwEM5AaE08aIgnj/PebRcwaX0h1rd2nPnNIKAsZtTyvsHeYUyLOzBKXLYt1g
         YAxqT2SVCT+CK+aN4x2+skH6QY/3HOgKZbGGIm4IFEP4OGJ2kga0C4f6vSRn3iu3Rqbf
         GjDqjMHYEvk+E5Q8NpysMlNoAdbwT9dEVKlsr6SQcSVzbZQFCwupurkDP4M3z+P8YExg
         QRtZb/u7zLory0PamwAn+cBuEas0IRnRp9bpDiWhmt+GAcCifejnya56qpBc+O8WcMMP
         RGDalbNGetu+9dcmZsDYl3s9RMz0/Do59ws+R/4+5OSbljsNmFf1BUZT6EGS/HadENkr
         867g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvCSVmgPzSHRqmw4ao0rkGS2JaSHBM4HPOCpMgiqjz8=;
        b=smOs6tLM1lrcStPw0rlYAlymCTd0QVf4r0gb/YFYR/GNRimudAweI9VcnrvVGoZ+h/
         EV7N+pzpZuts33VIfo1pTcHk5AClnxUgieBnfPo/naeYyv2Gu/9kaWISOoZyioqnwkXS
         VlMICLr+SDkWmdFQpPSe5gvfinmPkGEgwmQ352nHYboVSR8tGBCEHzcvjH+OQmo0ceLw
         Hwq5Y4nVLsz6Ujuu559ELL+FcaPiFlAYDz78QWCqS073U9em/XKhd6irZktvpTm3lh3Z
         hTTcB1Sgzg9Lg8cJWEEj5/DQ6ZTr7eRUB6DOcDa3junA1mr4GqOLWpoQI6D75db0wcKE
         KeOg==
X-Gm-Message-State: ANoB5pn6srRpo99kfmYMNduR/Fxv825MW5q8j+Jm5R99dWDWzlF80+p1
        5q1zD+XLIonY59jU4cubtOZNsLlr9kFF
X-Google-Smtp-Source: AA0mqf4dl6phgEboohJWHjzZMtx4etccfHoNQKn+VYvDhIjIWJyalrS3bM6sZyMhY8keOHUcTSoYEzN2d88W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a81:742:0:b0:38e:7550:171f with SMTP id
 63-20020a810742000000b0038e7550171fmr2191297ywh.466.1668645870526; Wed, 16
 Nov 2022 16:44:30 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:53 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-4-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 3/6] tools lib symbol: clean up build output
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

Missing @ when building libsymbol. Make the install echo specific to
installing the libsymbol headers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/symbol/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index 4c1d6b53032d..ea8707b3442a 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -77,7 +77,7 @@ include $(srctree)/tools/scripts/Makefile.include
 all: fixdep $(LIBFILE)
 
 $(SYMBOL_IN): FORCE
-	$(MAKE) $(build)=libsymbol V=1
+	@$(MAKE) $(build)=libsymbol
 
 $(LIBFILE): $(SYMBOL_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(SYMBOL_IN)
@@ -101,7 +101,7 @@ install_lib: $(LIBFILE)
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, libsymbol_headers) \
 		$(call do_install,kallsyms.h,$(prefix)/include/symbol,644);
 
 install: install_lib install_headers
-- 
2.38.1.431.g37b22c650d-goog

