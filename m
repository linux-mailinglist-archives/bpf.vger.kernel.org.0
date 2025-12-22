Return-Path: <bpf+bounces-77292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91927CD62A3
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 14:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3C9302F801
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE12D46C8;
	Mon, 22 Dec 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfjylhN4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796D2C21EA
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410396; cv=none; b=FOX9wpbPKw0Tx5ZKRkllPX8Gc/E5uUOZVswqBr/tX+bs2MOPHqCIKqkyF0bpG/Qr3Kg1TTvLu/GKKqM1ZxXG2CbFb8cwBUk/kfhMVzqpd1BMDU/l4k+XcuFm+xQi4iGBIJNr7AcR7NQ2WcVzKT2DceI9wumIduMdutT4453/FkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410396; c=relaxed/simple;
	bh=wukZ/dBkaUTZvR16MA9qazIAS8XTVz1eg6VQ3EqiEnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKLAe49lRIwJNrtODvr9uYRTjTMemVMrBuSZbzDpgKcMZjdIbLsbKbV39vtOwJFmEwA6bGbpuwHwgRRr8zQzppqkb/QWzcCKVIDw7al4mrt3uwOC3Q1sYGO/96oPjgcWEAVfIk/6nIWKrqJcNyHajdfbZP5JFvPwP2WmKpBMxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfjylhN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842EFC4CEF1;
	Mon, 22 Dec 2025 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766410395;
	bh=wukZ/dBkaUTZvR16MA9qazIAS8XTVz1eg6VQ3EqiEnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfjylhN4DDlUPKT0F78/vYPwpOjjAveCEM0y44lLmKhOh9XR36lKdx9p4erRdQhV1
	 DNqwJuNhcCuJmBjPPDnm/CECOpfRRPWFQkqsPrxw3q+u27IeMBJjbrAPdLallvIbAz
	 Yaot3ee6Ua/ZdxvafJqrRUswY8ypd1R2V11sD5gHz4hyZ6acYS1YkjO/Cpf7yGY04b
	 F964f6fieLDxnOcRMsCOi3tDGjpyi2ssCMxkn0Z9chWp9H0IOTy/CWYI1RBQfOY6pb
	 9eUr2HDiF/LBPxkJi9PHg7gwZku8+TLuCsieVG5P6GK72dPYYuSudHPa9vbDaRa4Ny
	 SSrkBP8ewxJBg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: allow calling kfuncs from raw_tp programs
Date: Mon, 22 Dec 2025 05:32:45 -0800
Message-ID: <20251222133250.1890587-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251222133250.1890587-1-puranjay@kernel.org>
References: <20251222133250.1890587-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Associate raw tracepoint program type with the kfunc tracing hook. This
allows calling kfuncs from raw_tp programs.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..539c9fdea41d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8681,6 +8681,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
-- 
2.47.3


