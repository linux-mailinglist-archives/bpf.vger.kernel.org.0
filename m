Return-Path: <bpf+bounces-3629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4D74080B
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20357280A79
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA46A935;
	Wed, 28 Jun 2023 01:57:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F488C06;
	Wed, 28 Jun 2023 01:57:23 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976DF2D4C;
	Tue, 27 Jun 2023 18:57:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6687446eaccso4813379b3a.3;
        Tue, 27 Jun 2023 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917442; x=1690509442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id52rcowJ7NZMb5+YK4IlpOtkvo0YDczJ2nwiMNvyqw=;
        b=ZCSUtjlRbqWXJJ8JIesLhYajDvasVipJn3pVbYY0jYCmeIXI+Ew/CBahT/NB3GwuTz
         5mMcZpxTCdw3ULfExGOg84c8Keg1nRW87sHw7GuHgPfwAQs8YC5oreWydsBgccrIHukT
         npDhRdQREDNfe4ghjNZsJDLFlRh7pGq7tTA47tXpOde56gNuuZ99Etx8DTRwVpxG57Xx
         ox6WwSqFxRRR46V3ILp8YRiwlXuxWaSDHGS6CKbsuQzP2sRwEe1qqDz946dj+A7O7oHc
         aGF8BR6Z9TEdIAeoZvst1Qno6DfXzmOkmKU2euI9o4n8FqiNwbOcVVWf6NNEGm0qq9LI
         GCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917442; x=1690509442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id52rcowJ7NZMb5+YK4IlpOtkvo0YDczJ2nwiMNvyqw=;
        b=EsYZGnh4jyuTXIWuyWdhsppDVNb0DTg4+WIR28YZG9lDsMGJgjcAx3CeTvp0WRdnu2
         ZzO899+qVIdjNOqoQ14tzCA6iNnnJseTQxxxHJq2mtME8Nd13/CqovvmD7EwbuBBoAWK
         /+CY8HJrBrZYMpFFIrce9OHjZyJ5a263TU2V1o/T8prQHZtNZTN37RugDBQmLqCwlNhx
         HS/yxkzqM3QH8igd5QQg1mwi6P4Ls5ERhwDvBXAznBUX+2A8BJ/cOANFXDnpfqAQKuPa
         21CeyBuetPXtjZITvoaVASqRmeOjforgFpL6WvugG6O3tCBKQALj28CK221To6RxohhJ
         ycuA==
X-Gm-Message-State: AC+VfDwHDb4Sm8yBrYyRVprDCS5NPwZEjpivHp4fYac7Ppf/oy0SINQo
	bR5gf057Y1HSZ4+lzX/hvfc=
X-Google-Smtp-Source: ACHHUZ7LIuf7QuI0kKroREU1alyb8GoYkxjYwGhB7PdhGL/R8EVBq+wTCRcmclDpn4QKeBt11mwOYA==
X-Received: by 2002:a05:6a21:99a6:b0:125:87b1:a30d with SMTP id ve38-20020a056a2199a600b0012587b1a30dmr20011745pzb.1.1687917442054;
        Tue, 27 Jun 2023 18:57:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id w29-20020a63161d000000b0052871962579sm6224217pgl.63.2023.06.27.18.57.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:21 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 11/13] selftests/bpf: Improve test coverage of bpf_mem_alloc.
Date: Tue, 27 Jun 2023 18:56:32 -0700
Message-Id: <20230628015634.33193-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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


