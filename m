Return-Path: <bpf+bounces-39091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D296E789
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 04:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D9D286420
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 02:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126D2110E;
	Fri,  6 Sep 2024 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAyePER7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3521FDD;
	Fri,  6 Sep 2024 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725588477; cv=none; b=eDFQZ7fL2e+lPYS3RksPvALcTXlkGco6Tm84LLnfv09HNa/VKdMMehbfyFOqZK6xYij+SAquG13oD+raTBcpQfPcKx2d8C3zLtAj4aZL1rU3rCxDMvsVGUUNYHDG4wFdfRTMTCW8KwCBdnAXv0fB70JnXHoSqhIBezoAcK1WbUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725588477; c=relaxed/simple;
	bh=G3RD5XQamkVeBHQcYiQTep5rnKF4dLumAIVt+qMHUH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkNf1L7ArsMtxfCA6HwUxK8H8cOBzsa9h3HX6ohPCGW6YM8fKG+8PC/HpyBT7q47wkzMKcdKj02ob6QNpCJzbodCLdGjCNKA6c75F516xkXZDj8FZ2rI/imZ+RVXeAyRW24GxpUd5qBTLu9hYo27IJ1hpDqYJfamKRJcubOCwtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAyePER7; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2780827dbafso831636fac.1;
        Thu, 05 Sep 2024 19:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725588475; x=1726193275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeC92OzPOF04P7yDZQ2JHlD1fZIv0s85Rx86Vrq4KtI=;
        b=CAyePER7weS138tnCpFjS+8skwcBKwHjdSA+tDHT8/4E+OmAlxOC17FNF+F+1Z3pb9
         FZ7VKv2EApZR0CSdMETtapn5Vf+CVlQbg7pprwUQJOEZA/0rMvqURfcDauRhwnHe/PUu
         VjbzLv2fUm1ZV9g2xWNi+dINJbQEt44cIBlQKTApBvMr2Uih/MA2H1BFvLtOWM0p2+5k
         e763mRjo6qach4romktbYwsHJbqkhrFTTtqTr+xXygBQDY5Qu457GxJnoz6Gar8iyvdl
         /skLBmoPIAFxICQFc/n0MaW7YOVCesLESOJp053tozmyky6g1+nIZl0umlxuw5OUySsC
         FnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725588475; x=1726193275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeC92OzPOF04P7yDZQ2JHlD1fZIv0s85Rx86Vrq4KtI=;
        b=eczUWRyMlHFzcg935a/VfZWdPnfhm9h2SUE/UFUwDWvKlGRU+y7kkdrYlCGLJtKTnY
         xjZoAx4Xl90h8IAvwy4smmIvqAiz5cMx8kDaH7nLwLEbDvh8DMmW+dwJ+QrFyhHX/XZw
         hG92xeVSrFfLuc7c7ub3Pbb6cGnTjxWDlt3nDzENYVU9NAtKhytC4gse7i1ttOra1HSW
         PGA1Q2DINwIUxPOtG7pJdS8c1HY1vtTGaqlStRUoafHtOhZhd58UO+9Y9Dn1CpgLkIfY
         Y4QWkTnKPo24gie0k0HRkHQroUEwSU1QmLzfTu/Z4tNXMmTZ6cvEPsM8IAGLn7CKoZYv
         4snQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXw+i1IV9QixrNF7KDldpgFklhVAmOUdsX6uG5zvFS2ZlO6U3ey2OQPxIuPXw3iu8a7zhvB0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFn1bP/p9l9i/Xrxu1UpuD7oOIlxpuZjEkWAo/qdspdksgWKZ
	wTeZNZ8wjxpG++QDrW2sRAz77WElnFUYhloDr0LvkV3StmyoEUYn
X-Google-Smtp-Source: AGHT+IE5lL8vWanXpVdAqd5nAMCzSCNWoQXLQirWfj6KhOqzo5yDXYo3VsUUeJIHnFOD1bwYRJhiyA==
X-Received: by 2002:a05:6870:6111:b0:260:e3fa:ab8d with SMTP id 586e51a60fabf-27b82fb7833mr1510068fac.37.1725588475088;
        Thu, 05 Sep 2024 19:07:55 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:959])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd85b36sm3936927a12.4.2024.09.05.19.07.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Sep 2024 19:07:54 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.11-rc7
Date: Thu,  5 Sep 2024 19:07:50 -0700
Message-Id: <20240906020750.13732-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 872cf28b8df9c5c3a1e71a88ee750df7c2513971:

  Merge tag 'platform-drivers-x86-v6.11-4' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2024-08-22 06:34:27 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-6.11-rc7

for you to fetch changes up to 5390f315fc8c9b9f48105a0d88b56bc59fa2b3e0:

  Merge branch 'bpf-fix-incorrect-name-check-pass-logic-in-btf_name_valid_section' (2024-09-04 12:35:04 -0700)

----------------------------------------------------------------
- Fix crash when btf_parse_base() returns an error
  from Martin Lau.

- Fix out of bounds access in btf_name_valid_section()
  from Jeongjun Park.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf-fix-incorrect-name-check-pass-logic-in-btf_name_valid_section'

Jeongjun Park (2):
      bpf: add check for invalid name in btf_name_valid_section()
      selftests/bpf: Add a selftest to check for incorrect names

Martin KaFai Lau (1):
      bpf: Fix a crash when btf_parse_base() returns an error pointer

 kernel/bpf/btf.c                             |  6 +++--
 tools/testing/selftests/bpf/prog_tests/btf.c | 34 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

