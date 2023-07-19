Return-Path: <bpf+bounces-5269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770AE7591A0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331912815E6
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69291125D9;
	Wed, 19 Jul 2023 09:28:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F1111BB
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:28:49 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF451FCD
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so11026415e87.1
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689758924; x=1692350924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=RmR0tn2XLxoJOQVfhj6Z1y0iP4vl4SctrEUwL1kVlHU/vpEljcorwTzzRgX4ay8x6J
         ZxCler5k1qYfD6FdRhctRHWJrBIPj38PG89ytDH1l+GK/juPRE8kbFKAaIJvYhEnX+81
         30HIyfPQhmb4VSWcnrPkYKDmvk69GBJc5iD2tQCEvBqIpJOSQdaWDlwlQGrmkiLNazPC
         2Bd5pSUZiJkEroDFWFD7oNPe2iJXfklJtZZAxJi52al2Sf6Kt+wJ4C53pbYDuTYFHwb6
         ENKVUA0rzunIqRYXUKNUzwvzz8u/Zxja1M6bOI/9MJ46+Hm2LNiCV5O8vSnBxs2Ub3fI
         jbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758924; x=1692350924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=bhgg1WpooDrjEqaKqTSor1upSn4sM4B1ZaLG42SE5TE9CHXsYKmsBQuFBEgnbzJVuV
         2S/Sf/p2sNYJF1IdKhYDiMYRZqlv17Fvvw/IrhxqkRreUO7TC9t0s7+Vpy5g1Bjk/4vv
         WLmjqrD799gWdl5MHFpJve6qyMdtGAPYKtZ5sO+u00X6veZ6zXlx1RWwazexuQFS7M2A
         V43O3+NdqHd6tdse7RYNPcVt/NsHekzsZUMccTXXUKBPrrpqOVUuG7m4ogQ12y2aJicG
         /9qVAPUI8FI4rJ84SaQzCiwW8IJbiuBsXAUoIYIJrmMyHs2IbtVDM07ZZ6tH3bqdNzsu
         BJbQ==
X-Gm-Message-State: ABy/qLbTE0yE/SiNUYfc7+yES7jfjIniyeY3eqhOKpnfJjc1wdrirXw3
	5k3+rcVNynXyDuQh21HtFv/7GA==
X-Google-Smtp-Source: APBJJlEvJxlIlo047VV+7wzcGwDG8LI2FzpITTuAkDeRT6GN74ABqTYEyn20L8ozGDwoQvHV0y9XxA==
X-Received: by 2002:a05:6512:3d1b:b0:4fb:8a92:4fba with SMTP id d27-20020a0565123d1b00b004fb8a924fbamr15073243lfv.25.1689758924233;
        Wed, 19 Jul 2023 02:28:44 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r18-20020adff112000000b0031435c2600esm4857213wro.79.2023.07.19.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:28:43 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Joe Stringer <joe@isovalent.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 bpf-next 4/4] bpf: allow any program to use the bpf_map_sum_elem_count kfunc
Date: Wed, 19 Jul 2023 09:29:52 +0000
Message-Id: <20230719092952.41202-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719092952.41202-1-aspsk@isovalent.com>
References: <20230719092952.41202-1-aspsk@isovalent.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Register the bpf_map_sum_elem_count func for all programs, and update the
map_ptr subtest of the test_progs test to test the new functionality.

The usage is allowed as long as the pointer to the map is trusted (when
using tracing programs) or is a const pointer to map, as in the following
example:

    struct {
            __uint(type, BPF_MAP_TYPE_HASH);
            ...
    } hash SEC(".maps");

    ...

    static inline int some_bpf_prog(void)
    {
            struct bpf_map *map = (struct bpf_map *)&hash;
            __s64 count;

            count = bpf_map_sum_elem_count(map);

            ...
    }

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/map_iter.c                            | 2 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 011adb41858e..6fc9dae9edc8 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -226,6 +226,6 @@ static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
 
 static int init_subsystem(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_map_iter_kfunc_set);
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_map_iter_kfunc_set);
 }
 late_initcall(init_subsystem);
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index db388f593d0a..3325da17ec81 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -103,6 +103,8 @@ struct {
 	__type(value, __u32);
 } m_hash SEC(".maps");
 
+__s64 bpf_map_sum_elem_count(struct bpf_map *map) __ksym;
+
 static inline int check_hash(void)
 {
 	struct bpf_htab *hash = (struct bpf_htab *)&m_hash;
@@ -115,6 +117,8 @@ static inline int check_hash(void)
 	VERIFY(hash->elem_size == 64);
 
 	VERIFY(hash->count.counter == 0);
+	VERIFY(bpf_map_sum_elem_count(map) == 0);
+
 	for (i = 0; i < HALF_ENTRIES; ++i) {
 		const __u32 key = i;
 		const __u32 val = 1;
@@ -123,6 +127,7 @@ static inline int check_hash(void)
 			return 0;
 	}
 	VERIFY(hash->count.counter == HALF_ENTRIES);
+	VERIFY(bpf_map_sum_elem_count(map) == HALF_ENTRIES);
 
 	return 1;
 }
-- 
2.34.1


