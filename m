Return-Path: <bpf+bounces-30128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846C48CB23D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D5E1C2180A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09A147C9D;
	Tue, 21 May 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6oeK1Uw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67A147C85
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309251; cv=none; b=WjtK/PMKy+5bGl8rsnK6eX+Abe1tXmWWaq+LVx9gjlX4f8FVR+KkKPlXJkWD44z2f5UkAiqcwZcA8JS3miW5ZJGOtW9CAwH3P8N4gUtt9gxGJP0tcE5hW8SVAGBLcOqFjPXZJJr5ENkt0xC5GEgH5tSHVD3NCMY5PXHeggxJ2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309251; c=relaxed/simple;
	bh=/M2O7Cyt5OcFCAFni7ZaMrpNoZe+Pp4LTjLqo8ViL/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZlHfNQAXu5REJoPB6YP0oICcCh0NQpnsRdV6pFIXakom9DPqpoPC5hRpshA95xGqms22ogRf3z16I43X18jK1hQNiGnDxW4sBpJy0Y1ILjG0Zy3aIEGRmsf3bOXMBSFsu35k7PO0mjDdFe9iEfSr4vxbY8H3DJ6tQz0IlJmCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6oeK1Uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E674DC4AF0C;
	Tue, 21 May 2024 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309251;
	bh=/M2O7Cyt5OcFCAFni7ZaMrpNoZe+Pp4LTjLqo8ViL/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6oeK1Uwxe7Tc/tG/YTiCzvnvsoFzza0ofo3ZcgzOCujDlsay4N1E3NT5xzAIiwXA
	 gsYAieaErx5vcrO0t9qX8tlxHwM+EeVMFoEFVydh5iOYumVUsQKlBSk5YqaoxhvdNA
	 TcsXYzsNPrDX0RaIRy/Af53MkojEY92R6YHJYTWjj8ed4loM4IZsiA6HZxSyffGaIj
	 v7YgNFaxsytcqyIo9XaBmq3Xm0EtxO4PROFEVZkfir8O/8TCRbbP0mbsRXfNLVVlbO
	 QHs7pTQMIPchU3TYWNMvb+IjQchRdAti4WkSDKK13hCrZ2Agcc75MetUuXpe5yiM5N
	 aT6it7LeTqH6A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf 2/5] bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic
Date: Tue, 21 May 2024 09:33:58 -0700
Message-ID: <20240521163401.3005045-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521163401.3005045-1-andrii@kernel.org>
References: <20240521163401.3005045-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_pid_task() internally already calls rcu_read_lock() and
rcu_read_unlock(), so there is no point to do this one extra time.

This is a drive-by improvement and has no correctness implications.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1baaeb9ca205..6249dac61701 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3423,9 +3423,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	if (pid) {
-		rcu_read_lock();
 		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);
-		rcu_read_unlock();
 		if (!task) {
 			err = -ESRCH;
 			goto error_path_put;
-- 
2.43.0


