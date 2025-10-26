Return-Path: <bpf+bounces-72265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0EC0B130
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A44154EB3C8
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A692FD7B4;
	Sun, 26 Oct 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx7UsoLN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C7A2FE566
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506448; cv=none; b=AWMPCnxtKr4TGcWsG1VNFiwVdqeKdbUa1Y4cwDtP7tBDw8nfLIswIUJDCF/NkOnRMN6Ghysblerz7HvJ7eocYfqk1P+EeYijBTIh86x1V6sHlJDUXoXfZCQr6pINHNUekltB/FmBZMmsXpu8tUvESIdEo+x6DamS9DOng4m04EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506448; c=relaxed/simple;
	bh=zEibW0fbiDJz4sjJNb92Etcezz+KgG0J670j15lVQBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7BLvloOesY78EkPPfi18IhektbyktbpU6OTT4M12QeHbjsXrYFnY7l2TBp6dvgRPJ2xLIKt7kJaQyR4RW0cXcRWstwr9djG2tbuJi2Mm++F1FEl0nsPZo3yh8zJFbNGrnkjpMuNE0qKCUDfDZOlyZm9foXKT0j6+ELqFkG2g5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lx7UsoLN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-427091cd4fdso2246350f8f.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506444; x=1762111244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mECsmozFOIZoqG19gm6b3t2WEiqfOoVU9JKTKTjQgw=;
        b=Lx7UsoLNJuUjhX/LVx6SYZxk/7w24MH5kDECXasas+KwmV6aYAI/4cC0f2GNovKOuA
         1i0hZQicjd38DNh38qxB/m5Unsol926coYMRMbdU2BjTGn+dGyl2Ar0Hw1UO6oWFsiJZ
         BjHn9QkQsH/5cbYZorkQRq43PNDwmb2o8Nb3yM5QamrqF2qjRbzzW6zPOuZntQPu6GdO
         AqUeR/AN3hkPTYcvjhFQAk2jLnLpq2NjkwTlItqbXzz8+tAxamzWcQNGt0XcOJ4meblL
         8ym1CFTpUO1jv9ZIhiGMJak/xngXX64P0opwb9NywuEzS1wJOWed2B940awKzB3HYmmq
         qeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506444; x=1762111244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mECsmozFOIZoqG19gm6b3t2WEiqfOoVU9JKTKTjQgw=;
        b=fPlVriz9b1PqZ1dd3FJUROOpGtXxOt6pjCrOyvBtbB5qny68l+q085sL74MLGuOp8V
         kHxHIaoFKvLzXxsg9VG7qgGGuwH/TA1+EGaDhCDq1GwCkFW6Ep7U7vwpcQKT54ugMWx3
         Ihxzzo7QncZHBQnnzMx89Fthl0teezC0OYiuS2j6+bB6CoHKhFS8G8Ho8l9olfAXcQda
         vEChyDB5t12xtcDuKzBYg/j0HEzrKAgVsgsWst1IfRKu4WI2u9XaRv6no9OxYyAPS4ZU
         7XHydC+ldeGBHjaDDgCS2KzVdYuSCWHr0QL1IG28UIjufoL6fSxKKHHvF7YV/TF3BsvL
         P03w==
X-Gm-Message-State: AOJu0Yx0kKZcSGXvQcH2bBLI/eaQuv4b5yafuFwRhPAh/412oj2YaNLe
	Z/W5meq161FvFvarKXhMc/2CALExNgdAZiXTa4inV6pAeNx6IPixzZxpzDiS4A==
X-Gm-Gg: ASbGncudOOsRjYWIVVMjnfsB9CDJbWyxnD/1tb0pe6vhu3YQBUJyQYicSJHzBPDvPN2
	pcs9MSd4ZAzhR8w1I6jDaSoqJOA+NtJ1V4QGwll85pqfAYz33Q1ghqJZxUklv+ZueX1AlWoAzEN
	HajTfw1tr/1AJiU2V6g/J8MUj8dS0YzMOkomZYXoPw9vmfrj3FcJhCET42rYiR224KdPWl6XgNw
	lFFsy4DGCh6U18cuHaYkZb0p+S9lCt3t273VSNn108XIowuTjszFZgkBTWZv1ZveYyT4kvldiYh
	385IIWCe5SICP4Z+Dh+NdYJh3zNt5SZmLDst/RgfvUPohTgLdKj3yTTnSkjdg8Y2R1PF5zNt0jr
	2OG6JVT4PPsL9D2S+RfANpm454/rXe5qAMCnbdtPtzdltbdPGlJ3rZfk/+8hiBwkj7aJkyMKFhJ
	CsmG8kOur12ibVyR8cjb7wcb/W7f8nFA==
X-Google-Smtp-Source: AGHT+IFbWjpuVDOxto1+pXt6u17c7r3cYMIVNbqa1CGse42ugRf1OzoDcZyxtfQkkhZZP96KRCqmIg==
X-Received: by 2002:a05:6000:1865:b0:425:8bd2:24de with SMTP id ffacd0b85a97d-42704d145c9mr19825079f8f.9.1761506444400;
        Sun, 26 Oct 2025 12:20:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:43 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v7 bpf-next 08/12] bpf, docs: do not state that indirect jumps are not supported
Date: Sun, 26 Oct 2025 19:27:05 +0000
Message-Id: <20251026192709.1964787-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-notes.rst states that indirect jump instruction "is not
currently supported by the verifier". Remove this part as outdated.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 Documentation/bpf/linux-notes.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 00d2693de025..64ac146a926f 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -12,14 +12,6 @@ Byte swap instructions
 
 ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
 
-Jump instructions
-=================
-
-``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
-integer would be read from a specified register, is not currently supported
-by the verifier.  Any programs with this instruction will fail to load
-until such support is added.
-
 Maps
 ====
 
-- 
2.34.1


