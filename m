Return-Path: <bpf+bounces-78869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 345F2D1E625
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4833038316
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334E394476;
	Wed, 14 Jan 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAdEmOH2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613D31329D
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389938; cv=none; b=hp4uzVkOFHte8SrrhVHUdZw9fHPw3rQT1c7eItK4gNshMpiln5eqq56Psf4FKJS0dKZ/s+rFz1vzigaL+e0qTOtnmRNL/VNXodrsZW4+LUyfDnh0kKKMcN1D5IYvTwMmiGd1MTA9FrrvsGkuyxVMB8V9xa+kb0gTK7I1J3OiemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389938; c=relaxed/simple;
	bh=FGOU5P2/1FVpgCG8TlvNskYI/TbLFqZFUjjAFbTxjiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ObpSfaJRjPU7J9vu0eU1upvEpCYJQZVPsrrSMQL03DMK9Krj0udMKtPuRGu0K2MBopj9ZvurckGQ7e/quHr9m/7bV33EMxE/L+8VsJDowNPBZyR/oYzp1IDu5nRbYod9CebQo3AXW7RHe52sDitfy/FvuFjl9Zj3987N1IY+9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAdEmOH2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so13646198a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768389935; x=1768994735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkTzUOMhWbquJEMyi1Rxk4gEIuIZkgcGjB5uDrQBJYE=;
        b=GAdEmOH2MdMKmUn9uSkjxOZEBE5eC0JhDinsMlgf3HCyQMU4ufgWM9QX6US6DJFsrE
         y3X4DceUEWnQ6xeqIdYy/oFtfBAynm+tYcuv5czCSST73b3z4tOld4VvZ0bCfzxoOnR+
         BqgjrYJuXh7Y8oqgEleikvEiigG0IQzcGULRv+wyDJRhOTJ+loPZoUXDOZSB0Sljhi//
         0H0DJOZRxFhqXazyfBGvpeut5VZakIBl+cQm9dzPQXZmtLqD+X0mtpaqjaj+cZ+4i5e1
         hsQJuI2y4wVN1RRi9OsnjmCiAgjOiXb62fwS63oP6P/+K8lZDxNuA2Gfti7BUrGZ/56H
         WRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389935; x=1768994735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkTzUOMhWbquJEMyi1Rxk4gEIuIZkgcGjB5uDrQBJYE=;
        b=YddFHNhCSKZSCCkYdcCy8Ttrn8RA6XxzBQNk04+eNn9SOkdcipxENkrAPCkvMLTHgs
         7EEUsL3tkZ9D7TeHaCBnuHSiCt0JJ1WpUdi/p1K65n8foYP9QeB0RSaLHzxMMc27x6ux
         lD2s11BjRbDPq9qgd4QNhrS1vdZ4zFL4F2EHYADXtTsGC01XhbOeAYVQ7zelpYv5fdl5
         Qt/UcaBLXl0EDusY7L9UTVRsoHD72F5PtHqgGO6E/rBCc6C33GCqEgwdaxB2tCodo58W
         O5KCV5nWU6SPKjIFHcFpVNrC/dfTaI7rO2+suvBKJh2tMxKLthvtkN0iWiBW+d+3rXgR
         czDg==
X-Gm-Message-State: AOJu0YzZ4FDnYWzY/cNSW5HPPZDG2a8epzswEb9OV3947Wj9YiMBjVDw
	Ju68V4CVB9w/RxcHFNGdZmGZkJtdwd0jMMOx5WaZi1lUpJ6q2SGmeecNfJGbHA==
X-Gm-Gg: AY/fxX4zP7AMwfK94NQLwuFRlHfj0o2IhyDabGk8BcYsmVc1HD8YhxmM7H5VXRL6u6M
	c+Ci0S+9nO2vy4SBHf74i0Q6u4iRMpPf3skdhGok3vbvjj6vzTYMhFylcTZGcBcn4mK5X/UvQre
	U5NYfzxeYv3E/zmMoTace5ObBtl53599H5Yuq+8v4xNi7ECQWonrLN3ZrP27YJPMRwZjKCnHKFt
	Ohb5a1XQMPHpRbHp+kH38doPEgLMvt2k3uzZ3W7Ho6cIf3PEi0+LO7bdvkwbkZbS7ZB2WA9e+HV
	ukheoTZCrtMtWEMOuq+1LNk+oFADcoeLX2aPYUp4MxBEmW0dEOu8O2fEBrsmkExL3c5y+AakTou
	gwKUrPRltEFW5q8k4XrCMcYOXQtcjj35YWwg2fT+HzjgvKL+1CV4YNKBMoIKdNspJ6TWQ+wJ1Uc
	U6O7BJDiuUNu2ELZiCHpg36FelIytC3g==
X-Received: by 2002:a17:907:9629:b0:b72:70ad:b8f0 with SMTP id a640c23a62f3a-b876127fe74mr182848866b.36.1768389934453;
        Wed, 14 Jan 2026 03:25:34 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871188ec63sm980423266b.1.2026.01.14.03.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:25:34 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Live registers computation with gotox
Date: Wed, 14 Jan 2026 11:33:12 +0000
Message-Id: <20260114113314.32649-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While adding a selftest for live registers computation with gotox,
I've noticed that the code is actually incomplete. Namely, the
destination register rX in `gotox rX` wasn't actually considered
as used. Fix this and add a selftest.

Anton Protopopov (2):
  bpf: Properly mark live registers for indirect jumps
  selftests/bpf: Extend live regs tests with a test for gotox

 kernel/bpf/verifier.c                         |  6 +++
 .../bpf/progs/compute_live_registers.c        | 37 +++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.34.1


