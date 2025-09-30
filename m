Return-Path: <bpf+bounces-70031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0154BACE83
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5AC1927B4B
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532A23506F;
	Tue, 30 Sep 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFSTWdD1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785392F8BC9
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236340; cv=none; b=Q0UHhMuqXsjOvbYCwIK5p0TSpS9+A/4Iy6vXmRuPE+/C4FbJkWePCuxDBRCjS1THj12Vou57NGF+FhfnPLBGJE6HgRDOKSRfhx3tVgFkXeQp5sJoZ7ZAxDap2E9X9JAnBVJ5YdFNOqTPydbSk2w1gp6DglGGGpe1ZDdoY4+iS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236340; c=relaxed/simple;
	bh=RhD4wRyJ6JrKXpHGdE7Ncj7RJaH4+6kDpH3uXnXtynM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpPRJSi6laoCgheEXOnbGwyf9epQFWpjVhwTPT0ArEYEFTOrLwUESGtCYthJjeCeg+VvZnKjvnaXZ/wSTQDdPp3YloL4eq55bY9+ODkIjzHyM/KIrob/o0KAE0R+rYpBMw0QlmkSUVAS8FaYcEAufpgxFgJJ4nm3uylBwDaML94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFSTWdD1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3949823f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236336; x=1759841136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3U7uJweED6UFPvI28CiCkAiHQpDM2hy20QPw1IpT2s=;
        b=PFSTWdD1Jh7rO+nfhDqQk3BzxOHYaAtkYkQhsnKuQjic5cekhhiWcWm0aisTJNW98H
         ljNm0Bk+w9zV3KphjyV+yhy0+s/kd2hTZw3p5c8j77XDuyB3v/o6BhP9aJUYQdXGH8OU
         bjv2vkJ7YNFcXoaY36fr51iopNFP/yg5PVNBv4K0LD6kfoQCAN0imb0j+/jJicxisumK
         QO57hfMUxysX9PCB6Hq16Fg6Aw/aM2NoSqXQ6wmD70YY/orRVxU88cM6nzn8zmWWYS8Z
         iRmlskcuIcV7OlOgtHrM+2nYPtLSxZhimAh7Yz/grsjLcngC8v3rAOO1RPPamr1AIQnl
         Rbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236336; x=1759841136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3U7uJweED6UFPvI28CiCkAiHQpDM2hy20QPw1IpT2s=;
        b=DcEQJ4pXG3MO8XkWIbPrsV2V0ULrPqY4IBa3AKSkntQhdP1zT5R1Gkr0w73Dql+SQ+
         ZsVwrr8L5Jl6vNZ0CJKaimAU48zSJu8qeTbRqJqXHSF/e6SYgdbg1URAcsYLs94A0rKV
         r9tA0uScAJlRy96KBR2XeWnSD+cruqewoJLKgOTIFimjHNWBLJJoBLzmelc2nEriW6DB
         eSlOL3l2TC32F45UyQBmrbqAdMGpl36gRSGW5SGxggOXaybLUcN2jGfnrnOeuxUPus6e
         skegfZSre894DrgZd0crYYtjDQNW/znuRg/zpZnFOKReNyO858nCFHO2boM4KUYsucqH
         UxbQ==
X-Gm-Message-State: AOJu0Yx+0vm8J8eIiEMlMHUv2yVgoqM2Q8Dvs4Xtn8sESRaNVf4cfp6x
	VhxB1xQ78B2ULT/Teet863CNK9QKpHamzLY1jnzIh0pGyXF/i79TyBDdZokq7Q==
X-Gm-Gg: ASbGnctvw79kskMTTVO/82HA8hnBdEzaYN0d4HzHv7GCphW6OO7JczdzRm4eadRL5+7
	Lj64YwaazcPJW/GFvbL+CScAALADTK2xSRAOUGnREv7ZmPckidWbAtw3tcOTR7Jdy9jke0A2DwY
	1cIG/slciAXRDqqr3bYVsvkjef10R1H/ZN4ZGzvIXFdJVzaEZ+qwTNlSnNvvhwiELbqYaUTDf45
	HE0ho5Qcu5bpYAlQZy2uoB8ssnGnvnz8pBrdOXt/Wou9u9F211X4USk2fC8CJW3FnHAIbeHkMeu
	ucDdMa7MGygVO3q7jfFG4i2I3HMLFhB4DWMmxwBWKdMCY3vvqKsLsfDfuTu9lRf3xQ3X6ICr8Er
	kJxMc+Z6jEVhc0VFsokkYFDRfrWD6oI5H/+d+cDL8Ps5/LvBZ6INgrDfJl/wB/1BaAQ==
X-Google-Smtp-Source: AGHT+IEinjt/ZmenflOcVtvXib+5qg56oVsebc50BXA3MUthVJ1xNTKGOYsn3uW8tzD5mMC4nb6FfA==
X-Received: by 2002:a05:6000:240c:b0:3dc:1473:18bd with SMTP id ffacd0b85a97d-40e497c348dmr18298495f8f.3.1759236336177;
        Tue, 30 Sep 2025 05:45:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:35 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v5 bpf-next 02/15] bpf: save the start of functions in bpf_prog_aux
Date: Tue, 30 Sep 2025 12:50:58 +0000
Message-Id: <20250930125111.1269861-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
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

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..8ad666a02c29 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1616,6 +1616,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5313ed905dc4..cc43116d283c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21570,6 +21570,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


