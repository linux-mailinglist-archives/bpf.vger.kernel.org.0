Return-Path: <bpf+bounces-72325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC09C0E37D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003EF3BAB81
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94B306B30;
	Mon, 27 Oct 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKtQ3kaU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D64277035
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573275; cv=none; b=qNx6BSVKNO5MG4f4bKU+UvvdnXB2/k208HLnw2Eo9tqYzfvcK8P9pAzqm+CiJq1+vWPbHtDxQPayjGpBBlzqXuf33POYja4VPRXhqGZT+HOaJ63kVlItRTb8KCE2/zDqnqa/aQFjGy6gDtSMh1adO8HPhWjIRfNi1XNMQMovm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573275; c=relaxed/simple;
	bh=9dUg+cyLNhN9BTpI9ArrVpEOGS9W0/szZDF7RkM1sjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJ56acF7iM+9rpEcW66n8uflnzlBEg8Va9enmz0Ikf2cr4kK8WXICR0Czmkh8dz58glbuNc4zDWqHha13E1Bq05lsDbM5vwmpzZ6mXm0sCQHjlj7rsIX6yUNZr/2UqJ7Rxa9JFaYlxdFTMekFoyBIsmGESIv5KtJoIwnDkG3zWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKtQ3kaU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33bbeec2ed7so4299767a91.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761573272; x=1762178072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f03KuUA7432J8JNmY+1PvZsiGlTGWgolhZe60JrC/gE=;
        b=aKtQ3kaUk9fW0EYHv0bj9LF0RiY5hcmmPgblTHNURQdggI+Avon3vSUddywTwUb6ZH
         sDW4JCm1MNZ9x6QbuKKh+4J0qKSDk6Ara9bq2Tmhlq3P8xyU6zNx5Pkla/n53VmHPE+a
         grAkvVwFCt85F+f8jcLi9GRnx3OfFzpllgQgkZrvsQf0CV8X+eOiRJR2ZUh/6uyAc3Am
         Q6HcoU0WEg4eIggPxUUKTHSt5BSGgDkc+I4jqM7DOOjz5juwTkiWSls0xstBc7zLFZBi
         XrIxJgkIY8oFLR763qCMzOgWS+gdYLaNmT2S04KzCuqs/lNXeTraeaV/843tenxga1YN
         YzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573272; x=1762178072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f03KuUA7432J8JNmY+1PvZsiGlTGWgolhZe60JrC/gE=;
        b=EPaojg3Dulh43s8bQiB7++O1n9AHnM6uzMurEiuUCOUNjijfhXkQUtSbbnqUdJ61Pn
         pgZEFnbCbGX7Mj0N7nl2p+lD48uFMlICBo9HXySg2FkRLgtN9+0VKeIAQlNAZpl2dC9e
         Cb/iPFaRlv3adA+EUxnVsWKBdRq24gFoz/AXstmi8XCzzhbbWIZB/TBSAPOyu++e5N+3
         Zs7mCp1H5oDBWezaWgb7TeHUMv8yGRFdoXzEuznEOhORzzic6UifTlIay378LPi8pMTv
         EL3q03+1SmE5TEqo9o4hTUD3QR/kAYoTjt5OC9an1kcTyRzXZL3XkStqIgm7el4dLaJP
         xHGw==
X-Forwarded-Encrypted: i=1; AJvYcCUzq/cBEILLt0x/4otc24N3Crj5P7CFnoBWygqZ4SG46K9MD/CRBFA4twDvfOcnMJ6FMiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/d2UnrPRQ42io1PtnSlfQIz/WL6vVg97eA5KuVBQXcpCwN6t3
	cXbIMAPDhrGf9ep4TyNBH3T9SG8ArIF4lJUrFsR2VUkDw+4ewVSpZVoZ
