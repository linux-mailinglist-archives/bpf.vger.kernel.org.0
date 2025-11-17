Return-Path: <bpf+bounces-74817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC2C6699F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652604E0F2B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28F30EF91;
	Mon, 17 Nov 2025 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="d+j3yOGC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD1255F31
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423815; cv=none; b=slMnO/Zvpv4fj6tjNFKlyIx9vMxbOhwynubUINom15nbeHwrDPSDT01eUTVlsiKDKYRVAhdZAe9dX8PRxhyLaW0+dbukL2mXLMYoZ5AC8p7YHOg5EjUS8F5/1TXnTy3xMOidi0R4p7CSYmqLMCGORVhkgiIQL1Of044C75x7Udc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423815; c=relaxed/simple;
	bh=g+C8C42jixkC27leLcPC74JL+Nl3bpmknzh06vWo9O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmhNRGKnp7MWWkWYMm+1Y/uSpPAUEk/cj+wz2H9TcHyPX+bpjeoHxuEX2pdIrN6V80UtlW0E6TteVANw5UH1HbIgJV5G0XcJybcRpTdCdNjJQSwCtRYp++k/NszIL2NNYEh7ozXTU+mQ8oSn26z48x5bnXEHaMoRVXT9gegj2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=d+j3yOGC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8824ce9812cso53540256d6.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763423812; x=1764028612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMtBVZkKHzIffmkjGxz84AmeL7jgEZVu/kELx9q8AjY=;
        b=d+j3yOGC7PckEIo8VVqt70NuM/ch/haya3I80ruGy8XJ9CCgfXvkXOCv0I1WLrPYhe
         2gAKxQ9mYYLKlVpp0+n8pwrVWnu4EnimQKI3vDmtfqQXR14rQzjlTNCjrjb74iCCjz7U
         SG+Bf12OBgLK6zgPjKQ8EbSpfqq9uw6wKkLcTWiYMNszzwg9kSm/w2un22/xCKAubbyG
         y1RdpbgJQ6w2EwQbsfjQi9BRo58Wz6RGmrBBr4X+YyT5eWC2vuoAJYtAHr7wmHnG51LB
         df/OjNsvm+F4ZVNeHL5TbYMV2bBLXe06Rsf8h1hwK0TUg5VFAdYaFv/bfXCSkLG9I0G6
         7lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763423812; x=1764028612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMtBVZkKHzIffmkjGxz84AmeL7jgEZVu/kELx9q8AjY=;
        b=F/HYB0SmHnaqkvI2sPbglfdc+yoXC1VJ3Nkdq7xY7zP5ahEAs9RmZwFVZZFDx9fWEB
         pG6SYjLoyOKTE6k7+bfLraEWDHkzrFvy186aQ6SU/emdFdTq+trQESYVpMjCBhHem70j
         ioi3A5Ktic1VzDG2lo8dU3IS8udIjttXSnBLW0PVFWhvBNwHvcLVEK3VOVATpFhsHKbF
         QeW/D3ipKUzMC68t9d/nTrkfpaCGm4Im2mP6SteZJ9vsBQNSVtItv3k0ZUGSRQ9xAxrz
         5ZN9X5i+8kmYksOeMzYbDIUeRR5Ylka4ZAbM4GTlUJ2x48xH5yXU44PvklFc1tc87Max
         Cb7g==
X-Gm-Message-State: AOJu0Yw9P/PGqvy9X+DkBZ2O65QwBmRl9levAzwDClT6PutsjsShsNlq
	KNU+tIMvZ04PhI+3MajevYQ2kEan/mt3ITVQ8ppKTqWqoe/Sh+ddJLZtF5MrMyhIzNJ2Ndv3pib
	zAXupjFM=
X-Gm-Gg: ASbGncuHelOc5VE24AXRyrSvvR+m1DKWbP1sRrP6LQ0syRC8cH7FstGjNN75NN/3Qpt
	X4q3EVaLR3yVaeNmcwtCyc25202Zc58PIR/eqGKiMaU1Hf/SRw1JxW2BurfZNdG4Vwv1DI18/e7
	Iq0EZDRWkiwnEOwPDTy9Gj0UFj8AKx6sMOZ9EP040owcJF/vLGDn89rNfxdadUN/HqWhJkUXDRT
	IcvIYomWTuQQlY+TuE8cs8Efxqoc942tv8GpLN7cH1dwPhASLNpmWHTfPM0DfcwUjyl1UJ1Y3WS
	ZFV81dmppvG+PGAhpyMqpVQ0kZLRxwqYE2feazEg/s2X8Bgk2/lL4671xZ6Y8S4KQ6R63NvBz0o
	tjGkkn07hIzu6tY/2Z5PYVEkQfeNcHbMBNRIIAUFMXmXJDb4x134luF3nazMVFWlawOF4cbo+WV
	I25bq7Bim2gg==
X-Google-Smtp-Source: AGHT+IEPhiwRT1enPjJVL1t+KshMvihT/82vvu7I4qMBSQwnK7+2HYw987oFB3EX66T/FtKdTXBusQ==
X-Received: by 2002:a05:6214:f04:b0:882:4643:b0ad with SMTP id 6a1803df08f44-8829275eb74mr194049806d6.67.1763423811824;
        Mon, 17 Nov 2025 15:56:51 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862cf6d5sm103077516d6.11.2025.11.17.15.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 15:56:51 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 0/4] libbpf: move arena variables out of the zero page
Date: Mon, 17 Nov 2025 18:56:32 -0500
Message-ID: <20251117235636.140259-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify libbpf to place arena globals in a small offset inside the arena
mapping instead of at the very beginning. This allows programs to leave
the "zero page" of the arena unmapped, so that NULL arena pointer 
dereferences trigger a page fault and associated backtrace in BPF streams.
In contrast, the current policy of placing global data in the zero pages
means that NULL dereferences silently corrupt global data, e.g, arena 
qspinlock state. This makes arena bugs more difficult to debug.

The patchset adds code to libbpf to move global arena data 16 pages into 
the arena mapping. If this move is impossible, libbpf tries progressively
smaller increments, and finally defaults to 0 if there is not enough
space in the arena. At load time, libbpf adjusts each symbol's location
within the arena by that offset. The patchset also adds padding to the 
BPF skeleton struct arena datasec to ensure the arena's fields are 
pointing in the right locations within the mapping.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (4):
  selftests/bpf: explicitly account for globals in verifier_arena_large
  libbpf: add stub for offset-related skeleton padding
  libbpf: offset global arena data into the arena if possible
  selftests/bpf: add tests for the arena offset of globals

 tools/bpf/bpftool/gen.c                       | 23 ++++++-
 tools/lib/bpf/libbpf.c                        | 36 ++++++++++-
 tools/lib/bpf/libbpf.h                        |  9 +++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/verifier.c       |  6 ++
 .../bpf/progs/verifier_arena_globals1.c       | 60 ++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 +++++++++++++++
 .../bpf/progs/verifier_arena_globals3.c       | 61 +++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          | 25 ++++++--
 9 files changed, 261 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals3.c

-- 
2.49.0


