Return-Path: <bpf+bounces-51014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4CA2F58E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E833A7A46
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D47325745B;
	Mon, 10 Feb 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVCkWQyC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24194257435;
	Mon, 10 Feb 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209436; cv=none; b=F/yRg96vvuky1nxAMHVNnfSlUiyvrLfFyKL6Kz4janlF5zBU+CqDklbyNTroTIlA5nLueh0CBWr4LzVSLZJX4ANy9eaWP3JiHqKsLx0rW67+MACIL2ZgDkfZpGbzXoebqxHq7hoSWlla6jXAwOPUdUDsIPanvSvC1bdi9NkGnpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209436; c=relaxed/simple;
	bh=4L0QpGoYr6OkA1ibAzBIDfCnhoaWO/S8JALDmmJDF48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFFykS/j2WKjjr4x+u3jTC5dAfBB+iiprywD8f4nj1IjOh4ViRFtghCukCVj8bVsos5pLm0fqvQAxFWVJxtJEoHkZra9En23sxmAL9DS96JofjZ7vx+kAJner98V0pY5PJx5MRdZhu4hhavhxc5uSjZU8rR+d7u4LodFryutXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVCkWQyC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6f18b474so31140385ad.1;
        Mon, 10 Feb 2025 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209434; x=1739814234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asG0Td5Uy+/WENZShXcphGkKxJyJZZ2l2bOrEIfzsQE=;
        b=JVCkWQyCBqBUP1MkTv28RGYWkLAWVUUR55xCzdR7H2IZkNuwRF7cAA83D8iADS3QzQ
         quK2xU7vVeQIB8ybUX5udsfXYWuO3pA6DNKl8uhzo8mkKxNej3sZd1aNOdRw6Cbo6v2b
         AaqKH8ZKsjUKGUCQQCjRbMTUEMgqwW4zdiD3qD3kv4yaeQnHHZdja03zODKu3EC22+JK
         MkFmpaGIUv+QZIMRZQfdVqvkYyxqxZOXP5Rl/EpxrSxokV4FyjdLuWinDmStmSM/AaDE
         DXgXSc/ubdogtWOJcaTX1mqg5pyV61CHtnkURIUqpjjq0p8VDy9dI73EjDdeRirm4/Zv
         EXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209434; x=1739814234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asG0Td5Uy+/WENZShXcphGkKxJyJZZ2l2bOrEIfzsQE=;
        b=bw9b7DsKp3eK9elhyEXaN+HVq6yxHpu3yyHmbtGBBUJL5v9xmUcMuSwp2uJOO4LTH1
         OXfy9mLtX7w/1BuCnfEH3Yvv00s+oo2YQaqdI6NS4j19UY+5mquWlNs0FojwUcUzwJjC
         nnnbeGEMk0e3yv7CUezo5Uegg/Snram8UeVrshF8W/im85Vf84e7bASPOcfiM4QTemve
         2YQXVGdjts80AZgK6WE9ee2Dyyjn2O04VHf29LOmzX06PRUyly3F0KPYawNaDXoe+Myt
         zgp0gz+wcYWJvGb2IOlqx5N/IzpZLwcPjUaliWgI+3bqxTnkpaHV2fXcuJbf6Xt6yAAT
         UCyQ==
X-Gm-Message-State: AOJu0YzlL1ZXY2rZ8ms92vrNOxAz7cR/asTjUpEDajrwv/4H2V8bTQ5W
	rzPiTkN5NEjN6Z6O+P/Wdny7VzISlC9u6+KdUJPW3g2tW73tKj7r7MVJ4R49
X-Gm-Gg: ASbGnctO6ZYA1aBxscimfouiPGOhdHLEZW6FAjbnMlk6CpIdiy1cEIOYto1aYZW3Oqm
	Sl66LYJzFpg/MVGtFMBWC66H83eyfVflHKBDm1kWqJ9EYG6q2sSOn8qCXiI9si1paYLi5PokKHL
	B0CU3ng3j8DtWLYiI3lEjC9lSl984hTQNyw+b/kFt8VLUDIpG7aWslPqORihMuQHpxSwlygf1eu
	TNRX8FPIYm8HdoNnojJ51XaLwR0A763rcpB+86usEZHmhc0qaf+ljjMdbv6K9pi3PtZtY3M7Yqm
	hifg+QhajGxq41vP0oUKpd21Fa+lZ+Uou3DSns1Zdc6Rauf1w10sl6PWw8LwiPXlCA==
