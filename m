Return-Path: <bpf+bounces-22456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3069685E717
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 20:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C841C2478D
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235F685959;
	Wed, 21 Feb 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JBFTxRKT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F88592D
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543051; cv=none; b=Zk5GwTreJKgxTX7483lKLGs/Ednb0wR1gLSEVCpRbUm6WWXP04WW7mz7q6pcd4fMrdPvGnaTUuElaF2NkydafBRXvQJP8rrbb7hN/gWBFjm90eZhHCcMrOxPrenb1whEdgUGJBTwP+lavoeNYlnwSyX+d3av5fkZEhK1x7sZ/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543051; c=relaxed/simple;
	bh=BAJxQAqNTRh0PupZskLwHWORTU0kYcrR7dHkANdZp5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMcSuKZT2NRi//MyRVOKKuEls/lEjgo8O/aikJMh8ZLSeUhWVMdIkxm55aCZDPfnpbSljxYvrTYNvNTODV+d2V1yO7rZrqxiLhhj60ZPfPbXdcLSMxYiWQMdn8NBOMK2elnofOjLv+TmvibwTSXwBVAee9b1n2EClZsA5jpfH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JBFTxRKT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da202aa138so619189b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708543049; x=1709147849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GfbLVCDf+8jb3m/1Q4Xr36f6hEaNOVT6MYMat+StDw=;
        b=JBFTxRKTPD1awdg2WSlrHkg7F/BvW1+AT2EtST3CdRcSxTTWPvjA0gJfKtKi0jSMNX
         XpsNhAP/8iFTOWVuHNSRqMHUQ8sn8BiEafEusM872w2nSrVv4En6UK2KutwOi3J9cqGo
         N1FaXMDPQBujr894cQ4OTcgzFgkVHXuH5myv36s6BY+I/XRztyTylZ7Yeld7tmbjrRWs
         93Ss0vZ8mM+ORHKML9XymZanDnoVCPVMZg3NnN4H3YgGD7RE8+ZRsvyXN6X/RHANxoPy
         1LuF+ZkpNU3Z3sQFMmpvvqHFAlZkAqWI03dySOGsQ4L07DFYD2RHnVfZiudtQrQpRiUN
         /Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543049; x=1709147849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GfbLVCDf+8jb3m/1Q4Xr36f6hEaNOVT6MYMat+StDw=;
        b=Lro0VnzsvFjpI08G/csJRde0x3qPFEoCXv36bPLNLNPMKwjLdjLaxGXzvjGN6DZTPr
         ihIZpXjkdzUAVW1B67RaEYKvqyCsbIpOuWZe93lowRLo1UHtKNHGKiGqKBGBqh5Fty94
         doZ58NwhfJ/kDpqQQPexDaJepaO0SM4GY244eJ2ZpRoS4mB3VwcX6If9WFjMXQDzX1BW
         +ctrBdRk1QNpHipKjk9F/M95a4wukqzWy5/zSu/NqCU9IHEdlvZ2caYYhgWnsVkwkg65
         xTUFTPQlPe/VQFOq3SPSu+wIYITWVaHnhFgIV4EtKXQBvNPsKb/+VGtQcmgSJcZ6Ql1D
         Ir/Q==
X-Gm-Message-State: AOJu0Yyk1yl9sFHYn07n5XXZWG3r66+RzhASNVCrfIt+oU2d5e9YlKT0
	XgK8Uqj7v/ULdyqi4chDFr7RRDfP6azjkOs8z7YhpWHBL30RtKQTBHYNECjQMuU=
X-Google-Smtp-Source: AGHT+IHkMqJq6GrwZYmU2lgyGwFR0/T6ORBe9qWNwPqAcJbcZp4TanCNfKu6NAVS6lh5yXbBSDES4w==
X-Received: by 2002:a05:6a21:1693:b0:19e:98b3:a1e with SMTP id np19-20020a056a21169300b0019e98b30a1emr21509305pzb.55.1708543049164;
        Wed, 21 Feb 2024 11:17:29 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id z11-20020a62d10b000000b006e4432027d1sm7856656pfg.142.2024.02.21.11.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 11:17:28 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next v4] bpf, docs: Add callx instructions in new conformance group
