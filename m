Return-Path: <bpf+bounces-4077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B27488D3
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826311C20B77
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3639134C0;
	Wed,  5 Jul 2023 16:01:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC316125C4
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:01:20 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675891BD2
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 09:00:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e09a5b19so844436f8f.0
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688572845; x=1691164845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx0VMyak3nyRLdbXQ2+B5IoThRJzYj7fu4JJH7XaqgQ=;
        b=SIy871a4QFD0dl1R+3jdUZfRq5V5I7rfPvXYctsYZhUJr80HXr1cveDdNo2losu8Jb
         kbDpm9tbgUuWG6HdEU6W/xQCqc5CPz5aMVqdvBbaKOQW4Oxo08WrQh6dzqfO/MDNdcRI
         DfR4Fnkk4adSC9afKPo5Nob5AtGGLTjbio/kgJ/Uu2evYFUktTcL7M4uydZgTMkW3sko
         o/MwJPEeQDcyzovP9Nf1JfFN0qY5TF7FYhmeS/mPYwu8qDfchahK/ur4YvRURNWS73ky
         SuP6NKK+TdqV+ijLchAlQqc8KUlAgrbDlq3y/k56/1+7J67p+VsmKqMJwplqf1j5V3GP
         srhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572845; x=1691164845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx0VMyak3nyRLdbXQ2+B5IoThRJzYj7fu4JJH7XaqgQ=;
        b=T0UJnu3AqVne1n7Xy6nTf75xwwhVzNQAvgxq6zccYHpw/CcR1NnFj/Iy0cfTPZPN2n
         Xu1Li//Kf8Au/4muRDz0Uw7HPg5x+6vKKoLBqMgM2uJgXydjqQCmCVOibDsTT20HIGNE
         8hiEAwrqOTdRuJDs54WIht8xEigf5wkpOJ989ThKw1XFp5zDpaKdMo5M+U+muO1ewYrI
         Y/oYtm6ikRRE+X24HuD3qR3eYWXflmWGlwnzkTwERI7qq5s0VsPOiuXZgT6Ts2ozAiP/
         aJt8YGZppNPyKW8diweA6f0rbmmpeb5FTF2KMuhzAR2nAUZz6zVhkng/C3EmIGmf6gfM
         +tLA==
X-Gm-Message-State: ABy/qLYtkwXewzhlk8C9hJnJll7Pt/D/GBOe38mqhrAsbOjcBF0Xy0GN
	9V/Bn1n2ILNK2jHBjS/JmYHbhA==
X-Google-Smtp-Source: APBJJlGxF7cf/N4MTtSaTc/bYJ5D2H7dFCt4x19xDZyoWKuxqYzfycoiDqegt/Oj7uKoIgJX88GB2A==
X-Received: by 2002:adf:df0c:0:b0:314:3c72:d1ba with SMTP id y12-20020adfdf0c000000b003143c72d1bamr2678001wrl.20.1688572844782;
        Wed, 05 Jul 2023 09:00:44 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16861950wrn.108.2023.07.05.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:00:44 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 6/6] selftests/bpf: check that ->elem_count is non-zero for the hash map
Date: Wed,  5 Jul 2023 16:01:39 +0000
Message-Id: <20230705160139.19967-7-aspsk@isovalent.com>
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

Previous commits populated the ->elem_count per-cpu pointer for hash maps.
Check that this pointer is non-NULL in an existing map.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index db388f593d0a..d6e234a37ccb 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -33,6 +33,7 @@ struct bpf_map {
 	__u32 value_size;
 	__u32 max_entries;
 	__u32 id;
+	__s64 *elem_count;
 } __attribute__((preserve_access_index));
 
 static inline int check_bpf_map_fields(struct bpf_map *map, __u32 key_size,
@@ -111,6 +112,8 @@ static inline int check_hash(void)
 
 	VERIFY(check_default_noinline(&hash->map, map));
 
+	VERIFY(map->elem_count != NULL);
+
 	VERIFY(hash->n_buckets == MAX_ENTRIES);
 	VERIFY(hash->elem_size == 64);
 
-- 
2.34.1


