Return-Path: <bpf+bounces-1302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DA712564
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 13:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B021C2102D
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407CF742F1;
	Fri, 26 May 2023 11:24:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D5742E1
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 11:24:03 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B1F7
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:24:02 -0700 (PDT)
Date: Fri, 26 May 2023 13:23:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1685100239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuhrwHtBdmWzMFZzhCPf02CiRKUsfZkqVPfNxHota1o=;
	b=J6yIThtkVMcn9OB2CvWNsx6yR/T8cu0uKFwAlwMguULrTQnhemV3rNuBr9rjwQyYwTy2jF
	2dV9obg61GrZiSA8AakLwhpmZt7Zbt8ObBjoKcdfIG7IFyGDQHNCy+qLvoqktdaF3PAtgT
	2op3kDxlgaG2VRSxfyJMgeKDDOv5toQUDV8jqXXgSMfkhHQUIPSZ7is4/Tz7OYK+H8mWvS
	imsJxIMQFn/0LG+FbD4iUOnf4SbXFF8HFCoJE12MV/aM+8pn68CHJjwiqfC6CFfMXXOWFi
	LLZbxWVNGH+YXBPECBQUoOGKD+0rBkEAil5LjAR81UQJxflsWzMlYu/NOaUXUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1685100239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuhrwHtBdmWzMFZzhCPf02CiRKUsfZkqVPfNxHota1o=;
	b=8xHFzM/diDbwarfgX/OftMghEWMv7PuMPq9kZ78zg2YezNHFFsaQ8a2nTYoPoIOEKbYNnI
	Flq4S1AOYYSqZgDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230526112356.fOlWmeOF@linutronix.de>
References: <20230509132433.2FSY_6t7@linutronix.de>
 <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
invoked within softirq context. By setting rcutree.use_softirq=3D0 boot
option the RCU callbacks will be invoked in a per-CPU kthread with
bottom halves disabled which implies a RCU read section.

On PREEMPT_RT the context remains fully preemptible. The RCU read
section however does not allow schedule() invocation. The latter happens
in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
=66rom bpf_link_put().

It was pointed out that the bpf_link_put() invocation should not be
delayed if originated from close(). It was also pointed out that other
invocations from within a syscall should also avoid the workqueue.
After an audit of all bpf_link_put() callers it looks that the only
atomic caller is the RCU callback. Everything else is called from
preemptible context because it is a syscall, a mutex_t is acquired near
by or due a GFP_KERNEL memory allocation.

Let bpf_link_put() free the resources directly. Add
bpf_link_put_from_atomic() which uses the kworker to free the
resources. Let bpf_any_put() invoke one or the other depending on the
context it is called from (RCU or not).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2023-05-25 10:51:23 [-0700], Andrii Nakryiko wrote:
v2=E2=80=A6v3:
  - Drop bpf_link_put_direct(). Let bpf_link_put() do the direct free
    and add bpf_link_put_from_atomic() to do the delayed free via the
    worker.

v1=E2=80=A6v2:
   - Add bpf_link_put_direct() to be used from bpf_link_release() as
     suggested.

> Looks good to me, but it's not sufficient. See kernel/bpf/inode.c, we
> need to do bpf_link_put_direct() from bpf_put_any(), which should be
> safe as well because it all is either triggered from bpf() syscall or
> by unlink()'ing BPF FS file. For file deletion we have the same
> requirement to have deterministic release of bpf_link.

Okay. I checked all callers and it seems that the only atomic caller is
the RCU callback.

 include/linux/bpf.h  |  5 +++++
 kernel/bpf/inode.c   | 13 ++++++++-----
 kernel/bpf/syscall.c | 21 ++++++++++++---------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e53ceee1df370..dced1f880cfa6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2073,6 +2073,7 @@ int bpf_link_settle(struct bpf_link_primer *primer);
 void bpf_link_cleanup(struct bpf_link_primer *primer);
 void bpf_link_inc(struct bpf_link *link);
 void bpf_link_put(struct bpf_link *link);
+void bpf_link_put_from_atomic(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
 struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
@@ -2432,6 +2433,10 @@ static inline void bpf_link_put(struct bpf_link *lin=
k)
 {
 }
=20
+static inline void bpf_link_put_from_atomic(struct bpf_link *link)
+{
+}
+
 static inline int bpf_obj_get_user(const char __user *pathname, int flags)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9948b542a470e..2e1e9f3c7f701 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -49,7 +49,7 @@ static void *bpf_any_get(void *raw, enum bpf_type type)
 	return raw;
 }
=20
-static void bpf_any_put(void *raw, enum bpf_type type)
+static void bpf_any_put(void *raw, enum bpf_type type, bool may_sleep)
 {
 	switch (type) {
 	case BPF_TYPE_PROG:
@@ -59,7 +59,10 @@ static void bpf_any_put(void *raw, enum bpf_type type)
 		bpf_map_put_with_uref(raw);
 		break;
 	case BPF_TYPE_LINK:
-		bpf_link_put(raw);
+		if (may_sleep)
+			bpf_link_put(raw);
+		else
+			bpf_link_put_from_atomic(raw);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -490,7 +493,7 @@ int bpf_obj_pin_user(u32 ufd, const char __user *pathna=
me)
=20
 	ret =3D bpf_obj_do_pin(pathname, raw, type);
 	if (ret !=3D 0)
-		bpf_any_put(raw, type);
+		bpf_any_put(raw, type, true);
=20
 	return ret;
 }
@@ -552,7 +555,7 @@ int bpf_obj_get_user(const char __user *pathname, int f=
lags)
 		return -ENOENT;
=20
 	if (ret < 0)
-		bpf_any_put(raw, type);
+		bpf_any_put(raw, type, true);
 	return ret;
 }
=20
@@ -617,7 +620,7 @@ static void bpf_free_inode(struct inode *inode)
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
 	if (!bpf_inode_type(inode, &type))
-		bpf_any_put(inode->i_private, type);
+		bpf_any_put(inode->i_private, type, false);
 	free_inode_nonrcu(inode);
 }
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573ee..87b07ebd6d146 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2777,20 +2777,23 @@ static void bpf_link_put_deferred(struct work_struc=
t *work)
 	bpf_link_free(link);
 }
=20
-/* bpf_link_put can be called from atomic context, but ensures that resour=
ces
- * are freed from process context
+/* bpf_link_put_from_atomic is called from atomic context. It needs to be =
called
+ * from sleepable context in order to acquire sleeping locks during the pr=
ocess.
  */
-void bpf_link_put(struct bpf_link *link)
+void bpf_link_put_from_atomic(struct bpf_link *link)
 {
 	if (!atomic64_dec_and_test(&link->refcnt))
 		return;
=20
-	if (in_atomic()) {
-		INIT_WORK(&link->work, bpf_link_put_deferred);
-		schedule_work(&link->work);
-	} else {
-		bpf_link_free(link);
-	}
+	INIT_WORK(&link->work, bpf_link_put_deferred);
+	schedule_work(&link->work);
+}
+
+void bpf_link_put(struct bpf_link *link)
+{
+	if (!atomic64_dec_and_test(&link->refcnt))
+		return;
+	bpf_link_free(link);
 }
 EXPORT_SYMBOL(bpf_link_put);
=20
--=20
2.40.1


