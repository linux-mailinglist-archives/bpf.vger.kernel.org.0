Return-Path: <bpf+bounces-61139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F9EAE1194
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 05:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FD91BC2E90
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 03:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A41C861A;
	Fri, 20 Jun 2025 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="uDUVFsLL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997823CE
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389099; cv=none; b=LFhOoJ/BYeERBpx3+exRjGQ+GiTX8qexnWunTp2/bYmfXW0X4aKyMXP546P+8sdlehPTPflweS/p62sWHIiNCs+R3MgxwICAF2GsiC36ynbFzxxete54I9tmjyc9IrXFlEe9vQh9wQyKWF67FD1+K2K1J+rflzyStb6os7xgqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389099; c=relaxed/simple;
	bh=qfoR3xg8SouGAkuAj30p44xOAE0+C9pkoYj1SVnQvIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1u5d/JnTu5JQG2sZTtmnWHDEtFnZYUUMi9nqqHYJ/uvEtL+z1qfGLhk/InSXrTx3N/r982ODiZbipY0jKFTzABcOHd67NnBRWYf4ZdUb3gG9mpEgAB/F7pd/GUYxhaxPbkXeFweB2M5oV4/1cigqm4XUGQT0pa9P9W0Iwc1w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=uDUVFsLL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a585dc5f4aso16106671cf.2
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 20:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1750389096; x=1750993896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi/hczcpZg9I5SOGYM1aAWQ/pmGexqQaBjs3hn7VO6w=;
        b=uDUVFsLLZalEAPjzAljvePl3IPePHHI1SKHKw5d79BIKumz/zlCfNnro4Et2vgKn3n
         P1/JYO8r111JRsxh+miZKVamY8zCf1R0O4vHskFKJWPXCiSssiCBUmeYg9EgajIWi/7r
         1sNcEtW60HKvEXdFfSnNV0SCHr+OhZypYgmVkoTkubBf+X1Bzp10kj+iBqJ1F1iBEvmR
         UACeYNVvhTI6toS3JB7OkytH2XqWH+r7ZKrUPrIHrnoPPlSBvESIA+SnMFSibgID3vtR
         9396vb1PzDVaJVVv3kVEc1+F34+3OkWGQHEgTFZKXWdenzI37exjSHSHjY64D+5KMsbi
         /9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750389096; x=1750993896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xi/hczcpZg9I5SOGYM1aAWQ/pmGexqQaBjs3hn7VO6w=;
        b=DFMJUm9Fu1MTZvfi9tr8q4joS+LnelFpZsRI2zBsdgx/pROHm9aNIih+FhvzSDG7uw
         cBkNNJ5GJ1kTltTEs7oyPEAyLX6kYNbrNyRGqjPGziZzQRm/Jakqn/jkHeDCZkX0XYI2
         RjZ0YAjzm8X+JyCKF8vIlzLflni+RKold59TzsehxC/l9Ga4i6j5UocgWRi4KFhfdPjm
         RBJg6Iqv2G/86q8QSVD3lHfSWyWyQKBCppeqLuE2dFMeDI/UtUKZ/Rkb7cBcEQLnXmas
         dHQvqN/LhVjQPgw+31dcpyGnPJkxDK+P+B+/YOBakj/tr17+ZqCuA2hF+x433uaimr5j
         Q9gQ==
X-Gm-Message-State: AOJu0YxiIgtSa8az+Gd2feGKRZbigUm3P6gh5iBkqmA7hIx2fSqjIgQA
	BZZnkRSifTBptas76nhzB4djiIZhuAA3QhjCmXdXosbRl6AawMOP4jtVSiCb3S5cIewifjHRI1i
	PD9gCArD6Qg==
X-Gm-Gg: ASbGncvFBVh+xO2dhbwfBnyhPVeGMoECwTNRsArO9JPmE/dE90Hw1RdtYs+YlyZboEg
	Qtm4TSrvKeLjHTntqB4/IA2uMio1bF9PmPQAKS+e996eNtbNAo4Qdn5OuIfGf1iQMNXkNXwry1f
	/09iG6F1tl6lxvaDBfaLvi8b+YzppJ0zqrvxzliLcxpXAc77Jh1g7EAxbgEWcO0D00jWlZFRHPW
	0lZTvQo1QYRD5/h8h6eegT4AAqMAb9Gc5GZ/MdoWRqEOjf667MtO8tRnb77kfYuERcVs4ecPD82
	eMIfauA4ZdohoL5kU9RNH9S3nKsmFRrooL1x9yPRwSzfuFSEPs8yh1RSVzTd
X-Google-Smtp-Source: AGHT+IFZS4LWqp0UCj33uTU5Ev97aF3KRAPrI6A/RbOF3HdHLZrPkL4oO/vcoj0bMCvrMN+xFkTMQQ==
X-Received: by 2002:a05:622a:489:b0:476:8288:9558 with SMTP id d75a77b69052e-4a77a29e41amr23830591cf.46.1750389096337;
        Thu, 19 Jun 2025 20:11:36 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e90ffasm4502441cf.70.2025.06.19.20.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:11:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 0/2] bpf/arena: Add kfunc for reserving arena guard memory regions
Date: Thu, 19 Jun 2025 23:11:16 -0400
Message-ID: <20250620031118.245601-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new kfunc for BPF arenas that reserves a region of the mapping
to prevent it from being mapped. These regions serve as guards against
out-of-bounds accesses and are useful for debugging arena-related code.

Emil Tsalapatis (2):
  bpf/arena: add bpf_arena_guard_pages kfunc
  selftests/bpf: add selftests for bpf_arena_guard_pages

 kernel/bpf/arena.c                            |  95 +++++++++++++++-
 .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
 .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  93 +++++++++++++++
 4 files changed, 294 insertions(+), 3 deletions(-)

-- 
2.49.0


