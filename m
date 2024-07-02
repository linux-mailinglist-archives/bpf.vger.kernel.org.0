Return-Path: <bpf+bounces-33640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF79240BE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62D9B26131
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB811BA084;
	Tue,  2 Jul 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbYkMNnx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNz2Njn6"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7111BA077
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930351; cv=none; b=BoZEnIk24eL/j8K4SmD/a2IKrPXRXEeG0Xih1B/g8w7PaZkybzZnR2bQwuTBBmW+uft2pxVUWYSGCXIVw4LZzrk7ABSm7vxa+xfjDB8Ag1dosZTUDP4AJB3nK2KBWcxcdNMUGpd2PjIE3SOEKcP3gD8BgALrtShtzZNvOxZMpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930351; c=relaxed/simple;
	bh=zsYl0KUgtaFvsfgr1tiDgBekbmTP/QfKssqLw0hRdF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA9dgnhFG1U8yxSwY4OC/V3fbtV2pZeBN76VlyH/zgVNVj9vDZrmdU0umDL7NwQ3MNr0GSmapRKFTesLcmYJ7mFxcRfCmlq7Ywdv1s/Wr1ucMJC01ZI3vGzj0GzZ8rvXi++Y1h5CS5bMhSD9TBXexXdDDzQD/TnsfhjxApCAr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbYkMNnx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNz2Njn6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719930347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2ckpRualGkPR9ih079iF5SaI8AiCmtArpUdexS/YWg=;
	b=cbYkMNnxPZOmYfkP77wUHjthT4xSr+bK9pBNyI0+XCNbxoXGPy7YIhX4wmxQ902xSJXyhw
	6G9qq15NZZIPXYSyjpOdlr+RzbZRIa3K3tLWCik9CSabJz1R0/Cwa3DVxx5+KhmJlz7zN1
	w34qL77fhNcO7QQohanQfKASoLKfvVTaXNVV6JQxZeo4iKWShYe7iTytPbhmeld95hCcp3
	r8kJEpfCiNq5e9Bk+M9LpfTbR8fKpJon75vJm1tqwDF6ou+PlO17qbytjKfguRYMgBdPtt
	5IFHYeNRA/2DUdjKogrM3AjtReTAZCu7ijE2u+tPj1IYeBwgqNee9AhsPOMc0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719930347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2ckpRualGkPR9ih079iF5SaI8AiCmtArpUdexS/YWg=;
	b=eNz2Njn6rxDHLXdk6aV9t6ghBZ4Fc1ubNMDmWzKwZpbDdi6wIiTtCrl6CArrF/FftMgm50
	GtbcZPDbGrnTHXAA==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 bpf-next 3/3] bpf: Implement bpf_check_basics_ok() as a macro.
Date: Tue,  2 Jul 2024 16:21:43 +0200
Message-ID: <20240702142542.179753-4-bigeasy@linutronix.de>
In-Reply-To: <20240702142542.179753-1-bigeasy@linutronix.de>
References: <20240702142542.179753-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sparse complains about the argument type for filter that is passed to
bpf_check_basics_ok(). There are two users of the function where the
variable is with __user attribute one without. The pointer is only
checked against NULL so there is no access to the content and so no need
for any user-wrapper.

Adding the __user to the declaration doesn't solve anything because
there is one kernel user so it will be wrong again.
Splitting the function in two seems an overkill because the function is
small and simple.

Make a macro based on the function which does not trigger a sparse
warning. The change to a macro and "unsigned int" -> "u16" for `flen'
alters gcc's code generation a bit.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/filter.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3f14c8019f26d..5747533ed5491 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1035,16 +1035,20 @@ static bool chk_code_allowed(u16 code_to_probe)
 	return codes[code_to_probe];
 }
=20
-static bool bpf_check_basics_ok(const struct sock_filter *filter,
-				unsigned int flen)
-{
-	if (filter =3D=3D NULL)
-		return false;
-	if (flen =3D=3D 0 || flen > BPF_MAXINSNS)
-		return false;
-
-	return true;
-}
+ /* macro instead of a function to avoid woring about _filter which might =
be a
+  * user or kernel pointer. It does not matter for the NULL check.
+  */
+#define bpf_check_basics_ok(fprog_filter, fprog_flen)	\
+({							\
+	bool __ret =3D true;				\
+	u16 __flen =3D fprog_flen;			\
+							\
+	if (!(fprog_filter))				\
+		__ret =3D false;				\
+	else if (__flen =3D=3D 0 || __flen > BPF_MAXINSNS)	\
+		__ret =3D false;				\
+	__ret;						\
+})
=20
 /**
  *	bpf_check_classic - verify socket filter code
--=20
2.45.2


