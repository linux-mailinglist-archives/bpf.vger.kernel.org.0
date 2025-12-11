Return-Path: <bpf+bounces-76467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 079E7CB5ECE
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B79A2301D32A
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3D311973;
	Thu, 11 Dec 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZVOFAA6s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CA311C07
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457216; cv=none; b=UtvLlpor/UXhWBVXl3t2ZMfRxfjW5lnj7hvMFu1V/F6oVAyykNICo8cWiAo5zXY7/IHtJ8DTD6oxmrh/OcRwByv9Zfv7xmlw18vahLEBsLndf8FssEXWS1KqIPWmJCtwweMg6TYnIK4Jc5h4k3OBILZtwxHpAp5OBvb/2dtlYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457216; c=relaxed/simple;
	bh=M8eRqkgPgBxM8ofhzKDpQ/IEnkN/a4YJtGuQ31KbvR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2Z9IAvR/+uHOoBWOGqby8RwzrRecwXrUixkaE6qUt/QSEIlMR/bBQi/hKOJuqqKitP79BagA3mFKxhbWYmt2vPNCEI/S+s3Ss6LwXFIIrpnLX/lKOvlfGxRm6TECb5Eg1TRy11g7wA1wnn/NefNQ071bUJ34/MIQZO9KbknKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZVOFAA6s; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 76C783F7C1
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765457204;
	bh=+VWHdEQoNsPgcwFXeNNGXSus+9dIrvpb6PWtF/9Odxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=ZVOFAA6sexLl6RyMIKZfxr0b+E28N4MJkwidDRgOqP4SgpAxfWytwniJBeKYcyYUo
	 uZEhHsEC3KF3bssbMc7FpSBSgIDoGb+khR8bmV2wAbCNowLg5RYlF63ZsfycOLXR7F
	 x9BLpzjD8VfY5XJHLUIlMlb8B4KiSOxh8jHqCvjuMxGw5juaMe7FytsuWcP1G+/myi
	 SKuB8v4LBk/QV0hppH/2fsnhe2282JzJfRuO+yUBihimxb/Pt1cTU/WlWIaABcYd/N
	 V8f3tfgw0gljAeskXjuTOAo+7bpXuhZaHrYek2+/18o0t8IkAKIoJXpO1VwSEGP7RB
	 TDCKhL/GlfG0hk+nnRiDvMMgTwzpmrzb8pE2p5GbztWdxceKckRLC7VnCde3LoPusR
	 vcqyMI8FKYy6i3u65E5a0llvGrkZr0/6NeCR/05Rm9K5OSyV54IDLV5kqMUtY+8PNM
	 ZZsgzTWmprGSzb+onQnL5LcUURxE4eE4ecbF+aiPzecUIcw/L3IkhJzKUgXOkdfwHm
	 c/cRDaV26hjRcVeuP8Hey5rLUAX9hfapZSARPE1ZjZQvnPETvG95PAmu3m8rO96PMO
	 uBJqkz0YUSpbib5m7fTgjXFHhx9ADU/jshh984zqIhRfHGvVMT0iH3Oo3LlMNCNhpX
	 hAEjuPepkGhYyuE8YumjqeIQ=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779981523fso445395e9.2
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 04:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457198; x=1766061998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+VWHdEQoNsPgcwFXeNNGXSus+9dIrvpb6PWtF/9Odxg=;
        b=C8U9vKSBIiFgkBVfWyWURg1ZDjJ21wJgW5tbzCH/PEnylwIwtVJnmgeQCOoAVyzIeq
         u07Oarfm8TjWIsv0rABcDIDvOJgUxgyfMgBRQDXNoJqhw3ubXdfi6DqXFnXvxlWj9rHQ
         K0TneefcvobMb/++uHfYWhOqEZ5nScMxa7kL7MIiqac93wntSTiKx9/pfiPcoVTUktkc
         6/eXV2vqJVcya5lRoq4kXqsz3Z0P401nj/sjZZYNP5KN5/cng2SGLwpriIR4PRm8mq1d
         OkjMgVUirN97mFaOb3/4Pbl6WMV7cvVYS84AzQtKg8OFZLxelV+hjtwAs/EPj0i+ob1K
         pneA==
X-Forwarded-Encrypted: i=1; AJvYcCV/YqWadEGRof5wRmVuN9f8LhBi4Bu5h2PeJwGa3P7XWG02kME9VYO+ephll5SOsey1hgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDocuuQKb5jLJI+V7Wn467BrYV7Y81qJKr+dmH804Lb5DGEYR
	u/32Ai0Wxno0EN3WVHPuISZ8PeCfONDWckBHvgaS0NEwdz1dJozp3ffo7a4U1CjawBNlj8LWtF6
	T6QZVsR5M+bIxiRzOXNrXl9IsDeBygvm/Zh5gf7lCEPKDz1DeqlftpjfSSt3EVyadLQnmzg==
