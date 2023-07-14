Return-Path: <bpf+bounces-5032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF5A753D25
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC971C21577
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2D13AEF;
	Fri, 14 Jul 2023 14:20:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48905E551
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:20:13 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECC35A6
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:20:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6685900a12.0
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689344399; x=1691936399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=fET5mheW2k8XUXyCZgr27r2S9eemW47Zml2RjJmVZyJa6RxgKX38TLREi0uUyQ65yK
         jSGBL1/GR3mB13uvWizvy6Tx1Co8Sv9uFVxkTHU1HA6DT+PaSInTystxarYkKtyDTgd8
         KrL6NGvz/vVSNmANyBpD4E7mcuQSp8VB3UIRBXInlWxCmPxprdUcZ5Q5cRifRqP5FMCY
         cDoOhltg0/cfN5w2vBvmO3IK4d4YIOVBppyzkcEEMPbbC+uNzVR3BCB+ojAZuDLIGRIV
         ScLMdhan5tSU1Yww7m2rFz5bIwIdG1kTi5rSEIxRDYLHiHYoTDS0Z48DW7PKBs2QrhRH
         lLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344399; x=1691936399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=eJhUZJeyd1KtiEwAb23nCscvtV8rbAnFkRQHOkw6OJqtCdmDI5MEVuh3AojIFFeqgS
         w5QT6OJaqaF3l45rR1mIv3xlVYxqUdeIx4tVEWHPekiJtXtS9dH81cyWvjaOHOP1640Z
         ekAr25bbqQbYQDUjy6Ov4UX4UNsIIOkRm2drNAH3GhlVnrf6fLxmCzFL3XVxsoyz89K/
         nCk6hz9a8LGh7F5jGxwvDLrixAqSEsrAh+wnlIipG/Px+gjFCseLbZrtZ2fb/zPDa49M
         3TQuRl/cPzptVOUSILcajuR1vrYUGJb0jqhN+9PgWzaTbq44JcloJt/0cSRVrFu1kPG0
         l1cA==
X-Gm-Message-State: ABy/qLZ9HZT8fMQmOGRsZ+KQmBPmLST6b90rjFHClm0Xu9FUEsnvFSnB
	NZ8kCLqSGsRrKGxFri8bIIHsNQ==
X-Google-Smtp-Source: APBJJlEQIvA3n/Prr51crDxtReiG/q/Se2PDT6dKD9tdWOl1w72csMERG1dYfF3M+wYIMbNXDH9elQ==
X-Received: by 2002:a17:907:6d19:b0:98d:abd4:4000 with SMTP id sa25-20020a1709076d1900b0098dabd44000mr3312257ejc.35.1689344399312;
        Fri, 14 Jul 2023 07:19:59 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709061d0b00b00982cfe1fe5dsm5469294ejh.65.2023.07.14.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:19:58 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] bpf: allow any program to use the bpf_map_sum_elem_count kfunc
Date: Fri, 14 Jul 2023 14:21:00 +0000
Message-Id: <20230714142100.42265-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714142100.42265-1-aspsk@isovalent.com>
References: <20230714141747.41560-1-aspsk@isovalent.com>
 <20230714142100.42265-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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


