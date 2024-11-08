Return-Path: <bpf+bounces-44317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A1F9C1456
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 03:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E0D1C21FAB
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5A3D96A;
	Fri,  8 Nov 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITLsd6Vi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D61BD9D1
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034581; cv=none; b=rxTFhZPz/81gBXoEB439KmjAmnkmsQiEKsBtjcoQc0w6Q3mXe6G7x6/HTHXVvlOMyiKDLyirPJ97vsEyD9w7hOtab6IdjTJljuk5NPbS8nubqVQh2CpWgzRmBFfOluThGC7KQ/aRC2d4UebiOUzhdgscT3PwbRufa/kHrRz/OOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034581; c=relaxed/simple;
	bh=drwOiXusGZgC/Qz+RC4g7pC9LWqUceA/s4wUMfjrBPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lMvJ+8CTjqjd70ow9m2mzvpEN74VlHtsT5i1wBShr/9Ln4b1ZFNJkc+nRXBQs6FMo5yghcG0E9WzFcdjLi9jG5ABTuIsqtVgPzi7GS1OqqCNKhn7Ol2PNJE1EmIC3z0Ts1M/3hoSWl7FnDfJGBjesD1VN34TbJ9JZ13jfGx3jvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITLsd6Vi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf6eea3c0so18049535ad.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731034579; x=1731639379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcA4EMrOeW3D/gJNP+6JPAU2637YE2TWB4EQiO1CJTY=;
        b=ITLsd6Vim/QGGPYj5AZlpYGNj3Zfy5S+uFEDvVLpS5Yn4psN5yThwzh8rny9Ljh/Ar
         D400VMd7gQnZYUPLqD+ynS46Xx23dsk2hqn9n7PtEOxQkqwdFpnBvq02geMzukFYGQ1q
         /WQXty3Aanc92UjaLcyuW5DJSpLrjR+1B+0MV4va+xSEGkKkhN/1GqDXR+/ygURRF3LT
         XRE5/c6m9SRvVrVnAheW6KDQrWVK1iHauz6QwjPjdCEgeWXkBioNFYWgw7b6jn0oU/G5
         /onEg7voMEVy0VSOPgF63YfHTosn3DO/qd6rD0mcB/leIIRFL5Ni6IYyptyB2R8Mfejo
         8vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034579; x=1731639379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcA4EMrOeW3D/gJNP+6JPAU2637YE2TWB4EQiO1CJTY=;
        b=jKa/opah0yWTjEfsdliaIgqncj5AT+sbuWu5UG4eculDnOZiuoEq6fQLLQoOdvkhit
         jAxHNzhC7+SP+80NiyufY1P8g1GHd+/bORoAsnPYtIZdlZW7ubFkoEJc64O+ywyJjy/S
         YL30wO5GrrmG2nMl3x3ep8iRU1fGEj/CkV8IrYRD6SCqk/ENrn6Z+xIC9Zk0yY40qyDj
         hsmGyVsjV+PKHsvGLCsdk60OlUO5cvxpQHhqE6/qq01ulOZ4U0BDz5uRteFoTd2GT1X0
         97sWHSFsWKU9sBdgrsV234vPfi+l4Ekqmr7KVwltxi/1xNv3uQXZ2slqokxMFauUMobd
         YXrw==
X-Gm-Message-State: AOJu0YxKY3sHZDmssI4kWJjPsxGXmTkw57wO9rwNKra0FwyRTVGn7M1J
	5QVADL3vATDj746lIZtpT4aaOS2Tmve5zDA5cIgfStCZK8hQ0U1SPtJcyw==
X-Google-Smtp-Source: AGHT+IGhbPM4dQjAEEScY4xRALu21Mi/Udq3ePKHcsnxBeW9WrOMT5INxkjgSa+/A15sIvbyr1hUgw==
X-Received: by 2002:a17:902:f541:b0:211:6b21:73d9 with SMTP id d9443c01a7336-2118359c225mr14165335ad.37.1731034579035;
        Thu, 07 Nov 2024 18:56:19 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59c3asm20325745ad.194.2024.11.07.18.56.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Nov 2024 18:56:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	djwong@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 0/2] bpf: range_tree for bpf arena
Date: Thu,  7 Nov 2024 18:56:14 -0800
Message-Id: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce range_tree (internval tree plus rbtree) to track
unallocated ranges in bpf arena and replace maple_tree with it.
This is a step towards making bpf_arena|free_alloc_pages non-sleepable.
The previous approach to reuse drm_mm to replace maple_tree reached
dead end, since sizeof(struct drm_mm_node) = 168 and
sizeof(struct maple_node) = 256 while
sizeof(struct range_node) = 64 introduced in this patch.
Not only it's smaller, but the algorithm splits and merges
adjacent ranges. Ultimate performance doesn't matter.
The main objective of range_tree is to work in context
where kmalloc/kfree are not safe. It achieves that via bpf_mem_alloc.

Alexei Starovoitov (2):
  bpf: Introduce range_tree data structure and use it in bpf arena
  selftests/bpf: Add a test for arena range tree algorithm

 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arena.c                            |  34 ++-
 kernel/bpf/range_tree.c                       | 262 ++++++++++++++++++
 kernel/bpf/range_tree.h                       |  21 ++
 .../bpf/progs/verifier_arena_large.c          | 110 +++++++-
 5 files changed, 412 insertions(+), 17 deletions(-)
 create mode 100644 kernel/bpf/range_tree.c
 create mode 100644 kernel/bpf/range_tree.h

-- 
2.43.5


