Return-Path: <bpf+bounces-42240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9119A148C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9001F2376B
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233991D1E71;
	Wed, 16 Oct 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="2qIJKGXz"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30318F2F9
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112491; cv=none; b=ZKPlbG6RdJf4aDiFDeznNiWrtt/jCKlSgRf2WUaptQ+ca1ap5CrwLuzb35m1ZZD6rrZXTdEkUuNFTs0Gfmo10to9I9/QefsnRqAIKQik2+8Y+UtnlA0GDk+ar6/5OirYHqVx0RshaW6p1MJMp8yyImc812kmezHinZA941xpiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112491; c=relaxed/simple;
	bh=J7VJOvb3+gWByufi8DxEEV+PP5uGJmU9rw04YU01O0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QS7eiTz/TsVOFKk2KMKqIYW7hWcgP8ViwRSkHmuAHQQEc4KSHht50CHhci1Lgv6NhYqK+vj2F0igoi5KCnOblVoRpuyrWgKFLqLnPdn/PR55LfdkXXnUR7iyJiDGCkA/1R54NuxY+bQ1KQxjS8P+1yAblAGQi+DoIG/WC8naYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=2qIJKGXz; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729112461; x=1729717261; i=linux@jordanrome.com;
	bh=nPyyMqaCnki3SYCO0WYRERMoEpoqneiuZUKl3/N/e88=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=2qIJKGXz6927Vkd3gsJxTWiYScZS4Lcj9z/Jd1D8SF/q/dtpVJppmKBK8eeldf76
	 FZf+3IxtkPPx2AWbGBL0+4RVZg4WaXPsJayA+3w3JseiKb2b1AQgHQQwshgOs9xKC
	 f8+Btl+HRaeMycdhf8t7uLaBfP6QzWpFjqf1ggb+5lfI7oipRvtt/g+iEgjpOxCtx
	 uMe5fdWUcNPhxqMhJ0MFHHBi32gqAr8Ngb4p4YLawWRHmuEsq+Puw+Khg1ObZSXtY
	 d0fN9SK8xvVcuBGqxaGjJ6BvetLWVpHnO9k5dLiJsn0g/X4sYFJGg085zCwAFiKwh
	 tP6iBYKnwhq7HabKcQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.113]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Md2qC-1tJOmN1j6Y-00XBek; Wed, 16 Oct
 2024 23:01:01 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [PATCH bpf v2 1/2] bpf: Fix iter/task tid filtering
Date: Wed, 16 Oct 2024 14:00:47 -0700
Message-ID: <20241016210048.1213935-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7ydAY+kefB0T78wt6G9KaGayILWBCjAICKnImjAEgIOJz+OFaxW
 rIqZSc/zDr6LeJAzyQ2xtH/yak9Af0vQIRUa2DfA/D+uOMHqDqJoIxJGGY3izK2+HezKNgH
 OuF7IKylIfd2ZPxB7tqMMp2lYix+jQkGM7wCkAK6rOiyAICDJExuAKVQtSLllbAnB7kGwrZ
 1KAQPquVHh1gEtlX44P6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y9Kwv+fVS+I=;LH1PW+uDlFBk2qzQpcjYLRZK/Gv
 Z2qdhzLxi7nqnOb6uDwWMFYFNJuCoyaCc6Msy9O5AbZuxo6poa9dVsiY/ojUa6/Ib4E2xE39c
 yBxpz5dMhJanwxDnsCxW1cc9r2b6WVFte2DNWElRm/DqDeWWkHqQUy2012MiHfYoL1aDKjBBe
 KS1mPYLIGEZYKgaOdDi7YRAFh8qH3X11nvr6sz3Y8yiY1UEVGe/CtJrHZ6rYgJWVeiA0vg5kt
 5jHRZzyXs2rqruQaENoRZ70Fq7xxZrrC4ql7ovZsS2M7mKWTOTGQqWSTf/g6rlYAMVFDSPukK
 6ntPDYqQ166UPW2qDZsPaV3glJUU63SMiTPzoO9Tx8ECBgzzWQdF1YTL60D0Yoahxl6eT+oYN
 WkSMSs/85eWy/vcEp4UZIt4SOBPN8W4BDuRU0cAxbZi0pWKyPnurVvuySB7NIJIspAt4VI5xS
 Hek5t9XIrI7czZaqGpBhobP0AMHi857nKuPT+NlTEPekEMLlyieo9Py7+sLaeSOFEPPCu0oPw
 hRysRJc7JiDcsUr/hL8TZ2skkHqRKyWHJjoXFdhxRWRiGXFn/l48EYDh9VEiSSLNcAxOx7j5N
 HI8VTITrRvrMhbKuR4WrZLa1WIi53xPeQoEUL8877TEjxsp5kmN3Vl8ei1jKgq0CAZHziMiMq
 OffnTdcDy14kvhslGCchLyRK8gPHVy0lfCGBk2lJqdc5qEbxHpnp0aArKcb9jvSEfJZtrw4eJ
 E8tqF8hQXWb3LMiJnUySW5UQf8xeHQpnw==

In userspace, you can add a tid filter by setting
the "task.tid" field for "bpf_iter_link_info".
However, `get_pid_task` when called for the
`BPF_TASK_ITER_TID` type should have been using
`PIDTYPE_PID` (tid) instead of `PIDTYPE_TGID` (pid).

Fixes: f0d74c4da1f0 ("bpf: Parameterize task iterators.")
Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 kernel/bpf/task_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 02aa9db8d796..5af9e130e500 100644
=2D-- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -99,7 +99,7 @@ static struct task_struct *task_seq_get_next(struct bpf_=
iter_seq_task_common *co
 		rcu_read_lock();
 		pid =3D find_pid_ns(common->pid, common->ns);
 		if (pid) {
-			task =3D get_pid_task(pid, PIDTYPE_TGID);
+			task =3D get_pid_task(pid, PIDTYPE_PID);
 			*tid =3D common->pid;
 		}
 		rcu_read_unlock();
=2D-
2.43.5