X-Gm-Gg: AY/fxX512hYDt/gpvs67bWfxFx40U0lZ1L8OdMTie+K+WutuDr5c+rIvqrOk7+N1R79
	yIRRYE5vxhFGjIEiaRJv6dyVp1SbkFBdHq3nWJtNElKHwFBu3cpqktMr4th3FsNEk8FIky+w/3y
	z20lw5hYeeRuQrUYPNWZbaAtqWJFQX4mW33VJszGCLBephbTgeeur9u0nlfZTObFXIzKlwx53eO
	EyjZq28PYvc6JO9BbmaqNrFBX3FDVw0c7acH5l3VlDbJ826EHeOqrdUV94UvaLxFwFvSxrgkYe8
	kXmd6ZHhYDDXw4fwmBtC0useH9RsMA4+8Ro9KMW1DnH64ZRad05vu4fbkqAYrIEC+PIq1RRRfkK
	EP/dVon+1FfXifsXAhov/Hg8ZH2jmJDhoR5ahB4AC34/MOc6zzrw8g2kqsK7ailobvnzmJF+oU9
	SQNPVjxf3oWjYaFdNbRlUUhRY=
X-Received: by 2002:a05:600c:8b73:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47a8379c99bmr57493625e9.32.1765457197842;
        Thu, 11 Dec 2025 04:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW5OJd4vXzfsiWREO4WnOPxV8GVFlOiBDlk4Bt0lWdwH50jp6/D3VvS3x72AqyIflrh1rrcA==
X-Received: by 2002:a05:600c:8b73:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47a8379c99bmr57493275e9.32.1765457197424;
        Thu, 11 Dec 2025 04:46:37 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf57022000e6219d5798620e30.dip0.t-ipconnect.de. [2003:cf:5702:2000:e621:9d57:9862:e30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f0d6f2sm32075905e9.13.2025.12.11.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:46:37 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v3 5/7] seccomp: handle multiple listeners case
Date: Thu, 11 Dec 2025 13:46:09 +0100
Message-ID: <20251211124614.161900-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we have more than one listener in the tree and lower listener
wants us to continue syscall (SECCOMP_USER_NOTIF_FLAG_CONTINUE)
we must consult with upper listeners first, otherwise it is a
clear seccomp restrictions bypass scenario.

Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 kernel/seccomp.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1a139f9ef39b..51d0d8adaffb 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1268,6 +1268,69 @@ static int seccomp_do_user_notification(struct seccomp_filter *match,
 	return -1;
 }
 
+/**
+ * seccomp_do_user_notifications - sends seccomp notifications to the userspace
+ * taking into account multiple filters with listeners.
+ * @match: seccomp filter we are notifying first
+ * @sd: seccomp data (syscall_nr, args, etc) to be passed to the userspace listener
+ *
+ * Returns
+ *   - -1 on success if userspace provided a reply for the syscall,
+ *   - -1 on interrupted wait,
+ *   - 0  on success if userspace requested to continue the syscall
+ */
+static int seccomp_do_user_notifications(struct seccomp_filter *f,
+					 const struct seccomp_data *sd)
+{
+	if (seccomp_do_user_notification(f, sd))
+		goto syscall_skip;
+
+	/*
+	 * This check is needed to keep an old behavior where the first
+	 * (and only) listener decides what to do with the syscall.
+	 * Note, that even if some of the upper-level filters have
+	 * returned SECCOMP_RET_USER_NOTIF (but have no listener fd!),
+	 * we must ignore them in this case.
+	 * This is how it worked before nested listeners were introduced.
+	 */
+	if (f->first_listener)
+		goto syscall_continue;
+
+	/*
+	 * If userspace wants us to skip this syscall, do so.
+	 * But if userspace wants to continue syscall, we
+	 * must consult with the upper-level filters listeners
+	 * and act accordingly.
+	 */
+	for (f = f->prev; f; f = f->prev) {
+		u32 cur_ret;
+
+		/*
+		 * We only interested in listeners, no matter if notify fd
+		 * is closed or not.
+		 */
+		if (!f->notif)
+			continue;
+
+		cur_ret = bpf_prog_run_pin_on_cpu(f->prog, sd);
+		if (ACTION_ONLY(cur_ret) != SECCOMP_RET_USER_NOTIF)
+			continue;
+
+		if (seccomp_do_user_notification(f, sd))
+			goto syscall_skip;
+
+		if (f->first_listener)
+			break;
+	}
+
+syscall_continue:
+	/* continue syscall */
+	return 0;
+
+syscall_skip:
+	return -1;
+}
+
 static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
@@ -1347,7 +1410,7 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		return 0;
 
 	case SECCOMP_RET_USER_NOTIF:
-		if (seccomp_do_user_notification(match, &sd))
+		if (seccomp_do_user_notifications(match, &sd))
 			goto skip;
 
 		return 0;
-- 
2.43.0


