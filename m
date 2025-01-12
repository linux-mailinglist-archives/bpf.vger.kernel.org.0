Return-Path: <bpf+bounces-48643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B290FA0A89B
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B4916752F
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB81AA1C0;
	Sun, 12 Jan 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3WxXL6u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9EF1ABED7;
	Sun, 12 Jan 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681901; cv=none; b=V9v1xsDYSdkrZT4w4PjXEyqvIAiIzLg25fDl/izJKpSPMRpV9oO6Sr+hfxORGrMXjAWqYduMjJ/3Np0sIS9FOMIRXE+AJnr3x7EH59843l89CeIXxDIOhfIb57qCV0HDTCO7wX9CNy+ghpEzzNgVHpHUtp+Od/VoT0JdfIxm6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681901; c=relaxed/simple;
	bh=2ojxKwgn3BFaGLBy+4x4MvB+ljH5A2omqcDIvarA/Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXGRmffuxUMElsUgWVYBNi40YZQFRQWLoejIP4RY5Fta/ukz5BtRB3xjCe1Y4tZNzunSaeJjBcFGrHcINEChXuuNHD1ZXQIrMfn0gAw4czalQzGj6U32ia/VMhIi0j32bcNu4HfxBXVopAb/EuwsKoejskYE2qGm2K8HscIDZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3WxXL6u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216281bc30fso69443915ad.0;
        Sun, 12 Jan 2025 03:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681899; x=1737286699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeN/vKrKCPyqWVUSUJNR8E9aGAUgXYbg1YNcWt8dLR0=;
        b=K3WxXL6ugDHzZEDUllBL8gQDmBslrabMLQUygjLkWnkE19rHK7WUKZ98qL//qoQcen
         l4K5xmX4vnW08O4sos07EdtZMeJoF7inxpDQQE7POI3fyICN7VjBKHmIA94/a7PnaUse
         H2eaZ41qoZf+a99dZqzMLDJb7psc1Wa2gNvExTVJXHs/0Hol5EEpJlg7uSGs0iIQfrCy
         qzPDGMOzf3DDCcY8qy7SZzNeZr7443pQluuVPlbhSL0960OtjjsLqmqOV2YoLIlZewLO
         22hGLLXLGLYb0VnAJkh8iLWYBPqBSrzkYCo7ZlijxP2eq9VzCfK2Hkxf2A2Oh3DKSxwt
         aenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681899; x=1737286699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeN/vKrKCPyqWVUSUJNR8E9aGAUgXYbg1YNcWt8dLR0=;
        b=EmcVt55y6eTvNrZP7BDu85iaQ1vjc7mWWPXgRBOgmOQGMRQxNq3F74HUb5rIO/ATKw
         MdtYmiQzIxR49DUQSG//oATrjXKm3Axw8CMjzp5iQWr7tf2q7nCnjamIM9tPHIIAuSYi
         O/b/WrnJp4BUjC/QFRPDL0yqHVPO9eu7EG1DTPs1Qb/59AIH5Do8CzoGhvZ85i8UDFoH
         G3PdHRTnjI+veEIn+gSsZrW8szB0GpopJral89+sOVZdBBAFlSaBfZum+gJCKzwFHtEN
         R8bRzujpqZxSmT62w8Jinczdxpk58PFm9Z8mYi+A5ePZHRy5sAlfQjDt89I844+2hxEt
         ZJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5cMV9Ux2ZZ9SqHjFYdW9efP/didwuEoc4Hx3HorhCzx1C7IBzbSnopZrfpeExEu58ZcS4KSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jiQVN7GsiHvpulSctmUP3QIznMLzDzKiAPfKY3Q84Q/QPu6t
	L8vuuTgg99TXSo2zQT6tMzPIr1OvvSgxAz1gGxRwRYpTjgXg0Ccw
X-Gm-Gg: ASbGnct5zsWD2oOqf3SlEeYLV3H0Tauoj9swlqe5Vbt99vAfz7H3mLROaOVOz+oFdSX
	kzhWPFHOAX3ToHHTGKjkgHlXK2qxtYZ0eXUcC/Os0bpXyEQoUG9dxliiLabcLJwBGO5S+9VXpYj
	cxNoQiNU2o6iS+2iKJvSvkLJMI2beMdDBq+o3kCS7fhs7Z7Pmj7HdJLWY2axFxFEHE/tN2vFt99
	p+Gcbch3Ohi+IbAzxa+zhym+giN84uiF1oTFaVmZ3W2XDJr0C8IAo9rPfiRcZaS2AGxte88cLex
	YZQk9eJtZrucxz1MMCQ=
X-Google-Smtp-Source: AGHT+IFtxL4EaY3JhkqtySG9y9+g1BhTEfqP1e/DYr6xmJJ+RTuPHN8tpH3BT4cej1gTfOHBhUJrjQ==
X-Received: by 2002:a17:902:e74b:b0:215:5ea2:654b with SMTP id d9443c01a7336-21a83f3eebemr266858895ad.1.1736681899016;
        Sun, 12 Jan 2025 03:38:19 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:18 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v5 04/15] net-timestamp: support SK_BPF_CB_FLAGS only in bpf_sock_ops_setsockopt
Date: Sun, 12 Jan 2025 19:37:37 +0800
Message-Id: <20250112113748.73504-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will allow both TCP and UDP sockets to use this helper to
enable this feature. So let SK_BPF_CB_FLAGS pass the check:
1. skip is_fullsock check
2. skip owned by me check

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1ac996ec5e0f..0e915268db5f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5507,12 +5507,9 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 					      KERNEL_SOCKPTR(optval), *optlen);
 }
 
-static int __bpf_setsockopt(struct sock *sk, int level, int optname,
-			    char *optval, int optlen)
+static int ___bpf_setsockopt(struct sock *sk, int level, int optname,
+			     char *optval, int optlen)
 {
-	if (!sk_fullsock(sk))
-		return -EINVAL;
-
 	if (level == SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
@@ -5525,6 +5522,15 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 	return -EINVAL;
 }
 
+static int __bpf_setsockopt(struct sock *sk, int level, int optname,
+			    char *optval, int optlen)
+{
+	if (!sk_fullsock(sk))
+		return -EINVAL;
+
+	return ___bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
@@ -5675,7 +5681,16 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
-	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
+	struct sock *sk = bpf_sock->sk;
+
+	if (optname != SK_BPF_CB_FLAGS) {
+		if (sk_fullsock(sk))
+			sock_owned_by_me(sk);
+		else if (optname != SK_BPF_CB_FLAGS)
+			return -EINVAL;
+	}
+
+	return ___bpf_setsockopt(sk, level, optname, optval, optlen);
 }
 
 static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
-- 
2.43.5


