Return-Path: <bpf+bounces-56883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7CAA0002
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF023BC11C
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E613E29CB44;
	Tue, 29 Apr 2025 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPppCi3P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105F2FB2
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894511; cv=none; b=kjt7rF6ogor8cpx/BEpJBh02PLpm+GDchS4toWCgOybX8gLt8b2eLKeocNFPC8SYmC0sQqpExHgOMOpRt59eEurQVoA/FTTnNd37JxizlokYyoVjLY8ShJTxOc4AI2TNaIasHWkEaPJLAp3h/iPOv3UP9cqH5s60wZbTvWPIWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894511; c=relaxed/simple;
	bh=O+vVVKcfyJpY+s9W+YsL5uugWadPHj4PRx07tT9wh1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nf+kXcs6z2xNj8TQSOOwiCnCHbnbnq2cIBu6AJ3kPPhLWm6ubRwJ3sAdP/uLuP1Nh1WJRRrhDoD3wqmozB1K4tfgNMaD8QkBIOBCr2C/IXKT0HND2F6wMCHXeIhR/3XwWvF9hqWnK2sRNqrm5bpbTlS4M6eaGB7htDbGldCLU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPppCi3P; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b0da25f5216so3467683a12.1
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 19:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745894509; x=1746499309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmLnEpBuZGcdIcLvXXK/nzmpJRoqGaDvFGAeEREmXmw=;
        b=dPppCi3PtWfB8dy1WVN0MOViQG/A6ToDIgMtkaGk0vzeIzW4LaVSSWbS190i45Bqwu
         otNsNgv4Yk04zl54+FugmRtFB6BaenbiWxSjGZ197ZFBiz9/cMWw11QPuoeFugxh/6mL
         xP585vuXSn/PJ4Q5i+gMhnbk6HHLdiNdS2Jd6cs3WM1AabcbM1yp++gmNVRLt3MngOE0
         +7v6PTNZH/tN6MdiMvoyV20EmE72evdfLHsCHvtJYOZY7TVCD+6bj03sLsHQtmpZyfVy
         hxwdw/J+CGfqgt5d8wSEcC7vY+SSKp0yzF7wCmh7mozPMeopE6Ra0P+QhFOLSqIBLPTb
         6WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745894509; x=1746499309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmLnEpBuZGcdIcLvXXK/nzmpJRoqGaDvFGAeEREmXmw=;
        b=wGqVkfNoOisEu3u+P6Ksg/FcMOFjGXYDiFxOy4g9YdEzfOlg0i1+Una+M+ugxP5iPP
         qm29iX3FrFINTY+z32QLmeCO3H9LQze2Cd0MMdG7jkcuuZ2lPOKKqpdfZTTypZuhu8ff
         Oen2dxPVuG2NVFuLEC21X1paIgGBep/KkfqD2NzKWdb8MUFkokjQnOTWB711sOyPATpx
         3JNrVEl5P0v/dKIMEafgem9cWMx0XhW7Tgj3x72FLQGQ0Cj/IOu5KJgBSl/WHa7X1M07
         XWrw8sgfw5bK5WWk/GkTSlSW1zmK0p/Yv+mC9omehXr3SwQyEUKlgvMs7NtydXUExJjM
         Sa6w==
X-Gm-Message-State: AOJu0YzAb4ZakpmNpsMFCa9dw9WwAM3+odCjB66ML/PuSnDpUR4ZMZz/
	vsg24yoDzH/REd2YMttt58ua/xP2Dn4OyjdOc5Ype1ND2RWeaoWk
X-Gm-Gg: ASbGncvfwN0mxEC4CkvDvfAY0ALZeKdGm6RMcfMB1a9KSkH+CRIYbzDcRKoyy0Sh/uM
	WI3i13mt6afNw8mikl0VazuOdRS6fPaFchHUyqtCwCUflCaBQaN1p1wyyipwy4Rbwvgj95XExcy
	47lfL4VE+qIMzujx0eJI7pEJxCz9hEPrDWIoR9pbR/9BYFn/OfUa/L77fDPC+22o3TVl58BVlb/
	A6pnMuCMyc3IWO1D5rBibKlp9OeAYp0j9C/KqSqYLXkSiZauCfX7SInbe6X6WAKhmecXs1aw5q/
	GG+KD8HSmMJnlkpFXokTJQM9dY/+tDnV1YTLLsqqMQNyq5ZOhgFzHsgu1/HnKUxCKYItAy4ENs2
	1
X-Google-Smtp-Source: AGHT+IH0G23aMYvesu02FPqyAxy08qoIZt9Eo0Z4T9po20YNdvXj0iyP+sEk1i1d7qTePy3Q7TEBtw==
X-Received: by 2002:a17:90b:5870:b0:2fe:ba7f:8032 with SMTP id 98e67ed59e1d1-30a013069f8mr17797743a91.9.1745894509029;
        Mon, 28 Apr 2025 19:41:49 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097cb7sm9893211a91.22.2025.04.28.19.41.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Apr 2025 19:41:48 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment 
Date: Tue, 29 Apr 2025 10:41:35 +0800
Message-Id: <20250429024139.34365-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In our container environment, we aim to enable THP selectively—allowing
specific services to use it while restricting others. This approach is
driven by the following considerations:

1. Memory Fragmentation
   THP can lead to increased memory fragmentation, so we want to limit its
   use across services.
2. Performance Impact
   Some services see no benefit from THP, making its usage unnecessary.
3. Performance Gains
   Certain workloads, such as machine learning services, experience
   significant performance improvements with THP, so we enable it for them
   specifically. 

Since multiple services run on a single host in a containerized environment,
enabling THP globally is not ideal. Previously, we set THP to madvise,
allowing selected services to opt in via MADV_HUGEPAGE. However, this
approach had limitation:

- Some services inadvertently used madvise(MADV_HUGEPAGE) through
  third-party libraries, bypassing our restrictions.

To address this issue, we initially hooked the __x64_sys_madvise() syscall,
which is error-injectable, to blacklist unwanted services. While this
worked, it was error-prone and ineffective for services needing always mode,
as modifying their code to use madvise was impractical.

To achieve finer-grained control, we introduced an fmod_ret-based solution.
Now, we dynamically adjust THP settings per service by hooking
hugepage_global_{enabled,always}() via BPF. This allows us to set THP to
enable or disable on a per-service basis without global impact.

The hugepage_global_{enabled,always}() functions currently share the same
BPF hook, which limits THP configuration to either always or never. While
this suffices for our specific use cases, full support for all three modes
(always, madvise, and never) would require splitting them into separate
hooks.

This is the initial RFC patch—feedback is welcome!

Yafang Shao (4):
  mm: move hugepage_global_{enabled,always}() to internal.h
  mm: pass VMA parameter to hugepage_global_{enabled,always}()
  mm: add BPF hook for THP adjustment
  selftests/bpf: Add selftest for THP adjustment

 include/linux/huge_mm.h                       |  54 +-----
 mm/Makefile                                   |   3 +
 mm/bpf.c                                      |  36 ++++
 mm/bpf.h                                      |  21 +++
 mm/huge_memory.c                              |  50 ++++-
 mm/internal.h                                 |  21 +++
 mm/khugepaged.c                               |  18 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 176 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  32 ++++
 10 files changed, 344 insertions(+), 68 deletions(-)
 create mode 100644 mm/bpf.c
 create mode 100644 mm/bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

-- 
2.43.5


