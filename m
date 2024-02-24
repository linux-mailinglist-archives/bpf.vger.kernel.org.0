Return-Path: <bpf+bounces-22642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEEB8627F4
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4871F21984
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3814D5A0;
	Sat, 24 Feb 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN7/sSDm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997B481D0
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814064; cv=none; b=tMrFtmtnDlpe5T9kwV5FkiIlSIy+SibNXxSNGvKsmoGgCkrYtKDcI8X9kWKHEN2ZAAUjM/Njj2nEas1jB9ybXSNySx7gNYCO0bCnECw0/2CWBKQ7wOP4WQaTWSi3FrfFgFsVgz8TplaXpu+RrCwKMzEnxUzNCKyjNVrn25weXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814064; c=relaxed/simple;
	bh=Q2Uv3KB0JLXAyNU2okLeh5p2hClorA3+u1pzTkiY+Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBYWXVFMvlua0w/TRSLpA87sP4IAEC3FaIWj7WTOiHqOzRC2SVcieLFbCIMNBjf31i0dUjmizrtbdnZhXC0qBFKPAOfHoSPzJCE7ACoUfldVejxKn5hmKe2Hxk2snLblDhjzN/azc0CICmzGGbGgaY6HgOVlKnOleeU70OxMEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN7/sSDm; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6089b64f4eeso19306707b3.2
        for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 14:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814061; x=1709418861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inwG6n/HTwkansOYZCCl6fh2aOFbOCCywNH3rDWHehU=;
        b=HN7/sSDmH8uiWHIBd8NJ4EyzhBaBfTVv03EF6OgmeI9LxLZNkoJSFnxYNkt8IwoiA+
         5bVaj6auq4SwFUGlg0YsHA8LpVl+3xtVIjB+2btOqS1zgeyLRVfXN1/sSq6RTF/pbM+d
         7WcpTHJF6KakLiyI7T132qRaMM8pPPf1hZIayyArUh8YsxFvU5gui3MUE0u2zOVhun+f
         lKHHO9SVwy+AdHxlV/sfrhsKLkwX6Nbyc4YSHanaYcd+g8hWdNVl/9hThI4uNvkmXEJa
         GhdZfFlYvtmoZczs3hXVXrNaxWPAvZ/6mwLm+pldwZlQDhMhUYXJEDCvLWOV+tjUnWbR
         6cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814061; x=1709418861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inwG6n/HTwkansOYZCCl6fh2aOFbOCCywNH3rDWHehU=;
        b=hDgYtc3OGIjvwQjoXNeOO5GrFkGwAd5lranvDT58cX80ppsAOBMoyxH1m+26DSw2zm
         lTGIUbJe5rJLlTfFQJPQbwxNbZNym8MKbbuP7P+2QN5g2xkdJ04BtNglQcxJFHxYWeB1
         JXe7ZfLJC/rogSdFNvmMMsQnviGVJjuc+kKnW9iebOMXNwcABIwP5HDDh3/XrgrcOms+
         UZeeTXX/OIUJiTm27Xt4XiTk8VU4Oa8Z061bgeZMrG3p83e7BdCG2E081MUaQR+N1AGh
         FUsVNjzaQECwvzdVrlZT8D5r88bpsr0Bnf2uv9m4WHa339Jmklr122C/UmAtub9+yU71
         PC4g==
X-Gm-Message-State: AOJu0Yy4G5efDuE1vyDeJB9wKyzk6AaXNwdhqMCOlvV84nNgSvT4sAOy
	W8grwGqVjtOEnECun3LDGqcBwSaaEsA9/bBYqpBZ59VpMCgIxHe7BrzDnL+H
X-Google-Smtp-Source: AGHT+IGYT2Xqip94BmYtPN1sU5LpqVoRpPuLZ64YgVAsS0WVgG3UUvoU8Xr6J5NRiHHoxalwWw785A==
X-Received: by 2002:a05:690c:f85:b0:608:b83e:c346 with SMTP id df5-20020a05690c0f8500b00608b83ec346mr3752217ywb.25.1708814061117;
        Sat, 24 Feb 2024 14:34:21 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9221:84d5:342c:9ac4])
        by smtp.gmail.com with ESMTPSA id i184-20020a0dc6c1000000b00607e72b478csm474010ywd.133.2024.02.24.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:34:20 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 0/3] Allow struct_ops maps with a large number of programs
Date: Sat, 24 Feb 2024 14:34:15 -0800
Message-Id: <20240224223418.526631-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF struct_ops previously only allowed for one page to be used for
the trampolines of all links in a map. However, we have recently run
out of space due to the large number of BPF program links. By
allocating additional pages when we exhaust an existing page, we can
accommodate more links in a single map.

The variable st_map->image has been changed to st_map->image_pages,
and its type has been changed to an array of pointers to buffers of
PAGE_SIZE. Additional pages are allocated when all existing pages are
exhausted.

The test case loads a struct_ops maps having 40 programs. Their
trampolines takes about 6.6k+ bytes over 1.5 pages on x86.

---
Major differences from v3:

 - Refactor buffer allocations to bpf_struct_ops_tramp_buf_alloc() and
   bpf_struct_ops_tramp_buf_free().

Major differences from v2:

 - Move image buffer allocation to bpf_struct_ops_prepare_trampoline().

Major differences from v1:

 - Always free pages if failing to update.

 - Allocate 8 pages at most.

v3: https://lore.kernel.org/all/20240224030302.1500343-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240221225911.757861-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240216182828.201727-1-thinker.li@gmail.com/

Kui-Feng Lee (3):
  bpf, net: validate struct_ops when updating value.
  bpf: struct_ops supports more than one page for trampolines.
  selftests/bpf: Test struct_ops maps with a large number of program
    links.

 include/linux/bpf.h                           |   4 +-
 kernel/bpf/bpf_struct_ops.c                   | 139 ++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c                |  12 +-
 net/ipv4/tcp_cong.c                           |   6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  44 ++++++
 .../prog_tests/test_struct_ops_multi_pages.c  |  30 ++++
 .../bpf/progs/struct_ops_multi_pages.c        | 102 +++++++++++++
 7 files changed, 280 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c

-- 
2.34.1


