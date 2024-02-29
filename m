Return-Path: <bpf+bounces-23079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63B686D46C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 21:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D561C21632
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71614BF5E;
	Thu, 29 Feb 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLRkOdYw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A014BF4B;
	Thu, 29 Feb 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239061; cv=none; b=L4YKbrRer2VoYo5A0yze8I9I8VzpiCqKed3QeqPMewxuMUo7cHSihQNRPK9y8pPAmNcqhSMSVwjncS8ax1HyUlCYRswqsgSI0bMoUd5zijumMp87iD2qWIOfoArOMMoDMYJMQGhIH0LgxH53inbKCCn4NFm8mv1x3dZz2d4wLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239061; c=relaxed/simple;
	bh=wGyL3labdAaMqFXA7KDslyStajtYj3CnrLy8cwVV/Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy2IZ72+81ybBv2BAnFimnPcDhNF4lLqhzErOPzIyefiHx2XsmxwGdQI/W9iTvB9u4KuT94nni6vMPsNRbjL0k8e9+fY88bpJF4liAr+V42QvfJf1zB1pOwl7OBttI0fdd7jloXreFOFOrLf2A//jf4sonVYDjXqXdHiZ3i69Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLRkOdYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659EBC433C7;
	Thu, 29 Feb 2024 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239060;
	bh=wGyL3labdAaMqFXA7KDslyStajtYj3CnrLy8cwVV/Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLRkOdYwd99IswaI8cLLXX04lL8fp6oxOx+EnjK3+CgLuCIznA+NUqLwu0A3f//oB
	 DjYNqVNXlawVf8UhsALFwtX3pTRnuqWUM/Fkp4F8YW0n/UjfOVF3b992gNjRPOYs/l
	 OCAvWw0pGx1E+9KTLwLrlxitf2RHO4O4UEbVKX8Sbv2A1QhiagtbZVgi9O8yayyVxh
	 gG+TrpWLtzvRk6EVioavy3BIcw/S2FobwQrIEsE3YFoTf65MgXFSPIyHvP0d+3iH8R
	 50R6MCjWbxHaKZ1x3qa6mB4JymV2BB/wEIxXoO6a1mxG6rk4g5ciARmNsP0Hao7r0B
	 AZJyMd2OcT7og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	David Vernet <void@manifault.com>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 06/24] bpf: Fix warning for bpf_cpumask in verifier
Date: Thu, 29 Feb 2024 15:36:46 -0500
Message-ID: <20240229203729.2860356-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Hari Bathini <hbathini@linux.ibm.com>

[ Upstream commit 11f522256e9043b0fcd2f994278645d3e201d20c ]

Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
warning:

  "WARN: resolve_btfids: unresolved symbol bpf_cpumask"

Fix it by adding the appropriate #ifdef.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: David Vernet <void@manifault.com>
Link: https://lore.kernel.org/bpf/20240208100115.602172-1-hbathini@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e215413c79a52..571642c149e2f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5445,7 +5445,9 @@ BTF_ID(struct, prog_test_ref_kfunc)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 #endif
+#ifdef CONFIG_BPF_JIT
 BTF_ID(struct, bpf_cpumask)
+#endif
 BTF_ID(struct, task_struct)
 BTF_SET_END(rcu_protected_types)
 
-- 
2.43.0


