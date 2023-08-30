Return-Path: <bpf+bounces-8974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674F78D3D0
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1543D281333
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A01877;
	Wed, 30 Aug 2023 08:04:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C81871
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 08:04:18 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F3CD8
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:04:17 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693382655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qs5GIxd/gXao51vH1rvqfnIqSWyOPls2CoHbkpmuMQk=;
	b=WQrcwpmx31Mq2HmsNHgOpN5MwgQ6iaBYjESbKA818M2KOEUTZvz5tkYzsQp/JSKrgB0usw
	COOKw+ztHEYO+68BreNR2XPfeIoQsNy7Jwnr6OYcqT/ICtbQ4RsZcwqO6WmMIC2jg+6lmL
	lTvDHJVktoGesCdpbZqrQIF4GW0tzRPlv7hSij/nzW7W/Iy+f/c9dYquzhbo1jDjGk2VKV
	0S1od9N9JVg45auPY905C8a0ri3w+rgkMB4GUuSXVhL5T9TvYbzt9mxJkCPCxObrCRcgkf
	zcoIYheHrXvUrBNJHtG2SD+Mm/2Z7br9zKTpqbvPo6aw99GmJSKxZ20Gx5fY3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693382655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qs5GIxd/gXao51vH1rvqfnIqSWyOPls2CoHbkpmuMQk=;
	b=EI1x4r1qZ1nT1KV/J/epqmCuhKQdpj1+4NEIDfsxDff07/hq/YMVNj3utDFhQybiJumz5I
	mWD1OXL6skKbyzCQ==
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
Subject: [PATCH 1/2] bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().
Date: Wed, 30 Aug 2023 10:04:04 +0200
Message-Id: <20230830080405.251926-2-bigeasy@linutronix.de>
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

If __bpf_prog_enter_sleepable_recur() detects recursion then it returns
0 without undoing rcu_read_lock_trace(), migrate_disable() or
decrementing the recursion counter. This is fine in the JIT case because
the JIT code will jump in the 0 case to the end and invoke the matching
exit trampoline (__bpf_prog_exit_sleepable_recur()).

This is not the case in kern_sys_bpf() which returns directly to the
caller with an error code.

Add __bpf_prog_exit_sleepable_recur() as clean up in the recursion case.

Fixes: b1d18a7574d0d ("bpf: Extend sys_bpf commands for bpf_syscall program=
s.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c2..c925c270ed8b4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5307,6 +5307,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsig=
ned int size)
 		run_ctx.saved_run_ctx =3D NULL;
 		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
 			/* recursion detected */
+			__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
 			bpf_prog_put(prog);
 			return -EBUSY;
 		}
--=20
2.40.1


