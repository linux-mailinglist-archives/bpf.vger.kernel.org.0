Return-Path: <bpf+bounces-389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A417005B2
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5598281B55
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03902BE5F;
	Fri, 12 May 2023 10:34:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF1AD57
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 10:34:54 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9067311B5C
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f4ec041fc3so11693705e9.1
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683887648; x=1686479648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NPNRPg3iC1S44ccs7eA5h09oCu2rts6Gsygb3/XLG4=;
        b=KU2TN68d5PEpMwlSBYS/XvHlC8aafie5kwDmui2hmBQVyiBlNj6n9dtieF5l34izcD
         3JaaIr8H9bgEKw+i/EPW29I/Ua73PAqHdwwQveaWvkRiUns4DM22mofYLbVch384U66Z
         1KVqmj6jU6I+mrvx5nFFn/FVOK4EWMSoOldG9T7Xr15l8UcREJuTgOi4SUFWn1YtblAG
         nBfPNbO0V1N4CV1G0RacqHfpzjJrL8nsCkVvmzoBzWViJhCzLPew+hdtXvyP5h2f1/S/
         aBRSpGuJS3ax+rePCU8qr0CDZjQCrKQKmJr4KjS2eqscByaecPGpoiwkapmPkkTzHYQB
         fpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887648; x=1686479648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NPNRPg3iC1S44ccs7eA5h09oCu2rts6Gsygb3/XLG4=;
        b=S9ysq3k90a0cP98azM6YeOl0r1Cx+ZoCR9C68gZa23CjjpjF8Vb9mEc/+T/K/isylV
         kvh7vbi5LDusut+P1nwFxUenp2/y6nnDfyBLpnoHezQO36T7z+dHb23z0S/Kc/rjs+zJ
         RsAd7yILMhZs1KZpOwFrcqeONVTp7BN5JUafcToBX+GTz6SHwWYC1MhgfVELNAbsRPe8
         DbOzYQOMpw7sHFwvcYacCCAV8NZ8L6VwxEGs/PkHYwGIJoBuSNRPKmxTQEL9tnbEQhqk
         sfNPwOWrdeFJczMY5P8Q4mMGSbKzsnpsRiDeSQ6ixipO0+Zrdy7MdsJseDmEcz0f572G
         o3TQ==
X-Gm-Message-State: AC+VfDwtA75jKDGwA5Ois4fcb0dFvU6F3j8BxvyuUy0bq57uBgnNGYKj
	2JeA4NM8xBixS6xty5itqTV/Zw==
X-Google-Smtp-Source: ACHHUZ6bRZz+6d8UGMUqDavEDR7++W9B8vc3Qup73zLqIy9pJJxQ7vNEgxEVvV45MXguGKfjpKKeLQ==
X-Received: by 2002:adf:f58f:0:b0:306:b3f9:e2c9 with SMTP id f15-20020adff58f000000b00306b3f9e2c9mr18224105wro.6.1683887647687;
        Fri, 12 May 2023 03:34:07 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:a162:20e4:626a:dd])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b003078cd719ffsm17946320wrr.95.2023.05.12.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:34:07 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/4] bpftool: define a local bpf_perf_link to fix accessing its fields
Date: Fri, 12 May 2023 11:33:52 +0100
Message-Id: <20230512103354.48374-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512103354.48374-1-quentin@isovalent.com>
References: <20230512103354.48374-1-quentin@isovalent.com>
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

When building bpftool with !CONFIG_PERF_EVENTS:

skeleton/pid_iter.bpf.c:47:14: error: incomplete definition of type 'struct bpf_perf_link'
        perf_link = container_of(link, struct bpf_perf_link, link);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:74:22: note: expanded from macro 'container_of'
                ((type *)(__mptr - offsetof(type, member)));    \
                                   ^~~~~~~~~~~~~~~~~~~~~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:68:60: note: expanded from macro 'offsetof'
 #define offsetof(TYPE, MEMBER)  ((unsigned long)&((TYPE *)0)->MEMBER)
                                                  ~~~~~~~~~~~^
skeleton/pid_iter.bpf.c:44:9: note: forward declaration of 'struct bpf_perf_link'
        struct bpf_perf_link *perf_link;
               ^

&bpf_perf_link is being defined and used only under the ifdef.
Define struct bpf_perf_link___local with the `preserve_access_index`
attribute inside the pid_iter BPF prog to allow compiling on any
configs. CO-RE will substitute it with the real struct bpf_perf_link
accesses later on.
container_of() is not CO-REd, but it is a noop for
bpf_perf_link <-> bpf_link and the local copy is a full mirror of
the original structure.

Fixes: cbdaf71f7e65 ("bpftool: Add bpf_cookie to link output")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index e2af8e5fb29e..3a4c4f7d83d8 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -15,6 +15,11 @@ enum bpf_obj_type {
 	BPF_OBJ_BTF,
 };
 
+struct bpf_perf_link___local {
+	struct bpf_link link;
+	struct file *perf_file;
+} __attribute__((preserve_access_index));
+
 struct perf_event___local {
 	u64 bpf_cookie;
 } __attribute__((preserve_access_index));
@@ -45,10 +50,10 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 /* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
 static __u64 get_bpf_cookie(struct bpf_link *link)
 {
+	struct bpf_perf_link___local *perf_link;
 	struct perf_event___local *event;
-	struct bpf_perf_link *perf_link;
 
-	perf_link = container_of(link, struct bpf_perf_link, link);
+	perf_link = container_of(link, struct bpf_perf_link___local, link);
 	event = BPF_CORE_READ(perf_link, perf_file, private_data);
 	return BPF_CORE_READ(event, bpf_cookie);
 }
-- 
2.34.1


