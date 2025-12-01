Return-Path: <bpf+bounces-75801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A8C973C8
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 13:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87DC74E1B56
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ADF30CDAF;
	Mon,  1 Dec 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Yr+kGOje"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D930CD86
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591868; cv=none; b=DMDGwtOC5v3107JMAhC4I+xlDTP9APT5yaw/rA++p4iqaWk/XK9fCL4b04IfLIH636giK47orhsTWiYJVQKpPkXhVCaPtZFMapMyjNOZImCUN0ruKdlQjxZPTW2aBfs3NBTbt1fAH1jg7z09FVE6dOwL5NlErmn34eP36You0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591868; c=relaxed/simple;
	bh=ROqAT17lsLKq+OAD8klz4rtDlUC6I1DaK48+5JEk5XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbGy9MmX79oSOk/4zzKJMm7rxAXNIUiLvHjH6inho6gtcDKVRkw7Nau7XeLoTpK9BMMSWlzQYsk4hshuOpYQjS8M5sIMzovkK1UZilKTiOkzEBjdARONkMvdYKQtRiLfpfKDq4BqvpzQjRTug8NK8ZZajscUfh3r8TlBR+rKwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Yr+kGOje; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4565C3F078
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764591863;
	bh=uDGFNs0dlemtVhhnPYk5y/JrXd8r2GFrUs0Gv8oHyF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Yr+kGOjelw+t6zr4Cxa0zFmMD40IwQD0mhOfpqcsqsH+3JhykyDVPrWendBVvkEcJ
	 1TKevjJnJZwnLQiM6gNqwH2nLVjb+ZARKbHcKQh+alEJsY3pwLMwaKcU3mZT4USx7o
	 +mnQKT1z507z+ohosPd4mwPbyeinFYkZeuHgk3giHbOe2hf/d36HXLGDj1b4QvTMrx
	 sZhGfjGQcywGelQlsVuapOjqaw/RXICkIQpX6RvYHGf1aaHpZ6HvLvt4DSV2klbvUE
	 Tt+hJc9oZIW+EfmgmVEebNSGuFtbeCvDy9lXfIkLkTPqEf/pyrRVuGUQMhhvF2YVUw
	 PR02D7bEIe3Vgbo+9R6/0koQgxlH/s7489jgoqlGfJNe+txpfSFxMBKA7DABMYz87z
	 BCWldMZND1VZ5GUHEQn/G0Cx1BPKrf7EHH5torivLSIRi1vcQOsljTSl7F1KIGz9Xb
	 pEYREsmg+9dLh7puMbUfcwnucKBRlztGdY7ELUs+N/llrwBwNKaFyjbgUQKXP1WXJv
	 tkoNk3udgx9az9GvkAA5LUji271yALuy0wFsfZb7u82+KkVXaMI76wqcAd+D55hyzO
	 HZIt5gbSqHRDR3DgvJ1ngQqR82LwEYxpQPZPguVaA/DrT439KlEwOcgh56u5636E9g
	 Kggj7v94UTCueFDAwFL1dLM8=
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6409849320cso9220035a12.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 04:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591862; x=1765196662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uDGFNs0dlemtVhhnPYk5y/JrXd8r2GFrUs0Gv8oHyF8=;
        b=mlIE0GfmSdnIcxuDttcqRkSRvBqFsFyheHJ72SkHcvc+nDW+tYFhqiXFcjI+n7AYIl
         5Hy2VRfjaG2CkZmhGcayYQcL1726uM3dtLDtRstI6TfVAaue2tybW5CEdmJCKtoJNgS0
         hqXiW95eyjHy3ZVcWkNHWunqAf2hrTWB2wHhkMqWmMI3nG5X9TvQZdhlVr/mklL8Mx4P
         m5v814FDAfv30buFiuz9YnNz8rSkBlKBqvC3gHmKrzuHeWqp07TAI3ktLNxcofp8M3jc
         Dv9JxlRKzO/Qgvou/sA8FHXyQeSayoMKPEf8JipdVmsCAGvgCNu0XYm+I40gKERDBuqj
         txyw==
