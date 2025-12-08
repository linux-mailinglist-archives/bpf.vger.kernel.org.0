Return-Path: <bpf+bounces-76295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10287CADC34
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 17:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EE97301D611
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672B257829;
	Mon,  8 Dec 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNkfconk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6741F419A
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765211668; cv=none; b=ptvyFLn5v8WdGyN8+f/4y8QR4S31DWBD0xDF7vMT2EdG0qbt0oUYQe6qrPA3LK67wfuHswD53b9DqVKoY7b3yLkIbsFwKSLoL6bDF4Ce9nKOIcT8aJ+yG3iB0tRdb1N7sZVRdtuz1Vz8qabvndS5DdXTNElsJi9IUumUHbaIQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765211668; c=relaxed/simple;
	bh=2qErDBVauh8Ob3S6JfCcRQ2e/q+m1zJ6QApTq4vjqtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUPedr+YDeCNPtf66p7ovV86Ei81KR8EltjWiAb2oLoBHKW8hq66eyTZR1vV++HO0GA9z+psJzt+Q4fs8LDdQu2JF8tjYdfvd+PtvjPrkleK9MEpjq/n1wcLvaQkxf10nTyAwOw8j+L/AH+0pptPdOhoN14vusqLOudFBiOJmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNkfconk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-647a3bca834so6061077a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 08:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765211664; x=1765816464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WqfAF1JHevk6vjXCbG1Hbz4OFMMsEVR96Z5MujIZe5I=;
        b=MNkfconkxmhuoqOiupqgo87xSqqalFylj37Bl6/PQPLiWLbMvXZr2eMqUb+yuPs7DK
         iTNOiXUGfNDIgzjULkuqPmJFjukBbWKanwClBPM6D0CoeCVWay2LCSoMD63OQGr6lJPK
         9As+OOXqaBPZjdZVBLIsYlOJl7bsSSg037TyWANynJZS7tirlnMa2y5f8ny4/MErdM7I
         /X2XMQf1T6iLCsClC5OGWgiTPbdn/q7JcLfZMFhP/yqRnTapmL1GjEwg4TXJMQdbbWEW
         eDseVpSvq5NGREKzoelTEyiDPxAi+GPiPJyaoFJZQYS9ou+qbxUTC8gGTTsIdskfGYMv
         YH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765211664; x=1765816464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqfAF1JHevk6vjXCbG1Hbz4OFMMsEVR96Z5MujIZe5I=;
        b=AqdsFU6dgoNWvIsc1uQvrFv6R7ayPrh2YC78/kRyDFIEqsIvddHrVzt7av6RBvonXN
         mMdw+G/uAieL3kSVXyk0dLQSNJn0Dl4BO2v37gXNcUJ37jR37geM4OKbUkl0Gqjf3Otg
         sEECTmdkH+eYm4b0/EU8ZXtLh9hYW6HVP8GRUMKNvavHKextghgeCTV+3T7/BVE0yBhM
         0SRuOheboRTS4R8jp1LW+8DempmpeJakZKhVX6f+H9FBpLu8d5wUglSAlezUZ6MBGJ30
         Q0qzJKJ1vVvUhY8R253x8gemLi/+xSZDsJhcke2S2BrfEknY23ah3KuELkSLfS0RDIEh
         BCxw==
X-Gm-Message-State: AOJu0YwP2OYT8gqdnbXgE1e8Y14B4IbTvyJXfj+sCBuPThIxAukbOPpC
	i2Uj3+sPcX/04sULrNnzNgIbrZp1hR53+/8xWXlc4YvH7giWsoMkKORckBjmxtoA
X-Gm-Gg: ASbGncslo5WAJ13+xMo5+thJsJJOsCHs3gOdXkV2hvdtaycuNBsuJa64V7u4vt1Jqyc
	7GhVmSxqwVmwKZSE2LjyhfO1dHpf5i1zkmv+GWpD8LWpi9EnZD85ySLoNhfldclOX3elAQPiLn4
	pYultbXNzAY/4NI4jn9jmkHVgDTgsNFyzJ8owyzvELDLBtE7r+DF8BrPYxY/oQmMHNQi7Z2aq3o
	4HJD4HOxHDK+sCLTM/EM1j0RjKQLVDPZkyheoFX6NMihpNQ2dazbbn60vZMAHiyDayE5KWNi1mS
	yYXml4Hu8NllcpCzw9i430+o35UHSSe0Q+RjnaTHQPzCHIMuGXGA3mBWB+eLAB1a0dT1dXdiRvu
	/tIZohE/L+imnAFuX+OEu4NGiTiZfpd9Yg9C7FW3UQybw8wVZnmrL1xL7ijNHpxLWMPwROnafIa
	EKQ3n6ebAEU80=
X-Google-Smtp-Source: AGHT+IEiw2TGf1PWZBQxUY2nu3fERd+iQzg52B2saUAUqD1f6GMoI4Q/11oFj0qOZJQJ0vDzQ7LW+Q==
X-Received: by 2002:a05:6402:35c7:b0:643:1659:7593 with SMTP id 4fb4d7f45d1cf-6491ae11406mr6874241a12.30.1765211663856;
        Mon, 08 Dec 2025 08:34:23 -0800 (PST)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64956402185sm766459a12.25.2025.12.08.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:34:23 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/bpf: Avoid emitting LOCK prefix for XCHG atomic ops
Date: Mon,  8 Dec 2025 17:33:34 +0100
Message-ID: <20251208163420.7643-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 XCHG instruction is implicitly locked when one of the
operands is a memory location, making an explicit LOCK prefix
unnecessary.

Stop emitting the LOCK prefix for BPF_XCHG in the JIT atomic
read-modify-write helpers. This avoids redundant instruction
prefixes while preserving correct atomic semantics.

No functional change for other atomic operations.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/net/bpf_jit_comp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b69dc7194e2c..77d724525808 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1305,7 +1305,8 @@ static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 {
 	u8 *prog = *pprog;
 
-	EMIT1(0xF0); /* lock prefix */
+	if (atomic_op != BPF_XCHG)
+		EMIT1(0xF0); /* lock prefix */
 
 	maybe_emit_mod(&prog, dst_reg, src_reg, bpf_size == BPF_DW);
 
@@ -1347,7 +1348,9 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
 {
 	u8 *prog = *pprog;
 
-	EMIT1(0xF0); /* lock prefix */
+	if (atomic_op != BPF_XCHG)
+		EMIT1(0xF0); /* lock prefix */
+
 	switch (size) {
 	case BPF_W:
 		EMIT1(add_3mod(0x40, dst_reg, src_reg, index_reg));
-- 
2.52.0


