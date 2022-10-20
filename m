Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B560605A
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJTMhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTMhY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A446495CD
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so2059092wmq.4
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixQHMERYdgRb7FUM1/1Io76g7S2tfmEKG93IxR6PYMU=;
        b=3UQpyJ4RSqP6U+LqFymJjrN/MX4HRMwY4itEvcF1El5nHMUpGuZka79djeTDUWMuFc
         yvSGPFpBMoyazKgTLI5KxyxDyxOoSjCVvq8ZJxCxrt5uDIyGcuKYbhVPRYY4oWaITj1s
         U+pvM86TSSZEDC17Fj5DY3M1JH5UakiI/EL64myfDPb5jGS7JhvcASDdPoLSJpiRfToy
         s8eAWsoG6fwUrtYIE2eDBuZC9ez61s1yyvbSMz6SPOiZ1YmBoXAvLQAkoccLizqQTmy+
         ie9qk4V3hS0Mv4euhrtEOz0Gte51QHvSJpkEr+hT6NUyQw/09RMNXYTbJjL+tiVrrJ50
         4Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixQHMERYdgRb7FUM1/1Io76g7S2tfmEKG93IxR6PYMU=;
        b=k7HZWdC9O75EM+NNmlTEXZSUBU5gBG8HYmCWuZxfPOPkucizGBOBjIrl9sL6uBAqxs
         N1ZlLbP2QEkxvQPj7SaZ4tg9fp6uAvUfRayNoPQNriWdJSbjinBwn/wCo+vrDHmMPhe2
         QdcmateMLT63UyH63YjaGYNNEkFsCUyyDT0SI0C4fuKVJMeS7SD5YDo/H7YbUpBROojl
         07fy0mcSEbExgBH7vQNELkXYdOXQsQxFaVik04R1JfmZk9HzMP9ncXZbLPY5Vnrk958h
         CpkY1t2sb5WVxL79J+OS/UFZ7elW14/KL6qE8jD31xhv9Z9EN8ZxoKIl90+ggJ04dw7Y
         bkvQ==
X-Gm-Message-State: ACrzQf1K8oIR9/gFcfaS/M8qLKNm1z55SrLrpTLxII+q+6mp9SeCg8il
        MeNKtac3OYdXrta/9cdtE38HjQ==
X-Google-Smtp-Source: AMsMyM4+2pDOsfQhWiLHK+tWKSZySmZIjXUgoVB1aMiZHpb1cpB698IqsmKBWvR8xL9Nw33IoVeJ7A==
X-Received: by 2002:a1c:7407:0:b0:3c6:cc25:c02f with SMTP id p7-20020a1c7407000000b003c6cc25c02fmr9016493wmc.124.1666269441420;
        Thu, 20 Oct 2022 05:37:21 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:21 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v3 3/8] bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
Date:   Thu, 20 Oct 2022 13:36:59 +0100
Message-Id: <20221020123704.91203-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020123704.91203-1-quentin@isovalent.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make FEATURE_TESTS and FEATURE_DISPLAY easier to read and less likely to
be subject to conflicts on updates by having one feature per line.

Suggested-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/bpf/bpftool/Makefile | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4a95c017ad4c..0218d6a1cae7 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,11 +93,20 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z \
-	disassembler-four-args disassembler-init-styled libcap \
-	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z \
-	libcap clang-bpf-co-re
+
+FEATURE_TESTS := clang-bpf-co-re
+FEATURE_TESTS += libcap
+FEATURE_TESTS += libbfd
+FEATURE_TESTS += libbfd-liberty
+FEATURE_TESTS += libbfd-liberty-z
+FEATURE_TESTS += disassembler-four-args
+FEATURE_TESTS += disassembler-init-styled
+
+FEATURE_DISPLAY := clang-bpf-co-re
+FEATURE_DISPLAY += libcap
+FEATURE_DISPLAY += libbfd
+FEATURE_DISPLAY += libbfd-liberty
+FEATURE_DISPLAY += libbfd-liberty-z
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.34.1

