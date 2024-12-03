Return-Path: <bpf+bounces-46000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C29E1F1B
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 15:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CE5B333FD
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2512AD02;
	Tue,  3 Dec 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HvTxL66Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7411B395E
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233722; cv=none; b=AIdLl6HTFu1Sfh6byTaOIKf/x1OPd6WM/8tRClAYWOsLI6I5uTcyXDu71wCVSOH76ycjZwRo6T0Fk8EgCoBZPYp2wj/EEpCG+Map2Zy+gQZs8oAxn+hcrIGzmc+rd1HCxdl+13hzUmKNo/3AhiVa9Y8Ngk4bATAd3utDfJ8mvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233722; c=relaxed/simple;
	bh=hhQ2XO9rTwHLewLsocshrgC7DLcLE29xIfhvLBkuPNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bLArmlNkKKw7FgMSdeoPg+UGjsGQfpRpoYnnHIk0bctScewLcjkp7xp+8HkiEtaYssRjIbGs31DgZLfalUmkKVOxtOzB7tWO8hTz5lx2YTe5EA+WnDLidCjjfbnbqkdJJe5zpNeMEs0oj3BC5pIYu76W58jqrGKS9PieKURLFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=HvTxL66Z; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0d71d7f00so4884066a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233719; x=1733838519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCeLtmKTjgwrImMMogOVWvtYxxbEbk+9kOpyESOcPcM=;
        b=HvTxL66Zzabonwtt3M2woWX0rg7OW7VP+XQIE83IBsjOd/K+1nycqcq4Dt27Ddltrk
         rNALj6qLleh+RoECj9o78eEcEiuRIPYxqX5yb1S+CmJTKtf27G03EE99kk/gzrLsJ1sF
         /iveX4htC/XysSUvPKX2wwGjastn1Llthz1oksl2plIVwKJzeA82QqsZBw/1NqMaM5q7
         vXMWxLjDz99Pzk5RxlleinQEHfBqr01+R9FctYhGtibzgYU6XZY2Bjq030wzvUlJCfKM
         1egRbtu4WoyX0/9+XCyovlT5A2NU27mBAA8sSyae9WnSsXhxWS/53yxUJJKmfvtF6FLp
         OnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233719; x=1733838519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCeLtmKTjgwrImMMogOVWvtYxxbEbk+9kOpyESOcPcM=;
        b=dxOnQ0/Lfhx9R16CoMaUgVbFgggZt6LGl5fhBM1XvhsBK+yY5Zda4R327oyTTyD9Vf
         9BG8YaChFOPgoALsdhXd/MLj91MJsLRrv3z/q6GshsZ8gtIPu4k9dnFLFF7/xDT2woGb
         hqooN9qllrgASFiU0EuVctz4Rjje5Umd7V6Fq+PKTIusUOaWwoaDHwxdt1LhJDq1mL+H
         XbawfzDMlAKy29rLmXIBDOZHZz3ixQu/Q9SF9DYZ9b142Sl4F2x6pTvs9kvCnGV1mIER
         UFV3tONKeUGnHOBqscn/8DyIunDMcfzyZmBbrD5Itx422brM4Pp/QtGr0vZ/SN3htT1J
         0MgA==
X-Gm-Message-State: AOJu0YzTosuzy1rzWJU0FQqmNezh4+a5nbGOd6lrENRKXIhlvLXsfXKk
	Db1BkyzY8Rd1CZDmOFcv0Z4An1dqHuxzVEFsEca/noOF2SLFYhdZayJhKdZXpAPjsY+6vt0hNVo
	X
X-Gm-Gg: ASbGnct0ZsJNY584d4x7JDOSi1LrMraVvu9tHJQ4uaSzk6xBTVWEW2plt+jC9wYHgoQ
	sgU2nHVM72nCX2HMGZtpmDEOIMm5LAlGXMmr04iAQpVSNKIUEXULvOOM1hNbM+X3UJgu7p9CyUt
	t/UxEk1plBsLWQBW7N56B8/MFzcqf82zBdwczsaohrVkUPEonXk22DvBbpQViI22F7BNYRp6B+H
	PGF3fNUypNN3nFaelXoW9bLvkmu7Boe/KKXnGOR7yz9Vdkt9bjVQo+gJ3zBURU=
X-Google-Smtp-Source: AGHT+IFLIFjBIezedt1ESyvy3OiANsv6mu2KffcgMEvg7IcC6aEILx84wMsV22TQTYpy8l5gQCniqw==
X-Received: by 2002:a05:6402:35d4:b0:5d0:bcdd:ff97 with SMTP id 4fb4d7f45d1cf-5d113ca96a4mr193495a12.5.1733233718726;
        Tue, 03 Dec 2024 05:48:38 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:38 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 0/7] Add fd_array_cnt attribute for BPF_PROG_LOAD
Date: Tue,  3 Dec 2024 13:50:45 +0000
Message-Id: <20241203135052.3380721-1-aspsk@isovalent.com>
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

This change allows maps, which aren't referenced directly by a BPF
program, to be bound to the program _and_ also to be present during
the program verification (so BPF_PROG_BIND_MAP is not enough for this
use case).

The primary reason for this change is that it is a prerequisite for
adding "instruction set" maps, which are both non-referenced by the
program and must be present during the program verification.

The first four commits add the new functionality, the fifth adds
corresponding self-tests, and the last two are small additional fixes.

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

Anton Protopopov (7):
  bpf: add a __btf_get_by_fd helper
  bpf: move map/prog compatibility checks
  bpf: add fd_array_cnt attribute for prog_load
  libbpf: prog load: allow to use fd_array_cnt
  selftests/bpf: Add tests for fd_array_cnt
  bpf: fix potential error return
  selftest/bpf: replace magic constants by macros

 include/linux/bpf.h                           |  17 +
 include/linux/btf.h                           |   2 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/core.c                             |   6 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 193 ++++++----
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |   3 +-
 tools/lib/bpf/bpf.h                           |   5 +-
 .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/syscall.c   |   6 +-
 12 files changed, 524 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

-- 
2.34.1


