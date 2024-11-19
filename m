Return-Path: <bpf+bounces-45157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629369D2322
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C7528109C
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DD1C1F1A;
	Tue, 19 Nov 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="aXGoSz7i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829C19E83C
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011194; cv=none; b=klXJP6DuWf0Z+1RcZsDXGVqxNW4kpAZ7C3MerpwJZEsjUdpKZOZcwgVMUw0tcSi+kHrQKhKMExBZhFni9STrm0GLNGYDTpCMfIQbst63FVsMmimkluo8YcSqY2y20nyZIFKxSTFitknVlVKqUBxRZnEiMbI3ffGBh+7lqZpUmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011194; c=relaxed/simple;
	bh=5o6ckwbyNW70lJ5wsmgjJ7P8CYGAjuIsOosf4J2xjJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WF3mIQSVn1BzJMcQPE+5dZUSRyRnVilQZrQ3HgFw6FvEAa3KjEMePayzA7sV9NKO2SjnOvGlmyCeI4d1Dy+Z3SzP1IvDst+x3L8o03Y7CmDm89/CS3KxNbVXmgIS7qpE6r46VooMLVYV/JH8L9R9Z5EN56slZkpkjF2WoS7b28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=aXGoSz7i; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9ec267b879so680606466b.2
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 02:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732011190; x=1732615990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yAeTKrdwVO0q4IaNFyUWovV1HeqqPL4g59d1D6cjWw=;
        b=aXGoSz7iNkwuezj+k1zTmQqrNZGG7eWKy3ZtK8dMlY8WAWdYEbew5TsAo6SwHiTTMW
         f2QgJya5rvhlgcgHvdmowEfmAqYtMuiAh/5CGyVIcwdoK1WoKFSC/utMgv/IpXfh4lIL
         QLr7IuTsinEopd0JkejuEXupi8E+cf5esl3B0rx+t4/axqRFhwT6KgnpJc6klAwQLA3U
         xaT0ZzlQlBlKDVk6/MFspgHTIj+vISwYTI3CTA9KwpLRJtgye5s7E1YB6nYaiywDxdg/
         PSVdappUlXRVjCm5oJmK1TpBWij86V62gY75/nsUHJ9rM4OTilxS60ekCnvPX+x+M1cf
         cR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011190; x=1732615990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yAeTKrdwVO0q4IaNFyUWovV1HeqqPL4g59d1D6cjWw=;
        b=iGhsIRcJQN8SdbXOw6LTM8V86VYIBU/85rKQcMcfWzYFt07Tg1uQVCUh121ueF+H7C
         sQFbTQFaloUY8ixFzlXkhMGCKtPrJKM5k02h/eoMsgenDVR7ZZh+QVY88NxFnLwC7MRV
         Yoy02BpWOoJ5bzvo7wMwZna9iJDynf5urhfbEnCBfnYjvIMDnlnR3kGzqg1L43/c+SAQ
         43SChAiFcBmScpV27XTHlCj8fpVx2Op6TxecEXclafE42tAXSlx603G3WYpOxpqowiMD
         LFzt0iK6GzKB0VwUNvYAu3KbviB2wqQhBdGVPkUEm4sJ/uDJEm/hG4F6KANqzxhHohky
         x90A==
X-Gm-Message-State: AOJu0YwT9MJ/pJRetv4dM/MOQ0nnJPOGTDTzl+kqFwXYDX+qTVoEv6/M
	YOZw+9OWhvxtG2wfiE02U0UQSHarntX25izM70rBYwJn26uz2gcatcwF0CHqWnJQoUWAcAZOMDm
	L
X-Google-Smtp-Source: AGHT+IFRdV4ETJiHy0QkAJZOip6GBcbbMNPkhznO/f6qyze3htbwaBWdK33CQ2B4TYk/THbolUfcmw==
X-Received: by 2002:a17:907:9624:b0:a9a:80bd:2920 with SMTP id a640c23a62f3a-aa48354b9ecmr1308075966b.53.1732011190412;
        Tue, 19 Nov 2024 02:13:10 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7eee4sm629003066b.87.2024.11.19.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:13:09 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2 bpf-next 0/6] Add fd_array_cnt attribute for BPF_PROG_LOAD
Date: Tue, 19 Nov 2024 10:15:46 +0000
Message-Id: <20241119101552.505650-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new attribute to the bpf(BPF_PROG_LOAD) system call. If this
new attribute is non-zero, then the fd_array is considered to be a
continuous array of the fd_array_cnt length and to contain only
proper map file descriptors, or btf file descriptors, or zeroes.

This change allows maps, which aren't referenced directly by a BPF
program, to be bound to the program _and_ also to be present during
the program verification (so BPF_PROG_BIND_MAP is not enough for this
use case).

The primary reason for this change is that it is a prerequisite for
adding "instruction set" maps, which are both non-referenced by the
program and must be present during the program verification.

The first three commits add the new functionality, the fourth adds
corresponding self-tests, and the last two are small additional fixes.

v1 -> v2:
  * rewrite the add_fd_from_fd_array() function (Eduard)
  * a few cleanups in selftests (Eduard)

Anton Protopopov (6):
  bpf: add a __btf_get_by_fd helper
  bpf: move map/prog compatibility checks
  bpf: add fd_array_cnt attribute for prog_load
  selftests/bpf: Add tests for fd_array_cnt
  bpf: fix potential error return
  selftest/bpf: replace magic constants by macros

 include/linux/btf.h                           |  13 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/core.c                             |   9 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 203 +++++++---
 tools/include/uapi/linux/bpf.h                |  10 +
 .../selftests/bpf/prog_tests/fd_array.c       | 381 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/syscall.c   |   6 +-
 9 files changed, 566 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

-- 
2.34.1


