Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D475A5780
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH2XSe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 19:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiH2XSe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 19:18:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477257F132
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:18:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33e1114437fso150347747b3.19
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=0lhafXj2iVGO0xHQkpT9DZ5Z9AK3RgqVp2dka9M0juU=;
        b=X6QrVWknF21loz5DsyEEHlL9TrT4PTGpWOX7oyi4kYvKaRKJJ0N7PSqk69cFjbIrsF
         ZSiloccWVc8EAwuuvR7o1+vATxAYqpraU2FJGv9yJSl/9in72zezG4RddKNK/w7tfled
         dSvqtYpvz/w+/o8t7+7tZpjOScqnoT3KqIXsUaBlapICH/wfYOinQGVG8D10Q1kfS47c
         iOkmioyaN9ls2NeNVRz6xsJfM5fGRfoKpGgLQigtk1F8fvSMMlGWXi36rGuSsqtdXgv6
         wyFuzTmhSjcGJW0HJMsIQP68MBdzPm+vBgTuzVKLDL73JuFCJB/CEiDZ7mr079OoZagu
         sAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=0lhafXj2iVGO0xHQkpT9DZ5Z9AK3RgqVp2dka9M0juU=;
        b=VXNs3rjObEswMKuG14+2un0SUQ9PPn/YUFe8q7d+D2O92goS+Ph/Hwb2HI5mjvpKPj
         xxREs9G/WRqacXZbVt5q8DOYTjNhs3AkLkjvMVbu6VUYDejhkbb4vGFn4fgodekrX5gM
         SFWm9bclc3eSHz8pB/2kF1G4hL4ZWCBhsArxDjUgGKCa7llgj5h0sNi6MU70MOQivuOr
         6/vS3h/TzxKt5vopIl9eo5a2jmDGglvaQWFTSK3+0qV9aqOwFwf7JnHQsz9CcSZqIQ29
         Vn/R7QEzi30lf2MpmR+otxr0rBHqaGUNnKGVScu5XrG8hXCyep1uXPiF4yZ6ShD3ZpTf
         oalQ==
X-Gm-Message-State: ACgBeo3NQR62lJEqQdIum5uHOB16dEUHJlVBxQnDsVf1UPzMm8iCBAad
        C3K9USezm09yvdxuaCOl/pE9/bEZOI4=
X-Google-Smtp-Source: AA6agR5UJdH5HnV9NGjkFnupHjUrC1l+Gwz4Yi7D3ZklLgd6M0+8CTOt0eyZRsWeEl8mKfDkn9YMU4RhW3c=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:3698:5104:9e22:e494])
 (user=haoluo job=sendgmr) by 2002:a0d:c1c4:0:b0:330:4891:be97 with SMTP id
 c187-20020a0dc1c4000000b003304891be97mr11529426ywd.465.1661815112615; Mon, 29
 Aug 2022 16:18:32 -0700 (PDT)
Date:   Mon, 29 Aug 2022 16:18:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829231828.1016835-1-haoluo@google.com>
Subject: [PATCH bpf-next v1] bpftool: Add support for querying cgroup_iter link
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support dumping info of a cgroup_iter link. This includes
showing the cgroup's id and the order for walking the cgroup
hierarchy. Example output is as follows:

> bpftool link show
1: iter  prog 2  target_name bpf_map
2: iter  prog 3  target_name bpf_prog
3: iter  prog 12  target_name cgroup  cgroup_id 72  order self_only

> bpftool -p link show
[{
        "id": 1,
        "type": "iter",
        "prog_id": 2,
        "target_name": "bpf_map"
    },{
        "id": 2,
        "type": "iter",
        "prog_id": 3,
        "target_name": "bpf_prog"
    },{
        "id": 3,
        "type": "iter",
        "prog_id": 12,
        "target_name": "cgroup",
        "cgroup_id": 72,
        "order": "self_only"
    }
]

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/bpf/bpftool/link.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 7a20931c3250..9e8d14d0114d 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -83,6 +83,29 @@ static bool is_iter_map_target(const char *target_name)
 	       strcmp(target_name, "bpf_sk_storage_map") == 0;
 }
 
+static bool is_iter_cgroup_target(const char *target_name)
+{
+	return strcmp(target_name, "cgroup") == 0;
+}
+
+static const char *cgroup_order_string(__u32 order)
+{
+	switch (order) {
+	case BPF_CGROUP_ITER_ORDER_UNSPEC:
+		return "order_unspec";
+	case BPF_CGROUP_ITER_SELF_ONLY:
+		return "self_only";
+	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
+		return "descendants_pre";
+	case BPF_CGROUP_ITER_DESCENDANTS_POST:
+		return "descendants_post";
+	case BPF_CGROUP_ITER_ANCESTORS_UP:
+		return "ancestors_up";
+	default: /* won't happen */
+		return "";
+	}
+}
+
 static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
 	const char *target_name = u64_to_ptr(info->iter.target_name);
@@ -91,6 +114,12 @@ static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
 
 	if (is_iter_map_target(target_name))
 		jsonw_uint_field(wtr, "map_id", info->iter.map.map_id);
+
+	if (is_iter_cgroup_target(target_name)) {
+		jsonw_lluint_field(wtr, "cgroup_id", info->iter.cgroup.cgroup_id);
+		jsonw_string_field(wtr, "order",
+				   cgroup_order_string(info->iter.cgroup.order));
+	}
 }
 
 static int get_prog_info(int prog_id, struct bpf_prog_info *info)
@@ -208,6 +237,12 @@ static void show_iter_plain(struct bpf_link_info *info)
 
 	if (is_iter_map_target(target_name))
 		printf("map_id %u  ", info->iter.map.map_id);
+
+	if (is_iter_cgroup_target(target_name)) {
+		printf("cgroup_id %llu  ", info->iter.cgroup.cgroup_id);
+		printf("order %s  ",
+		       cgroup_order_string(info->iter.cgroup.order));
+	}
 }
 
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
-- 
2.37.2.672.g94769d06f0-goog

