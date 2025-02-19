Return-Path: <bpf+bounces-52002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00BA3CD9A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616523B7B9B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E325EF86;
	Wed, 19 Feb 2025 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHne908M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314771D79BE
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007864; cv=none; b=KM2D/+kL7O+CTocJbuA8NFMIEk+ZsB43jLf1AYxqT011kTfQ9JbqcqHAagMtwMuGh3mJ6/NdE7mZcBl+y77sUXmLmR39N6jXtcZ0QK1tER/WwQQkrOHsxITCRXoBseA7bYunFTNGHbeZ2Ip/3oybwi1dPuqgkpDlLpSXqdgOfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007864; c=relaxed/simple;
	bh=qSxTVMmtCuGT9LZrLtxChHo115EDGEM/gAZw5/iF04A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeVbNSos9uAgi5iz9NCHq/Gh1/ZnsjI6HmElJYcLSMYKnYoG7fnW3cWAFcUSYnMa394C141xdKLB0TCyTf5u3Bp1TiCIrICt+NDY8eHJSsB4KVMHc7SK5c2y1PGsvknmPRwJzzFQ9cBakeyFuZTlakRQOILWzn+rIyRRUEPnYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHne908M; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so1830655e9.3
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007861; x=1740612661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kL+F1ae0JrGtP3CSHxBMqomhSP6aCEP2lOkRJ9+eLfQ=;
        b=KHne908MVSOmV9l0BzCQfoYq0OeHgVAiJsLM99XWGr2eePdpYrLSjYhwIT6uGgjRHr
         ufxcHBfYUepDHxGZ35r4DO+r/hfdNnvzitRPW7Zww0XT/B6wLRmGWIyR/NtyWghhZ0NG
         rkNCEiTm+0skwIExyhp0N1D7pFkptPDgOVhBDzgpD7vZRpKLIWWP+8U/HxzVHLxeDDv2
         +wHA6iyYQ5sG2OQQm9U7EjTgqpAgHwN9XM+DetLdW41GSwDTMXV3kWZud0YR1ZfiTlyq
         ySWJ4qHbFXHHYhoE/fQpy+9U7z0t26OxROparTTlMyxbg9aFSyPa0oy7xfupy13cjD59
         bZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007861; x=1740612661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kL+F1ae0JrGtP3CSHxBMqomhSP6aCEP2lOkRJ9+eLfQ=;
        b=C1dlwNc7dz0Nici4kpJ+46XX9s6QydjkSS0+rOkqQjSynR2ym1LmRE82Xm0uM33U4l
         UYkjc1ZzKx1xdMQoyAM99eSCAe1LdAEjZ/YE+Wt3JCiTsKFDCUisNKwalvlefEkMAwBa
         mcIL3B/AKDdzylSVGtdqlDCr24E3BxuceOu1rS3HkFP3tUgQ/B3nXGBnQWheHyX0Scv1
         IXhRDtq1+RjJFN/fKjVhRZvRoSNgtb3ahJ/Itc16ABF9K0k5N/OwcVPZYUc5FrNtKJVQ
         PJOfrZfYsNfa/Ei2MXsUpFCxid0ZTw3PSFCH5fq0slLhy4lVd9AaT2waIIOg6xw23DGx
         +gfg==
X-Gm-Message-State: AOJu0Ywz1Dz3wG0Q49gYqT96+2hocNH9zIKi9kfS09dq/t8pIXK9f3Sr
	RD2b52cKMx1yJgOmlO6SdNExsHoTbfAPDs1WU3LjhuzVPDJlaLmqy30wMQ==
X-Gm-Gg: ASbGnct9eEdoLQkYsnyqrlX82zTXiHI6oDubDh/QgXw1D4sW0PfckDcQfA+lx0ONr+E
	BgD7R4OhxK15H++1LLbIOaS3VQDUiyhnDrbnv7oiuZXMsA0UYQcqS03fXY6hmAA0w7wjbgRJbzY
	FxQUoLw/FxYKTdS/7MYhCHJTsiuGq3DX+9JoHuTdbOUYJ1aFkRbolWkr17snd0el1nIFxTpWmNP
	LI6h2tZ/9FXCR2PT8Ea4vIkNOpyo0ECxKYrkTLjNMs75Lt9B930apSxoIdJqyRdpIwhLwPkRXk4
	oWkJOOkK32KzqNjDJTWWuclBUGWMv1XSLsQUk71lIIluG9RX0T6aN8nv4cFJuk8pDJyqWHy/1nb
	jZv6r0NPLZhOcQEj9FnoJ
X-Google-Smtp-Source: AGHT+IGsZlt6+e6gM0CdEndQzrle4+d1ZVLdHow8L0Q9QWbxduRgQEKGj8Bjfix31FLbX9y2jmyBrQ==
X-Received: by 2002:a05:600c:4f02:b0:439:942c:c1b5 with SMTP id 5b1f17b1804b1-439a4a9d500mr1975255e9.11.1740007861305;
        Wed, 19 Feb 2025 15:31:01 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm18779048f8f.82.2025.02.19.15.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:31:00 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/2] selftests/bpf: implement setting global variables in veristat
Date: Wed, 19 Feb 2025 23:30:43 +0000
Message-ID: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

To better verify some complex BPF programs by veristat, it would be useful
to preset global variables. This patch set implements this functionality
and introduces tests for veristat.

v2->v3:
  * Reworked parsing of the presets, using sscanf to split into variable and value, but
still use strtoll/strtoull to support range checks when parsing integers
  * Fix test failures for no_alu32 & cpuv4 by checking if veristat binary is in parent folder
  * Introduce __CHECK_STR macro for simplifying checks in test
  * Modify tests into sub-tests

Mykyta Yatsenko (2):
  selftests/bpf: implement setting global variables in veristat
  selftests/bpf: introduce veristat test

 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/prog_tests/test_veristat.c  | 136 +++++++++
 .../selftests/bpf/progs/set_global_vars.c     |  47 +++
 tools/testing/selftests/bpf/test_progs.h      |   8 +
 tools/testing/selftests/bpf/veristat.c        | 282 ++++++++++++++++++
 5 files changed, 474 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_veristat.c
 create mode 100644 tools/testing/selftests/bpf/progs/set_global_vars.c

-- 
2.48.1


