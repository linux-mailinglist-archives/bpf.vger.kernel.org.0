Return-Path: <bpf+bounces-34291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A84692C4EB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA351C22297
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CED818562D;
	Tue,  9 Jul 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzRoCXxx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6EA144313
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557785; cv=none; b=OJRXXqOf2itXQY8jzvsjUJhlVHZx8xCgR1mOAz/uuPxS5bAaIU/TgxFaGk/3YsVBZJKkDvmYVVI2fFW7Tv8pTo/2/izXzENiyC2rLumTEsXoKfjj8QqGjoTaTsfIJ9jozv5FhmB6UCJpQw/OMLSyQK5CWdhJOJjO61KmhXZ8nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557785; c=relaxed/simple;
	bh=O2hhW1KJHjeOM5cr1mZFJ2v06umN6X8sTn4Mje/nOWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpc3QH1u+Xz78hjCqkXprYysgJo5gaDHYnJNYNO3HG4J6CTXtZPD+1OAik/tcv1MefGdsBFy16LqouUEB63RSSYhGaxDc7hLparm+hNrGGKRh81mPAt+7Wmdd9IeeBFW6VUqb9PgKFG6QwJhmEg8irwcpF3BNao+TJ/QmtXLCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzRoCXxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF29C3277B;
	Tue,  9 Jul 2024 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557785;
	bh=O2hhW1KJHjeOM5cr1mZFJ2v06umN6X8sTn4Mje/nOWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzRoCXxxIgU97mgevxSLXRSjJt9eMODm+Xww5DbcnEGGQb32oZygpM+kn7rhk4036
	 WuHSWR525O8aBUt5+VMpo3Ni89DmSrXi6fKqVw7uh0w6q7fp3VlwcDIF1mB+UX5UeW
	 0bdX/feM9uiT/gwRPw58Qb7ZWDQ7pRNzMnPN5BLuk7yq+XedvT4gLFi9XYr880NrBP
	 5mBRcVGdTORwmTEVA2RaWrs7kU6BFQzbzzCjtipMDM3Tb1gKz+99bKMX88AwrPtPgZ
	 bkz73VsSUIbG6us1H1nhwB6z4u1q+yUYcbQ1OIurD950oqwmcFK5gepPRV/og6CODx
	 uBHAedRYltlIA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 04/10] lib/buildid: rename build_id_parse() into build_id_parse_nofault()
Date: Tue,  9 Jul 2024 13:42:39 -0700
Message-ID: <20240709204245.3847811-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709204245.3847811-1-andrii@kernel.org>
References: <20240709204245.3847811-1-andrii@kernel.org>
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
index f0128c5ff278..e3927b688699 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8812,7 +8812,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
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


