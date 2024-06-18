Return-Path: <bpf+bounces-32426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C90590DBD3
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 20:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A314F1C22561
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5855015ECD7;
	Tue, 18 Jun 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSxgv6aS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1D13B5B8
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736148; cv=none; b=cP/NJ7VW0e9FQPK2YluV5cOqy2masBd1kbskngRiIfRIhHU71Fw1Lr8rxamyk3qaRG5IbJFv+a6BVK7isCNmDqFOKTYXriiZ8G+GdJzEpOLQnyomkRMUHDlHCBeNlV/VkdLqVVDbjAWrMttCvmzbPbZhjKPSRTO+2jRx6QW2Gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736148; c=relaxed/simple;
	bh=NtIOOR44Djq5nsVGGxJiZjqIjCYad8tjuRWdONxVSwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aHaxspuRZYsmvJmj8dOvf8ikcF10lYHrNS/A8isOCzxuM1USI19k+3D1zdcP03V0xUen1aRn2ec7kgQAARUU5Efy04+xVYYePlptQIeEL7mlN1zdBjptKu16+Efb+VxR3PJ8iR5TZcUqaJydBvy0nbdVuVTmFhWWJwSGU9q8v88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSxgv6aS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b45d6abso43832705ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718736146; x=1719340946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0EAfxhLEA1RcY6zFsf730SHaD3jFbPJy/SorAIdLtI=;
        b=WSxgv6aSv9NsCDCk8X7moh9qR9svL8wutCaAY8yBfQeyYqfTyOKmKuzM+jlO8M0y6k
         YP0Q5WeaEzT1YkWuHg1/ULxDGQ7EG7LTeRXq6DmlF4KO3cicZLL+ZvCBtn9ncNWoCydb
         geHgKnefjXiGfg7WgDfPjvm6ipfl0yqQv0+n9LlvPEM64HaTnQjKcCPjY+qLwPBOHNtv
         lZJg6LXiA/4AnuTmR3+GU8QeZKhDywNPwWeAEYHo9/ywMR/li0beGb1kulMEipScLuyH
         CIuDk98TAzXAhEfh3ChYQvW5YT83ucfzEXhkfHPFIntRYsbFvk8r6B7q6RdGr820DxAQ
         eNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736146; x=1719340946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0EAfxhLEA1RcY6zFsf730SHaD3jFbPJy/SorAIdLtI=;
        b=JwOumKqk7X+Tay/dHI6N2vWaSC1t9lTpPxWu76BhONMYlFKEr1eIFyJZtxgpEgnxFO
         A8u+UEOzlCgstp+xBlC7PSnSLSIhgX0ugjyM+vCT+u2Kr6vjnN3FGhP2Y0Xqd73K73G2
         IPD6WNxo66p7O6coAzTOPWASDR8h7+nCw+LCRKfn0vy92lxYI5nMPstsMTNAfuBWfdrm
         berJQkjuEXid09ruQV8Rt1ReXLmUOZoEr6LfQUkXz6fRlzvm0xZyDo+G4YdkpY5qqR/I
         8qZXdMFQvD2oz5WmVlpMItwQF+RYd0VHwviL496FEch66PvKODNdj2Nvdxx1y1Xb6O5L
         7VkA==
X-Gm-Message-State: AOJu0YxcPKnMfb3yhplswyGW/p0qqj2F7PJvrQ5nAd52lGYkeWWU5eVg
	OhldDa2kVwMUYe0i2g4irrVhy+GahA9YkNPO0+k9kuCWpD42cWP/Czmyfw==
X-Google-Smtp-Source: AGHT+IFXAthzs7w3vtk8RkSvTeN947ngcZf+VAK+rw+xITJV93tseomkQfOD6BZG0MKBhxZsamttPA==
X-Received: by 2002:a17:903:120d:b0:1f8:3f13:196a with SMTP id d9443c01a7336-1f9aa44fc82mr4638365ad.45.1718736146586;
        Tue, 18 Jun 2024 11:42:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::5:5466])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9969c4e78sm16917975ad.161.2024.06.18.11.42.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 11:42:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	zacecob@protonmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 2/2] selftests/bpf: Tests with may_goto and jumps to the 1st insn
Date: Tue, 18 Jun 2024 11:42:19 -0700
Message-Id: <20240618184219.20151-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
References: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add few tests with may_goto and jumps to the 1st insn.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index bd676d7e615f..e3f4fe763aee 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -307,6 +307,61 @@ int iter_limit_bug(struct __sk_buff *skb)
 	return 0;
 }
 
+SEC("socket")
+__success __retval(0)
+__naked void ja_and_may_goto(void)
+{
+	asm volatile ("			\
+l0_%=:	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	goto l0_%=;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_common);
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void ja_and_may_goto2(void)
+{
+	asm volatile ("			\
+l0_%=:	r0 = 0;				\
+	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	goto l0_%=;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_common);
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void ja_and_may_goto_subprog(void)
+{
+	asm volatile ("			\
+	call subprog_with_may_goto;	\
+	exit;				\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __used
+void subprog_with_may_goto(void)
+{
+	asm volatile ("			\
+l0_%=:	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	goto l0_%=;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 #define ARR_SZ 1000000
 int zero;
 char arr[ARR_SZ];
-- 
2.43.0


