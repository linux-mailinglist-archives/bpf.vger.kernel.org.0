Return-Path: <bpf+bounces-8287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4047848B7
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FCC281168
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA91DDC0;
	Tue, 22 Aug 2023 17:51:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2179CF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:51:53 +0000 (UTC)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE52CEF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:51:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-68a6cd7c6a6so871384b3a.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692726710; x=1693331510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMQ9h7kf4eznjMgNFpxxScKtpArHTspf3R2UQPNlXrM=;
        b=dv3pRrl36tIbwsg3O3rc0yXC5hQ7tp9vSa+S3tAq9ZSgS+YzxGbdxjNCajEKetqFJp
         Wg/TEX6S8IolIk6CUJ4W/sRN4dX0rkHIWmEdC0l7iM1TjgK8/odQxWxV21H6WBHcD6ba
         TqPA7KhkjvEhKiu8xU7U3/FJRg+6VpvZN35zCWEzhc+mejYY5yTbsJTeSxKW5Hp1kmS0
         wFtQk2yUg/SFaO16DVScMOUKk3ko0d/KGxeKsumvvAfX8esGLC4q6dT3UmQxrN9QF6Oj
         o5zdHuBKhbFxSxDpLsIt29RnLQekpDQQC3aHpVE0aLKhbF0zJ4bkKtGFRZN6wpRzGbnV
         zP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726710; x=1693331510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMQ9h7kf4eznjMgNFpxxScKtpArHTspf3R2UQPNlXrM=;
        b=O1ogaZohfaJdAraHOh1JyjFf1/rv3cgmkcvrLitwqszxDYBKz4UPmFsGbe+CeNhlxz
         vsoqgmtZcW7WLaCuO/XLkpcxtSbV2qOLV1CmipFUVWj3JapEebX3oVef8hB2D/2Rgm8u
         nRc0dZkyVNdWq9JDaAv4NgMcBK8PvzXbupBVon5K8+7K5DH2+VL1vO5Vv8HOFdM9Cypu
         H+XvSeTmMGodY3yVa9LQAGm6giw1ubT5vs9RMoifVe2e4rmmGHIPzydKdms/49EXOMyD
         NqHuicelByZv6OosPoFGDaAh3yoqf3NiO40fCL5huvkGzyfWT8TEXRMfv9maK/2OFQyz
         SU6g==
X-Gm-Message-State: AOJu0Yxi81FN4iXFbIJwhMUt1UzWps111/k1CXevd6UGAsC4JHcjqPDj
	SqXYc3JdbNuXv0HUjG3KhvsoGjrVrcortcmp
X-Google-Smtp-Source: AGHT+IHF2ewJ+HnWzorFyjBNGQPP2ewa438wlLGSijFHBgfMbM/EZPf1CZ92pt7k1JaIandQ5t5VQA==
X-Received: by 2002:a05:6a20:7d8e:b0:140:730b:4b3f with SMTP id v14-20020a056a207d8e00b00140730b4b3fmr10460025pzj.1.1692726710468;
        Tue, 22 Aug 2023 10:51:50 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:46af:61ea:5ce:65e2])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b006870ff20254sm7992949pfu.125.2023.08.22.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:51:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add test for bpf_obj_drop with bad reg->off
Date: Tue, 22 Aug 2023 23:21:40 +0530
Message-ID: <20230822175140.1317749-3-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822175140.1317749-1-memxor@gmail.com>
References: <20230822175140.1317749-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=memxor@gmail.com; h=from:subject; bh=lkT+Pch/nDc8SY6j9kuwYs1NLcSw25lzZch0x35xrU8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk5PV1ZH4RjCNPBeCJg5RX5u9lfn8+13N0eZIwT hcSUOfp+5WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZOT1dQAKCRBM4MiGSL8R ypm8D/0T5pQTOdhqs5myvF256gTCaVejqk8EcpUAr6atdhqwu13ZL6QkTuSClf6y0lObOPwigsv 8HFUA6ZCv3Jh0nuO1lAYCHKNIw240nj45ykaQ6fg6RIXJaBlxVNrZ7b3iPN4iom6a/jdM3qZxnh 5S57Am6IbYMtb/l65GNECl7LtCAfELVbIFbtJPbtGqjUCNGdjBYN5YfczpMlm6t9U+/IUNQFp3t x/YO17j4IU4hbn2YGiJTeld26RbZmZN2fgjiCtW+e1vlG7OVGky7UIrtHrJ3XNnKU2V29Rf1/nX 0i1NQvNWI9w/uOBPw4zv4Kjh5yZ2Gkh4vpwNr1coR5cYXxNT8krcqnQOJwOiqP3uZzWhwyXL9ZP sg9i2bBWg8aZ+kZ1m0hWXLoqR7kU7TC369UqIhDQA9VTSXrCgSydUVhjlIwU1wscPsEMDnxtyZc UjnaMcDw4T9riDNh5EYOi1JF6zypeuhh4amw3kYCigxjpX0V23kCEk8rWh54sF51fUTHrDwF++D PBhsjo2n3j8kVAY7grN6vKMxpfPtdkGr+nFAHrPq8kKv5WCV6jFpg7qTdblPBb/qIE6wzCvX+zW OGgzaoAd4JMs74Uuqfx2ML5pvI6kuf5quXF/fIaRPul/rMQxlKephvvwndcW/ZvQ+9njDDfHQ4L e9RK/KK2bx+DHvA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest for the fix provided in the previous commit. Without the
fix, the selftest passes the verifier while it should fail. The special
logic for detecting graph root or node for reg->off and bypassing
reg->off == 0 guarantee for release helpers/kfuncs has been dropped.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/local_kptr_stash_fail.c         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
index 5484d1e9801d..fcf7a7567da2 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
@@ -62,4 +62,24 @@ long stash_rb_nodes(void *ctx)
 	return 0;
 }
 
+SEC("tc")
+__failure __msg("R1 must have zero offset when passed to release func")
+long drop_rb_node_off(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *res;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	res = bpf_obj_new(typeof(*res));
+	if (!res)
+		return 1;
+	/* Try releasing with graph node offset */
+	bpf_obj_drop(&res->node);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.41.0


