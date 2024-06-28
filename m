Return-Path: <bpf+bounces-33337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736691BA5E
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9206284447
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1635C14E2CB;
	Fri, 28 Jun 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1O2U+3pY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjVylIi9"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B714B96F
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564546; cv=none; b=PnqgJLaLQ1/LPKKTsQgQ7OviVrIQkwCaYIRTmL/r3Mcw1RRU5T94Y96/o8w0zuTDt49mg5a9oaZ0+cdEjjf6UQM42EMGT3ncFuQvDsW4w/kwupqu7pQCKKuwuMJ5JCgTLCzQd9Rp3cog8PfswS8cr/PXQzon3VzEImuBOrq0oNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564546; c=relaxed/simple;
	bh=MFo3CJUMjfzzSqAXEUbXuEDeMF7DaLrx+fnjBX+zwQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oxwhhe8wALhQ+m5PrWcOhsjSN5PBPHvoW62EeEI22+9dX0swinc4E+sY0nWLS1Beloet1GDDXIoeh3/iFMD7ItTK5znBy9BHe9Bko7QARkhc1RCKcDJSYhN7GChD3suB2RAg906VURdQFHVBI55LfbnyMu8Ufqkz2nojcW/b8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1O2U+3pY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjVylIi9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719564542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6Nra70WiqjDzMNgjpIPCKOgbH+ZimhecuOESN4J+fQ=;
	b=1O2U+3pYFRMYvLzM5k5nGvbwdOf5fnolPT7LleuzV+4msDPBP2gSSpv990q0qUV7AaATcc
	4sNh9tWa0q5YS6ljel6hcfA7fXDeKmadO6TG5RG9KXqHirSGNiR9OsIQxfbSi2sxWkfLVl
	ANg/bvKdBQcAF+oQplkThjJTYbtqXuPJ9GvK0+UZPbfPDnUDB1sP6jZr6DN4lbFzVuxPZ1
	i2Bd52OFprTtiBTgbhscGJcewsA7NZM3ab6N43+HDXsRxOu6POcEFY48SAEeJAMFxSxJC2
	g877FDssDdAJyHrv4n8wBhGluIQIY/wHyy39VCrpuep7m6ScMu4Xm//sOHjl8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719564542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6Nra70WiqjDzMNgjpIPCKOgbH+ZimhecuOESN4J+fQ=;
	b=XjVylIi9/VKcCCLs4X0e1MPXxMQdpmXEPHfcAi+e+7OTvD5v/d29z36LlbxFbfdve0g4PB
	5tJsbBp8U0GU3jAQ==
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
Subject: [PATCH bpf-next 3/3] bpf: Implement bpf_check_basics_ok() as a macro.
Date: Fri, 28 Jun 2024 10:41:01 +0200
Message-ID: <20240628084857.1719108-4-bigeasy@linutronix.de>
In-Reply-To: <20240628084857.1719108-1-bigeasy@linutronix.de>
References: <20240628084857.1719108-1-bigeasy@linutronix.de>
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
index 11939971f3c6a..72ccce80f9f15 100644
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
+	bool __ret_ =3D true;				\
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


