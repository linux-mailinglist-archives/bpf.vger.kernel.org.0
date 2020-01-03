Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD88212FF41
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2020 00:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgACXrT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jan 2020 18:47:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40003 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgACXrQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jan 2020 18:47:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so9933503wmi.5
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2020 15:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqpA7+IQg8wmtI5+/njoQrdK03zJ9XpJ8M9GpWAhFPk=;
        b=SSe8Boj9RRGI3BiJ+6SLOcjxHe8xsZyytqj19N8JTEqg14ts0P2ZcvhEl3Q0GrGUuq
         XjfL0eFLqlalIt2vXNcK38SVfF7btM6Jx/SumoH3F87p0SQ+WQxMjeIvHW3bEwosjzPm
         vOYFZR2wIUQKBHPhiHj5k5OvBfvYDDvvxCclo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqpA7+IQg8wmtI5+/njoQrdK03zJ9XpJ8M9GpWAhFPk=;
        b=ahBqSlQC2qECeqSnvitAFfaxwpvJGugBwqwX/AmiS2HxlQD4htwCqywlZNIUj8Wk9z
         O9IGiEDj159JKKMtV35XrTSz43N/4dHaSfn6d3nbLJQ3LRiJuMo4dStpC3Yoeme1Clni
         nNzusQKvmrZB4veLVviliuPDiBHBAL6jeZbpwAsvQTWCZWkSAoCyuqQF9tm66Uv2XcLc
         bW30KiaOK/I+6QpaMp0KAULJK3cplJIp4Bp8dWsDdS8NswUGmXCVl43161wC9ztDmdRe
         cHrFb93Kly+hvvx8XMVblb0TzmE/K2gzq+h7B+HWImIVuXC7o4+gnZBsfhmD3MtCVQ/k
         2J+w==
X-Gm-Message-State: APjAAAUu1dhDUA1wRVNbQKsKAT8CLXvxC/fHgooquNpHT/whTYZJYwUm
        Y7PEwiIc2qvnTtU6ud96Kcx1KA==
X-Google-Smtp-Source: APXvYqzkNDyb/rDTQKYodOxdQ512QxV69RgOez8G9MWHHZYmK+E4QDmvkgWYS+9U87Ln7IsNteH+EQ==
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr21764423wmg.39.1578095233571;
        Fri, 03 Jan 2020 15:47:13 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e6sm60931506wru.44.2020.01.03.15.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:47:13 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Halcrow <mhalcrow@google.com>
Subject: [PATCH bpf-next] bpf: Make trampolines W^X
Date:   Sat,  4 Jan 2020 00:47:25 +0100
Message-Id: <20200103234725.22846-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The image for the BPF trampolines is allocated with
bpf_jit_alloc_exe_page which marks this allocated page executable. This
means that the allocated memory is W and X at the same time making it
susceptible to WX based attacks.

Since the allocated memory is shared between two trampolines (the
current and the next), 2 pages must be allocated to adhere to W^X and
the following sequence is obeyed where trampolines are modified:

- Mark memory as non executable (set_memory_nx). While module_alloc for
  x86 allocates the memory as PAGE_KERNEL and not PAGE_KERNEL_EXEC, not
  all implementations of module_alloc do so
- Mark the memory as read/write (set_memory_rw)
- Modify the trampoline
- Mark the memory as read-only (set_memory_ro)
- Mark the memory as executable (set_memory_x)

There's a window between the modification of the trampoline and setting
the trampoline as read-only where an attacker and ~could~ change the
contents of the memory. This can be further improved by adding more
verification after the memory is marked as read-only.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 arch/x86/net/bpf_jit_comp.c |  2 +-
 include/linux/bpf.h         |  1 -
 kernel/bpf/dispatcher.c     | 30 +++++++++++++++++++++++----
 kernel/bpf/trampoline.c     | 41 +++++++++++++++++++------------------
 4 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4c8a2d1f8470..a510f8260322 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1527,7 +1527,7 @@ int arch_prepare_bpf_trampoline(void *image, struct btf_func_model *m, u32 flags
 	 * Another half is an area for next trampoline.
 	 * Make sure the trampoline generation logic doesn't overflow.
 	 */
-	if (WARN_ON_ONCE(prog - (u8 *)image > PAGE_SIZE / 2 - BPF_INSN_SAFETY))
+	if (WARN_ON_ONCE(prog - (u8 *)image > PAGE_SIZE - BPF_INSN_SAFETY))
 		return -EFAULT;
 	return 0;
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b14e51d56a82..3be8b1b0166d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -502,7 +502,6 @@ struct bpf_trampoline *bpf_trampoline_lookup(u64 key);
 int bpf_trampoline_link_prog(struct bpf_prog *prog);
 int bpf_trampoline_unlink_prog(struct bpf_prog *prog);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
-void *bpf_jit_alloc_exec_page(void);
 #define BPF_DISPATCHER_INIT(name) {			\
 	.mutex = __MUTEX_INITIALIZER(name.mutex),	\
 	.func = &name##func,				\
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 204ee61a3904..f4589da3bb34 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -93,13 +93,34 @@ int __weak arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
 static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image)
 {
 	s64 ips[BPF_DISPATCHER_MAX] = {}, *ipsp = &ips[0];
-	int i;
+	int i, ret;
 
 	for (i = 0; i < BPF_DISPATCHER_MAX; i++) {
 		if (d->progs[i].prog)
 			*ipsp++ = (s64)(uintptr_t)d->progs[i].prog->bpf_func;
 	}
-	return arch_prepare_bpf_dispatcher(image, &ips[0], d->num_progs);
+
+	/* First make the page non-executable and then make it RW to avoid it
+	 * from being W+X. While x86's implementation of module_alloc
+	 * allocates memory as non-executable, not all implementations do so.
+	 * Till these are fixed, explicitly mark the memory as NX.
+	 */
+	set_memory_nx((unsigned long)image, 1);
+	set_memory_rw((unsigned long)image, 1);
+
+	ret = arch_prepare_bpf_dispatcher(image, &ips[0], d->num_progs);
+	if (ret)
+		return ret;
+
+	/* First make the page read-only, and only then make it executable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_ro((unsigned long)image, 1);
+	/* More checks can be done here to ensure that nothing was changed
+	 * between arch_prepare_bpf_dispatcher and set_memory_ro.
+	 */
+	set_memory_x((unsigned long)image, 1);
+	return 0;
 }
 
 static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
