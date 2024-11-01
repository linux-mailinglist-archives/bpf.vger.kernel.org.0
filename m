Return-Path: <bpf+bounces-43795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732C9B9B53
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 00:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152721F2219F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 23:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EB1D151F;
	Fri,  1 Nov 2024 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy5P4u6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A25165F0C
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505300; cv=none; b=i+LtutPhQwLeqflCKsYNzppuBxPYBDY38ZwUAktUBVVWJwlGcG5mLpAfahWFWbR24bXG//mJ7akDyey82PlJb74DMHaEPFhj1lfXV7l1tcB1eDQo4eoe51TP3xwBWLwBIEBKdtKqN1fQw/54hHZH8RQNPfOaqpyKbTSKQEx7UKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505300; c=relaxed/simple;
	bh=akNbmitRTSCwrpxmV3sXdGYv0Gn9Er3xY/aJEZ4Ht2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4vwbiVo0CibxMMGiLSwBm+ZdmfbbU40a86aCjmbX+nArSDzY0aC0HSQVrtPt6S9P01Oa36pHvlJmrKheeTqwIMbk2ej9pqQDNSJEJTEo5zb0PGw+BfA6RcanmP5VCYfCwLUl1RmjOfd4qKfFtyO20HGZlqu0ANNK4PbB8eplkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy5P4u6m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caea61132so21613315ad.2
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730505298; x=1731110098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OD64WBzWdvsd2FI78h8dBEVA5ff0n1B8ZmLUMQdOtDo=;
        b=Wy5P4u6mmbzmveabH1NxdOYGHKoFd32sXnVX/0qeA39jt3iZ7X2BmHSoUc0xHk/hNQ
         cWCGsADBtrAsY3ZYnQmn/XzoydvUnNnx6a35rPWPcuq6hM7X7YLZnWtaRJKVdhLQIrU2
         5r3KmzGN4lEIztIv/DYrIgO80QlslHhwV8xwyuuA1j4jQ8tO+REz9SrtCefT4irExa9x
         2Nkc9plzt5oWYSaxgE5i8mGi8TTXeO9K9QBQS1f69lQkObDJeyopI9JIBsjrv3/J4kw4
         jT2hgpa5EOZZTsLN8oq5rGD0QSlA9ddmbtuZDk7Aqna4QIhmMbf8W1j2EFE3sNwOmBcw
         180w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730505298; x=1731110098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OD64WBzWdvsd2FI78h8dBEVA5ff0n1B8ZmLUMQdOtDo=;
        b=byq2nOoIQQ0GBCypgBUgHFnRrjvnQ2BnInb4AWAr8KC4vQUsGDMCJUBx6o2Z4q0FoV
         9wYjKFT4TDrOO9Lku0DVXn0RCH+B37Zj+RS90onc/q4PYh2p98X1M+NEZv3gocEWLRBe
         pInYtXXvbqcVt589F7OWkurM1dLKcKKicGgxRskCknRUQ2MnV6zwswZPf9Fvg8n9NEVK
         aOKzh8eWNJsE6WhZ0ANWi8AmyRsCbSYDy/dl4FyJGxPSWEdYY9esUUSzsj1qexPPtmfm
         rWVi+h38rOz5byCj526XSOXPqsBPA9tXkdXn86+maTSqJkdt1O29C163tIXgf/F8uoMw
         GTjA==
X-Gm-Message-State: AOJu0YyqQ+a6uoilhXXIHr5EJ9UGbQwJ5QOspbJ6cUnDXiYFcjoUBn4v
	pzMGydk8ngHuEhxh4KsALp5nljE1hvTdioHgg0D/3DCNsC78g116/Wb7Dg==
X-Google-Smtp-Source: AGHT+IHzYjnu+/nlPw6CJg6fvjzJcjEVC9BZZ9JccksjCJmTCVtq3JgqsuLUn+eWjxFAApBgdjiR9g==
X-Received: by 2002:a17:902:ccca:b0:210:fce4:11db with SMTP id d9443c01a7336-2111aef27b5mr72733505ad.22.1730505297979;
        Fri, 01 Nov 2024 16:54:57 -0700 (PDT)
Received: from tungpham-mbp.DHCP.thefacebook.com ([2620:10d:c090:400::5:7de5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed86esm26698835ad.44.2024.11.01.16.54.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Nov 2024 16:54:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 0/2] drm, bpf: User drm_mm in bpf
Date: Fri,  1 Nov 2024 16:54:51 -0700
Message-Id: <20241101235453.63380-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Hi DRM folks,

we'd like to start using drm_mm in bpf arena.
The drm_mm logic fits particularly well to bpf use case.
See individual patches.

objdump -h lib/drm_mm.o 
.text         000012c7

So no vmlinux size concerns.

Alexei Starovoitov (2):
  drm, bpf: Move drm_mm.c to lib to be used by bpf arena
  bpf: Switch bpf arena to use drm_mm instead of maple_tree

 MAINTAINERS                       |  1 +
 drivers/gpu/drm/Makefile          |  1 -
 drivers/gpu/drm/drm_print.c       | 39 ++++++++++++++++++
 kernel/bpf/arena.c                | 67 ++++++++++++++++++++++++-------
 lib/Makefile                      |  2 +
 {drivers/gpu/drm => lib}/drm_mm.c | 40 +-----------------
 6 files changed, 95 insertions(+), 55 deletions(-)
 rename {drivers/gpu/drm => lib}/drm_mm.c (96%)

-- 
2.43.5


