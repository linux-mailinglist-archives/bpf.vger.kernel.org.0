Return-Path: <bpf+bounces-27261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCC8AB683
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 23:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B172838B1
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953813D252;
	Fri, 19 Apr 2024 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xb7AAs08"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A013CF83
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562712; cv=none; b=Fc15wHzsNyxzCTaER0qlvEuz9WVPxdoYGum0Tzl+9902LQ4pbNV33XDffqDFAkxwA/k9RWDumKfrIZHrVLECrfli3kVVuUpX0rBNAW+P1GyYjpDWlZGS9hkgA5mBHdRzSM68ALCAV4Zlel5eZdqA5PnY/3dRFwk0iWZ+b7G+rOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562712; c=relaxed/simple;
	bh=oR2eLxlZxENRHrvi/1Z20sx51KXC67tmX7JnYEz127k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlJGU80tvVwZiDrYI5i5v6BBlr1Pw9PBDhpEsVsCMLE+TMVPCOoRzfzYW9lGSQYzKfI6UqzKvMdYVp1ozcj34o/3cJrCczBhh7ZTSaUPpjdJ/ErVtMkINgjTO9gk1WMC0gp6PAy4iM302MCZsIz/YT1s29BG8jbevlp9lQ4k4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Xb7AAs08; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so18206225ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713562710; x=1714167510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhH2fDPoebOT1miU3yZ6QUPdr8Qf3wsGNhwEo2ogET0=;
        b=Xb7AAs080vQaADtMQ0/lzQ+4nz9QgJVaWApSXfSyI1FP4N/pjkrnz+QAhsV0l5i0fP
         WAKDrAJF/gkSv8JzbQDpUsJN/MwTlafujRI/UDQx9JvC0IKpD3JNXvH4Hlw84xZVJgJ+
         n7IbXeq1W7dsK1Z0/nv8+EYaE2DIO8AvuzW6RWJQX2xsgvjpZXI6FhpWuJCOmWBprehk
         KbGi/sWpWWVSvQ+YSMNAhk2i6NZNv6pNjBkQpoYd0Lrwc4Nrs1HhvsLvlDEaGHAnOKvO
         DaPDiA+bfX7cupfuab22cQ976bkaC/j1NJFKT2H8f2EygYVF4e8aCa5TMEu3h14c7hpD
         t6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713562710; x=1714167510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhH2fDPoebOT1miU3yZ6QUPdr8Qf3wsGNhwEo2ogET0=;
        b=vcO0IgGzEPl3ihLBp+dulPQ0jmUpZARlMKXtsIDfIIPFgfBonj2/O2/QQNMElYaV/+
         GZHwMy204fDTje0mAIwTrItyyUagfBD/m8YYWaBEjKWdzPT9jwpKtOAFnp9ChWueuWSu
         Edc5QLbNyhwoGLz3OMbrl7+M1p7cXILhPdZU6QxPTIsUUIuqzf8KE0Mn4c8+Ni2ahvsI
         doqezjDKelFK4DrjB9ONs7SPbkwJ29sTc2dC0gkPFPTwxg7MMnsmr7isq0wBGItY0FBO
         VQoeoIKbNTRKQBukSo5Av4nfzYWcQlxKccwM2MtlaDGjE5TgmmVSFywkdmt01LmGXSHi
         Lt+A==
X-Gm-Message-State: AOJu0YzB2844e1xE2iTtrUeg0m++IwRtExmryjMgUL6FXaUcvWXTuhwB
	bj3VM+5jNhSm118B1+dcff2EjPta/PGCTcq1OR0PpispDpveyq52hZEUsAlD
X-Google-Smtp-Source: AGHT+IFTIEvox+BPzjcJPqGsjk02Wvswzaio8qnIc15v/PFKaoa/BGwMPFggMnu3urntKBt2q3Pn9Q==
X-Received: by 2002:a17:902:ea12:b0:1e3:e6cb:a07f with SMTP id s18-20020a170902ea1200b001e3e6cba07fmr5201686plg.26.1713562710223;
        Fri, 19 Apr 2024 14:38:30 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001e0e5722788sm3921221plb.17.2024.04.19.14.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:38:29 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next] bpf, docs: Fix formatting nit in instruction-set.rst
Date: Fri, 19 Apr 2024 14:38:26 -0700
Message-Id: <20240419213826.7301-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


