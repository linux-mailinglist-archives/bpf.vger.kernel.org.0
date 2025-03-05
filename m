Return-Path: <bpf+bounces-53264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E2A4F359
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89AA3A1E03
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4FE74E09;
	Wed,  5 Mar 2025 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3dh9eZ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BAB10A3E
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137535; cv=none; b=iZleZIw8GyyQnLLUb76+T5JNuHr3XvpVmiDuDVl6YToJOOQ81opMmHPPcXTnhFCMZaX439DLU2oX/sx+D3pBKiSFOBE0vTRkSW97ItY5WTkcmTPmVVy+lBKx6/dQYtc3QAt+jZdOOnr23sdc9E8mM+8IW/tWmuuP2bS6kRZIQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137535; c=relaxed/simple;
	bh=+st+f/ifeNkdYeLBZELM2IoODvgcnOYDNRlo7Y3XkzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jl2f+PlJR2VIusG6Hym4JH6H6VcdGwXa0edwwClDT9tx0xDwBIQSd8um1hFtdrntwTYwWNEN6cU0tU+IjvEY4RAou9XJqKEwhfUyC79r/rw+qbsr6DnqBQEjlhXSfcOI4P/huoY+SyG3ljuGr/RKNVntocEmx0vr2BDxvn0ehWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3dh9eZ/; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so42611325e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 17:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741137531; x=1741742331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcUDlXwhvLiCmg8pcQLLcAx1DHJubWL2edWqFtaayKg=;
        b=T3dh9eZ/ruY/OU1+R4oQpCEz9/JtdE9ZRJcUoK4h1h/Mz5da/i5BUx82ZuMpVjPJGa
         lIa33Wg6VT6QdLq/411k05sO7sPGmO2PpKlz+lG8AZ1e9gk+yxSOcmwjLil19HL1mqpT
         K42GHCEWcICjIpRlFcNFVlhhKXs24UW3JEaMyNxrgAZ9m0ZdsEsuRcKIHXECS0be5kE3
         /PqWR4W+sQ0Qijv5LtZ35XFrcij064UqudVojgaHdzZLueX/r09XxXIDVcRlQTVny3og
         enEiS4Kv7Ne4P8nPVkvX3BvlD2feI5wTtMZ84Mc0n5mN9IUDPfeS0sYZa47ctwz69oMf
         uTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137531; x=1741742331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcUDlXwhvLiCmg8pcQLLcAx1DHJubWL2edWqFtaayKg=;
        b=sMp2ithRtB7XZQqKeF5zqxV2+AAxkCTLYyzJW2xTShnfgKjCVMlG8jTYachUOeAFfJ
         1I2HmvlSn2DqJ0dGukYiiwZ7Tqm1Efyd4zvFFLNP0V+U/t9y9Urn+30jy2RKu/J/PPFL
         VERG7y7iXMUWW6qi/lBdpsEpjSmQNOl5dxbcNH8EgXVpEyO3wTySng2ayk0tItLpwwca
         tGxvgqb4zKktxKu/pcJIMe7Tk5e3zUWUWxq1TwY1zdRUCIt4AoW88wzMGDxtx3XsjdhD
         3HL1NtgQ/DGk+RvGnx1rNmal+le+InI0wW3eO2NjGkR5F9XoWxtTaQBf4L+73SHSA1YT
         Msdg==
X-Gm-Message-State: AOJu0YynU5vkedta4rerkt4lUdAYzrYQF95YLcEPrYJOk+HBRNGujfkU
	DQ/HNDeHBAUQxNHPXnfHVD40AY3QLCs+MSVPyZ3Dto4HNClO7EPFCvJZW1fLcJw=
X-Gm-Gg: ASbGncsPgW36dO1krNqNrko3l7xwlnZCGhvDplRUrATc6YifvUKf29e4QBif+S9C0I0
	h5D4YPwjBTCgb0CK6QoxbbV+JrGilqgsWOeZWzpIwt1wAmprG1LFGHXOrc9k3lRyL0pre2G2GrL
	oAzlFh5vlpSREXNb/HsIYiXQs4cRY2gMTXxzs1IBaGm8O9pIsSxJqYc5ia8zIghty3nsJi/+Nf+
	QYWJ46AiTHFtTzcSgD2nOIhZIRtj83Yl3Bf2xO+7jegQEMWkA9oq3vjfthIX6pr8VzbMNk2644j
	Q6ONJLkUHTxZAJSj8gYRA4FRigdrSW/eXaE=
