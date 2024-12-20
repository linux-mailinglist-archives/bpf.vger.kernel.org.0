Return-Path: <bpf+bounces-47478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE29F9ADD
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 21:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2BB188936A
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C8228C96;
	Fri, 20 Dec 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXdPh9QK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27142227B85;
	Fri, 20 Dec 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724600; cv=none; b=ROhtXM4/Zb288Dn7NU5brctgy0TTJt6LGYsVHl1G35RpTwpblzQKVAXEPHad+JVGqx1dAQEnuEa1A1Laniv97QmbcXa0bnQli65aEPgGPV9MOqFoCtb5yUT+TdCJ9K+Ak1Mlq7R7rK1tnTzdRrGIJEz3XaQbeQNqQOzOcaH39FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724600; c=relaxed/simple;
	bh=Cgx59rfQ7uTrwAt2fviLdB9a8k5VgQaOm7OFEtfhO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uo405rPgzzCxxV31WePxl5+kdg/KwmoFyUirkOy6DtJHm+bnuESLEtkXiGgDpEFYBMi47NzQMb+NGY6I7J09+wQeDviCLCciWrkNIz6N9MJu6j+LmoUeZR/gTPcrikp23YAufeHQ0hCxuHWa41F+wmgEo8cixaHgFgXtZmRAfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXdPh9QK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725f4623df7so2322700b3a.2;
        Fri, 20 Dec 2024 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724598; x=1735329398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZT2YZ64lp7kr6Ks7lrnL2X7foJtTo0Jit/ACU1Pr64=;
        b=cXdPh9QKDbe8djpCFCDtZIkD4y+DN8knt3wFWA7BpmmeDLfuC9SwS3/lOxPvXxn2lG
         W2gHPuXuMztUxiURVhbw65rWMTo6tw9p9COkO9swhJG3MBHjhIfHpeDrBCp6qLy5lLZR
         VCqZLeo0i5aoPzcvriBqqqf4293QJ9fDkPEPZTMH95M0H5DLsxdHkZ31TFjNHrOMyV83
         kmmpzsRHiyalek5lsMKdTbQ5nXTVl95qorZ0MglPTAW4/C8GUhF+W+O5KyCsME+6WXYE
         1nyNTrQb3jPdY7NuepkADznArLNLM/WLtyS/2wTTJcvvnnc9TwVgsHhRw8KQPodTqvdP
         lTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724598; x=1735329398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZT2YZ64lp7kr6Ks7lrnL2X7foJtTo0Jit/ACU1Pr64=;
        b=tDbB8VlWtSELSImFYQg91kGLussuAdSJIq2zQQ7rZrI6iOIjc/AumJtJK8ZQNU5zBv
         W5+To3P/C4cMfgnYSXdkMPQhxcUUAfdOh+7Gjfuv6Ymxfs/5PIAIfE0/cA4gNqfO16AZ
         54M9uLlaizty1PgddPEnhfbG6Ln8wMwBJIabx0sD3VhMsrJW4dpGgz3f92SizwJ35WaX
         /zX0bcgK5RnaCUkbRJU2oHqROgKr/oN0h6Epz7QB5KyhMI1JPr10ykvteQS2Yb/oGvvb
         U6lxuN89Xw4MEQojdP6u7JfVUVXrmfy2ge/HFWf+7TVoZLToWUNiVomuOERcJYVGXKgq
         ZtLw==
X-Gm-Message-State: AOJu0Yz9uYJyI0eA2/IdpfuWemigfpGQGem3kn3hfeIACQdxUDvMmfhf
	Qr28iKABU8ntlAxsUfkAjNar+1bN5EcBwJRIFRVgCo/WzMkBpG1k22199A==
X-Gm-Gg: ASbGncsObQanDyim+xqQ/9vKmGCnQoHz5xm5YtwxLUPOXGXeNFH1riTOicyP6qyzini
	Wc1yPvk11+MR0E16DKcAUFmPhhMin/9WvU2om/ees2aKmwjE6li998u52kju8ahfJ8YWSB4J0Mw
	CUUzeZF2Se4Ac1T7tQtk/fMT79A1Set+mhfYWvt3ad6ZYURMk5xbUkkKyuZWgcJIhw0i3+ZWhsW
	CKmb/XDFs2aVuWd47FPmHpXj28J8/5yFUkKUNGXp+VLJKSnD1IPfEa0YLy1KHErMohI3CVlwQw7
	ez0Yp2SQ0WS5DxMnlXeIUISFlVGM6VfN
X-Google-Smtp-Source: AGHT+IHt+sIOm5AzBnZJjLKQRCn7gqoUYL6/KAY1Eg2b7FDWJY31wXUbw6+TxDV6kT7bYfIFKMmy3Q==
X-Received: by 2002:a05:6a00:8085:b0:725:ae5f:7f06 with SMTP id d2e1a72fcca58-72abe096383mr6459461b3a.23.1734724598359;
        Fri, 20 Dec 2024 11:56:38 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:38 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 10/14] bpf: net_sched: Support updating qstats
Date: Fri, 20 Dec 2024 11:55:36 -0800
Message-ID: <20241220195619.2022866-11-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
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
index 39f01daed48a..04ad3676448f 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -33,6 +33,7 @@ bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
 	}
 }
 
+BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
 
@@ -57,20 +58,37 @@ static bool bpf_qdisc_is_valid_access(int off, int size,
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
@@ -112,6 +130,25 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
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
2.47.0


