Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D471264F6DC
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 02:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLQB6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 20:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiLQB5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 20:57:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6011158
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:57:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u5so4095844pjy.5
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaxWeWngZMSAhXbJqUy2yy8VTPB8ppKaEKcVqmP8WIo=;
        b=AEn4HXfDAjNH/2hE1bXmKNe9N9YPDZb98Y/p3O9rOgAly02Cp9eZQP8BE+HetakznQ
         S16sNPtLkEGJ4f4fvmQvuxoZNiSUECFGtgIp356ywXVTaH6QYdHwh24tPMDYwXMtqYxq
         /mTrxJ/ASr5ACLKIbG2CPRWre0Y01PeJX7dsW+TXt+UdcvLDSXhbcPHRatdMdWhRQjTC
         9heAZ/Y+5tLn2NBlsLEIflxd0i4B/gsJThSh8kcZUbwkj/6Ph2eH34P9BRVfuDkpMHh6
         uaUA5RazSkLXBEE0SkflrMS4OsuSQDtcRNm0fTuKClmkNrGxAbnNsN0GmsuBsf5/yuQG
         m6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaxWeWngZMSAhXbJqUy2yy8VTPB8ppKaEKcVqmP8WIo=;
        b=b+LfvI+3NOERXKDgnbOr3/HaN0c2vs+2zOvVg4Hp5trMWb85qCVZo0+J1hre9Vtpl2
         L+miIpyENd3HnZaY6RbDcxJBpZqguiTyMnGtfpaPvgUbSBK+MPkg21rhRdcl+Ot4i8Dt
         ahqmcFb4Y7bUtk+9nRGH2otSf86F7C++cwlXS3+1kVm7q08ZvtEpmRWLViZ3L+3Tk6T0
         IsWKChIlSaTe4ARi+z9gVlE+5rm46/rVFv0K7BvIcAZAqOXyQ0TTXPek5NoHwoZ7MRMr
         QePagYZVIVYNiv3Idhte+JeyfLIVovd0QkhydnQpVK4SomD/x09QzlhaM+x7Xt/5keuR
         40Bg==
X-Gm-Message-State: AFqh2kqBGhWD/YX6LrtqJu9S55kgVxPie7mUkxE6a8sj/ynmdKeNuC76
        yA8C9TxS5Mln4yoacExmBLOgl/+fHPTS9JD9zJ3MFRlEe3U=
X-Google-Smtp-Source: AMrXdXsWMqt1AMmXRECKK+2nZs1QhKvmTkn1bj4hKZQ9WEemfjPgk0ZRNaIVcbqC0lcwddkmUkzguQ==
X-Received: by 2002:a05:6a21:1506:b0:9d:efbf:813c with SMTP id nq6-20020a056a21150600b0009defbf813cmr827451pzb.5.1671242268289;
        Fri, 16 Dec 2022 17:57:48 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a1f4a00b001ef8ab65052sm1924994pjy.11.2022.12.16.17.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 17:57:47 -0800 (PST)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [PATCH 1/2] bpf: Add socket destroy capability
Date:   Sat, 17 Dec 2022 01:57:17 +0000
Message-Id: <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1671242108.git.aditi.ghag@isovalent.com>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The socket destroy helper is used to
forcefully terminate sockets from certain
BPF contexts. We plan to use the capability
in Cilium to force client sockets to reconnect
when their remote load-balancing backends are
deleted. The other use case is on-the-fly
policy enforcement where existing socket
connections prevented by policies need to
be terminated.

The helper is currently exposed to iterator
type BPF programs where users can filter,
and terminate a set of sockets.

Sockets are destroyed asynchronously using
the work queue infrastructure. This allows
for current the locking semantics within
socket destroy handlers, as BPF iterators
invoking the helper acquire *sock* locks.
This also allows the helper to be invoked
from non-sleepable contexts.
The other approach to skip acquiring locks
by passing an argument to the `diag_destroy`
handler didn't work out well for UDP, as
the UDP abort function internally invokes
another function that ends up acquiring
*sock* lock.
While there are sleepable BPF iterators,
these are limited to only certain map types.
Furthermore, it's limiting in the sense that
it wouldn't allow us to extend the helper
to other non-sleepable BPF programs.

The work queue infrastructure processes work
items from per-cpu structures. As the sock
destroy work items are executed asynchronously,
we need to ref count sockets before they are
added to the work queue. The 'work_pending'
check prevents duplicate ref counting of sockets
in case users invoke the destroy helper for a
socket multiple times. The `{READ,WRITE}_ONCE`
macros ensure that the socket pointer stored
in a work queue item isn't clobbered while
the item is being processed. As BPF programs
are non-preemptible, we can expect that once
a socket is ref counted, no other socket can
sneak in before the ref counted socket is
added to the work queue for asynchronous destroy.
Finally, users are expected to retry when the
helper fails to queue a work item for a socket
to be destroyed in case there is another destroy
operation is in progress.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 17 +++++++++
 kernel/bpf/core.c              |  1 +
 kernel/trace/bpf_trace.c       |  2 +
 net/core/filter.c              | 70 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 17 +++++++++
 6 files changed, 108 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3de24cfb7a3d..60eaa05dfab3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2676,6 +2676,7 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_sock_destroy_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 464ca3f01fe7..789ac7c59fdf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5484,6 +5484,22 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_sock_destroy(struct sock *sk)
