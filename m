Return-Path: <bpf+bounces-53985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC65A60060
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673117A942A
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDBE1F2B94;
	Thu, 13 Mar 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1UmDjlm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B11E9B30;
	Thu, 13 Mar 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892603; cv=none; b=aRC7KFNvQTc29vGqzfLu16rVh+tVX45a8xw/mIA7quLUCzmndAkoWFUigCn5RjsLnG17eWnJWZBlZVUXa2OOAiy4ljAx05QBlGORFZ9ix0hMAi9Ms2y4vIdW58x0tbeEBjcBwOlpVuxM1GZbHSu4033h+IzCzHEHUiL281+6ppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892603; c=relaxed/simple;
	bh=sef1qcilGkhe9JUUrUVaEMXIk/wXcfEC+HV4nh1nh3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXT7JGRRhYuCMxNnazUfWcstKHHf4oLwj71M1MTLUwtl8yUMgyH2FtdWjw/bNePoaIaXYDcuQKNSm0JEsWUT6a7C9RmjOzaA+Z6MbFlb52ynFB4fiJWT3ApHBiEdOo65fzPwcD7ZH1YYAVSn9k/mjqe3GLyVSVrEPuU98UHBD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1UmDjlm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2241053582dso34384685ad.1;
        Thu, 13 Mar 2025 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892601; x=1742497401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjeR/x0qDwmVuV5v1i7wkxBYQ4TFckMqeAG7zQVs0H8=;
        b=K1UmDjlm/J+p+rzAVRiItlcEpt6Qx67yLB8+RjUnDPgp5p3AvmKJaXDfDMRJJDWoUg
         zy+voGO65GPVv0ItyV8nOr9O/yCZoCjNsPrN++aRfhygptmyoRKfbvQkfMlsRLBNdGHj
         wYaXbLKCVMtIvfmiVTroGJmVVYrdZ30QpZXDsdAy6frqXGvr718GdwOpFW3WH3Xh8LKo
         g7Z5ZAatIbHgFS+ZG2ny6z/t3MDj871mj3v763uU9MsthWtywvJ9dQJVawr2jTXDzGuQ
         wtcY6T8xHmgIsAH2CjpbqqaNstllDbiYDXkj1Vn9Wub2vlwcDvI7fY08DfULzhj1J1Ks
         0O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892601; x=1742497401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjeR/x0qDwmVuV5v1i7wkxBYQ4TFckMqeAG7zQVs0H8=;
        b=AzDXflzubEK+v9tWCEDwOOkgsoGRwcu/fQFMtrbrb8sd1a5dYEey2knPMR3uFsM89g
         eQNfyiObgHBoya0apf61LeXpRGw7VH/jsBkHMHi/5eHAkH5oblAynPPGKMyZiuOqEfn/
         17GeKMFgFjGvkRFIflNiFnyoRUbEXmBYVwiUHLEC08DUVjG12qDfd3g7S0dx2DJ1brW4
         ksKyx4FDDZMvh7Y4AfWBYjBTnU9GQHGAtGth46QDjfpMXvRbPEH0nZvIJM4I0ew+ylgK
         wZ3yr4ZuoH8Hm/Gf/dVLhbZlulveSwoSg8stXjPkiXi9udw1WpPMaAZi3/VmVp49K3Mb
         YMJQ==
X-Gm-Message-State: AOJu0YyMwGz8oeiXZXaTy7otWhLlIh+n9iMvj7kgyjx48C0s+t63CWAO
	vDIugqbHG7+yazCxmNzxyxlAiUVn8cvK6KJodi40PZoNkS1gbOLP3v54MhrqinDigw==
X-Gm-Gg: ASbGnctunM6WOVmV/kJdiWHA4/oYu0Cs8pbzQEkk4Q+v9V6or2QbcVx+WBuX/8jY6CI
	adVFkpAxc0w7kGTBZfhKOxJJgYVf1Nll5B8YM3mzS82UZ9E2JGJE7ZwoFpVlcf4ecV5wYx3xAlQ
	Cxh6EBLSv/R0lkpQX71fqycpLTXWC8PR4v4YT7IH3GgIj2688WX5OSK72TVE3Y/4tg2djnR8EXH
	bIwPWA3d3S4ceIeQBhhNfdlLmGsm/kFOyWIi/Lfy2AoWEBALlfmwN91xMP/BYDQynEl8f0bibAr
	8um2VGT6iOsyrXe6KR0tC99FolTtHAQjtMS/KLiQYwruYZBP8cqiAgJg4I4wSucOFqF9j3IJVli
	GaGz7N9zAk0lp1CVBHUg=
X-Google-Smtp-Source: AGHT+IGFQZPK7gCfLmUYnjbo20WGBIJwFMaZIRaI++6/zw0QXtNtR50W2mEA98v8RGcbkLPnVlyckA==
X-Received: by 2002:a05:6300:4046:b0:1f5:8678:183d with SMTP id adf61e73a8af0-1f5bd8a98c9mr1380466637.14.1741892600587;
        Thu, 13 Mar 2025 12:03:20 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 02/13] bpf: Generalize finding member offset of struct_ops prog
Date: Thu, 13 Mar 2025 12:02:56 -0700
Message-ID: <20250313190309.2545711-3-ameryhung@gmail.com>
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
index 7d55553de3fc..463e922cb0f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1908,6 +1908,7 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+u32 bpf_struct_ops_prog_moff(const struct bpf_prog *prog);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index db13ee70d94d..1a5a9dee1e4a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1387,3 +1387,16 @@ void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map
 
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


