Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF4A53C4AA
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 07:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbiFCFwD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 01:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFCFwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 01:52:03 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC60272D
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 22:52:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j23-20020aa78017000000b005180c6e4ef2so3818946pfi.12
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 22:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8MGcac1+NMnCFqTNkAP3LH9iYhQFVupT03fTHS13h/k=;
        b=F1Frl6XmIOttiQHw5FYbqF5lSf7HlRCqVLHgOovpTeymFO1a9nMk21DnGkcnWy4hIV
         ZofZpNRqKGZ8xlqbJvoXaYY0iS7U9QTfQ6uNUByBlD9w/w+Co2Vs1TUrcf2R3FMqTwaM
         N4OxKdK3ljmff2HKEmldBCuFo49YnQjVgDwcJ1la+nvxmCo57wL+RrSJks4HfYIRKFVX
         YYMje3sos8w6ArzxpkSeu7M3qla0CTNY6jUFPOabo+MPoy6TEs5qajEt/P7fSdh3fgmn
         BJpO2las5+kqfhfJRbREihkHZgWFMXi/wOMsdYQShW6Gc9XRFv57eWR7nj/scGuK1Cw4
         NY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8MGcac1+NMnCFqTNkAP3LH9iYhQFVupT03fTHS13h/k=;
        b=J/4KE2lEXcXJi5Q6jKOyDDvUv2igMjZ7rnxKqIkWr7Z5S1ITyYCmcp8TJnf5HUl5uA
         IzAGNTRF2ju6FeXzs3OAqquaXJ6ij73l1FhMAw3R5OyhrotuqVmy/Z7C8dwoVMM1tbBq
         CJFPTQGF3OX8GqFwVZ9jAc1JzbRMa+z9rylSbR1c856AWX0WuMXQSpdr0d1l5C7DzMh3
         9L2QvlEV/QuEDuCF5P+yeiVjzz6fKPWr3vcZfnKwMx9WSchiGiVEKnunApNshkIYPWne
         L9IIamk2qtWKQN16ZxpVxAOfYCH6ZFm+3HlvD81W7KUbLp2fqdSalEBiXUFwGdWLiaoj
         ePKA==
X-Gm-Message-State: AOAM530pyRNac4fvSxf7tdVDlqdw6raFncCyFSFFZBm2IcKd2ObZjAGS
        Fclr7/ujN//HoxJJu/zvIUfizKHN++YL
X-Google-Smtp-Source: ABdhPJyocRs8naUtOBDapn9dNnFxP6PLE+KWzr0IdfOtTWVs45RklCV6XMaOSN4VDKwxdYmj4cKkFCgFwkNZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e5a:e82c:d3a4:578c])
 (user=irogers job=sendgmr) by 2002:a17:90a:178f:b0:1e3:3ba:c185 with SMTP id
 q15-20020a17090a178f00b001e303bac185mr352114pja.1.1654235520615; Thu, 02 Jun
 2022 22:52:00 -0700 (PDT)
Date:   Thu,  2 Jun 2022 22:51:56 -0700
Message-Id: <20220603055156.2830463-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2] libbpf: Fix is_pow_of_2
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuze Chi <chiyuze@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yuze Chi <chiyuze@google.com>

Move the correct definition from linker.c into libbpf_internal.h.

Reported-by: Yuze Chi <chiyuze@google.com>
Signed-off-by: Yuze Chi <chiyuze@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/libbpf.c          | 5 -----
 tools/lib/bpf/libbpf_internal.h | 5 +++++
 tools/lib/bpf/linker.c          | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3f4f18684bd3..346f941bb995 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4954,11 +4954,6 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 static void bpf_map__destroy(struct bpf_map *map);
 
-static bool is_pow_of_2(size_t x)
-{
-	return x && (x & (x - 1));
-}
-
 static size_t adjust_ringbuf_sz(size_t sz)
 {
 	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4abdbe2fea9d..ef5d975078e5 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -580,4 +580,9 @@ struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
 					   const char *usdt_provider, const char *usdt_name,
 					   __u64 usdt_cookie);
 
+static inline bool is_pow_of_2(size_t x)
+{
+	return x && (x & (x - 1)) == 0;
+}
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 9aa016fb55aa..85c0fddf55d1 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -697,11 +697,6 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 	return err;
 }
 
-static bool is_pow_of_2(size_t x)
-{
-	return x && (x & (x - 1)) == 0;
-}
-
 static int linker_sanity_check_elf(struct src_obj *obj)
 {
 	struct src_sec *sec;
-- 
2.36.1.255.ge46751e96f-goog

