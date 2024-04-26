Return-Path: <bpf+bounces-27976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD98B40BB
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19011C227A5
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96B2231F;
	Fri, 26 Apr 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DEL8kQ5+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B391D54A
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162714; cv=none; b=fSIfIsLtmKRBoCGvJB9HvdaJGY1Bc5pQ+lLdK5NT/FqQNl7+Fa9FdlT8lowUGaWekUTJAfJB4eb7blMB0rC9qFf7GZkBl1UNAX6LGWtPw00d0Wc6CO1Ow2WFkL6tAFU85ZP+6bleWldo1zQsMSM9nGcq+KbK4lxzic84s2cPMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162714; c=relaxed/simple;
	bh=UYEkUea1x+S9fs7ZUvLvRMDcE6jTtBqu2ecV7A3IOwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n6bhprTXOZbWg/PKpKbBW39ZjNPN1nGv8pyapBs9RLicmSp/ss+eeiTb+RC7QjAKyRxGNsByu0suQduDJp8p204ZG6kPz71xtQwBV+X0LgPcu+myywF2oKRHXF1G9byQm88k7hT0jwINwh9ZAc+XKCVqzf+qqGEAaAuyktY+TqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DEL8kQ5+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e834159f40so20761225ad.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1714162712; x=1714767512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgDBU2AIbrsQ47mDrqYmZTI1+5aWSHVonXPYPQDCiIc=;
        b=DEL8kQ5+OtRnnEl3v6Lo+Vqi0ofzjdfgto94Zo5yxcotblVvXBFjUhKxowtnW9238Q
         chWnCOs7/wcIY1oyEirvXhpgnvT6XB8Dv8aGWy86JQI3P69b6DPeTVXyWP2Jf2NW4frL
         ctwK7zIBvoGQAK5h6f4hCEy0NpRPkRgVa00/mB6QvTajYpvadcKJ2+u59POmqJJ0Lruf
         fftAZT6nO8I6d92qSWAGsndGFAO8BvTj+U+z4PYATVfA7VKEYeFbjHjAz1F4HkRfinNt
         xn9RDVzSIwvG5S9E66YCBlgFdZiVlsO4rOxf9TdvjojfNPN4aTMLYAclOSTB511tWZpl
         WFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714162712; x=1714767512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgDBU2AIbrsQ47mDrqYmZTI1+5aWSHVonXPYPQDCiIc=;
        b=gXTDnrv05caFqgZJonXoxeOJDdVRkejmO1XjYfF7YJlj7+Ozm7qi2+C4WX89D4PjG6
         tsS2cklaJaElw1fd8QGE7xU4t+YGkHiUkyb7kX/DmPurWCyi7UG8+O3iW0iiBDONNZqL
         rf85BDyOfbRxAvJl2nyyX1dBz1nsHaDESfq5RE9tiNjfLSg2frbzwfheaGFJAMnXJZoQ
         io9zyQHJP6VXH5Dv4tDtJQE5PrIcTN0jkVvODsZ+17npqNrR0y7YZm+7r3CokvLcwSI2
         0ZUv1/ejG6u/x4ocVJFGjCP1tzW9l7aTFpY6PVAinVwiX48vzcRE8ypTmVEpIEtNkavh
         gx8g==
X-Gm-Message-State: AOJu0Yy6TmpoEd0ni5ANqrK5za67MEgDqPiLyfJLWlWRryOn2Wq2DZNT
	09O6vYNvVyWzIgZOLTeIm4GQU0c+CTYv6VlFaSc9/JQ/n8g8N6RcIV6R4iY7
X-Google-Smtp-Source: AGHT+IFcugFxNmWYS5Fjcq6LQ/oo/4JK/R6yk3ortBJ9ZyHMCFC4U60fdngNGe6gzqmQVyqQOx02mg==
X-Received: by 2002:a17:902:c947:b0:1e9:519:7dc6 with SMTP id i7-20020a170902c94700b001e905197dc6mr4391629pla.55.1714162711749;
        Fri, 26 Apr 2024 13:18:31 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b001e434b1c6a6sm16200996plb.58.2024.04.26.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 13:18:31 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next v2] bpf, docs: Clarify PC use in instruction-set.rst
Date: Fri, 26 Apr 2024 13:18:28 -0700
Message-Id: <20240426201828.4365-1-dthaler1968@gmail.com>
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


