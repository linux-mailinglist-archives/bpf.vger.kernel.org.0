Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA911CA89
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfLLKXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37496 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfLLKXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so1663730lja.4
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lb+PxNY/e35zOCvcdNaHpr04cM3kwu+trmNMlv6bwBw=;
        b=QD/2kLcLpyRRr//0OQ/c83CbVH7C5rPX4PhVkWVI43ojlGxeite9N2zNxkn3LsZSF1
         gOJUlmw8Y6yuXpI2Pt6JG+6l1JhewDOiBDK0JrzpIzDklHvm2nKswvTciWTWY+ugRf2w
         V8I+s+kzOGIW2OU3Jq8TkdMs4c2PMywSjpB5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lb+PxNY/e35zOCvcdNaHpr04cM3kwu+trmNMlv6bwBw=;
        b=bQ6reHamMelMjM9trLqVlHJKURk2bsAfyj+3beOUzY2E6dfPNjJ7gRbPc65UvJDwvl
         sLl/OPn9s58kWCTQIwNaEcvc/T/62iejF+oDgZ03LxCvmuB6CtaxCyhNiTq+rgmJeNzA
         /JKIwlbIgVFJhArM8FGsuBRkBjPBJl0eqKYFi3IT67YRu28c2OwwKuzC3UzHn7UZtfiY
         2dEiVGd5B1USQVBBioxVxo9KpAkHWBU83J1ZnHjwcnH4OhTGRX6sUYAakEF2lIsje8j2
         3wyyiEyrLMYS61ev+wajAHNKM5YJkng64V0wRiw5xK0viMsVb8618OOP9AKefPW6kLAI
         wqIw==
X-Gm-Message-State: APjAAAWfMBZT7v/hBQcqkV1kxhMdUyE7Fa3qHFoZzpEJwyVpRcSgafRj
        9Tz9WuBqX50bMJzODPCP88NHwy5nkYOWqg==
X-Google-Smtp-Source: APXvYqz2WzTHqDZmvo/yoiVBm+1dIpBO7DmYW1t6i4Crq7E3zaayWUIswMcI1KdLC52gx+stn7grbQ==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr5437191ljk.201.1576146183201;
        Thu, 12 Dec 2019 02:23:03 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id n19sm2649647lfl.85.2019.12.12.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:02 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 02/10] selftests/bpf: Let libbpf determine program type from section name
Date:   Thu, 12 Dec 2019 11:22:51 +0100
Message-Id: <20191212102259.418536-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that libbpf can recognize SK_REUSEPORT programs, we no longer have to
pass a prog_type hint before loading the object file.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/progs/test_select_reuseport_kern.c |  2 +-
 tools/testing/selftests/bpf/test_select_reuseport.c  | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index ea7d84f01235..b1f09f5bb1cf 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -62,7 +62,7 @@ struct {
 	goto done;				\
 })
 
-SEC("select_by_skb_data")
+SEC("sk_reuseport")
 int _select_by_skb_data(struct sk_reuseport_md *reuse_md)
 {
 	__u32 linum, index = 0, flags = 0, index_zero = 0;
diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index 7566c13eb51a..1e3cfe1cb28a 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -87,19 +87,11 @@ static void prepare_bpf_obj(void)
 	struct bpf_program *prog;
 	struct bpf_map *map;
 	int err;
-	struct bpf_object_open_attr attr = {
-		.file = "test_select_reuseport_kern.o",
-		.prog_type = BPF_PROG_TYPE_SK_REUSEPORT,
-	};
 
-	obj = bpf_object__open_xattr(&attr);
+	obj = bpf_object__open("test_select_reuseport_kern.o");
 	CHECK(IS_ERR_OR_NULL(obj), "open test_select_reuseport_kern.o",
 	      "obj:%p PTR_ERR(obj):%ld\n", obj, PTR_ERR(obj));
 
-	prog = bpf_program__next(NULL, obj);
-	CHECK(!prog, "get first bpf_program", "!prog\n");
-	bpf_program__set_type(prog, attr.prog_type);
-
 	map = bpf_object__find_map_by_name(obj, "outer_map");
 	CHECK(!map, "find outer_map", "!map\n");
 	err = bpf_map__reuse_fd(map, outer_map);
@@ -108,6 +100,8 @@ static void prepare_bpf_obj(void)
 	err = bpf_object__load(obj);
 	CHECK(err, "load bpf_object", "err:%d\n", err);
 
+	prog = bpf_program__next(NULL, obj);
+	CHECK(!prog, "get first bpf_program", "!prog\n");
 	select_by_skb_data_prog = bpf_program__fd(prog);
 	CHECK(select_by_skb_data_prog == -1, "get prog fd",
 	      "select_by_skb_data_prog:%d\n", select_by_skb_data_prog);
-- 
2.23.0

