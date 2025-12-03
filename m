Return-Path: <bpf+bounces-75974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 105EDCA06E5
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 18:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A4C31B3317
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEE35CB7B;
	Wed,  3 Dec 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Z69Gc9Ba"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34835CB78
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779201; cv=none; b=N+/7sknRUdYfLfK2q1w5LVOqcFQI0yShX0xiWXf/bwoU2DioXY7mpwdrkqWTBNX6aAgh+BNEHxVF+iErR1WIEzgzQ/D86047VgeqYCo7nLqJiMjGsbOzlBLZg6w4YXH3S0hQxQ65zBhp25vbDBYHOA86YPfE0NjPzSDMiJRDfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779201; c=relaxed/simple;
	bh=GR8WoOv+/2T3w97KzXA/J+nlPU6gelboCoRzQ6rbMmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiOqLlchOD3OLDud6U/17uDofCye8ploMdBK8cyYLCr0RwgIWblbIXWT9tWa9AmhFuuvjY47/zrx5BVxBjTSS0k7aL3X49t20uVqx/uPhi3hiYCDOoTe0wpRHcgYFeuybsM0c7ayuglkRd3ZnhBBDvjtLAHIDqt0upGloyqfIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Z69Gc9Ba; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee0084fd98so51728861cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764779198; x=1765383998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jU3Dg3pd2TwKKTZCy1S8D+XNcCoM+FcTIveNS2Myg78=;
        b=Z69Gc9Ba8gPrwF5xBV6OeFTqW/hQqnYAlJyMn+0aW1GHDfGVPCytXFeYY/LnonEN+w
         QEnDJaePenKlH74Oehn7gK3HP/jdRm/cPkPZc6dgU2Qp/Z1KFI8MA4JQ1agAs65u9VpF
         IzeKT5MM4+QpXqVeLwfgbs84t9xmicEwmZkvxAQTxwpYcAAiq3mVFowYxt+Rvz3IEuEh
         I017x6BAXOsOmFW0eyWTzH02dPG9jzAWXGTjDHTg4NwvnxgkDABqnQGc6oVh6+/WLAQC
         HOpaT7u0Ow/8R7Qxhh0P7v5A+c7WHetPQqRjoauWYibmQsRsOmJSzu1weqW7MBtFj7Sw
         rqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779198; x=1765383998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU3Dg3pd2TwKKTZCy1S8D+XNcCoM+FcTIveNS2Myg78=;
        b=FZCjjbd4xPc0kgygQeB3obIZvG9PoS01vU3rGGxpalA9EbPCMF3Z1ajb5zG9rhXM3c
         guiUyD9xbvqbMDo3gQnUFN8/wh1VF4M3DQL5ttWzi5T13+V4uMaaYduOekHWkoZ8HQWz
         yHmz513Rh1MhAsDyGoRbcVvBQpgGcyhwo3v3qSwUCrL7cwIpBILOqeVoyCqRRwaWjUaq
         o6vFlq7zNBNyWrLSpBK6pNKiSV/JUB8/XLYfgYgO1R8UOBNdkoKW+OcnKYMkZHLbIlN0
         lamhDE5cuBXPx/iiqsQory1CjS1aNM2fx1LnqwE5u4dkRbqFJ05d9g7j9MUU7CS2c+wF
         BuiA==
X-Gm-Message-State: AOJu0YyR1UR+xsN3gTXIaqWUj5GRUvYaOLrXZRa0fyYJ69O8PoC6rj6C
	0ZfKGin3nwj82JYLEeFzB5Hj5a5vmDZ7vfBHXG5ZQeHd7ykHqJZNk5giGHS5P5DHI4DFT0aZCsr
	XMXG9ToY=
X-Gm-Gg: ASbGncurj1vOYhNxHxQjKin6zPe+cLEC834JR4YeCuwrWBrUAQ/g3iG+PPJj1j+0wwi
	hsEg3C5X+zvvxHXtNub48LSDIp/v9w8uVHu4RQWR4wjTVibZxebiTYEov/FRBQyQFwQOBS+ofZk
	liM/qxsRhKOFa/3TaL1l3aOiNSuj8tuNWXGPpSQ4+srPc05ZHNYWR7bG1DeJYS9/hSVM6THlJx9
	BCYm3p2NM42aGD7B8meuTy9gHlxyBxc3Ol1CHrY1Xk/aKimwUVy6iOQk/Qm5IgL9YbotytoSSeI
	2X57MMd9CRFEHGB/o0wNaOmsuHa/DTyO95fm304FcrP0TMkUm005ADw1qyCme39jkKRxG6h+C2B
	Ow2i1ZMJl1HcZMZRVMJ+wE8ISByatOz8pjgYvslWonmUQM0oxL1T/Wn5eCHz38FmlglUoKKcsbu
	cwatgey1R6uXWNPMgmDchg
X-Google-Smtp-Source: AGHT+IHV3I0+avZLDnEGpWO9Cnu36BrQhqmKy98Cd1itJqaSpCknfkRHtydVNq0TZ6pIDQ2A8Af5wA==
X-Received: by 2002:a05:622a:13c9:b0:4ec:f577:c5b4 with SMTP id d75a77b69052e-4f017530285mr40480291cf.16.1764779197889;
        Wed, 03 Dec 2025 08:26:37 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f0046825d6sm45279411cf.5.2025.12.03.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:26:37 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/4] libbpf: move arena variables out of the zero
Date: Wed,  3 Dec 2025 11:26:21 -0500
Message-ID: <20251203162625.13152-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify libbpf to place arena globals in a small offset inside the arena
mapping instead of the very beginning. This allows programs to leave
the "zero page" of the arena unmapped, so that NULL arena pointer
dereferences trigger a page fault and associated backtrace in BPF streams.
In contrast, the current policy of placing global data in the zero pages
means that NULL dereferences silently corrupt global data, e.g, arena
qspinlock state. This makes arena bugs more difficult to debug.

The patchset adds code to libbpf to move global arena data to the end of
the arena. At load time, libbpf adjusts each symbol's location within
the arena to point to the right location in the arena. The patchset 
also adjusts the arena skeleton pointer to point to the arena globals,
now that they are not in the beginning of the arena region.

CHANGESET
=========

v1->v2: (https://lore.kernel.org/bpf/20251118030058.162967-1-emil@etsalapatis.com)

- Moved globals to the end of the mapping: (Andrii)
	- Removed extra parameter for offset and parameter picking logic
	- Removed padding in the skeleton
	- Removed additional libbpf call
- Added Reviewed-by from Eduard on patch 1

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (4):
  selftests/bpf: explicitly account for globals in verifier_arena_large
  bpf/verifier: do not limit maximum direct offset into arena map
  libbpf: move arena globals to the end of the arena
  selftests/bpf: add tests for the arena offset of globals

 kernel/bpf/verifier.c                         |  8 +--
 tools/lib/bpf/libbpf.c                        | 19 ++++--
 .../selftests/bpf/prog_tests/verifier.c       |  4 ++
 .../bpf/progs/verifier_arena_globals1.c       | 58 +++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 ++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          | 21 +++++--
 6 files changed, 147 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c

-- 
2.49.0


