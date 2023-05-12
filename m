Return-Path: <bpf+bounces-388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D17005B0
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08923281B4F
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D591BE4D;
	Fri, 12 May 2023 10:34:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15FAD57
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 10:34:54 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832FE132B5
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-305f0491e62so9376791f8f.3
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683887647; x=1686479647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8+XuKxjMAeHAGdlI1NVxBOcoZ+cnUWPAn3g63YYSyQ=;
        b=VmjqalVY7z5kg8NT8Dsrxvhv4ZWc+QmcqO5vi1U++6dL4gaE0dP6DzSiXs+R+J7eIl
         5VGSYqPuosVwKnP8gJ3wXLSIdL4Nz+WMdePxw5RiAeto/9IwpzE/h77Ym+QhmHgeaTJG
         XLMal0O7iEcrQItuXo34JqgTO0HSuk38CO9P7TliGxJk4uFywf983znYiJnMMd2GIxPX
         r0V14yQ+dCAVeGLB5hcpNBjvaPj536S5rTDiTZQKoi4/stFkaDz69HfVjf/AAvMPnZXw
         ddw+HhldMKGH3Er8V0aSIk1I6JH5Nl+LnUghqcZXyuoA+emvVx89WFJG3z5Q3SYyObDg
         NSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887647; x=1686479647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8+XuKxjMAeHAGdlI1NVxBOcoZ+cnUWPAn3g63YYSyQ=;
        b=cMJsB6ErPRjVnXCmk5dGTsNI9ipkb92nHWVly8sueF0tuCl/clar4TavEphkQmqnV1
         NWyQGGDNuctzBOoxXeSv+wpGxz+7UDtb5vw0CTtGFgyvrmOuGYkB1i06ZKejwAam0fCR
         P+cuRC4FGvxrwJqGQgrJsSXJvmYVxau4eqGQ2WMhOcqmOmbGBE4omtADhq0/XLuJq6q5
         /IZQchZMCMeKLVLrY3tNELKqnc/xDom8YiA986v8/eSg8+PNPX9AxtgCtbEM4++gEadq
         l5hn7ukjU/TEXS3L3t/3Uu8ddZIhOwFskT78yZM/HmNbl+Le8nvuH8eyR2iKKxqyj7Z4
         j6hQ==
X-Gm-Message-State: AC+VfDz/9EaeythX2lMj5F6zlIXQ78eR7TCm7nVfRGxrG7SgRRB+o1xf
	c/51I1+As4a9TVGDETaevPo7lQ==
X-Google-Smtp-Source: ACHHUZ4/fs/YQPZVoJ+tJ8HsBI1l4D+8Pk6QqzO/BZV4CjziW8p2SGnNZvehICuFJaVDwUERKdVfig==
X-Received: by 2002:a5d:42ca:0:b0:306:3b78:fe31 with SMTP id t10-20020a5d42ca000000b003063b78fe31mr15443375wrr.69.1683887646768;
        Fri, 12 May 2023 03:34:06 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:a162:20e4:626a:dd])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b003078cd719ffsm17946320wrr.95.2023.05.12.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:34:06 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/4] bpftool: use a local copy of perf_event to fix accessing ::bpf_cookie
Date: Fri, 12 May 2023 11:33:51 +0100
Message-Id: <20230512103354.48374-2-quentin@isovalent.com>
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


