Return-Path: <bpf+bounces-22447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B585E4F8
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81650285BD4
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6318E84FA5;
	Wed, 21 Feb 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="S7BTdy2Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="NovG3+M3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HSIm50yo"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3283CBC
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538071; cv=none; b=SxPMYfLnxl0tAM2z153uMZ6Pa/IXEnTbg8kAOJ4FXWvghS3DDK/ETXcMQwGJEBBo8z763M2cxD1bDIYUIuotDEqMUr4DKQboevwxC9CzDliYoDUDd6wps36ZHBxvO/hXAgpjgRuaq99iV56MAxrvqEKH+O5+lL2/gU9q0WBwCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538071; c=relaxed/simple;
	bh=PzfAXjX7v1crOclmUcGiSeD9C0BVPbS327hixZKzkBM=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=r5Sj7AN/iE+fCLg4tpxhs9yaDnuC4obbjQCjjbQz9VN8TV7Zw/ewa0JP6DQHIzPO1KZt8m0/5bWJ0D1o24P3aMjuMjRw24WuWZsXI9RNiG7i81UXN/d6ltrtEYTa/8sAxtYoQDkNymFmYTqOp1hUypPPdDsQrDrhx0/Mc1d04Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=S7BTdy2Y; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=NovG3+M3 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HSIm50yo reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 76203C15198C
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708538069; bh=PzfAXjX7v1crOclmUcGiSeD9C0BVPbS327hixZKzkBM=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S7BTdy2YOzuM7gAKzNlhSMPaFNSAfD6vFXBFbpoIsdOuUtpjfS0C4oRCGKg045kfQ
	 W77tJGs4KXkKlQtWYdRJCVde+m3B4vPDPIm8XGRBV2miWKLj2qXDxnrbiynWB+nxFz
	 uO0zbBpikzn9PceMPwQ/BWqMvxY0zmQVVNcxssys=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 468BBC14F708;
 Wed, 21 Feb 2024 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1708538069; bh=PzfAXjX7v1crOclmUcGiSeD9C0BVPbS327hixZKzkBM=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=NovG3+M3JEJ9e5cpvEN83kH9BpKX8NN5M2rPRtPtG+WmVGzXGwq5InhliPjVUi2L5
 j0RhiX7T/zFtqx3Z06jZIGJqtwXVCxTuNGpgLqgQZbGjanx/hktgTKkDwuKODSN9+t
 lPEaSHHdrVB9V1dVvlbYsaOuYlPvBUh9hAIZgMq0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 32649C14F708
 for <bpf@ietfa.amsl.com>; Wed, 21 Feb 2024 09:54:28 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZShMDnTSehC for <bpf@ietfa.amsl.com>;
 Wed, 21 Feb 2024 09:54:24 -0800 (PST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5734CC14F705
 for <bpf@ietf.org>; Wed, 21 Feb 2024 09:54:24 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so638565a12.2
 for <bpf@ietf.org>; Wed, 21 Feb 2024 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1708538064; x=1709142864; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vAiLZN0pi4jLVX7vFnkPjwRpkLJWTLMpGcIfhD7FtF4=;
 b=HSIm50yopX0tOpMSe0k814hLXY3BWbIXhAxVVgFog2FthWf5+d3wrzR1QHW6laJC2f
 ksDS6rsXvAlbDymEl2Z4tYFtGgLlqcOlgfP/HfNya4Wd4CW00CfQd29pHg9dmLWcSUH1
 evAWAp872G0nYj2c9W8r15B+fD2v7SagTEBUm1aYszo9ykBPC3QbHtB/k7SkeU0WcX61
 fTBxkA2vPLrBQDopeVCN0dbbBILVaD4H1wjOqKAg86bsP7OJltrhshg0GBZYfKbdAcXz
 c+HMAhrenwkuwyjjOA1uXOkSUlA+WyNG5a/+JLbakJdKFiktkr44Mzz5jvtGy0W+VxJB
 kw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708538064; x=1709142864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vAiLZN0pi4jLVX7vFnkPjwRpkLJWTLMpGcIfhD7FtF4=;
 b=KtHWI2JqTb804nfzBtZqSDPIMay/JNLf3iH+PY+qtojQfpOiRXfBVk8jHYXA4X1Xag
 oGV/f11r9iihWj/2zAhieNpz72xEY6JJ3QTBB5bA9QdE8Ohs+jbqAc1QsSjexKXNPmN2
 AhD7m4XsAzFUG5fxUJMtIUzRvIFBfRHY3/vItvGeP32SOT112g2/PApNhRosjHUcWhtV
 8D5iodswZ46yXi5f2nJ1P3YZLJLIMgs5oO50p1uv7o5FUfRKcJ2qpdsjWTTwEsgceMvB
 rcWkuCqDuaQuozWRQl0BaUleSVUbW+yC26lpYO7z/+OwC7RUuu8IVjbngOlume+Banz0
 7p6g==
X-Gm-Message-State: AOJu0YyeO2h7q2fyT7sJs60nvbVUX1AxGwBtVU74kdfkAWx6E9GUJsXF
 kIqZz8bOGu5x7eJo2htSE1DxNRI+QPFXcS3SOpx+2VeEfVcjsArJqAFIZJ3F034=
X-Google-Smtp-Source: AGHT+IFAhoJgj8lUvdtNWDvCdSpWzoSxplp41JWr24eC0mdWkPZ/MJj6PzFGzcvtZVTAUw2u9PahbQ==
X-Received: by 2002:a05:6a20:e617:b0:1a0:912c:ebcc with SMTP id
 my23-20020a056a20e61700b001a0912cebccmr15782753pzb.43.1708538063685; 
 Wed, 21 Feb 2024 09:54:23 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 kk8-20020a170903070800b001dbb11a5cf3sm8427669plb.63.2024.02.21.09.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 09:54:23 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Wed, 21 Feb 2024 09:54:19 -0800
Message-Id: <20240221175419.16843-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/1IajDsjWY2_43rX_qmloFkIADcw>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: specify which BPF_ABS and BPF_IND fields were zero
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

Specifying which fields were unused allows IANA to only list as deprecated
instructions that were actually used, leaving the rest as unassigned and
possibly available for future use for something else.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 868d9f617..597a086c8 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -658,6 +658,7 @@ Legacy BPF Packet access instructions
 BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. These instructions used an instruction
 class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
-mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
+mode modifier of BPF_ABS or BPF_IND.  The 'dst_reg' and 'offset' fields were
+set to zero, and 'src_reg' was set to zero for BPF_ABS.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
 instructions belong to the "legacy" conformance group.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

