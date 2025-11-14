Return-Path: <bpf+bounces-74554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3EC5F31C
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A57D35BA68
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48889348867;
	Fri, 14 Nov 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIZ2hNVy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340152F12A2
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151212; cv=none; b=BNTkCeE7ecvW+CcHtV28mQ8rwJyDMWZXEr/KQV4h4PzBDPBpsLQRl4t0O6Dlc+JaflGD5sIY4h6ob1gJLofWiOEdVmGC0M6Co1ux1XJV9AdF7neoMKpqBP84CYCNw0m1HoNzvgspAJ5Zi4tFcj7XnKvhS4E1/Yh4j0LPCBQt+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151212; c=relaxed/simple;
	bh=gfsEfam1TnFDHwHfKeJ/eALWiVqPybvUIuBzruEQW+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwK0S9ykgNW7xelz3wN+CXcnTKQVURppVaqPP6cCaSZ1LBkUMQB3vNZt50nk539EIRbKFEoTLqcNEOixiE7iv4FNRHvzh1echki7xFsJej2HFofcebW5yDMJT+AIxcbNYPSoXdsVhpsSq2G0Yo6jPV1TySkh53Mu3pxBsMzzB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIZ2hNVy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1346242b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151210; x=1763756010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uf3BUSzSZCJoavzKn2m+Jz/HGUOS/A8evMUw5+t52po=;
        b=iIZ2hNVyg2oJCn/9hzCj5MwhOjKE6SckaxoxOpzSDKRNjPjxsO9/d41qauIsVODR7h
         V3cXtal55vsxmsVXMWmy15D9xDu/WHcYVkRrjaqJxDSO3d/1ji20OPmHgt/zAphQ97ME
         OVyez6xaLu4lt4+iXlPQXwzDudTTQZ2VlcHJm3s5T0z1C1OfbtSt2mHIJSJ0Pbv0ZLnE
         dbjtgvDyMY/P5SEYiAkR0jTeNGiKujwAskF+yRlBLCTP9CuAc2KiBX5dzNYRLn2hkLkd
         b1/DGO6T+91ipSUwnHjeRQZBRJ5iZ260wgVWgLY7wxyIYprUXQbz0MtJFpWi7naeB8AR
         1Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151210; x=1763756010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf3BUSzSZCJoavzKn2m+Jz/HGUOS/A8evMUw5+t52po=;
        b=q6sSc0xQQYaPjCKiL8O1QmmNb52hEIOAqBnhYLwprqOz0MGQX5VP4OfopE4ZI5kej6
         WUNepaf1azOcO6ER4xCYhtJQ7CIJp1WLDKmQ+2i0CY3CgPdZ0RtCuv+X2ZAkuieTzznH
         jEq98rrpuSvqaWFxpd+ydZ8NU9MvlVOfKeNulU44VGnbDGUzvC+kcz7SDVJfaLZrvhmq
         LAPapMWWbFkNFtrBB1w7jDrjrGJObF1gBGreAeC1iTIJRkMWR7JE1Gc9sVU6yy4/Zxx6
         dFU4Fxgrz8pYSTsB7/OD9ZchAJ9wWonxSDwwwUb/Ih2wwyAC5U9QZzuoqbxI5bZq1t5V
         1AqQ==
X-Gm-Message-State: AOJu0YwgsXiWOBp2TiY90FM7a66cvy3IW3PXGl0MMmO2Zm4SGATxagWk
	xjzbquiRobrBGJyBkfOEjdAvm3Fglc1S3vnBEDyXdCrHoDtGfAdMa6fxU4xkuQ==
X-Gm-Gg: ASbGncso+Ov19ufIZRdTrDk6KNMUhzq5K+ZuZuH8Qvu3IkyPeJACGe6SF1o+QRuLGN0
	6ib8zPhkwa2eCnoCNTfG/o0MFxSgmBh/yMrrVkXVg9Rg6zQqdNtk/4g9oho149BegY2kz9w5VTZ
	wDcPw1s5qxdlRIzQGn3KtFWcmfI35GhT3QUDy1HHkWZ9r6yUXazz0vOX5ItfaKQI/1IPxN1ej39
	9rmr3LumyEwehxOoccRg526auCqzWFSywY/7NDBDOY3fZXhRwi/JmKvCXYSTOMk9/mZMiypZcjF
	PpftOYBHSmY0hQhqHHXn7oTuUIolqdFLnWQ/fHECSm0RtMrdaaxdsSyNrdDgU91PJ60BNol7xQ2
	y7UC2OYnGLq0IY4+yxPOdRh4ZecGaqVFGO//vWeSeUZEdOoMUp4BtLeKaQqb55cez+E2qWxAYzI
	qZzpVAf9Aas3Bnvw==
