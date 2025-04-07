Return-Path: <bpf+bounces-55424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F5A7ECE7
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 21:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337DD3ABB8F
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F133253B61;
	Mon,  7 Apr 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+YTrTRG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937A221703
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052530; cv=none; b=HOrt0yLL0wxvyP3nUjhNidGms4vbOLmdSaTNZpZppA0Re2Yt3Sp48JVWpLv4NBBHa0mhUe8pIdGIHIQzfRS9fOKHHHQR6yjdHBmb/wmzqMn/9qbjDjyKoIp+783taoPKVBEvxV9u6IqpODy6nK5mAWNB2t89IMFQ5HBmrClWM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052530; c=relaxed/simple;
	bh=wwTx0rqQ5fFHE/kILAzyF1hY/8nAawsM1lQI+vfoTNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IagqBkqQLiAS71p45vY/jS1d4uzace1Keuaq98mCD1r3bwUNSAuAYsECFWkSQPKmJ407DYFY0iusaRNLridNk4BIXRGpXPglTlkPkjnwWk+ufE10oxGUy3vFFJpDWwLNVKKG+ACIMTtjGeVDipCYc3Zj8AdjCbRE5yfUJcMpWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+YTrTRG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549b159c84cso2446415e87.3
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052527; x=1744657327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h8SxcH6z1G2Qr2ZYNLeAyOsp7Cgz8bg2uXzQmC1Njy8=;
        b=S+YTrTRGA1WOL1utxbigC42KjNZ34TRzhddZR8gpQUBjGAZixwt1FxNDyFdra8vOwp
         TAaIBZrXA1JHQXeJXU5Vz0QBKaw7vSN/F26PoxFat64/0JeY5URQqd6AFv7REI3vN5Ay
         KMF2BUSAmM9wOfTzodL4YcjiB1vxqEthyWp3VIatczNfvKhjQbDGJz0W8GYBFPB16f+m
         cwpQGqgDF8ERyMPm6flOxXdr1P1ET3HUpVIAm5QSl9h5/G8KGSKpeHPjam2Di51VkoE1
         ujEwDkkFi7DSP4v5YellaPknm916KKt8i8KArzy0t4OPJrepInwIe4LLffQFAZqybLv3
         bN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052527; x=1744657327;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8SxcH6z1G2Qr2ZYNLeAyOsp7Cgz8bg2uXzQmC1Njy8=;
        b=LL3zS6HKVwXWkshbEqwBQNTE9HL7NZp5Fg7QvuMrvAsMOQ3j5T3mlIig/o7AtpcRn1
         boRxrz7YItSU4Gx0mRykCVBe+Qltl4heJApso28/Bdvc+LNUGFrU8E/azi/1gUsofwLc
         qv/VZcYLBT6DTOW465Jv8QAJcf31ly5R1p7HGATleBECHekOwB6JxpBICAyBn1mpz5Qz
         8Y/kr0qDraqXUZ4zUVeUC9Ovlb93Rxv8Mb96lzCfR5FSfZooIqAn5uZtFGFFwhjOeeX0
         mPfSuPZctJhAF4dtOl4oxTzU9H9NYJVVJFTAcpUZhVeQsxvS5DLh3MW5mfi0E/FuaLOA
         GcMg==
X-Gm-Message-State: AOJu0YxlblGmugpMm8sQeiGVfGH6tx/XZOIwbuI4LsjUaQABHxxH1zZj
	Z7Wj4ZuHJ4PksElCNFdOWtmTHHhTfaGq3Pp4Zpv/IQdI4DjOpeMriNzx7LhNN/o=
X-Gm-Gg: ASbGncuPaVgPbAqXQReGSDyOkGzDw1TPI59DTUTTkzx40/7JJCrrJwrjM0QZHFLBh2c
	KIZkDukfenExFxWCaaUPmJ2wesS6q9R1U32r/HfZFMfCxHifu4aBZIjmLHrDHzNVSkHBImLtqKY
	KnEGLAJkVmJ03HcfjDxTTp5LjeViMIqdPOXGQnxO0d6DBgO9bHexxxk1VNI/qfYyDZyV9vPEpm+
	YgAM5HkwH9ljTmx3/d7SrIlqI0Y2Wh1gshqFd8MUAY9TGCWpoTwDG+v0xODAksvu1suNohKU+Hu
	oZ/mOVECZCP/WXEEqLmWT4ObPcF5yWmNG6vIeFi+9O4qLOzuAcoZd+r2Ao61jt3kOnbIfGioeqA
	DM2Hf30we4KFPrHStB3bDrr3XPGbD7uP8nWNC5w==
