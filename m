Return-Path: <bpf+bounces-23231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEEE86EDD7
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300712862D1
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC11566A;
	Sat,  2 Mar 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="gAtvK+jQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Nsu3HF7t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UqfhWu8Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011F63AE
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342561; cv=none; b=K+u6JGB7h6IcXSZ5bxFWr5oOvdjDcV97sFq+VFqvqqAuJ4MVUn6ehfQIhOgGjKvKMSpLxcDiXm1gzWO6iCMPqyoo0dBnetKe/S80BhSSeHHZj8euJizb3gq1FNoIkqJIO+2KUZptUMerDZJsW+6tBL9UhFRtp3DHdMVSKDVbcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342561; c=relaxed/simple;
	bh=dmdVLkUEOrNjlBpU7+JDEYIgelKEdSupSCLUw9BkQZI=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=EZYAcedIgVNGypaUZ2MV6fasQmESRdI/sA9OQH3Yv5D3E0yWL1tbM8uvGdYcu22hwDPLDzm6qdvWloy680Xv1mOUktJ4FT56VESczQj5MT/eka3ms9NlGQ7qzJXBekkgIi38Jbz/iNFmzol4D/mXQ7g/SsVJjvG8byjn4zxafec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=gAtvK+jQ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Nsu3HF7t reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UqfhWu8Q reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7D12EC14F6FE
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709342558; bh=dmdVLkUEOrNjlBpU7+JDEYIgelKEdSupSCLUw9BkQZI=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gAtvK+jQ83mzw6iTMbmKMtr1ITHf7dcG7t/dUsyV9239L2MNcvXlA6RbJbkSXetK/
	 frnrT4iChOy2B2iuGZkRqv6ckKLM9W7APiwfV1Fy1kLnFqhA0xZ/8LX5xoULjvZq02
	 6q7uBmhrFWhROaDifvXPTIPDfaJZ35W3veSfbqYs=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5977BC14F6A1;
 Fri,  1 Mar 2024 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1709342558; bh=dmdVLkUEOrNjlBpU7+JDEYIgelKEdSupSCLUw9BkQZI=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=Nsu3HF7tqPjZK+/mymqOjYex8Uh5qBbw484vD1PK9JMVOIWBOEdFG5TEAs85deR2q
 cBaY8nrQrSjrXK1lVzWReQGy77gvKl5lEcY+HXt4v9Rc2ZOXMdplKktovuwdUaszv4
 IfqRP3rNpfva8RusGVvsFkeJreu6ADspKvXue+0Y=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3A2F0C14F6A1
 for <bpf@ietfa.amsl.com>; Fri,  1 Mar 2024 17:22:37 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JhmCS3_i6PAj for <bpf@ietfa.amsl.com>;
 Fri,  1 Mar 2024 17:22:33 -0800 (PST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6A81BC14F69C
 for <bpf@ietf.org>; Fri,  1 Mar 2024 17:22:33 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e59bbdd8c7so2124911b3a.3
 for <bpf@ietf.org>; Fri, 01 Mar 2024 17:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1709342553; x=1709947353; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KpoJktcbuHN5dnAl3p51ocrSuJjC+qA6HqRRbRyh6Nw=;
 b=UqfhWu8Qp6HPQxDd4x7ny0V7G8YOCh66kHnTWsphd6CUCeikFoEjYe9/Kyfk8/tDyt
 EoJ7pOyqFD2C7kAAifEGCH3PyTfdvotlfFohD0yHWwTevLhLkZ2WdGrJnQKpdlyRWIfJ
 IJqGEsJwQZIm1FbrWpDqwzWIb3DLXiy+2FyxmqbZy2pp7K4O/wjw/3JPPPq3DZqdIfRK
 UUHMM/p3HKiYzKYPgZMM0JirEpFPFYumeO+vh+K2PZtYkMBJstATi1CKeuQuwb7xqiqs
 gZn/r7s0xpZefbCFoOMLQmauHov4X8krlAdZCUBw0KCOaMARUAY3fGxS76tpmbxM0uJT
 5kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709342553; x=1709947353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpoJktcbuHN5dnAl3p51ocrSuJjC+qA6HqRRbRyh6Nw=;
 b=k4nilaSqPPnhxa4UJM5Cy8GOE6i98s3KvCYkU7OYRCO4KOpzT5BJWumYH1+zx/d6EX
 nNkPQpn3XlIyqMh/9l8CZ7wFUMU94gDrZX5BNCEEMuIp/tXjOKB0TFfcQmruoaFfRw92
 pENLkaj/YP/XMd9GHbxXvkWtCKaETrs2OMutIrnmfvxMoe81NBZnjyQZAzR/sWCMPZMn
 36lARRq3UljL2iBjc+B5TnvEEjKjlD9yCX/hbU6gqKv/rtICQFgC5OWWo1dDN3+vlMeF
 fwwOOeluEFxr7PyCycFR68VMwvwFZ3PlP2xCmqe7hrubBGLvLc8/f+kXfM/JUWASlgLg
 0ECw==
X-Gm-Message-State: AOJu0Yws8zE5sfjIg1Xm0uUhYTpThRdDksE9o2Lq2zJNjExC63tss74Q
 yr3e89IGJuXmRtfw9qyM4Kq1xh37sq2Us7Na0FE1Yeil5HS3bkvP
X-Google-Smtp-Source: AGHT+IF9b8+P6U+FSI8na/7HCIw3M2hgs321KB48BKQiu1ES/xbgiAfGXs/Vk1+tDnc8GJkXw5VLkA==
X-Received: by 2002:aa7:8885:0:b0:6e5:6cb2:a68c with SMTP id
 z5-20020aa78885000000b006e56cb2a68cmr4744707pfe.8.1709342552793; 
 Fri, 01 Mar 2024 17:22:32 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 c2-20020a62e802000000b006e1463c18f8sm3576960pfi.37.2024.03.01.17.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 17:22:32 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Fri,  1 Mar 2024 17:22:29 -0800
Message-Id: <20240302012229.16452-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/J53zC84eBRp5OLZe-XFJc3w2Sr4>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Rename legacy conformance group to packet
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

There could be other legacy conformance groups in the future,
so use a more descriptive name.  The status of the conformance
group in the IANA registry is what designates it as legacy,
not the name of the group.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index ffcba257e..a5ab00ac0 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -127,7 +127,7 @@ This document defines the following conformance groups:
 * divmul32: includes 32-bit division, multiplication, and modulo instructions.
 * divmul64: includes divmul32, plus 64-bit division, multiplication,
   and modulo instructions.
-* legacy: deprecated packet access instructions.
+* packet: deprecated packet access instructions.
 
 Instruction encoding
 ====================
@@ -710,4 +710,4 @@ class of ``LD``, a size modifier of ``W``, ``H``, or ``B``, and a
 mode modifier of ``ABS`` or ``IND``.  The 'dst_reg' and 'offset' fields were
 set to zero, and 'src_reg' was set to zero for ``ABS``.  However, these
 instructions are deprecated and should no longer be used.  All legacy packet
-access instructions belong to the "legacy" conformance group.
+access instructions belong to the "packet" conformance group.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

