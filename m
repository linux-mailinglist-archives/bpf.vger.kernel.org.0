Return-Path: <bpf+bounces-19848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F6A832241
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD681C22D67
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396551DFEF;
	Thu, 18 Jan 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A2jfHGLz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA81EB37
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620612; cv=none; b=DxLq4fP6qbqsZYdy+zeJMDT9dvUnQQQgYgw1KxPdr3g0tkCZOLDseR+IBNJENz+SBhdwIlqnUlvrFhC8pFx1jQenmEtzzl1VCuzyKOBC+mU5/lDQU38c6lwX1OhY27zddy3vZwKTmW4EqbzHih/mNYX9w/+DSuAcBgDnnh6fVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620612; c=relaxed/simple;
	bh=11O8UZBN33Ii3GjRQDchEaq+2Za3tlWpI8wBB/KemJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usN0nprV/O+okv65M5R6SqDZNfsrRXFeMz7D+7D9VFKpP3bwa6ptPY1lMSUFHlWqh8+ZKcvNFHAz+iY0znlMBw5MjiXSTaR9WV9GGi67hTVshNdBebzLmoGXZktfPp12is39jH56NprSBX/94n0NOoTtoqsUtVsG95yZ6s74h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=A2jfHGLz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9344f30caso160736b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705620609; x=1706225409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ioogeLx+74muZbeEkvEVMi/iHfl4LvcvtqKYeaQeBCA=;
        b=A2jfHGLzOAYzKJGAbT8duNDCr5ix4mdbtXLdVd3lmkBHbicAvaogcXwcoD3JF9c/sf
         ueB5xaLYNNqywMCOVxe0wyHbeCniHj5Qc/eMhPAewnXFJkWDZAmHFszKO+qayhksID7V
         Hn1exrrxh+rgMZzmkQ3z4IsjUiG/uBWrEKwYQTPeEJ/Zb6K8zaQNmDnJG8hIuFUIwyiN
         nkmZLKPGmXZN4IH5EdqGHONGJaPDAdSQOOTL0ZEtXBnuqQwRdV8glBR/m9Y1qLKsyQLx
         Z9U8/a9aqzOe3RCOkEGDdKarrwSPRg66SmN1CBxzAzPvX38jKfn4aOewKI+n9fYh0jUe
         3w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705620609; x=1706225409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioogeLx+74muZbeEkvEVMi/iHfl4LvcvtqKYeaQeBCA=;
        b=nhqjwcW9WCs+awREFIP0frDUBEOn1rQ9YWgzaDvnH0uv0t2zP7hYV9cuW+C4MYnOEO
         XR+fGHV6aUIbrHRMTbKFoJ5xRIsNvTjvN14BvRYTDovUjgpkscfjknbLr+Xp5bc9W9gh
         Htg2dn+4udIx10Vy6DKrwf6Zz/V1tawhZRgXSXgc8vTE8n1OqLclcoDhwTc2uCvrhMYf
         6M/qm2snl6R5InJhii3piaTiRaJhfOVDTNCNwjyOuAoaD1LsC4KbC5E8BiyAAb9/G1+C
         Wq1L9ComGTy3aRpgm5B3ueLB0V3VToyichP6s5JLT+M9l07ZqlZ5rDuZ/Q7GJPTcmEG0
         dpdQ==
X-Gm-Message-State: AOJu0YzxenWFLPqxwdcjuL9TwV4UqB7HKhZm/jC9doyC9awfW3TwP/PS
	wKz+1DjVcr6Fw5790NCGOKU3e5ARU85x/GvBTj2r+FIPN50qHfQEXoxow5BfiS0=
X-Google-Smtp-Source: AGHT+IEyv9y6uis6khDQHvBrXdalw5Di3YAm1aMR/aQAxnmj7tK8SCcRHYpBxtanDRMsA0QboSFFHA==
X-Received: by 2002:a05:6a00:2441:b0:6d9:8ddc:37e0 with SMTP id d1-20020a056a00244100b006d98ddc37e0mr97148pfj.28.1705620608816;
        Thu, 18 Jan 2024 15:30:08 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id s13-20020a056a00194d00b006db13a02921sm3809815pfk.183.2024.01.18.15.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:30:08 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Clarify that MOVSX is only for BPF_X not BPF_K
Date: Thu, 18 Jan 2024 15:29:54 -0800
Message-Id: <20240118232954.27206-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per discussion on the mailing list at
https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74/
the MOVSX operation is only defined to support register extension.

The document didn't previously state this and incorrectly implied
that one could use an immediate value.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index eb0f234a8..d17a96c62 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -317,7 +317,8 @@ The ``BPF_MOVSX`` instruction does a move operation with sign extension.
 ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
 bit operands, and zeroes the remaining upper 32 bits.
 ``BPF_ALU64 | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
-operands into 64 bit operands.
+operands into 64 bit operands.  Unlike other arithmetic instructions,
+``BPF_MOVSX`` is only defined for register source operands (``BPF_X``).
 
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
 for 32-bit operations.
-- 
2.40.1


