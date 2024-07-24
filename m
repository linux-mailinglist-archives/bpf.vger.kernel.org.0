Return-Path: <bpf+bounces-35571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2993B94B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3677286580
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947F13D635;
	Wed, 24 Jul 2024 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esih5uxC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B213C9D3
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861547; cv=none; b=eR1l+f4uDiWRV4FPWrnue9qhEV/kLmC9yV/9HAvEscaT0DxtZuD9qNso5ccLcovTx0pUNCxIMAiwKUROQBuZTgo/4JlPK2hAJfwGFpedZR8b+TKVl826uvMyiDW1EeraTE74v0Uao6MognjqpR4L67jFRs6vuepBPX5uEIsWDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861547; c=relaxed/simple;
	bh=ttN3FJZUIXMIoxb3+/1Zwk+6ong/Mn3pgESyR8mPPTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IG0ZedqHJXvUZvbtKaufhZsyhy74um6fDKwiz0pMWs7Yhucw9cI4bl+Io+wj9mHRk8DJCtUalT6v0mLKWuFpWAfOlqzmGmAkvZ9ChidjmE6MTJuzdicie6+n+mqqwxL1ZZlL4r54t3MaAzaW13mfXQcl2eGtz+nWQ7geU1CW1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esih5uxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4159C4AF0F;
	Wed, 24 Jul 2024 22:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861547;
	bh=ttN3FJZUIXMIoxb3+/1Zwk+6ong/Mn3pgESyR8mPPTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esih5uxCybKcEIXW7Uqc3DL51opICdz6HHVG1J6Vfx7wCI6BfOD481/t5nwtlbRzT
	 k/279fhp3fHxpaIW4ahunTN3A2seclhLFmwJeHSW1g8bOO5bBn7LJ94p1JR2vJMjHR
	 ujSSDoyFVwY39DftebQIdmhqOzqe1JpOyu++tQ+yAXxtX2r7SZFFyJH1anQ0eaVCQ/
	 vhwIvddChY20RKQ9hqKhkNff6xiHNvln9C0KjhbP43WBOvnVRQ2SqikP0Mrum8EZ1X
	 Ilqv1G+KJH8MHKwPSUEdmdEZjTZoCjRAgiT8evGe0tQp0c7BTXqpV/R4SzCScYyJkB
	 msrEBspoAclmw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 04/10] lib/buildid: rename build_id_parse() into build_id_parse_nofault()
Date: Wed, 24 Jul 2024 15:52:04 -0700
Message-ID: <20240724225210.545423-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724225210.545423-1-andrii@kernel.org>
References: <20240724225210.545423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it clear that build_id_parse() assumes that it can take no page
fault by renaming it and current few users to build_id_parse_nofault().

Also add build_id_parse() stub, which will be implemented in subsequent
patches, just to preserve succesful kernel compilation if another
upcoming user of build_id_parse() (PROCMAP_QUERY ioctl() for
/proc/<pid>/maps, see [0]) gets merged with bpf-next tree.

That ioctl() users of build_id_parse() doesn't have no-page-fault
restriction, so it will automatically benefit from sleepable
implementation.

  [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-4-andrii@kernel.org/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/buildid.h |  4 ++--
 kernel/bpf/stackmap.c   |  2 +-
 kernel/events/core.c    |  2 +-
 lib/buildid.c           | 24 +++++++++++++++++++++---
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 20aa3c2d89f7..014a88c41073 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -7,8 +7,8 @@
 #define BUILD_ID_SIZE_MAX 20
 
 struct vm_area_struct;
-int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
-		   __u32 *size);
+int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
+int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index c99f8e5234ac..770ae8e88016 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -156,7 +156,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			goto build_id_valid;
 		}
 		vma = find_vma(current->mm, ips[i]);
-		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
+		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ab6c4c942f79..c2079e25f211 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8850,7 +8850,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
 	if (atomic_read(&nr_build_id_events))
-		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
diff --git a/lib/buildid.c b/lib/buildid.c
index 49fcb9a549bf..5f898fee43d7 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -276,10 +276,12 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
  *
- * Return: 0 on success, -EINVAL otherwise
+ * Assumes no page fault can be taken, so if relevant portions of ELF file are
+ * not already paged in, fetching of build ID fails.
+ *
+ * Return: 0 on success; negative error, otherwise
  */
-int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
-		   __u32 *size)
+int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
 	const Elf32_Ehdr *ehdr;
 	struct freader r;
@@ -318,6 +320,22 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	return ret;
 }
 
+/*
+ * Parse build ID of ELF file mapped to VMA
+ * @vma:      vma object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Assumes faultable context and can cause page faults to bring in file data
+ * into page cache.
+ *
+ * Return: 0 on success; negative error, otherwise
+ */
+int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  * build_id_parse_buf - Get build ID from a buffer
  * @buf:      ELF note section(s) to parse
-- 
2.43.0


