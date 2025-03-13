Return-Path: <bpf+bounces-53990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19513A60068
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083CC8810A3
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C81F3FED;
	Thu, 13 Mar 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny2p3jwQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810B1F3BB5;
	Thu, 13 Mar 2025 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892608; cv=none; b=PZl3PIOdWDuxSAakBwy9UPNTaFoHVcGrhpT4XLfDFP3y8o92dxZXiWdTCoBB0DXGvPQpcE6C/PjuIFI8DuU/EMXhJ2J47CBya8uLDxYyNeikrjt1C8aGu9uyhZxbAkLIn5LRbvBEBuNmKKJ08gcjz9h0pSiNgT5a/w8uSTBramo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892608; c=relaxed/simple;
	bh=vPF4pu/P8uuuCviRPth91G084ytUrBykEU3WXlDjZ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzVUGrV+EvXff4FItTTzRqRHf2F4cr/nrsUpx/Emi58exyIyXBsmmA7wAriYdOSHh6tGDVpauqqlKH80zXIRGM+ahGJ7nswAhQSUZP6dWdR415RMuX3OmHKnxa8hJyxq6dqH6PtLAckq8zG9F8mrOBD39WGj5sq+olgmAxFN91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny2p3jwQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223a7065ff8so37043615ad.0;
        Thu, 13 Mar 2025 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892606; x=1742497406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+Y9OxGeDSUuz0ekM5BZDl8hgTH17GlThABvm9XWiw=;
        b=Ny2p3jwQO4U4hnehjrK3XDNLUTsHpo4vFOTV/DJC9xg3YPpr9krm1JL43Nq0TNhU2f
         bis8l2rA0BRIwAzBVKNnpyggXkT/TRYeAPBc6XFMu9C0OBlheh7t9o/Y4f3U9FgyJ90z
         oCZ7FGQT/xIs/I5/v5/r6L74drKM0N3YDAA9ZWB8SpUaBOawacoVPLCjh8ZCRx0T2Mf8
         0fcI0N4MeASxkyUmsjTwfOv7rYFEzQiZle0DUGzHluc/AKNvz3zN94o4c4WkGfr4Ea9H
         DICISwP3ZV6daneSa+AWvHuigE/uc7r+rJQ+ECA7wiPJYRz0Hk+R2f7EVZJf9aTPXcCT
         KNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892606; x=1742497406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY+Y9OxGeDSUuz0ekM5BZDl8hgTH17GlThABvm9XWiw=;
        b=Je4UW/IJI2PEfA8w1dMfn535UrTIe0P87iICkoGUyoQzukrMK5cgx2qu9yypa8g6/x
         uwnea2sG973cRtRXvYd5IX5HOyXYl+8tH5NcABGCG3DnvAsRCCEiA36IKXFQWEpszNkO
         dyECG0HV7N0CmKqfcG/80E45KnBwl1cze7TLMT3/OkOpIodStx08YU0uPRyEj5IyLgD6
         0jU2cPjzeW9TY3U+rF9XFo/6GnB0S+RFE6UrjHNtgQy6E3HnpblZciRMi+8iDqZzZ97b
         emuZbbbWiPNrWLT9cu+0QYCUdUt0O2aSS2KzHWJMXen7K2224+ZPunMkEG2CQsnHerc/
         PhGQ==
X-Gm-Message-State: AOJu0Ywrzocm9cU19+ixO8uAY70tfYzo8uko27ffiJ8UUJptnmsjUpvP
	R2vBlFWZTIjcL05aFUusbaHLgDOmPr7YLTzPNQnGZQzZcfVgtQyOSCEgNTPruk+dJw==
X-Gm-Gg: ASbGncsGKX9wYQNlqOzBUELkRz9Vw9zE/I0Y1/MFUoe8oOpOnFGNFpgZk7AYqmlhU+O
	UOcRcr1QbFhGk1PyYqAeD+5TvN6GdGAUTPWHFfS6FN0Al+COLVOFvZmfWhF1ULPad6+4dRmmiC4
	FLGepWZI2pmJNsL+OMmdNFP16LGXPBxruPd829VGaxUT74KM+QjiEHFqFbP29sIBRNoTUe7WBqZ
	jiR8QbGjN2n0tHj4S80ihVe9UWXvLLF48Gti1V3QqZE1pL/W0pIM+5l15wLHUMd5MCrKWjuTMML
	hefko6XKuJtmDYc27vOieHN1QdRY9rhEYwsq1Crgcl0I3BuKSZbcEBYr1JjN0f9MMzgUeNcdw15
	CxEiBlYFb02qLAIzS+fR0+JRsXSaM+A==
X-Google-Smtp-Source: AGHT+IHEWyhsNjlW0lbTXQ8cUQBj7X6D1W1T55Vt+rww5yrGqETiAt+Ps8ysYrHQNJswgQML0/MKfA==
X-Received: by 2002:a05:6a21:180a:b0:1f5:591b:4f7c with SMTP id adf61e73a8af0-1f5bd8a945amr1169141637.10.1741892605797;
        Thu, 13 Mar 2025 12:03:25 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 07/13] bpf: net_sched: Support updating qstats
Date: Thu, 13 Mar 2025 12:03:01 -0700
Message-ID: <20250313190309.2545711-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Allow bpf qdisc programs to update Qdisc qstats directly with btf struct
access.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 53 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index edf01f3f1c2a..6ad3050275a4 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -36,6 +36,7 @@ bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
 	}
 }
 
+BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
 
@@ -60,20 +61,37 @@ static bool bpf_qdisc_is_valid_access(int off, int size,
 	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
 }
 
-static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
-					const struct bpf_reg_state *reg,
-					int off, int size)
+static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
+				  const struct bpf_reg_state *reg,
+				  int off, int size)
 {
-	const struct btf_type *t, *skbt;
 	size_t end;
 
-	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
-	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != skbt) {
-		bpf_log(log, "only read is supported\n");
+	switch (off) {
+	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
+		end = offsetofend(struct Qdisc, qstats);
+		break;
+	default:
+		bpf_log(log, "no write support to Qdisc at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log,
+			"write access at off %d with size %d beyond the member of Qdisc ended at %zu\n",
+			off, size, end);
 		return -EACCES;
 	}
 
+	return 0;
+}
+
+static int bpf_qdisc_sk_buff_access(struct bpf_verifier_log *log,
+				    const struct bpf_reg_state *reg,
+				    int off, int size)
+{
+	size_t end;
+
 	switch (off) {
 	case offsetof(struct sk_buff, tstamp):
 		end = offsetofend(struct sk_buff, tstamp);
@@ -115,6 +133,25 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
+				       const struct bpf_reg_state *reg,
+				       int off, int size)
+{
+	const struct btf_type *t, *skbt, *qdisct;
+
+	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
+	qdisct = btf_type_by_id(reg->btf, bpf_qdisc_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+
+	if (t == skbt)
+		return bpf_qdisc_sk_buff_access(log, reg, off, size);
+	else if (t == qdisct)
+		return bpf_qdisc_qdisc_access(log, reg, off, size);
+
+	bpf_log(log, "only read is supported\n");
+	return -EACCES;
+}
+
 BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
 BTF_ID(func, bpf_qdisc_init_prologue)
 
-- 
2.47.1


