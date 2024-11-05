Return-Path: <bpf+bounces-44071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFE9BD785
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 22:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27831C22737
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD521441E;
	Tue,  5 Nov 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VztuKCeq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251873D81
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841606; cv=none; b=bKCN79j2hulc4E+lOm7sqa13H1jCPRj4vByt24zFeoq14yACiCmHgBYvaQ+iW9Hs/JybQFPYHMxWlWlazOCsG1YaDu8O8Ibdl/FBCm/8AY7aKacr3iqHjbJYpA3UYzJbIv2+FVsI3BPriFroq2qZPNUqYKaZuGP0OrpmhhVtsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841606; c=relaxed/simple;
	bh=TQaRudi/R8pktPnIITb0/6xcO1T+pJkaj1TT+wUrsWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J2sdVB905/VExfLBouBeTMForC8ttZ9FqFSXdiKJzyxKDw4j6iv7NOo1faUQFjQ29VZ2R4+ZUPBjDUKlXN3X4vb6Ws4nWPVITGfvKjJFDj/jOUlk7JUWb35Bbf7vc0R0lvttsMSvGtxTngbPNyCq/TjDL1arVFVCnI8DquIwU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VztuKCeq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso4188472a12.2
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730841604; x=1731446404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lvJRS0Iq2Rr1qnscnO445sP51rMCDjYbRL0P/uElMFI=;
        b=VztuKCeqRA1ZQlVUpb12vZcrm/knA2mbYEguJWejGVY2nDT0kfYWvFhIdoG750LTux
         7Th41zq95T08SIPb+rF8XGjJqm04f7HyJOj/BzTOjD0JYuSRzWRKhlMgYmwYtnWdmSbM
         bv+OO5cwjPRpXdxoL6iuZBX2Vy/5AE/FkGmX5CSNT7ev4M5pzoxtGCYYC82Q46QN8f5B
         5PsA+kfY24IsfMSD4qOnAdMInFgq16nFT0Jt2xrs6Dz6IAjwFzIAwjZ/rJyJJHeZmFLU
         ppMFVjGLq+st20s8CMsskjLJa6ETqsBNa5wXu+taCTtVGRITDib5VnqCfUjSTSKuEX9s
         vR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841604; x=1731446404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvJRS0Iq2Rr1qnscnO445sP51rMCDjYbRL0P/uElMFI=;
        b=FZHLADnaCz0v6SoBIHuij/Ej0Kx2ZfrF0aWaeBkncu3J941ggKjm+H32VvVNfA//ix
         IpyujhbX7TKgNHLsXlSIiviHvEaho2PWi1eX353DLdFJGyimSRyuJhPQmt+fh0KR3OKD
         1Ri0tW8ubM8reSNG/iMVjwyU18OYG+PKapWBIjZD+5Y/CNmRYJzk2aqlAd+IHsEM4LAX
         o+f44jcJ5LiBQyMali4PuPVHLYbfxlbEzs9ZHv/69mD5Kx/yzpzkfqBApiShudNhgERs
         LqLH1svRNUdRPgIBHpBUn8781qToCTfc1t7HDT2WXMG9ZinsFlGdcW+1OJBKayaVMSpK
         AvTA==
X-Gm-Message-State: AOJu0Yw4ccUXOZGLsDBoJKcHgVuaMY8XIwOGxiqIbLd0qgC+qGc7NtwF
	9fdenmDTuNBb7Lkju6eAny8dAFDj7yO/EFSC5Df60cW1d5RAYkZCZBHsHQ==
X-Google-Smtp-Source: AGHT+IHOr6UuR/OTItB2xPC5Y/uX2O3GRqNIdSS39MEbeCVUUynWuJDZdIv8YAe3h0ovqFcFaQmllQ==
X-Received: by 2002:a17:902:d4c3:b0:20c:ee32:759f with SMTP id d9443c01a7336-210f76d659cmr349627895ad.39.1730841604058;
        Tue, 05 Nov 2024 13:20:04 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057068a8sm83723025ad.86.2024.11.05.13.20.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Nov 2024 13:20:03 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 0/2] drm, bpf: User drm_mm in bpf
Date: Tue,  5 Nov 2024 13:19:59 -0800
Message-Id: <20241105212001.38980-1-alexei.starovoitov@gmail.com>
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

v1->v2:
- Fix build issues and add Acks.

Alexei Starovoitov (2):
  drm, bpf: Move drm_mm.c to lib to be used by bpf arena
  bpf: Switch bpf arena to use drm_mm instead of maple_tree

 MAINTAINERS                       |  1 +
 drivers/gpu/drm/Makefile          |  1 -
 drivers/gpu/drm/drm_print.c       | 39 ++++++++++++++++++
 kernel/bpf/arena.c                | 67 ++++++++++++++++++++++++-------
 lib/Makefile                      |  2 +
 {drivers/gpu/drm => lib}/drm_mm.c | 48 +++-------------------
 6 files changed, 99 insertions(+), 59 deletions(-)
 rename {drivers/gpu/drm => lib}/drm_mm.c (95%)

-- 
2.43.5


