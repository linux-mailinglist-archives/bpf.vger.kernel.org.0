Return-Path: <bpf+bounces-3761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539BC743701
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844AA1C20B7A
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCE4F9C9;
	Fri, 30 Jun 2023 08:24:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E677E55E
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:24:22 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316691997
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so17479305e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688113457; x=1690705457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8KYxGujweYLCYh8YYyQ0jA4DubxHjifs++dZAbkdWU=;
        b=c5wp2vJUANlucp5wpcfuIbVxkFaqrepcKBtjVl7YSSVfsdpOe8VD6NhxRxcRtSixY4
         yDDa46VPnan5QtfdeIpjGM1+kp9MtpuZNYlqMPyAEiGYjkoW3W1bE7NAnaSk/8kSPk4h
         522CKtGHJdu3uPXSsTCthxUUeBtN89tHa5HBQ4eDH3HpkviwvhenCOlcikToPO9h1zUS
         QAsAJD+uEEbhAMn12I5UtOxwANda+fqpEbOkD7TuLTbrTTvQwvU15WNKHmFtaUBHVElh
         pnBCwWIzVPMVUVsH0LrM1VlFOBrq3wnS+6zuVI5gsgDje965jJFj8Q4475Jno9JwH8JN
         OjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113457; x=1690705457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8KYxGujweYLCYh8YYyQ0jA4DubxHjifs++dZAbkdWU=;
        b=CzUeXMhjH7RYuoJrbvw1iiUdxbPI9ZSImKOQznIL9guAikBMfn6hJADX0IsEW8AHuP
         PSwvTZp9a/qoQ8Puw+r9BiqrNXbc864yQ94Tvi7AlpUMJ805ROtK3JKtLvamKIqMOIHc
         ch/F3je7dOF0lvFv0S26EN36XVh0b2v0HeQxn2AN2mb+hRI1+ComMrWxO2eqm+rXgCC2
         OSs9Mn9XVLUSYTvDNxTjV7IcLZ+iAkSi54k/3xQ7fPN9VIU6TCXizOMsz1NTa9nAqTDy
         JNzhW83nVW4wVUTA4VuCVOFuE0YEORS46vzQsdCgaerjP45cX2Z027kGEBIk73x8HpY2
         DELw==
X-Gm-Message-State: AC+VfDw0unwIz6es3e+7a9Rt556hEBpWknBnMwzHi6DZmAOS25c0+l0+
	zojX0OFLER6jbcgaaMhk9KQ39Q==
X-Google-Smtp-Source: ACHHUZ7aAaGOVGwDUZNDPe635byxA0So90JsS01O4lS236bg4tglsrEFDs5nJtAAA2/T3VmgCtUHDw==
X-Received: by 2002:a7b:c4cd:0:b0:3f5:146a:c79d with SMTP id g13-20020a7bc4cd000000b003f5146ac79dmr1346878wmk.15.1688113457630;
        Fri, 30 Jun 2023 01:24:17 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm18189941wmb.26.2023.06.30.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:24:17 -0700 (PDT)
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
Subject: [v3 PATCH bpf-next 1/6] bpf: add percpu stats for bpf_map elements insertions/deletions
Date: Fri, 30 Jun 2023 08:25:11 +0000
Message-Id: <20230630082516.16286-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630082516.16286-1-aspsk@isovalent.com>
References: <20230630082516.16286-1-aspsk@isovalent.com>
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


