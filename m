Return-Path: <bpf+bounces-22648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A188629EC
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 11:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471DF1C20A17
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36998E55F;
	Sun, 25 Feb 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpRsmrHh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505EA50
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708855630; cv=none; b=G+ntoDd4fme+i4+g6RaIxWPoiTrentZJ2z/z5qJIFVU+6UnzjgZhptyLivrXH4V8LwTz5txQ2+8wNCo3wO4ieL0xBIpyEPzQqEv8TvuYadnVaCp25vd0wKQ1PGVUvstbN6b7rBY6zLntq7tVdHBHKf/QmCflz+lpIE5pqBwMeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708855630; c=relaxed/simple;
	bh=P5BD3nAEerbKfteBlsYM2K4PeJ0bQo6Ffg/q+amsGOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HondwUoLQ8OdI2sqcgnunLuoOhAKGn2wJu4sv1IVLhsrSXO27eux7NYKwpLCA0E2rQ72Eku4n/XKX4WthxGvPOkTn03HCPeDINti94qbl2S9qiEH2oHPnn/NXaztIy5p/OSCpx79eL3XUUJNdIWVuyPJ78di+gOF+wSYgdxr0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpRsmrHh; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c132695f1bso1344974b6e.2
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 02:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708855628; x=1709460428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vekXwb3oxruqG86Lc25kSlZc7qGC3yPCrP/NRyv72aQ=;
        b=JpRsmrHhDVAtg+RouRKQjFzvKrqPAvKO9cOvkTQE4PvZhyvEOLmQT6rXq0eJuU1vnq
         b/B4B/x1qS12/da2GH0Fqp7BngqHpiCPaDwZAhVkSCqvhBsNX43Tauv+LplD1JXpPTB3
         8P8k9R2ltsAcDSfAtnP0qVhUS5WLTVyd5uUwPMjp176Mz8NRBaxKgOJl6JK9TyORyxsR
         OFUNlUWcikRa/ALc2yLkNBu9QTRbXX5CPBegzfmvx9V7S/tcKSpz5hnm0R/eFsraxRfS
         TbxDPivqmMa4qiSARPIj1Ew87PA+tcp2xxmPiQ4VVT8QLTJKoXgbEUq4gcXzpBM9EP5d
         4Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708855628; x=1709460428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vekXwb3oxruqG86Lc25kSlZc7qGC3yPCrP/NRyv72aQ=;
        b=p2gYVDUtQrPkzdopdLY7BvATNQ6WX1sFL15oIXdI95uhFq4ACZWYTU6aQTAUGHYSkw
         5GklctgT+T0RiiBxui5hSiw9SXB3oQxV7Pad160qm5K490kwXh+qXOi79c45L8tBgVkM
         6kPsgUO6zxbD4sT3+l/ChrJIPQnpeaWLtJYCrm1SA7luonkKCUUAkiXCyq448vUYv8h3
         DWi23uSeFQ9MZb3IB39Vl0xL2+b4q2SLy8COrZRKPuYUqpBbLuCikUXw/T8RYlCO3V5d
         Avizym0tC71s1sxNK0YVsAFPCMOj6HKFMoQyB2Mi8i1/7K26nP6f3Mz825hTlQB3A75x
         KJVw==
X-Gm-Message-State: AOJu0Yxqck7C+uhcm1XmabwbxXIiOY7pMVlbuaZ8rKwv/qWMB6uPhhm+
	TOunpHwf+xg3xN5oNekxBsHMgU0DECsz1UDsA8fWz4JE8SAfWaL0
X-Google-Smtp-Source: AGHT+IEfqczSYUp5gKpiGWmwBF/LSyWYF+V1/x0OUz+Z2nWvpIDPVtzeWQztTtXaPA98ClTWa23N1A==
X-Received: by 2002:aca:1107:0:b0:3c1:6807:2809 with SMTP id 7-20020aca1107000000b003c168072809mr4615034oir.59.1708855628484;
        Sun, 25 Feb 2024 02:07:08 -0800 (PST)
Received: from localhost.localdomain ([39.144.104.176])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b006e1464e71f9sm2119775pfq.47.2024.02.25.02.07.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2024 02:07:07 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 0/2] bpf: Add a generic bits iterator
Date: Sun, 25 Feb 2024 18:06:35 +0800
Message-Id: <20240225100637.48394-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
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

In our specific use case, we leverage the cgroup iterator to traverse
percpu data, subsequently exposing it to userspace through a seq file.
Refer to example in patch #2 for the usage.

Changes:
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

 kernel/bpf/helpers.c                          | 100 +++++++++++++
 .../selftests/bpf/prog_tests/bits_iter.c      | 132 ++++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
 .../bpf/progs/test_bits_iter_success.c        | 112 +++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

-- 
2.39.1


