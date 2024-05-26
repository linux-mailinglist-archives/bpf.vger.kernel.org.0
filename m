Return-Path: <bpf+bounces-30606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439428CF2A6
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 08:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88441F2127B
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 06:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9E1849;
	Sun, 26 May 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TG/iyhHC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5815CB
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716704301; cv=none; b=bgQyAJdxMLp1sV1/NL1nepoMocL9cm+Kuqc5x/Hw3SDGTCcizp/M17U96b8jTPKiYIT/eirMmhAg+MeNlO8ZKZ/lAT3/BVQJoT9oVd+94Ban/w0r4fsmMbQObV/edoi3dlkuAYTMs3yzBoJwfUnA2AqKL6NEpl0CQZqrBDoxUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716704301; c=relaxed/simple;
	bh=p2SUJKTiJOV0wwGju21GOwKbWcVuZoEtyrMn2D03RKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eB4rr7aJ8vr0fnqJY/nr2JC4qIbMM1NYLY6sbIrcCUVrC5MdMy/FL+8XwZvjG/sIvyVV4reDbCYGkE5zOUawXiapVg9xXPAlk3iJxh/+5PCBoIWC0uc/xymI3s2xh9LHWwFYoy9kLN8+HIC99e1SKiHn5gybSSOylZOL0w+pZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TG/iyhHC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8f30712d3so1073915b3a.0
        for <bpf@vger.kernel.org>; Sat, 25 May 2024 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716704299; x=1717309099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOdcBgu9Aq5+isa9I4zoSOyXomOsAMJXMKaz27e1n4k=;
        b=TG/iyhHCHvuqQO2NuHa4dOg0oCPjZPuuxd3Ba9Dx2baBQBguduFgPrU1N6QGnEbheO
         q+zPCztiQctxO5/j9r61on3AOutVj84khTC3FVD8vrq8+s0lvEQDoriU4gBqVJp172PW
         CDPUBM8J7E1h3ZCqwKWjZviEC2I8/mFJ9mGsbK0AJRIC8LABgDhaQCEvCsynjpAsDeUE
         IRqM3PcyvygWJqwMTrsFncuiYQwWmjN0wVUftn5aVqjsOcgBPS8HgE022y12OwfZmmak
         4ikLcgtaewM7nNU0EjvLq0h8vME6eKLqESYvl+fHjSkPuGcm+xONYrg9ybKzcdWrHw28
         7mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716704299; x=1717309099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOdcBgu9Aq5+isa9I4zoSOyXomOsAMJXMKaz27e1n4k=;
        b=XGwwSbGJ0jrx2S8k4+r6kBHsD7pUdK/LUerVfq16RagdjLtvcV3wSKK5c4Dlclf6tc
         aMj4XzSgd8fNYvwFIOFF+/JZnfbJT4GR9OLwSx6/yM/X3MRSEztHNYyev0n9AkWtGCoK
         Y2VY/QQGcNoHOo8BanO2wfWBcUbRYpd3LDGr+N6IAQ7xlIUME6ZIe/99qvmTQp7Vn/s0
         FyLlsUUOubqYRKYGXj1rp1aJ1En/XrvX09yiyNbzRZwG56VrucePaUvqlbsMbNVqdyZz
         VQG6ivNr+E+uhpfRj7A5hmNvVZzjv+tqubMS2Pwuq22WeeUoxsxJdhjbPiuIyAuQhQYW
         QvnQ==
X-Gm-Message-State: AOJu0YysKR8cdkqroH4B9/N+ipgOa7vHShAuL+t+jQGWc4UAe8HGH4C6
	rS2RWW3BXCOkG3OurKuBLOZWWQhRs/ifR03whXcF1fWiim1FD+FW7ciMcJn/
X-Google-Smtp-Source: AGHT+IFPMeGSuOxnLNcuF2GZoyt6oel7eXZq227r8N+xreUb5az0JouP+12c3YkY6KXYyni0yZgTTg==
X-Received: by 2002:a17:902:da8a:b0:1f3:3b0:61a7 with SMTP id d9443c01a7336-1f339f0b3c7mr121684405ad.12.1716704298855;
        Sat, 25 May 2024 23:18:18 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d42a7sm39763975ad.117.2024.05.25.23.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 23:18:18 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Fix instruction.rst indentation
Date: Sat, 25 May 2024 23:18:15 -0700
Message-Id: <20240526061815.22497-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table captions patch corrected indented most tables to work with
the table directive for adding a caption but missed two of them.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 08f614b10..8d1981050 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -296,12 +296,12 @@ For arithmetic and jump instructions (``ALU``, ``ALU64``, ``JMP`` and
 
   .. table:: Source operand location
 
-  ======  =====  ==============================================
-  source  value  description
-  ======  =====  ==============================================
-  K       0      use 32-bit 'imm' value as source operand
-  X       1      use 'src_reg' register value as source operand
-  ======  =====  ==============================================
+    ======  =====  ==============================================
+    source  value  description
+    ======  =====  ==============================================
+    K       0      use 32-bit 'imm' value as source operand
+    X       1      use 'src_reg' register value as source operand
+    ======  =====  ==============================================
 
 **instruction class**
   the instruction class (see `Instruction classes`_)
@@ -681,13 +681,13 @@ two complex atomic operations:
 
 .. table:: Complex atomic operations
 
-===========  ================  ===========================
-imm          value             description
-===========  ================  ===========================
-FETCH        0x01              modifier: return old value
-XCHG         0xe0 | FETCH      atomic exchange
-CMPXCHG      0xf0 | FETCH      atomic compare and exchange
-===========  ================  ===========================
+  ===========  ================  ===========================
+  imm          value             description
+  ===========  ================  ===========================
+  FETCH        0x01              modifier: return old value
+  XCHG         0xe0 | FETCH      atomic exchange
+  CMPXCHG      0xf0 | FETCH      atomic compare and exchange
+  ===========  ================  ===========================
 
 The ``FETCH`` modifier is optional for simple atomic operations, and
 always set for the complex atomic operations.  If the ``FETCH`` flag
-- 
2.40.1


