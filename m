Return-Path: <bpf+bounces-52334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DBA41E31
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A923A061F
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECAB248863;
	Mon, 24 Feb 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUpVu4rS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B12192FF
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397582; cv=none; b=kWqmdBWACLAQMW+3UacM25JSfPnx+xSXRpJWIccXGT5cx++n/quREEjk2c91c+Vd7fNclz1LFpSF7k97dd135gfPlC3GrSOc4zw01MDjDFfHzYqPPvcVZrYO6s3n5xUwXMkL0LuJ6op0UslyZ0JBGxLtfl/JYf6EQqZ5VOh30VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397582; c=relaxed/simple;
	bh=OW6epBWBIuUBgG23LBAIXMgYxdvk2k/wDO4/gkj9yzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZTh2w2QCgdalvPMT/lwIePteH7tSzp7oHQU9VXpncH5ERJv8T2lW9wr0RythtHuACQdCG+vMq3oCZrScberruon0q6CXtr++tdlXUsZaF/Dbb6QCq1h8r5bzh604ykc2D5Pz9G2xGhFpxoNbku+KHEWgbyioUTdwaZTNLE6hy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUpVu4rS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220dc3831e3so80562085ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 03:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397580; x=1741002380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HhevWF4yq+fN91LQ3pW5UcEQuR+VsgbT5NceZsssrR8=;
        b=OUpVu4rSzfbnhUx5fCr7Fet4O9UcGLg6Qfs92saowlgdARq5Kp/tA7uCzav7CsU+vJ
         0qU8RYXCuzAz5CTAj4Ia7jq/up3M2+QgCq+X0jXzYKgbTbzDLbsdVO5mTrZFRAqjznp9
         LasydjDXVhnU7PdsYFyKhuGFNzyaB2iPdQbENMDz0MwsB1tVDoTVPkxWjxWWw3rydN9N
         vYTd4tHNVpcI6vs5GWUmQgQJfLtPehZhY4rfoDGarlo2SmDOtl2np9F9s4yKmvrYq0DB
         8E+1CUs0H44x/Hh6zNP8cQdSvQhPGas3yDfOa7k7qmxSX0hnwoL1JNVoJAY0ecGsOF1l
         9K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397580; x=1741002380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhevWF4yq+fN91LQ3pW5UcEQuR+VsgbT5NceZsssrR8=;
        b=Z54QskHGeLhDa4O6aDKZRBbBKgQT8igG1OpHQ0+A/vtsge5Amco3f83Tz3fLe1il08
         Ibtoylk/wbHVOx+crWc01zSlw1q48RKdYT/kiNdXgMgnm3S1v9voReNdBc8J4IryzHzM
         +74rfdcPmWCZ42C60t6h4IZIn7CCybBgUIhHt5R6QDb+O2Zi5CaBMQ2gfnenq29Un+T5
         zyyVsNLm3jn+ugkvW9W9M54QCu6ud/D/1SmmW7wZIugR8hCyB/wQ85S8xeQZipsUzvor
         CEaMjpzHBGNiDzv1MbyZMvitl1kNvUqQquEHLJWmJQfqpQZoha4IuWZsVKqUHsRWkId5
         zwdA==
X-Gm-Message-State: AOJu0YxiTUyHsQF/FctklHjgfGJ0vCt5AEl00uPAXGB9P8BVLp9jqtdd
	DNI3D7qVTQ/ZpkODlvVSo3+OScgNxUjwtNrPjWGgW86uYko1TozOanR2Tz2M8sA=
X-Gm-Gg: ASbGnctotx1JgYPHnO2RfwuqVMmF8Jp28v3YUUUQ8UsLSxJrbX286POKUjXep/1kqGH
	2C0pjzLzDJSkPR4SFDXh1bmfnXEbVHalOlMQkw6BqZ4M0aTk6j+briOMVQnUe7PSaRd/vwFzv77
	XzOguLFwhrbitQ2u6vez3Sf5QMPnDKopWpFI1eUZYWlMWe8ng36TejDOk0/qXYsOmGWeQqejQtd
	hswDdzqjw7p7249V5RshGtlKaGi/wjapa2GXJpa2FBhBcfn395jcfAk5g7BO/bDKnzHEMKXJ8ol
	LOZevagwgu53XcyWR4jmbHCQnp8L7cuGnPs5z7/f6PbjUkI=
X-Google-Smtp-Source: AGHT+IGWBfOkshkdqpReQ+B0YRlry8p/zWEmdRQywStaE4T5U+v/DMP1oVUN+C2xKIkQkXSlPIt8TQ==
X-Received: by 2002:a05:6a00:3d10:b0:734:a78:2f36 with SMTP id d2e1a72fcca58-73425cde0d6mr20224315b3a.12.1740397580342;
        Mon, 24 Feb 2025 03:46:20 -0800 (PST)
Received: from localhost.localdomain ([39.144.45.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325f063782sm18095080b3a.148.2025.02.24.03.46.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 03:46:19 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 0/3] bpf: Reject attaching fexit to __noreturn functions
Date: Mon, 24 Feb 2025 19:46:04 +0800
Message-Id: <20250224114606.3500-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching fexit probes to functions marked with __noreturn may lead to
unpredictable behavior. To avoid this, we will reject attaching probes to
such functions. Currently, there is no ideal solution, so we will hardcode
a check for all __noreturn functions. Since objtool already handles
this, we will leverage its implementation.

Once a more robust solution is found, this workaround can be removed.

v2->v3:
- Remove the need for objtool (Alexei)

v1->v2: https://lore.kernel.org/bpf/20250223062735.3341-1-laoar.shao@gmail.com/
- keep tools/objtool/noreturns.h as is (Josh)
- Add noreturns.h to objtool/sync-check.sh (Josh)
- Add verbose for the reject and simplify the test case (Song)

v1: https://lore.kernel.org/bpf/20250211023359.1570-1-laoar.shao@gmail.com/

Yafang Shao (2):
  bpf: Reject attaching fexit to functions annotated with __noreturn
  selftests/bpf: Add selftest for attaching fexit to __noreturn
    functions

 kernel/bpf/verifier.c                         | 57 +++++++++++++++++++
 .../bpf/prog_tests/fexit_noreturns.c          |  9 +++
 .../selftests/bpf/progs/fexit_noreturns.c     | 15 +++++
 3 files changed, 81 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

-- 
2.43.5


