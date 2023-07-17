Return-Path: <bpf+bounces-5114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1A97568DA
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385CD2810AD
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE4BE4F;
	Mon, 17 Jul 2023 16:15:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12641253CA
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:15:56 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E21715
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-55adfa72d3fso2607836a12.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610548; x=1692202548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKrz1A0vGFtHcHg3EaeYTb9Cdgqp8lyQvCacQQZZF1I=;
        b=jXe6z2alpLdUGc5aL5mvFKtqJqSmI/z6BMuiMGwTjZ5XGEwJFVyYqQeuH/WzMmpDIn
         yTnIFd1EMKOdn7DLqXusEsCA/DA8IGfCOY/TblGDpsiCXCMz/VbADiSC208nedcyNl8U
         LpSH8lUWgjt7HKTSHS+knOC6w5nvpTmAtUsOn64QC1pcQKrKXYcfkj6RQxhB27UQ3heX
         5bYIRqqisLdpQjWUDJKMo9rbTZfwaDSTaGi6pOYfmfnv+BkffnilgaC/HXXCT6rM8Jir
         qVj8ulX7VLXcw5SM7We2+FnX9Ptpn+d4jTgsAvutwEotoAF7K8QTHi0r+MAai3+A7vZd
         w+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610548; x=1692202548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKrz1A0vGFtHcHg3EaeYTb9Cdgqp8lyQvCacQQZZF1I=;
        b=SVhqjbBb9jlOJrXeNv80aB40/ee0wUo5DS2D4n/1NG3l9AxvKTP+UcKdEfn1SChRw9
         K7K456Bhxsxh6VykhmuHzOI9LSALnj4KOakbPLNqGppw4+t2rJqPKVEv3+Tlt0wqzAwZ
         yVju6wxuKW1LYOk7bWaG4Wyn5X09StfIUSDluhwXkkoGBRtY93QOuy8GPrGZF5ZfxkqL
         QSR03FewC7naAQMvkI2BA3SAf9itB2L598JXSSpPjoVoDHnfH+DtX2u6mu1tYq4qbIQk
         LucNCgqTE8b+33BC54Q4395mh4gxvFd5KL0qHeiuMIC9QjPypD8rXDe9YU8qJYVQoDnW
         V6Hg==
X-Gm-Message-State: ABy/qLaCz44iy3fqpm1lV5NC0kX7prDjOJAbSLgGWOws7/xj2ncRo3S9
	QwL4+sQw+wiXBqtO8a7roSnEv3qCQjl16Q==
X-Google-Smtp-Source: APBJJlElcGIqpofulNksznj+eG7t58ieUZ9ua9BvD9xFWLV6i7sp3aql05mZP7WHTc5nqY9O3iiOCA==
X-Received: by 2002:a17:90b:4f8d:b0:267:6c28:17b2 with SMTP id qe13-20020a17090b4f8d00b002676c2817b2mr9581910pjb.7.1689610547857;
        Mon, 17 Jul 2023 09:15:47 -0700 (PDT)
Received: from localhost ([49.36.211.25])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090abc4700b00263ed4efa9bsm74953pjv.19.2023.07.17.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:15:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add more tests for check_max_stack_depth bug
Date: Mon, 17 Jul 2023 21:45:30 +0530
Message-Id: <20230717161530.1238-4-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717161530.1238-1-memxor@gmail.com>
References: <20230717161530.1238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=memxor@gmail.com; h=from:subject; bh=wYIJHcKzPwNySuFQ464kcwZ+uH75u3RqpKzcvaAjzn0=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBktWjgiG8xYHfHEx8yN0IsiLmd5Nz/Sv7V4l/fO BuCz7QK+TKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZLVo4AAKCRBM4MiGSL8R ysmxD/0UxGlgdlDwi4Zh66f/UXsTTBi5TcY6dRtP5dXOlQyCB03UoGBdCHxgNIX40Ce8+FSQVM1 7J6xRmt8k6485AjLqX9Lk9wHWfpCBDEpSsYBQ3kDtcV1Lpkq8nsnRPFRQ5JntkB22F/DHsVHUTZ EpioArL8/nKTS9DTMVviu401AOGlnLG7tWzpSlnjSHzDYE5EbEsBtZBb3SQ4DV34yc5eL6mlF4R wM+118wo/UC74+/jHV0KNHKQpJLapxon8IgNa3EeEoL2AC4fiJQCP2q6uuPRjAvLYoJKeKpG0zk WBYgw8Lawxio1WLzvy+VUO4jUnoyt4Fne1/1IftswGksEP1c0C4B2lAWOrh/kfdwht6w16IRRQJ nKQd95lWMksPSfdTWM7Djr0EfAn35nJyoZZU2KcPS6UrWWYpU8d0sd1eXFuMGBFatGDNbpeYbw9 VEsRQvbFMOgnFn/I06A7JQ23SF0k0j14ZRsqwzNZKOKM8DbwhOqFDv1Q8VmhUIYHm++5mBxCI00 53fBI0qt/jH7X5YGYn+tW2rkPykVESr+zXwhl/jyNA1a/PybgPTjZG/URD8cupxSJ/eEMTvPPx4 Ny/8C6QHB0CSnf0Xh9hMlbKN2vQsk8uu9AZ2y2rXJ1GwDCxgrv4pviGIA1MVmqsEAdOWQZTITMd A2R1TV2cbX/FzUg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Another test which now exercies the path of the verifier where it will
explore call chains rooted at the async callback. Without the prior
fixes, this program loads successfully, which is incorrect.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/async_stack_depth.c   | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tools/testing/selftests/bpf/progs/async_stack_depth.c
index 477ba950bb43..3517c0e01206 100644
--- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
+++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
@@ -22,9 +22,16 @@ static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 	return buf[69];
 }
 
+__attribute__((noinline))
+static int bad_timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[300] = {};
+	return buf[255] + timer_cb(NULL, NULL, NULL);
+}
+
 SEC("tc")
-__failure __msg("combined stack size of 2 calls")
-int prog(struct __sk_buff *ctx)
+__failure __msg("combined stack size of 2 calls is 576. Too large")
+int pseudo_call_check(struct __sk_buff *ctx)
 {
 	struct hmap_elem *elem;
 	volatile char buf[256] = {};
@@ -37,4 +44,18 @@ int prog(struct __sk_buff *ctx)
 	return bpf_timer_set_callback(&elem->timer, timer_cb) + buf[0];
 }
 
+SEC("tc")
+__failure __msg("combined stack size of 2 calls is 608. Too large")
+int async_call_root_check(struct __sk_buff *ctx)
+{
+	struct hmap_elem *elem;
+	volatile char buf[256] = {};
+
+	elem = bpf_map_lookup_elem(&hmap, &(int){0});
+	if (!elem)
+		return 0;
+
+	return bpf_timer_set_callback(&elem->timer, bad_timer_cb) + buf[0];
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.40.1