X-Google-Smtp-Source: AGHT+IEQY8H+wV3mr/kLSqpmpdK10CBNVqKDbw6hZ/ad+anIu50qHjeZGtsocwWzakH1pS1iqVuCPA==
X-Received: by 2002:a17:903:228b:b0:216:7926:8d69 with SMTP id d9443c01a7336-21f4e7832d9mr199739875ad.47.1739209434189;
        Mon, 10 Feb 2025 09:43:54 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:53 -0800 (PST)
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
Subject: [PATCH bpf-next v4 07/19] bpf: Generalize finding member offset of struct_ops prog
Date: Mon, 10 Feb 2025 09:43:21 -0800
Message-ID: <20250210174336.2024258-8-ameryhung@gmail.com>
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

Generalize prog_ops_moff() so that we can use it to retrieve a struct_ops
program's offset for different ops.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 13 +++++++++++++
 net/ipv4/bpf_tcp_ca.c       | 23 ++---------------------
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 15164787ce7f..6003ba36f6c5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1892,6 +1892,7 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+u32 bpf_struct_ops_prog_moff(const struct bpf_prog *prog);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 8df5e8045d07..d3a76f0c5a82 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1386,3 +1386,16 @@ void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map
 
 	info->btf_vmlinux_id = btf_obj_id(st_map->btf);
 }
+
+u32 bpf_struct_ops_prog_moff(const struct bpf_prog *prog)
+{
+	const struct btf_member *m;
+	const struct btf_type *t;
+	u32 midx;
+
+	t = btf_type_by_id(prog->aux->attach_btf, prog->aux->attach_btf_id);
+	midx = prog->expected_attach_type;
+	m = &btf_type_member(t)[midx];
+
+	return __btf_member_bit_offset(t, m) / 8;
+}
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 554804774628..415bd3b18eef 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -16,7 +16,6 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops;
 
 static const struct btf_type *tcp_sock_type;
 static u32 tcp_sock_id, sock_id;
-static const struct btf_type *tcp_congestion_ops_type;
 
 static int bpf_tcp_ca_init(struct btf *btf)
 {
@@ -33,11 +32,6 @@ static int bpf_tcp_ca_init(struct btf *btf)
 	tcp_sock_id = type_id;
 	tcp_sock_type = btf_type_by_id(btf, tcp_sock_id);
 
-	type_id = btf_find_by_name_kind(btf, "tcp_congestion_ops", BTF_KIND_STRUCT);
-	if (type_id < 0)
-		return -EINVAL;
-	tcp_congestion_ops_type = btf_type_by_id(btf, type_id);
-
 	return 0;
 }
 
@@ -135,19 +129,6 @@ static const struct bpf_func_proto bpf_tcp_send_ack_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-static u32 prog_ops_moff(const struct bpf_prog *prog)
-{
-	const struct btf_member *m;
-	const struct btf_type *t;
-	u32 midx;
-
-	midx = prog->expected_attach_type;
-	t = tcp_congestion_ops_type;
-	m = &btf_type_member(t)[midx];
-
-	return __btf_member_bit_offset(t, m) / 8;
-}
-
 static const struct bpf_func_proto *
 bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 			  const struct bpf_prog *prog)
@@ -166,7 +147,7 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 		 * setsockopt() to make further changes which
 		 * may potentially allocate new resources.
 		 */
-		if (prog_ops_moff(prog) !=
+		if (bpf_struct_ops_prog_moff(prog) !=
 		    offsetof(struct tcp_congestion_ops, release))
 			return &bpf_sk_setsockopt_proto;
 		return NULL;
@@ -177,7 +158,7 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 		 * The bpf-tcp-cc already has a more powerful way
 		 * to read tcp_sock from the PTR_TO_BTF_ID.
 		 */
-		if (prog_ops_moff(prog) !=
+		if (bpf_struct_ops_prog_moff(prog) !=
 		    offsetof(struct tcp_congestion_ops, release))
 			return &bpf_sk_getsockopt_proto;
 		return NULL;
-- 
2.47.1


