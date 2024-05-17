Return-Path: <bpf+bounces-29951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2468C8966
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F10282E1E
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD12712D74F;
	Fri, 17 May 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UXY3Ck2H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53854673
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960091; cv=none; b=V/oXMN80Mxs5Kc26qQG8tr2ZbZFiSwx8R6CmOJQzWaX6pq4KqY4N6fcwy79sBRE/+NhwlXuHNZPjVxcv2xxyIHP80mY64Vc6n3DIdYfY271hLFRU013T7GD7a8pGhgeo58Z15Pqhxjy25rFGV1Ov2Osj0oY5eSnKHDpoIxFd/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960091; c=relaxed/simple;
	bh=UkqjKfmhbO5OyfYRmSX4f2sXh07K3UTE+omaUOYPCXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MfDX+T3iX5D7QziNC7dH2cII3oEwJjsOewSmWbRVvKeIkEiETxU14WpZvsCY+1NENEXRsOi0AzPSktOFOz6So+EqQDDAFxMyNUfeW6xTDf+mv55TaID2SNcfb+VhIQ3bGULQ6JFYw+6ixPiyHmqT2/1JJ0m6OvYXXFcTKdXy9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UXY3Ck2H; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3c3aa8938so11928205ad.1
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1715960089; x=1716564889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gu9rHXjrQNiuEdfil+6Qxyl1dIA+C1Ezul/fpNnbzX0=;
        b=UXY3Ck2H4tR8AZx0sQW9/JGxmrTNB+vXRdGSpBJfGZ7KE0TWeU79AhI7AElZGKoLz3
         NCxnH9J++/3XMh5Jni2jo7BSw+23uasQQGU7QuxIsDK7YvIcuQywv2A0o2RctRyNXXLV
         DK0gQU7gkgpifnwYK3637Qd8T6cOUMA4ZwpyhWMvJ6vSB6SY+tjuLrL1LBlotGbGjQ+a
         20tFcqq3fRTmCuIBPLljfqU3dS9rJzn4H2K+eu2MklAscyF8OybGlsys+bBnMNCo0yNn
         t5G3BzQbQeaeg5yuEfGSTNXcRmAmfzAKNwonn3ElIJu1LFnEq/ijiDGIdTrpGW22OUPo
         N0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715960089; x=1716564889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gu9rHXjrQNiuEdfil+6Qxyl1dIA+C1Ezul/fpNnbzX0=;
        b=W9T3jt3poNKhmbjbn1r8rnwyp1cMG8IDplXnzyN7IkJrKsDZE43ihD1IKTj2ZjIp0k
         87l6CPLLs6Bn3p5DzsSPz8JOR0M1ymPi/C1ZUrNCH0f2lCI0igVtAyiD514t/I1n8XFY
         s3IRu49kI81lIWJfX7j/kVLDP8GINigjZ20ow1pj/AmihxLAKirrGa0ttBXtTJYY2hzT
         Q8vIRtbYKE7QAgZlSum4JODjOi5bHTjuQJrkGhIHm+vRPo2WcWgxSAZ91cC5rpXF75v5
         BmjOy52OtxE/ddx4+5kX5OZDUn4RApImB64yZXxxCFGKw6VUJJ07Vzj6PJCdX9LVBCWw
         OXZg==
X-Gm-Message-State: AOJu0YwNI7K5+BQ1Ndp1QM+lboxjIlZEuHtK+EFjmY/hvay3qMC361q9
	MpdfAvOqBCFzlu4pnM4hglNZ7/o2pOLyucDxnER97GQHhGjGLHhRy2+h6Q==
X-Google-Smtp-Source: AGHT+IEmwrGI+mO352Ret0QmpEQXcshi8dtdOKXoKXqgkRXtzbmexGrV7Gnc7qYFKDIm26al4/xBrw==
X-Received: by 2002:a17:90a:ea12:b0:2b2:7c52:e175 with SMTP id 98e67ed59e1d1-2b6cceef2f7mr20254508a91.31.1715960088955;
        Fri, 17 May 2024 08:34:48 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5124sm17494864a91.43.2024.05.17.08.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 08:34:48 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next] bpf, docs: Move sentence about returning R0 to abi.rst
Date: Fri, 17 May 2024 08:34:45 -0700
Message-Id: <20240517153445.3914-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed at LSF/MM/BPF, the sentence about using R0 for returning
values from calls is part of the calling convention and belongs in
abi.rst.  Any further additions or clarifications to this text are left
for future patches on abi.rst.  The current patch is simply to unblock
progression of instruction-set.rst to a standard.

In contrast, the restriction of register numbers to the range 0-10
is untouched, left in the instruction-set.rst definition of the
src_reg and dst_reg fields.

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 Documentation/bpf/standardization/abi.rst             | 3 +++
 Documentation/bpf/standardization/instruction-set.rst | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/standardization/abi.rst b/Documentation/bpf/standardization/abi.rst
index 0c2e10eeb..41514137c 100644
--- a/Documentation/bpf/standardization/abi.rst
+++ b/Documentation/bpf/standardization/abi.rst
@@ -23,3 +23,6 @@ The BPF calling convention is defined as:
 
 R0 - R5 are scratch registers and BPF programs needs to spill/fill them if
 necessary across calls.
+
+The BPF program needs to store the return value into register R0 before doing an
+``EXIT``.
diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 997560aba..c0d7d74e0 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -475,9 +475,6 @@ the jump instruction.  Thus 'PC += 1' skips execution of the next
 instruction if it's a basic instruction or results in undefined behavior
 if the next instruction is a 128-bit wide instruction.
 
-The BPF program needs to store the return value into register R0 before doing an
-``EXIT``.
-
 Example:
 
 ``{JSGE, X, JMP32}`` means::
-- 
2.40.1


