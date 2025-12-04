Return-Path: <bpf+bounces-76044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D31ACA3B24
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 14:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 869BA308D01D
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D33E33F8CC;
	Thu,  4 Dec 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhAKJztP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8iPtYBp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345033ADBF
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853169; cv=none; b=vFY4EOvcY7dc5jh5w9QWDFvzVN8E1kUMa5+bx1+szF0PTTksTaVJxjC3yyYbWB3Bk4lIlYzDZx+eyMa/TEkaTRjtTSm7h9qHlebxRYv1zie0dNllz1VIQokre6RqFvCKheHvowSGnO5KrhJGCruZs/AlROcTCA109D/8x4AljV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853169; c=relaxed/simple;
	bh=hDClTYUke+S3lw1Dam2zNOlSPw5NHSqYQafCDHsN8xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhJA4zRBhFLKgyIfakGAN24ALkY/4wQSVtDcJp5eRlkiwjroHQYtHNWgIU4Ttbi1/UhTEf3EYzxJi04LEnZoVHQVuppOHwZVwgFdY+Rm4gs9EXmp7Td7XEKUkAuht3UTHPGCn0FBQbOHeiU48Q5hDl1AhYWdTS38fa9GdVBeeIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhAKJztP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8iPtYBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764853166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
	b=UhAKJztPIQeGR0lnvjdIokMe1UYBcTGfWNt6qlqqxB+ENDyNWBM+T9hHsEaqQLD4fcQlNm
	DGnCcro7OQh4abribzqfHjJ1y+YKO1m1bdHXuGgpxoy9Ij5LgVFNqzEUFuDdnEw0JCbxOb
	6XV4rFyLHGwDhco5PgbgBt/MPFa4UMg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-X0pdCFaGO561XeqL3UGMhw-1; Thu, 04 Dec 2025 07:59:20 -0500
X-MC-Unique: X0pdCFaGO561XeqL3UGMhw-1
X-Mimecast-MFC-AGG-ID: X0pdCFaGO561XeqL3UGMhw_1764853159
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64160e4d78eso995084a12.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764853159; x=1765457959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
        b=D8iPtYBpjNJULRB4s77sruEUD6TjR2CmpPwbfoKrXcUEI+GTSftnR8vCQSdQgYFlSi
         0oA+g4H/LNGHj+lmrEAt2VRPVJ5iNiKCyIwXrU4cquidBU9aPxasM1iMNlx5g8Kz9919
         oXiaQaUA5Z6gFubXx/1Kjom/j3MPAi9cCj4YDzqurNEMrV160fIesESfKvsIZlhTyM1c
         K7JXh//jBD+xXZD8AzlijbZ0xeqagbXzZYLw9Sq1tIm6Yga0Tde5bmts6H12WV9b7zyk
         7JHyqkmrT49SPZc7MRTaIuonFJbxVv3BEhFbwja4rsKwt66sleKpydWsDFfXQWTZTGpV
         Wraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764853159; x=1765457959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
        b=fH0JDsnSFvrgvk6SB7kOTIGkC5a9ma1iTwRzlZdujBY8UOBP9+GsonGcC7Eu0WwjFL
         cFATxu4kIPf+6lBTSliU8otJhmx5ml0tJUAZsEwXlgA3PezOwk21wCwr8VWO6pHZvZkd
         EuVyhErrTyJ3GjBEZdjeb4nXQO6ZY81wVhla+IeCVDEPA+5EEkjSu770C4BFtovBSbkd
         hBPhr48qPTtrZRLLSQY+S6GHdSSd0NvhZCLtcFu7/XOEo1sgOzO5lCVdaxt0hiurVsnc
         JmDEkS/8dNA+gpUFdxjy1Iqv2V9Qk93quM2odWtaKXZIcmqVUUSiQPbtPUO2MH9ReDyw
         hxYw==
X-Gm-Message-State: AOJu0YwMokXoP9if2AACI7px/C4f5/PVH81LOoEgTAe0DEwH1k2pEj6/
	Al0G3ciruzxOOzSHgSiOku3bi9rkgrFlM/2vL76eYbL8lBKZRYKAawOfE+U3GUsOyO7qq/clI6e
	ktJtMmavD44MgUpT8BHkRVXMNJ9/Ls5fdc/4uZ/hkJ7qyN5hazBvERg==
X-Gm-Gg: ASbGncu7A7N46ZOR6sXDuj0p8ttXZxkbEdqVzyu//di6OHB2ljBFtlZfFN1O+n4v5Mp
	wiSI/oyiWU5JHUP0dCS23gfHCt8cV3Sr1S4GU5uuZvuNniwMN+2ZSz2R2NGSdL5N5LFvUeieNVj
	rfP+0YOoLZ6d2yrK8onhwzjJPAtmeQu0sih3f0vXeacWjBdsdRCMBDnXwP2nBEZYJLzW8RAyJmU
	/9JToLXJoyXS0dkV9pTadYirH0WT/z3QX5QHnTumDN3G5JfpzMsKtsmZvd+20zK9cuwpm/PwQTU
	tekNCV05kH6sYcLiSbitrvhiuNFRKQFU8PxC7mFjHF+u9KO7Os10XVldc4JIywB30yyfRwWXe1n
	BuRCjUQ==
X-Received: by 2002:a05:6402:274b:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-647abdd3177mr2458536a12.18.1764853159328;
        Thu, 04 Dec 2025 04:59:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpIWeVg+u1yy1Z+F+69TkiJ/5ziYNykTKxahwDIMAG7zZcbakM3dgVe2ZnEUxhIOcGKQFi7Q==
X-Received: by 2002:a05:6402:274b:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-647abdd3177mr2458514a12.18.1764853158907;
        Thu, 04 Dec 2025 04:59:18 -0800 (PST)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec319csm1251929a12.3.2025.12.04.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 04:59:18 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH] bpf, arm64: Do not audit capability check in do_jit()
Date: Thu,  4 Dec 2025 13:59:16 +0100
Message-ID: <20251204125916.441021-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analogically to the x86 commit 881a9c9cb785 ("bpf: Do not audit
capability check in do_jit()"), change the capable() call to
ns_capable_noaudit() in order to avoid spurious SELinux denials in audit
log.

The commit log from that commit applies here as well:
"""
The failure of this check only results in a security mitigation being
applied, slightly affecting performance of the compiled BPF program. It
doesn't result in a failed syscall, an thus auditing a failed LSM
permission check for it is unwanted. For example with SELinux, it causes
a denial to be reported for confined processes running as root, which
tends to be flagged as a problem to be fixed in the policy. Yet
dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
desirable, as it would allow/silence also other checks - either going
against the principle of least privilege or making debugging potentially
harder.

Fix it by changing it from capable() to ns_capable_noaudit(), which
instructs the LSMs to not audit the resulting denials.
"""

Fixes: f300769ead03 ("arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index afd05b41ea9e6..5823f2df204d9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1004,7 +1004,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
 		return;
 
-	if (capable(CAP_SYS_ADMIN))
+	if (ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
 		return;
 
 	if (supports_clearbhb(SCOPE_SYSTEM)) {
-- 
2.52.0


