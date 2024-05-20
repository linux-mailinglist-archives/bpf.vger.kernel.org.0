Return-Path: <bpf+bounces-30055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F6E8CA400
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764581C214FC
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E1139CE6;
	Mon, 20 May 2024 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QSHr6bGF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB01847
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241982; cv=none; b=tdMdJEBRN48Rjr/2tbW98/pCXsuaofQtouBnQDWFEtO5TG+7efXKXFZbZwBpmscQJU8LJpdp+yUCGbeUECxhMsTQATrmq1z7tTAXF8D98vJmsXsV+1b2r3hLv5rbTLmQfYRH8/4OnT01m9AFGWVxlGt5xy1ZHGaPCZPaMssPlwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241982; c=relaxed/simple;
	bh=SJadZyYeqvD4BcUbbkPOv8iFm57f7rgqvKmEvJi8AqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HK8yclhRknUJqS7paWpdEeO9WTBp2xcuTe2cZ1V0tGudYfjCKoxnWnTGAJm7WNxs8W3TyOFf9JVKCEyT9nlDjjwHJuC6Yw4ffRRnjZUCC88T4GlMApgu+ZF70QyOMj+A9PMsgi01swNGhXzBJR0Kp5knhOToPbRgB6tbXv3N1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QSHr6bGF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed0abbf706so21264835ad.2
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716241980; x=1716846780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vWskpXNzxNtnQzRVqcAY8ey1nFXzxi3crSbI25m+TA=;
        b=QSHr6bGF3GnZoys9N7oHjeOfoGGHaQ6X+WHxkyvGJOjqt9AnbkKTwctVpA8y75blZs
         Vp/1kwlJyP04mxVGsM4D0DePFVxzYB17pIUlWJPUqomGkWaaAryonKkS/I6KezR1/TLF
         cjUFBko3+FUD2rU8muIZgR0MPNdmwELoRqXbC9bNXjA80QOnEJhEUFQmGBGsWpYVeMj2
         S5C5niHz3yy+wsBldx6G5MqzZG2V4Dl+majNp+j5ehnN+V94u0JY+uA9k6YQ+QC2RqN4
         gl/jbFnEq8DYSBiNGmXKnPM0LGOGUCQtmCymlb9yeF8jOpCTzbSmR/87ak5/gP3r9aG+
         aPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716241980; x=1716846780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vWskpXNzxNtnQzRVqcAY8ey1nFXzxi3crSbI25m+TA=;
        b=cFVTD+9zlwuX5MM6+fAqGULgLx8BmCvTAq92T63RSJufFYRhdlFExpXglsM3WMLzuj
         rk1/Y9Hqwvo5JF1NmRHWxhExcf0E9Y4LmxBJIrE0tP9BQDUKsT9j3FoY+FWJKd948w56
         6FYjBO7Q3GLi68FVdJ2yaANKIHkqdJaxfoRRijbIcm0EKi6McV/T7psuWhtm7kECB91o
         35glycQB+E5k/HCzA6X4AXQ+06dfSxsQC72RCRbbNuW7XJDjQIpmUPYESJgHS4G77KE+
         CHmkL7XOtYUzsMlC65M7vk1xpx/Om59od9TEaj9fiJz9NvSFaZ0g8Oq8J5Jk1R5Iagqs
         LEsQ==
X-Gm-Message-State: AOJu0Yw1gOXlJqkjb95sA2/+EstrJ3sP4zZHfi6KUGBs3DfFp1D9zoXs
	I0QoYTOjen+oOCm0aXDrcK7MHIZFTWfUMsfAWYC5X5z4EDpDekfzjBZDk5Pw
X-Google-Smtp-Source: AGHT+IEiOHXbwnlCTxA5hWZQFMd63KNQ995CsH4UziWHlnhPD88DXjoZHNxl6JhDZGymmc0LhoC9sQ==
X-Received: by 2002:a17:902:82ca:b0:1e6:116b:b0d3 with SMTP id d9443c01a7336-1ef43d2ec00mr343736645ad.28.1716241979567;
        Mon, 20 May 2024 14:52:59 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c138c04sm208265605ad.267.2024.05.20.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 14:52:59 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next v2] bpf, docs: clarify sign extension of 64-bit use of 32-bit imm
Date: Mon, 20 May 2024 14:52:55 -0700
Message-Id: <20240520215255.10595-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imm is defined as a 32-bit signed integer.

{MOV, K, ALU64} says it does "dst = src" (where src is 'imm') and it
does do dst = (s64)imm, which in that sense does sign extend imm. The MOVSX
instruction is explained as sign extending, so added the example of
{MOV, K, ALU64} to make this more clear.

{JLE, K, JMP} says it does "PC += offset if dst <= src" (where src is 'imm',
and the comparison is unsigned). This was apparently ambiguous to some
readers as to whether the comparison was "dst <= (u64)(u32)imm" or
"dst <= (u64)(s64)imm" so added an example to make this more clear.

v1 -> v2: Address comments from Yonghong

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 .../bpf/standardization/instruction-set.rst     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 997560aba..7bb1281c5 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -385,6 +385,19 @@ The ``MOVSX`` instruction does a move operation with sign extension.
 operands into 64-bit operands.  Unlike other arithmetic instructions,
 ``MOVSX`` is only defined for register source operands (``X``).
 
+``{MOV, K, ALU64}`` means::
+
+  dst = (s64)imm
+
+``{MOV, X, ALU}`` means::
+
+  dst = (u32)src
+
+``{MOVSX, X, ALU}`` with 'offset' 8 means::
+
+  dst = (u32)(s32)(s8)src
+
+
 The ``NEG`` instruction is only defined when the source bit is clear
 (``K``).
 
@@ -486,6 +499,10 @@ Example:
 
 where 's>=' indicates a signed '>=' comparison.
 
+``{JLE, K, JMP}`` means::
+
+  if dst <= (u64)(s64)imm goto +offset
+
 ``{JA, K, JMP32}`` means::
 
   gotol +imm
-- 
2.40.1


