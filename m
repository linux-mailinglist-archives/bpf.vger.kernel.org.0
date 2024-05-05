Return-Path: <bpf+bounces-28588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FAB8BBF0A
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC49AB2129B
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837215A8;
	Sun,  5 May 2024 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzR1SSdR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F617C2;
	Sun,  5 May 2024 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714873797; cv=none; b=b6RlICUDwYQW2gF9RHmwKZWhGBR/mS5G6/4BnHLhlr9LxbVV2D82Hq8ZPG6pfepF0vMvDmojM7GZeI4bwGxsHsTRd0XKGp/sGgNnRwTYwnwC57XZENikidJK0MBYS0wcvY8k/VipEKXoYXOoDKKiAm2eu+c0y1NBwm5Ndq7eSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714873797; c=relaxed/simple;
	bh=gwS7SvCCQzpLEKN5XmF5rDHidC1WX6HSiHlxk5j+Kdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDPFLl9MYhVRphuDG6yudqiW7teFJA34gO1fZbrwwiRK5PasfHxeNXDrMOfTFHoNRfBCsDH8LuZ9S2syBXfNLAZK72TXZLP0J1yPCMNGpsQ5M40oVFK5byZX1c5GS20MR4+BivBzZoGoUFszhg2Ej/X4ZAzHWLi4FbaQoKWPS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzR1SSdR; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f0307322d5so263796a34.0;
        Sat, 04 May 2024 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714873794; x=1715478594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKURNdYPj7HMqSPgV0Iuf+l9Ve2ja713YdXS96CYBIo=;
        b=kzR1SSdR7R6/s2njsZ19/4W7FT2FjEJx8YNhWCbVyRxjABJaLmeawZy3iQy153ry/o
         jmmFqOIsjVKoQ1sRBx2FQ7WdapNHO16I3sfIuLNMKNjv424Ak97kFrX7gbhcwMNhu8i+
         gc6SMygpHKzne/Z/8GenPouA6GEZzXzkzAhOe0FWFrZQFw8PoWsCDLKYoxLf/rnmbhxD
         Yr2BO7zUV/HWdTnjAk5sAMoFFwgfKQKtLYJDqO9CGmDBEWL/QIEnsZFdPx6Teb1rXTVE
         X4+oagI6Kw2BN1NBB/E+xwOD/DRju2+vOKfF8zNmzRRHluePqlu2s5f9piywxGfiMybG
         nN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714873794; x=1715478594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKURNdYPj7HMqSPgV0Iuf+l9Ve2ja713YdXS96CYBIo=;
        b=Jw6RFVjRSnJ+4gBOccDZVBCPzix05Jcl7cIGktwXIyyU4u2vubsXMMCeMDt9aSZQDq
         yIfzP2sFB/xgx0zt1Yn7fID+gLUucukWi5+UhUZiVlPJxz/mmGSWfjl5Bjn2abmTh61D
         xD58JQx0irvi+xeCrA05BoNcQxrrnBKz9UWfQw7K2nbxU0FKm3EoKKFlVvZYqAKbXJ/F
         KE/DhNgRz8FIXzmTHz62yxumbJwUhOHKAV4BI3Jo0RZO0FZCqjGXR4NzeV23HzAX/ydh
         XQDsXdjDNLIbTk+PiLbRPFnHpoNjYicuYFFE9vB90pRsTKylv0v9kMcepdBe7FEGwsJg
         0f3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiEeuTZRrKA+U+Pn+w1nk57BCRNCmLNeKl5+Mcp1VGmxJe75um3nQfTfGX0K6+NDyoZf8XwfZFb5aTRGsgHST9oWfsTcCH9D4GPmpa
X-Gm-Message-State: AOJu0YzPf57Rjk5i4jurxzGD9rZBiKuklA+FjhiH8XkVUQ6nc5GpEe6E
	6utK76EUB5XtkDFKnEkJY/sDYT5QYOAQH434Nu6n7jKCkdekP5fv/2kpcEZE
X-Google-Smtp-Source: AGHT+IFC7+Y8m5ihDjkRKe7ei7TaJn3CEK9M1rcC9r9JFAJrNyCDbzo3sH5V7Mmxcwyy/AA+KhuzmQ==
X-Received: by 2002:a05:6830:1314:b0:6ee:405b:5220 with SMTP id p20-20020a056830131400b006ee405b5220mr7390613otq.19.1714873794678;
        Sat, 04 May 2024 18:49:54 -0700 (PDT)
Received: from localhost.localdomain ([190.196.101.184])
        by smtp.gmail.com with ESMTPSA id h64-20020a638343000000b0061a943e043fsm5070536pge.80.2024.05.04.18.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 18:49:54 -0700 (PDT)
From: Camila Alvarez <cam.alvarez.i@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Camila Alvarez <cam.alvarez.i@gmail.com>,
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Subject: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
Date: Sat,  4 May 2024 21:46:43 -0400
Message-Id: <20240505014641.203643-1-cam.alvarez.i@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error indicates that the verifier is letting through a program with
a stack depth bigger than 512.

This is due to the verifier not checking the stack depth after
instruction rewrites are perfomed. For example, the MAY_GOTO instruction
adds 8 bytes to the stack, which means that if the stack at the moment
was already 512 bytes it would overflow after rewriting the instruction.

The fix involves adding a stack depth check after all instruction
rewrites are performed.

Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..a9e23b6b8e8f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21285,6 +21285,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = do_misc_fixups(env);
 
+        /* max stack depth verification must be done after rewrites as well */
+        if (ret == 0)
+                ret = check_max_stack_depth(env);
+
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
 	 */
-- 
2.34.1


