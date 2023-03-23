Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D394A6C7187
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 21:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCWUG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWUGy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 16:06:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7125E0D
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:06:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so3060515pjp.1
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679602013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW0tiAWBVLKjnwIUis1lvm04oebQt67O7eZhyfelwws=;
        b=eBGeADZfk0TYeLGMQfqd8+yxtYmv15ALJi4Js6FzcvhX/bfuYve9cjy/awPL98ZjKa
         +6MpSTUEHa9flk4KyLoykQ+Fe3dP/kGdMiQTJRqOj9tdAOSdUz7LhvyefCDgEW1Yob1w
         VmY3BQgLufHoFDk10qivs1N8pQVL20Vl4515zIpHKs8DZ5ou5zXkTsCqLIuErxQyCWBj
         t+toQE1Ej38ii1g8uD2QkhYH0EHx4bvrDRKIihz7XQlOcRr5ftTVLlWJ3Hwa/X5vXmqu
         tZEKZfd9tZDOlNFBYgMhhRf7mS/Kq1HST775bvnS/jkxG92H5RwHaES4vnXs6C7spXqH
         IIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679602013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW0tiAWBVLKjnwIUis1lvm04oebQt67O7eZhyfelwws=;
        b=05wDErAsRMFSEgnY8OqffrWlj62DMpSNC1Q3OMsmVo0alKd40Swfj3xO3NA6XkfgCc
         khNy7rU2D7zyC9dtFVV4bHSQpLKQIRHiNJnaVOMTyQyPHq9UAt9BuWfwGfbGuwIetXcU
         u682fvwx9drZggxjfKvfDR84FQ1SWBCpdPF7qkpWyvP9uOWuYTFISlvoZ8V+fYRANtrP
         AZYOOeDSqZDyfXnVU8z8rW1HhCzypnOQ/Trs/TbMxO313mdWcM86QhkUuT3iVjz7TG9k
         XXiD3ZKJnLHMxQ0VmXa9WmNK0NIaHbnOLV2jtR+KKNM5scLiH1alBWKt6/3HZacP8V6q
         JsBg==
X-Gm-Message-State: AAQBX9fxG4+tKX/jRZjGWNktkoKTx1lbUV126CUisVwVIvm2GLlS3iyV
        LWiVXLMYOHiKkF+ED01D6/XhWPud2gWcfVAgI3s=
X-Google-Smtp-Source: AKy350a4PxFjTOqgOs582So2YuwSIDOgT+20ei8L0nqIA0mrpkDi9nrgCElRfMErogp2yohykid9IQ==
X-Received: by 2002:a17:903:cc:b0:19e:6e00:4676 with SMTP id x12-20020a17090300cc00b0019e6e004676mr35811plc.61.1679602012832;
        Thu, 23 Mar 2023 13:06:52 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b0019aaab3f9d7sm12701698plt.113.2023.03.23.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:06:52 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v4 bpf-next 2/4] bpf: Add bpf_sock_destroy kfunc
Date:   Thu, 23 Mar 2023 20:06:31 +0000
Message-Id: <20230323200633.3175753-3-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The socket destroy kfunc is used to forcefully terminate sockets from
certain BPF contexts. We plan to use the capability in Cilium to force
client sockets to reconnect when their remote load-balancing backends are
deleted. The other use case is on-the-fly policy enforcement where existing
socket connections prevented by policies need to be forcefully terminated.
The helper allows terminating sockets that may or may not be actively
sending traffic.

The helper is currently exposed to certain BPF iterators where users can
filter, and terminate selected sockets.  Additionally, the helper can only
be called from these BPF contexts that ensure socket locking in order to
allow synchronous execution of destroy helpers that also acquire socket
locks. The previous commit that batches UDP sockets during iteration
facilitated a synchronous invocation of the destroy helper from BPF context
by skipping taking socket locks in the destroy handler. TCP iterators
already supported batching.

The helper takes `sock_common` type argument, even though it expects, and
casts them to a `sock` pointer. This enables the verifier to allow the
sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
`sock` structs. As a comparison, BPF helpers enable this behavior with the
`ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no such
option available with the verifier logic that handles kfuncs where BTF
types are inferred. Furthermore, as `sock_common` only has a subset of
certain fields of `sock`, casting pointer to the latter type might not
always be safe. Hence, the BPF kfunc converts the argument to a full sock
before casting.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/core/filter.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c    | 10 ++++++---
 net/ipv4/udp.c    |  6 ++++--
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1d6f165923bf..ba3e0dac119c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 
 	return func;
 }
+
+/* Disables missing prototype warnings */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
+ *
+ * The helper expects a non-NULL pointer to a socket. It invokes the
+ * protocol specific socket destroy handlers.
+ *
+ * The helper can only be called from BPF contexts that have acquired the socket
+ * locks.
+ *
+ * Parameters:
+ * @sock: Pointer to socket to be destroyed
+ *
+ * Return:
+ * On error, may return EPROTONOSUPPORT, EINVAL.
+ * EPROTONOSUPPORT if protocol specific destroy handler is not implemented.
+ * 0 otherwise
+ */
+__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
+{
+	struct sock *sk = (struct sock *)sock;
+
+	if (!sk)
+		return -EINVAL;
+
+	/* The locking semantics that allow for synchronous execution of the
+	 * destroy handlers are only supported for TCP and UDP.
+	 */
+	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
+		return -EOPNOTSUPP;
+
+	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
+}
+
+__diag_pop()
+
+BTF_SET8_START(sock_destroy_kfunc_set)
+BTF_ID_FLAGS(func, bpf_sock_destroy)
+BTF_SET8_END(sock_destroy_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &sock_destroy_kfunc_set,
+};
+
+static int init_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sock_destroy_kfunc_set);
+}
+late_initcall(init_subsystem);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 33f559f491c8..5df6231016e3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
 		return 0;
 	}
 
-	/* Don't race with userspace socket closes such as tcp_close. */
-	lock_sock(sk);
+	/* BPF context ensures sock locking. */
+	if (!has_current_bpf_ctx())
+		/* Don't race with userspace socket closes such as tcp_close. */
+		lock_sock(sk);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -4701,9 +4703,11 @@ int tcp_abort(struct sock *sk, int err)
 	}
 
 	bh_unlock_sock(sk);
+
 	local_bh_enable();
 	tcp_write_queue_purge(sk);
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_abort);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 58c620243e47..408836102e20 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2925,7 +2925,8 @@ EXPORT_SYMBOL(udp_poll);
 
 int udp_abort(struct sock *sk, int err)
 {
-	lock_sock(sk);
+	if (!has_current_bpf_ctx())
+		lock_sock(sk);
 
 	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
 	 * with close()
@@ -2938,7 +2939,8 @@ int udp_abort(struct sock *sk, int err)
 	__udp_disconnect(sk, 0);
 
 out:
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 
 	return 0;
 }
-- 
2.34.1

