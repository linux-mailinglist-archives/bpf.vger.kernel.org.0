Return-Path: <bpf+bounces-52107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC8A3E74F
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0CF47A9F87
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 22:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD771C3F34;
	Thu, 20 Feb 2025 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfOXnPqC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC71DE881
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089744; cv=none; b=tVI18ut8CkvLinL2Aqrna6Bbs4xgUJ40Br/GsYBoU2NBL9cpw9+l2XIwfXSg2+6FI0pFn85b0qghvIwYzsECbsRy7rwzNau6kxKCJG1Mf4JNrkGi+dA5C+flODaqCDZZNuLaLThdh7OFZsoxsHHrTmd1GUJi6byHfAY92rGL0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089744; c=relaxed/simple;
	bh=FjmkIwblnzc1BffhJswgrozzGN4BEEZJr3M+4kThQoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+2KqkIoqaoV75LXewestDw9MA5ukvLI5DgoEpks33rfjqLYqWxD4duAqIkWPB6v0sysw+A6xvRn1+I/yeWorbP7bfMGDaP2i6AwcgFspymZ1RKYrntTA1pTw5qNSEFlHPKH4YUnaSvv/pj/l+JOwocX/hktfsGHT0O/pPuu1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfOXnPqC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2211acda7f6so30969465ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 14:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740089742; x=1740694542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUlEJReGACOX1GpKQqg6MAi5kmt0tU9SUBqX7PBIS2Y=;
        b=nfOXnPqCJ5GSuE7qZrLq6iRNYA/D6gL8IvWBnd6HoF/EA56lqr5BEOKRqPrq3LZC6R
         ZDUnJAj8ZgpTcaHrnSPjFQgZePY5V0P4p3WDCRN2zvrRSVguBVw1zgRoXb/Gi04BON1u
         XclOIhwTdlreuDxdsymqRgq5xbe+6pjm8fo7P77+LbCRdPpb1wjwsRGZ8CxX8f8XZIvX
         hSFEKEGOv1bm3BdC1oeom3x59RzkIs5pPdi1KOIGyscZIErZ/3jhsVTAkMvlmi6jYCCM
         Fi0jpGfx6PpNa/K5+vrrHTkiMoKU4UBxiXBgMqnvN2dHzCd04rwNi0imanSMg6PCqCB7
         LR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740089742; x=1740694542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUlEJReGACOX1GpKQqg6MAi5kmt0tU9SUBqX7PBIS2Y=;
        b=Phee8Cp6IzrVGE/P84gfugm1ShZNrHAhS/p0RYJdXrpNBmlA6/AoMzsfBfCEfvqkcU
         gqYBu7wpMG9y0/K+qLyodmBO+T2pH+SPEMxWMRa7B3OzSkAuYBgxbTEmy3+Fjwfq127w
         sGlbP2psm+MYbhOZ1F46U5M7HV7F5fKZaYDyZKDXWGRZ1/Zc0pFpSIi1g1JZdN2joad9
         RAsWkDcOuv2rr6UYXgRIbeMr0ASRNy39L8MDPblunoBwEFyMjkKN0dWA3QoIRs7r1qfI
         ynEG4PErgQvT1FKkau8noZrKiFLs41ZkZQrEJz8rfEdOYtNZDc5L+ynDuRvt1/0GIYRF
         u4ig==
X-Gm-Message-State: AOJu0YwqwDuj7WEcYf+vcu4lKL+h3BuUxQCHm7HVhpKMxSBksmZoyA6n
	wPyWaPdHQGCk/pIUAlI3+3Vesce1CpL9I0nm0xc3Zg59wHjRKKN0auqThw==
X-Gm-Gg: ASbGnctdYOWy8IOX/+el+ihdhF4Dxj8WCCFDkDKaC5lu7NSQq7zkcwAgCAHTQ3xShHb
	tvU1rVegEvO+Hjx75O0Pvni61jU/h2xcJx3bnVtFmFPOpt8wp+a1t5L7iZXDEsIK0RlhNEjFOpn
	m6I7JxnvYGlfWr8INi5hFZmnQaDPDK1rabCAHZlgfSaxz6SKqWFcmJ5OrjBhvLKp3vHatGGIBJV
	/HOKq8CpCfAtr54LZQ5jt2dX4cZUPNZFzeRKLxIicuUSPj/4zmAy8DMetvWC7jiVChQUEtXm+/I
	pbL54b2tRnOFFAMVFhwBIBxcXBCUiSbDSI2x4H7tkXMNhPuwW6qh3KN3di9IRpnolg==
X-Google-Smtp-Source: AGHT+IE0o29TVyfOFlh2vD/cbCwxpOck7R/98+Q4l5kPCCcae9WeaU7yWTccN+WaDQjeTrqyNCht8A==
X-Received: by 2002:a05:6a00:8c2:b0:730:7d3f:8c6c with SMTP id d2e1a72fcca58-73426d9002cmr802260b3a.22.1740089741897;
        Thu, 20 Feb 2025 14:15:41 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425467adsm14852251b3a.15.2025.02.20.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:15:41 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Do not allow tail call in strcut_ops program with __ref argument
Date: Thu, 20 Feb 2025 14:15:31 -0800
Message-ID: <20250220221532.1079331-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject struct_ops programs with refcounted kptr arguments (arguments
tagged with __ref suffix) that tail call. Once a refcounted kptr is
passed to a struct_ops program from the kernel, it can be freed or
xchged into maps. As there is no guarantee a callee can get the same
valid refcounted kptr in the ctx, we cannot allow such usage.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 85b2d4e65834..8f1df279e432 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22450,10 +22450,11 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct bpf_struct_ops *st_ops;
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
+	bool has_refcounted_arg = false;
 	u32 btf_id, member_idx;
 	struct btf *btf;
 	const char *mname;
-	int err;
+	int i, err;
 
 	if (!prog->gpl_compatible) {
 		verbose(env, "struct ops programs must have a GPL compatible license\n");
@@ -22523,6 +22524,23 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EACCES;
 	}
 
+	for (i = 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
+		if (st_ops_desc->arg_info[member_idx].info->refcounted) {
+			has_refcounted_arg = true;
+			break;
+		}
+	}
+
+	/* Tail call is not allowed for programs with refcounted arguments since we
+	 * cannot guarantee that valid refcounted kptrs will be passed to the callee.
+	 */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		if (has_refcounted_arg && env->subprog_info[i].has_tail_call) {
+			verbose(env, "program with __ref argument cannot tail call\n");
+			return -EINVAL;
+		}
+	}
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
-- 
2.47.1


