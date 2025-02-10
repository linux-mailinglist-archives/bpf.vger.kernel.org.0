Return-Path: <bpf+bounces-51020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695EA2F59A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDC168BBA
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03B25A344;
	Mon, 10 Feb 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0XIylxk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0E259486;
	Mon, 10 Feb 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209444; cv=none; b=Kcg5CnrYdoMoAjEoeLu+fERQhZ8g3738la64zud0mKgqejpcZFuDq7j0VYUs4zAu6KSMuD9zSDQB5nrk0E2kQg6OGTSBRav8xzCrdiQ8C7gFPiDN+Ft5wgjGxd/49Dffiun2HVgVzYRsf9s6W2s1NCII6DPtUgmBg0VBZJpG5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209444; c=relaxed/simple;
	bh=vPF4pu/P8uuuCviRPth91G084ytUrBykEU3WXlDjZ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po/+LmhU+9eO8phS0/Ra3sKjJKpZ7DkjU0MiRbw2PTPYWR1jEM7i2XWiJOaByo9y3jQ/0A333Qt30O7Y+CidsJEA+LYov8+I3A15ul68ycgdoM8clhjKZ5ix0e8CetmUvg9tqvqxNYDamg6K/r/mhYhxr3faD15zp5221ev2sL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0XIylxk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa2c456816so4659367a91.1;
        Mon, 10 Feb 2025 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209442; x=1739814242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+Y9OxGeDSUuz0ekM5BZDl8hgTH17GlThABvm9XWiw=;
        b=a0XIylxkEEbGMxqYCjDpObWFWFS4CVhJHd76ajp4DDOJasEHFnd99au5shqceVdKnx
         XUQqQ6N8/J4DDNGm0QV8H0aRkmyPaPn9UiuAjFwrTQu33zy1ZQ9i8t6yVg0D3LMWaQbd
         yPFVFBiFzQ73znbKafxcx0oOuj/tp5densJHIyEtHrTr7PFnvGN12u7sUHoZe91803cN
         +7gIPAxTB8KQhE1t8cye/+gDBnWKkBiTbLPDGcgJhY1xUPiYIuvrqWbc9az6GMx6MVb8
         U6XrbCHcNuPW91DnWPtUcSVSuDYCWJTqeAsJx9gTNSFvyIdhhu80PUmJjhVYf5DCJCuL
         +E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209442; x=1739814242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY+Y9OxGeDSUuz0ekM5BZDl8hgTH17GlThABvm9XWiw=;
        b=wfNRMgyJd+RnWYyL656KeNtOMRwnfkpo4/du+jbXAkx4LW2L4q2MlEYqez3+uHNWMR
         lRMRFGBESI2tLFkQuZAWhnVWBUcD9pF0p61R5bIuTknobPVIP//eh4b+kt2yQ+EsKTSe
         kCAHOImcF9acyNcL+gi4xu3RtOPF3KET5DCckwwyw0Iv1AvoVcKEGOKeWz3XaWDJpXHd
         9y/MxnR8tLk8fESHaznzWw+7M+z3FKup+M/Zpm5PBpDwCCdhCTz7+64S8KBTJb8h4llV
         /E3ZRLnMupgUDpGMLLAsPAQc00CgdqFGhLZFLyvsY8NwWOoDI5wCuFDQHQxKX/cyNg4q
         OR4A==
X-Gm-Message-State: AOJu0YxmtVn+k76Uel6dTb00kVi96QzVEnYqF+cgx5OpRgNw/t7pjnqU
	JZq/NVw/4YaaDjFdMA1MLXGu9bF47NKmVtid2DYhOctpokS2W/VIumOeG+iH
X-Gm-Gg: ASbGncvGdzW+fT6K1zUg8+zxrkCuQh1XcuT7+1fx9SHR2Cr7Ex4XKBXU/OFU/iNpKbH
	bY6j5auDgYVrz5GQnQoVh9kNvNHe50HFyDfwyeEqClxi9XdrPQLoKG2u3uQ/rGdBIeIDyeH3RSx
	AhTclInRkk8XbRScbXWq39YAICzm3cF+vHvK7+sfO4ST0VKgXxG63OWgmHl/MqCyrEEniT5grvE
	5AZ+4NW9KqT7h4R0sCaGsS4HSkoVmBYOfo5sri5IH3a7v6TG+A+5GJMqcwdQx/RJb86kKWbCWdj
	frxzvgD4QiU1Z3ivcdgHaKmGpSuIEPQhtQZTJ8UpZRolkM1u7PVLwYZAKYfU3YaFlQ==
X-Google-Smtp-Source: AGHT+IEHfmKmIygUIDhQvESzN7Wtk2XUBKOyHKoP9XCChRmGG8nn+dNRuy+maETDFRZs5Kc7YyN9oQ==
X-Received: by 2002:a17:90a:ec85:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-2fa23f423d9mr21205213a91.4.1739209442000;
        Mon, 10 Feb 2025 09:44:02 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:01 -0800 (PST)
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
	cong.wang@bytedance.com,
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
Subject: [PATCH bpf-next v4 13/19] bpf: net_sched: Support updating qstats
Date: Mon, 10 Feb 2025 09:43:27 -0800
Message-ID: <20250210174336.2024258-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
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


