Return-Path: <bpf+bounces-27950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB47D8B3DA3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECCD1C2215A
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2215AD89;
	Fri, 26 Apr 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iXAun7Bf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583652230C
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151469; cv=none; b=fRd/yk8LCENYtmGHSXF6PIysv5D/oOz8ANsipKWSIH/fv7V25E0Fp4mnGgdDVRRsipjT3DLkPN1ah3XILRxMxMAldx4cCBTBlgp8aXzg3DfyNY9qjcRUxtF5B/uPxAPCNmq2T/kzoqqSvB16ndsAETWr/5wxDxcApP+BJWhqVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151469; c=relaxed/simple;
	bh=vp4EewgOAvB0hUY10fQnqWOhJqcUtLpXe3JwUECRiuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoqiL3yHhzKvGC3S+RI4EOiA7w5ewwOrnFhy0LA09FhzwJQlpyvw+dk1CtsQCQbE8sdZuUlzpeHZvCf3UZCS6GCno68NO7TPfjz/3xpRrXt9WVz8avVXM4pWg7v8NIHy+OjnJob+/HRZkiWCI14vgiSp022J9FtFCyULANJn2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iXAun7Bf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e65a1370b7so22129275ad.3
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1714151467; x=1714756267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdvIkzQYL0QUQIUZDBpESmAbo+26vKvrycV4Z6MfDZw=;
        b=iXAun7BfHCyt7EwpERDP06ouRZCUv7obvPwwKhMZd/ukaEyYv7vOL0/q0Mg2FchSWn
         bt9rYq2i6xDOzcD8DOFGGBAgDOndmDOmBttsK/rWVCDDFUhp+3+XWjTUmjRkWFXWtlkF
         M5trz2SLkHb7SjxQxNEA0ChOhenMj7Tx+ApcuuTwrgzX8I67HvpaLZj5kh1OTOCV6Py8
         WeCZdqg3tAWY5CBm38/NnvWlZytDo9Fw3Mi7HfgpI5UyteofSeLcolnnb4LqZa9dwz31
         0ZgeD+CCmsrKhQcAJbH+ShVDQLAQsKDxMvUx1whnpBR8aHQxpn2kRGeUfMYAU74u+WU/
         7GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151467; x=1714756267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdvIkzQYL0QUQIUZDBpESmAbo+26vKvrycV4Z6MfDZw=;
        b=e5dj69OumSxKtPKVBzJ2PLEoq7IO9JJ/61Xm+4PXuB9UavnSvMPkk137tZ9GizmRqi
         RzlsHbEtOdL+si9UpOKXdHdZG9m3RIBz0hur7gV0y+wfBi8q/6yBJ4vQQrCQslJB5/ed
         DKG3smsuXcHHNdrKNQt/uLjeQPQXtj66fJwhxTll1ab2DL0epX6x4F4U7UXdswBF3/fl
         dxk7WZl4OufE+zfv3sLOZP+LzLqTlCLjcc62ZV7VlEcNCmVZJM6uXQvoIc2N3lx/1vBk
         o5VOp0DSt9mAoeZhYJrJNGqhj2L2Iw+mD/fuqklekWKISwSE1A/3ruDIXqi0NQegTnbg
         UZJA==
X-Gm-Message-State: AOJu0Yzr+mdPy7fmX+jLntfxK4ayuL/4uoK4HTQ29eW1+/HyS71j9rrD
	sXLRk2Xce3w4kYYKNtlOJD7vhi9RX7X2Dxqpscmmj9GjlRgN0EP/SL7xV9ve
X-Google-Smtp-Source: AGHT+IElEKZ8x0CBcgq/KkKh2SpyS80PR7LG5hgyM43/sAPnP0ZwsNN8Dr+kPqnGunXRe4lnmJwEUg==
X-Received: by 2002:a17:902:cec3:b0:1e4:48e7:3dab with SMTP id d3-20020a170902cec300b001e448e73dabmr5051864plg.38.1714151467302;
        Fri, 26 Apr 2024 10:11:07 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b001e27dcfdf15sm15664394plc.145.2024.04.26.10.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:11:06 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next] bpf, docs: Clarify PC use in instruction-set.rst
Date: Fri, 26 Apr 2024 10:11:03 -0700
Message-Id: <20240426171103.3496-1-dthaler1968@gmail.com>
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

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index b44bdacd0..5592620cf 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -469,6 +469,11 @@ JSLT      0xc    any      PC += offset if dst < src          signed
 JSLE      0xd    any      PC += offset if dst <= src         signed
 ========  =====  =======  =================================  ===================================================
 
+where 'PC' denotes the program counter, and the offset to increment by
+is in units of 64-bit instructions relative to the instruction following
+the jump instruction.  Thus 'PC += 1' results in the next instruction
+to execute being two 64-bit instructions later.
+
 The BPF program needs to store the return value into register R0 before doing an
 ``EXIT``.
 
-- 
2.40.1


