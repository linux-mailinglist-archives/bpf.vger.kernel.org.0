Return-Path: <bpf+bounces-54319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A249A67665
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558143B36D7
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86AF20E6E7;
	Tue, 18 Mar 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="F02H5hBs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9C46426
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308200; cv=none; b=DDASlmMM86KxFhqKc5CsrAq/Ha9LVdd1H1+Sl3rdVzqMXWi4jFI80dKL14Mo/4daXtUSulKdQAcNkmq29himSqBDk8DvyqcDRK84+XTMcRa2O0sZOzVxOE5wMUk1AxZOznVQOTrim05HD+am9+8r+4WRFQHM71arvbOoUpHpYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308200; c=relaxed/simple;
	bh=oODnVCdr1945qfq5cPuBPmRRXDtvK2Eo5z+BNBfhJ9Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=monQotzA30QEHetxsZTV0AfLuxVLVdPm8rpLvY4bcuS3PA9H5nq2mgZm1JD7ouBlwtsVIpcBogOo03NvIt3bD9KT2ADcQxxp2DbxEs3L3AhfK0xZRTd6SiJo/zkrJZ6oY0uLIK2k0RO0vPvQJYzTRvEX5GXEoydUxQVwJ4MxJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=F02H5hBs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0618746bso25938245e9.2
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308193; x=1742912993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqan77Wlb3LpYTtYGPOVrcaQChoebzScRGAKNoFaw2w=;
        b=F02H5hBs5DvXKvHlJ8iMXNvs1ncGA8ywJEcNpKTxcTwcM2nY9XpxoJ1ipi2p+bHSSm
         j8/Yn2+7k1PpJAzPY8LcV2+urXyzpexPpc98buXcZQhKV+yCwM2ADj0CSrfat5t1BgAN
         me+xpjpmftLMXvU2yC03xoHbRQnezLa/iNu9S+B00jJybjpBOgR13yUgcjnFY6qgMzai
         hiys0eeQZ7y80B3J+Aj7AqQV9dDjJ6M1tYyO4fuFiRUrsUdzCCXucL1iGpo0CPqZ+XUB
         RVikrMfse/q6+luzEnfESkHWwwTOpoA2H1WOE57iVPPPQHENoMHlaRk2TYLo+Td45Nto
         pKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308193; x=1742912993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqan77Wlb3LpYTtYGPOVrcaQChoebzScRGAKNoFaw2w=;
        b=TVKlW8eMNn9owlAfc8MHMl73vdZQ5XZ7UL8IVb9lKn3VSBCw6FhOkIhXTfyNxHIjKE
         +fuKUBJenYMscDE9E2CPbVpzEtXKHS8XcGXeKyD8cnzZM8gSWKvfZ2F114ExZDuMxEiy
         3iAq3QIXXOgukllFo/TmobYaQUlWTTBSW/PKom6IKk2EK5zTqYYr1mfLn4kc+UfqH/p9
         PRrC2KxWPN1JLRh1OdM5VIqHV0gn7oZTEPd/vdCDCaZXOog1EkweaTmFXqa2aD1rl1O8
         s5y9KGLl5U6XazX5JPeLKVtam9EriLUm1M0rzrY9TdGNr/8TmV2t/0mad6G560fGlnS2
         6ZFg==
X-Gm-Message-State: AOJu0Yzz3bmsNTm7nDeCk1nbD3vKYZsqJT9ZLP0vPHq6tS1Dvx3/qmO3
	nON9khEU4bCgRRjv3oFCoX6UeRAQng72YIKVNy/PF5tixcu6c3hAD44pyz4eQ0QJWvA4BYLlb6Q
	F
X-Gm-Gg: ASbGnctkR74TmTRie2XhMVyFxIMPO8YW5kfXusJqn9hwLDCdUAlyJ56IwSKTvjv0odh
	E2/C/LNBWCBaeBjjA2NVzOqs+gneUrTgKB1Th334wJ3tC4TW4Eb61lTbJE0QHv+VEDM2ZedkQpL
	46YnzNHDly0wLTqm+EIOpBp3+MFECKbLPDP2nZkIJ20v9uhBGqD+fVZdOHt5BZZ98AvUtPjAg89
	33y9hmwyJiS9bORu3GvgkUHPGwjcMcCo+hbjAN3A4tTsxBUhPLv6iZcqV87dPXgR6hoKa4fRgZa
	jvNmkTjbWL5/2/FlQ17gG+Nc2PkGqecQTpdBvAULK/mSnZhpOzx3fljyCA==
X-Google-Smtp-Source: AGHT+IGwjpRy7r2TqR7l+c+Fr2nOGop8hEQWz7a2FQY4+deaVgGoskabtlKqqBkHMtZtusEZtbyp2g==
X-Received: by 2002:a05:600c:1389:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-43d3b951a1amr31560055e9.5.1742308192775;
        Tue, 18 Mar 2025 07:29:52 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:52 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 07/14] bpf: save the start of functions in bpf_prog_aux
Date: Tue, 18 Mar 2025 14:33:11 +0000
Message-Id: <20250318143318.656785-8-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new subprog_start field in bpf_prog_aux. This field may
be used by JIT compilers wanting to know the real absolute xlated
offset of the function being jitted. The func_info[func_id] may have
served this purpose, but func_info may be NULL, so JIT compilers
can't rely on it.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 42ddd2b61866..fb0910083b79 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1524,6 +1524,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0860ef57d5af..7f66002071ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20999,6 +20999,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


