Return-Path: <bpf+bounces-68273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DEEB55923
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70DD5A3227
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E50286897;
	Fri, 12 Sep 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj2GwCDE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D4257820
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715943; cv=none; b=tvH5sNOIPwqlL/ZgWeW/N+AbN77KaR+SzsPaCXqtXPsJrvxHE9ltLTZX7d986Udpu6XgEkU7/hsMoKZ1OEo/K84dbleXnUw0KtKnirUbWB6+AbqxX7WVDMFj9QKC3xHFBMN66GnQKSaZ/NRthFs0KoateHLWknWi/bjKO1aPLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715943; c=relaxed/simple;
	bh=kK67gOsMKdnTk8XfJvCFmZ1AgZVmladu8chilWBm6No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ug2n+h6p4IVJuWRS4O0c5M8hLHKI6mhUTiSIg5shxXFVh5GynQmvuTJjqXrAWxebqC1j//iL1+UF5UcOp4FMv+X2BptdDho59R4l+dT8lZxUN1Poc7gQCL2pCc4HmSI5ZtuNIKo78lurcfZnIQfcCgguPLNR4KDACwHZMDrEq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj2GwCDE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8250869d5d8so124908585a.2
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715941; x=1758320741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzZnnPEt3bRj9xxliys6aMLfk6CSAaQd8ndI256Y7tQ=;
        b=Fj2GwCDEF42NjL5js8RIKxSdYKFiwRb5qkfg6dTzNVdpHb1HkMIPrurM/TXlmoIKMO
         /Oj5r3RUe0Ute1cDJPaWSsNGEuEfwEusmmYfuogCbILQeeMPGEW1zV4M9rQS1R43MNjf
         Y+CouY+I3Ypeg8fzOFzGEmuvj4Z+6yjWr/024m/kqueLMYR90yp/gtx6afy7zgLZpPAo
         iHUVEaG+m2OR4TBndXtGSrv5M55BzIUxEZEZFugth11wkY+bIz/fcWKwuxjGbW9g65Ac
         K45FNKjYs4kPn7fNcMrLoT/GMRDT2HOBrywdW6+qzKeBrHBPHAHA2qkpLRHdhy82PnnT
         cbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715941; x=1758320741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzZnnPEt3bRj9xxliys6aMLfk6CSAaQd8ndI256Y7tQ=;
        b=rWUcICJypEYRzZyN44pyIU9xkuMrL4jvITZk/YTnOdobqcYz6/0nh74vqy3gizOKbi
         0j09XFwkwxO+0YyabgNndlCwKljcuGHy4VxzthvN78G9PnaWe2nzYfyFvL2SGZYuaC2Q
         xNdh5ZsT8T2OEd1rwxo1A0hbHhOLpUmwgTXPuzw28J5ZDh2+fwLXDM9xTiraTSjHj+iP
         QtPYwV6FYFJTsvb4in7fZW9AOds13MT5Y0zAWM8JZSDAebJo8olM9Z9Ip7MpfiQn6maz
         ui+bJ4MDwF+FVnQs77y4najHGFO1udbdlmsA75wlA2JunsVx8teUsuwGPwidwt8PsNy9
         rSTg==
X-Gm-Message-State: AOJu0YyR+FfF47IitcKboNtt4IrLUbPzDVl5Dkj5NVtyghVeNUUmSh7m
	isiRXtC4vfIFuMhP2FhxXS4JKY9BDe0P/tNK3RkZ2JhgkAlK4oYJWtIGg/3GeRxXS1oJlw==
X-Gm-Gg: ASbGnctul9pgI5vOySCon+zbkI9x7uvnSgJa1pQ0Pl+HjP82fuuwRBZVlnLFO9IuzL5
	VgRHHycEVYX1UMVNbAfu+EGhXhx5Yx+L1WJl5I1HyEelYWnzGm5+dl/he4+hDwFKl0FQ9pxoCgc
	/1I0DYp2CivEqY6Wtr7RqnfCR/rytUY1vifR4MFBH5BukVGN74IEWqpCYYgXXDyQeNuHm+2OS6/
	S10gEVoW3hpxKWsbalbIeu3zU/n+3NEwQZSuZHxH2wBTi15LcT9a6vlImz2eKo1LlZnh2zbX2ls
	BXetrXW3PrP/wkyUvNUJiDzwXF8RqOY3jJ2C/2V1c3XR0nmjRwh5aQaqGumLpvxebiggb2oorD7
	atqbn55jCcpri3EXzpenbMPRnoMddFKdxD3On8i0km3U01i/ty1cKwAlAQvq42EtQ2TZEE5xVOd
	8o9vGbHsE9l3OJXKn3hyrOd/4L8Gf41QbDPstZCR3mNPqQjrcE
X-Google-Smtp-Source: AGHT+IHDnmgT2LntxCPaqHLYhzHzjBtnWhONEJnC/8/CEs6lbcLFbVpRT6CWOfWsSwot3fYuSD9/uw==
X-Received: by 2002:a05:620a:3185:b0:826:c5c8:7cca with SMTP id af79cd13be357-826c5c87ccfmr82561185a.24.1757715941058;
        Fri, 12 Sep 2025 15:25:41 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974d635sm339136985a.25.2025.09.12.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:25:40 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	dwindsor@gmail.com
Subject: [PATCH v2 0/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE support
Date: Fri, 12 Sep 2025 18:25:37 -0400
Message-ID: <20250912222539.149952-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds BPF_MAP_TYPE_CRED_STORAGE, enabling BPF programs to
associate data with credential structures (struct cred).

Like other local storage types (task, inode, sk), this provides automatic
lifecycle management and is useful for LSM programs tracking credential
state across LSM calls. Lifetime management is necessary for detecting
credential leaks and enforcing time-based security policies.

The implementation uses kfuncs (bpf_cred_storage_get/delete) that return
bpf_local_storage_data pointers, with map values accessible via the data
field.

v2:
- fix kernel ci build error

David Windsor (2):
  bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
  selftests/bpf: Add cred local storage tests

 include/linux/bpf_lsm.h                       |  35 ++++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_cred_storage.c                 | 175 ++++++++++++++++++
 kernel/bpf/syscall.c                          |  10 +-
 kernel/cred.c                                 |   7 +
 security/bpf/hooks.c                          |   1 +
 .../selftests/bpf/prog_tests/cred_storage.c   |  52 ++++++
 .../selftests/bpf/progs/cred_storage.c        |  87 +++++++++
 10 files changed, 367 insertions(+), 3 deletions(-)
 create mode 100644 kernel/bpf/bpf_cred_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cred_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/cred_storage.c

-- 
2.43.0


