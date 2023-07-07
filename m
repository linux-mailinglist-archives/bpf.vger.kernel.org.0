Return-Path: <bpf+bounces-4417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9F74AE35
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D04281720
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796BBE4B;
	Fri,  7 Jul 2023 09:54:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE54BA5D
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:54:51 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3602128
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 02:54:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so24592975e9.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688723687; x=1691315687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8+XuKxjMAeHAGdlI1NVxBOcoZ+cnUWPAn3g63YYSyQ=;
        b=Be0QX/DChtycp4X74WkaHGih95BU3Hrqx21bLpOzQnu2uvDWr5ijeqIvWxIMObJIgZ
         rtBTgIlnupMk9/P7CGs6bsMkLi8NFYPYkGHIjLgBtqvACo0ShMDxWmTrlv54zxEokI+p
         bLiNTdJHo49m9gfUH2aXkQk3xYUBOVIg33A/5a4oW9UeJUPv1ZSE/4sCyy8GgGz51dtJ
         2MSetqtG2rXcAySzeIFI6H/vQ8PM4xJUSJy8Es914Jjcm2LTb+RoVtjyXY54PGmk/CBE
         IxijdSmAW5aLL03gFI/bO8i3cgZqpvpvdLlSS79w4dXZELuT+PndsdtmaWkUalLUXA4O
         RogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688723687; x=1691315687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8+XuKxjMAeHAGdlI1NVxBOcoZ+cnUWPAn3g63YYSyQ=;
        b=W+2h45RMR9VfGFfxzJ+ymXXSLKbMw5IpYUuTaEiYkn3ynqJzOD2qYK4+XQ7kx8BP2I
         ODwv2vdHvI1jn7IHlcCFZt/BLQygTMwsH8CZwB0bxErpmW0bk4UvQ9GYaUAfpXMlXEWN
         ENCPb+YtVjWd7tFbPQQ6hrMnzVDNRIpZGTnalgJFij7gl03EyEndDfTFC+E6avj8I3Fd
         v6qsbahEMBMwydBWjaSonIZuiXLRaQm4qIIVsEpmO5NVb7ChcufBkmy7qnt/oaKf26PU
         NfOE389Hk/T3/+v3kMBCrlsyxUPcdVx5bqm7Eg7SWJ4eMeG4YXrqAk3ZrJBAExBrrTpi
         GTJQ==
X-Gm-Message-State: ABy/qLYW1cw0qu46l/OQRbJonOryrn1QCFKeuS9fO8BuX1n8ixQvnxMY
	fCMPk/QLhRZnwRQnbL/yIF83Qg==
X-Google-Smtp-Source: APBJJlFfu/IEM2iWY4VemYk1IYTtG7dzcsobph7TxzO6AdZ/RilCys1bhOXkYNsO0HkmXrPPrYNZGQ==
X-Received: by 2002:a1c:770b:0:b0:3f7:c92:57a0 with SMTP id t11-20020a1c770b000000b003f70c9257a0mr4643069wmi.14.1688723686952;
        Fri, 07 Jul 2023 02:54:46 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:9d9e:aaa3:b629:361])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003fc00972c3esm622636wmb.48.2023.07.07.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 02:54:46 -0700 (PDT)
From: Quentin Monnet <quentin@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH bpf-next v2 1/4] bpftool: use a local copy of perf_event to fix accessing ::bpf_cookie
Date: Fri,  7 Jul 2023 10:54:22 +0100
Message-Id: <20230707095425.168126-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707095425.168126-1-quentin@isovalent.com>
References: <20230707095425.168126-1-quentin@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Lobakin <alobakin@pm.me>

When CONFIG_PERF_EVENTS is not set, struct perf_event remains empty.
However, the structure is being used by bpftool indirectly via BTF.
This leads to:

skeleton/pid_iter.bpf.c:49:30: error: no member named 'bpf_cookie' in 'struct perf_event'
        return BPF_CORE_READ(event, bpf_cookie);
               ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~

...

skeleton/pid_iter.bpf.c:49:9: error: returning 'void' from a function with incompatible result type '__u64' (aka 'unsigned long long')
        return BPF_CORE_READ(event, bpf_cookie);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tools and samples can't use any CONFIG_ definitions, so the fields
used there should always be present.
Define struct perf_event___local with the `preserve_access_index`
attribute inside the pid_iter BPF prog to allow compiling on any
configs. CO-RE will substitute it with the real struct perf_event
accesses later on.

Fixes: cbdaf71f7e65 ("bpftool: Add bpf_cookie to link output")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index eb05ea53afb1..e2af8e5fb29e 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -15,6 +15,10 @@ enum bpf_obj_type {
 	BPF_OBJ_BTF,
 };
 
+struct perf_event___local {
+	u64 bpf_cookie;
+} __attribute__((preserve_access_index));
+
 extern const void bpf_link_fops __ksym;
 extern const void bpf_map_fops __ksym;
 extern const void bpf_prog_fops __ksym;
@@ -41,8 +45,8 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 /* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
 static __u64 get_bpf_cookie(struct bpf_link *link)
 {
+	struct perf_event___local *event;
 	struct bpf_perf_link *perf_link;
-	struct perf_event *event;
 
 	perf_link = container_of(link, struct bpf_perf_link, link);
 	event = BPF_CORE_READ(perf_link, perf_file, private_data);
-- 
2.34.1


