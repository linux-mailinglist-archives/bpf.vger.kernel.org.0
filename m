Return-Path: <bpf+bounces-23230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E486EDD6
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4761C21F07
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC8B5680;
	Sat,  2 Mar 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DOnlYHrh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24791C33
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342555; cv=none; b=IxgxNgrc7z5CKHZKM6l2/JAb0Fx0sHgXIgtW3BaA7AuFEmVzphpKVKMMDP3AHV8HrAyX1Nd+CEnG5eWakXNIJF9UvVgIiaNTHi2mg+9KASkhRA3RG8kmJnfDX+So6inBCC9lK7v9C1vk4O3EE2l6bFg8vxKhGyA16hM7zh/b4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342555; c=relaxed/simple;
	bh=woZXRzUCL2aWzERkH3XLKYq5uj4RNkuyPfUarQlpIzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWrYwnL2inph65ejH/puYvEv1DY+mNGzDXt/Az0drIB38q5TfE2ZjSbu4B4QSTHuqq2T9pxNDC6MolVWq8M81834EuYHo2WScFTsmC2mEsprcq+3riTuHmy3LnOEkb6r+h/+tZoPXlbcpE+xBTtb00xKUw7mQpWlPrhhGk0AXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DOnlYHrh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so2245402b3a.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709342553; x=1709947353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpoJktcbuHN5dnAl3p51ocrSuJjC+qA6HqRRbRyh6Nw=;
        b=DOnlYHrhZos2ctN+G8K9Ix4B6G5CkU77Gn9paitWAHcpiiSCeoc0hV9hxIDJqz5+ez
         br2T18JTHaw056qsGDs7a7QQ+awuhlwOWL+joiV3tL27gMeD5yv41YTuO6UEM2CEWLsd
         +gZxqqFsd3FgY5lPDyMHmKjHPOU6SO+mAnuV8qzo5k97kz25YYk3LFnGBWfMBxk25IXQ
         h27JeB8I+REr60GOJ5QCyl/FPKBNg6ho3tqkIZ0OaSKpZDDruyYqtKUwLrvjJqUqXTET
         yAMIIHpNrDN7IPev+wpPu2/6kL5LrfFBDxkU2e+R+875hruCUooX/71tdcERsMKiCYDU
         2xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342553; x=1709947353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpoJktcbuHN5dnAl3p51ocrSuJjC+qA6HqRRbRyh6Nw=;
        b=T8VYpP8UHiP7thb413ze624Dm5GihWp6qytitYRcNZy8BLhw4ssQDq2f1xRblRLOdG
         mZtE4jcr6NUKjtHmifgKNmld/39yJBogjHYEH/ujJlgthaTK82pxbvFm4zdFXXc+PwHi
         xhmNoXsc6FJKiQ4XcNDB9ndpgW9+VrCoepbpYSAlK1znvMFvPjLiGTU7sjSc6fS1wxaA
         Oq7QMHar1Cll371cEhF8DmPK80u0sjNIGo5Cbo/O4VziG6BxRYoHnSeDG1FkN1R6w8cv
         yRWBNgQmoSm/+y2a27lIob9KhK3afcGdPDJn8a8YbbHKK6SHECwdgfm7N9gvrt+peEee
         dpWQ==
X-Gm-Message-State: AOJu0YxlWI+QkXNNclaDfPnA4B91TQyoCgxA7anpEUdV9dZxtnzLcjtq
	CORXcXaThZCAVt1XQ38YII4c2NUWWwf6ndFYwEnRdlLsE1qQx/A1PJ3Ok7D0Wy0=
X-Google-Smtp-Source: AGHT+IF9b8+P6U+FSI8na/7HCIw3M2hgs321KB48BKQiu1ES/xbgiAfGXs/Vk1+tDnc8GJkXw5VLkA==
X-Received: by 2002:aa7:8885:0:b0:6e5:6cb2:a68c with SMTP id z5-20020aa78885000000b006e56cb2a68cmr4744707pfe.8.1709342552793;
        Fri, 01 Mar 2024 17:22:32 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id c2-20020a62e802000000b006e1463c18f8sm3576960pfi.37.2024.03.01.17.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:22:32 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf,docs: Rename legacy conformance group to packet
Date: Fri,  1 Mar 2024 17:22:29 -0800
Message-Id: <20240302012229.16452-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