X-Forwarded-Encrypted: i=1; AJvYcCXBlxqDzmG7EIxu/mlGichDC8FTjWirKLzGJqYHRePi+KJyvBSVvRa3ECAxhNSmNs+3Duc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4eDupwWoXICqiawZAJ5sxQ8uysb0kwFy42dGbARZmmPHfPxs
	X+JUGWg41y39qki01FXQCbCFcFjIx5c0Anuxyf/PY1HkWp4mCyvJbYcuJ9h1fxXNyJoxAlHxhzR
	nNAR3SxXehZ4dQCFMbjdcPVuPOqL+FWMHFw2YOenH+taLnqtoWqrQuHd75w8Yp0266n9zCg==
X-Gm-Gg: ASbGnct1+IcOGIlOEHo5JvYInjrG+ymKjg7oIBOE5NxuG//ITZnAtkIg0H0j1sii38p
	ttl+c+CeX4DQ+dnhKe1C6vfPq7gTSSl+xcCLkcIwOuz+7tPTUAF/59KXGinM+qAdz2rru8MafDe
	qkrWjLTMQmQyZghY0I9K/vxhl4Ezp3Ou/9aOUiYGTS6ecdHATBXm5OCACFXb1I3oUPE6FIg32CV
	sqaIdnio/86L/XZhp7gYFvNTTTgyF69tVCWantxgONU5zJTddZ0naQDmBmq7iWgbzkjAHHBO82N
	6WFAm+5Q7WDCeu103H95UIRgGLlVj27DkErXRvmQHW3LaewFeKHkb18mTVreqN7KFJd790T8qj4
	OrnidCcVHidiGO8mEDYQU6tNk+g2PLhA41rJypCqVntzPxbynQdUIdq2n9FIG/T0CralvpXHemR
	LgKEXXlvS8XQ7pI/RUZ9ci++za
X-Received: by 2002:aa7:c6d7:0:b0:644:fc07:2d08 with SMTP id 4fb4d7f45d1cf-6453962437fmr30760791a12.2.1764591861620;
        Mon, 01 Dec 2025 04:24:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjhzLfnzC1QhpwNYy2/mmU1w8pIZLfn1RzCuX2/F7919eyjEsj04ZLXWi2Vg7y70ykH7tP6A==
X-Received: by 2002:aa7:c6d7:0:b0:644:fc07:2d08 with SMTP id 4fb4d7f45d1cf-6453962437fmr30760747a12.2.1764591861218;
        Mon, 01 Dec 2025 04:24:21 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5749de007c66abd95f8bdeba.dip0.t-ipconnect.de. [2003:cf:5749:de00:7c66:abd9:5f8b:deba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6ea36sm12307884a12.2.2025.12.01.04.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:24:20 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 3/6] seccomp: limit number of listeners in seccomp tree
Date: Mon,  1 Dec 2025 13:24:00 +0100
Message-ID: <20251201122406.105045-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We need to limit number of listeners in seccomp tree to
MAX_LISTENERS_PER_PATH, because we don't want to use dynamic
memory allocations in a very hot __seccomp_filter() function
and we use preallocated static array on the stack.

Also, let's return ELOOP to userspace if it attempts to install
more than MAX_LISTENERS_PER_PATH listeners, instead of ENOMEM as
we do when userspace hits the limit of cBPF instructions.
This will make uAPI a bit more convenient.

Notice, that has_duplicate_listener() check is still in place, so this
change is a preparational.

Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 kernel/seccomp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index c9a1062a53bd..ded3f6a6430b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -931,17 +931,25 @@ static long seccomp_attach_filter(unsigned int flags,
 				  struct seccomp_filter *filter)
 {
 	unsigned long total_insns;
+	unsigned char total_listeners;
 	struct seccomp_filter *walker;
 
 	assert_spin_locked(&current->sighand->siglock);
 
-	/* Validate resulting filter length. */
+	/* Validate resulting filter length and number of nested listeners. */
 	total_insns = filter->prog->len;
-	for (walker = current->seccomp.filter; walker; walker = walker->prev)
+	total_listeners = filter->notif ? 1 : 0;
+	for (walker = current->seccomp.filter; walker; walker = walker->prev) {
 		total_insns += walker->prog->len + 4;  /* 4 instr penalty */
+		total_listeners += walker->notif ? 1 : 0;
+	}
+
 	if (total_insns > MAX_INSNS_PER_PATH)
 		return -ENOMEM;
 
+	if (total_listeners > MAX_LISTENERS_PER_PATH)
+		return -ELOOP;
+
 	/* If thread sync has been requested, check that it is possible. */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
 		int ret;
-- 
2.43.0


