Return-Path: <bpf+bounces-69036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB1EB8BB87
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A45A5C56
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34868219A86;
	Sat, 20 Sep 2025 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTF5G5EK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2F212556;
	Sat, 20 Sep 2025 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329976; cv=none; b=D4g2ei0IW+/7UavBx2/DXaswiVh6p4a4FYo6txQNqPUjPGMZenwF/Tv1JOYxX3+yiq7QJ2sElnUCil4oQuLiR8+YlM7myY1gyJpTxC/74QQJ4v/W0LXTGlaBayI5TNlQgNddF4h3ZeK5UUqlEh1Fej+0BaTiszCm3lCSx4DpiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329976; c=relaxed/simple;
	bh=VHLLYGUKKLWWYFzSTAhsDh5Dm2/CPftRfbREaFPtaBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajgxzJ5uTbqZNbengaZo3axxjZPZpKB59sXQB7E3ECKzpGbpeMLG0GTSzq4ikyXVR330sXe4GjK6qOpUxf0f8osuoJDs2OtkZHHjB/PfoDgxTuTi8GS5yIia9c5H6Y8ewLJmt++6G7/woV30M9xRUYVrfziewI+BSRD5MESDpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTF5G5EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DBDC4CEF9;
	Sat, 20 Sep 2025 00:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329976;
	bh=VHLLYGUKKLWWYFzSTAhsDh5Dm2/CPftRfbREaFPtaBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTF5G5EKyWcEb7EB6SdCvrIpcnnt2Ze8zJt+QSRv6xgAbs8CXIWIT2uDR7GTcnnGH
	 Iag1ktANkU8ldlddJv0CwBeQmEykQ/NaEsaF89Nz2a63VUWjLTowOrFijpJ9hM2Ler
	 N/r/8HmcnhN/jz8zPUZFty9P8QOFbGmLlEazUkEregxGsi74I9rBwl4PlIOvX/bq+0
	 CTZm6deRdkD/KA3xTyLNGkKjIXmxJsYplGT90abxYOKjpcJfHbqTgSkaBu/B7A9vz4
	 Uk73KMERSSzDlBw/mI01CrOEa2PKdWNLmpEY3ht8PflFWtHkEOwPDnYyaW5X5I9tWf
	 9OcsfcECj470w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/46] sched_ext: Improve SCX_KF_DISPATCH comment
Date: Fri, 19 Sep 2025 14:58:25 -1000
Message-ID: <20250920005931.2753828-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for SCX_KF_DISPATCH was incomplete and didn't explain that
ops.dispatch() may temporarily release the rq lock, allowing ENQUEUE and
SELECT_CPU operations to be nested inside DISPATCH contexts.

Update the comment to clarify this nesting behavior and provide better
context for when these operations can occur within dispatch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7047101dbf58..d82b7a9b0658 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -108,7 +108,11 @@ enum scx_kf_mask {
 	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
 	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
 	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
-	/* ops.dequeue (in REST) may be nested inside DISPATCH */
+	/*
+	 * ops.dispatch() may release rq lock temporarily and thus ENQUEUE and
+	 * SELECT_CPU may be nested inside. ops.dequeue (in REST) may also be
+	 * nested inside DISPATCH.
+	 */
 	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
 	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
 	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
-- 
2.51.0


