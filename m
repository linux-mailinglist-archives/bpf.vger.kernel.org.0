Return-Path: <bpf+bounces-51139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F8A309CA
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7467188A497
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71D1F1911;
	Tue, 11 Feb 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv3B/HCP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083631C9EAA;
	Tue, 11 Feb 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272754; cv=none; b=mHrNb5ktIJlICAGLfCk71EJoYg5HF9hxeQVvErDCxyEjCuOO9KcPZAlcpsod5IyvnlYsrZNRL/hF9xn6WrTgj9RxlYVklLdGTOuy/Qbg3Meu38+/FiNGBLoiXB1J5EoXMhG5DEPNGdY2EHRKuG3TdrcBh69GxD1CyVzURFa/LE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272754; c=relaxed/simple;
	bh=/C3eTdAxvH+wSCUbMTRcH633vPf5d+21de5byk4rQPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=frSWg7rVdBK+KWNg7SOev9qI9a7khrjfaEWusK+Ti2c8pMTzkY37pi9CKfjP73jjMHcn+Yb9W9GdAeG3W17yvIAfqa1aweiiXhD90wZwmkeiiN3w+4NfJa8gNd1+BqcBq1P3Ogluj23eHSRiUECT/U0bRKGpWdhLSmQbxSuugfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv3B/HCP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so3976110a91.2;
        Tue, 11 Feb 2025 03:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739272752; x=1739877552; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NTDAzLZXBwCjKofiWgwOedMDKJqLuPnTW2TFWpLCguc=;
        b=Xv3B/HCPTsYurlpJADYHuJguHzlpWqXuvbqtR6kXmcQCCFXrjrlt1XnhRSjYi4dThF
         edpg/JWL5KpWrbkiqvcrtHO+sX+rBRxv9w5QuLNcQcvZXKiV8ZBlFJo3yK4gsZ7EQp41
         obeh8jkyX2XPsv0hkQvpaMqtBJ9yoLaccZry36RpgFCrdM9SJK934hZUdGoBXkqMDrT/
         bTf9PEwn0BzTTTC05I8PrNRgCxA2x0rKIBr0AnBAoWBBwDriNvZtsp698GOD8L6Lyr82
         f3Nbyti0fq0BvJzzs+PpKVl8wHaQQG1O4AVQj1miJT3X34/yiZ1kWc6Z4xfMlCGZC2aP
         /ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272752; x=1739877552;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTDAzLZXBwCjKofiWgwOedMDKJqLuPnTW2TFWpLCguc=;
        b=pxrJCXMoI3SGAZwPuPEN6Q3CfJD34p4Z1JdZtg1tpCl89vKFiMrncsyR1jsTs6/FyQ
         5wwLWJlw55e8LTmaKLCx+I0P4GjyeYfgy/e2xr/iqF1916AR88LGDKhYlaWfx83uvlYX
         wiBp7zwXH425KaJLSMKdytkaklVRu7aZEzD8cioz61TxshttBKEAASewJ2gSYElW+IsQ
         PMFhXaDXpJVF9uW4fs8UZ4qq1AE4wfKnfprkzno0IiAOJTjkdHJEwAUvBSgLM/6Ur7vW
         z1yjRMZZYrrSmorts9iknFX2BrtSHMdvygdlfaqkM38VqdZ/VURHQs3ULcbkUcBXksjt
         Y9xA==
X-Forwarded-Encrypted: i=1; AJvYcCWMNjIH5Qp6tFSySO2+aHovGafgnX0XQfhCQ47Y7JcBz/afOs5aRsEoVzj0Yk9V7SkPG38Ndybgzbmf8WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQW4OtTOIXsRS8putoR9wj7fzr5napfgU3s30RkQCC9j0Gkp4
	+cQFvBvESP+yN6lS9VTRgSrbbHmXLQywpMI5PCCkYpdNq2zG4lCs
X-Gm-Gg: ASbGncsvFyfj+DTUh8iArP8MVgANkp7MOH5qXWgAALihYzI/hsDsT1fbFZNaduB/rW1
	R+U7s+MIcrPGoWSF8TzTDGqFibkltThy11ucR0elcOJ603JxDj/Y4n9lddsAybgxR9Gd/jq37IY
	kytblwTlKWcCU8ZZsPCdtWKSqD6CpZ/7OaKtU+mndZg9NNlodqVOCm6Dz+bO9yLBIJE8Jq64Wqq
	ms4qdHU+HWNJ7praHgtaIXcJJ062pB56JcARFJ7geIJCpZw9pplmjvITfwF2S9dmHpvGECUeTC9
	PMTD9Sf1CM7fCjJ9
X-Google-Smtp-Source: AGHT+IGjFNrmi7UMgu/44yDEfF1ZW51HqTWuDurr/WmQMThCc7ld3503PXol/LogeG6aJRPCN87jUA==
X-Received: by 2002:a17:90b:4a4c:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2fa240634e1mr25196994a91.13.1739272749646;
        Tue, 11 Feb 2025 03:19:09 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a16e53sm10186726a91.11.2025.02.11.03.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2025 03:19:09 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v6 2/4] libbpf: Init fd_array when prog probe load
Date: Tue, 11 Feb 2025 19:18:57 +0800
Message-Id: <20250211111859.6029-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211111859.6029-1-chen.dylane@gmail.com>
References: <20250211111859.6029-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

fd_array used to store module btf fd, which will
be used for kfunc probe in module btf.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index aeb4fd97d801..8ed92ea922b3 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -102,12 +102,13 @@ __u32 get_kernel_version(void)
 
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
-			   char *log_buf, size_t log_buf_sz)
+			   int *fd_array, char *log_buf, size_t log_buf_sz)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = log_buf,
 		.log_size = log_buf_sz,
 		.log_level = log_buf ? 1 : 0,
+		.fd_array = fd_array,
 	);
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
@@ -214,7 +215,7 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0);
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, NULL, 0);
 	return libbpf_err(ret);
 }
 
@@ -448,7 +449,7 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 		return -EOPNOTSUPP;
 
 	buf[0] = '\0';
-	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, buf, sizeof(buf));
 	if (ret < 0)
 		return libbpf_err(ret);
 
-- 
2.43.0


