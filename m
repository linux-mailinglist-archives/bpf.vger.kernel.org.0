Return-Path: <bpf+bounces-71377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA2BF040C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3F81883A35
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC092F656D;
	Mon, 20 Oct 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYypevcF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7712A1CF
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953191; cv=none; b=dwpmry8uge50bumpBR6yLH9/CBCuYf3EeEKyODTC0At81jiAAgpTWSuBKGUaeUUFnHHEww2m2jnC9nNxKOdzrQGU4tr74MuTrBsa9OZp0lD/WhaFXxeRMahcJa0ptCqRu1tjdJ2hzReA2SWAfySQX4NeFxBvZi4h9UQJsd2gsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953191; c=relaxed/simple;
	bh=qt6UJ/hJlELXtuMt4ypNVj1qWpfGwv6po0f0oyxAylU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NxhIc/pyCHz2RdhPBRpRdm1orGdRMJzLCv3AIMm1k/BpCoZIxamEtIRaz2vAsJhC0IZqKhI6ALQ8zI7h9dJhupYGUlBRV1ZfNurhmGOgtVf/jK/21VDkEKvu+xjA1Wkn+aS0hatL3deRsgFrQ15HsJojcQb0j0idHxiL4qqtc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYypevcF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so3668368a91.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953189; x=1761557989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UW/RpDvxWclR/8XIrRgqzELU0axb8aZH3H3Ow60Qrc=;
        b=AYypevcF2oChY4hGa8F6CMGljtD3aUYJrV4JrDhpUbLMvvBlpm1WY/BtJ5qAcyHK2J
         YQrq0S42CmsOdGAaZfUBV17y8FMqZmeg31NMcITtcp5aPDtpG7VjDTpQ3woomFm1QfDV
         53je47bxkud+CindStHDDbx2ibP42+ycX1TEWbycrikKwig3/bhZ230WYN29b6qiA0eq
         dm324cciXTlgfPN5KvyyywK91dWjgul336M3wehVlI2+mIKvEWxTJGBrqFeo9iPrJntq
         vMpZ7Dhr9FDINarN7Yt5b7miupmhTwezR4wuqmdvjSr1RSOOkzgvz8xmO2RtzJbKw0o4
         Y6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953189; x=1761557989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UW/RpDvxWclR/8XIrRgqzELU0axb8aZH3H3Ow60Qrc=;
        b=GXbIbeqxRGs8HDxKO1DfM+ZyTQY8fNT3opmVNhFtViGzBY7bNJ3/Eoias07TLjrEHm
         r25pMiKPmMbLkqDpY9ZRN0ALj3Ncubn3Yvbw9T91J/9OMY3PiE7JMFkJkdQ6SnX+PBKe
         PTUdbKKGjNIbRUc+eiBllKzFX89xMMEkFaoQXIAIXerYT6hrpFOiZxiVC/YGUoFGi4Zy
         T6CDYi7Axuw44sKmCk9DgYRkX6ohRzdF3qXm84dIca45Nkbj5zxF3/ZB7YTeSYRMZhsc
         RaAtQRNQXrL+aB08+zTJ4h2/Mo7BPEvBhhof4ESBMasiLMcbqWWJdtdu1QN853NY4n1Z
         gMVw==
X-Forwarded-Encrypted: i=1; AJvYcCWHfSjB4HF/+Qs5OIJYg4X9gOJ3lB69ZhuT4XGuLtNSqfEP5P1lTZ9yTBP/alEgoTjDzsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqOG0fB4l5vD/9WCNh43HzIQdiaZcVNZ79BBPUH6zkpnEYi/N
	4NNRLN/Wp0D3kJyIlMrrp+R33oNvIVznUtRgWIvl1joj00HYt6dfhtMN
X-Gm-Gg: ASbGnctMjY9a81mQiGQahL1iKDFT/1p7JihatMd9nN6FeXJdSn55WFYCePFzu+uTaxp
	t52lbulEi39+IOwvzdaASyYMKYQIRi56Oq6K8L90w1NS8mpIkOco1FiFJ1sWdSAmoKLHf48wwI6
	IFSFscGe+LEZHorNDldi8vkcv6YI7RIHRqX9VDr/jW1i5bytNw1zUzF+rl75vn+MLrleqkTTo97
	bUZe7vvrfMArIua6SR7/ckiXHf//SxvXJJuBnj5zrdarQe0XeJuF2VORrleGqsSYNxwHNFm77mc
	8p4ZjYltIDW0rvMwKe+YTPDkxzuAcQDjXxFXU0sNz8Al/42o5QXLviIe9zmyfafg5fFfVNb7MhO
	5IBvjbrqCDcQIWzWLE+GTOcAKht4CLLBDIOeEGaDBZYG1S7XUFaxFtq/YnT2b3vib3mp9oXrtTC
	3VoNqeLxKusegePXw/EvHnrXU/4xM=
X-Google-Smtp-Source: AGHT+IE5jZ/moctVdc5rCAsZJU6nfmdrndVmP6VgYwoXwv6ECZgIqxtacKXwQgRjrlVozXjrhx3NOA==
X-Received: by 2002:a17:90b:28c4:b0:32e:5646:d43f with SMTP id 98e67ed59e1d1-33bcf8e96d3mr16844082a91.19.1760953188896;
        Mon, 20 Oct 2025 02:39:48 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm7617200a91.19.2025.10.20.02.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:39:47 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [RFC PATCH v2 0/5] Significantly Improve BTF Type Lookup Performance
Date: Mon, 20 Oct 2025 17:39:36 +0800
Message-Id: <20251020093941.548058-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The funcgraph-args feature currently invokes btf_find_by_name_kind()
frequently, which uses a linear search algorithm. With large BTF data
sets like vmlinux (containing over 80,000 named types), this results
in significant performance overhead.

This patch series optimizes btf_find_by_name_kind() by:
1. Sorting BTF types by kind and name to enable binary search
2. Changing the search order to check local BTF before base BTF

Performance testing shows dramatic improvement:

 # echo 1 > options/funcgraph-args
 # echo function_graph > current_tracer

Before:
 # time cat trace | wc -l
 124176
 real    0m16.154s
 user    0m0.000s
 sys     0m15.962s

After:
 # time cat trace | wc -l
 124176
 real    0m0.948s
 user    0m0.000s
 sys     0m0.973s

This represents over 20x performance improvement for BTF type lookups.


Donglin Peng (5):
  btf: search local BTF before base BTF
  btf: sort BTF types by kind and name to enable binary search
  libbpf: check if BTF is sorted to enable binary search
  selftests/bpf: add tests for BTF deduplication and sorting
  btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME

 include/linux/btf.h                          |  21 ++-
 kernel/bpf/Kconfig                           |   8 +
 kernel/bpf/Makefile                          |   1 +
 kernel/bpf/btf.c                             |  36 ++--
 kernel/bpf/btf_sort.c                        |   2 +
 scripts/Makefile.btf                         |   5 +
 tools/lib/bpf/Build                          |   2 +-
 tools/lib/bpf/btf.c                          | 169 +++++++++++++++---
 tools/lib/bpf/btf.h                          |   2 +
 tools/lib/bpf/btf_sort.c                     | 159 +++++++++++++++++
 tools/lib/bpf/libbpf_internal.h              |   6 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 171 +++++++++++++++++++
 12 files changed, 541 insertions(+), 41 deletions(-)
 create mode 100644 kernel/bpf/btf_sort.c
 create mode 100644 tools/lib/bpf/btf_sort.c

-- 
2.34.1


