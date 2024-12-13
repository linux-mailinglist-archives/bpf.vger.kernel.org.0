Return-Path: <bpf+bounces-46838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1189F0CF8
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A82831BD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334E1E0091;
	Fri, 13 Dec 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Y/nLagSV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77FD1DF744
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095270; cv=none; b=oX1Z/WLE7GKLkpR4pZWmeQZhuwvDAzz4n8Z61OMU4Hb42LRJ3z7wbxW0aoa+p+YTuTJFloLw2crUPCy2BHc0bsKWMCxpi7Z0aFNf/Jld2JZuTQScpBgs7+rsRfqmw46nZyFd9XgnDZnTWIcGfpFc5ZWsnw+voc3Sj7rgnXnjfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095270; c=relaxed/simple;
	bh=Bgh9/St2CGdNYZbjfcyoRd3zd3wkFLTLxCID9KGoQ6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7UnPcJyGJUer0DvrVrDuVM7TBgTP72OgsEhCPsSM3wKPTVS2EmRvEeYdi65qxrjf2/tWDIABPXaUSecI402+wf2mUd2pq1fiTBua821G8rOP8sPli97ifHFCgLW0DQOPbLIJqTXNtSc8bUxyaN17P3EO5z/epwLXzVoLX9EhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Y/nLagSV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso3567317a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734095267; x=1734700067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lV8j0qnNkNW0zjz6wXA3c3bwIqPR22Y+NyjNpv8b6z0=;
        b=Y/nLagSVzT+766p0A78ovpx7VWqktm1eNIiHyia9MOR4qC6qlK7FvEX5wyJVFm+Gk6
         szc+BPU4FmvhoZK0vfcYP7+/e+7r8WM4OHyUdTQc781x3tY75AmM5MkaKGkDzG62mVL6
         hMAarW/lZ2QJTEO8gjVMrQHDd+y2A3n5j72PtIRpLiI8xvQijKr5IXcS4oSK2Ucgslew
         yZtx2HiWerdh9RM6ZuTB0OBLBpZJHfYm5CslzAKQLnbsdrLb92LPLvaGAWu9hHU8isJM
         NHGGBYV8XjocW3/N5KuAcyx4NrnFKiHKnLPSds53empXldbgylM4pZ01Sz5eXSp5iIpI
         wW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095267; x=1734700067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lV8j0qnNkNW0zjz6wXA3c3bwIqPR22Y+NyjNpv8b6z0=;
        b=OkiLo1IT8F8h3UolZSh4D31w3Kkgl8v9/8naLcDiPfr6m43XLvg7wg8axWxobl7yJP
         8X9ZHouW4v5Cu6xJzZmAOPsO2X1jVNPiYoXmIG71L2kxPLGWPSUwfRqO4BGfLtBUFUzU
         ifQu9lKpH/kOqEa1WCmBQqayuaAXLud8JmNAOeOvqQLoipiJAwS93xALJnYwQaBBpsGI
         ewsS7TWO2W5Azil9gUhq6n73BKvP8DLibXs0Z7ZmsB8uVEEq0FeLBWwHF3Dt7snbvMyc
         rhU7eedhFwAowLl8wo7kuYk5jSJxdhXV1zPY3LmjPXYPu/MEpc0Dr3Xkz0Rr8YJm+G9+
         ITSw==
X-Gm-Message-State: AOJu0YztU+zt1HNc23U3/3MhzGB/FOOeEeVu/K4JPRQVuPiyhnLhi5I+
	qQHVXrJXX7yD+5xIR7JBC1l5w+YF1nHY/4kI+FkqkSCFGHHx1BDTK01RrShJDy94L/Fze55aBF3
	7
X-Gm-Gg: ASbGncvdlb0i6Gzgd1r06caFaEY2/6a36OPcGB/85eLasDWZHoPkJR81VCJD5t+EmB2
	TgyL26Ury2MvNAoDb1vU706M79+0Hg6BaOXRjaSo6papKKFozz3zYd/Hz+Ii0bD7+Xm2EEvYBx8
	eH0mQFkv8V+FyndI9KDyxa93EZL0WSKy5UajUF6l8D/Z3g1vFgS8Ay4WyeFbFpuE2vDGlrUX5xB
	1jRWO89hLRSKgnqjyn4zxvmazKkrhSQhxd6+it/kJSBP6xsuktfSqMAqm60w2EikQyucw==
X-Google-Smtp-Source: AGHT+IGF6pIpp3KHmeXctplC2NMClQFJAuaI9YzzjM8Ux/XbKqpVUc4hGx0Wno16jv4J5u+1FfUhIQ==
X-Received: by 2002:a17:907:7f17:b0:aa6:8fed:7c25 with SMTP id a640c23a62f3a-aab7792d063mr258010966b.16.1734095266874;
        Fri, 13 Dec 2024 05:07:46 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm931248666b.128.2024.12.13.05.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:46 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 bpf-next 0/7] Add fd_array_cnt attribute for BPF_PROG_LOAD
Date: Fri, 13 Dec 2024 13:09:27 +0000
Message-Id: <20241213130934.1087929-1-aspsk@isovalent.com>
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
proper map file descriptors or btf file descriptors.

This change allows maps (and btfs), which aren't referenced directly
by a BPF program, to be bound to the program _and_ also to be present
during the program verification (so BPF_PROG_BIND_MAP is not enough
for this use case).

The primary reason for this change is that it is a prerequisite for
adding "instruction set" maps, which are both non-referenced by the
program and must be present during the program verification.

The first five commits add the new functionality, the sixth adds
corresponding self-tests, and the last one is a small additional fix.

v1 -> v2:
  * rewrite the add_fd_from_fd_array() function (Eduard)
  * a few cleanups in selftests (Eduard)

v2 -> v3:
  * various renamings (Alexei)
  * "0 is not special" (Alexei, Andrii)
  * do not alloc memory on fd_array init (Alexei)
  * fix leaking maps for error path (Hou Tao)
  * use libbpf helpers vs. raw syscalls (Andrii)
  * add comments on __btf_get_by_fd/__bpf_map_get (Alexei)
  * remove extra code (Alexei)

v3 -> v4:
  * simplify error path when parsing fd_array
  * libbpf: pass fd_array_cnt only in prog_load (Alexei)
  * selftests patch contained extra code (Alexei)
  * renames, fix comments (Alexei)

v4 -> v5:
  * Add btfs to env->used_btfs (Andrii)
  * Fix an integer overflow (Andrii)
  * A set of cleanups for selftests (Andrii)

Anton Protopopov (7):
  bpf: add a __btf_get_by_fd helper
  bpf: move map/prog compatibility checks
  bpf: refactor check_pseudo_btf_id
  bpf: add fd_array_cnt attribute for prog_load
  libbpf: prog load: allow to use fd_array_cnt
  selftests/bpf: Add tests for fd_array_cnt
  selftest/bpf: replace magic constants by macros

 include/linux/bpf.h                           |  17 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/btf.c                              |  11 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 333 ++++++++-----
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |   3 +-
 tools/lib/bpf/bpf.h                           |   5 +-
 .../selftests/bpf/prog_tests/fd_array.c       | 441 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/syscall.c   |   6 +-
 10 files changed, 701 insertions(+), 137 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

-- 
2.34.1


