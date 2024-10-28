Return-Path: <bpf+bounces-43262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1F9B21D4
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677691C20E61
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FD1547CA;
	Mon, 28 Oct 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3D7Ov04"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89FB13774D;
	Mon, 28 Oct 2024 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077753; cv=none; b=bvucaNJmB2DFwThLuZCbHeF9IsFDiGN9QCNR5wdyd0AvQblTWGN908XS+/sQ+gHDR4gSSvbe6XtpndMuC/dJmSb1AWv9Eer6wzXlSUtRWHIQiAPfw1yXJJVqY348Wab3KqSstGbEINxnHMVNv9ycl8UkwvXJal38aUp2f3akOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077753; c=relaxed/simple;
	bh=hDtDfS8JqT/fLQMiv3m8WVup/RU6yhW70oJ6haQb60E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfR8wtMidNFkCXcS1vvuUYd/FzfTR2JZ6IwjEmy2CV0/j36PE/lSMBQMzsrvFPQwW8ncsH/Fp0yrLtLijchYZBaqdwBGi9krAApU+x33lHlKukdK1TJphBhDKqqaTiyPZtS2BE/26KnbHzCuZfPRE5Lc1WpU4gKQup16NGNy8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3D7Ov04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E76EC4CEE5;
	Mon, 28 Oct 2024 01:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730077752;
	bh=hDtDfS8JqT/fLQMiv3m8WVup/RU6yhW70oJ6haQb60E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3D7Ov04DpaTyYJl+4SfPWoXLMI5EldjfTRT6VKHmSxekQRYCT+7e+vroidwAIM/y
	 c9UyoWB0yeHAQH9wTW7L78nHqBKgCt8ub4xAaiUUNjh1wTF2ra5CO9zN6Y1+ZM9WXu
	 XyH8q6zDh3Q2i8O3Z0GTJGneeTd+hwvD+2koWe7Tt+V5W6IjIOahBvgr/w8QyRKLZX
	 zh3XZeFvlXwBaoY/ZbL/16DKFuEy1Pqn1S42YcpEXwRg9wU7Db45SReuz3aoSXoDcX
	 pYqPLyrc4kC79COC4fnmbguofXh/ZDGrmKdLWt0rsIyDhYk4VXtGueWWod/9Y+SFIn
	 07MKzAQ58jXyA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	peterz@infradead.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	arnd@arndb.de,
	richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk,
	hca@linux.ibm.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 tip/perf/core 2/4] mm: Introduce mmap_lock_speculation_{begin|end}
Date: Sun, 27 Oct 2024 18:08:16 -0700
Message-ID: <20241028010818.2487581-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241028010818.2487581-1-andrii@kernel.org>
References: <20241028010818.2487581-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suren Baghdasaryan <surenb@google.com>

Add helper functions to speculatively perform operations without
read-locking mmap_lock, expecting that mmap_lock will not be
write-locked and mm is not modified from under us.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/mmap_lock.h | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 6b3272686860..58dde2e35f7e 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
 	seqcount_init(&mm->mm_lock_seq);
@@ -86,11 +87,35 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
 	do_raw_write_seqcount_end(&mm->mm_lock_seq);
 }
 
-#else
+static inline bool mmap_lock_speculation_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	*seq = raw_read_seqcount(&mm->mm_lock_seq);
+	/* Allow speculation if mmap_lock is not write-locked */
+	return (*seq & 1) == 0;
+}
+
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, unsigned int seq)
+{
+	return !do_read_seqcount_retry(&mm->mm_lock_seq, seq);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
-#endif
+
+static inline bool mmap_lock_speculation_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	return false;
+}
+
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, unsigned int seq)
+{
+	return false;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
-- 
2.43.5


