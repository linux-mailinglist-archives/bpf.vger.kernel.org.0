Return-Path: <bpf+bounces-34717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4C893031E
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 03:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC42B20B48
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0212B8B;
	Sat, 13 Jul 2024 01:52:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC611CA0;
	Sat, 13 Jul 2024 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835577; cv=none; b=sQy+bIR0bMknM/i9E+0To0hi5z2zFzD7v/elms1u+7JAvO4ekKwl3gAvco7wljeKx9g4O4qCRVaMgJTlirgtyX682IflFvtBZBAO+V14vXXj4V07DsrKBhqk6pjXHW/6hus9EFMJAFneEovZUz2QkLneEQ8gPHp7CHcW4FqrL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835577; c=relaxed/simple;
	bh=x8zvCkX9+XsNR+eIvOxiEQy48Xufu07DIZRs/HQ56TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRrQsSIuyZ3BUHKAf8qx5bTNAQ2258fLLR1dZGiLcAG24QZIeXH68Mbl9FbOAG+9/1Eq/xX0R9i06UJcMulsv+yXglZmXbuBuxqp1rJJQc/6LY734ay+ZqDwqg479HZMw+O1QLYSQylXvHVpMm6Gzv6ZWM0ob0lEVpYW9uTfLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so1744817a12.1;
        Fri, 12 Jul 2024 18:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720835575; x=1721440375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8O5Zob1vQ5vi8fTJnLGcY2tDnLSI+vJnMsnMTm9PH4=;
        b=pGZ1KO12uwXPhjVfKxHQwPiLgk6q3MxcpdxTou1kqhJTm59tSpcpb+lBced4+i/DBz
         LOj/obI8AlUo+GFhe7Wb6Oi88Tva61Gr977pN3GxU2E28p6E8FQsxESqRUIIur5b/BFV
         w6c09jN/KF4PD/lw2tz8nKSJ5gLt0d+inu+uXaDLs4ve3BTBQDKCRP5CNGrd4YD3dyms
         jdoOrMNbHiSawDC1vwLV3bEavvn98wqSWDA8cbdZp0k48zw9Mu2E+LvEEOK+AJArTKo4
         FsHH2arkiAOgG2UEulBBuDLONHgqitnGYmv/UXmDgi5IxTXNOXLh045p67cScbC02A/i
         zx5A==
X-Forwarded-Encrypted: i=1; AJvYcCVvclzP5Sxxq/Igs9hOwgeSfYaEmWNYvjhBLlQuDKhI1XEysPnvuPWKq2fOyeueHWun7u71zjF+RtPA4Xa71p7cHaUOvEvV
X-Gm-Message-State: AOJu0YxW3285TuGNhrtjCmO7NL6w/xTrD9P92i98JlNcfZ0QmoPj95Hq
	xFm/tXjIQaf7EAJ06+MkSCZePqcodmQqT0lQpfmEmSUsGx4cnD1fHjXleeI=
X-Google-Smtp-Source: AGHT+IGEYLv69FcS6sLPauR2y6Xb23GLHVCOQwzMV4R7b84kKSG9mEJ5Gu4UomUvGfcIiLo1+z4Mkg==
X-Received: by 2002:a17:90a:e606:b0:2c9:649c:5e08 with SMTP id 98e67ed59e1d1-2ca35c29447mr11085527a91.15.1720835575128;
        Fri, 12 Jul 2024 18:52:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd419d11sm2208215a91.30.2024.07.12.18.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 18:52:54 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	Julian Schindel <mail@arctic-alpaca.de>,
	Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
Date: Fri, 12 Jul 2024 18:52:50 -0700
Message-ID: <20240713015253.121248-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Julian reports that commit 341ac980eab9 ("xsk: Support tx_metadata_len")
can break existing use cases which don't zero-initialize xdp_umem_reg
padding. Fix it (while still breaking a minority of new users of tx
metadata), update the docs, update the selftest and sprinkle some
BUILD_BUG_ONs to hopefully catch similar issues in the future.

Thank you Julian for the report and for helping to chase it down!

Reported-by: Julian Schindel <mail@arctic-alpaca.de>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>

Stanislav Fomichev (3):
  xsk: require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
  selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test
  xsk: Try to make xdp_umem_reg extension a bit more future-proof

 Documentation/networking/xsk-tx-metadata.rst  | 16 ++++++++-----
 include/uapi/linux/if_xdp.h                   |  4 ++++
 net/xdp/xdp_umem.c                            |  9 +++++---
 net/xdp/xsk.c                                 | 23 ++++++++++---------
 tools/include/uapi/linux/if_xdp.h             |  4 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  3 ++-
 6 files changed, 38 insertions(+), 21 deletions(-)

-- 
2.45.2


