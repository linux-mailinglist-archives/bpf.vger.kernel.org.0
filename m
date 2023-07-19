Return-Path: <bpf+bounces-5268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FED75919E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76511C20E05
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B5125CF;
	Wed, 19 Jul 2023 09:28:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D6111BB
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:28:46 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E606A1BE4
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3159da54e95so5970927f8f.3
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689758923; x=1692350923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4zgnqP7ASsB+eUpBj68dhMcY1VzfTyfkf9nUd4K0Yg=;
        b=SJ3Q0B0A3Ka3GcM2fsrRRu1ABrz3qH5VgmkgNyaET96MSIOytg/OiEvrePd6F8G38R
         3hsF8hHq1GaxCVrvDR4njcuc8XDEMSD/QU52mvwbWVqCXXmsKizJdl+1vcFeg5dH3uBE
         D18W8vJhf5Pzs3smkfJc1RF9ftkSDd5q8XubHReffV4Svz9vwql31AQfXLIFkFFQBuJj
         bYk5O0F0zscjX6UwNUMlxOWG8C5eRgR5yrEBMczGh7d0S8+2q58dK9PNv18cDwHv9txy
         3qf/p9NX9okmwlwyzKiHN7FyxZqgYiG+vQW0XUSSQzLohGIejHdnf/JD5laAtmUHJCGR
         BpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758923; x=1692350923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4zgnqP7ASsB+eUpBj68dhMcY1VzfTyfkf9nUd4K0Yg=;
        b=IrL3tbxxjLQa7n7PANEmCRM2A6pKWRgXF2isSWFMh4/GY47j4GPx1FxtwyFtIjNAzt
         5TubAi9BeVFpcMew/kir8p0F1o82Dk6ZQP3Uu65IcRp8iF+Cf2AIK+Fy5m+6NM1jHCQG
         uZdZYxYAMeG64lHudKcZp+w9wOIPjbvt1D4TpJQpa+bIGS2hITGFHz5bN+QupZI8kTlt
         NA148AvODHzSMNQ1WKkOW1lMIrydxbLynTpa1CDqYudluB/0rMqvkR778sfkj/InSDCx
         V0niOh1B4Q4W8D1J4+o0+u3TU/44LmOJ2zixqnJfMgci4zAemcdvqD1j+eO6wCPN5+05
         uhVg==
X-Gm-Message-State: ABy/qLZsBnVvlCIJClXBVHa3hAxNBh1QZD82e97ICoKgONWRTHv6TaBi
	EfXzKUH9hySrgHuPBGmTEZn0VQ==
X-Google-Smtp-Source: APBJJlGtFawbZBqZERUAV75DJCPsKZRCyTCDL7eU0AnTNqHeGvVdeQGCV9GkZYMhye2U0gW5/Sl8MA==
X-Received: by 2002:a5d:4532:0:b0:316:cbb4:4e49 with SMTP id j18-20020a5d4532000000b00316cbb44e49mr3584324wra.1.1689758923173;
        Wed, 19 Jul 2023 02:28:43 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r18-20020adff112000000b0031435c2600esm4857213wro.79.2023.07.19.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:28:42 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 3/4] bpf: make an argument const in the bpf_map_sum_elem_count kfunc
Date: Wed, 19 Jul 2023 09:29:51 +0000
Message-Id: <20230719092952.41202-4-aspsk@isovalent.com>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We use the map pointer only to read the counter values, no locking
involved, so mark the argument as const.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/map_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index b67996147895..011adb41858e 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -197,7 +197,7 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
-__bpf_kfunc s64 bpf_map_sum_elem_count(struct bpf_map *map)
+__bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
 {
 	s64 *pcount;
 	s64 ret = 0;
-- 
2.34.1


