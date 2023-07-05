Return-Path: <bpf+bounces-4071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E537488CB
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC248280A1E
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB43A125C5;
	Wed,  5 Jul 2023 16:01:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF77125AB
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:01:12 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771761FD6
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 09:00:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so69243605e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688572839; x=1691164839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8KYxGujweYLCYh8YYyQ0jA4DubxHjifs++dZAbkdWU=;
        b=bVo30utd90jGmX26Asrl19Hh3WB2whZwlLMBoaGLEhNrmcz/5H47ooBCqFM09bbQ1D
         GY2e22hr9q+O7uQ+jhHte9FdbfyErMwR0eQe0oXt/BVnWt2eIgPvb5AkvmScbwCt7vkQ
         iXKrgtP/AQ4G1h7Ds89lro1JsirvD7uWcO5uuXSNJBRje5fc3alhRF/3D0/VUh6PEh1O
         ol93n2gjfGFtKyFjR7Fm7SF/mUw2UKes+gRYA/puo89GfyDq1sHGwid8V2PRp0LiiiYN
         ghns4YupM/Q2zGi3PezkrHxnboJsUE+G+3jmlvszZsPcc9gM+wCggkpxiyCOsMFDUQFz
         4QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572839; x=1691164839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8KYxGujweYLCYh8YYyQ0jA4DubxHjifs++dZAbkdWU=;
        b=doz/zi/PDhH2nosXZYjwLzp/WPUFjubLMXqr9Z8lBbE2WUZO/tWMxoV84Yh0pMXMeP
         DQfkA+Gm6J2yfXzRzJw/39eGxI5xembP6AlJZRjRF7pbiuTHLUPer8SBzJv0TVJO/1b4
         OyvB6UQ98PMgDZH9BVVXhVskiSjpxwa1zILtqjrOhDmy5dZyGSHTSv+7gUC6RR/nfKlK
         hU9+hE6jycXHya2C7WoygkPBRbvLMWxezzSPiaPPVP35tsc6Rdp4qkZbf7OvLZZqxbSa
         LYup3Tx4sajNTByVICGQMeQ/dDNlvOEe3iBdQBvXbZ8vR+YYGIMWi7/fT9ZI3RJ+/ERp
         SH7g==
X-Gm-Message-State: AC+VfDz94CwP/f0Vw+WZGhz80IwbZ024IUVtq219DqWBzOs/sP54oNr8
	gixZREkARSQtTkHjguwgRNWIqiXWAP8aRmkwAvTvxA==
X-Google-Smtp-Source: ACHHUZ4Um/reDbbXCC1XxkmzvHLi2wXkfnENgb3F/Q6tjYHordK+Ml9xsGS1+msI1SpuCCbbtAphFw==
X-Received: by 2002:a7b:c353:0:b0:3fb:b70f:fc21 with SMTP id l19-20020a7bc353000000b003fbb70ffc21mr13725965wmj.35.1688572839442;
        Wed, 05 Jul 2023 09:00:39 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16861950wrn.108.2023.07.05.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:00:39 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 1/6] bpf: add percpu stats for bpf_map elements insertions/deletions
Date: Wed,  5 Jul 2023 16:01:34 +0000
Message-Id: <20230705160139.19967-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705160139.19967-1-aspsk@isovalent.com>
References: <20230705160139.19967-1-aspsk@isovalent.com>
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

Add a generic percpu stats for bpf_map elements insertions/deletions in order
to keep track of both, the current (approximate) number of elements in a map
and per-cpu statistics on update/delete operations.

To expose these stats a particular map implementation should initialize the
counter and adjust it as needed using the 'bpf_map_*_elem_count' helpers
provided by this commit.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..360433f14496 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -275,6 +275,7 @@ struct bpf_map {
 	} owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
+	s64 __percpu *elem_count;
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
@@ -2040,6 +2041,35 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 }
 #endif
 
+static inline int
+bpf_map_init_elem_count(struct bpf_map *map)
+{
+	size_t size = sizeof(*map->elem_count), align = size;
+	gfp_t flags = GFP_USER | __GFP_NOWARN;
+
+	map->elem_count = bpf_map_alloc_percpu(map, size, align, flags);
+	if (!map->elem_count)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void
+bpf_map_free_elem_count(struct bpf_map *map)
+{
+	free_percpu(map->elem_count);
+}
+
+static inline void bpf_map_inc_elem_count(struct bpf_map *map)
+{
+	this_cpu_inc(*map->elem_count);
+}
+
+static inline void bpf_map_dec_elem_count(struct bpf_map *map)
+{
+	this_cpu_dec(*map->elem_count);
+}
+
 extern int sysctl_unprivileged_bpf_disabled;
 
 static inline bool bpf_allow_ptr_leaks(void)
-- 
2.34.1