+ *	Description
+ *		Destroy the given socket with **ECONNABORTED** error code.
+ *
+ *		*sk* must be a non-**NULL** pointer to a socket.
+ *
+ *	Return
+ *		The socket is destroyed asynchronosuly, so 0 return value may
+ *		not suggest indicate that the socket was successfully destroyed.
+ *
+ *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, **EINVAL**.
+ *
+ *		**-EPROTONOSUPPORT** if protocol specific destroy handler is not implemented.
+ *
+ *		**-EBUSY** if another socket destroy operation is in progress.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5698,6 +5714,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(sock_destroy, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7f98dec6e90f..c59bef9805e5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2651,6 +2651,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto __weak;
 const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
 const struct bpf_func_proto bpf_set_retval_proto __weak;
 const struct bpf_func_proto bpf_get_retval_proto __weak;
+const struct bpf_func_proto bpf_sock_destroy_proto __weak;
 
 const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..016dbee6b5e4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1930,6 +1930,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_ptr_cookie_proto;
 	case BPF_FUNC_xdp_get_buff_len:
 		return &bpf_xdp_get_buff_len_trace_proto;
+	case BPF_FUNC_sock_destroy:
+		return &bpf_sock_destroy_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 929358677183..9753606ecc26 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11569,6 +11569,8 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 		break;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_sock_destroy:
+		return &bpf_sock_destroy_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -11578,3 +11580,71 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 
 	return func;
 }
+
+struct sock_destroy_work {
+	struct sock *sk;
+	struct work_struct destroy;
+};
+
+static DEFINE_PER_CPU(struct sock_destroy_work, sock_destroy_workqueue);
+
+static void bpf_sock_destroy_fn(struct work_struct *work)
+{
+	struct sock_destroy_work *sd_work = container_of(work,
+			struct sock_destroy_work, destroy);
+	struct sock *sk = READ_ONCE(sd_work->sk);
+
+	sk->sk_prot->diag_destroy(sk, ECONNABORTED);
+	sock_put(sk);
+}
+
+static int __init bpf_sock_destroy_workqueue_init(void)
+{
+	int cpu;
+	struct sock_destroy_work *work;
+
+	for_each_possible_cpu(cpu) {
+		work = per_cpu_ptr(&sock_destroy_workqueue, cpu);
+		INIT_WORK(&work->destroy, bpf_sock_destroy_fn);
+	}
+
+	return 0;
+}
+subsys_initcall(bpf_sock_destroy_workqueue_init);
+
+BPF_CALL_1(bpf_sock_destroy, struct sock *, sk)
+{
+	struct sock_destroy_work *sd_work;
+
+	if (!sk->sk_prot->diag_destroy)
+		return -EOPNOTSUPP;
+
+	sd_work = this_cpu_ptr(&sock_destroy_workqueue);
+	/* This check prevents duplicate ref counting
+	 * of sockets, in case the handler is invoked
+	 * multiple times for the same socket.
+	 */
+	if (work_pending(&sd_work->destroy))
+		return -EBUSY;
+
+	/* Ref counting ensures that the socket
+	 * isn't deleted from underneath us before
+	 * the work queue item is processed.
+	 */
+	if (!refcount_inc_not_zero(&sk->sk_refcnt))
+		return -EINVAL;
+
+	WRITE_ONCE(sd_work->sk, sk);
+	if (!queue_work(system_wq, &sd_work->destroy)) {
+		sock_put(sk);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_sock_destroy_proto = {
+	.func		= bpf_sock_destroy,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+};
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 464ca3f01fe7..07154a4d92f9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5484,6 +5484,22 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_sock_destroy(void *sk)
+ *	Description
+ *		Destroy the given socket with **ECONNABORTED** error code.
+ *
+ *		*sk* must be a non-**NULL** pointer to a socket.
+ *
+ *	Return
+ *		The socket is destroyed asynchronosuly, so 0 return value may
+ *		not indicate that the socket was successfully destroyed.
+ *
+ *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, **EINVAL**.
+ *
+ *		**-EPROTONOSUPPORT** if protocol specific destroy handler is not implemented.
+ *
+ *		**-EBUSY** if another socket destroy operation is in progress.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5698,6 +5714,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(sock_destroy, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.34.1

