Return-Path: <bpf+bounces-29972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE98C8C91
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5843B1C22F07
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E4013E405;
	Fri, 17 May 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehAW/4YU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73086A005
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972773; cv=none; b=f3Gh0OOudctuZ7qA1nouXeLXpqBlDKJIaVO+wjqOfoug6GmftTrSjJbR8rfnkMw94gPHf3evNlIMVMaPXUUG2LA6AcHapECRApDmk/8V0ZNDYF7w14Kw4JDuJWC0nVkkQ6ZGb6eDdaPHa4BETzsF5hzaxRom5WJPHsTc7AXlhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972773; c=relaxed/simple;
	bh=vRFX16U6ZbdJl60Rk6Q+Np2bjeuuL0xQY/q2key0MFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C81ZfRLDUC+KvwBoZcmnygSkbgP+ng6rsZFH1rrzVQd+KIaFmBQAkMT17ofZ/TH/h01ge+KG1KJ59+ufnTai86e2EuWwi2cjfMb7FfmjfkkpoviBpPz0I8kYKC6JiOrpGf7ProLt7dH7TyUpN+fQEsJCZozrc6RoJrEOZsJO8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehAW/4YU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so70858a91.3
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715972770; x=1716577570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppcRlxhCgqPeJ/eCCIUZ+FHjvruC3n/kAnhmMV53fKg=;
        b=ehAW/4YUSE3aBB+p7qM3GIz3RQCBclOppzqKJYGMDu2q9CyzvX/jnP6uaj+9Ts9VBa
         bpRTO/WZykRbvMbhc/ZcadsZ3CmkCQCT9n3pfIX4yPfTExLp2tDmw3UpfQYqeDSp3mZS
         AzzwuP6+MU3NNWU+yp0dYHUFyXvU8oKQHX2sEW/AjyEkTawWDtaEflWAdLNV15EPTNRl
         /5zUeQrrx9KHaqDlVbaOcr5kJDepzz45QBHiX7jPwo5333qAL4ntcmqNwyocKV8wbHLN
         Y7yhRG7pSJvdYVju1oEkgWHyHimkcfutPPMGEzXcIEqDzU6z9HUAGjBdY7VrSY7dDGp2
         JZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715972770; x=1716577570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppcRlxhCgqPeJ/eCCIUZ+FHjvruC3n/kAnhmMV53fKg=;
        b=CdwmZZKyS1bcA4348VmoF4wnjv9cTNdG/gtvXdG2oLYhnsvXkCEQud/2qXQka6nIWI
         VqURss6j9XPnxnhIbVJiHxPBaCphA+6EYvFIDXgUNVZiVVFa1iq1avroyB0BBMsJftnF
         +lHajhj6xUzcQQc44iNuwaQw6rAnL9Wn1qHzjd6oVnQAuNv0aP3aivkXb/VlGAxY6uZz
         oTBmbeUqx05gGjn3a3pZuIYupmS4T+i0OZ7LNWgP6o9PPUbQIlDI6qABufmPVdbaHgUN
         Y1czzLIVVkWQ45nQuKR2NMngPGSCKrjfbj/9Njtg30D9IaMie5a/orYcl7b8IVMDF9jb
         4KXw==
X-Gm-Message-State: AOJu0Yyw6fR+/UwUC1d7W7+b33D5que+ymq6s9SKDx8yOQAH4AdlS/uB
	gLlS6DbvodeOtl+rCFuL0H0V1IG3SgWXYlxlGVv6301RYmOOQbPNR82L3g==
X-Google-Smtp-Source: AGHT+IEG90JIPJu+D1jH1HGz328jn30MkLnCYb5jjG4WQGm2FhaUl8UU/lcdo6GMPdL0qWp/Pt4+2w==
X-Received: by 2002:a17:90a:d686:b0:2b6:95f6:b79f with SMTP id 98e67ed59e1d1-2b6ccef2f54mr20868672a91.33.1715972770500;
        Fri, 17 May 2024 12:06:10 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b9ddbcf05csm5459747a91.45.2024.05.17.12.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:06:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: corner case for typedefs handling in btf_dump
Date: Fri, 17 May 2024 12:05:55 -0700
Message-Id: <20240517190555.4032078-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517190555.4032078-1-eddyz87@gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corner case stood out while testing:

  typedef struct foo foo_alias;

  struct foo {};

  struct root {
	foo_alias *a;
	foo_alias b;
  };

btf_dump_order_type() visits root->a first and root->b next.
If 'foo_alias' is marked as ORDERED when visiting root->a
type 'foo' will only have a forward declaration.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/btf_dump_test_case_ordering.c  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_ordering.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_ordering.c
index 7c95702ee4cb..e542cb8fb3f4 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_ordering.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_ordering.c
@@ -47,12 +47,22 @@ struct callback_head {
 	void (*func)(struct callback_head *);
 };
 
+typedef struct foo foo_alias;
+
+struct foo {};
+
+struct typedef_ptr_and_full {
+	foo_alias *a;
+	foo_alias b;
+};
+
 struct root_struct {
 	struct s4 s4;
 	struct list_head l;
 	struct hlist_node n;
 	struct hlist_head h;
 	struct callback_head cb;
+	struct typedef_ptr_and_full td;
 };
 
 /*------ END-EXPECTED-OUTPUT ------ */
-- 
2.34.1


