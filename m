Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2006F6192
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjECWyE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjECWyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590C44B7
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:53:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so10093095ad.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154439; x=1685746439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2lHDg5QdZkq6ksUKNS1hcQveXASFcJ3fP2NeLwWO4c=;
        b=fT7Zx8V8aK2LtlLZsqpr/qGLhiVYJDLKSkZmQqWrGn3GMwBKCwI1PPNBR741DiudJ2
         OZ3tVFKOSSQm7EMFzl5Oro/YHd05m6s+xP5xdM3qXwk7QXo4W9lbXXtYcAMFXGtfiAla
         ei170g5gLvG6AchcoPIox1JsbZSzksLwX/ps0bp05pWHtb1qSNx6PPOvfxWLOK7E5RbE
         O+gtNlpQigMHqo9upphEDdH4a/cin6Zyl0Q3A4JwL9zEoByIaG5ZfCcnkf4jxBASbuuO
         x+KjCwubabbD/9iq0S++bCwVXv64+3Z2ty3+KSqh1GnSr5i9dfSxgVzJeraKlEdn3CMR
         t4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154439; x=1685746439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2lHDg5QdZkq6ksUKNS1hcQveXASFcJ3fP2NeLwWO4c=;
        b=XOZrajdAjdDCet+PpaHtmIYOR5+WFDQVTtE0rtL/mCJ53Tol13t5tyW88wAz2w6Zqz
         m10cdm5q2DnSsyvqcok2iy5YieYaZtafIKyJTWIdNximKSlrPWmmI5xVMLLIxZ4svd5/
         EpMq/kSGeGPmo5aIVIVKasXF64gJUt8Ry8YKk4jl09PUCwIH9VW2niHVhjinKTk2cFIO
         Y5KLuFrEHYyhH0ojOMGWbW83FXtOg1Yj5HQvgFZpLy5rft/jrVZreOVVMTT8Vdi5ehg/
         bg42/t7ybkZ2fVGuZ7DwfsQuCZozxyB7oiWB45iN0Utxo6QOe9Db9ihugEBCo7K17C9V
         FP0A==
X-Gm-Message-State: AC+VfDyTeXC6u4W26u4KDdcDjsqy8hiOlI/eEEYQ+Hjudam2/b8Szigb
        Mxi431iQzWGf6y/AO36LzPxW9vhE0rcHyraW28M=
X-Google-Smtp-Source: ACHHUZ6KRJxwXFkf/mP63c7IqpYNQehYm+kPMThgGS5+WI3OBcQ1JDWJlY77JJ/OPqmk5YdOaEvqog==
X-Received: by 2002:a17:902:d505:b0:1a9:90bc:c3c6 with SMTP id b5-20020a170902d50500b001a990bcc3c6mr2063954plg.16.1683154438847;
        Wed, 03 May 2023 15:53:58 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:53:58 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com
Subject: [PATCH v7 bpf-next 01/10] bpf: tcp: Avoid taking fast sock lock in iterator
Date:   Wed,  3 May 2023 22:53:42 +0000
Message-Id: <20230503225351.3700208-2-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, BPF TCP iterator was acquiring fast version of sock lock that
disables the BH. This introduced a circular dependency with code paths that
later acquire sockets hash table bucket lock.
Replace the fast version of sock lock with slow that faciliates BPF
programs executed from the iterator to destroy TCP listening sockets
using the bpf_sock_destroy kfunc (implemened in follow-up commits).

Here is a stack trace that motivated this change:

```
lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> sock lock acquired with BH enabled
sk_clone_lock+0x146/0x520
inet_csk_clone_lock+0x1b/0x110
tcp_create_openreq_child+0x22/0x3f0
tcp_v6_syn_recv_sock+0x96/0x940


lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock (may cause deadlock if interrupted)
__inet_hash+0x4b/0x210
inet_csk_listen_start+0xe6/0x100
inet_listen+0x95/0x1d0
__sys_listen+0x69/0xb0
__x64_sys_listen+0x14/0x20
do_syscall_64+0x3c/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc


lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock
inet_unhash+0x9a/0x110
tcp_set_state+0x6a/0x210
tcp_abort+0x10d/0x200
bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
bpf_iter_run_prog+0x1ff/0x340
------> Release (bucket) lhash2.lock
bpf_iter_tcp_seq_show+0xca/0x190
------> Acquire (bucket) lhash2.lock
------> sock lock acquired with BH disabled
bpf_seq_read+0x177/0x450

```

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/tcp_ipv4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ea370afa70ed..f2d370a9450f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	struct sock *sk = v;
-	bool slow;
 	uid_t uid;
 	int ret;
 
@@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	if (sk_fullsock(sk))
-		slow = lock_sock_fast(sk);
+		lock_sock(sk);
 
 	if (unlikely(sk_unhashed(sk))) {
 		ret = SEQ_SKIP;
@@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 
 unlock:
 	if (sk_fullsock(sk))
-		unlock_sock_fast(sk, slow);
+		release_sock(sk);
 	return ret;
 
 }
-- 
2.34.1

