Return-Path: <bpf+bounces-5088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D37561C7
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3451C20956
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6714AD3C;
	Mon, 17 Jul 2023 11:42:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970DBA92C
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 11:42:09 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF1DE58
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 04:42:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so44833595e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689594121; x=1692186121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC3kRXuJb2CDsNb5ofLQfMx3YTx5F9ozdQp3kszCIv0=;
        b=Auzfuff/BXSj3l/XWHw4L7DXLokGkrcuPtT6rumBdt+l+AJreyG8pQNlDW9mrJ/zuY
         RD9MbUDYTSGtVNNDwApPqj6652bN9tKXBxFpEo226OSGd3r+c1QM/TVnwM2lfDqeR79v
         VOHvOTUc1g2XyLYH3A/P3AkxocgTuTlfSp8UqinTrNGIvj8If28VBbtGFBps7MN2rEhN
         iyiTcaKLGV8t6UxoUnZVmJB/Rv3JDWAQgSa1SokairijDELoRXVzntaEd/Bh03F2hnxV
         fJllhQGlE/2p/K/QJzacYC0NwRssdnyvEvC0m6Lev9jeExIlfMn4Ag09RoLYT1Xk8Riz
         k/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689594121; x=1692186121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC3kRXuJb2CDsNb5ofLQfMx3YTx5F9ozdQp3kszCIv0=;
        b=DkjK2txZIkx+ts5pp85ipErqixTg/KY76MfBHieOYHJAQriK57pzl3mjywkOUWxQeE
         FSr57aFGyEydJStnP1RI8+NQP2FWi4L/8LRYaNXpvL+FiJH/WFhI+a9XXBx0023Vszl0
         n6UjaC4MkNjIWJXIR+PW+ut1wIMd7N3Oc9SlJ2/uiPFmj9oy2p7UvuCKImEVS1y8wGT4
         B6fmHmke8b+CMqv6Ge8nXK2Jkd3r2fanfT+kGGe8bYCSZwqKuKMmyjIQ6+qerc33srcK
         axCxW48ezG7u1L9uQ503mep6TeJKW9GZ+n9gVh3Mf4c2Ui8xqEUdmaYHBud/YVGtqW8b
         ylsQ==
X-Gm-Message-State: ABy/qLYGiIrZ1YN/uVaU5KM+XEyo3fs6IXcnQb6VhGdaRmsBFnJOPvzF
	LedzEzavHgmnwi2NdJ1CJ8oiZLjzF8wxAZy/xlf5Hw==
X-Google-Smtp-Source: APBJJlGDRgpaqXBnqkzb0WwwhDR/B9BEFzZ16kPCK8IDZLtIAJWhABykrg2Q5mRvQD2QS6IfMIFQGA==
X-Received: by 2002:a1c:7c08:0:b0:3fb:424b:ef6e with SMTP id x8-20020a1c7c08000000b003fb424bef6emr11325861wmc.23.1689594120691;
        Mon, 17 Jul 2023 04:42:00 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c214900b003fbc9371193sm7946725wml.13.2023.07.17.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:42:00 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Brian Vazquez <brianvv@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Joe Stringer <joe@isovalent.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 1/2] bpf: fix setting return values for htab batch ops
Date: Mon, 17 Jul 2023 11:43:06 +0000
Message-Id: <20230717114307.46124-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717114307.46124-1-aspsk@isovalent.com>
References: <20230717114307.46124-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The map_lookup{,_and_delete}_batch operations are expected to set the
output parameter, counter, to the number of elements successfully copied
to the user space. This is also expected to be true if an error is
returned and the errno is set to a value other than EFAULT. The current
implementation can return -EINVAL without setting the counter to zero, so
some userspace programs may confuse this with a [partially] successful
operation. Move code which sets the counter to zero to the top of the
function so that we always return a correct value.

Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/hashtab.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a8c7e1c5abfa..fa8e3f1e1724 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1692,6 +1692,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	struct bucket *b;
 	int ret = 0;
 
+	max_count = attr->batch.count;
+	if (!max_count)
+		return 0;
+
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	elem_map_flags = attr->batch.elem_flags;
 	if ((elem_map_flags & ~BPF_F_LOCK) ||
 	    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
@@ -1701,13 +1708,6 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	if (map_flags)
 		return -EINVAL;
 
-	max_count = attr->batch.count;
-	if (!max_count)
-		return 0;
-
-	if (put_user(0, &uattr->batch.count))
-		return -EFAULT;
-
 	batch = 0;
 	if (ubatch && copy_from_user(&batch, ubatch, sizeof(batch)))
 		return -EFAULT;
-- 
2.34.1


