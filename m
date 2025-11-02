Return-Path: <bpf+bounces-73254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE1C28E36
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 12:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EDA3B1782
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29EA2D8DCF;
	Sun,  2 Nov 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN7z943z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA0270551
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083471; cv=none; b=Xg7sIHx574PSZns0G8K+ZIaPKvgDqhHWGAhnrSbGYPiMQXzAAB0p3ydQ/BZTOIKdI8w5+uLo5mj0NSbFni+BpLLO3SpNWlL3S4d2eyoPo9ZDeq6VAgJ4jf8d5yyMej8VAjKUIQK3R0plLekEdMaItuBpT4TRiE4fB6Mqa+TXV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083471; c=relaxed/simple;
	bh=bTxFJO9yoVX7Uq03Ks7P+vpbNJ7Mnn7qkT+vSkfPxpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r622L1OPQ6LbQPpvzgGrwjBZjAjl+hI19nRMMLUE5WcxKn5grNcF1ZMviIoimxGIShtpLgffb/cp8o+9kvq4TRrUY43p79lZ9SHIDfs1Iq/DM3usaDYnu0YPLXp9wonoNXWMWTsWAaS/0P1zmGJjtiKCQL1AJp7VEAOVZU07AGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN7z943z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98258C4CEF7;
	Sun,  2 Nov 2025 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083470;
	bh=bTxFJO9yoVX7Uq03Ks7P+vpbNJ7Mnn7qkT+vSkfPxpo=;
	h=From:To:Cc:Subject:Date:From;
	b=KN7z943z9tRf+fI8f3+1mF0n8imgg0cy/Rcjd0CgtFu+f+UR4i5rcZvQcAOrwN9V6
	 QGTp3/ujH7fyq81/ruJOly3laFGmKmF+Ub9k1KZlyByOUCgsinviHe7quz8aeeVC1A
	 iB1O16hL+XzvvcsZNHyMW0ycV9ZIdCPXOqoF1M9i9WuLLVgYKoutl1WpUuttwvbr/N
	 pnVc8N2XmRCnJmoTNdDQmMV6F8vLHfs/mtuiPUaec6PjuTZ9/kCS/dJ0AoBpdwwAA7
	 x6orZ1oYLXTFqs0XF5AiMIEopkcuRp12rjh3fwGppxGBUVgQcgVgqt99KGg+m0+LKx
	 ZpGcP8PAQMa6w==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	clm@meta.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf] bpf: Check size of the signature buffer
Date: Sun,  2 Nov 2025 12:37:42 +0100
Message-ID: <20251102113742.34908-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept only a SHA256 sized buffer.

Fixes: 349271568303 ("bpf: Implement signature verification for BPF programs")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..cc5bce20ec86 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2826,6 +2826,9 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 	void *sig;
 	int err = 0;
 
+	if (attr->signature_size != SHA256_DIGEST_SIZE)
+		return -EINVAL;
+
 	if (system_keyring_id_check(attr->keyring_id) == 0)
 		key = bpf_lookup_system_key(attr->keyring_id);
 	else
-- 
2.43.0


