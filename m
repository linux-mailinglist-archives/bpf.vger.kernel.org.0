Return-Path: <bpf+bounces-42901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7B9ACD65
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E981F25237
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E940218594;
	Wed, 23 Oct 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeFd2p4R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DE218339;
	Wed, 23 Oct 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694007; cv=none; b=kjZoY463+QQ/CmdSn1xbUFJjn8qLxZIJgvdxodI33CgxfpUplgo3sgUk/G9Eyp+x/zihHcIDuEBFxwT3IyunzkHKKNcGhRxtuhpd4YQ6c1kO9Yc2RmLqrbMRajN5Ac7/Xv2TORKEHV0msXA8D2NDXYI2KfvAmEGOYAO93m2CVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694007; c=relaxed/simple;
	bh=ehKCRv5eADkou1azTYF5vkSU2N2nnR4vZ3u/U0CdpgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAbJlx/KssApTXDsWrCFMSiUVVYKqVvnKUBxZIMvK/Xf59CYGb/vnMc8jLc//8r8m/3oXhSmiI2ah4/g/Wjs7YMlq6x7OSpFm3//TqGYH5Y+5F469vDj9rzYSxp3utdte/9T09QrqlXR+GPCD/0yqiZE6+ZNc97LsbuYSu1nTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeFd2p4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B082C4CECD;
	Wed, 23 Oct 2024 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694007;
	bh=ehKCRv5eADkou1azTYF5vkSU2N2nnR4vZ3u/U0CdpgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeFd2p4RhRlN8zkAxm7eEhzIUvJ6LfW6oYhKI2w/nKF5nw48s3/yKazdqRQcUFw8R
	 Opb/Ln4ElOGkL5LuNCIQSBAqHfPaAzVuW6PM7/Ccvd5TainWOUkuYrbRFL7kMuEukX
	 ZTowY9YLrH0yIYxFjuIsaEFo+rVohEdG3NWTLC18vRQSX9vTAknAOKCy7OwCw2LOm4
	 EToc+H+iMQIfLXfqP0CANGIuVRwtgMYRIIZYlieG9V4px9B3qZersyzyYtyyABLlqb
	 GuPg6qIyeJfZ3NmtCHplhZab0ELqTv28yKqakl44QjoJvfQpvQBm4IcexXL9Ocx+Aw
	 Cxa7F0gx67xrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/5] bpf: use kvzmalloc to allocate BPF verifier environment
Date: Wed, 23 Oct 2024 10:33:18 -0400
Message-ID: <20241023143321.2982841-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143321.2982841-1-sashal@kernel.org>
References: <20241023143321.2982841-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

[ Upstream commit 434247637c66e1be2bc71a9987d4c3f0d8672387 ]

The kzmalloc call in bpf_check can fail when memory is very fragmented,
which in turn can lead to an OOM kill.

Use kvzmalloc to fall back to vmalloc when memory is too fragmented to
allocate an order 3 sized bpf verifier environment.

Admittedly this is not a very common case, and only happens on systems
where memory has already been squeezed close to the limit, but this does
not seem like much of a hot path, and it's a simple enough fix.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Link: https://lore.kernel.org/r/20241008170735.16766766@imladris.surriel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a48de55f5630e..de0926cff8352 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6446,7 +6446,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr)
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 	log = &env->log;
@@ -6573,6 +6573,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr)
 	mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
-- 
2.43.0


