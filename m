Return-Path: <bpf+bounces-21081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F884798E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 20:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EBEB2E0B5
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9978062C;
	Fri,  2 Feb 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAk6sJyr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2C8061D
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900741; cv=none; b=pcKxQO4gVj/rucT/Zq+9hmuOlKuDq7WPSKv58HmSl21xrBLor0VsVn6+VuPm/ngmskgyMtlU98q0dTflVgUZ//IS86tXG0q7qeEhD8vgJwftS/dMCYTl22EdlWvd6uRzsLK+AucrR1nK/a+q/M0KVIA691+H1yCUyPPcMUKsBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900741; c=relaxed/simple;
	bh=LRobvEBeEvKss454zFbdn7VefKAkrBQSvgl0fc+i5+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbarWrrqxQB8al4t0w1+2vSPVq5al6A1PMJVNCsaLYXH/L0mdYdgzfT+OYdZfKs0hewZVn9S6wxStd+HCiL0+g26rGcxZehsMpFd+5u9HPUhYU4nFLoaaPZdPbytiJiHUizJDSNqvIA1UIUnPHrOZ22PoM0g1J6avAG/rAcYthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAk6sJyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1410C43390;
	Fri,  2 Feb 2024 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900740;
	bh=LRobvEBeEvKss454zFbdn7VefKAkrBQSvgl0fc+i5+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAk6sJyrgrXuFgscKbiwJaEqg1Rq/eM5B9JY//YRk1T+VRtL3g3StkT91uBof14XX
	 GWqUdybttJ7JiDIwqobfGJpIhQ7KwMHSCk4ag90A6QK0xMDTN+8nwK0UWsr40s9Q0h
	 lNT6zrwfiQLhk0+cbaDrTpNzlr4WOmuDvF8G3tMKCLghVOcmdMK2P+YnXe5cs47a3/
	 oVpS3vkD+lZsX71Rzg15PtU48zUBsz/pR6baO56BNO9ejhnmFVYhEx6BnwzKwC8KBx
	 CFspjylsQy+LqUuismMeshZ51eSReNgZBrAesFMjStDsAOIWcRoFI/+XBj3uuMYE4Z
	 T9b1NsEkjS7hA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] bpf: don't emit warnings intended for global subprogs for static subprogs
Date: Fri,  2 Feb 2024 11:05:29 -0800
Message-Id: <20240202190529.2374377-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202190529.2374377-1-andrii@kernel.org>
References: <20240202190529.2374377-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btf_prepare_func_args() was generalized to handle both static and
global subprogs, a few warnings/errors that are meant only for global
subprog cases started to be emitted for static subprogs, where they are
sort of expected and irrelavant.

Stop polutting verifier logs with irrelevant scary-looking messages.

Fixes: e26080d0da87 ("bpf: prepare btf_prepare_func_args() for handling static subprogs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef380e546952..f7725cb6e564 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7122,6 +7122,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
 	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		if (!is_global)
+			return -EINVAL;
 		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\n",
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
@@ -7131,6 +7133,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
 	if (!btf_type_is_int(t) && !btf_is_any_enum(t)) {
+		if (!is_global)
+			return -EINVAL;
 		bpf_log(log,
 			"Global function %s() doesn't return scalar. Only those are supported.\n",
 			tname);
@@ -7251,6 +7255,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].arg_type = ARG_ANYTHING;
 			continue;
 		}
+		if (!is_global)
+			return -EINVAL;
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
 			i, btf_type_str(t), tname);
 		return -EINVAL;
-- 
2.34.1


