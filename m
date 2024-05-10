Return-Path: <bpf+bounces-29470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCA8C24DA
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482B01C21589
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA8F16F8FE;
	Fri, 10 May 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i+T2wioN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35A2C853
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344129; cv=none; b=TaPbe8FV5FnByAWmz7HwOdlJ67IgbJfPTRBy5U2nzWGc/SImj/oMI+yg6wLOL2t7MInczeDpLgzMIZA02LEKFEDxfPm9aCplN9BFPmOkPeAbMKTv35TZC5kojVvU/H1P7wD1VnHMkSoVtDdKQprgenNv1noO+f+3KoeD8qJQwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344129; c=relaxed/simple;
	bh=xx7n+bPkoW5+4rcSAK/H2P8Ebg8192JxiEdBvY6jD34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5GMyvyJbwonoGWaOzhgovt29wiLyfJJxdSAbz8czbzUZwVug9J4CIY4KlAyDNSREVUyr84VeE1O42VQum2OzfE6nHXaTGSD2X7zF447tnorAS7PO8f9JpGQSJQ9OzZV94+dGco+lqcnZgVqfBCuvbqCjrnRd4QDuZ/BiVrLheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i+T2wioN; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0PsSJ003550;
	Fri, 10 May 2024 05:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=90g+jyj9c5+rSNBF3TWYN3tmGM5ndi6rUhYFl7rY/zw=;
 b=i+T2wioNE6KYQ2MIqHoIVvnPn9ZKEjOEvSQ8J3D1QcJz8aoAC2hr5phMfrUAOHuyhr2l
 +pkRkbAiymLKay+lZ25z1sQTGaQe/qz2VUeq35mXDEwHcF441/MslAkEeZ6zIfRHJamM
 W+bODE0MjdzBUPQsx0XefdBTYhLLoWHxhFRXldsRDwD8PXmhk+rgl6TI7aWfk5i/IrVf
 bqF+PLG8eq33/5/uYPriDezYu9CcCcALA4wOuMM5D3KIfqp2W0Xx6KoS7fpU3UpZaNAV
 mOSej4N2M2oCOIHwCZpDq2gS1/NIRmt5BtalTbmagXJEDJwLjrZRzKkGbs1Bnv8gunUE 7A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pwb1t2-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 May 2024 05:28:36 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server id
 15.1.2507.35; Fri, 10 May 2024 12:28:33 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 1/4] bpf: verifier: make kfuncs args nullalble
Date: Fri, 10 May 2024 05:28:20 -0700
Message-ID: <20240510122823.1530682-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510122823.1530682-1-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: t9l0ohjQLltjDid8DtfEPmP8seB3cUUI
X-Proofpoint-ORIG-GUID: t9l0ohjQLltjDid8DtfEPmP8seB3cUUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02

Some arguments to kfuncs might be NULL in some cases. But currently it's
not possible to pass NULL to any BTF structures because the check for
the suffix is located after all type checks. Move it to earlier place
to allow nullable args.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e3aba08984e..ed67aed3c284 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11179,6 +11179,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
+		return KF_ARG_PTR_TO_NULL;
+
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
 
@@ -11224,9 +11227,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_CALLBACK;
 
-	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
-		return KF_ARG_PTR_TO_NULL;
-
 	if (argno + 1 < nargs &&
 	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
 	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
-- 
2.43.0


