Return-Path: <bpf+bounces-76252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FACABFB7
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 04:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BAF301B80F
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 03:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5BD217705;
	Mon,  8 Dec 2025 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zbzmm5Ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB448C1F
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165810; cv=none; b=DU1SPGOvDnCw6rV8SLR732HZTnR4Z0Pe4Qr88AzK2eKpAXaZNuQQAuj7aoOMXzVDqkHwXYYTzYwzXlYthCRAUTzca5HeER/NXW5FfA73V/nDt/5oBMnRyLZuHfK0sHJ28lY60poBXQ9+E75f17+h/q+7L4wJdk1OD1cVKCk3wQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165810; c=relaxed/simple;
	bh=SSWz+g+cQ9XE3nvjrnP1BXVz5X1yrwhIz5tDXPr2F50=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=KWnkMiD1fhxHTzLI9EMmydQs7IV/XsfvFYvfvqZQntgBZIbjH7CHg2vmrDxEBWoFjfcB+tpm8YwUE6A/cg6ZWbRP/s2DWPoaGcjh3osEBp6rIlamXlXn7LamPgKjh4e1FzOKIalhlWmGpDY01h+uQc/vsh1zd+VYqqFS2QyKemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zbzmm5Ko; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-295548467c7so52730445ad.2
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 19:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765165807; x=1765770607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mty2zn4dwIlfoS/rTSTz6mOhmsuS4SWDSU08vOSH3ts=;
        b=Zbzmm5KoN9HiCldkXiMi5aQ51/q8K2CsGPFDu1SAAHNPcl52WCaDWNeIugHSy8gsrb
         4S6zGVx1vuCzHUiOGxEvE0/phkFfr/eFVRQCVQ1qLZEQG2DW3fSBplg+8v0fMYeLBmEA
         bqww5NcAeHBAD4+92aOstiK2QmajkVWCkMWOcO3qRfDvYD8e2T70lIogxmSzKic36MqV
         gFJ4Wl0IPY7rmTl47pS8UJKNg10nXlgu3v+K5ujA8k4zJXqofPOkzewUxi6+H2uIculu
         KlNOPRkpYGfc4VyVTrosnek8tXnrn44muzwJO1zfp6uJ6aqG+iceo8op8TWLPiCdTjoQ
         SwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165807; x=1765770607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mty2zn4dwIlfoS/rTSTz6mOhmsuS4SWDSU08vOSH3ts=;
        b=vpjkWbIB4csoD3ePwoeq7XnUut3xyqujVeUiEGQ01Jl3vg50jcOZxnxarozBP45GB6
         oeCzadcCTFDJIkD8hEfvEgh4RULtmvgxy84ACmuMmXr3NYggProf/WYJmkSfOef3/Brd
         tcth3jzl4YuWMlXIbcrmE6Zlpq+Gmvg0cp+8wEIecDL5yQ1Ug/Wg0kXCWWi6ayKSP0vZ
         /eEBh8ibpi3T0sMlaQOwmFIsuzeAqEEl3rhLhKjyxhpRMzBam626GwwYksbxoaeAPX7/
         j6CzV8uJIrN2tSJDeXeFloWxOcWUTRiUZ6gc+bNBhZrahEmKqGxvOlkboG67k0yZBa82
         EW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtdatpnLBn/keC6DL83oHHy6EoOJVWlunQnu3eUm+soI6dxk6L7DYZ/PoUsrLTdFwDWb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Kuk2jid/om0GHVsLUv9+iEGlteTVlvKOY7KjBfUBGHL6YPgk
	Aq1u/k9kRHHTj7kmjApfDYuUcRxC55OzSugSrH+xv2sEGwCmlJaI8QLCqyZaMtlhOpg=
X-Gm-Gg: ASbGncsfUtQkksFu34nlrYVanSAKXMHO8yvqtlvGPWLRfnJfDA5UGuL8GeabJ3p2LWz
	eTwgs3tITtv0IBiZJgBpbtJl97HrQoUF/4RjKAogVkpZs35EBvu8nBIHLB0/fl7YbWKweGPO//C
	E4+5W5RPOE63xmsRB7PMPuCBy9FfjCZrtHWSKJA6OXpyPKUg87KpXQnY0fMyHaNKKrrV2RsU0Ah
	Zu9A5JGYjtatlKyAhWRrmbLD/VLnwpajnZUGcl/jrOjklxgjDcge7lX3HMHlHN+YL0eFUZ1MYT1
	GcF+DAq/1+VuPM8Z732Vld/O/m1287TROExX2GDyR9CDCqiy8nKdkuJGjK0ZxDmvhEGeBZhqGKE
	BLeL/GK3XHAeeUnrHW1NydX+M8KJCAbvRco3Hm/vWX1OvK6AEy39ixUa6ANv8B9BlNftaTbKh2Q
	vcAGHJRQifenctrwffMKeH4OOpd82g67CrHFNhVIlZR2rs
X-Google-Smtp-Source: AGHT+IFUgzn7oN/GX+yC51QRUlb1+YHbrj6+uDfWoUdYP/BClYG3/VlS/j6Bvy5yLNw6/cq82JDAwg==
X-Received: by 2002:a17:903:1a30:b0:295:20b8:e104 with SMTP id d9443c01a7336-29df5ddd373mr63685045ad.58.1765165807515;
        Sun, 07 Dec 2025 19:50:07 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6d96sm108871275ad.102.2025.12.07.19.49.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 19:50:07 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andii@kernel.org,
	andybnac@gmail.com,
	apatel@ventanamicro.com,
	ast@kernel.org,
	ben.dooks@codethink.co.uk,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	charlie@rivosinc.com,
	cl@gentwo.org,
	conor.dooley@microchip.com,
	cuiyunhui@bytedance.com,
	cyrilbur@tenstorrent.com,
	daniel@iogearbox.net,
	debug@rivosinc.com,
	dennis@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	martin.lau@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	puranjay@kernel.org,
	pulehui@huawei.com,
	ruanjinjie@huawei.com,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	sdf@fomichev.me,
	song@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	thuth@redhat.com,
	yonghong.song@linux.dev,
	yury.norov@gmail.com,
	zong.li@sifive.com
Subject: [PATCH v2 0/3] RISC-V: add percpu.h to include/asm
Date: Mon,  8 Dec 2025 11:49:41 +0800
Message-Id: <20251208034944.73113-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
1. Support percpu add/and/or operations for non-ZABHA
2. Implement optimization: store percpu offset in thread_info

Yunhui Cui (3):
  riscv: remove irqflags.h inclusion in asm/bitops.h
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/bitops.h      |   1 -
 arch/riscv/include/asm/percpu.h      | 242 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   5 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   7 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 263 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5


