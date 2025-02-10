Return-Path: <bpf+bounces-50910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33779A2E3EE
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DFD3A9E03
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 06:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BCD19D882;
	Mon, 10 Feb 2025 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9SD7OGn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE4199FBA;
	Mon, 10 Feb 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167206; cv=none; b=ZSfDJ1N5DBYVGfOozXwiOHLOtoWaochaM10bkej0IkYqmZqkH05uaKRm+r5aSavI5T06PhmDi5c4LOQuInZVSMDP2IMOqQgBLrE970aa7VjIYdFMP2M58suEZ0/etlG86dN19pad1G9zLVk8jPFnUcFr0DGF6Sf0keTOr7TL2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167206; c=relaxed/simple;
	bh=JTGPCLc+TlheKyWQPI9FBCXUAAOWLK0jpbNJkDD0Y+g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n5W4iolmUAg6mWU+3BqC0WufZ1Yl+cPYAjFABYvFyiQm5IR2QrLhoyYcnn1Mg6SCyehCYGDYTbqDODezb1PRhZR4bSHQcDa9zPWD4zAi6jwMJzCAybXrIp3Q7zVeC9qmyCRI0ZQ5eaLknsTSBJrgfEG9hYTdl325SVmobDwuR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9SD7OGn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f62cc4088so32200585ad.3;
        Sun, 09 Feb 2025 22:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739167204; x=1739772004; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXA76by7k9KEcBmeahyuiTnqNISZNAapJLV8/EFhixs=;
        b=B9SD7OGncHt7RXqf7vQKEt6cwXNddlvKB/NyLAcBiT5l4m/Fvq7DHlP9DuSAm1JGh+
         8EtIdCJmWRCI4H+i9tx8O2egw6LzQJuvZkrGCuKV+LANDABcR1AcmYFu8UuJebHtK3N4
         MDHHeb3fEE0k6n9WJQ6zwpVeNLicrqSSe4gDCfmOlx0DNyGf70C5TW8Fq2Bqwt13/JKf
         VNsbh9DBkTBoH8Sq2KcLgxwgRQNVYHkqaklY68GV0091stXXYKteo7o361YeXFat3yRl
         +oinZlaPKwtn3XuJbpLGWkls7JHkQZ2CHgapHObYZVagf+LXpYNV6yl+lufBz1Q1Dd+x
         nOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167204; x=1739772004;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXA76by7k9KEcBmeahyuiTnqNISZNAapJLV8/EFhixs=;
        b=VmroeoRnxWrwJl8EkmwclEpXpwyjSkoakLVoQk50WxomwpD9DoFzcbvMbpMgw43Oip
         6vBBmRU/YnPtYDPSoiNN7WbPiED58v0d08H2X3zZJ9H6Nmvb3axaHJf27yQfuFnYCNZt
         W6N4s/Fclw1F7C/EJVQfeMJ37CGXWg8V9T9aM/ZUtgwtdHn936qqHtYoCCBlvEEa9x8K
         mDcPeOfHywUBy9JQadqWpqIMATkWHpO+uwLF7hG5LChhozR353Tp9Z0mO7zC/amJ+1Dj
         8DY3bKmG8RazXYW+4Ak0ZECkKdgheZdQ8CfbsbCCuBxs7kAxOQGOqfETzWdMnsEl4cje
         AEpg==
X-Forwarded-Encrypted: i=1; AJvYcCWWa8rOGHxw0ie8snQkHCKYTtok4GkxEI9Y4uY7snwuCFzARc/NImErm+nX624hOJoWFQ4FYAE8FrXgIPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+1XxcQ2AyQd+cu8pcaFqtnXoEuN2acRpmC8Cc4ZIx7kkCWDA
	5qE7RFI71kBytV+Jt+XsDP8Uqi1pWR0boxdNTCAcaT1DyISPHGV4
X-Gm-Gg: ASbGnctP9OwFztPyFaDjGBkYKPYQaWy1ZH6GR69MILgXEquxmuK3vo33iIv2XBXF4CE
	gHRR8OUKGQQv7f5HMzMUL8Ya3zklamTRFLKEwNZv04XfoJ7i9G07Mn1h+Oz0k+vsC/YENGeEKXb
	NZFNd5uc1L3Sy6Sv5rEi0CrasCvQur1ecKoaXfAqlAqyIttpTOy0oWcL5C4MQJURGFX5HBLRQmk
	XU6CUzVl46DyPWh183MPwmoFw8nZq3iujNd/XcpB3hUfpi5jhj3GtMh3F5p+P7RTVWEtr4LYfqF
	Thn3mArKQlMKM+C/
X-Google-Smtp-Source: AGHT+IEQIxw5kFBpp6lSdPoJPNjjTuWEHJ2U3CC/OCa5A1s3D6jBs5T/Yl9Ytg2o8i/m2tyaffvFMw==
X-Received: by 2002:a17:902:e802:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-21f4e76391amr187472835ad.45.1739167202976;
        Sun, 09 Feb 2025 22:00:02 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e239eesm9958278a91.30.2025.02.09.22.00.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2025 22:00:02 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v5 0/4] Add prog_kfunc feature probe
Date: Mon, 10 Feb 2025 13:59:41 +0800
Message-Id: <20250210055945.27192-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

More and more kfunc functions are being added to the kernel.
Different prog types have different restrictions when using kfunc.
Therefore, prog_kfunc probe is added to check whether it is supported,
and the use of this api will be added to bpftool later.

Change list:
- v4 -> v5:
  - use fd_array on stack
  - declare the scope of use of btf_fd
- v4
  https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail.com/
  
- v3 -> v4:
  - add fd_array init for kfunc in mod btf
  - add test case for kfunc in mod btf
  - refactor common part as prog load type check for
    libbpf_probe_bpf_{helper,kfunc}
- v3
  https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail.com

- v2 -> v3:
  - rename parameter off with btf_fd
  - extract the common part for libbpf_probe_bpf_{helper,kfunc}
- v2
  https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmail.com

- v1 -> v2:
  - check unsupported prog type like probe_bpf_helper
  - add off parameter for module btf
  - check verifier info when kfunc id invalid
- v1
  https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com

Tao Chen (4):
  libbpf: Extract prog load type check from libbpf_probe_bpf_helper
  libbpf: Init fd_array when prog probe load
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        |  19 ++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_probes.c                 |  84 +++++++++++--
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 118 ++++++++++++++++++
 4 files changed, 208 insertions(+), 14 deletions(-)

-- 
2.43.0


