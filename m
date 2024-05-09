Return-Path: <bpf+bounces-29175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F138C107F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FF32850D6
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BB158208;
	Thu,  9 May 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b7Lp4jV8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11171527A1
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262054; cv=none; b=YGCHBUCIN25ns9fHN7SbnlhJvPrl6GaaoRi+C3bRCA7VsXxseEpz6ZFLYjCC7YVRUA40yrtR+jkxFWxN05erASsolFqiZC1OpfPOMGeU+5MDSqSPtOzd9X+IXgYeZG81N0kQ35/9g9YhlKDaHXlLv3hHcmH5aYIWL4GA7Q9k5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262054; c=relaxed/simple;
	bh=xx7n+bPkoW5+4rcSAK/H2P8Ebg8192JxiEdBvY6jD34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9b0Ig2e994mJGUj2AYs4lW1gZLsrgtXK8xLFnGe5SpWf9OcGozy9X9209O7QAV0j5Tg3XyBmKgjjghkHpZdYWsWL9JnZ5JhfvjHq9XtGEWkrGR1FEaaHbQh+S4iWNGtyk18/GsNvItXEVKo20rb90qYld7v8FXg7dr73HcIdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b7Lp4jV8; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 449DOpC5001589;
	Thu, 9 May 2024 06:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=90g+jyj9c5+rSNBF3TWYN3tmGM5ndi6rUhYFl7rY/zw=;
 b=b7Lp4jV8RWrtxp31TVnRP0aeVhZYVh+mS+rPdkOWm9Jgnvb6KKlKqpqkdU1XSSdCwZnv
 dYvCb8ShviQ3eKT9Of3DJqDhcsmt7tEOWSlcgVheB6ZjhTI64FO5NNZwITWAvcZEy32r
 +p5JIB0JupZXmekir0D+a3P+xL/mbAIhtMDABP7dNmTis7QCauuISd12bcZO9jv7B1FR
 c7trXKdpEQtHwe4aeuniALW2LkFz0UtMH3H/q0a5qlDVc35ZU3834NO0QFTe2cWgYqm6
 zPxWnw9AyuZHSTYEWQ5FMVPuew49ocBTJaHcr6WuZgNdBvMgAldM48nQ5mDxOOS8CD8Y fA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3y0e7umtpu-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 May 2024 06:40:40 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.35; Thu, 9 May 2024 13:40:35 +0000
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
Subject: [PATCH bpf-next 1/4] bpf: verifier: make kfuncs args nullalble
Date: Thu, 9 May 2024 06:40:20 -0700
Message-ID: <20240509134023.1289303-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509134023.1289303-1-vadfed@meta.com>
References: <20240509134023.1289303-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _XolGbdb2s77eUR1lCdC7Nm2kskVLpCk
X-Proofpoint-ORIG-GUID: _XolGbdb2s77eUR1lCdC7Nm2kskVLpCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02

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