Date: Wed, 21 Feb 2024 11:17:25 -0800
Message-Id: <20240221191725.17586-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Add a "callx" conformance group
* Add callx row to table
* Update helper function to section to be agnostic between BPF_K vs
  BPF_X
* Rename "legacy" conformance group to "packet"

Based on mailing list discussion at
https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/

Only src=0 is currently listed for callx. Neither clang nor gcc
use src=1 or src=2, and both use exactly the same semantics for
src=0 which was agreed between them (Yonghong and Jose). Since src=0
semantics are agreed upon by both and is already implemented, src=0
is documented as implemented.

v1->v2: Incorporated feedback from Will Hawkins

v2->v3: Use "dst" not "imm" field

v3->v4: Only use src=0

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..a68445899 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -127,7 +127,7 @@ This document defines the following conformance groups:
 * divmul32: includes 32-bit division, multiplication, and modulo instructions.
 * divmul64: includes divmul32, plus 64-bit division, multiplication,
   and modulo instructions.
-* legacy: deprecated packet access instructions.
+* packet: deprecated packet access instructions.
 
 Instruction encoding
 ====================
@@ -404,9 +404,10 @@ BPF_JSET  0x4    any  PC += offset if dst & src
 BPF_JNE   0x5    any  PC += offset if dst != src
 BPF_JSGT  0x6    any  PC += offset if dst > src        signed
 BPF_JSGE  0x7    any  PC += offset if dst >= src       signed
-BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K only
+BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X only
 BPF_CALL  0x8    0x1  call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
-BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x2  call_by_btfid(imm)               BPF_JMP | BPF_K only
 BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K only
 BPF_JLT   0xa    any  PC += offset if dst < src        unsigned
 BPF_JLE   0xb    any  PC += offset if dst <= src       unsigned
@@ -414,6 +415,11 @@ BPF_JSLT  0xc    any  PC += offset if dst < src        signed
 BPF_JSLE  0xd    any  PC += offset if dst <= src       signed
 ========  =====  ===  ===============================  =============================================
 
+where
+
+* call_by_address(value) means to call a helper function by the address specified by 'value' (see `Helper functions`_ for details)
+* call_by_btfid(value) means to call a helper function by the BTF ID specified by 'value' (see `Helper functions`_ for details)
+
 The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
 
@@ -438,8 +444,9 @@ specified by the 'imm' field. A > 16-bit conditional jump may be
 converted to a < 16-bit conditional jump plus a 32-bit unconditional
 jump.
 
-All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
-base32 conformance group.
+The ``BPF_CALL | BPF_X`` instruction belongs to the callx
+conformance group.  All other ``BPF_CALL`` instructions and all
+``BPF_JA`` instructions belong to the base32 conformance group.
 
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -447,13 +454,13 @@ Helper functions
 Helper functions are a concept whereby BPF programs can call into a
 set of function calls exposed by the underlying platform.
 
-Historically, each helper function was identified by an address
-encoded in the imm field.  The available helper functions may differ
-for each program type, but address values are unique across all program types.
+Historically, each helper function was identified by an address.
+The available helper functions may differ for each program type,
+but address values are unique across all program types.
 
 Platforms that support the BPF Type Format (BTF) support identifying
-a helper function by a BTF ID encoded in the imm field, where the BTF ID
-identifies the helper name and type.
+a helper function by a BTF ID, where the BTF ID identifies the helper
+name and type.
 
 Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -660,4 +667,4 @@ carried over from classic BPF. These instructions used an instruction
 class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
 mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
-instructions belong to the "legacy" conformance group.
+instructions belong to the "packet" conformance group.
-- 
2.40.1


