Return-Path: <bpf+bounces-27951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E78B3DA4
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2411C21ECA
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59515ADBE;
	Fri, 26 Apr 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KnOGF2d6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="OKki465a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Wk5W7ttl"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEB2230C
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151481; cv=none; b=miW+TISWYfKMW+DZSR3IebrUzwiZuiS0eJi3ghxwuuePS70EpLJbXZ9fb0MNs0KNBWn0DgTyirXRj+gK2fR96AZVBEO+2qPDB+egcIEx37V9CTrtBF7mNkg4yvdeFrX4PBu4CNgNfhHno7kq9H/3/csClCiNDPxUh1lVQ6iMz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151481; c=relaxed/simple;
	bh=7F83scvny5HLxbKUxWo8/UgBnoadOaVIdCLLaSNSKWU=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=OHYJyXv8k3MXtpfrC1O8eWj05tBdOeNTc0qDkeI58uhawbGYY3dfiQbuwHOj1F+3V2a5z4f7w7JIlGrs7swoVUqf0WVCGOirvZH+a7Ocyi5po+1r8wRI7bLJvSUcTSCKalwlGUyMBqktyOOjS06fAeT33RPWcBqHuK7tnF38Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KnOGF2d6; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=OKki465a reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Wk5W7ttl reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3A463C169433
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714151473; bh=7F83scvny5HLxbKUxWo8/UgBnoadOaVIdCLLaSNSKWU=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KnOGF2d6mB76ZB/HVGkvOhsH11h2q+IAB2pnigViaGPI6MvfMxQ9Tibwn4e+opgot
	 OsfrWB54I6zqFJqrQ8LVQpWpto8upkYl9fD3kIAolX/Nwgx2Yl5VezLS7q8yXBtSCf
	 SFwaRh0RmDgGSQVekh8YPlZ9fVnfcX7lYvSKSJc4=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 172D1C14F738;
 Fri, 26 Apr 2024 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1714151473; bh=7F83scvny5HLxbKUxWo8/UgBnoadOaVIdCLLaSNSKWU=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=OKki465ahnZRoJJM07xNHT3RAs1JWZi4dsmF4R28dTHehNKs3a54+HzulGtvKudHz
 Arw/919hlUXHSsKAM2aWwuksp8hlQNwxLrPI9Ef7nelBzWwiJ5SN5ex2gf+JkDzMPc
 LAo+2G6gZj2FuEaMo98cM1UlRU8XO0MyQXwOYksU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id EEC0CC14F738
 for <bpf@ietfa.amsl.com>; Fri, 26 Apr 2024 10:11:11 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEylUXgC4zCZ for <bpf@ietfa.amsl.com>;
 Fri, 26 Apr 2024 10:11:08 -0700 (PDT)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 306F4C14F6F7
 for <bpf@ietf.org>; Fri, 26 Apr 2024 10:11:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e8bbcbc2b7so22153025ad.0
 for <bpf@ietf.org>; Fri, 26 Apr 2024 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1714151467; x=1714756267; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hdvIkzQYL0QUQIUZDBpESmAbo+26vKvrycV4Z6MfDZw=;
 b=Wk5W7ttl33Wzaf6/OSRz0e0wDCMPBuM9cCZ0Gc9kmIacBL7DzDG1U97zZuGkE/fS+I
 4uIvTpF0Fqqb6IQ4JduBlD6ZrjV8QJO2tVCMhILL2BvsIbuGCiknM1VDBG+4xZdpooei
 YAwigFaW4e2RZX5nRfYiGHWpKOG4GS5bpK6nXNAd7e3RkqRwcOgJ248bxlEmAIJoSMbu
 8A4nmwWK+oBd5yfMeQkNDY1iPggDMkZmfqqRxYv87I3HRhxsg3JbQtQSgaNVVpNKILOG
 P4d/SdhQLic4PlJ1HK8NoPuufQkQOQCUpIC+HNYeE9VQVMaSbt2VAOevpKW94a1bKmLY
 yGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714151467; x=1714756267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdvIkzQYL0QUQIUZDBpESmAbo+26vKvrycV4Z6MfDZw=;
 b=RZueJ9xYtxSzaPhyNzq4oWnb4FS71ZOCsr+FjOxGwMPOy7RxzFydBqe40Ne5aE1p+F
 bYTMAs+swgyvo6AG8g7Tpmlx5teW3G0A4lM95d9KexEUZdIjJ4IVnnbHptc4rvOfsHBy
 mGi6B445X7VG4FeKUd+UyDmBVC5bD9ViQAuYbpShAuT5xPqlBc7GUsJhFQr3kRaIcjic
 YbqqVwx1ro8C5wUbQ4gftciX5agiiGpldpqgDVDiXift9JlwuRkHM1PUsElOQra745q9
 KPLzXGazAVRfwOc84mOeW50jv8B/t0G3NDb//WjsoqlR9zVE8kBwgcZp1LePfmjDvMXy
 FX7Q==
X-Gm-Message-State: AOJu0Yyim8DSf2IAzo96hvxb2iGZDb6Bikqx6ndm05oQe8xXfbrLYtYP
 ee4mb2afMQsfBTwQ0QQCDJ7spCa/LCsBct/OjR5PE/So8orcdP0h
X-Google-Smtp-Source: AGHT+IElEKZ8x0CBcgq/KkKh2SpyS80PR7LG5hgyM43/sAPnP0ZwsNN8Dr+kPqnGunXRe4lnmJwEUg==
X-Received: by 2002:a17:902:cec3:b0:1e4:48e7:3dab with SMTP id
 d3-20020a170902cec300b001e448e73dabmr5051864plg.38.1714151467302; 
 Fri, 26 Apr 2024 10:11:07 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 n10-20020a170902d2ca00b001e27dcfdf15sm15664394plc.145.2024.04.26.10.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 10:11:06 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Date: Fri, 26 Apr 2024 10:11:03 -0700
Message-Id: <20240426171103.3496-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zP-PrOsUbOkqgFybS_6rTGpuxhQ>
Subject: [Bpf] [PATCH bpf-next] bpf,
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

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index b44bdacd0..5592620cf 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -469,6 +469,11 @@ JSLT      0xc    any      PC += offset if dst < src          signed
 JSLE      0xd    any      PC += offset if dst <= src         signed
 ========  =====  =======  =================================  ===================================================
 
+where 'PC' denotes the program counter, and the offset to increment by
+is in units of 64-bit instructions relative to the instruction following
+the jump instruction.  Thus 'PC += 1' results in the next instruction
+to execute being two 64-bit instructions later.
+
 The BPF program needs to store the return value into register R0 before doing an
 ``EXIT``.
 
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

