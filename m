Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64B519CAC3
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbgDBUH5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 16:07:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50285 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388861AbgDBUH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 16:07:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id t128so4808553wma.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iu/q3zMTB/NGBoImfknpSwtGLLWxG6GnJEB0Nk4jwMU=;
        b=BYi7UK0tgravCN/xlIXTjI2k/wLwNPVZjOA+zXhVyXKBwtlL6koSK/yxy51fQ8NttV
         5mkWj6mrHJ01ZUnrBytPbgXPIzv483auc9jen9PrDxSQg/cDjIAnBcfYG2KVhaptMaJ9
         Q+fOy4/jVwS7BD13/EEfuF9cImBH9CK6bY6Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iu/q3zMTB/NGBoImfknpSwtGLLWxG6GnJEB0Nk4jwMU=;
        b=aVtDZJ4+fTNiYg6H6MpO0zd4G55cmcSr4U0LTeWcApg/CwHLnGkHnEM4eOVp42MeOc
         Ut4LVA+mdmn3/KuMiRXM96Q7L2+zrch0yoQIjDphMfFDRGDn9kcfQGRDqI+0X8j8fFT4
         uzzCRdtisF97n7Wxh32TXxEBlH7zIGI7JAtPwzfDsMkFtVIWOuWH++GKMoE57D8CgUU6
         0caMBeFRC+5K5xQiqERO88kHxqqT3JGPrJc1T6CadPxswykZ46zOBtvFal5L9GN4UtuO
         bV57XCOTV93jl8r0Idcq+dNiSxjqSYUwhbHLWdKRnDuMqosmZ3ePWR3XZepseaZkJaqc
         UGzQ==
X-Gm-Message-State: AGi0PuYTJkiJzawkJvPTGlixErMT/vp5/3y9d4HGkVFpPv7Q9FOBfwQj
        K7307aUeqvhkUexUdIBQf5iBpg==
X-Google-Smtp-Source: APiQypLwXf59H0ELqYQHrCLRAaB3IZpY+8LNTDxn5b36clU3b2wvqLoK0knFNxZUXmAQ/NJ9Q8CxHQ==
X-Received: by 2002:a7b:c083:: with SMTP id r3mr5214243wmh.92.1585858075446;
        Thu, 02 Apr 2020 13:07:55 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q4sm12562641wmj.1.2020.04.02.13.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 13:07:54 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf, lsm: Fix the file_mprotect LSM test.
Date:   Thu,  2 Apr 2020 22:07:51 +0200
Message-Id: <20200402200751.26372-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The test was previously using an mprotect on the heap memory allocated
using malloc and was expecting the allocation to be always using
sbrk(2). This is, however, not always true and in certain conditions
malloc may end up using anonymous mmaps for heap alloctions. This means
that the following condition that is used in the "lsm/file_mprotect"
program is not sufficent to detect all mprotect calls done on heap
memory:

	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
		   vma->vm_end <= vma->vm_mm->brk);

The test is updated to use an mprotect on memory allocated on the stack.
While this would result in the splitting of the vma, this happens only
after the security_file_mprotect hook. So, the condition used in the BPF
program holds true.

Signed-off-by: KP Singh <kpsingh@google.com>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 03e54f100d57 ("bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM")
---
 .../selftests/bpf/prog_tests/test_lsm.c        | 18 +++++++++---------
 tools/testing/selftests/bpf/progs/lsm.c        |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 1e4c258de09d..b17eb2045c1d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -15,7 +15,10 @@
 
 char *CMD_ARGS[] = {"true", NULL};
 
-int heap_mprotect(void)
+#define GET_PAGE_ADDR(ADDR, PAGE_SIZE)					\
+	(char *)(((unsigned long) (ADDR + PAGE_SIZE)) & ~(PAGE_SIZE-1))
+
+int stack_mprotect(void)
 {
 	void *buf;
 	long sz;
@@ -25,12 +28,9 @@ int heap_mprotect(void)
 	if (sz < 0)
 		return sz;
 
-	buf = memalign(sz, 2 * sz);
-	if (buf == NULL)
-		return -ENOMEM;
-
-	ret = mprotect(buf, sz, PROT_READ | PROT_WRITE | PROT_EXEC);
-	free(buf);
+	buf = alloca(sz * 3);
+	ret = mprotect(GET_PAGE_ADDR(buf, sz), sz,
+		       PROT_READ | PROT_WRITE | PROT_EXEC);
 	return ret;
 }
 
@@ -73,8 +73,8 @@ void test_test_lsm(void)
 
 	skel->bss->monitored_pid = getpid();
 
-	err = heap_mprotect();
-	if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
+	err = stack_mprotect();
+	if (CHECK(errno != EPERM, "stack_mprotect", "want err=EPERM, got %d\n",
 		  errno))
 		goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index a4e3c223028d..b4598d4bc4f7 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -23,12 +23,12 @@ int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
 		return ret;
 
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	int is_heap = 0;
+	int is_stack = 0;
 
-	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
-		   vma->vm_end <= vma->vm_mm->brk);
+	is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
+		    vma->vm_end >= vma->vm_mm->start_stack);
 
-	if (is_heap && monitored_pid == pid) {
+	if (is_stack && monitored_pid == pid) {
 		mprotect_count++;
 		ret = -EPERM;
 	}
-- 
2.20.1

