Return-Path: <bpf+bounces-28007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A98B4358
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DE41C22A60
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E92C68C;
	Sat, 27 Apr 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="AZGBS5jF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="PmpIaT8P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JaA0005O"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371229424
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178788; cv=none; b=jZJ9jjFHsPrtVSZwY5gekvsYFJI9TPwzap5wZc/evV1QxGLxribU8NfzJryjBUTpembQjz6agyVPv0E8wI1H2o9OHT5kfim7S6WmGRgeXJIJqaAL+VEJl0u6Xx0ocJORT61GyYfdrJvqhRqRaxhtqBgF6LmoXDmhhXF8CfT2+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178788; c=relaxed/simple;
	bh=6283YGSFgMHjPdP63+trRy0kANw3Pb3ljrIlVIAVrBY=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=bt7hJ6fBJHDJU6jBrFhKwx7U7q4j8QoXpZ1YXA87d1zfBwJSjlk7hAHwdlDwAAqA6P+lXoio5dU4c8O8ZRseLXL1ftHSxnrfKJVsA1cSRcKY95/2JuMLjnjDUYy0s0lJBQqnmS9ZuexX58qghBRs2Bm7bhyeDJKHqESk2zWvg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=AZGBS5jF; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=PmpIaT8P reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JaA0005O reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 856A6C18DBBA
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714178786; bh=6283YGSFgMHjPdP63+trRy0kANw3Pb3ljrIlVIAVrBY=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AZGBS5jFHsWnfMOHWwAQCDC5uphlNKn/HMEC2WRPIPtmgv1fro77p74VUFcRpPb/j
	 qdcII3pDMN1kGVlyrtb3OBBvtTu7lwdYkXXjSOMT8Bv6aJsr1zy7ohT02zTEfMxhCz
	 kgIYPVtpTjKx39gwVvs1QTMxI45QhfdhhokNvjlM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 61CC2C151993;
 Fri, 26 Apr 2024 17:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1714178786; bh=6283YGSFgMHjPdP63+trRy0kANw3Pb3ljrIlVIAVrBY=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=PmpIaT8PuUGHVBE/MEgUM12p8HaRvCe78ZAJ5SDNhIp2IgE5wqr9NRZVsmTkNJK6G
 adbxiqMy3PKZ2YuJiO49PR0gM7T9Bql17lm7IQM9ZZmVXPwro3wyyWOLQXiigqalPN
 VyyVfXKnu/uEx9y4DsL8o+u/H3p/yVQk2Dj3a2aU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A38B3C151993
 for <bpf@ietfa.amsl.com>; Fri, 26 Apr 2024 17:46:25 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AqNxFwmarjVV for <bpf@ietfa.amsl.com>;
 Fri, 26 Apr 2024 17:46:21 -0700 (PDT)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C4E2BC151539
 for <bpf@ietf.org>; Fri, 26 Apr 2024 17:46:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1eb0e08bfd2so8158365ad.1
 for <bpf@ietf.org>; Fri, 26 Apr 2024 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1714178781; x=1714783581; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iqM4bH/egkC7F2KP36qPWtDs8oXxAHgrORE+KnzqiWQ=;
 b=JaA0005OV73ETRytNWDywgu/+PFlVlUsYAMcJ+0Fe9skaaelCa1RcQJqPR0ly2kTFw
 O6Uz2ujNWdCMNTououHMQD/0ew3idCGySsKb+JZoLuFN1Bhj4AULn+RgBzdLxb6MElm1
 xO5khu8VH8Iujfd0YxX0/96SjSTo1y5z3YOHv5FQfmyQeBdvKNnZnQKhb6pNaexS+1ZK
 7gBj44//2YaZx++R/l2JV8sJktvbZn54E64FDCMzoUuc9nCg41WwXaBGPwBN0FjIrFAM
 Z049hTg0QkXjqMRtz/SVgB5jUQ/m8KtUCJpPk5VahKsYXYErGPTwfBTD66Kw/R6cyiP/
 y/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714178781; x=1714783581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iqM4bH/egkC7F2KP36qPWtDs8oXxAHgrORE+KnzqiWQ=;
 b=XIBPRaaVtfGsK9Q7XDEDwDt2OINcG5++3QvYHIeReg4p6s6Zq6RdJTBVtaktWzFfrq
 xTGLJvRlLDi0y4Kl5sgRCfERObgHzmu+O5JWDwSbz8fsvdTeRn+BbDxaj4bASXTXPKo6
 V4skdBIMKcAJWKxeU11ENjBMP/cntiKtN56hB8zapVY2Gvj0d6jQhNnwySNHIiJqmTXZ
 jHZHjdHT0VKSGIezxE6ghxwwGGI7wgMXsT3oDWJvd+VKBRBwLOIrf8awrFPNrerVlPtH
 PVC8kq230bmsjrBDxPpxMlp+BUD7fLtsYDbp4WH4y8T6amk1Lk13863GAbWVoK4qwdIg
 3WPg==
X-Gm-Message-State: AOJu0YyEWDXFPsresbWpO+zttwk2JS0X1BBbaqDODOBcc41CtTYxVnYd
 /qR18b8EkHb4nXviv4Qvk/eQ0qaS9b20GsQKewKrbZt83r/Qw7RoD2RepOeA
X-Google-Smtp-Source: AGHT+IHeIoF16Q80uSiQ/DLhSa9gvzJy1G5tafVpXFNAzzY8ZxBVdawAOtuwx6qU/IflowpZ8+6Klw==
X-Received: by 2002:a17:902:d2c8:b0:1e4:4000:a576 with SMTP id
 n8-20020a170902d2c800b001e44000a576mr5299716plc.43.1714178780819; 
 Fri, 26 Apr 2024 17:46:20 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170902b58d00b001e0942da6c7sm15982243pls.284.2024.04.26.17.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 17:46:20 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Date: Fri, 26 Apr 2024 16:11:26 -0700
Message-Id: <20240426231126.5130-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/r3dr-oiTdpKJtYK2Ctl3lLzTdKE>
Subject: [Bpf] [PATCH bpf-next v3] bpf,
 docs: Clarify PC use in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