X-Google-Smtp-Source: AGHT+IGL6d/Bnb4w2lmsKjgdb6AVcFSnWvfPhyiBt4Hqj7GOAjqk2+JskkwiYum6+UOIV5MTWdmo7g==
X-Received: by 2002:a05:6a20:431e:b0:2cd:fbcf:147f with SMTP id adf61e73a8af0-35a516a9b22mr11012015637.14.1763151210372;
        Fri, 14 Nov 2025 12:13:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:14::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375081023sm5559248a12.21.2025.11.14.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:13:29 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/4] Replace BPF memory allocator with kmalloc_nolock() in local storage
Date: Fri, 14 Nov 2025 12:13:22 -0800
Message-ID: <20251114201329.3275875-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patchset tries to simplify bpf_local_storage.c by adopting
kmalloc_nolock(). This removes memory preallocation and reduces the
dependency of smap in bpf_selem_free() and bpf_local_storage_free().
The later will simplify a future refactor that replaces
local_storage->lock and b->lock [1].

RFC v1 tried to switch to kmalloc_nolock() unconditionally. However,
as there is substantial performance loss in socket local storage due to
1) defer_free() in kfree_nolock() and 2) no kfree_rcu() batching,
replacing kzalloc() is postponed until necessary improvements in mm
land.

Benchmark

./bench -p 1 local-storage-create --storage-type <socket,task> \
  --batch-size <16,32,64>

The benchmark is a microbenchmark stress-testing how fast local storage
can be created. For task local storage, switching from BPF memory
allocator to kmalloc_nolock() yields a small amount of improvement. For
socket local storage, it remains roughly the same as nothing has changed.

Socket local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
kzalloc           16    144.149 ± 0.642k/s  3.10 kmallocs/create
(before)          32    144.379 ± 1.070k/s  3.08 kmallocs/create
                  64    144.491 ± 0.818k/s  3.13 kmallocs/create
                  
kzalloc           16    146.180 ± 1.403k/s  3.10 kmallocs/create  +1.4%
(not changed)     32    146.245 ± 1.272k/s  3.10 kmallocs/create  +1.3%
                  64    145.012 ± 1.545k/s  3.10 kmallocs/create  +0.4%
                   
Task local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
BPF memory        16     24.668 ± 0.121k/s  2.54 kmallocs/create
allocator         32     22.899 ± 0.097k/s  2.67 kmallocs/create
(before)          64     22.559 ± 0.076k/s  2.56 kmallocs/create
                  
kmalloc_nolock    16     25.796 ± 0.059k/s  2.52 kmallocs/create  +4.6%
(after)           32     23.412 ± 0.069k/s  2.50 kmallocs/create  +2.2%
                  64     23.717 ± 0.108k/s  2.60 kmallocs/create  +5.1%


[1] https://lore.kernel.org/bpf/20251002225356.1505480-1-ameryhung@gmail.com/


v1 -> v2
  - Only replace BPF memory allocator with kmalloc_nolock()
  Link: https://lore.kernel.org/bpf/20251112175939.2365295-1-ameryhung@gmail.com/

---

Amery Hung (4):
  bpf: Always charge/uncharge memory when allocating/unlinking storage
    elements
  bpf: Remove smap argument from bpf_selem_free()
  bpf: Save memory alloction info in bpf_local_storage
  bpf: Replace bpf memory allocator with kmalloc_nolock() in local
    storage

 include/linux/bpf_local_storage.h |  10 +-
 kernel/bpf/bpf_local_storage.c    | 235 +++++++++---------------------
 net/core/bpf_sk_storage.c         |   4 +-
 3 files changed, 74 insertions(+), 175 deletions(-)

-- 
2.47.3


