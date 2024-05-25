Return-Path: <bpf+bounces-30587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7398CEFD7
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0889C281842
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B49A44C6F;
	Sat, 25 May 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ciSMU7Pp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFC1DFFC
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651217; cv=none; b=b5h5oUWN2Jatxp9lGiL6KkjYwLcS5XGRSEzBEc+G5grPrZo1wJQ/PJ6JHUr2W4+PbrQbfSbDYAqAP28/e1Cl7gaLNw4zO+ss4AA6FgrIDGxUBDDmDaKT2a7OVqWghgnp8nqvVp5ccKN+seQgGhacUt0wZw7llqYmdVb9eHaMwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651217; c=relaxed/simple;
	bh=9StCoyqXZRP9t0wnsp+Nrt2+XiTG1jKogib4mPXAEW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s4HIQfHXVHiFGEfsVDb86w+DTpdZUTMjWhkqJRYDRvzL/w1Dk7s0RYTGfZFqtd13cH/v+uu5twDmxEo83hg89mP/hlg80e7VEXqTytGpjK7e1GD5hO9QXQkk0igtVH62353RJ1B4HvZ5rsmGhnD4lSyqa44WmGNZnd7O52+J+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ciSMU7Pp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b59f8daso12645625ad.2
        for <bpf@vger.kernel.org>; Sat, 25 May 2024 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716651215; x=1717256015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WhgM3TzL1k+cJvnIJ9yiuydwQ2hP9//8jGA/WrlIoG8=;
        b=ciSMU7Pp4ma6hYlMSXst/3jll41c/Hro2KpD3l9fZZVTR8ucgI5/xXxBUulsaR01w7
         0sBCIabUpilA3raQ/PhloP+KbnL8WYtcAAgITL0+OBifXHnQehJ9ImGzdaOr5aNFePeL
         sqQEgy2HCZHpCYPYai0TKuJBcoxgPn5tsu+sjAG47LX2U2TZvP6dMJBgoo9bACmvRr9Z
         shyucevkIIyoJW/zHk2XEFzrNuUby/OZYlQsrJPHRQrGPwxXMxh6JOjR9Dop4GIczoE/
         m5+n2cwRDPhwVE5LFTdMXEWObJbcNFrIaNVf9otnR3lNxNmEQwTg7u+U+xN/fdE1yFax
         M7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716651215; x=1717256015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhgM3TzL1k+cJvnIJ9yiuydwQ2hP9//8jGA/WrlIoG8=;
        b=JUYfP+FMnGVoemotxojrF5K9foaAPOe+RZyWpA+XKm6plLxY9yU+OOyU3vz/Lu3thY
         phxbzxl5aXguHktNeBCzRRLpJXFKWr46WdHFBd0rg9q/6dnm4/XifvLobjQtv6ur0z1a
         a2JxYeGXYxn2L3fB6rI1HWuADDdOMhkGCQcurbFj1QBxm1pMfzx4HHRRzapSAc7j1PgE
         3BJQ97GoT/J0mci3rvUrKXz2cSRJ8Ps5xNOnngFBeAjmS+fBYklI9nKt5hND9w/MK/bh
         GFZ8KLK3frbhXlGxnRH5lQqBcEyfmfH1vc8U82uWipJIFb/HDFOVjEFMvBWRi+vpienZ
         egkg==
X-Gm-Message-State: AOJu0YyAgXZpdv2dEDXb1qkMdFctnrzwlLbeb2aPCXPx0bemZBFRymWw
	AniY5d2N7xLE9Y7e5OaC1xvE9m06+4GDTpdQLPLgQoIHc0iEUPvMtDk7XILM
X-Google-Smtp-Source: AGHT+IEmDQZqj1300++gHaFZYQuNrJSs/0y3Sdlv2EkEsUW2Ya+rfHEBXre6C5l12oDbAJ4B7Us7tA==
X-Received: by 2002:a17:902:f68a:b0:1ea:cb6f:ee5b with SMTP id d9443c01a7336-1f44883876dmr63477225ad.38.1716651215310;
        Sat, 25 May 2024 08:33:35 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7cadf4sm31468335ad.109.2024.05.25.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 08:33:34 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Clarify call local offset
Date: Sat, 25 May 2024 08:33:32 -0700
Message-Id: <20240525153332.21355-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Jump instructions section it explains that the offset is
"relative to the instruction following the jump instruction".
But the program-local section confusingly said "referenced by
offset from the call instruction, similar to JA".

This patch updates that sentence with consistent wording, saying
it's relative to the instruction following the call instruction.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 00c93eb42..6bb5ae7e4 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -520,7 +520,7 @@ identifies the helper name and type.
 Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
 Program-local functions are functions exposed by the same BPF program as the
-caller, and are referenced by offset from the call instruction, similar to
+caller, and are referenced by offset from the instruction following the call instruction, similar to
 ``JA``.  The offset is encoded in the 'imm' field of the call instruction.
 An ``EXIT`` within the program-local function will return to the caller.
 
-- 
2.40.1


