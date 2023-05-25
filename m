Return-Path: <bpf+bounces-1224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337F710E1F
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B6A1C20ECD
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E682311CB8;
	Thu, 25 May 2023 14:18:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8762101E4
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 14:18:18 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C563191
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 07:18:17 -0700 (PDT)
Date: Thu, 25 May 2023 16:18:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1685024295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlEzqf8v5LIHFpTK6bS8f7bh0N8Q4MKhEvHKfwTR7Lo=;
	b=qegWGBFjYZT8xoJu79oaHox4b1lJTsoBfa5uidlT67FSTd5pV25Wrbyadzz9TevEvP9Acw
	C2j2+Js1a1/72+yZZNZGIDh34rkf5dlt7IWXziBOwY8z0QxktMbfRRHLS+3gZlPg2j1ULb
	aCZaOP9HrBo6102nloLeXWm0AWdu0XrGgyxZ7Aua92dOsPTrysE/1srBqpprpSAmWoFS3N
	rFTsR6HlZ3FKqFi0JEt1dCW4eT7bSoOdZTDo9FbsQPlH0C4vJpHpG4CpOmSbCS+bAEiFoG
	vP4O8pzVTJxgXCS7+1CDRHG00S0FykJcXcYUF/cW/lUTGKVF+KK6tLSl6Xgoyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1685024295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlEzqf8v5LIHFpTK6bS8f7bh0N8Q4MKhEvHKfwTR7Lo=;
	b=dTjZTP92nujluv04YY4Dty5AQxOEelsKuUrwlvzKZbl+/YbCwS5hOm+9wqZuYgLiCw6qB0
	Bxli6zoXMSxiGUAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230525141813.TFZLWM4M@linutronix.de>
References: <20230509132433.2FSY_6t7@linutronix.de>
 <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
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
delayed if originated from close().

Remove the context checks and use the workqueue unconditionally. For the
close() callback add bpf_link_put_direct() which invokes free function
directly.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1=E2=80=A6v2:
   - Add bpf_link_put_direct() to be used from bpf_link_release() as
     suggested.

On 2023-05-17 09:26:19 [-0700], Andrii Nakryiko wrote:
> Is struct file_operations.release() callback guaranteed to be called
> from user context? If yes, then perhaps the most straightforward way
> to guarantee synchronous bpf_link cleanup on close(link_fd) is to have
> a bpf_link_put() variant that will be only called from user-context
> and will just do bpf_link_free(link) directly, without checking
> in_atomic().

Yes. __fput() has a might_sleep() and it invokes
file_operations::release.

 kernel/bpf/syscall.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573ee..85159428e5fee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2785,20 +2785,23 @@ void bpf_link_put(struct bpf_link *link)
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
 }
 EXPORT_SYMBOL(bpf_link_put);
=20
+static void bpf_link_put_direct(struct bpf_link *link)
+{
+	if (!atomic64_dec_and_test(&link->refcnt))
+		return;
+	bpf_link_free(link);
+}
+
 static int bpf_link_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_link *link =3D filp->private_data;
=20
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return 0;
 }
=20
--=20
2.40.1


