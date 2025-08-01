Return-Path: <bpf+bounces-64881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B8B1814B
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 13:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99711AA7BEF
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 11:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD71DF98F;
	Fri,  1 Aug 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="e6bpmgnv"
X-Original-To: bpf@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556E17BA5;
	Fri,  1 Aug 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048818; cv=none; b=BvR0PDZB136a5bZ7fHG2iBz3jLXtorBFul86mmXO9B3ph5HryU4QU3E6XeVeH9umQPkoeTxSmGIDFKrXXCuVjaE5Tn1W/FEwD4dunjuWUarAVPVcGdObB/GIPmYV9mquv9uInZPb1htrKwLTv8d9FX5DIHq/P5rcdsta/w32NN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048818; c=relaxed/simple;
	bh=y1ul/ePEL6TuTljSvrve3qgbisA5RKF5kOvE/Fx3ZyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3ZgY4bCDbshWb7P18U3uKNwuEgmZQlT+Lt0Wk2XeOFjL5+KRBXeCXc4JtvnafaFpKoIMEHAs26rvap8pyfPvnlgv7ZbvqM/Q8gBYmqYSU7mEtNEKPp2E2G+VDwSqb80/fV7Xfebil6Nq6Mo/4ZYLfg94tK/Oh8c99GCKjJT1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=e6bpmgnv; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 6A9247D326;
	Fri,  1 Aug 2025 13:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1754048805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYwCqmJrhPqYZqyuDDiVsTLJbguAyJltYFAQRIfPEys=;
	b=e6bpmgnvIcV7iKSmDn00e5xC5ex4qX8Xt0cQrU0q1+S1TcMU0WIeDgcnSdi1tjkNEXKd8R
	JJgmrlZmPkGSd/bx6E4y9OiwYEWsZCdbKq1zUgzccjk9hUfW3Qftj+uokXj022JXMJsd3T
	Uvom74EupBPfJJ8EKMlYGGVxU3EgN2g=
From: Achill Gilgenast <fossdd@pwned.life>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Achill Gilgenast <fossdd@pwned.life>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] libbpf: avoid possible use of uninitialized mod_len
Date: Fri,  1 Aug 2025 13:46:06 +0200
Message-ID: <20250801114613.610070-1-fossdd@pwned.life>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <a74ec917c2e3bf4d756a5ce2745f0f0a2970805a.camel@gmail.com>
References: <a74ec917c2e3bf4d756a5ce2745f0f0a2970805a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

If not fn_name, mod_len does never get initialized which fails now with
gcc15 on Alpine Linux edge:

	libbpf.c: In function 'find_kernel_btf_id.constprop':
	libbpf.c:10100:33: error: 'mod_len' may be used uninitialized [-Werror=maybe-uninitialized]
	10100 |                 if (mod_name && strncmp(mod->name, mod_name, mod_len) != 0)
	      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	libbpf.c:10070:21: note: 'mod_len' was declared here
	10070 |         int ret, i, mod_len;
	      |                     ^~~~~~~

Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20250729094611.2065713-1-fossdd@pwned.life/
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067cb5776bd..fb4d92c5c339 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10086,27 +10086,27 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
 	btf__free(btf);
 	if (err <= 0) {
 		pr_warn("%s is not found in prog's BTF\n", name);
 		goto out;
 	}
 out:
 	return err;
 }
 
 static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
 			      int *btf_obj_fd, int *btf_type_id)
 {
-	int ret, i, mod_len;
+	int ret, i, mod_len = 0;
 	const char *fn_name, *mod_name = NULL;
 
 	fn_name = strchr(attach_name, ':');
 	if (fn_name) {
 		mod_name = attach_name;
 		mod_len = fn_name - mod_name;
 		fn_name++;
 	}
 
 	if (!mod_name || strncmp(mod_name, "vmlinux", mod_len) == 0) {
 		ret = find_attach_btf_id(obj->btf_vmlinux,
 					 mod_name ? fn_name : attach_name,
 					 attach_type);
-- 
2.50.1


