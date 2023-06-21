Return-Path: <bpf+bounces-2976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F0F737942
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111C4280BFC
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DFC2D3;
	Wed, 21 Jun 2023 02:33:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85100C14D;
	Wed, 21 Jun 2023 02:33:24 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0EB4;
	Tue, 20 Jun 2023 19:33:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763ca800ca9so5173285a.2;
        Tue, 20 Jun 2023 19:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314802; x=1689906802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id52rcowJ7NZMb5+YK4IlpOtkvo0YDczJ2nwiMNvyqw=;
        b=J3PGKBdPnjukA0sbhXRiwBk9g11KFflhzOYtZlGKS3eTknSgMCmyWtsAc2zmX81t9v
         lHFG6JJqWpV85kJJHshNZXmwqebgurllmC2LtbFLxgpSh865LwfWTzvHlyawMfqFQt/w
         G+qtNWCQPNdCupAsfhSRnM8M5j74Ory9NPSMOFiTndZQ8jUIK8JhKcadAjvWb2ReU7Tn
         FbLjjtoKcEjUcvWk62mzWuByVgqIwjMHNrR5rz32u5VG11HrTL/bBuPfHnsZw9QouQv4
         9tp5aA5SfTumwPkUiC5k+k0rd2YUHo8Ru1Bf4sOKTcJMftb8qdwANMYXrzuzZ2Wsv8hk
         jBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314802; x=1689906802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id52rcowJ7NZMb5+YK4IlpOtkvo0YDczJ2nwiMNvyqw=;
        b=E5EP1vRlxzkq3XSHX4Zyoh9nN083QSwBiR1ev9eKigrUE/Lwix2Oh4NS/rAoGFAaRA
         ZOnBcil3Fm3+9zQvbE1HkGOSM+aA42XL7cAgBb6cA8amfukz8Z/hxbnGbfebO7yoBDF8
         t3oIVCyV1cwInPaQ7ZmPn+hQRoWryFLjwc9lGzvFS3OyClzDvwpLx0CCb4z0RqKccC9/
         iA3m6txG+hPq8280eG0DTijyOkA0rN0lGMSvaDMPgXAGY7QznWSO/uC8TiHMvTlzaydI
         XDz1hIbrXFz/VYTqnuQEEYvxZP6zEMOd40frVl4BwOQBVHdZs/o3DTcH6p7YfcNW6hBW
         9vaA==
X-Gm-Message-State: AC+VfDzns9kZFPIGo1zsh0LaHB0zd9Ft0ypRpePJngbaqiVtPbmv1CMw
	dexoMLBau0Y1esh2Q50kHUCUx3FymTc=
X-Google-Smtp-Source: ACHHUZ5qdum4e3IJtgk7T78so98Uamyb1AHH6fQlnjkm7duA5MKeRlBWHw2RnbPjssxK1/OibjxjyA==
X-Received: by 2002:a05:620a:4d88:b0:763:c1d0:f846 with SMTP id uw8-20020a05620a4d8800b00763c1d0f846mr446014qkn.54.1687314802291;
        Tue, 20 Jun 2023 19:33:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id a5-20020a656545000000b0054fb537ca5dsm1776634pgw.92.2023.06.20.19.33.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 10/12] selftests/bpf: Improve test coverage of bpf_mem_alloc.
Date: Tue, 20 Jun 2023 19:32:36 -0700
Message-Id: <20230621023238.87079-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov <ast@kernel.org>

bpf_obj_new() calls bpf_mem_alloc(), but doing alloc/free of 8 elements
is not triggering watermark conditions in bpf_mem_alloc.
Increase to 200 elements to make sure alloc_bulk/free_bulk is exercised.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/linked_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 57440a554304..84d1777a9e6c 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -96,7 +96,7 @@ static __always_inline
 int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
 {
 	struct bpf_list_node *n;
-	struct foo *f[8], *pf;
+	struct foo *f[200], *pf;
 	int i;
 
 	/* Loop following this check adds nodes 2-at-a-time in order to
-- 
2.34.1


