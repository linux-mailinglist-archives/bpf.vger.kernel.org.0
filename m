Return-Path: <bpf+bounces-21279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D284ADB6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9F61F23DA1
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA678695;
	Tue,  6 Feb 2024 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="LgMid5j4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UD3OkjIs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Fef9RTgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D501E492
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 04:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707195118; cv=none; b=geGpqNIKDaxITFer6lew4qXcNJSqUN85H3j9ISMOekGxtZ+foS3DJ+9GkigFix4o/ngCW+np3yagTmji+tqwQpNq/4OgbIiglcZr6CZaHUpeqAHL/aAeI4HD95y1Q3AlsslXu6OX5UBqqvxmiFyzAB8qkPGf7gzYW538YnAv3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707195118; c=relaxed/simple;
	bh=p/5q5OkKZTfQxwzwkR16Lhyfl8fAzmr+t7DoDushcWU=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=WoChgTmWqd2MtrZQIpcU6BqQpzQukfVd5eSxFXX2V2Qq0kRjewcd2Z+wJm/Lrrxjvmc2zRXWOCVWSdMmm07y/c2klpTOp2ukm4YCiTbvgS40Kpb3Z7t92LoA+8qEXEjXn1F5g+Dn397Q9eVuFHGoFx4+X/lwN2rA4XZJpCyrIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=LgMid5j4; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=UD3OkjIs reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Fef9RTgg reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3308FC14CEFF
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 20:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707195116; bh=p/5q5OkKZTfQxwzwkR16Lhyfl8fAzmr+t7DoDushcWU=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LgMid5j4bzxJ6VbMumqf7W1gTmjjOFSto6z8EqLmg9Qafgz2Wf9OJOvl7ERIMHeIj
	 Dh6cn5lZUzvVKN7bV/EzLdAX2lSqeVsW1bRA93WGFlov/Q8EgqmKHqWPXvI/AEJgO1
	 fqeR2FYDXiXFY5s5s6LhchTapsewggl31nK6pZLs=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id E7166C14F6BA;
 Mon,  5 Feb 2024 20:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707195116; bh=p/5q5OkKZTfQxwzwkR16Lhyfl8fAzmr+t7DoDushcWU=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=UD3OkjIsM4Ee3sTDyY3is50lU/yAhtTByf/CXu1xA/299X8/YUzLm5O1AknJdx0MS
 BDup+OkGXr33pCUO7BAHkWesHHU+Iuo+DIzbkNsAv2aXcc5r0+QSu7wHTdL05c3uXZ
 gyxibnKjdBIhsjQnCfw8SzO1hi5i2hP+ypHONalY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A6C6CC14F6BA
 for <bpf@ietfa.amsl.com>; Mon,  5 Feb 2024 20:51:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3Mc0IX8IJdy for <bpf@ietfa.amsl.com>;
 Mon,  5 Feb 2024 20:51:51 -0800 (PST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CA642C14F6B9
 for <bpf@ietf.org>; Mon,  5 Feb 2024 20:51:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d918008b99so39244475ad.3
 for <bpf@ietf.org>; Mon, 05 Feb 2024 20:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707195111; x=1707799911; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9JhFREGZ5CoepqB+/CwW4U3bJPSdUrEAa1K7KoVJ2+o=;
 b=Fef9RTggDU2yC8rV6gJWPTsho7UjI7oMXG2Z3FxGSqXhnLalSO01M6/qflvkhiO1Mj
 FPqiQIu9LYfqQRtNixgAQ3ic6uBlxcsNiqU2FpA5yQqcS3hXmh/gml1PguB/rL3R9zVn
 1tN0Fa9tx3WMAO5yIMeOZnt66X4TIQ1HL32ZJGv4dT9lRZNjDyc/fk75pxKe/Awdl6Ug
 ztckvQ7U3DecVsQAaw6eEvFufg+AkJqgPtVdaK4Z4D7efvvhQYb6SLnNRDrafazzf4Cx
 DaKkktPJZqU+R29B11dfN/ovVYm7q3HIVHNgPlwc+zFKdVt+FlUiFVA/MV23zDXRmobj
 G3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707195111; x=1707799911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9JhFREGZ5CoepqB+/CwW4U3bJPSdUrEAa1K7KoVJ2+o=;
 b=Yq6AlsSbS5Vll93Z4e/6GO0nCR5qmLsWMjsN2aLVDVTxMgzMNcZBi95Bv2ahswWucd
 vSbmFPidj1opx7YJgy5qRd8fyGJ7uU5C+DL++/vuk7cJJkXcb0wPeB0quU3kFEQK9R1O
 YvI+IIwslrmAYhsv7Qo8HpSwFXf6QlClol7iZXwj5iJqtEKNN7dTJN3UNcZhrOTjIKRc
 hh/wNfUadq0OMOeDLeIwfx5IFsGJy6+nm9EkL+at3yhjpHD3GpmoQVR0xBOyZjBdp9IN
 jPN9MBV33NNCXvN2HSsOE5QgHSxwAMs/2WKp5UlyidUHq1enUiErh9CgNTP1ESvq6mMU
 LMyQ==
X-Gm-Message-State: AOJu0YyOhDkjvjqfqo8ElNiFnVNZGMFh6eZ8hlue6ar5hil4UZ4DO2r5
 iR1sQ24TzwcJ3YwNF9M8fa3adWdzanEINHNi+Fou8s5zuxMsbSjW
X-Google-Smtp-Source: AGHT+IGRmGV2YTayw8tiNwViDSwnb7ENVvumW4Q0sZ8buS1BrLW3DyCvv0saNmMxAqGpr+FG6X5EVQ==
X-Received: by 2002:a17:903:192:b0:1d9:9735:ed6c with SMTP id
 z18-20020a170903019200b001d99735ed6cmr617892plg.14.1707195110770; 
 Mon, 05 Feb 2024 20:51:50 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVGhy+jWQnRvlKs6iECCYvXm5EcplOULkxws/eS8yjzhG90Pk44O/C7u5mnCYQ5msW6peRVAygTbYZzwjh85DaFZb/GvVY=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 jy3-20020a17090342c300b001d95b3c6259sm774613plb.263.2024.02.05.20.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 20:51:50 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Mon,  5 Feb 2024 20:51:46 -0800
Message-Id: <20240206045146.4965-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/afoxfDzBdjqB8HhB-uYa9ed9ERU>
Subject: [Bpf] [PATCH bpf-next] bpf, docs: Fix typos in instructions-set.rst
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

