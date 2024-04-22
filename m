Return-Path: <bpf+bounces-27464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1DA8AD4A3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8609DB20E60
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99CA15530A;
	Mon, 22 Apr 2024 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="hd2nMXjw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aL6+o8bk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aG7yHF/z"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A77152180
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812996; cv=none; b=Ol8aIbPpK0A9oFW5vR2AgiFmFcGt0vbXHVjeNbry3j4uZhBcJboc98lgAwdyMc9LAU+SYcWM6iziGBlJTY3mAErJ6M6csFqLTZbRxHB0n2LQCWK+5vWqF8gh6HZiObVJOffFpnWyxjw3HZ4BXxyh56glCRcXMRAHdeAXIHwW2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812996; c=relaxed/simple;
	bh=AXGXMUN0HvX2RQ2bk98SJjB2/i37LOtZiuajx3NKcUQ=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=iwg8EDS8ijJl5IL+oeAQ0tdHDU+baPvU4F2F5YBiiEtWo+/J13EeoJVXC5/tCfNJ63UDGp2WolX3qI/acZ3Z7XahpYBcUbv1kzvazxw9P0Bs3a71QAhmRwKDHYq4YAWTezSR/f72lIZC9r6W9RDX0/koLaAXKh5cKYtb+UXRB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=hd2nMXjw; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aL6+o8bk reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aG7yHF/z reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A6FD4C1CAF3F
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713812993; bh=AXGXMUN0HvX2RQ2bk98SJjB2/i37LOtZiuajx3NKcUQ=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hd2nMXjwYCUVaICXNzxRs3gN2Znz/LIls4IDhhaNtGtVAh0vymQkzPFdty6PHjkQY
	 6OmjKVyPa1wQvUhoibrbJN3zfTZMFHWjI1RAJL8ue+tJzDZOo9KWg1R704zEio37Qt
	 J99rSVbv2r4HFJjb6tDZnK2pEI9B+eLKgBzEU+D4=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7C306C18DB83;
 Mon, 22 Apr 2024 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713812993; bh=AXGXMUN0HvX2RQ2bk98SJjB2/i37LOtZiuajx3NKcUQ=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=aL6+o8bkxpzvs5OY/lNDhIfppf+U+BeIIhrHdbSiBD2NtEEgB0m37D8CjXK0nfk9V
 NQWIpIsNzM0p15ckIS5uR1GR1L/iup3LRGc5rlP+xAhREO+FrA8u/WyFjsTl+a6WUc
 xde+OU2eeEwagE+Y7Y3qJstINEIuHM+Z86Uap+Jc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B828CC18DB83
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 12:09:52 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vdY-t_WIIjT2 for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 12:09:48 -0700 (PDT)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9DB5DC1840FE
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:09:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ecf05fd12fso4547602b3a.2
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713812988; x=1714417788; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rGOXjPZgt2q5MzYfPqLwFNnbtyA3bd/HxSwCsxXiUSw=;
 b=aG7yHF/zL1+i6vZPCp1NkQkHSPwOxpnOAyNMaD3SocqTwKIFCwOxPQM3zHlBaOg5/j
 ypFMcZjIRzfXYmgGlDjOAVrbxCytt+cgcW5rg2631BF3MvpvEYDKYz4+8kf7ZEV6MVx3
 jbZ4ajNEIm4Cd3kpis0wP5az1r5a6nRq+XYmSFV1BVsfFJaTko6RWl2z4AYyFnQgg2fp
 ar3GOKOIjStNoMjzcHcXFb6h0Mtva1QXCEAsJuX2Gn9fPgfILw00nzX7h0sW9kFOyWxq
 alLxv47WIp1m/LM3Akk52AIQXtdxioojdS+qeQm81cPFuYrt8gN0ADbriPqRc0J2eVh9
 tgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713812988; x=1714417788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGOXjPZgt2q5MzYfPqLwFNnbtyA3bd/HxSwCsxXiUSw=;
 b=etSHMcVF4z8L+iyPk7fGwR4C/aVkDBWx4f2kl9e9Dc8rsVxfimzch85FDXS0KQ0xif
 Wv010DUKIyN2lrCLhW4DUlrneqUL3ZRB0hn6P5fI8cWvVa5slPZWe8tUz9Yv+bITTpDk
 WgMsxMs2EPvHtO/D1kJvsJVPNCFMF8VVmV95p2xcXODNPtFh4e5ZGwRTgP94F4bW6fgN
 Zbwgm2g0wmkAAko764KTpJ8ALaPX2bgo2VLHdA3O/tivsloVlajZUT13IFmN8OHssqCJ
 pSKxMNET7rt/YIaWPRI4gyi8q0pdfPeIYvfe/U7rlSjr1e41G9FhR4u8NfQJ8mLtQPB4
 hvwQ==
X-Gm-Message-State: AOJu0YwGum3PUxRMXXlmaSPnGyBhsHT2cWbiXxNtCA8kne6bF0Qj7+7m
 aclktDAY08d1ppemvB79G9svojEBLegzbHh36Vc2np8uLy3zUerz7ldwBV9u
X-Google-Smtp-Source: AGHT+IHQko8Ro7YvNU5/+0OIr+JEyl1KAqudpScEYzaSc1PVyruWduD9DCEuhC0WYEv+t3iVyfHw7g==
X-Received: by 2002:a05:6a00:310e:b0:6f0:c79f:cd7e with SMTP id
 bi14-20020a056a00310e00b006f0c79fcd7emr10363583pfb.0.1713812987762; 
 Mon, 22 Apr 2024 12:09:47 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 v127-20020a626185000000b006ead1509847sm8448284pfb.216.2024.04.22.12.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 12:09:47 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Mon, 22 Apr 2024 12:09:42 -0700
Message-Id: <20240422190942.24658-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Zx5ZwUgSB-SU3JxnIpJmJj9uWvw>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Add introduction for use in the ISA Internet Draft
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

The proposed intro paragraph text is derived from the first paragraph
of the IETF BPF WG charter at https://datatracker.ietf.org/wg/bpf/about/

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index d03d90afb..b44bdacd0 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -5,7 +5,11 @@
 BPF Instruction Set Architecture (ISA)
 ======================================
 
-This document specifies the BPF instruction set architecture (ISA).
+eBPF (which is no longer an acronym for anything), also commonly
+referred to as BPF, is a technology with origins in the Linux kernel
+that can run untrusted programs in a privileged context such as an
+operating system kernel. This document specifies the BPF instruction
+set architecture (ISA).
 
 Documentation conventions
 =========================
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

