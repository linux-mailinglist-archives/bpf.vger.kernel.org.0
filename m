Return-Path: <bpf+bounces-21182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B712984916D
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 00:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C21F219C2
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910DB676;
	Sun,  4 Feb 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJtWd/5W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449FBE58
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707087758; cv=none; b=JdcSbHFL7ZCcodDHuZ33hPtwPZ3BED+Y0B7+m5Nf5Kz8Xueow9EwpqDvj+wVzrLbeJTocqbjBr7boak/blMdAC76nwU2/9xQf/cNQNy0tSU1TcKuL64sJHG12rCWzx0JJw3r6ghBssdDfCRovsOmG1UfpEFHe4WJMc4MhGvzglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707087758; c=relaxed/simple;
	bh=Y5sEagRMtUu3cf9U/alxyUA+rjezKQ4qrByKo82xLK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZ9M0YwSrOvz1ikxdpWE0TmNE8UcbfiEfIVS9+hs/vg8BPZAsnaCxTLeebzFj2q4ChieLVt6mjYyF3+xPbl56gBFCBMV07I4NmGQtlNF93APhAyvDxbuqq+nqJIr5eZQskU4rFzlHiqZbsv67WITHmrVf/bROtY7wZWQ3UuEy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJtWd/5W; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so5039840a12.0
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707087754; x=1707692554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bV35qLxXpRlEdi7mclokQh7x+DCnPlJaBu7Zs3RypI=;
        b=QJtWd/5WmT21chdLaNhhNVj26Jpe5Px6ltosQkn52o6dh+IHWnOgdlestu0PWygsK1
         06o4yANV1GL6VpEldB4fbQjy8thg50K0zLguNpTNFpBbUPj3ViF3FOHS66xxFTrejYe3
         ixnvcRF0xNIKj9AziPlFlzZizw4WASJGCWxdBuykGaCjjNIbPXfzO20DYiBDGBiVRjen
         Jhm0E9YveLEKvZBxOni5iruPUJHJdryrLHF4P3LcDfohpOpTUkQA6F9X83iN8uFvaHdE
         e5PEe/ktiJby7ZdqOpQyZlLlL8pX8RLJikcywcg3NTaQKa2sW0UWaC+wgOjdSA4M+HYE
         l5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707087754; x=1707692554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bV35qLxXpRlEdi7mclokQh7x+DCnPlJaBu7Zs3RypI=;
        b=DkN06U9abITMZ7y0z5TGIhQSGWHVj8LWAHzu92uhjYqxv28ROTSeRL0+THNd+wjd00
         G9/sXwlJsTCuVHAbptRnjQzhWDLOo4uzoU8d6YqscoxS76D3pG6pSQc+SVt6H0+dGKqr
         k8Ic65OgnznoQHY4OMTa5GJE35HNe2eEE/soIe4ibI0aIuM/mdldr6CAVxZ8vZ+Ur3yR
         qFfBadCwQJUaj+5aXiKCcDhvr1g8gjdbNBf/KEa2gUvh326wD7nKdF/1q/gOoDgGdoWQ
         7IcSecEYuMe0zUzhFLOt4cP+DMFtMsfSQybdIT1eO3t8dHOdaiiXUTbrdJqzFMzXcXyO
         burQ==
X-Gm-Message-State: AOJu0YyliZMmijScbFTSn2+BZFUkR/BmFLgkzEN3eO+yEupInnP8Xtco
	0t2nbIxruLO7J8bSF2GGOeI85xMA2bXU/k7qbigqFQe8uVhyZ2RYOL/1SFyUTV0=
