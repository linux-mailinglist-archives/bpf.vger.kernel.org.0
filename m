Return-Path: <bpf+bounces-28006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F98B4357
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6A51C22C29
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524928DDE;
	Sat, 27 Apr 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N8voBjC2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB832383A1
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178783; cv=none; b=t9sLipNThVEVg44TUe5uFHGlnWqFe6soAAGz7CcrIl5iW0uLCOUpV0LwWT7iTv+y19fPHu72Cxgf+qv+kYJzWglm4ZYx9ocuWIjp9EsUh8dnQ3FIU4tzcYBJZveBpbqZKLN00T2jaaZMATM4CEc17UPj1+6IorIR64aYJ22cV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178783; c=relaxed/simple;
	bh=rQYvjlosyaYGA1Li2Cis7aS1jYPsYBHhReWToeq2FU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lmqNZF/4kGa+IBc7nBQvQdO1DrCWuFbkEp5sscfl9JGParfT6zNVWxW0cegpbUNxqDRspO2A7QcQu6lcZ0/wthv+t8/1rwng5nEU0kjsN+odN7WWtnIezYLV6QtMsVcUvkXc4jFbA+DrCUzYoIJHztjI0s01BeULDcTXLLOSWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N8voBjC2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e834159f40so22111645ad.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1714178781; x=1714783581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iqM4bH/egkC7F2KP36qPWtDs8oXxAHgrORE+KnzqiWQ=;
        b=N8voBjC2myDZhC5RNHaoFvRjCpJexrJ3j5V+OY7eUa2JRQgK/fnr+V0zYV3hHkm7Or
         5ar/M8YbpattJQUQRuB5ZbWsoa5D5iDeKO0YI8ifboKA9UqQ691O+hgvI4xX2WsmeVsh
         8WOWde6q2Kxrta1w681NiqGp61L/FYJ8x8HwiWhZkNkYefZbMY0BQPorT74AVxycQDKc
         exrvq8dl0HZs/OmcO5uy17InV1E5fgRP6B/HKGP+flMQXgkkHVIZwaI/EID4GOoQysfs
         SCytxlY+zaJpVC0Hjz6LLP/osdWTpukdzwAgOP9O15KbHRcvoLvNVur9PHXALSZ+I13U
         kwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714178781; x=1714783581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqM4bH/egkC7F2KP36qPWtDs8oXxAHgrORE+KnzqiWQ=;
        b=Y7YDTgAG5lBugflqM+OCSgiTIlrFvwbJNs292dwE26qvZ1U7f165cJPrUcOq7N4yh/
         7YIm88gHzvliyQTmpirSK2NvUdQEdBHSinlDnthsIWzLvgWi6AVwxdanMq8FgFnK0gNo
         u+qAuwppCRIeboiBIDJVFK8yTJ87ZBUmCLeARNc/eEl0xW4UwKzRHgpVSnlIF2k7NoPJ
         sTkJ63Mv4VyIefHVQzr1tD4a2a4AfvXzPYdlzEAyh8/9Ws2nqajxlJvHBDAkOnyvqOeD
         x3KDb0QFfqJFOgXugbV2OgzdeMCK+dXnprVoQInWbwkZIZw+gf6IereQ48w5tr2ePQJL
         c0bw==
X-Gm-Message-State: AOJu0YwbckF4n/jEUGY9FV53cufFR/JjLz9TjO6veaaieGplfEdUoI5B
	ZYB4fDi888x8AbMi7CTB3wqzdC7ToU7gpuqPJ+DHj12fYJ2+E6ghqxoSN1Cj
X-Google-Smtp-Source: AGHT+IHeIoF16Q80uSiQ/DLhSa9gvzJy1G5tafVpXFNAzzY8ZxBVdawAOtuwx6qU/IflowpZ8+6Klw==
X-Received: by 2002:a17:902:d2c8:b0:1e4:4000:a576 with SMTP id n8-20020a170902d2c800b001e44000a576mr5299716plc.43.1714178780819;
        Fri, 26 Apr 2024 17:46:20 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001e0942da6c7sm15982243pls.284.2024.04.26.17.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:46:20 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next v3] bpf, docs: Clarify PC use in instruction-set.rst
Date: Fri, 26 Apr 2024 16:11:26 -0700
Message-Id: <20240426231126.5130-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch elaborates on the use of PC by expanding the PC acronym,
explaining the units, and the relative position to which the offset
applies.

v1->v2: reword per feedback from Alexei

v2->v3: reword per feedback from David Vernet

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index b44bdacd0..997560aba 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -469,6 +469,12 @@ JSLT      0xc    any      PC += offset if dst < src          signed
 JSLE      0xd    any      PC += offset if dst <= src         signed
 ========  =====  =======  =================================  ===================================================
 
+where 'PC' denotes the program counter, and the offset to increment by
+is in units of 64-bit instructions relative to the instruction following
+the jump instruction.  Thus 'PC += 1' skips execution of the next
+instruction if it's a basic instruction or results in undefined behavior
+if the next instruction is a 128-bit wide instruction.
+
 The BPF program needs to store the return value into register R0 before doing an
 ``EXIT``.
 
-- 
2.40.1


