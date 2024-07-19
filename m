Return-Path: <bpf+bounces-35101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C90937B82
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CAD4B2149D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2A1474B7;
	Fri, 19 Jul 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBiewfAo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C631459FF;
	Fri, 19 Jul 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409688; cv=none; b=L/JR/c5EIa1OxjWbzZP948TabMBF7QA6Zb8ugBm+i5FaHCDlNa0tGPgDVQntxJnIft4M1Kog7hnU8T2L0NcSmHosy21mDP/bL4Oi1kYZJWUILrmu/9L1UNLMdM5J4EgzjNEdrBNnKsmJe3qyiZUjrIv6bLgD/r3hsBjoLKVVrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409688; c=relaxed/simple;
	bh=3DXvp5jOvkAPu9y5xMa3aGwUsjFfFMj1jE7amb3n3b4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuYqwNDqcEO9FFaz2i2md3extkwi/AMYas67Bd+T3rsnRgw9YzU7kPESRY6ooIAgNfgXXuRH0UArsJGkt3hLN7KIOEVUzJVIN8U61kYLV3ey1J0ugWUrngdhhyOGl2oIZKtzsClBQd2zyf3uMo8FZwaMsoWi8ypq/hk6hFdtM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBiewfAo; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9ddfbbc58so1232795b6e.2;
        Fri, 19 Jul 2024 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721409682; x=1722014482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuMYKJns32/RgL4AWz+EBPPTGPYCidSuSNjBgS6hFzE=;
        b=aBiewfAoNEHCnkG1gIIfY9evz2lR81tKb04KrZRVUmOBid7G6cblkJefWP/V6Mf0z8
         rUP6884uBnd1LcLx7ZVmnmX1ZAmC++3YTHwygZzjIyLc2ERsvixIkIIPtVrv10+LpB/c
         tlvrhRI0UsEiAeE7i/dDzHG+jG6dnDhufn7vRjPgGiHWLZ5lV7FHnnC6KurP/awvS+Wp
         P2b1u7xSioPPFHnfQIbe+yqKzOmB1X9okJ9P6FOLQvcwBOWVxiiuXTWnT3VJuxjrLF3i
         9IpgxqbzM4nK99xixUqtUdeF2FJGiMvzhLwdA2f0Q+rWWiKDrkvwgJI3OCJj5C5rvjX3
         NLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721409682; x=1722014482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuMYKJns32/RgL4AWz+EBPPTGPYCidSuSNjBgS6hFzE=;
        b=YmdtkJun+0D9F7LDgDshyOW8NzaC1hO6lsK02V3Nubhd2fFIStI2pywYO5Eu63+/2N
         tCdd5VpMPogDx8ORTk/mspdetTOyATeaCkxfumw+Hm1TIamrgtuhIW9nYyVNCStRRsWD
         wZxEoSqUR/3P+xfYTDzdFaexKfeHFTy5rshn6BJhZ6Opti/k2zIZ9e3VSFa79NKK+Spe
         PQn0mbAYb7NHlNSSiyt0Wp4kFML8oP2iGTdd9MGdp8hTP0RmPAeu0Ju2fXuSmHjCg7Pw
         9esmf3HnG8qET6iuH/ZW6VBOZQxrZfxQ6OiZxC9y6desRNCQqq3J/2AmbGmIeHFQQ1lk
         MeHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoZtg4agzFmfL/dEwn7bfOn6W2qktTKQ2/lqa6jCrzNQVhh5Es8c6+lABwtQLpMutj26I+LkQT+EV0UoM92O5PBliAVbORM57Rl9JtyUQkaYK0NU7GWVvrzYgM
X-Gm-Message-State: AOJu0YxMQU55U+BKEZws9XPOHbkvo27nD4h4xoM5lj1Brpvq38V3/jAr
	FBGYRatIvOY5cSwfFmmAwtyiM1+E7vC04gnHFZMMjihfEKxpuqGN
X-Google-Smtp-Source: AGHT+IEu7n+++Po4apJfVbgZ2gfw8/CM/R5Nijd8lh2ztJc+Tpz4sIp/Bn4JzsLDk7OAPcKJEbUr8g==
X-Received: by 2002:a05:6808:2024:b0:3d9:dc98:c84b with SMTP id 5614622812f47-3dae5f43226mr794380b6e.5.1721409681844;
        Fri, 19 Jul 2024 10:21:21 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905eb1dsm109706485a.89.2024.07.19.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:21:21 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: ameryhung@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	sdf@google.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	xiyou.wangcong@gmail.com,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	donald.hunter@gmail.com
Subject: [OFFLIST RFC 3/4] bpf: Support bpf_kptr_xchg into local kptr
Date: Fri, 19 Jul 2024 17:21:18 +0000
Message-Id: <20240719172119.3199738-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240719172119.3199738-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240719172119.3199738-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 06ec18ee973c..39929569ae58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7664,29 +7664,38 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	struct bpf_map *map_ptr = reg->map_ptr;
 	struct btf_field *kptr_field;
+	struct bpf_map *map_ptr;
+	struct btf_record *rec;
 	u32 kptr_off;
 
+	if (type_is_ptr_alloc_obj(reg->type)) {
+		rec = reg_btf_record(reg);
+	} else { /* PTR_TO_MAP_VALUE */
+		map_ptr = reg->map_ptr;
+		if (!map_ptr->btf) {
+			verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
+				map_ptr->name);
+			return -EINVAL;
+		}
+		rec = map_ptr->record;
+		meta->map_ptr = map_ptr;
+	}
+
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
 			"R%d doesn't have constant offset. kptr has to be at the constant offset\n",
 			regno);
 		return -EINVAL;
 	}
-	if (!map_ptr->btf) {
-		verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
-			map_ptr->name);
-		return -EINVAL;
-	}
-	if (!btf_record_has_field(map_ptr->record, BPF_KPTR)) {
-		verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
+
+	if (!btf_record_has_field(rec, BPF_KPTR)) {
+		verbose(env, "R%d has no valid kptr\n", regno);
 		return -EINVAL;
 	}
 
-	meta->map_ptr = map_ptr;
 	kptr_off = reg->off + reg->var_off.value;
-	kptr_field = btf_record_find(map_ptr->record, kptr_off, BPF_KPTR);
+	kptr_field = btf_record_find(rec, kptr_off, BPF_KPTR);
 	if (!kptr_field) {
 		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
 		return -EACCES;
@@ -8260,7 +8269,12 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types kptr_xchg_dest_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types kptr_xchg_dest_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_ALLOC
+	}
+};
 static const struct bpf_reg_types dynptr_types = {
 	.types = {
 		PTR_TO_STACK,
@@ -8331,7 +8345,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
-	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type)) {
+	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && regno > 1) {
 		type &= ~MEM_ALLOC;
 		type &= ~MEM_PERCPU;
 	}
@@ -8424,7 +8438,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
 			return -EFAULT;
 		}
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (meta->func_id == BPF_FUNC_kptr_xchg && regno > 1) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		}
@@ -8735,7 +8749,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->release_regno = regno;
 	}
 
-	if (reg->ref_obj_id) {
+	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
 				regno, reg->ref_obj_id,
-- 
2.20.1


