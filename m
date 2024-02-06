Return-Path: <bpf+bounces-21278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B818A84ADB5
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB0B1C23240
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A467577634;
	Tue,  6 Feb 2024 04:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="m5cmLE0I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335E1E492
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707195113; cv=none; b=k02nOQqWo3Xxlztaq+35IWk3uLwdyJen/CE7sLDwYy1f7r5MFnFZcFDyG/+3CxAkW43fonUB7jF0Ff1hO53TX3MaVOnIBerVzusoiNqQJmB5crNZNeFWZ4/SvdLyV/bt+Vv4sXB1IxdcW1cndwvCWVsUnVNbJNNP5mNye0ZjoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707195113; c=relaxed/simple;
	bh=GgemygxAyUqgqORqzkyrbDeQUvo0EJdEvXWt7SZe05A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGTDN7w+7TeSjgOPgept4RJzfNMPa8Kb6X9n/PhqBMNUK2u9aVRrWp55UoFW0m+hW/DSxbGovOYkJY4QhZe7eNtNKqGEFA1AijmhTG84mTz2M5D+MvCXyqJZbe/7P59kgQdtSX053w48BZ4tuecbimyP2NHjSfV1NGifU9jLxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=m5cmLE0I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8ef977f1eso39308495ad.0
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 20:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707195111; x=1707799911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9JhFREGZ5CoepqB+/CwW4U3bJPSdUrEAa1K7KoVJ2+o=;
        b=m5cmLE0IfKepqSZF/U0OWk/G6rhhlFerlZvGvrk1+3ZYnJVUOjGOfQbbvkvMQDOJYA
         xAm0ckY0HubEj3YUrv441QJiDcr8Kbp3x54Dh3Hbt1bpfWTx7plRiSGJbWuZddfHgyTw
         MbGLhJXE4vgxYLQUuNc5TML2RNC2fHVfTFymcFzLeDaIHbSz6CSL8s1laT1/z79iS6i5
         6AEKMNuiIBngEuD1LesVmmwcS6i9HQK83zSJ2XhVgyRbbTvdP7gudjMX8uPu2jWjqeJg
         GyniACDim7ECaS9VmXab2STh+07Mj1RkgB/tDSl72NJnYxmxYFcPANJI5j15AUbrJcM+
         nW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707195111; x=1707799911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JhFREGZ5CoepqB+/CwW4U3bJPSdUrEAa1K7KoVJ2+o=;
        b=anRbYmOKLrhO1pzFwlcHL8fj4nGr3/hX/rhtPitly15WqdwxYeLeC9gMcGrR6Svrj1
         PXr+X5bEsqtwc/AO1Jnm0PnisCV2oWJx/dlbyAKeqd3m5ZmQMQ+RlJU6n4ZtdnaFkC2Z
         Bnj0G34Aim8AGH0teGy/fZUYTtA5BMLuE8JmAqLXe6NdC2r4nID+h6rN0919DOR93+B1
         4QTQECrR5u/oFFyEDql9JL7Chc5AzkOU3yCfATpNr6CpmM4o97AEiUBwNwRPeIz311y5
         2yIDLJ0OrV4Ir+EqEg4TYJh553fKpDmjcLLfUJxgd1kV++/nXGIL46Wm4tDvDKaTfSvO
         UEhA==
X-Gm-Message-State: AOJu0YzSKBCxQNeNRDdFK51qgr3OVOsE1AS6B2NLrQWYWn2qR9br2Yaj
	Yn0rm6ga0/uY/hIaseX5IK2Lc4oGKyscTGOLhiyFw5phdmn7TcC90+DVI81RRUI=
X-Google-Smtp-Source: AGHT+IGRmGV2YTayw8tiNwViDSwnb7ENVvumW4Q0sZ8buS1BrLW3DyCvv0saNmMxAqGpr+FG6X5EVQ==
X-Received: by 2002:a17:903:192:b0:1d9:9735:ed6c with SMTP id z18-20020a170903019200b001d99735ed6cmr617892plg.14.1707195110770;
        Mon, 05 Feb 2024 20:51:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGhy+jWQnRvlKs6iECCYvXm5EcplOULkxws/eS8yjzhG90Pk44O/C7u5mnCYQ5msW6peRVAygTbYZzwjh85DaFZb/GvVY=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id jy3-20020a17090342c300b001d95b3c6259sm774613plb.263.2024.02.05.20.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 20:51:50 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Fix typos in instructions-set.rst
Date: Mon,  5 Feb 2024 20:51:46 -0800
Message-Id: <20240206045146.4965-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* "imm32" should just be "imm"
* Add blank line to fix formatting error reported by Stephen Rothwell [0]

[0]: https://lore.kernel.org/bpf/20240206153301.4ead0bad@canb.auug.org.au/T/#u

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 1c4258f1c..bdfe0cd0e 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -117,6 +117,7 @@ corresponds to a set of instructions that are mandatory.  That is, each
 instruction has one or more conformance groups of which it is a member.
 
 This document defines the following conformance groups:
+
 * base32: includes all instructions defined in this
   specification unless otherwise noted.
 * base64: includes base32, plus instructions explicitly noted
@@ -289,11 +290,11 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 
 ``BPF_XOR | BPF_K | BPF_ALU`` means::
 
-  dst = (u32) dst ^ (u32) imm32
+  dst = (u32) dst ^ (u32) imm
 
 ``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
-  dst = dst ^ imm32
+  dst = dst ^ imm
 
 Note that most instructions have instruction offset of 0. Only three instructions
 (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
@@ -511,7 +512,7 @@ instructions that transfer data between a register and memory.
 
 ``BPF_MEM | <size> | BPF_ST`` means::
 
-  *(size *) (dst + offset) = imm32
+  *(size *) (dst + offset) = imm
 
 ``BPF_MEM | <size> | BPF_LDX`` means::
 
-- 
2.40.1


