Return-Path: <bpf+bounces-29957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A86DA8C89E1
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34213B228F8
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69C12FB12;
	Fri, 17 May 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KSxDT1P1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227C12F5B2
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962581; cv=none; b=Qk+WfhcS1ZkVs4+tpnm1q9UxsqwjdTLAoNXGMKzsmVPk/3yGLaiWZEOuf3RcarWMbYTC08ZkBOEgPLnaq9MgWlvTgzN8PXgsnKkw1V+2a0MoZxHGtvmAyRGmRlqcTUZi+ankwY8L1gjnKZJ3G4SD8z4a4r15EZQNg/J/UWmiG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962581; c=relaxed/simple;
	bh=ug9A1IeTy+2qJZmw2wdiGiE9ZxVmrFnvNA3aiSZXmpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dIZ/+gVdKJCooruVVYSk4nhnc1mFfwE7q+pd9ClBtDgERZ4JQn2nDzfcM+GNjQWQEZsDZQCtIevhAqkVhwsexnsxOC00mC9xtwg6isySpQ65jr2bHTmJ2VCtY5a9LnK75UVDrBoqYN+QL0l3WJbcbgOPpL9gwlGeB0pmVBhbNeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KSxDT1P1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ecddf96313so14458015ad.2
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1715962578; x=1716567378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7armfeLAXQsQMrjI6vgVSTIgmnXDgZlGhC1Cl43yCcA=;
        b=KSxDT1P1iCY6e4OOLFD392Kht7hsggi3INrzhsOGgt+1nIS4kdMPvc7Ru/K2vntcpj
         QjqePkTZB8cd7DbKLEP/kqOCz67UGNEQlwgIjoalOp0CVu+omLHMbrvLyAaA2rIHdpBp
         bNoH+2vQuw4lsnXy/Nv8hT/StIw3skY4VrrnWjItMfXW+XRp+ZqoQqBCVm4QZVBImQX9
         AkWNnACMlGELTdpeVl2JPoAtTEYNdDq3y/q9OCzloa4MojiUjHeDjSbP/ePz/gqVaW8x
         31XLcBLf8vhbn9Eq9mmdLKH5WsUz6ljs8Cfkh3AiKoSP5OEeXshibugZK2pHvBEjl7j1
         QqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715962578; x=1716567378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7armfeLAXQsQMrjI6vgVSTIgmnXDgZlGhC1Cl43yCcA=;
        b=OH25fZ3rBvazjsE2aKtd1QiJdSB/lXpGCaoytSACVsMgaPPwkiCfTIcgtgr+srkUP3
         BD/doiIAG1SWHa6xz5TaFRo93horSPFrGaJkiH6NxWmrX45HMjlysMFqt4blQxnIgwmS
         ilmbk9/j5PgNRhGaG5Qe86PQq2rMHs1Y61m7pSSHcxwqV+xm6a1e5Votn8SUyzRFhC+C
         yLnaNO4FCWoV7Y2vTIxh01QnWeHW8/GG1yNVvsvDwf2XNc5hkpxUkFgNCknh/LD65HFP
         GoabMGaQwZuWfMZJuEIZWtNxQEyBfeK+Dr9W0vRaYVTaVh0K+h5Nns5loqHusGVNc29o
         dcqw==
X-Gm-Message-State: AOJu0Yxjwi7/bpp98TyjowrNVYU4wzF23zsNk7PzV3lIEGSikBgAwl0o
	Ufdcmol6SP3vKkgI199p4oyHNc+eiY4ynXGXRH0hF/y+RL2prunkZopqkQ==
X-Google-Smtp-Source: AGHT+IELgdG7dj3psWg2I6LwndPnLGU73+zzMKxqQ0QkyQOw8zjQDpy6DpP2Wg52aAuohVDSevg3kw==
X-Received: by 2002:a17:90a:fb4d:b0:2b1:50:cad4 with SMTP id 98e67ed59e1d1-2b6cc450329mr24365693a91.1.1715962578510;
        Fri, 17 May 2024 09:16:18 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd47ba8c2dsm2300933a91.27.2024.05.17.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 09:16:18 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next] bpf, docs: clarify sign extension of 64-bit use of 32-bit imm
Date: Fri, 17 May 2024 09:16:12 -0700
Message-Id: <20240517161612.4385-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imm is defined as a 32-bit signed integer.

{MOV, K, ALU64} says it does "dst = src" (where src is 'imm') but it does
not sign extend, but instead does dst = (u32)src.  The "Jump instructions"
section has "unsigned" by some instructions, but the "Arithmetic instructions"
section has no such note about the MOV instruction, so added an example to
make this more clear.

{JLE, K, JMP} says it does "PC += offset if dst <= src" (where src is 'imm',
and the comparison is unsigned). This was apparently ambiguous to some
readers as to whether the comparison was "dst <= (u64)(u32)imm" or
"dst <= (u64)(s64)imm", since the correct assumption would be the latter
except that the MOV instruction doesn't follow that, so added an example
to make this more clear.

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 .../bpf/standardization/instruction-set.rst       | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 997560aba..f96ebb169 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -378,13 +378,22 @@ etc. This specification requires that signed modulo use truncated division
 
    a % n = a - n * trunc(a / n)
 
-The ``MOVSX`` instruction does a move operation with sign extension.
+The ``MOV`` instruction does a move operation without sign extension, whereas
+the ``MOVSX`` instruction does a move operation with sign extension.
 ``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
 32-bit operands, and zeroes the remaining upper 32 bits.
 ``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
 operands into 64-bit operands.  Unlike other arithmetic instructions,
 ``MOVSX`` is only defined for register source operands (``X``).
 
+``{MOV, K, ALU}`` means::
+
+  dst = (u32) imm
+
+``{MOVSX, X, ALU}`` with 'offset' 32 means::
+
+  dst = (s32) src
+
 The ``NEG`` instruction is only defined when the source bit is clear
 (``K``).
 
@@ -486,6 +495,10 @@ Example:
 
 where 's>=' indicates a signed '>=' comparison.
 
+``{JLE, K, JMP}`` means::
+
+  if dst <= (u64)(s64)imm goto +offset
+
 ``{JA, K, JMP32}`` means::
 
   gotol +imm
-- 
2.40.1


