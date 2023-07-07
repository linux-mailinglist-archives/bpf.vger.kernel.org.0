Return-Path: <bpf+bounces-4418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB8E74AE36
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 11:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17ECD2816FF
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582CFBE5E;
	Fri,  7 Jul 2023 09:54:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F7BA43
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:54:52 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32596213B
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 02:54:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so18532515e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688723687; x=1691315687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydRUhTvkqIGbGqxLt/z4AF3VaqBwCqvDolxh+gB9HZY=;
        b=V1jLwohXh9u5sjqU47m+fMFe0SFW/86TAY6sjy6GFNS8VwUCZ7g3xr8QlI8bsYoLUL
         1WME/BWa2qWKmmKkKLgZ0ju3vuSFMdH3/pALM7SkvRfdFlFIjFwxsRIj1PIcFODhCy1C
         q6OIJu4DYTY2qCUChOy2Fr8m+2oEIxILY+vt5GxlYj/TfALDQIP15yc+OCZTLt7YnV/i
         xpdQYPl9e/RA1dc6FcYQGOwGXGq/6jMTOYJgNZw5JnoX6nnB7CadZ1MqT7UBlmS5kCun
         m+QRVuhPZX6iWySCD4eSQqtmywgcX2L63BLIzWaJGJ0A4pw+IDDdC+fwSVwvlxtQCXoD
         ftlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688723687; x=1691315687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydRUhTvkqIGbGqxLt/z4AF3VaqBwCqvDolxh+gB9HZY=;
        b=lEg63a3rD9R2uPTJrRCzLo/387yfffwdlswFbc2NKGkxmOgMgbX/r4p9xpQKPzgLVX
         F3U6b6vJu7zWvcy6g+VqfApwKKt2sdBXvHRrZ+4jVZiutdrQCf/9cLBZYqiYlFqs2CVI
         3NrOFEteilb2crJ1vXhI9hjQMVhfpyD0nBGhb73OVdqXGldkyNZ02HPCo/aIZ3sjcyXe
         ueMFQsMa9NSSSkY2Fslu/Sr63luA9y+nYmaWkL7PdNJsfZT8WW41fott4vCMu/RwyBvK
         /oLsKvuO0ReKP3/tyFuC5edIiAxjMHi5NQHgrIs/dya5uXiqWtImEylp5mztqA3cChfi
         1rfA==
X-Gm-Message-State: ABy/qLaH4tuB1/D/89A97/Vh5pr3Eswxu0SI8D53m+E3VaX7Q6IHusuU
	bota5lxYFdJSA7cPxySWm67mdQ==
X-Google-Smtp-Source: APBJJlH1ZWXVhCDLURObSvpjCCCjMDkSXt+8Icu+1NhtWzEb0q0ztd7Ziigep14PBLw+Kvj/HZR8uw==
X-Received: by 2002:a05:600c:ac3:b0:3f4:d18f:b2fb with SMTP id c3-20020a05600c0ac300b003f4d18fb2fbmr4053008wmr.8.1688723687786;
        Fri, 07 Jul 2023 02:54:47 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:9d9e:aaa3:b629:361])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003fc00972c3esm622636wmb.48.2023.07.07.02.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 02:54:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/4] bpftool: define a local bpf_perf_link to fix accessing its fields
Date: Fri,  7 Jul 2023 10:54:23 +0100
Message-Id: <20230707095425.168126-3-quentin@isovalent.com>
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
container_of() uses offsetof(), which does the necessary CO-RE
relocation if the field is specified with `preserve_access_index` - as
is the case for struct bpf_perf_link___local.

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


