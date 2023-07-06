Return-Path: <bpf+bounces-4246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F879749DED
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193DC280FC5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F3944C;
	Thu,  6 Jul 2023 13:38:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986F9442
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:38:50 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5B1994
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 06:38:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so7835505e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688650725; x=1691242725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8KYxGujweYLCYh8YYyQ0jA4DubxHjifs++dZAbkdWU=;
        b=ObTycPkZBZTv6E0R9obd3mKMLWQFgFRN7hhu49URQH5ZfvqaqxWRfdarYixFnW5s+k
         U6t57yKHsjwF6D8yInl+dTVCCoVa7cSUusHARe+I+gmGlCuV498vNZDlOpii8OgCaBmH
         RU3aJQPqBvWVIDnFfuw641wIwIZsbTU/+80cSzT8/ddOiUy0kusoURRi/DQ2os9CeAQM
         2+wEDecmak+r/7+2zF408Fm29CZvV/U8VxSRKx8cBfsZ3XaFTsLDyKt1A/AyptfI4ciA
         hg7uX2AC9rG1EkfmpvZJ1RqlzXcdUiKXME4jUgc141roFC57pQmnL5URMm9gkLRe+oq3
         ATzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650725; x=1691242725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8KYxGujweYLCYh8YYyQ0jA4DubxHjifs++dZAbkdWU=;
        b=R2xrFbTPLh94hv3rAGCLF6Kw+gWMWyTNk+OvwUOp1CtJAxJ26S8MlWY7S22S9LM7l/
         4za3TtfQdAcLfmL4ZmbA6nFxwMUxkt9cd0lHTNfepJXIITsBJHLL9TALqN8wQyGne2qF
         3n386Ng/BV42dOXY6QKkNpM4MW5O8OQH7hsNahu6kDqHDU9ufNcJsFTe0yTlSLVptqXy
         ggYqFiFE3GDLidooruYMU4FiQrHxJRUJXtvsIupHZHOAwWQPnTubLAXNb6Muf/CfMGCe
         smomTBO1AgRd7cnDqnEHd6iNCis0h2pRDyVl21MTkakMeBQRzjOqBrpsdGns08dxtHcK
         hjwQ==
X-Gm-Message-State: ABy/qLY+xjxUC3HFJ5PWEN3+2X4odjrLM0FUlzqKw0Ygrof7wmHYnfWh
	gdxQJfrXOw1mRHcdL0CN0PgsOw==
X-Google-Smtp-Source: APBJJlHARBDlvjKvfkxejD04dz6QRzLO/Yzxxsv6ayKZw4ylcxzE8u33NcfrIIjSI2pj+t5kG/zuag==
X-Received: by 2002:a7b:cd0e:0:b0:3fb:40ee:5465 with SMTP id f14-20020a7bcd0e000000b003fb40ee5465mr1584159wmj.22.1688650725500;
        Thu, 06 Jul 2023 06:38:45 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003f9b3829269sm6754524wmo.2.2023.07.06.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:38:45 -0700 (PDT)
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
	Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 bpf-next 1/5] bpf: add percpu stats for bpf_map elements insertions/deletions
Date: Thu,  6 Jul 2023 13:39:28 +0000
Message-Id: <20230706133932.45883-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706133932.45883-1-aspsk@isovalent.com>
References: <20230706133932.45883-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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


