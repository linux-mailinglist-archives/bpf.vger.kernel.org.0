Return-Path: <bpf+bounces-8975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124778D3D5
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5D4280C03
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E91C39;
	Wed, 30 Aug 2023 08:04:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C11871
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 08:04:19 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE4CDA
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:04:17 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693382656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqdZAwU6v40vJUHRhOXclUO3qJSqTF/XTdzJp3JabQI=;
	b=J2lSRD+6iSrQtwchqlQMMysiplZMLDdu8JB+K0qmLVgrT/HXXkn17jnfGAfLJY9VqGZ7Rj
	elL4mxGJuuB3/XhPBBebt644+S2aM6jxRfb5u6QY9q6yHvyKYz4W30rsQ5wlMKpdx+8Psf
	AcMzJUyENBDLCOPVlqhI3+/zSGR6Dd6ryb9mR7WikRUWKgDeiK3H0jks9jObO1c29x6o/L
	87zCJRcYqnhFzSswvb6M4DpAHLn/+g1EzvnnzTyI8S8JX0TGugXDaQTXVBLKaHEj93Tt/6
	laCiF/1s8zMJffwzar1wWdsnz/OXGaklMWhbDr6/OwN9iC2rMr1R0d+S2WTmmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693382656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqdZAwU6v40vJUHRhOXclUO3qJSqTF/XTdzJp3JabQI=;
	b=HJ80TsAkxoe9GiYvCsvhC9mqKrjiYnDR3gS+tsgAidk1KQ26zVfYz8dD54hEPDm5Asznr8
	0EiA1MvGb+wn78DA==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.
Date: Wed, 30 Aug 2023 10:04:05 +0200
Message-Id: <20230830080405.251926-3-bigeasy@linutronix.de>
In-Reply-To: <20230830080405.251926-1-bigeasy@linutronix.de>
References: <20230830080405.251926-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

__bpf_prog_enter() assigns bpf_tramp_run_ctx::saved_run_ctx before
performing the recursion check which means in case of a recursion
__bpf_prog_exit() uses the previously set
bpf_tramp_run_ctx::saved_run_ctx value.

__bpf_prog_enter_sleepable() assigns bpf_tramp_run_ctx::saved_run_ctx
after the recursion check which means in case of a recursion
__bpf_prog_exit_sleepable() uses an uninitialized value.
This does not look right. If I read the entry trampoline code right,
then bpf_tramp_run_ctx isn't initialized upfront.

Align __bpf_prog_enter_sleepable() with __bpf_prog_enter() and set
bpf_tramp_run_ctx::saved_run_ctx before the recursion check is made.
Remove the assignment of saved_run_ctx in kern_sys_bpf() since it
happens a few cycles later.

Fixes: e384c7b7b46d0 ("bpf, x86: Create bpf_tramp_run_ctx on the caller thr=
ead's stack")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/syscall.c    | 1 -
 kernel/bpf/trampoline.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c925c270ed8b4..1480b6cf12f06 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5304,7 +5304,6 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsig=
ned int size)
 		}
=20
 		run_ctx.bpf_cookie =3D 0;
-		run_ctx.saved_run_ctx =3D NULL;
 		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
 			/* recursion detected */
 			__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 78acf28d48732..53ff50cac61ea 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -926,13 +926,12 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct b=
pf_prog *prog,
 	migrate_disable();
 	might_fault();
=20
+	run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		return 0;
 	}
-
-	run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
-
 	return bpf_prog_start_time();
 }
=20
--=20
2.40.1


