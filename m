Return-Path: <bpf+bounces-75264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D66C7BEDE
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87B6C4E683A
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 23:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C686630E85E;
	Fri, 21 Nov 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mks9SMAQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6A22655B
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766837; cv=none; b=m2ZfkguxJmpUC9RBvZWHTYfh8vzNBAoyaLrnx7I+E11TDIEHmgOYsxAYVWVH66po4vRO6JabDBa/GQ8b2RVZ8+7+aM5hvoFR2591QCGUxLE0sAgeQf1B9SRoer3ORFYs3VC1I8G/hH+cS9NJG6m/o4zwNCFCfNUC6IIIypRRtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766837; c=relaxed/simple;
	bh=3K9lZnGtBbwYbmS44CtDcA/7fs0LZXm+KLqcdeuXBCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rds3j3Wqr2TfXdJiC4K6o15yc3AH541XHssQV3/1RaJnfqsb3vdvpi+i9Vb3aCbZ0fdEJu4dUHTLaXzckaOvSvyOEMsyP2FWunN5BebAANe+zcPG32NYez4JkJQS1esTB/jJ1cCaycBqzaua8o3NslEC+m+uSH/Pn09cMITRyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mks9SMAQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2953ad5517dso32462855ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766835; x=1764371635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN4Qf7h07dcgNnjHgXwbtwldBcXrzrsN7+YsR7Gnqco=;
        b=Mks9SMAQhOtTmP+PfZmNV6rjICePX4rjUFsMyzE/BMV6m8efwOwdZgzoxhgb6AU7On
         /bOMJlTtPY0dXlvLqRNv+1JG/SvJCjmU8QdeWPOq6BqsP/yyax+MgFkT+7pU1QbsDIzD
         Epjzs2oHiIBcYH0gpbJu3FvMEnceZTvMAncQXTHvUZ3WBtOVEtenavNrbUNVX4NAAh7c
         cuAkBHWrc0GcYp83ozq0uL8rmL1eZDS7nAmzTSklvCK3YaVj9mVciSSBy7yOV0q6Rq8T
         wQwy5ysXhz0dKndHRLRAUQ6wEzd2uhZQaA7mz0ffoUdRMkdEyvF52uqe0AeX9pdkeebv
         q/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766835; x=1764371635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bN4Qf7h07dcgNnjHgXwbtwldBcXrzrsN7+YsR7Gnqco=;
        b=BHMXwBepPmtSMtW2YDigW7IRz4tDdwzsQ8lfqsOba+cY9spVoMtnEb4JbhX+pJZbsf
         fv5uiTFfgTgWXvcV5zRzsGNijNd7SEObygt5woiFGmOF94cUvVdZhG0VN25XC5c1kR43
         U9aWNfC5lYIUv6sDhxMqm1CQa8avSRnsQjULiXWeHFCqzA03B6cJgsINprVElR73uglo
         fqmlDJvZY9uH9C0o7AnCzcNXUIYcWKz6fP7Vbo62k8d0dtdauC38jeYr1VAvpngy10cy
         YPQIL1kNXwpg6ZRikoeZSI6ieYgyDD3L0k/sPMrP7g1P1STb5YA6uvk5lYZDexDINMKc
         Hkkg==
X-Gm-Message-State: AOJu0YzXHK7UwEcKfZwz3Xi8CbHBCJrTHQvb5RAg1y6jnJcsC2Hibh5M
	SMwo+74IdwDU3v+H1SQfzKg9YRcmXTcXCgBuGVr+yOkbrpNSO6xwmG/gfqL5iQ==
X-Gm-Gg: ASbGncvJplsK4nWTrJZ1HcnxEpm4qVBHO/RwmCLpBwFBb/eHHYoRkIovd2uaLKn3+iE
	hpxBmp/7IM00Fp4k7+vXub/qERQFM3XEy4+lJACWg4igqxpCqCfA3tPcL1UroBtyh1L7vGqn1wv
	hdoIpQZpa8SjZyDN8SuI7grl2aDJfwrDh4CR0bDgUKYX2Uu5CWt+edKreYgtfEjmbSJy0tX4uhj
	7IV+LJkpfz9rZ22DtSMGqgG9s8ZH+9IZyrnc8JVCwacyOh12aL++dAb6WN3mzuIjzPnK7IVZerO
	XD0xOzXqKupfqZo24FM1GxecUDkxNlSelc12SXWor/+dvsKMrSXY1GFbsMatACuNhn+UrlpCSsl
	MA7ylQHt+iCQCE6fSTYU7Wjxi4oWi1DEBZg6xouhlS12Lq+5tLPZMUzmn4KBE/57YqmmTsILuLR
	g9a/nWqFF2emI3rg==
X-Google-Smtp-Source: AGHT+IHj1USi+MCp8ZTjdHNGsbyMsMiMctV4Pwx+mdkpjC0tdeHrrjUjbTvrYC6el6QCnM8KvHCmEA==
X-Received: by 2002:a17:903:187:b0:295:557e:746d with SMTP id d9443c01a7336-29b6bf9b406mr57756165ad.57.1763766835002;
        Fri, 21 Nov 2025 15:13:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2bb7c1sm66833475ad.99.2025.11.21.15.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:13:54 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 1/6] bpf: Allow verifier to fixup kernel module kfuncs
Date: Fri, 21 Nov 2025 15:13:47 -0800
Message-ID: <20251121231352.4032020-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121231352.4032020-1-ameryhung@gmail.com>
References: <20251121231352.4032020-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow verifier to fixup kfuncs in kernel module to support kfuncs with
__prog arguments. Currently, special kfuncs and kfuncs with __prog
arguments are kernel kfuncs. Allowing kernel module kfuncs should not
affect existing kfunc fixup as kernel module kfuncs have BTF IDs greater
than kernel kfuncs' BTF IDs.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..182d63b075af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22432,8 +22432,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-	if (insn->off)
-		return 0;
+
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.47.3


