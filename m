Return-Path: <bpf+bounces-21554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C593384EB74
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA47D1C22D48
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2F4F616;
	Thu,  8 Feb 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="glfPNyyv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="NwYygSPj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VjK1S/Zw"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2B4F5FA
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430521; cv=none; b=d/pI+o+KuAOl4xJjQkK2f3zAo9KMjHvzuM3vXvlEHFyxa736IPPTwFax8/hU6reM7j6DnGXB+12iJ9g8GlxpRL4Aszf/JMFRB4Fd8b+5GFGe2SksxHK6pSlCk/uiC/1n9U0oFpGgg2k8WC9KIW79Ip9ZIsiMGEwQCc5G3cyCthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430521; c=relaxed/simple;
	bh=rp47ZApYVF3CLY2r6AYT16tmlL+Mt5F8dVezGLwRI60=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=K8MSsjtcsKdtJHzsuxtj8OPsAMh/n9PDCCAalLIMARCjs/cpEUyWTHRN11S8XaOy0U0fSb0K3xX0pSVQtNhteBg++ki9ycL7I6JdXqCCCtlvkfQCFNoSmYeNmzo/CgFVdb82aLcuO2YvBxBrTeIKlk3/sH5Y6LdtxgA/BB53Daw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=glfPNyyv; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=NwYygSPj reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VjK1S/Zw reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B14B9C1CAF63
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 14:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707430513; bh=rp47ZApYVF3CLY2r6AYT16tmlL+Mt5F8dVezGLwRI60=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=glfPNyyvvrK5ofScR6oaDGzVyhWq7T2wFLBVcIUBfIgGg0+mRJjTLdAuLsD9GYBgb
	 sjZJnZFjZz8SsNqkCGqhaUuNJk60DSPQXGGUgN/zHPfEyRWGnor6Z3oIRE4YtnxbGB
	 8tWp9ZEQaacEGxkksPPxcjTLfq0lDkn/dBFCJ760=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 89B7DC15154F;
 Thu,  8 Feb 2024 14:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707430513; bh=rp47ZApYVF3CLY2r6AYT16tmlL+Mt5F8dVezGLwRI60=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=NwYygSPjm/3cpeRHFyBpuzFBQbDOPrq6hiQ6vahvTMs8sI6TraWYku6DgfeVy0iAG
 hFh7mVBthD+nr79eDI9ENZScSrPiz4dzcvmoquVBVQdqyWgTgBawo4UCAyozhJQS4f
 Qb50lv4gN1OpgXmAv8U/A5hY/IhnSXRA3tAg7rW0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C8B7FC15154F
 for <bpf@ietfa.amsl.com>; Thu,  8 Feb 2024 14:15:12 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id onW8WbqLVfto for <bpf@ietfa.amsl.com>;
 Thu,  8 Feb 2024 14:15:07 -0800 (PST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7A3B5C14CEFC
 for <bpf@ietf.org>; Thu,  8 Feb 2024 14:14:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d780a392fdso2280615ad.3
 for <bpf@ietf.org>; Thu, 08 Feb 2024 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707430493; x=1708035293; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TslwQ3ipme5SpeiZwhrffuh7Ucx5TElMvVQFOWDiWhg=;
 b=VjK1S/ZwpKi6/ce+PBogx51ctPdShUt+gHttOJWDETnQNfi3OP0QS9IL69hFloZxdI
 czyt+8RKpuN+QeGqe/vAV0pdG+uxQ+tPF+b1Yzyf2IIQdy+vb5ipOtMJ5ovj1r/ESci+
 S/pJNaMuYzW3Q8Nt8MWQbGTg+jg7JNroUN7cl6OpsTdjufkUaT4ZRzxUDGEtf5KgBjHX
 lywhH4+gkBYNxM5rbGG4JjUxAlSPAiN9Z+nYijqft3An7bnY5JBPxGo7jkyfq/pDageK
 Tu02DTLJTGMXXW5ZUo5GhxwcegjW9e87mMkVKa0GpFU5DNQsqU15t2yD/mSGi9WDRivr
 zwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707430493; x=1708035293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TslwQ3ipme5SpeiZwhrffuh7Ucx5TElMvVQFOWDiWhg=;
 b=OL3rUOexPYfGQybdfyp5kiI5D5bjmNNRTrIlJp9Es+7CSXCWrIuy4WLnA2FC5ATdE6
 iRoc55v+sjcmtv6WpUyMRC66S73e/jWVI1CRpRo2ipsva/6geMNlG67uCoZR83zxp7XI
 YSuY9FBcQIIG50dsIvrsf/A2qYwsIPpQdaWZkoSJJbqk37PnM2sFl5yYiLki9XHiaEAT
 W7wjNSXAQ7vL/kVzrjXPga2O7redC4yknsUzzCoZc6SA39zMmlPHRvKK2NnPj5HnAxXp
 +3sLERIqnPKr6jVDmiGK99XcPMOl5NU0yBolNVifpQ21JwQNmKdH7LYndyr3i9A3yp8p
 n7Uw==
X-Gm-Message-State: AOJu0YwDt+5h+zi0cmpWuxLcQ3lywZYXLIODB4eQUSuJNulOJpmLzEKH
 Y6rxVE8e0dSkmEICJInVMZWESC2p4VlRa6vZULRppHroGjH/bp4bKWbeISiHY/0=
X-Google-Smtp-Source: AGHT+IGlQKtqpZZdyVe6q1GsedLmcNPuTDXqsROPx4fWCP9+iM4FCz/SpuO6+//xJghMpqAivI9VmA==
X-Received: by 2002:a17:90b:2317:b0:296:6bd5:42df with SMTP id
 mt23-20020a17090b231700b002966bd542dfmr668554pjb.38.1707430492615; 
 Thu, 08 Feb 2024 14:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWVdW+bbu50ZthDHHoaBIIM6AjYliuovtdpoQOiVEQ9s0by2iwqmbh1a29BIdYs6VR1HfP1IefOwGurrkZWmw2Mj5h5OMQ=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 kf3-20020a17090305c300b001d90b9ec345sm259465plb.114.2024.02.08.14.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:14:52 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Thu,  8 Feb 2024 14:14:49 -0800
Message-Id: <20240208221449.12274-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/NeURxAIvEURLIlHWMx08u9xetTc>
Subject: [Bpf] [PATCH bpf-next] bpf, docs: Update ISA document title
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

* Use "Instruction Set Architecture (ISA)" instead of "Instruction Set
  Specification"
* Remove version number

As previously discussed on the mailing list at
https://mailarchive.ietf.org/arch/msg/bpf/SEpn3OL9TabNRn-4rDX9A6XVbjM/

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..868d9f617 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -1,11 +1,11 @@
 .. contents::
 .. sectnum::
 
-=======================================
-BPF Instruction Set Specification, v1.0
-=======================================
+======================================
+BPF Instruction Set Architecture (ISA)
+======================================
 
-This document specifies version 1.0 of the BPF instruction set.
+This document specifies the BPF instruction set architecture (ISA).
 
 Documentation conventions
 =========================
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