X-Google-Smtp-Source: AGHT+IGP2boOwku22aCq9OS6g7pBoqyt7HVSjB24p55XoBiRMgMyZNNPYRHwCX4JvZZqhAjnlbMSSA==
X-Received: by 2002:a05:600c:190a:b0:43b:cbe2:ec0c with SMTP id 5b1f17b1804b1-43bd29c9377mr5729835e9.27.1741137531202;
        Tue, 04 Mar 2025 17:18:51 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c01bsm1976895e9.2.2025.03.04.17.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:18:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/3] Arena Spin Lock
Date: Tue,  4 Mar 2025 17:18:46 -0800
Message-ID: <20250305011849.1168917-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; h=from:subject; bh=+st+f/ifeNkdYeLBZELM2IoODvgcnOYDNRlo7Y3XkzM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnx6Zy6W3UZEdOGXIpS9upsnGp91dFUFIBiA4i57KL eJZNPsSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8emcgAKCRBM4MiGSL8RyrukEA Csd+/ajcNciF/YESJ7aH+isjzAOKIiOGW7BkOQckxPhDxYyXc9h42Ze49NUOS1dsTApPAbboFuxW/O KhqB9GP3SsgzJpCviZrujyAHyz/7HTyPETIr6wbBvNE80NgLZbq+OJ/hSs4y3lcmDcc/UogN0H9+Fq ug9nPJDKGLByhD+Yc70hXIca2mBY9xGDodBS91IJCKZOhgHuYOtWxPpkNs8TB86TFe5OYg8VSjTwVw D+0Pbo7X1lWZUPVsJ+MXbdimu7AUOy3H222lIieTOEh6PQGEFoN293A6t0RKZ8FKVyxBEKuyjoMwah OTx3IzSBqWGJ/Mca3PNTpEuTX62xwGIY8Bv6ZTxlxoYYK70zv3MckyGHOqxGeosk2+GRLFrPVURCOx 1vU+qARDIqzFe+17HbXsJwhp93isssNgLHV4oVbUsF4ulUN/J2JcwPe3Rg2h5V7q/9oCj8fQ1oeX0V k7WL3ZOxqp04O3hBJy7tf+MbWV/Y5ckvtfo6aAsJwR4kwQX9WMb3e0IrnHHrDzitlUhcphjv6xz4QW MlUewKM7IsQ7eyExuz2o1/1aiW4zAGcLydeeWj8+o0O0HgpfryidQeaUHp9t7DrY4zsrPC6OdLRm3N oauCaUJF7oityEnZ8gMLkcHODM6B8LROjWg6YWa3UT0YCYXkeggJT5tLBXlw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set provides an implementation of queued spin lock for arena.
There is no support for resiliency and recovering from deadlocks yet.
We will wait for the rqspinlock patch set to land before incorporating
support.

One minor change compared to the qspinlock algorithm in the kernel is
that we don't have the trylock fallback when nesting count exceeds 4.
The maximum number of supported CPUs is 1024, but this can be increased
in the future if necessary.

The API supports returning an error, so resiliency support can be added
in the future. Callers are still expected to check for and handle any
potential errors.

Errors are returned when the spin loops time out, when the number of
CPUs is greater than 1024, or when the extreme edge case of NMI
interrupting NMI interrupting HardIRQ interrupting SoftIRQ task, all of
them simultaneously in slow path, occurs, which is unsupported.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20250118162238.2621311-1-memxor@gmail.com

 * Rename to arena_spin_lock
 * Introduce cond_break_label macro to jump to label from cond_break.
 * Drop trylock fallback when nesting count exceeds 4.
 * Fix bug in try_cmpxchg implementation.
 * Add tests with critical sections of varying lengths.
 * Add comments for _Generic trick to drop __arena tag.
 * Fix bug due to qnodes being placed on first page, leading to CPU 0's
   node being indistinguishable from NULL.

v1 -> v2
v1: https://lore.kernel.org/bpf/20250117223754.1020174-1-memxor@gmail.com

 * Fix definition of lock in selftest

Kumar Kartikeya Dwivedi (3):
  selftests/bpf: Introduce cond_break_label
  selftests/bpf: Introduce arena spin lock
  selftests/bpf: Add tests for arena spin lock

 .../selftests/bpf/bpf_arena_spin_lock.h       | 505 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 132 +++++
 .../testing/selftests/bpf/bpf_experimental.h  |  15 +-
 .../bpf/prog_tests/arena_spin_lock.c          | 102 ++++
 .../selftests/bpf/progs/arena_spin_lock.c     |  51 ++
 5 files changed, 799 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_spin_lock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c


base-commit: 42ba8a49d085e0c2ad50fb9a8ec954c9762b6e01
-- 
2.47.1


