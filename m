Return-Path: <bpf+bounces-50228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F0A2434C
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABA5188AB0E
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8B1F4269;
	Fri, 31 Jan 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivs0yDtN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE51F3FE6;
	Fri, 31 Jan 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351771; cv=none; b=TststJOJtZr15K9bsB0njcMeiGiDgnOfqwJWhi33FZFq/MbI/GjLEak0mc7ogeyL45NjqQn3V0rqR8vV+YZRWV5tx6JHNnQ3e2iULPK0pH7dMRh3I00jrBTTay1AnyMdKS+MkHcoPHiHCddezsXXDOHCYbESqGdvvlM7LKAkl5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351771; c=relaxed/simple;
	bh=E2FPEoDrBFd0lRBTxumkryWrhzXuxyfUoTUazgGSfDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiFxtywC2zj8n4qXMeeY39pRGxaFui/GrkbGk+/k0YmHY+QTAp8KXHhGiGHac0g104yaAILNjMhh0hEKuNQzR8WP9/vw3aGDPa5Y2eqLRstgLQdpPUWR3S677GHdwOiSD62Q7YvTgAWIO90ATaxxgHWkxoXlAadNx+ZbsU5uFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivs0yDtN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so4202107a91.1;
        Fri, 31 Jan 2025 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351769; x=1738956569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgX9dUcS1QzoON8XWODEy7A4wJkZDpESE5En71DUIxw=;
        b=ivs0yDtNKXmcsjee6ubLfi0InqTMUsbxCtjbcS5d0AiqtV8RYEMybYUeTEKPAXYZm+
         Nv+RbMOnvxS8x6H1X3mYrNWpY6JvhLjhebHT49lyFZK9s7Ae0zZ41CRq/agxRwGVMwRf
         qYwhZ0/fsG6JHNOSdLKT0tnvY6fPDzZffgg5UGvl55tFJAY7RWzO7EA1YDr5xzWPmg9J
         zW/EouWVXksmfbf+o9HnX8GW8x266Jo+rpUimGMkmdd1AmM44mdpwrmUzuUxXVG0VOK3
         mVbjayRaI9+adIiaF2qkL2KKDEdOic+SjAhVE1kUtHtvw90tkeBvy+5PuTo/uszGQWEX
         SAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351769; x=1738956569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgX9dUcS1QzoON8XWODEy7A4wJkZDpESE5En71DUIxw=;
        b=WTrtL87e5z1oiwVnbHsawjC1Q1DnX6ydB1U2l/xNvGRAFEpoVC/YKVVleP1C/mXSDl
         lBxhLl0a4JS7eHn8n+tO1jDTuUMjKcIGK6Dru7K10s1OgMHDiuugDue8LcUQRgrAL372
         VBEISH3UEKjV+H1VKo0tPeJ0eJhuoSbHcIRaEAahtvbAPPqqYYNR1QentIiqDDY2ZO0C
         lQ0A0W0KnEvyz2BHTxqFP3sHKSmqu37KPRT1F+SLYVLEe03bP+AqmLTSrjxDqx59Z9yz
         VLfpbE2mmpvk+QUPlAWGts47yZUzZcqlDuZDnWXSd0qdllOXe5jlgvcZQ0+y+Mw4QgRP
         gEww==
X-Gm-Message-State: AOJu0Yxwl03FDjtR2deiUDmR5q4dod3zseZKTUejDhKS9xw8GnvDZYsB
	E943JKlPC5IN4B84C5H+99p2SWHpI4cd/dpm+Zqd4SsIU5IRZ1UR2q58stOwQtA=
X-Gm-Gg: ASbGncvoef828T2P24EDuz4TYUWwgJ8P82b6h8eCdswU+eJ5KzfypV09FA5VJqQblCb
	7Zcst9zOYvrl+XezSwDTVIRSlNaX+U2EsW5Nn4qe/M6sXSQ6iKYAsnaRemVrJOWxMtcRDnavOLV
	Hz4iHUgAOnfatkf08OMg2cahSuRSEkd4/BJJtQZzo+quk0JPA5XKT+GP5cY9CmnUY9hACBW4DHz
	xZweYbnAo+1IAmuM1+4+2cGza46NVP8v2r6fsKu4fcwQ7mPBRNvGQR+47S1u4EQt6rDlXG58VAr
	Al+kvioGWvu/nHpOIozo5fYJSF90fYb1Fz9/K/Dbz2q5fdjWMuz+hIbfpiIW3yppPw==
X-Google-Smtp-Source: AGHT+IFg0uOED7G77J125I6avlTWgSiLJQORQXW8soRUgW+osiwVeUR47pSsYKzjYL6h5P6Bg+p0PQ==
X-Received: by 2002:a17:90b:2b86:b0:2ee:f687:6adb with SMTP id 98e67ed59e1d1-2f83abb403dmr17171033a91.3.1738351769383;
        Fri, 31 Jan 2025 11:29:29 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:28 -0800 (PST)
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
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/18] bpf: Generalize finding member offset of struct_ops prog
Date: Fri, 31 Jan 2025 11:28:46 -0800
Message-ID: <20250131192912.133796-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
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


