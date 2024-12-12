Return-Path: <bpf+bounces-46688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C139EE0BE
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B2116267B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5720B7F6;
	Thu, 12 Dec 2024 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4JFCXI+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CD2010F2;
	Thu, 12 Dec 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990401; cv=none; b=hiwimtPE+SSkGar1cU1aEjs7d4S1uLkpNL9fWwcK7sOtaq9qhFG9ug0gab0ZXCSBY2mxPsVJzEkob/aCyv5BO9ic06MS1iJ2FGyNI6f/FEgL3NUh47zU7lt4qJ5zQMD2lpaz2v7pr8ooiVfYZH/MI6WHcP994KLoAUrLRDRL4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990401; c=relaxed/simple;
	bh=wqcCObgwvwuBvGZlSNF/mijMawDsoOqIAedNageBYGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUTUzWy0S1zo3eh24XgP5c5feNIWJKSPk+agAofpLtpgDuD25W5TppB1jfsaXKVUwr/lkBZZOo27F+P3MJAntKenOv43Ebw08L4g7W3EY9YWrR3Ky/30arKm8ZypWvPi5MF/tv0iSwRgjCP5rvh8jvfg/x9wenq9Ux9LRQZRDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4JFCXI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268E5C4CECE;
	Thu, 12 Dec 2024 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990400;
	bh=wqcCObgwvwuBvGZlSNF/mijMawDsoOqIAedNageBYGE=;
	h=From:To:Cc:Subject:Date:From;
	b=N4JFCXI+2uk+yGh8yCwsJNIopzUKNHNuIxLzmr3Go1WhwipuJ2fIdXQ1PFr85C708
	 NXV1yzPoV82LozFDHh3Dx79T5v/ZlqhOGk/5aEVgvkuXK+flm7LFSli7mF+FF1IBh/
	 QX8NMJDujwTWaCAK5mk48LoKW1y3YtbKS/KNBY0jF3l7s62Kbi02A0XLV3p8/5cm1O
	 pgLhoFeHVnT/MqJ1OSckKOv7+1r7YPVpJv9/g9fg5mpux6pe1fAxX5EhNIRRavvDHn
	 bPsDfDv1bPLCi3rqqRLVsaqIWlmbxFCPMRLkKAW8RL9sDP5+pvGd7vYTQYCwOItppN
	 /1iGU9HxkMCqA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] bpf: lsm: Remove hook to bpf_task_storage_free
Date: Wed, 11 Dec 2024 23:59:56 -0800
Message-ID: <20241212075956.2614894-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_task() already calls bpf_task_storage_free(). It is not necessary
to call it again on security_task_free(). Remove the hook.

Signed-off-by: Song Liu <song@kernel.org>

---

This was initially sent in a patchset [1]. However, this patch is not
closely related to other patches in the set, so sending it alone.

[1] https://lore.kernel.org/bpf/20241112083700.356299-1-song@kernel.org/
---
 security/bpf/hooks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 3663aec7bcbd..db759025abe1 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -13,7 +13,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
-	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
 static const struct lsm_id bpf_lsmid = {
-- 
2.43.5


