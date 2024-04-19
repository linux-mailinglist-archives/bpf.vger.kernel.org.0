Return-Path: <bpf+bounces-27262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB1B8AB684
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F2B22B3E
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386513C9D4;
	Fri, 19 Apr 2024 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="vxzOo4Rt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZPe8x/Gc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OVU/35QC"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4B129E7D
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562718; cv=none; b=WNL6UUoflPb7sv7Yt061jPJTE7OZd7CtqX86CILfXcIRODDfsW+o/WElGcPTpc2yfK33fO53qWaE5bd8thjBPvy68KaK6DmtVfhLe74leP4B/R6GTe7xZy3oP0bddHhmQ2q+STi9uOQk8hjz9Cyd10Mm+8k+m9xBQyAW4BYhdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562718; c=relaxed/simple;
	bh=CxbYjo9u+QIaS8mH3ox3+pPK9N74PF5knVcxk7GfRHE=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=TCr/IjdmWIOD21XHAeVQLy0Lz9eoQrSXrn6uzbMbW492snO1lvxvkLGXl0TyFxQmf+8gnspU/6HA6Vs9mWKJcw+PuLMnJfA1xcshEcpFHn8Joy9JErmuRDJ3m3CVH/nsjKwEIGTv4/nD+Xk5JQmXtD5NNvVP5knhMABlA4crF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=vxzOo4Rt; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZPe8x/Gc reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OVU/35QC reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E6346C15109D
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713562715; bh=CxbYjo9u+QIaS8mH3ox3+pPK9N74PF5knVcxk7GfRHE=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vxzOo4RtOV5PRu7rP1Y1c4NCaRMAFfYIZniPYyEFCmPhTxo4rC7KbeSvlHv7pP7tI
	 OuFvCrQbCm34GpW4LP07Fbczn02TKgAgHlG0q/zE0y9/vRmVbyVhT/7+iOU88KcnPF
	 jZIvhuUO2yaXl5m6gi54IOsKqdM2KTGEiH7KQUCo=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id AE707C14F5ED;
 Fri, 19 Apr 2024 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713562715; bh=CxbYjo9u+QIaS8mH3ox3+pPK9N74PF5knVcxk7GfRHE=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=ZPe8x/GcSVcJjBjFyggEIxfJlo+7e7+YCXn4rixK7Dztb/pglLLQkAlaSzC62k3Zp
 naf3Vjn6juktcEohsR1EzjEwhU+9VOjOdFhKb4GvDKnXKbNoz5KGHjtY+yqdh7V9J8
 3MBCAbSLcvn2pWASxUdNykC/vqY7GmMt35CjSYiM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E2361C14F5ED
 for <bpf@ietfa.amsl.com>; Fri, 19 Apr 2024 14:38:34 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unTurDOFy3Gq for <bpf@ietfa.amsl.com>;
 Fri, 19 Apr 2024 14:38:31 -0700 (PDT)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1C4ECC14F5E9
 for <bpf@ietf.org>; Fri, 19 Apr 2024 14:38:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so18728275ad.1
 for <bpf@ietf.org>; Fri, 19 Apr 2024 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713562710; x=1714167510; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhH2fDPoebOT1miU3yZ6QUPdr8Qf3wsGNhwEo2ogET0=;
 b=OVU/35QCtgRPKMqdp3BYJ3+u2tyQ0cNSYTpej5ldxupCv06dIf5jsdHSjNT52+zN6m
 e4/sfajzVvQN8Y2eXvcDXbNGAtlwNOmFJOahn2Hsde2rjUtajBwl6zr9/fvmIvY0nxJi
 CLCmCwIU0G+PCU5xOxua21poyOjWOxTm/eea+wdQV8ezy5HLdFWzRLzMcjfJRg/B4UxQ
 /etf3a/Rd0uwAt6SQufrG7wnF+HZmL9GBH6QqHGebxBgXip90JwsGpi7uraSKDsb+tCc
 Q6FoZgkL0KrmBccT7BMytUdgc8Y6a1E3KMykItbvHmDLFKXWPUbVYiIBeAsszOuxSAw3
 57DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713562710; x=1714167510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhH2fDPoebOT1miU3yZ6QUPdr8Qf3wsGNhwEo2ogET0=;
 b=NOcp/lLuLsOjPNYAsdm2/vTxKwWClGwj/AtwaWuuPte7o3jZ3IlBMDgaDcItTBC7em
 vx3OegM6Iy8Kmj9SsLL5CnAb7TnQwLS9Gt7k4ah6apd+GAP/Ft6TRuNReFpOMjZes11e
 KQzk3mnLopeNXVKBO/ub3gZGdD6liHpoTsGn2d3kuAzfn8mvzB9MEVxKrNVzx13yVloY
 B8SmyOzuhDuhuLYA09sxhmz2H0KaNK40KmLO93EsPmJcsSDEiR51+7XSAZEM/zJ7Tj0p
 AaGNl2MOeMF2D/y3YwO5QAvD/2wBJPWyLcBh+X1FZ9Sjvi5HrufUxTUPH9YA68p3VP8Y
 9lLQ==
X-Gm-Message-State: AOJu0YyaqWe8cg1CJifhGalctxSNOS5nWapat3WdNRQEA6VT5n43BsqU
 V7NQCzs+tng6L9HsyMdbeEqT5viWEBxMMKKy/bLjlSMgbgo8kLJI
X-Google-Smtp-Source: AGHT+IFTIEvox+BPzjcJPqGsjk02Wvswzaio8qnIc15v/PFKaoa/BGwMPFggMnu3urntKBt2q3Pn9Q==
X-Received: by 2002:a17:902:ea12:b0:1e3:e6cb:a07f with SMTP id
 s18-20020a170902ea1200b001e3e6cba07fmr5201686plg.26.1713562710223; 
 Fri, 19 Apr 2024 14:38:30 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 p2-20020a1709027ec200b001e0e5722788sm3921221plb.17.2024.04.19.14.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 14:38:29 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Date: Fri, 19 Apr 2024 14:38:26 -0700
Message-Id: <20240419213826.7301-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/yatI-qX8tW-shSYgrh0RgGrN0fY>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Fix formatting nit in instruction-set.rst
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

Other places that had pseudocode were prefixed with ::
so as to appear in a literal block, but one place was inconsistent.
This patch fixes that inconsistency.

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 8d0781f0b..02fbc286c 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -370,7 +370,7 @@ Note that there are varying definitions of the signed modulo operation
 when the dividend or divisor are negative, where implementations often
 vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
 etc. This specification requires that signed modulo use truncated division
-(where -13 % 3 == -1) as implemented in C, Go, etc.:
+(where -13 % 3 == -1) as implemented in C, Go, etc.::
 
    a % n = a - n * trunc(a / n)
 
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

