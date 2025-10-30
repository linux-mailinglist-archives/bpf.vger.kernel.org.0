Return-Path: <bpf+bounces-72965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B279C1E2CB
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 04:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BAE1734B41D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593DD2D877F;
	Thu, 30 Oct 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGKITDbR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ACE37A3D4
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793221; cv=none; b=BN8N9UxPPJ7cJ94kSxC8dIlQlpJM6o+kHUakdMpuZwesf9bzqXZvGb5O3rviLwFmqchSPPbwLsAwxVvsaKfVwh1w97i5SS03WILnbjg9l/cCrq+034+7NO0tv/yRUtlGKQvtQCNCsoMX3ZEZRC4P1hstbVg8K854JpmTRUeYacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793221; c=relaxed/simple;
	bh=K0f1o1VbpszWwR/fKC4DOMxwlCsFKCVrRuZo1Za1t8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/X/nXOgIfNzlu2RW2mfALu1n2lBrORtpOBA20okOSCY7rMGGmPYfpyY+8VeYf0BNDuqiesDymo3hN9fO+uJlWkh3h7yIKceQ46b3LjdDZSV4E/wURQpdqhY19/++ZKNktChKWNKX8saf4CiBVcbrPEeLDlGOAujIF7B8kQdDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGKITDbR; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-78125ed4052so895841b3a.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761793218; x=1762398018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvVaTZoHjzFOfTaOS9c6wuXAkDCXJtnG/9Vx8Zjx4vo=;
        b=fGKITDbR9pKJ4Q0JngUR2VfKXwjLW4FxC2IyKLMkUe6yoEdekfSsxbfgSXFoQ63Nfe
         Dp4Stx53BttSIvUGuvSWaZuqJD7XbiWGfdkf+eOjZsS8TByT3bTforlejuejc/DWNNZw
         yefvi4N8t9Gi/zc3WeItaQ4Vy9J3A0C9DQi1HM9CDINQxHf9l0ctU8Ll2fhSshmKr0lJ
         rrGzwmVjrtKjlbG8JsGfJMAO4ft2LTlocfdSOcQvEYeEjnl9HQPiW3g8kEnIl4BGviNv
         a/nqLQRbQ5g7TGFoc/zFubLAv2xmrtrfDQHJF3gN/55u24BiMWFQAvI15HZDvwlz5TzD
         kRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793218; x=1762398018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvVaTZoHjzFOfTaOS9c6wuXAkDCXJtnG/9Vx8Zjx4vo=;
        b=ZY+zSh8DrrmmjPMIb/YwYYyrdb3Dg6d2MmHUC0fHp0h55ipdx2osex2KH34RPLnBF9
         vWikIjmP6GPdXCV0iAt7MohW02YNnE4YaJGJGX7shhzimKYR/Zc3qanMViGD9OoH9OEF
         OH335fIQB7ZS/3iNIiKCSVCv5jhznjNAS2ZCEmlDMCeglIL9l04Z/N9L9JjXmecfnBwv
         h1GVlyCRbV7yiW+T2S3QWdRNilNmln1IVGhG14UQaPrJmaCU0Bi6xufoeCoWerncSqCJ
         9KT43TcWLui45xL1OwYisszUnIK8pBHQx4r0WFODDhtfBetSvU4d/32o53NRdQElkn8i
         rWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlmRolg66CaYN+CuWscVNXVSYTMXwRCmF3tAdAa8h0w+TI1kVH6090RKIV4QQ/bSK/S+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfKyyUoBOzVjNn9VHTXZL3xXUFTwtipxonHPyEbStv99WRBeO
	Mq8vv9WgXvt4Fq7uHT2Q3SUMi4mhx2k/o3ha+ThVpRAzCn5Mz7T/+LcduTslCkGL30U=
X-Gm-Gg: ASbGncsvBBgMICSCwB6oyhiRYjGZG+YrBjH3TlSr37x+tYKfrlLczOmNva9gJAYVdo7
	RHuRX7KQkqHiY7b9llFD6kO8FJiHWtx6C2LC73YGVQ04mSHzq/clsoxcYXsPN3QWWjdcT0oZ2tw
	mFI+I8hwMAtS6SeYWVzgW2I9zImLte+vYumebo3TroqwzxAX159uaovTkONBFVCt8l3T0MkLaUk
	a6u0zEZgE0bVYOoo68eo0VtNdJJ2cegEod7b3H+yqrWcZ8OikOD3hMZqgwdAdhpT9Ibwm3dDu5Z
	EwiKwan9w1VSTmgPvEEYHwIgzbuhue8y97ZKM37QNPKPPlQnXkDSJmEBly9dt2ni+Qv3CsPiw30
	Xw4ib3qQvS+FF+JNVkoLe97wo5geKHadFBNv3Sw4ZAsDUbKlWHLFouRmossL+SPadesUhoBNYlH
	Wlt3bq/7ig8Zo=
X-Google-Smtp-Source: AGHT+IHFjScuupRcBVVx/y0EmSBi/aHgLpKdYf+L8LdTc0k0O/fP4xz2JXMfSv3sb6YF0O7c0uIYZw==
X-Received: by 2002:a05:6a21:3288:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-34786f61014mr2257534637.46.1761793218462;
        Wed, 29 Oct 2025 20:00:18 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm16663311b3a.12.2025.10.29.20.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:00:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: martin.lau@linux.dev,
	leon.hwang@linux.dev
Cc: ast@kernel.org,
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
	shuah@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] use rqspinlock for bpf lru map
Date: Thu, 30 Oct 2025 11:00:08 +0800
Message-ID: <20251030030010.95352-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the raw_spinlock to rqspinlock to fix the possible deadlock in
[1] for bpf lru map. Meanwhile, add the testcase for the deadlock.

Link: https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com/[1]
Menglong Dong (2):
  bpf: use rqspinlock for lru map
  selftests/bpf: test map deadlock caused by NMI

 kernel/bpf/bpf_lru_list.c                     |  47 +++---
 kernel/bpf/bpf_lru_list.h                     |   5 +-
 .../selftests/bpf/prog_tests/map_deadlock.c   | 134 ++++++++++++++++++
 .../selftests/bpf/progs/map_deadlock.c        |  52 +++++++
 4 files changed, 217 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_deadlock.c

-- 
2.51.2