X-Gm-Gg: ASbGnctNWzfpFzbHvGboSi1/RYQVsinQXfOOdJWvCt/GTZmM0FdIgn9YjPLT7q0Azdz
	q1CSA619IIF4phpwV/W/mXfkesLTK6S0ODeP+gz+wQPnEkDVW+AfAAUUS9mHk1UbX/rwuLzIwJ/
	KF7s5ZgIyqkOD4oDGde0icTp5/GaFxYe9CIFhAeI35y2sCwjs0vjIv2BCFvgR6OEfo8mZ7u0wWA
	jL/OXqAeQU1PPni++WUoSWyiGsGAoNib9ml6YGWllEM3XLmRhYtYFDVnY4y7iZ87vmn5pHtuYnO
	jpfeP90N0cEascJiOUK7lqCjMb8/sqO6yURUf0Z9f+X8K3t+VIJSJvZEQEUqGke0ogI05zG1zUn
	RlghnPo96OjuQRkJ+vsWui4ds8OWkr60loJNn5dJQTKGIckZmU1ZahcyXyO+j2/nbbjhsUanwWK
	qw7pU7HUed7KsqAVf8bQnAqru/byo=
X-Google-Smtp-Source: AGHT+IFtvYxCbikSbaZMg1KaUpeSrllaNNeLVSqVHrOb6NH79D4XLDrzdDXs/kaauXcKnz3sC473Qw==
X-Received: by 2002:a17:90b:4c02:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-33fafc1ce07mr19191783a91.23.1761573272413;
        Mon, 27 Oct 2025 06:54:32 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm8574361a91.4.2025.10.27.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:54:31 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [RFC PATCH v3 0/3] Significantly Improve BTF Type Lookup Performance
Date: Mon, 27 Oct 2025 21:54:20 +0800
Message-Id: <20251027135423.3098490-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The funcgraph-args feature frequently calls btf_find_by_name_kind(), which
currently uses a linear search algorithm. With large BTF datasets like vmlinux
 (containing over 80,000 named types), this causes significant performance overhead.

This patch series introduces a new libbpf interface btf__permute(), which allows
tools like pahole to sort BTF types by kind and name. After generating a sorted
type ID array, these tools can invoke the new interface to perform in-place BTF
sorting. During BTF parsing, btf_check_sorted() verifies whether the types are
sorted.

Performance testing shows dramatic improvement after sorting by kind and name, as
demonstrated below:

# echo 1 > options/funcgraph-args
# echo function_graph > current_tracer

Before:
# time cat trace | wc -l
58098

real    0m7.514s
user    0m0.010s
sys     0m7.374s

After:
# time cat trace | wc -l
58837

real    0m0.371s
user    0m0.000s
sys     0m0.383s

This represents about 20x performance improvement for BTF type lookups.

v2:
https://lore.kernel.org/all/20251020093941.548058-1-dolinux.peng@gmail.com/

v2 -> v3:
- Remove sorting logic from libbpf and provide a generic btf__permute() interface
- Remove the search direction patch since sorted lookup provides sufficient performance
  and changing search order could cause conflicts between BTF and base BTF
- Include btf_sort.c directly in btf.c to reduce function call overhead

Donglin Peng (3):
  btf: implement BTF type sorting for accelerated lookups
  selftests/bpf: add tests for BTF type permutation
  btf: Reuse libbpf code for BTF type sorting verification and binary
    search

 kernel/bpf/btf.c                             |  34 +--
 tools/lib/bpf/btf.c                          | 262 +++++++++++++++++--
 tools/lib/bpf/btf.h                          |  17 ++
 tools/lib/bpf/btf_sort.c                     | 174 ++++++++++++
 tools/lib/bpf/btf_sort.h                     |  11 +
 tools/lib/bpf/libbpf.map                     |   6 +
 tools/lib/bpf/libbpf_version.h               |   2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c | 109 ++++++--
 8 files changed, 559 insertions(+), 56 deletions(-)
 create mode 100644 tools/lib/bpf/btf_sort.c
 create mode 100644 tools/lib/bpf/btf_sort.h

-- 
2.34.1


