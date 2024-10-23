Return-Path: <bpf+bounces-42900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7909ACD54
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B91280EF5
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9D217328;
	Wed, 23 Oct 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr/6bCqx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66058217317;
	Wed, 23 Oct 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693996; cv=none; b=lQdViKpLoF4aiJ53fM6MZ3KOCQPi8HVGv79jeNsKsWHqYFMqFZIHVj5dPbdNcsNr8W3M0n/nS4Dl3y4Vin8dilNdDQBdUASOqaWTEwj+zLGDCziUTLERkxKLGILx1FtESPyC6n+I4nMfnKtnkjiwuF4j5VpuD5KxAFUSMKt2vtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693996; c=relaxed/simple;
	bh=w+760G7ArMMkbTlp5iu93gpeU6Zl4mQ0dS6uBeXXMtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhBYK1rIggO9yvw87k640l5sDXnc6kWRByWLqGUqQe0GvO91PH35hkUbY3E0beVFirEvBBmiqdNSMkjDmBLDbx1bZ6Z2x6SQkNOHZtp+FGWzIqrsC9aYVbW8HlN/exDJu02UtILbTXhBCPDT1XbddiqV00ImeNYSJoLrMv1w0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr/6bCqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BC4C4CEE4;
	Wed, 23 Oct 2024 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693996;
	bh=w+760G7ArMMkbTlp5iu93gpeU6Zl4mQ0dS6uBeXXMtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dr/6bCqxb/8uTpSFEisALSX69xC7MYSBn8WZta0kOxb58WQeUip4Lr/lKOquYz6mv
	 dy3bxFnsC1xRgVUTekeVckhnIeK4RS+YaZH2b/GPSXcGJhyaX2O3IFG8rCB2JchUmu
	 l+hblwgERDb6Venu0qjBFYij4E7cMtBttoS3cdhrEbTdTX8MtFoi4ZozuLFbyduUvZ
	 fPqrehOOWpB0qV8Oh3TGI2jEqnRYtVdTIP0kVVin+Gnuz7RUiuamfI2F/C8/75Dggk
	 O7ORQkyTT9jaiI/2i18mLepc93Pjbs4rxgk3XPIO64206aQPN3D9OAqGO6as2aXu6s
	 KFKtc5h56qLUw==
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
Subject: [PATCH AUTOSEL 5.4 3/5] bpf: use kvzmalloc to allocate BPF verifier environment
Date: Wed, 23 Oct 2024 10:33:06 -0400
Message-ID: <20241023143310.2982725-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143310.2982725-1-sashal@kernel.org>
References: <20241023143310.2982725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 0901911b42b56..013b9062c47c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9558,7 +9558,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 	log = &env->log;
@@ -9728,6 +9728,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
-- 
2.43.0