X-Google-Smtp-Source: AGHT+IFHi8p7VTc0QAY/X1T4fNUwzzyr1i9Z/Jofr+YvvGN3qH7/3YDOO6H+XD6hIapNYbjZ7MlrhA==
X-Received: by 2002:a05:6402:3416:b0:560:87f:3215 with SMTP id k22-20020a056402341600b00560087f3215mr3437252edc.12.1707087754104;
        Sun, 04 Feb 2024 15:02:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV0VwJ89ylD9mEAWbYGaVp/2ooe9Xf8HimcAzaCtVkM4oEvTk/oEC9Q4Y2HIzD2RSzAqAvw7mWYVlptu7CopQrz9MEo7xoI3mbdun19E1SEyK1LMHJjmvo7Dna6LZj3vedLfH6BvJEs9KkzDEhvXLx5Rf6QZdn6fs/v5+pCYrddbxEowHvjFoXWRb0bu+QLY7oHOodvdBRczgmK6PXT6tlDpEcdDDaV
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id v23-20020aa7d657000000b0056020849adfsm1881172edr.26.2024.02.04.15.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:02:33 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 1/2] bpf: Transfer RCU lock state between subprog calls
Date: Sun,  4 Feb 2024 23:02:30 +0000
Message-Id: <20240204230231.1013964-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204230231.1013964-1-memxor@gmail.com>
References: <20240204230231.1013964-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=memxor@gmail.com; h=from:subject; bh=Y5sEagRMtUu3cf9U/alxyUA+rjezKQ4qrByKo82xLK4=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwBeATk8jBgpvsCp5lsDq0axRXSCLbgN7meumU dcxDWG8mmKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcAXgAAKCRBM4MiGSL8R yuBsD/4qRAXgXZu319g2K2q5C17DDjyddcFUf/FgUWenMw9ZtQNFznJWE+kXIwi3xqTgAS9cjdb wgTp9vvkK5/a+fNxtfE++K/K2gYPwL6w1QxSFIixNpmzJJX3UcLv/deBWnuOeEKgMmsP/rjexot VEFKSvPIGHfYkKYYHOjgoA6HPHzLe6sBnPzRsh+H3D5CfrKaucGQFUsvMIilCkS6Aun9I+t+Qnz 6CDXJVzv+J4S/AoKd0JCN0G9JYbPEZTqG4Z32kviX8xjNz6X5BQfPQ0UceWRM3ooz/6r89XDvLn CQEuNkPgGqqpadBWL9mjuEsRUH0XpzkkZCF7QFQnIEWOTdQiT5ERX/9tPE/viDs7RV4DZaijSQz Kx04iH5ewfTWrsSJ4bJAOnc4pHFtcE4rqURpT8heQYEE7Aun3eGZOmQZvKWHwTkK4dgrRIdOC/a osrSJvnlj6PxG3Fwvub09qIs/vcRzj+cltdfrWJ9rbQr9wQ+jumqnhy42U2txxloaNNDGyMUBWz wLulwEbm4YO9xiDNFQjcqmD3boWraVDwfprmOJqJgkyR0RbVNLmacnq8y9QSoLhKopl1Q5D1YAB yYemEaGgIpVQCTH9IOdcBxadp8P6mgyQuPU2ghtWiihJovAXrJuNNrWboeXQKCFo+uQoE9Pbess qVOGKK0WvhsLffw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Allow transferring an imbalanced RCU lock state between subprog calls
during verification. This allows patterns where a subprog call returns
with an RCU lock held, or a subprog call releases an RCU lock held by
the caller. Currently, the verifier would end up complaining if the RCU
lock is not released when processing an exit from a subprog, which is
non-ideal if its execution is supposed to be enclosed in an RCU read
section of the caller.

Instead, simply only check whether we are processing exit for frame#0
and do not complain on an active RCU lock otherwise. We only need to
update the check when processing BPF_EXIT insn, as copy_verifier_state
is already set up to do the right thing.

Suggested-by: David Vernet <void@manifault.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..993712b9996b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17698,8 +17698,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_rcu_lock &&
-				    !in_rbtree_lock_required_cb(env)) {
+				if (env->cur_state->active_rcu_lock && !env->cur_state->curframe) {
 					verbose(env, "bpf_rcu_read_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.40.1


