Return-Path: <bpf+bounces-51261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFAEA329F8
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5D162012
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2607220AF8E;
	Wed, 12 Feb 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQTodWuM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D082116EE;
	Wed, 12 Feb 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374104; cv=none; b=eA45VGDNYT4fKpKW9YSpFlsc4QOTrjagKJ3oXNdE9+8XC5ZSG6KBsAM+g0BP67kX1+o4mcas+aYj4Uc7TAFQFM7XRsfofmv9OFp+YsGp89V4rJxAD2bqiV4MPJj747HEphJsqt1FcFCLCLTNkSC5B1mYnjlQIfl+1EWifa8OeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374104; c=relaxed/simple;
	bh=HTkoJFuX7aK5t0v3Lj76UIYFE2oN/rL2HfvRJ3A6xjg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oWYQ7qWnnQAmugsXrB48AUDN6FOM8/K2gWzkStyRmABZskVOOgxbfbis7uXRB9p/pqGXdCyBNMsokr1cxTbQTC7Krl5BZDXQrq9J5cD6etQC3MT1KlVLYia3MCfDhpiWbojrTiE/VnSANpSVnqlERaMZYsNdj/KGj5TK/dQktD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQTodWuM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f6a47d617so79163895ad.2;
        Wed, 12 Feb 2025 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374101; x=1739978901; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVD6ArEN3zLDtbxFG5imI2+gpY0nGDXOlMf7RRZWQHw=;
        b=aQTodWuMtjUl3K+YvFXM7UQDX6a9eEJzB3g1yUeRMfhrbJGXgtnxsVmzLd3wLkn4SK
         puMZE8yQKAu29Po50eghQU6yFo1CYqc5iD8UAJ9geI2YbKUkbycN7TQsuzfL0VDhG4AB
         QF9WO2HjkJbg+Zs9GU+DCdgtfVnMMHCJye0Rr7KWVo3/96PeTgi9siFkTWhnT03xTh3e
         eaQGuZF8Oj8LC2U2N3gG25oOZTNwewchbLuZ35i6br9VstnbRWlUKymu0IWpVsMYmL0j
         OxwCKD/46NO7CMU1BHITr8q+kkHbZD1fxoi1ykjlP0Y1qiSaT4wnTKkdpr5Siq3pibKk
         ZfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374101; x=1739978901;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVD6ArEN3zLDtbxFG5imI2+gpY0nGDXOlMf7RRZWQHw=;
        b=i0XHJVP8E8lszSlGe2As5T2ev7H4iV7ZmNMRHJfTJT8il97PlQwipUl9HJd6gtDnYK
         nRJilwflqzdylcoYVBpuvPwUX6fdiOhLQ1ubTtup8tP3ghk8OKvVJmbXxd54jm8ljvXY
         GnSvdgwVrXrpd4SSJEJ8g09xrjELLs5xFjg/AjVFBuvudEpQIOOC66h3J7f2UyX/bnGh
         5tK26y4Cot5gd7tFTgkgjwuKPeJZFa2MOvgRx9XKD0xJ+eeqfqzKgf81eJvUzP3OwtP1
         aaj9kxxUWfq7LQqis8FFAJSxXFdaVyFgZhthX3Op2ne/zWk0BmAyLtVejz7eK94d0Zwc
         4wtw==
X-Forwarded-Encrypted: i=1; AJvYcCUGDkc6rsciSqcXdRjyjZNbF8o4UTIMr0cowRCO9tKoKK60fhAgWd4jwn49OAZxrBt4iZofxoTqP9nEa6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8naQgrd0Lo7MCvAqGJ0U86H5jjkSWvsVkyU0+d9cf8dhzy+Y
	LypD9FPjVFj8f07FRNwUgUur6isQeAx1XKntlpeVR6gy17rmOIY6
X-Gm-Gg: ASbGncsuD/f/LMKGTjHNHA4BFSj6yuSHNcqW9XCVG2kNXV8fCI/L41TSvuhsOswJNJl
	OmmwCObUwOOti9MF07cReL3JdNY3Gc5aETVNX04iCLN28pptl6BjYJjlT2lnWr3jvJGDaKJKqvH
	VhaL/glwDETRVuTLGfRN3QcdJ3zC4wmSNIi8OfiME5gH6Yo4+XGS/+4NvoMpn97u0A6/H50rbr9
	1qY80V9106gxuczE40hgYuTAoktISnuypVF+urvv3sJysL2uBv67a2AfDfEDKydACFDbVogcd8l
	eYzQF4ZDCPCi6Gsj
X-Google-Smtp-Source: AGHT+IHCiWXpODMGZBjASShY5oJThhdGO0du5RmdR/duQniZc72gJ+Huh/73PVc2nL+hH6r11rRE/Q==
X-Received: by 2002:a17:902:d50e:b0:216:410d:4c67 with SMTP id d9443c01a7336-220bbc8dfa1mr67494115ad.41.1739374101255;
        Wed, 12 Feb 2025 07:28:21 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36560ee5sm114373725ad.96.2025.02.12.07.28.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:28:20 -0800 (PST)
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
Subject: [PATCH bpf-next v7 0/4] Add prog_kfunc feature probe
Date: Wed, 12 Feb 2025 23:28:12 +0800
Message-Id: <20250212152816.18836-1-chen.dylane@gmail.com>
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


