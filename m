Return-Path: <bpf+bounces-40722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6F498C868
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 00:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17882B22796
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CFD1CF7AB;
	Tue,  1 Oct 2024 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpHdhX2M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902D1CF5FE;
	Tue,  1 Oct 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823145; cv=none; b=T15Jjza1kzE2iIhW1rgFyJhDsNxgWvoRaH2C1hd4wbNWvT5qu/Kh9IG+ew4uQYn5JP7+eEZaNUwYpHyntlcoGgaFYPIEdUIQTuaLrFxWx/17VtVGNCHBMhfag0r0Mek4URR0Fd7t/feyzKRTIY76p3+Rx8as29yizKQp5nsr+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823145; c=relaxed/simple;
	bh=Fe0W0B2s6ceCb71LS5xDyOWx4mAiBCLoZvDtud5NppM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTYqxHOMkGj5C5o4JIvvWEpHaSDr6M4L7CQu0xoMXLf1rjJW2kMd0iAfNxY8SD5YdabnNQs+ixmQC4LcR+kYQ1hvOizke9zQ1ry4l8KOmD7OKgqYW8NKgRjdAt+flodBjZaYVp4CCxmjtIrkARBkgElLdreRuRE76uegWWU99o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpHdhX2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4533DC4CEC6;
	Tue,  1 Oct 2024 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823145;
	bh=Fe0W0B2s6ceCb71LS5xDyOWx4mAiBCLoZvDtud5NppM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpHdhX2My8bEMExNjtkiCBGzgD/icJoKKBqYiIrUbPzCTfYszjoLtbMmq1dssYj3T
	 Vrwe8b43Ff5XJWhkflBzoIkA4mbw1tW1bc+gdwJ5gHBcaUuGvSIZVtObiyY9gzB6fL
	 279sn7GDirJgGJM+LjoW+rAaFbP+0qgSw780RGYXJSzkxUeqFy2lbgEVIGwSB2x2EA
	 yVmzNitaw7bjQ8Gxrp5it9ifxi0NkWH3rkKE5gjhUNhD8GF3nt6umR84JDzYdOvj6S
	 032wn+XUSq9IQVRDNOwPE/ysqQ+e7s8s7xRGN/F99dVabaYTJU5jAaQ7kjjhMvZGTm
	 9/45fjGcrlZ7g==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	mingo@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 tip/perf/core 3/5] fs: add back RCU-delayed freeing of FMODE_BACKING file
Date: Tue,  1 Oct 2024 15:52:05 -0700
Message-ID: <20241001225207.2215639-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241001225207.2215639-1-andrii@kernel.org>
References: <20241001225207.2215639-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6cf41fcfe099 ("backing file: free directly") switched FMODE_BACKING
files to direct freeing as back then there were no use cases requiring
RCU protected access to such files.

Now, with speculative lockless VMA-to-uprobe lookup logic, we do need to
have a guarantee that struct file memory is not going to be freed from
under us during speculative check. So add back RCU-delayed freeing
logic.

We use headless kfree_rcu_mightsleep() variant, as file_free() is only
called for FMODE_BACKING files in might_sleep() context.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index ca7843dde56d..257691d358ee 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -68,7 +68,7 @@ static inline void file_free(struct file *f)
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
 		path_put(backing_file_user_path(f));
-		kfree(backing_file(f));
+		kfree_rcu_mightsleep(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
-- 
2.43.5


