Return-Path: <bpf+bounces-5031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B2753D24
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03191C210F3
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708C13AE1;
	Fri, 14 Jul 2023 14:20:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE014E551
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:20:12 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2CE3A86
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:20:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9741caaf9d4so252596966b.0
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689344398; x=1691936398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4zgnqP7ASsB+eUpBj68dhMcY1VzfTyfkf9nUd4K0Yg=;
        b=TH0mhba8d76c7Ka/TPMFwg664iBScu0zUMrviGBOrnld29U0ezZQ12/r0PR+0/oaHW
         wxHfKcWtJqqGt0rT8Nh87BExLDIHT4FWrefDnQeTelmuyC+fjSPcVA41NhUb9PLFAaHC
         7h+LaS2nyFQFpSFVQDhT/gKp7ShQGXW/08e0nEBaa/IqWeg1OtAFin07xJ3q+c9Wu6VM
         SGkgBWb1XxwTXtjThxfgKB609GRd8BTw38kPue5yvOJX3O0/fFSZZSd3QJmhqUWczuPe
         bk96qig+pVvkXD6uMmXXfdwPtsrGDbdKoFLzTi8nHsn8iZStYk7AfRVlxZ1MYZCAK1w/
         RpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344398; x=1691936398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4zgnqP7ASsB+eUpBj68dhMcY1VzfTyfkf9nUd4K0Yg=;
        b=GhDresSvKzLiFjf5jd/yxHwNXShIxigsP7y+0Mp3FeTWEeCtODayBCuLVk/Zv/vWIC
         YG5AwZhHBbzYSQS5kTA/YGxZhSvtp5Rjc0+pi8QC1CIoCC8tVKrAAHa561N5f8SsKztt
         cUo1dpqGajEnbIBMgLhtq+jZJ/2+4/Bxkk0d57X3EgV6H/IP4cn+s1X+noORym1U/FR8
         L3+Mf1b/Ary2nZiVDOngnmjzAQvYfZpJDAF2iQ4beMHLD2TParu+SHSCPP9JcOO8o07Y
         LHaRjbG7kPMd2g32abbEjv3ovVJM1+AI0o4BwYZ2i1LW4NkN2+w3HaUuHnIpd7ZfO9eV
         cGJw==
X-Gm-Message-State: ABy/qLa5FEmBDKeNNLptNV3/G9WD/nDr36rGbKuwocM4rrWT76Ob7U3P
	ZywHOA5pprQHy6bp2Pt/R/GuYg==
X-Google-Smtp-Source: APBJJlG6aTI+UM8YICICq6ZGR8uS5qkOUtVH5/T1tGNddtCWDEE72Dhzu9qW4+p9Nb3eFzEA2rgCXw==
X-Received: by 2002:a17:906:248:b0:994:569b:61b6 with SMTP id 8-20020a170906024800b00994569b61b6mr484575ejl.40.1689344398399;
        Fri, 14 Jul 2023 07:19:58 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709061d0b00b00982cfe1fe5dsm5469294ejh.65.2023.07.14.07.19.57
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
Subject: [PATCH bpf-next 2/3] bpf: make an argument const in the bpf_map_sum_elem_count kfunc
Date: Fri, 14 Jul 2023 14:20:59 +0000
Message-Id: <20230714142100.42265-3-aspsk@isovalent.com>
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


