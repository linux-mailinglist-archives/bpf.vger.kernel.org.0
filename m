Return-Path: <bpf+bounces-60994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DADADF7DE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D32D189DBFF
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871DD21FF54;
	Wed, 18 Jun 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao2Zp2Pw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1321E0AD
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279151; cv=none; b=Kpx0xutNcEixTj6W9U7RdUmSe1U3eTldBja8jXfPo7Qfv1Av6Me+tDjfF/oml/U81rRELnH/OmjxFdemdmP0r7+PmfAuZIX2ilUp07l6ZxwqztcSb5aSXThg3jvgliLwyOF7Ctk68CISnr5KtzKCN+z8CMtBoMg47fGYFpTo2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279151; c=relaxed/simple;
	bh=piHpzTeDcCcEbKYwUiQaAnzkc0lpMITVAMVEShOE33w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0ziqjq1PCzL+r3LvcIiVRyVY4f2ScmLYD3efQR9UsIiFcHl5Dw6VRL/HzyjSdKyq7N4DJvUPqOIPcW7bE3gPnsok17GXPPV2u8yGbW1EaQdttpQymjeMt3V0dP/FTLPWvUiTqoFKJMxo0OkywS4f7idsLWZRYGpQS35TSE6gl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao2Zp2Pw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so71890f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750279148; x=1750883948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku79Ovilb2qFKWjZOb4WV+4PZHxLlBW9DlZutXZzlyg=;
        b=Ao2Zp2Pw0hf3imfT+Lj+qjyqedMR/LHk1jKQRdXLl2ewdnsDXD3pVNGRQcvBDqw2tV
         iLSm9OFv8bGiCgBWVc5wJx4XazDhUVLlNy2PhPHocJNlXlP3U0GkJ8eqZ78xdAmYddEz
         dqOPT4mRxVQTHgNl/ng5csEdAlbuRCNcjdEIXsX5Kwm112RdsstUEXr+9OOux7IktAtv
         9cXag6N1OvTsZIdwItmuI4d0vbsvSgvETPK6iLgV7ljJryiMQ/dYGM6UQEvU2ktW3e9R
         njLEJBTPcUxduM8vDk28uLszOAhBRHJgy56hH+3ZbhD/i7EWVr6n611SQQ/FCaT/1bfQ
         wLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279148; x=1750883948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku79Ovilb2qFKWjZOb4WV+4PZHxLlBW9DlZutXZzlyg=;
        b=vbzwopB8Vu2OHJDnlKiGkz4lCwJT7x3VLf1iLFsQ9rZTuKUxXYXQpfrny5SqZepaEk
         nq7JeyrEm4RajtvVShx1bgMfdNAXOW2i3vcnCSDqM+8hVkThAQpP05lz2lRigfXKAzjG
         b1e2lGoR4o6jAkayN+9t9bJ2asO5ycTAHuU1ta9c6Sjewn9bOfMKxiwKuP9HmMZINp8V
         WYKtiDHaSiCHKT7D53Y1rEcKbg5asH+47TZAHGCeGm3KLt5+tRwogOoNofz5C+syiYnc
         3ZyuGnW3wsDTHoD+JUGzDJt31UJ+6G8AmNw87y6CNNLFhxYVWG8iVajNs1Q/m8Oh9SbK
         yX9g==
X-Gm-Message-State: AOJu0Yy7TqER+HBPyYynERuDBhJ70yhjja9MBFnY6bTEZ8y6KR6E3eme
	yXpXxOlc7xi4eIpOHTVlKqp5dRIJhRILGTrXwg+J/vV/5mPy1llgCOMFJeD5cw==
X-Gm-Gg: ASbGnctSlFW4O/gSCufY8jDX6oUWXIxWPZuK5nXJO4hEV/wMKnKRxJ1zoSur02OT73v
	CIX9gkMguAwlXHDWkZeWMqYmoFoNq830g3ryhtv2NOId2QI/4Ooi3K52gGpYGis0u/JQVF1P03s
	/WJ6z1I5k1QAsS0Hr9uxcIGRqkL0brCsgxCveZxwv4E7ztKATwv6Wir9lFrlLSfvhFT2oKk+BzO
	ufrtSOJoIqKz704K5YATFMpv4scD2+Tds/fBiXYhwkOi+MIpev0kkcOk6656OIOs8/EdmQi8V7R
	XZ9+nCbP8as9TKChtM9888nPPPoPThWXfF0t2g5snaH9swLbrc50xYoUOp1r
X-Google-Smtp-Source: AGHT+IHP+A8OFaj77uKdi5gAyPMsXdyCjkCErDTQ5HD39Wrn5rOJ31bw+tINBEh1adxsLYfTycNqmA==
X-Received: by 2002:a05:6000:2313:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3a572e79c14mr16823043f8f.31.1750279147434;
        Wed, 18 Jun 2025 13:39:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebcecdcsm6884385e9.36.2025.06.18.13.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:39:06 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 0/3] Support array presets in veristat
Date: Wed, 18 Jun 2025 21:39:00 +0100
Message-ID: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch series implements support for array variable presets in
veristat. Currently users can set values to global variables before
loading BPF program, but not for arrays. With this change array
elements are supported as well, for example:
```
sudo ./veristat set_global_vars.bpf.o -G "arr[0] = 1"
```

v3 -> v4
 * Rework implementation to support multi dimensional arrays
 * Rework data structures for storing parsed presets

v2 -> v3
 * Added more negative tests
 * Fix mem leak
 * Other small fixes

v1 -> v2
 * Support enums as indexes
 * Separating parsing logic from preset processing
 * Add more tests

Mykyta Yatsenko (3):
  selftests/bpf: separate var preset parsing in veristat
  selftests/bpf: support array presets in veristat
  selftests/bpf: test array presets in veristat

 .../selftests/bpf/prog_tests/test_veristat.c  | 127 ++++++-
 .../selftests/bpf/progs/set_global_vars.c     |  56 ++-
 tools/testing/selftests/bpf/veristat.c        | 330 ++++++++++++++----
 3 files changed, 414 insertions(+), 99 deletions(-)

-- 
2.49.0


