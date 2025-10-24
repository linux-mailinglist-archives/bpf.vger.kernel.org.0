Return-Path: <bpf+bounces-72160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F882C08306
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 23:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BF63BF9D5
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000A304BB2;
	Fri, 24 Oct 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpy5FCGn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2C303A3C
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341358; cv=none; b=H/VADZvjf6yaQ1Km6AYQczZ8oPPbct6Gu4ThY0n8B11V7HExpl80Vwkmp28VgSfjrxXWBrg6lt6tQ8Iy/6waMzkTKD8a8+8yxO30AEacMhehELHti5A683qVzn3ADN12Z0mPc9nCZ8XcCw9n5kB1EjDSfwStBa0TRyioD2cKhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341358; c=relaxed/simple;
	bh=n0G0Z+92IypGH3eawej6SXwPonZZG9VIFFNWrEFNd3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh7n4lQL6qGBf/BKzJZtwxNhBIX8wduvGsS7eRI0LpsAKG01uNehShxVTAP9DgHqb4zB6yTp6ca6oC5hHCnsP11UIxzBnMLXcGpuwgZQKIe3OxT5+WlezFjxCKugoog+i1SMjNNavNydMGVqP3yUxXp5zFg+93YAv3+gQZD8Mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpy5FCGn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f898fso40109595ad.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761341356; x=1761946156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSNp2i4w9S/UuwRxxUx4tJy96Wj8Kx1e17mXUe1U+I4=;
        b=gpy5FCGnHO4t2HKtg02b+jvQ5z8/9QImvcElMkMXvnYds0GHGXoslzPKHCXFmRKk4r
         6B/HawoTrHEdfhznm7vN8SPzEuPukCjhJ9Czx5uFKWs6MAbcvhvA0s7DZqyhrr9if7NH
         NtZoK2SFHTX3fxdbBN8ROVYhSvxbtJV32LlwPUvWXV9fzU7JGBmegU0TuFpxztRtdUS0
         vwzUx6Q9qG0tpS4jyE6vsbTxIGE16JD0EVjVybyQs/jQYSkpgrZAQESbLMMsV4j/6O6n
         oNzrbBulE6ZldocoGQyl7xJHjDiuCc8AdvQESa6K/H2T17OPQ4WQFHCgzg1yJWUGivBx
         bhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341356; x=1761946156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSNp2i4w9S/UuwRxxUx4tJy96Wj8Kx1e17mXUe1U+I4=;
        b=MUe0MiUgV8ZRDieSRnfRgWZ6Dkwur32FiEceKzcLiO/GGpCggpHJtyS4DhFm6dL556
         8JBv5Lk4mmpGjYuink+RFnvlMT4xp0eUWRrA2cwvBVk9oZxh7V5eJUBwtn5cjFNhwCXg
         9Fgao3mQ7Ogp04JH4767YjOP5UuA7ljzdl0T2efLMwrX3/DcuFki+192AIbR3DOVnz9k
         SchIFFMSEQtPRd0ake70k1FOJ2ubFMFVsU92fXbT0vykQrl52x8NmaN/bsrZGeXJGGBD
         CKlhhGbinG6cD570K5wrphYMAHCJjuiOvU2tuZPVzBXEGnLA+FGE8NQlEI+0zaPY4Xdr
         FWzQ==
X-Gm-Message-State: AOJu0YzVvmmJuze6BSf1JZ8cuhvUGcqWvJTteGeo3HX4P9kfoOZVXM7D
	ase8zC+9SLtDaY14LNOGjXcnwODoFpjOYS95rYLfFkljo5pU+PAJc1WDSvo41g==
X-Gm-Gg: ASbGncsNAS4MWcfuqEs1WLoEFmmiDb/xw6uoXElqbYgJKXDC2xRnNN+5H5NUh2mCBTk
	ru5rY7yOdJNsnbTB8AC23AkzLtVTqi29DGmENTzBTQHR+Z4FxVIoIxtz3NXPYgFo/6zf/5ekksD
	Nonrdvq0/jvYnIeAIjx8E3BQMfuCHCrjWosfo8LTW4C+BSjvMDkLQ6SGdO58pd5BFZ3ae5oqIT1
	CyS/HpZkwSxfSa3uvGgP7Kdd+kqBcNNoqObo3nsnB9UHR0diukqxr4d6YNPYX0MbNjQfvV+Gjlt
	wuYjJ0SPCG0mj5BE2eLpbRB3ZEqn7SCWtnDaksSSUEucFsEihXBq2NTmnMz0y0+W9SzL4IrEe96
	rvaTIQ71ZCkx6WBMw4o2wObWqJqITl6Cm9v3+/e1dmihtqhUXYakUoqFkk5pho5z4jxw=
X-Google-Smtp-Source: AGHT+IGJr+5x77DlT/OshDRttOBsDAAwKl+sjLHIhX4wnUpBuJ46bCMGDYr+9fFwDn/OZDmi7ghTDQ==
X-Received: by 2002:a17:902:e889:b0:27d:6f49:febc with SMTP id d9443c01a7336-290c9c93af5mr388840995ad.1.1761341356405;
        Fri, 24 Oct 2025 14:29:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d20d76dsm180911a12.28.2025.10.24.14.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:29:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/6] bpf: Allow verifier to fixup kernel module kfuncs
Date: Fri, 24 Oct 2025 14:29:09 -0700
Message-ID: <20251024212914.1474337-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024212914.1474337-1-ameryhung@gmail.com>
References: <20251024212914.1474337-1-ameryhung@gmail.com>
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
index e892df386eed..d5f1046d08b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21889,8 +21889,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
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


