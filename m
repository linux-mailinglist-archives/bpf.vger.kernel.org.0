Return-Path: <bpf+bounces-35099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A82937B7E
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C951C21D8E
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2C146D45;
	Fri, 19 Jul 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+k1q+Vy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFE13D61D;
	Fri, 19 Jul 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409683; cv=none; b=XaWZdWY6VKgJXdBLwNHQ0wssWOnC/ZyHzNlVuAg1caLsG85GwXz4VJUJaZ5Yvh/nH1JcmxuiaDFnE8ewy+0l7eUne/FUXXRruVuNWQ0KZkOXjgehTj1A5tkizmtgOrTntb+QKwMY22TEOgKYqskLWA8XxY65tJgrNOwKcarnI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409683; c=relaxed/simple;
	bh=N7XN9zYJyoXoo4WBRpHa3c/xnLvk5O5Eq2nJF1C9R6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOqLsSlU/U0Ye3CVqdc1KXtyH/7NS5I+NYiwnCKbBRXA/vr2JS6+BMRA1p8y3fnmgSfp2QC19IHiM3EmKaU1Du6QQCkrEHovnaHoNYKo0FH4QpIX82aaCJpEDbjJow2vNW6UheR4vBEK/idY+MtxEcIIGyL3dDQhyMqeLC9DZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+k1q+Vy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79f08b01ba6so143258485a.0;
        Fri, 19 Jul 2024 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721409681; x=1722014481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHkR3HeaTgi9Sf/bo6ZYoa8FS/YOxvNEWT4vNOjsanI=;
        b=S+k1q+Vy0We+3KOVL6AlIVVLCdbXQ1AAHlMlwOhwJzM/97OJW/GdtkfhKep1BoG/yi
         Fu8stwgNneZJEKKuV4RuHObzvMdtsZaH0iVu9VMC42JE73vU2fb3w+4B3HeUaAghFtZ+
         MXLN+6x8IohrIz2bgPwOhLpNqqU2K7OEwujJx2GKndfgNjp3fLhwOAhMiZeRHf1+6s+x
         7jYGDHF7SV8Sw05VuwMErhiN/aWzxvFpJ47BJ5J9lWqZG6oUYxzf7i/F9BEeqZP2ytua
         bnKHPxikGuvqU/24WdMju1gZrLA6U15sko/zLKvTVL9XoGItPMrR+T96hwgqsGOB8/Q2
         E0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721409681; x=1722014481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHkR3HeaTgi9Sf/bo6ZYoa8FS/YOxvNEWT4vNOjsanI=;
        b=w7RgIWW0LUbSO1ERRNMROsgElWlnkrtKpx7KsX7Lp+3Aem/x+lEtU5asHHFTPdX6Tn
         19AP5/10WkTWVP9XhIp3r2oEuBbHlath9caTBINcNUmNS1HTVAa01PLKlKyk6I+9Vi77
         8iczvPVGeBduKMfrod72TQB9PCrfaHZq49Ym9NEw/GWE6TFskmyYbFLw6B+maoXerZ6/
         XLMoYVe4mUQeHue8hBIi674uzq3RL2n23UydZU4yYk93seDKZkMSi+al1qPRvniM/ups
         rvSbiO1AsottLYIAL+Eru1/TK9NHAUhM2w2ZvmT3NGf9xn5R8tp+nG40I/FhFsgaIUq/
         yIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMo5KdxcbqrKFXuOCckxmwSlXAktHakBA3KOLreggmcQlz05ye6410kxxFjbhYEEI5BEP972LAePW7vj02xD1aQ95tebeB87gaoFf/wIDIVPkhb2PwQlzjAv/g
X-Gm-Message-State: AOJu0YyBlTpAMitO79pZsNXGmizRj3KT3WHevnteFWxSCM36ezoOVjOE
	FDnt5g1QsAMOJsPZHJp9nfJXIdWwUC42qbORUnw133E2y2qunokH
X-Google-Smtp-Source: AGHT+IFcJWc4DhxYXowk7bcxAPqGv/DdpDPFiY2uxMgEAlptAMLX/qoN2RtmyPMXSgSJsN1EQuH3SA==
X-Received: by 2002:a05:620a:4549:b0:79f:18f1:b6e6 with SMTP id af79cd13be357-7a1a18e9aabmr60574685a.10.1721409681157;
        Fri, 19 Jul 2024 10:21:21 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905eb1dsm109706485a.89.2024.07.19.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:21:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: ameryhung@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	sdf@google.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	xiyou.wangcong@gmail.com,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	donald.hunter@gmail.com
Subject: [OFFLIST RFC 2/4] bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
Date: Fri, 19 Jul 2024 17:21:17 +0000
Message-Id: <20240719172119.3199738-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240719172119.3199738-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240719172119.3199738-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

ARG_PTR_TO_KPTR is currently only used by the bpf_kptr_xchg helper.
Although it limits reg types for that helper's first arg to
PTR_TO_MAP_VALUE, any arbitrary mapval won't do: further custom
verification logic ensures that the mapval reg being xchgd-into is
pointing to a kptr field. If this is not the case, it's not safe to xchg
into that reg's pointee.

Let's rename the bpf_arg_type to more accurately describe the fairly
specific expectations that this arg type encodes.

This is a nonfunctional change.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/helpers.c  | 2 +-
 kernel/bpf/verifier.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f1d4a97b9d1..cc460786da9b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -743,7 +743,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK,	/* pointer to stack */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
-	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
+	ARG_KPTR_XCHG_DEST,	/* pointer to destination that kptrs are bpf_kptr_xchg'd into */
 	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
 	__BPF_ARG_TYPE_MAX,
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5f0adae8293..c038c3e03019 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1635,7 +1635,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 	.gpl_only     = false,
 	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
 	.ret_btf_id   = BPF_PTR_POISON,
-	.arg1_type    = ARG_PTR_TO_KPTR,
+	.arg1_type    = ARG_KPTR_XCHG_DEST,
 	.arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
 	.arg2_btf_id  = BPF_PTR_POISON,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8da132a1ef28..06ec18ee973c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8260,7 +8260,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types kptr_xchg_dest_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types dynptr_types = {
 	.types = {
 		PTR_TO_STACK,
@@ -8292,7 +8292,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		= &timer_types,
-	[ARG_PTR_TO_KPTR]		= &kptr_types,
+	[ARG_KPTR_XCHG_DEST]		= &kptr_xchg_dest_types,
 	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
 };
 
@@ -8892,7 +8892,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 		break;
 	}
-	case ARG_PTR_TO_KPTR:
+	case ARG_KPTR_XCHG_DEST:
 		err = process_kptr_func(env, regno, meta);
 		if (err)
 			return err;
-- 
2.20.1


