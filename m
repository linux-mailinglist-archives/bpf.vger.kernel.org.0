Return-Path: <bpf+bounces-21367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9452184BFB3
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD94284915
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3C1BC27;
	Tue,  6 Feb 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOl1EX/V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D701BC41
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257096; cv=none; b=p9Pf7ZCaSjM5sETUmwAtbr7jxiDNXj6MDmAcpcQKeC9z2cnLqpiKtChizivjtc5PJSEoS3BV1LMsBdjmQs3j4s2WIVddItpiWBKHfa9btamz6vOyd88hcAfgK6R+V1gJ4A5xDXrI+QmdsXdsSCYSHHUNW+Oz3j8DFQ06AFcj3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257096; c=relaxed/simple;
	bh=y/WnPpS5v7h0NAuexgmi/BtX46N+W3zY7R6LeqdxZUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHw/GrVBw8JJ7S5J3Kq/iI1shSsDHbl6o9VXvZmaNFwvg5ZzeWbNj1xqr6qPvwwBHkgY4/oZyD4DI0STwdf1LlkWm5aQk7LAguOtvGzwej+5jeLpW9D9oY4MJGIKPm0NdDyirzmi+000UT023wU60QUn+6kQ2C5GsPTvSp3udjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOl1EX/V; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso17840b3a.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257093; x=1707861893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYMIDAZLgBUgMpP99zrxeTSMtNJZxQwPNyQYFWZYzso=;
        b=KOl1EX/VkcCub6+reNZspY+xprSpgRLI5hQkB+ancywiNOlcj8JZzrwfQ1kMyHsdNZ
         s6SE1YBL7ZLfYj3KbcHSCnH3YKioET2piBJeQkT6toegOfB3JXGE6YpxUqILkn23ORFf
         wkgxl+jzmVmgNKYGfwNSFCuQ1OfqvQ6cdUOmgd/pzHh9a+ovISea3Ec4PElBDpITBjc3
         W3QmdaXfcssqlcc6u2aS8X8/k7tVLa05Jl1vKLSn5PbdDnfhda43OimG9SlKlrzdYlIf
         sUsGMkxcrnz9i21j8zbvoKwfWjehYU6f3pEnuU15I930FCqTDkGv3tIKVD1YVka0Kj/I
         yMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257093; x=1707861893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYMIDAZLgBUgMpP99zrxeTSMtNJZxQwPNyQYFWZYzso=;
        b=ItMoZq7A2yRSEl1g7YYAbxqelhvSKCIGr2FKlPLO3S8SJ3t3qm99VmxNUk89Ujjw2p
         +TNAuveSspvKVLOe6QX9UbIW47Cq9OkoZtWYR4U9JvURWdWBirBxqVL6XK4jnK754E6z
         Rx9bh8JpDXWmJedbDxFhibc24QRW+J7yFnsXfkIRUyzkLaeGrtb1ZVtDIrf0fZ9FQuT6
         WhSKGwCoym0MCntqOeOCRchZQWxeSjjW8RjgCS0LmxGhQWpPMzZtX3N+6ripMUupfXlb
         oU4KkQmlN+Pj8Om0S0cSDVkBcbUVgvFa96EGSwXSb7y5oRKC1JkmEWzLJiE2cuyMlBaK
         uShg==
X-Gm-Message-State: AOJu0YxiRUv+RZcGeNnk0BGEf1tn98cio3SjcP0YNN2tCDWw/Os6KZP7
	e5/IbWTjI/hJIAeLNkYBCdOvq2as9NLnorQ0wJYE+Ud/dteKlZ8p3IxEsT/B
X-Google-Smtp-Source: AGHT+IGOIOdH45J5dyDgzanegb8JLdqXenulcK+qVHNvlZfYkUWkLxixF+6eKSWhF7qb3dfASt+aRw==
X-Received: by 2002:a05:6a00:b93:b0:6e0:4f30:bcfc with SMTP id g19-20020a056a000b9300b006e04f30bcfcmr1405410pfj.9.1707257093567;
        Tue, 06 Feb 2024 14:04:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUQoVkIthQQOsy6U4eSoQ5WdjVc0nJCVsDbkA2v0JGF6Yabw2lW6vfJzu68baFahsluKlv1NXHpG3TR+PKOZ23wdIUvI68+73W6afFYOGp3111MbSF540b1PZ6MPixqg3IhHR0uNOvN8cle0tWOioXnGsAI2TDADOi5Fif9LN8YHbGgy0QINttwPB4URjcnMqY8BB11Ij1d6XI/7mcn2HIpchSHafTgbAynmFH5kUNenEDFjaaPYgtauQDqNmqat3SfznSOSAwQYvn61xLPdSXcFtvHj6P1zvY
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78554000000b006e0322f072asm2488200pfn.35.2024.02.06.14.04.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:04:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 02/16] bpf: Recognize '__map' suffix in kfunc arguments
Date: Tue,  6 Feb 2024 14:04:27 -0800
Message-Id: <20240206220441.38311-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Recognize 'void *p__map' kfunc argument as 'struct bpf_map *p__map'.
It allows kfunc to have 'void *' argument for maps, since bpf progs
will call them as:
struct {
        __uint(type, BPF_MAP_TYPE_ARENA);
	...
} arena SEC(".maps");

bpf_kfunc_with_map(... &arena ...);

Underneath libbpf will load CONST_PTR_TO_MAP into the register via ld_imm64 insn.
If kfunc was defined with 'struct bpf_map *' it would pass
the verifier, but bpf prog would need to use '(void *)&arena'.
Which is not clean.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9c2dbb3939f..db569ce89fb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *a
 	return __kfunc_param_match_suffix(btf, arg, "__ign");
 }
 
+static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__map");
+}
+
 static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
 {
 	return __kfunc_param_match_suffix(btf, arg, "__alloc");
@@ -11064,7 +11069,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		return KF_ARG_PTR_TO_CONST_STR;
 
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
-		if (!btf_type_is_struct(ref_t)) {
+		if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
 				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
@@ -11660,6 +11665,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
+		if (is_kfunc_arg_map(btf, &args[i])) {
+			/* If argument has '__map' suffix expect 'struct bpf_map *' */
+			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
+			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		}
+
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_NULL:
 			continue;
-- 
2.34.1