X-Google-Smtp-Source: AGHT+IGPQCl/bciZ3ElcjCqFFGxC7OCx0VoNNYYDTndQ/DOx9sOEpnc12PFfbCY28GWOf5nkXXtLKQ==
X-Received: by 2002:a05:6512:e92:b0:549:8d16:7267 with SMTP id 2adb3069b0e04-54c2276aba5mr3850791e87.10.1744052526497;
        Mon, 07 Apr 2025 12:02:06 -0700 (PDT)
Received: from cherry-pc-nix.. (static.124.213.12.49.clients.your-server.de. [49.12.213.124])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5c1c30sm1376997e87.75.2025.04.07.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:02:06 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	Timur Chernykh <tim.cherry.co@gmail.com>
Subject: [PATCH v2 1/2] libbpf: add proto_func param name generation
Date: Mon,  7 Apr 2025 22:01:37 +0300
Message-ID: <20250407190158.351783-2-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407190158.351783-1-tim.cherry.co@gmail.com>
References: <20250407190158.351783-1-tim.cherry.co@gmail.com>
Reply-To: 20250331201016.345704-1-tim.cherry.co@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel loads BTF with specified min-CORE BTF and libbpf does some
sanitizing on those, then it "translates" func_proto to enum. But if
func_proto has no names for it's parameters then kernel verifier fails
with "Invalid name" error. This error caused by enum members must has a
valid C identifier, but there's might be no names generated in some
cases like function callback member declaration. This commit adds enum
names generation during sanitizing process for func_proto kind, when
it's being translate to `enum` kind.

Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
---
 tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b85060f07b3..c2369b6f3260 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3128,6 +3128,8 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+
+	char name_gen_buff[32] = {0};
 	int enum64_placeholder_id = 0;
 	struct btf_type *t;
 	int i, j, vlen;
@@ -3178,10 +3180,50 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 			if (name[0] == '?')
 				name[0] = '_';
 		} else if (!has_func && btf_is_func_proto(t)) {
+			struct btf_param *params;
+			int new_name_off;
+
 			/* replace FUNC_PROTO with ENUM */
 			vlen = btf_vlen(t);
 			t->info = BTF_INFO_ENC(BTF_KIND_ENUM, 0, vlen);
 			t->size = sizeof(__u32); /* kernel enforced */
+
+			/* since the btf_enum and btf_param has the same binary layout
+			 * it's ok to use btf_param
+			 */
+			params = btf_params(t);
+
+			for (j = 0; j < vlen; ++j) {
+				struct btf_param *param = &params[j];
+				const char *param_name = btf__str_by_offset(btf, param->name_off);
+
+				/*
+				 * kernel disallow any unnamed enum members which can be generated for,
+				 * as example, struct members like
+				 * struct quota_format_ops {
+				 *     ...
+				 *     int (*get_next_id)(struct super_block *, struct kqid *);
+				 *     ...
+				 * }
+				 */
+				if (param_name && param_name[0])
+					continue; /* definitely has a name */
+
+				/*
+				 * generate an uniq name for each func_proto
+				 */
+				snprintf(name_gen_buff, sizeof(name_gen_buff), "__parm_proto_%d_%d", i, j);
+				new_name_off = btf__add_str(btf, name_gen_buff);
+
+				if (new_name_off < 0) {
+					pr_warn("Error creating the name for func_proto param\n");
+					return new_name_off;
+				}
+
+				/* give a valid name to func_proto param as it now an enum member */
+				param->name_off = new_name_off;
+			}
+
 		} else if (!has_func && btf_is_func(t)) {
 			/* replace FUNC with TYPEDEF */
 			t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0);
-- 
2.49.0