@@ -113,7 +134,7 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 		noff = 0;
 	} else {
 		old = d->image + d->image_off;
-		noff = d->image_off ^ (PAGE_SIZE / 2);
+		noff = d->image_off ^ PAGE_SIZE;
 	}
 
 	new = d->num_progs ? d->image + noff : NULL;
@@ -140,10 +161,11 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 
 	mutex_lock(&d->mutex);
 	if (!d->image) {
-		d->image = bpf_jit_alloc_exec_page();
+		d->image = bpf_jit_alloc_exec(2 * PAGE_SIZE);
 		if (!d->image)
 			goto out;
 	}
+	set_vm_flush_reset_perms(d->image);
 
 	prev_num_progs = d->num_progs;
 	changed |= bpf_dispatcher_remove_prog(d, from);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 505f4e4b31d2..ff6a92ef8945 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -14,22 +14,6 @@ static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline_table */
 static DEFINE_MUTEX(trampoline_mutex);
 
-void *bpf_jit_alloc_exec_page(void)
-{
-	void *image;
-
-	image = bpf_jit_alloc_exec(PAGE_SIZE);
-	if (!image)
-		return NULL;
-
-	set_vm_flush_reset_perms(image);
-	/* Keep image as writeable. The alternative is to keep flipping ro/rw
-	 * everytime new program is attached or detached.
-	 */
-	set_memory_x((long)image, 1);
-	return image;
-}
-
 struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 {
 	struct bpf_trampoline *tr;
@@ -50,12 +34,13 @@ struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 		goto out;
 
 	/* is_root was checked earlier. No need for bpf_jit_charge_modmem() */
-	image = bpf_jit_alloc_exec_page();
+	image = bpf_jit_alloc_exec(2 * PAGE_SIZE);
 	if (!image) {
 		kfree(tr);
 		tr = NULL;
 		goto out;
 	}
+	set_vm_flush_reset_perms(image);
 
 	tr->key = key;
 	INIT_HLIST_NODE(&tr->hlist);
@@ -125,14 +110,14 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 }
 
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
- * bytes on x86.  Pick a number to fit into PAGE_SIZE / 2
+ * bytes on x86.  Pick a number to fit into PAGE_SIZE.
  */
 #define BPF_MAX_TRAMP_PROGS 40
 
 static int bpf_trampoline_update(struct bpf_trampoline *tr)
 {
-	void *old_image = tr->image + ((tr->selector + 1) & 1) * PAGE_SIZE/2;
-	void *new_image = tr->image + (tr->selector & 1) * PAGE_SIZE/2;
+	void *old_image = tr->image + ((tr->selector + 1) & 1) * PAGE_SIZE;
+	void *new_image = tr->image + (tr->selector & 1) * PAGE_SIZE;
 	struct bpf_prog *progs_to_run[BPF_MAX_TRAMP_PROGS];
 	int fentry_cnt = tr->progs_cnt[BPF_TRAMP_FENTRY];
 	int fexit_cnt = tr->progs_cnt[BPF_TRAMP_FEXIT];
@@ -160,6 +145,13 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	if (fexit_cnt)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
+
+	/* First make the page non-executable and then make it RW to avoid it
+	 * from being being W+X.
+	 */
+	set_memory_nx((unsigned long)new_image, 1);
+	set_memory_rw((unsigned long)new_image, 1);
+
 	err = arch_prepare_bpf_trampoline(new_image, &tr->func.model, flags,
 					  fentry, fentry_cnt,
 					  fexit, fexit_cnt,
@@ -167,6 +159,15 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	if (err)
 		goto out;
 
+	/* First make the page read-only, and only then make it executable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_ro((unsigned long)new_image, 1);
+	/* More checks can be done here to ensure that nothing was changed
+	 * between arch_prepare_bpf_trampoline and set_memory_ro.
+	 */
+	set_memory_x((unsigned long)new_image, 1);
+
 	if (tr->selector)
 		/* progs already running at this address */
 		err = modify_fentry(tr, old_image, new_image);
-- 
2.20.1

