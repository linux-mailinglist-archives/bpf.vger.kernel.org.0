Return-Path: <bpf+bounces-39582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0349749FA
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 07:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D38D1C24E70
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA07346F;
	Wed, 11 Sep 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FohalLzT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4F3BBC5;
	Wed, 11 Sep 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034176; cv=none; b=U/T9VB716D/Y1XcJ+phyDuC3Syvuj2SNhh6HDr2ClcJB01eGZKv8bSXIdZdqevP0OzROs7fcZKgUcnyvs+/t02iNAJWl9Ix7zQlDVO9bgoOKLBVtj8/EQgWd/AQllIYj63+jz4OkE6W9hHb+YMY9JuQn3nMMPP2IvIMhSy4j0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034176; c=relaxed/simple;
	bh=/m2C9bmCWJwO8lq66PrcaCUfrp5s0ny66qmRjoWP9XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNVGALegMpo8/UwwhVJkkCpvvf9dnxDD7tBWq10sbHf7yOWrGfPhXvQVvYksCxwXcYbqlFAsR4ZwQ6sKOUnwxNUERGZmWQVDdwZFCQSKoTk0Juid7i0TCED6DTVdD3hL2GWq/AulexxAkDYj0J8cnig85M7YyHs7dIMOmYsfGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FohalLzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC774C4CEC5;
	Wed, 11 Sep 2024 05:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726034176;
	bh=/m2C9bmCWJwO8lq66PrcaCUfrp5s0ny66qmRjoWP9XQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FohalLzTsi9gTAOeooIS+z5NbDCdaveqjZhPDgo1kDcuNzr/o7Im3/FXjShqe4Cf2
	 wGvbKo7uRw6Io+Sz8cOIx3IGADMzU+degj50J6d/SC11n6C20jQDIsreyCdYAJZaoA
	 oEwZtIS7JSpj4PgR7sn4+/YGL1kQ4hV2CoPnKcPhJ/oW0MiudacRoQD9VvQTLDL5Sh
	 9BbwX5n/HOHAuhho7W27cfg7bHHzCZbsoNJ6Q9LhRN2KyQTtdb6TtcyDgnEbaOU4qG
	 1oONQDFdJBEk5q1ei+WjEM5vYdgzzECya3vmTAE8jSAD+V8sJyrsAfBZ27HwGOyB7b
	 Ff7oSOl76bmiw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>,
	stable@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: [PATCH bpf-next] bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0
Date: Tue, 10 Sep 2024 22:55:08 -0700
Message-ID: <20240911055508.9588-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf task local storage is now using task_struct->bpf_storage, so
bpf_lsm_blob_sizes.lbs_task is no longer needed. Remove it to save some
memory.

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Cc: stable@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 security/bpf/hooks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 57b9ffd53c98..3663aec7bcbd 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -31,7 +31,6 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
-	.lbs_task = sizeof(struct bpf_storage_blob),
 };
 
 DEFINE_LSM(bpf) = {
-- 
2.43.5


