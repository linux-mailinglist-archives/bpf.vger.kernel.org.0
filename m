Return-Path: <bpf+bounces-54990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49492A76DFB
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949E03AAE3A
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959B217675;
	Mon, 31 Mar 2025 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGWja10p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703618BBBB
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451834; cv=none; b=MM4jQA2GJHaDbjMeUi/BvNr68mUr84CyJe4++rE2G2sy4cZg89U9raxtB4Cl0IuoFE7bbidkMNFtu9sMCqLLpkfLUScvHUhMclcpD1zuCkki4Jj9gxEOmyw+89vamayWuA99ZCby+sG1TwISyCCRIF65JwsqWGsOw9TP+UqMa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451834; c=relaxed/simple;
	bh=EYQ0MHc/CY9aFj+IlI+Nom2h4guWq3kAF7fJcYA8ugY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlFVsTYeRxAxATpefhagHTB685is4IRuS40IH02pB+eiknebbuqyJn9C1vIPdm+ixD0J7m4YFuUUs6c6ZAQ1VNhc++tV1M/yZg5WvhI7MX3VN2WJo3/Vrh8betgzk69jMiloXf3bVAxutxbMJHjxxPq9sZS0SPlfBTX1S735pNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGWja10p; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-549963b5551so4996197e87.2
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451830; x=1744056630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEGoLovXvpwYUrY6U3HN5L8CDd8R65LHRR8osNivfko=;
        b=iGWja10pEobxC6LxRcEDi45U7P9wbt/R1jd1jYEYDCvj7rJi4qzmWdRwLKBgGt7efh
         pw47FjKv0RGcQniQDPer2RmaVY2s3Y6gxGs/J1m7oymujhEJ5obGzmxe52u3obw3UXPy
         zRyRtQDRxu1Y75BX9DYe7D74sS5XowM/3M4mbTxZJI5Sx6TZPXf+gUzJ/84ZpYaK2TFs
         LSxdAqdLGSGviYaRMArSNNmrHSZ+k/r5RyQ8iNmoq6N5iHIHHW4lKlTTtAJzNOa5vCdB
         GyN0I/+IOYBKEy5zZ7BTjjQ5PjRkvW70tUrcPF7RjxIDDRcS2O4V5oykkT7PqhMmTGkY
         OjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451830; x=1744056630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEGoLovXvpwYUrY6U3HN5L8CDd8R65LHRR8osNivfko=;
        b=vt4LOg5zK2KPMq5cZkbjmH9z/OE1PvXWZvL4/KJ3g8DeAlt14jJU4UGLnuoBynIL4A
         bKPkoD7Y6Q9B3NL4e+x8q2GkSCk1cti7n2JO732iVKDqc9BYX2oLOPZtzbZPPQ4PqCkg
         IoqRUPmdOb8/y3TXE9Lwq5pnPsoE923GwnhZxjvk1QItLOQ2kqtdur7ahTpyzTvtOzzN
         8yh3E5hbggm5bFDNouZ9EX8h1jEnXkUUqWE+QlNikNarRiFDadoFvbq3aekxawFkLIrG
         gnzFpZE0huRe9pNvRkCx6D+t9T9TH0AbMuZPrvmsPudGymtOfu4bvmZs5Zy/i29/HDZP
         xIiQ==
X-Gm-Message-State: AOJu0YxRfFAbOBzd8PT2QAl3Yx6Hl08daL+uOXTkg8zQF28TjMGveF+s
	pELb2S5zKp2RzAJ83qlsMFv2M5Dq8wPbK6H7aBPMXG0FE5nmP2+73Pe2Fadf
X-Gm-Gg: ASbGncv8a9yp4flgnPhhC09Rj74xf70RmPK4nqGjpNFlA2UGsdIVRDrlJdDbCSAs8Oy
	Qr7iPP79aGEWbCyvcf9iWdMaJ4yMg9UW2rQ9C1SzcZQgRDbVonljIqHrbShDytJpOyKWLlqhbYM
	q3Sd8tBrXckmBz7XJDew8Wiakayi8tbDYWi+VB8FGD3q+5gcwE++vBurbFDtYtVbiF78pLa3Xro
	R+BYAGvy5j8/wPiptpVtJoDq+5GVmb3VtdeiKCtc/p/9ZWdn1k6kmPEuxrwmf0xWPxanWCxkj5S
	jaIlc1+5mC4VEQ+GgZl4T2L6hD2Xv+2Y/CUb/DcF/UeJzumExXt8tA==
X-Google-Smtp-Source: AGHT+IH7wywFypP/pG36JFjbW0HAcKLhBfX+GDXQ+kyk2URZaqN7ijCM1lWkhElrxzKYErRd39BkZw==
X-Received: by 2002:a05:6512:3090:b0:545:2ab1:3de with SMTP id 2adb3069b0e04-54b10dc7b75mr2505007e87.13.1743451829882;
        Mon, 31 Mar 2025 13:10:29 -0700 (PDT)
Received: from cherry-pc-nix.. ([77.91.199.108])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09580604sm1196328e87.122.2025.03.31.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:10:28 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: Timur Chernykh <tim.cherry.co@gmail.com>
Subject: [PATCH 1/2] libbpf: add proto_func param name generation on sanitazing it to enum type
Date: Mon, 31 Mar 2025 23:09:53 +0300
Message-ID: <20250331201016.345704-2-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201016.345704-1-tim.cherry.co@gmail.com>
References: <20250331201016.345704-1-tim.cherry.co@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
---
 tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b85060f07b3..8e1edba443dd 100644
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
+			struct btf_param* params;
+			int new_param_name_off;
+
 			/* replace FUNC_PROTO with ENUM */
 			vlen = btf_vlen(t);
 			t->info = BTF_INFO_ENC(BTF_KIND_ENUM, 0, vlen);
 			t->size = sizeof(__u32); /* kernel enforced */
+
+			/* since the btf_enum and btf_param has the same binary layout it's ok to use btf_param */
+			params = btf_params(t);
+
+			for (j = 0; j < vlen; ++j) {
+				struct btf_param* param = &params[j];
+				const char* param_name = btf__str_by_offset(btf, param->name_off);
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
+				if (param_name && param_name[0]) {
+					/* definitely has a name, valid it or no should decide kernel verifier */
+					continue;
+				}
+
+				/*
+				 * generate an uniq name for each func_proto
+				 */
+				snprintf(name_gen_buff, sizeof(name_gen_buff), "__parm_proto_%d_%d", i, j);
+				new_param_name_off = btf__add_str(btf, name_gen_buff);
+
+				if (new_param_name_off < 0) {
+					pr_warn("Error creating the name for func_proto param");
+					return new_param_name_off;
+				}
+
+				/* give a valid name to func_proto param as it now an enum member */
+				param->name_off = new_param_name_off;
+			}
+
 		} else if (!has_func && btf_is_func(t)) {
 			/* replace FUNC with TYPEDEF */
 			t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0);
-- 
2.49.0


