Return-Path: <bpf+bounces-51266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C314A32A3B
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE2E3A1AE7
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4C212B2F;
	Wed, 12 Feb 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtIgqqrh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710321129F;
	Wed, 12 Feb 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374759; cv=none; b=pHyGsRyJCaL+xOrcZqmTn9xLVdHpEck2rTodDdjDDTbNe4jsGJOfGdztD96IQZuqSZv+hOrIPY8IMj0xw+DEG0bMKe7/U1MVs/3Vy90oOnZssLcLWyMRVMaBlKMc/OJJZMslabXnaRC7yWguQj5gC8PPgBqgquBJuImfK1+IcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374759; c=relaxed/simple;
	bh=HTkoJFuX7aK5t0v3Lj76UIYFE2oN/rL2HfvRJ3A6xjg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sBZ+qTQA4EmmxO4N7sotktooauKbbU5Sjre3A+0gyfFUuNHpCGXvK0CMTyxOyYcnVb/Bhh/hlKNIT2UkJamywvX516Rt2etHNlqfetSjInZbwYVCzsQm6S6sE2VZj2cC11Tsy3Q86cRzyMmNe7xqLR8ujAocjPtTdZ11uWeedHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtIgqqrh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f818a980cso67319985ad.3;
        Wed, 12 Feb 2025 07:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374756; x=1739979556; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVD6ArEN3zLDtbxFG5imI2+gpY0nGDXOlMf7RRZWQHw=;
        b=KtIgqqrhlxYiI8phKxfL5llbtMahxpvMuSw8tsS3ux5f3b7IBIraoW6IBnkRBBm8qy
         SBOqyEeB/jCPgfeMNzbre1sQXGky+ABNSocprnUmeWbRXlam+bn/YRI+tyrkg3E/WCOO
         d+6yqWC3E0Mpxn5SbiEfbTFuLPHq0NgPORPrRjd4fMCKjeiNUhOj0G2Q+LSGszBTi39+
         kODyqwwI0dHR3USSZp8J2kjgChrDBQ9djaht6Eteyc/3MUSKKXfv12p/fZgngJfpbZIK
         t1orGVpxYQeqkY0frXQO+93zbih3dx/g1NeNb/opyLtbf+vt9ThqUgio9sZBikM2Y1sN
         Yb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374756; x=1739979556;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVD6ArEN3zLDtbxFG5imI2+gpY0nGDXOlMf7RRZWQHw=;
        b=mPb/C7q03fgNZoyYlXTo+Fl+NrB8OBnG+gUjMpZc2GmJ6+ib3XmTzo/1Z5qHGYx1vr
         C7OtvDdckqtYM/Ali2zj4AV4gOxb1nCIx+frx+DfkcOMihSbqv5jJXicF21gdpsKaI+d
         mOzf5zUtxpfI1z27r+kpBcD2NP9vCLytTr4Y4GOKHbkNDczJuZYyDXLZ1dXmEDB1Xnkx
         Fvy85jQuvllv+5HgiswNl+WtXF/s373reYKSAia09X6w76OhxRNOu63aPYvCtl3e34Zf
         B70ad4mqWMCaftiBVLYz4TH50Ac78uCAHFqflBPTd0WUJczOHaWH9bFamCMshgwpDCo4
         czEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXehNnlXwPNq2R8c78DbAq5GkOFL0QZRUUUMBCvZdTGUP1/e73/XRqg3HfndyeCK/ujBdyzE9ppFzkMLgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAH5qsPJP3l1dw7cD1Dtv8T9mJU+bB8rlLGNUL5EbdP25KRSD
	YUoR7lyWy5l2NC9aKAG8gGZMus3R9u0G/THn+e4hrqVF3c3e2fVX
X-Gm-Gg: ASbGnctoOLbjJmHsLOwsBhXQocXOEN7C/iG5hqdCdBeqjiKiRnAkcbvB181qYKp6X2c
	6mJAHlHOBLXF1FPf0jk6vgDH+9i8FujrmDqm/9M6UkttkNr1e/vcrAeLyZHJ/yf81rZIGjebSqO
	5Me7dc0C+txgNLbj9TP4h6GNS2Hf6LgSwJoscqADk4A3ftl+UeHpUznSMf2XmI7NQM60+pl9hTS
	QdOjV9xtwO6p5+ADq1rko307S86CAU6md6Ou9v/650YHnXaz2vtFf01wm2TNB/FzZeONttXRt+R
	nUPO3ckE6CrkcKyR
X-Google-Smtp-Source: AGHT+IGTYrAs7sLtP6yNr+sz7hQs0yToT0vpXYmRc/AHmvUoCkbt/echvgi1CchyUDig8nCtreX7Fw==
X-Received: by 2002:a05:6a00:6c8f:b0:730:8c9d:5843 with SMTP id d2e1a72fcca58-7322c383fcemr5182743b3a.9.1739374755595;
        Wed, 12 Feb 2025 07:39:15 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7304c780da5sm11433429b3a.69.2025.02.12.07.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:39:15 -0800 (PST)
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
Subject: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
Date: Wed, 12 Feb 2025 23:39:08 +0800
Message-Id: <20250212153912.24116-1-chen.dylane@gmail.com>
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
- v6 -> v7:
  - wrap err with libbpf_err
  - comments fix
  - handle btf_fd < 0 as vmlinux
  - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
- v6
  https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmail.com

- v5 -> v6:
  - remove fd_array_cnt
  - test case clean code
- v5
  https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail.com

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
 tools/lib/bpf/libbpf_probes.c                 |  86 +++++++++++---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
 4 files changed, 201 insertions(+), 16 deletions(-)

-- 
2.43.0


