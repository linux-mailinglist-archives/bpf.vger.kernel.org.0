Return-Path: <bpf+bounces-28649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DA8BC63D
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 05:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F23128241F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 03:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A1942073;
	Mon,  6 May 2024 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuaaNkXH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0CD44C9E
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714966514; cv=none; b=IzTnTEh1KKCLz2P5ayx0Qsadf88fnxTAuU/qUkw9rQROEvEvAGecBm7qgFd/mYR4Eu0qbZB05doqnDnxdXHDxJC4Pj06l8QxnDllMa815rLAVCcdLYJ8yHcxkiycKbHaxgBY62qW9PwqPnivOhk68gebA7GQPKbTF1zZG3eI/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714966514; c=relaxed/simple;
	bh=kNIxcp68aExunNdyH/HpK8kmbbiCNlm/MVDQoVKx2ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZUuTC4V16A6HkWfQHmZxakufpahDtFUskdubh0/s6w3FHdj3hAGtK7/HtR9w41xwCzM0tyg8Lgu3dZmyH5qeMngv3Dpgla7QtzYagmBJSdLEfEJAxhcRw/Xi+riRJWq83xjBmznl3yUBmmEGSJl8hwADbsuLnRuMpyBUlkrN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuaaNkXH; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c709e5e4f9so986053b6e.3
        for <bpf@vger.kernel.org>; Sun, 05 May 2024 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714966512; x=1715571312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoXJ0XdCFwL7dsqz4DKp1C9eKf+cFLheoBEKfmLaHCY=;
        b=KuaaNkXH55A5H0ySDSaigl5UKoVVcrq8ib3ZkXmVnnAy2DG+wtRD6iExNrw3nYStVx
         weyghbqN4QTbm1N29Pe9o/w3qdIletnMS38e6w93IMSIK8jx3vLAJQoborglVYlw01nL
         9vadW5gZKh3NT7OO2yIfWWqLYais95z2MGlog4IgxvGh5yScMaU4pJPXCaHDJDrA/uzY
         BzDF3bT7L/EU5LHgRcpAGi1upTUsh84xHfyRtrM5AqaPguDwVKKYvPKe7VCY+9LbffWb
         eZiOM7ivAoCsaOKCzTcbUr3pBor/ZkZNsUfYCPb7FHE9VGdTK0NUqpj9/+bfgl8H4RsZ
         G8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714966512; x=1715571312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoXJ0XdCFwL7dsqz4DKp1C9eKf+cFLheoBEKfmLaHCY=;
        b=iiQ5VEdbPedKMrjMFwOU/TwvXjV41vGv89KrxedCp9oVeGjdnUGQG15QOStU8gEc37
         0ihnzUFJREvcM/mg3FF2pOBsghid/nrCoaYN6OGB2R9weUolt2jdfhGjesrTia6ow6bC
         lnH/0C/RF6kTrMwhkhfr571p9iWhIM3aV4ANVGoYYYpswBMpACzFiLDfyHXOTsXqp9ch
         q8UjsxguN4kBdjbG+FxDtU7R/gVeIu4Ju7VUJI+i7qeFAv6pOTcjfUQMX78AuPvtqHRM
         M9hBZya/YfJeFDOu3I74YJrVuQw3mCLZQ+xU7VNr0SXMmnYq9tFkYCYQShKgR7r0GoES
         TIQQ==
X-Gm-Message-State: AOJu0YxK/foTQAKHTs0UKMQPKsJgfNv2mHfxwCu4nThZK2QZCxYSh0j8
	I79nGokNzmTHrrVivNw92Il7tmb2TmnyGD0KyyXjZNkWsj389Mds
X-Google-Smtp-Source: AGHT+IGDGPWszOf7ZB8gq6s20eclSHl2uhtrDkDL4Mh2/48fsgIG7nAPuXdH2M56NCVl8Oh6k4jzcQ==
X-Received: by 2002:a05:6870:f729:b0:233:4685:aea3 with SMTP id ej41-20020a056870f72900b002334685aea3mr11609026oab.41.1714966511851;
        Sun, 05 May 2024 20:35:11 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.178])
        by smtp.gmail.com with ESMTPSA id g9-20020aa79dc9000000b006f33c0aee44sm6897539pfq.91.2024.05.05.20.35.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2024 20:35:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 bpf-next 0/2] bpf: Add a generic bits iterator
Date: Mon,  6 May 2024 11:33:51 +0800
Message-Id: <20240506033353.28505-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hree new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
added for the new bpf_iter_bits functionality. These kfuncs enable the
iteration of the bits from a given address and a given number of bits.

- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits to be iterated
  over is (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator can be used in any context and on any address.

Changes:
- v6->v7:
  - Fix endianness error for non-long-aligned data (Andrii)
- v5->v6:
  - Add positive tests (Andrii)
- v4->v5:
  - Simplify test cases (Andrii)
- v3->v4:
  - Fix endianness error on s390x (Andrii)
  - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
- v2->v3:
  - Optimization for u64/u32 mask (Andrii)
- v1->v2:
  - Simplify the CPU number verification code to avoid the failure on s390x
    (Eduard)
- bpf: Add bpf_iter_cpumask
  https://lwn.net/Articles/961104/
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/Articles/939939/

Yafang Shao (2):
  bpf: Add bits iterator
  selftests/bpf: Add selftest for bits iter

 kernel/bpf/helpers.c                          | 140 +++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  | 160 ++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

-- 
2.30.1 (Apple Git-130)


