Return-Path: <bpf+bounces-70040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398BBACE9B
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9AE3BDCEA
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42096302747;
	Tue, 30 Sep 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDcwixMd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074353019DA
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236352; cv=none; b=i1EmKpZNIt6fQSOBCNAnfnDe2STFaUBZNJomVKWbHtTlDYI7c+cQkdk3ITfRU1obe9/+ObTpkhIQDHBxDjKMlL4QuG2OKz++g4i/J83TIfS0DaiIauw6M03yoGyNc9xLO3wyunE/h8p+GAIInBZUsFivvusbUa7MDeg33GqZDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236352; c=relaxed/simple;
	bh=hRWw6HRyudjQRzN8bKjzNfgQIK7cN6B4BAgy2ZklIEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhjZckmfP8tnQFrFujnmmx+zzZZ7EtiXZCVWwIOAVb5YPuCYrRdkDR1uHduByMYO4pe91zSBt8nBCQ6gWcYZBcJfas+9XrDbC2ARd9DXMLxf9+ZXqtIsewSbq0jb3vkCMa7D72oTBf4uRmOf5fkwlm0DpmlZcBL/xnTXJHOCQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDcwixMd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso4081778f8f.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236349; x=1759841149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBxnc1qQogcksj+OAiWwQ4t8mVfNeyHphSf8vVmSFRo=;
        b=ZDcwixMdGZ9trEYKI7YyEoWr2+CTLwu5SC4k2G223KXqtMxk2l+KZciIWGKjsC44mO
         ZC+3+PA5ZE3VW9w6ynmSCdp0ESilP38XDz7ihTccg1HRXQucZh/tejv13oppk9qATzA+
         Nq/766VFJtKsxTHLrERxgXncwb7fZ8kGl0NX86a4V6L0gGsWQPCng5O4pzPWjxBysjwu
         jZkBKtUbONuocNE/DgHUjz1vaWV0TTnv1xMIVs7ujsVv3oyylYkAN/zh9QQEw3umCmDi
         wjZL5SmRCJQRnh19m4bUIacqt5L0qruRz0hlJX/hKmwqxbCinpSRUZ8U4XvGbb8lyDh+
         Bslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236349; x=1759841149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBxnc1qQogcksj+OAiWwQ4t8mVfNeyHphSf8vVmSFRo=;
        b=vhojvOpA4YdbDwzUjT4nOj+3Oa/6T0Oow1aVFs8VNOi0u5ZcDlSUX/aFThF8EWkC8m
         0VJtHX5At9k/OgII4FbyZFkrTofnnTbnDJbRQT5Ss7IdHe3qMDj8axV56v9L+rbP0fn5
         TZmRQO3tg9HmOg7bpu289GVk+i/dPScg2iXOTEgv9Kol5lrwRomyhk/k1QNIShT1FK+P
         lY9VL8q3OPr5obnI2mmXsLDdLfpdam+UI1GeofdSeWgtTt5h8F4v383NCINbcndjsUA+
         XVP1E2I+iRHVUte9OCZb1dCRK0Al0et5KHo2NZI4DRC1QS/1rCXzMldVOwz9D6lMHG0g
         YT2Q==
X-Gm-Message-State: AOJu0YwPy5z/shnF/BRhICahtg0T3bSHHdePwi1OnbEFw+sOdZ4zyJhS
	91/5WcHZnmBnxdK0y0Pb/RW8ZFaKOOuT0tH59Ci5q16oVaoNn0bmotTWn9UWBQ==
X-Gm-Gg: ASbGncuveyw7jK2i0WcU7vB6TSO0DHENHn8Hqy0djlku2kLO9+eCxNNtbWo8F6mD/rn
	01NXIftChS/qhCWPA6c2zd9HMgrIzHrc/RSXdu7v1wjk0bwca5Zb+3A1NRdArjTQpA/K2WaXGBV
	qJ7LvGn+IuXBns2zAtSgkMBRHawc6ysnGSr72zf/fPbRIawNQ5rfJxobOqhXKfY6i3JhnQ4uhPl
	kHnd88B25gKeUJiM28megzgXNj4+AuKJqy3XCkrDRndOgoYndLa7JZfyR7/y9H5wnm7qKL50xYX
	bxQfzt6YhnvFCTAcicPmy0kGxjwdjMRepnBpQJUZZKYIxydAnYFsCyPw0Vrrx5rEvuZn7cufbpy
	/5xqp3iDqU8yaLBuCHoK/NXQ/9zRPh7ERXWP9YFCP4KH7+CjbYCOiuRVKnNZd/T6T4A==
X-Google-Smtp-Source: AGHT+IG3eFcbwSx4v9sd8Ml5mbKeTcTB6kkQU1/r9PY+jb7nR9UE6vEQokLTEBqB7UWBk4py5b3HAA==
X-Received: by 2002:a05:600c:358f:b0:46e:43ee:3809 with SMTP id 5b1f17b1804b1-46e43ee3ac6mr129215815e9.7.1759236348598;
        Tue, 30 Sep 2025 05:45:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:47 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v5 bpf-next 12/15] libbpf: fix formatting of bpf_object__append_subprog_code
Date: Tue, 30 Sep 2025 12:51:08 +0000
Message-Id: <20250930125111.1269861-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6c918709bd30 ("libbpf: Refactor bpf_object__reloc_code")
added the bpf_object__append_subprog_code() with incorrect indentations.
Use tabs instead. (This also makes a consequent commit better readable.)

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f92083f51bdb..083ec3ca4813 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6440,32 +6440,32 @@ static int
 bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
 				struct bpf_program *subprog)
 {
-       struct bpf_insn *insns;
-       size_t new_cnt;
-       int err;
-
-       subprog->sub_insn_off = main_prog->insns_cnt;
-
-       new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
-       insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
-       if (!insns) {
-               pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
-               return -ENOMEM;
-       }
-       main_prog->insns = insns;
-       main_prog->insns_cnt = new_cnt;
-
-       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
-              subprog->insns_cnt * sizeof(*insns));
-
-       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
-                main_prog->name, subprog->insns_cnt, subprog->name);
-
-       /* The subprog insns are now appended. Append its relos too. */
-       err = append_subprog_relos(main_prog, subprog);
-       if (err)
-               return err;
-       return 0;
+	struct bpf_insn *insns;
+	size_t new_cnt;
+	int err;
+
+	subprog->sub_insn_off = main_prog->insns_cnt;
+
+	new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
+	insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
+	if (!insns) {
+		pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
+		return -ENOMEM;
+	}
+	main_prog->insns = insns;
+	main_prog->insns_cnt = new_cnt;
+
+	memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
+	       subprog->insns_cnt * sizeof(*insns));
+
+	pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
+		 main_prog->name, subprog->insns_cnt, subprog->name);
+
+	/* The subprog insns are now appended. Append its relos too. */
+	err = append_subprog_relos(main_prog, subprog);
+	if (err)
+		return err;
+	return 0;
 }
 
 static int
-- 
2.34.1


