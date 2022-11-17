Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF32762CFEF
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 01:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiKQAog (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 19:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiKQAoY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF8E00F
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 16:44:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z125-20020a25c983000000b006dc905e6ccfso118129ybf.1
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 16:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb2+Mv9K/LFDyUH74/vUrjvC69FTheHi2sop9NGNDDg=;
        b=EeToBv2ab/HwHh2BINPuHn/YTQ2BmxkpzXjjH2qCQUMHWSO1DbWb2kPnw6e07uo0um
         dTbxN5qVXQGJfvCPX/U08k0Mpax0CBt8eru/jOX7fRKcajzsrQVvYJ8nlUgXppWC6DZ2
         FFM23sRyf3vSCFRUhwvrp5Hm18g8lfqnuGxmDOTdllrmal2Zn5ZcDqzdutOJs2267nOz
         N3wWUHuKBfpHnSeTJ90B6o8tQMtT0CXzJIH1UUq2r/vDixwvjj6eHnwZgoHtvfRaAnKp
         obEAMNs9S5K9B9TYLrvygObugs3cOHV7a4dvea66GLzVwbrl2F9DKv5NK8auKaqAUE5i
         yCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb2+Mv9K/LFDyUH74/vUrjvC69FTheHi2sop9NGNDDg=;
        b=sWpC+DOyryvm0los11hmQs+HJrB2h1ySazJOCxOu0Fd6rs8GtjrU0GPRWnvN2Tf+ID
         CL86Ps9AlvjUO0GUy3oB8+O/V2uFwoA4eeaW5OA9odwsFYoqHaSmI+C8tSotMslnObyz
         Y30mJLmnuNkmwEfWbXsFsNW8ZkdGuiH1egmVjPHeqoPut/5gwCLyD0r/5zRQjqEwLM9v
         sm2Zrder6hkMvVTJj7M1PD832c25euyoAibRvo578h34027Lr9j1ckc41cMY8wfv73px
         r8Kp7Q8qQlWyNROzwcNMDSqygxjiVwD5NSo+xXYzmRNQrksV91tOq+75wkrGvIyvM5zI
         7cTg==
X-Gm-Message-State: ANoB5pmOu5DT0gsJ1gujrKZ9Q1lBhW4sGtSQhpkE7aNH3idR9iEXtZKP
        nG4y264sNuFjyOFaWU3Bx7sW8c0DvKjl
X-Google-Smtp-Source: AA0mqf69drmheqtALfnafu9Fr+lV1wALgs9yuFszvYEIzHoEcMU/nXWBcDWIBFJoB37J6GDh+W6eyCqmDML4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a81:a116:0:b0:38e:b5bc:e996 with SMTP id
 y22-20020a81a116000000b0038eb5bce996mr1960731ywg.493.1668645862605; Wed, 16
 Nov 2022 16:44:22 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:52 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-3-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 2/6] tools lib bpf: Avoid install_headers make warning
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf build makes the install_headers target, however, as there is
no action for this target a warning is always produced of:

make[3]: Nothing to be done for 'install_headers'.

Solve this by adding a display of 'INSTALL libbpf_headers'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4c904ef0b47e..7f5f7d2ebe1f 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -255,6 +255,7 @@ $(INSTALL_GEN_HDRS): $(INSTALL_PFX)/%.h: $(OUTPUT)%.h
 		$(call do_install,$<,$(prefix)/include/bpf,644)
 
 install_headers: $(BPF_GENERATED) $(INSTALL_SRC_HDRS) $(INSTALL_GEN_HDRS)
+	$(call QUIET_INSTALL, libbpf_headers)
 
 install_pkgconfig: $(PC_FILE)
 	$(call QUIET_INSTALL, $(PC_FILE)) \
-- 
2.38.1.431.g37b22c650d-goog

