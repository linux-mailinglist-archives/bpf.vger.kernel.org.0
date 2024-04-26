Return-Path: <bpf+bounces-27977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3F8B40BC
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BEDCB21600
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24F6208AF;
	Fri, 26 Apr 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FwAqdORP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="p6yEkQ9X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Aqb7xM4U"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620422334
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162720; cv=none; b=d8lPkQPrNrpQngsLxj2j96f6kJeuisZ+aoDGVaZGbp6HeLcDGOmYoZK7Yb5s1EpeyS3reVn96YL67crvrEySK5oaslGMkmHT3bzfALxbNuvUTgreppjl/9FG5oe9zKFT9gCl6sVF4bw1gmUSrP4pPIu8+DHsg7SENNGtXW7lXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162720; c=relaxed/simple;
	bh=0fFlHFOLIVA/8vNigAIm/CkrjHejTOuzEdJWeqpBo9Y=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=kyTTN01+H6TBJXZh8VPtL9/xDFWV1NFrhOFpUSGsMfs/W8YvFZTBUTEnxSzmB2BHBwTIA8Yvf/H3ZyOQgiVOr4hTjWJWPTQScKID6LF60zl5/GXs7ynbzVJ3aSahEVAZI/MXyUO1UFJE9NahSXUj5koeUUc9Icr0We96DF+ViYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=FwAqdORP; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=p6yEkQ9X reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Aqb7xM4U reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id F2496C18DB8B
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714162718; bh=0fFlHFOLIVA/8vNigAIm/CkrjHejTOuzEdJWeqpBo9Y=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FwAqdORPco8cJqf599EgJlyHDFWSXpf1d0dmyHD1ao82venMBXkPuJBSZ/nXJjMax
	 R3/SmwYNbvC8sJp/DiGRroTSFfcqGzbFvc1FzaucTx0sDLaxHlZrCDQh9eVApRjA3Q
	 q3rIrv5cVxgAH467XFs4GbK26Qi+frcFotNFADlM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id C2F39C180B79;
 Fri, 26 Apr 2024 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1714162717; bh=0fFlHFOLIVA/8vNigAIm/CkrjHejTOuzEdJWeqpBo9Y=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=p6yEkQ9XrZK0sgCAT1INuH+tGmuI5iVkcXlaFEJ8BUtrUmngir8EyBLl4eQw+JhAJ
 8TfsVl9gF+Tu3yZLw/VcrOezbBtKl5k1TOOJnWATcqZggIT0uA6kI6hWnSJot+RGRu
 WOz0oFmDdccX8ONJU8WwPXYUON+sfLkSSTN/WddQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9C679C180B77
 for <bpf@ietfa.amsl.com>; Fri, 26 Apr 2024 13:18:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BbZ5n75PVit0 for <bpf@ietfa.amsl.com>;
 Fri, 26 Apr 2024 13:18:32 -0700 (PDT)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CD20EC180B46
 for <bpf@ietf.org>; Fri, 26 Apr 2024 13:18:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e5c7d087e1so23466875ad.0
 for <bpf@ietf.org>; Fri, 26 Apr 2024 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1714162712; x=1714767512; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JgDBU2AIbrsQ47mDrqYmZTI1+5aWSHVonXPYPQDCiIc=;
 b=Aqb7xM4UZVlpBemlanA+Z07fG3yIeZgqHPor9GYXwfJjcsKwFW5piqnDJGRyLKNLA+
 yTCW8em10ty87p0tkmYa/0yvgm9ecwrnvVuGT0qmNd1ye3a+Bqv2u5cxBkNmEf1mdMiu
 7EPjgwD54JYTw1uQMerDcrI6xgIj5/Knu5MA/uBTjpmoyGojraB6oqM3BhgJoX9TDT/q
 gpWrPpAylT3e9AD5b8YhLPSw1qb/21y2EQdAn8sWs4Op6+RrLviMnh75q6NgWv8T2Sul
 c77QOaiucZ6+28LtVhhTmxgKnQGT/BTj1D1yz7lPFQrCID3naZ+k8d2VSD5gih6yQb7p
 Ju8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714162712; x=1714767512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JgDBU2AIbrsQ47mDrqYmZTI1+5aWSHVonXPYPQDCiIc=;
 b=DjWPy0uhjPUGZ5D5MUp36TKcn8IFhSzm5Vio8kmYjB1eeSG2g7qH03SP6IErQfkJto
 jFMwCuBdG/TFPekSLnJlOh9mw/5d/O75u6S1NTXRkjFTGvkkb8a82Zu4FaGIdJ0VhzLa
 5xIYYCBtr9/vnWxoaG6O1iLgv8mClRM70GBRsIMauT8l6k0MkbcjFZMVXkFfbpujQg1Z
 z+oARJATEKgjaAwf1YRWTTNzxhHvLTeLGPoWuWhUhL9sykM3BBFljAeEfdn2gPumwT3h
 0jXHQ0qBeQMfSxUQXmjmgSqLr7DUTkjabJxwnNdPZLvTMcX3qFIZZzsPlT56ek1/IIoo
 rrzA==
X-Gm-Message-State: AOJu0YxJepvu+IUdPscCF//MgyScmzUwNgYZifoN3Ea7mrBNFlBGUMoQ
 s96ucxj1re6v99NtZYpwJbvZveM1wD+WJW783aL8sNXf3tlryhEK
X-Google-Smtp-Source: AGHT+IFcugFxNmWYS5Fjcq6LQ/oo/4JK/R6yk3ortBJ9ZyHMCFC4U60fdngNGe6gzqmQVyqQOx02mg==
X-Received: by 2002:a17:902:c947:b0:1e9:519:7dc6 with SMTP id
 i7-20020a170902c94700b001e905197dc6mr4391629pla.55.1714162711749; 
 Fri, 26 Apr 2024 13:18:31 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 q7-20020a170902a3c700b001e434b1c6a6sm16200996plb.58.2024.04.26.13.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 13:18:31 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Date: Fri, 26 Apr 2024 13:18:28 -0700
Message-Id: <20240426201828.4365-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/rK0xDlzUoOfnf4ztzii5VSNnSkY>
Subject: [Bpf] [PATCH bpf-next v2] bpf,
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

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index b44bdacd0..766f57636 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -469,6 +469,12 @@ JSLT      0xc    any      PC += offset if dst < src          signed
 JSLE      0xd    any      PC += offset if dst <= src         signed
 ========  =====  =======  =================================  ===================================================
 
+where 'PC' denotes the program counter, and the offset to increment by
+is in units of 64-bit instructions relative to the instruction following
+the jump instruction.  Thus 'PC += 1' skips execution of the next
+instruction if it's a basic instruction and fails verification if the
+next instruction is a 128-bit wide instruction.
+
 The BPF program needs to store the return value into register R0 before doing an
 ``EXIT``.
 
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

