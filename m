Return-Path: <bpf+bounces-75613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE70C8C2FD
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 23:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE493A60DA
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF0335553;
	Wed, 26 Nov 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1fg38/X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FF26ED4A
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195453; cv=none; b=faxgxodoOTrMn8aj3SH0zKTGsaoMeJbhIC8zkUVlwY2/QtJPElremoVQ6aS/1N0+I/nnvcqNebAjzaRLtHdZt/2nZXcNaCxpf/zhsKqWqLDQGbNYFJykhMKeRk2/2OTIJZ1hPqQkgoLzNc3e4RDmHcdnlu55NU5wwZfgJoy4aTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195453; c=relaxed/simple;
	bh=wnENT/i7AHCCTI97AeWVd6C/3Pz88vsc9+JP3PT4DCs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EunZlVcQkXbxP2t7mWoTuFwxRgW2oIVr6u+HPl0T+cg63QXjmPPOcepfqQmaLYaXO8aKm6RskV4T8tZAGTzpWMdTy351WGIhlhwN7DqC/Fga8mVerNII+7nCKEgPtCNdSRpbuk+z4+GmoaujuQX7KUpxvPJF9Sy2KeaNxUR5ha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1fg38/X; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b993eb2701bso235918a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764195451; x=1764800251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WaZfnN+3wROne/L3H9J3JAKUYfm5GqcyYNg/Uc9QV2Y=;
        b=l1fg38/XUV3exMf7iOZBGmo1qEC/qw4BoMYdDIVNV6H5h1q6MgN91pt/Q1HfBiJ1wU
         OTAAeVIfCeisN7MkHiyL2cR9q4S0HBYrC3pNvj46pW0AMfQSyAzcDPU5dArofAXUL4vH
         SVMsuCD+FUu/0XqbU9STY4I8E+6R5Leu0Tul9Iwm1Wfdsl5BZueKSeqS/6DVpDa+flub
         aIHadA9gB0nXxnuRKg/M8iS/RPyDB/l8xHqpWkiBYuR96Bf73xDPp8UMs1qnRd1v9dhG
         iFUaxUampTDVba7pJ0+3ceW9tiEa/5Tde3ImhrzA1aFTWYrrjc5sZFXOokD5rpyT7VSe
         Z+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195451; x=1764800251;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaZfnN+3wROne/L3H9J3JAKUYfm5GqcyYNg/Uc9QV2Y=;
        b=JljjaPZ6wrNI7YKoBFEeUfsBCeKXT/Ad5LC1Vxfd4p1r7ppnNtIb4zEzvkOyGxay48
         5bu0Qw1QRRNtkuzh3O00HaNyUa2KQ5hmU5KW3LudaYiXMpunHesAID3hWc4/IsjGha0A
         pUaA5uleqs6EqYW4rTub3AnPEpTU+XUtWUaVbewIC0+rbeSJVGRphH5qnQOYOYixqbjT
         vk+b+UwhExKUZ6OrTzhNwG4ulgy2uvbb7yMppiLm9CqpDscuKV+nmzeWh07vRwWyJ3lS
         MinsuFm9tKNclwnToX/IAUwRXW6WM5/q8X9rw+VfvgyEPO0o73zLbV+kmZx1sPU4DJV2
         WraQ==
X-Gm-Message-State: AOJu0YwhlJLcyb7v2lVBcsFiWnGh24NiLRZ4r/J60UVclH6hqp/Mi3RZ
	C96YtZJsjUwa5GsffA0+5l3nRslS/xEvFeVRzvn3Bq/DvYFW3Rwp/3WNgmHsgzRWT0FB2LOS3Wi
	ONHoDPuBK4lu3bePRFJiq9aNzOG6S9GVdVM/VQAvPgmKTLchUxllBqOcNJ2l+l+sicpT6PPRKDw
	LgZHJRu25KfarEl46GyNv0ZoXyza1iiE+I0KzT+4zLbvicS6uloNAHEHsK69nSdVtg
X-Google-Smtp-Source: AGHT+IH8iX/fB3tgapZ25MpvrcT6Xf459YdbUTDtyain+2dc0liftOqtbSsWJS0Cg/PasnsVJfCnfiLsLzzVsTaNzQQ=
X-Received: from dybrq3.prod.google.com ([2002:a05:7301:4683:b0:2a4:480f:9430])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:7c0e:b0:2a7:1232:f3a2 with SMTP id 5a478bee46e88-2a9413b5447mr4530275eec.0.1764195450517;
 Wed, 26 Nov 2025 14:17:30 -0800 (PST)
Date: Wed, 26 Nov 2025 22:17:25 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=samitolvanen@google.com;
 h=from:subject; bh=wnENT/i7AHCCTI97AeWVd6C/3Pz88vsc9+JP3PT4DCs=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnqNSX/zC4dLE4Vfvbr3ArvhX87zx69YZBZvSJtR+qUH
 eEzrvxX6ChlYRDjYpAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQATOeDL8M/E3D/Q8fdHJ4Mz
 8xbM3WlpfV37TcW1BUvNHsTfqm73VlZh+B+WXLxBp79abFdL7+u62j9XL7pdiJmo/oLZqcK4uWy DKT8A
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126221724.897221-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v4 0/4] Use correct destructor kfunc types
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

While running BPF self-tests with CONFIG_CFI (Control Flow
Integrity) enabled, I ran into a couple of failures in
bpf_obj_free_fields() caused by type mismatches between the
btf_dtor_kfunc_t function pointer type and the registered
destructor functions.

It looks like we can't change the argument type for these
functions to match btf_dtor_kfunc_t because the verifier doesn't
like void pointer arguments for functions used in BPF programs,
so this series fixes the issue by adding stubs with correct types
to use as destructors for each instance of this I found in the
kernel tree.

The last patch changes btf_check_dtor_kfuncs() to enforce the
function type when CFI is enabled, so we don't end up registering
destructors that panic the kernel.

Sami

---
v4:
- Rebased on bpf-next/master.
- Renamed CONFIG_CFI_CLANG to CONFIG_CFI.
- Picked up Acked/Tested-by tags.

v3: https://lore.kernel.org/bpf/20250728202656.559071-6-samitolvanen@google.com/
- Renamed the functions and went back to __bpf_kfunc based
  on review feedback.

v2: https://lore.kernel.org/bpf/20250725214401.1475224-6-samitolvanen@google.com/
- Annotated the stubs with CFI_NOSEAL to fix issues with IBT
  sealing on x86.
- Changed __bpf_kfunc to explicit __used __retain.

v1: https://lore.kernel.org/bpf/20250724223225.1481960-6-samitolvanen@google.com/

---
Sami Tolvanen (4):
  bpf: crypto: Use the correct destructor kfunc type
  bpf: net_sched: Use the correct destructor kfunc type
  selftests/bpf: Use the correct destructor kfunc type
  bpf, btf: Enforce destructor kfunc type with CFI

 kernel/bpf/btf.c                                     | 7 +++++++
 kernel/bpf/crypto.c                                  | 8 +++++++-
 net/sched/bpf_qdisc.c                                | 8 +++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)


base-commit: 688b745401ab16e2e1a3b504863f0a45fd345638
-- 
2.52.0.487.g5c8c507ade-goog

