Return-Path: <bpf+bounces-32131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D12907DF6
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8521F245D0
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935ED13DDB9;
	Thu, 13 Jun 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GXh+GVDF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5A7604D
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313534; cv=none; b=nlR/HRgm44IxTXMqSPAZsT/wZNY8gX+E3+rurv1XXCjKTwsNkt0YExuIMymiKtoWxuzzkFVGG0++aXhCPjGIu/pM8KrJlIEkLYwUnEv91gIRPkes/qt0JaQ47xEIftMcSq+jucWo9qv6+g7ymTOx1ug/2JOcqdxkUNsIcIg4FaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313534; c=relaxed/simple;
	bh=IDAlJaZb6bb54aPjeyTpv3YrmSaQ9XJm7++0B+dqPaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feF6X14dW9gqLXCR2kcWFqXdLKhjeBTIeitwW7D2QcJ/4PDegzBVXDgCLzTFL4AtS/X2pIiB9yP5qkdHpPjcFDrv4VCmM+HDinGWNHC0/YQvzCUJ6xE+yoNvPB4QyljBSGwQYwBbdPbJJkZ2lcKV73xG4U6HIhHJyUnIFcbS4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GXh+GVDF; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DJYD1w003272;
	Thu, 13 Jun 2024 14:18:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=K/3fv4BqO5ok7HdzZ8VoTwfKIfvvrhHmoX6khZJEpYk=;
 b=GXh+GVDF5Kjkkdjd1knmMXwixWcHcT2vo5r+RTA9CLWmyGBQ9PFddFdqLDkTCD5gcmh5
 5d7ZHW/RXjRtN830CmFQ5HJFmIMpA2RH3lmcmbc7BxENzWc3BgB29CJWBsYqiSaPw9tK
 PSTkFsr5EBeQrxySG9KUPr+gQK1Z5nj4+fMnEUwDOpDwpgToZb/4JDIIiKXyo2TQqmoM
 jHgOC0Q14sBXV1dPVgI6H95FXeydYuQuNKCScrG7ujKJe5QfakODnunFSEwzWi6GuEVz
 IM1uRHzg+wa3dtulXHe9miNTWCB2BCPerZwAN9bCq4Umw/laaPFG1Sl2BUShX0mH8tA9 yg== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yqd9gtyxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Jun 2024 14:18:30 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 13 Jun 2024 21:18:27 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>
CC: <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf-next v3 1/5] bpf: verifier: make kfuncs args nullalble
Date: Thu, 13 Jun 2024 14:18:13 -0700
Message-ID: <20240613211817.1551967-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613211817.1551967-1-vadfed@meta.com>
References: <20240613211817.1551967-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: h5Uws2jOFpblgxhcWhpZakq5SZqUEA2M
X-Proofpoint-ORIG-GUID: h5Uws2jOFpblgxhcWhpZakq5SZqUEA2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01

Some arguments to kfuncs might be NULL in some cases. But currently it's
not possible to pass NULL to any BTF structures because the check for
the suffix is located after all type checks. Move it to earlier place
to allow nullable args.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index acc9dd830807..e857b08e1f2d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11187,6 +11187,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
+		return KF_ARG_PTR_TO_NULL;
+
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
 
@@ -11232,9 +11235,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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


