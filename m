Return-Path: <bpf+bounces-20785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC992843490
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 04:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7879289A38
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 03:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76EF107A9;
	Wed, 31 Jan 2024 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eeyPZdAZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73A15485
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672288; cv=none; b=R95bZQpoQKq2/v+11/ofZj9khS6sfI7rwQ2IcC1e2xJFmvkanVPwBBivvFca/b1+qOvnag/HckXEjU8fysa7+jxXcxPNe+lyPNlz/bdqM98+SpjRF4uEhWxsLM9LdgCn1UOkHBNl6CK4SyAbXvqV5zH2j27AEuP1RNBwSJC60Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672288; c=relaxed/simple;
	bh=zL0ChvUCzwzrBGhUhYQYbjIO8xWUd3MGL/EOt3BPK/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZ281D6RqT2Oyge5g3pIzOKY4cKS1e7jvkcc0NCFvdC6LDB245elL/+syuODm0Hvij80FlM1Ge8mE4ZfcoeNc0tFKuSBZtgXpnvUATubBNRk/2WzUX3B57h6RICj3oaIpeze5mwd3B0t9Kll4HI1F8N/VoNc/JuXHqCUSYUp120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eeyPZdAZ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59a58ef4a04so1217892eaf.2
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706672285; x=1707277085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhXNQgLXBlJmEoHckwon0RzHmRHma/rjdahanXvt4cw=;
        b=eeyPZdAZSHHYbVkQ8CEF+CdaVaH31dITD6YrXiZiaPCbenKSXC8+dg98RR92FRBLFo
         WmHwlv1FzZzP1Wn5Aa7o9/LuaxDSJ7KK/S2z88N3yui7pibWSEYSIh2Tjm8XlXRCrIdy
         5RdvyonkT6d65QDP2QXUBGfMteL8Z9INvL1rCI5e//PgHwOan35tFXF+If88/NuULe9V
         oi/42NhF3t9s4KPHgUG/Ia5dp3X/QRAuYRjemWJakpubriEwqDJcUz+dIC06WiXUSjrQ
         ZOoN5uMxbJNCFSwqY8Wtye5WaEsUKYl0acM/2o+0mHe7QqR5JGDnwDKhUWY2p35WEocY
         oKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706672285; x=1707277085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhXNQgLXBlJmEoHckwon0RzHmRHma/rjdahanXvt4cw=;
        b=LXfQWtdxt+q8rUW6Y++riYW6+ZIkChVo58He1cBG3WWqzqbyUjWrhqJIxW6heE3miK
         GkSSGyJg9hWvYOCNafm9TrmtBoF86GbCM8dJcZBrPVZ/fLAgI2adpvrn+HZTluS+BzRK
         XHq1u2GG6nABnKP8p4TCu5hXgMrI3hHz915J0IaU8Gtit6loYjTxZ4s3ly43dVAC/P6s
         sXL/5CXKKKYtQZjRvqUU+/gf3Hqo1fnEQX63iNZ0NLk+ODaueIJSo1g6Qo9/7aRU8Upp
         oglOoOGBoixOmkH+6ZZT9eer15mXg85W0N3gEwwPEBE3So5QudwVxHn9eyR5n+hxor0A
         w4OA==
X-Gm-Message-State: AOJu0YwwTotZHlmHW1xS1TUWgAclLjDIbNxqgQjlSFgb2bXT67YhtJPA
	CjvZ6eJADMLxQmWGjAOF1ONGJyoxyFmrqSE81kDg4SEhi3/9hUkYIjSuNIim+gA=
X-Google-Smtp-Source: AGHT+IERakJZGap0ueNR2PueNiFVwjj5vEYM2GYiFK+mo7oXsmC+CZCS/Nt12iwI/QzhUNhCMLZ+yw==
X-Received: by 2002:a05:6820:1c8e:b0:599:4cca:3f93 with SMTP id ct14-20020a0568201c8e00b005994cca3f93mr523919oob.0.1706672285711;
        Tue, 30 Jan 2024 19:38:05 -0800 (PST)
Received: from ubuntu2310.. ([50.35.79.164])
        by smtp.gmail.com with ESMTPSA id l18-20020a4abe12000000b0059a56e36763sm928496oop.22.2024.01.30.19.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 19:38:05 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Clarify which legacy packet instructions existed
Date: Tue, 30 Jan 2024 19:37:59 -0800
Message-Id: <20240131033759.3634-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in mailing list discussion at
https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys/
this patch updates the "Legacy BPF Packet access instructions"
section to clarify which instructions are deprecated (vs which
were never defined and so are not deprecated).

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index af43227b6..cf08337bf 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -635,7 +635,9 @@ Legacy BPF Packet access instructions
 -------------------------------------
 
 BPF previously introduced special instructions for access to packet data that were
-carried over from classic BPF. However, these instructions are
+carried over from classic BPF. These instructions used an instruction
+class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
+mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
 instructions belong to the "legacy" conformance group instead of the "basic"
 conformance group.
-- 
2.40.1


