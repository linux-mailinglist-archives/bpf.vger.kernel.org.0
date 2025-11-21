Return-Path: <bpf+bounces-75263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3500C7BED8
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D60944E2D09
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB92FD675;
	Fri, 21 Nov 2025 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd1PpmDc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B512D8762
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766836; cv=none; b=UyTBVdwvQhOzsUUmMT9cYGEz+cqgVvmJezZX/9ciHKYzXhB6tpx3OCr7rHQQKbYokfEja7Q/Gt8TdlhLkj5SS9N5sVb0Se2o930e2hZHMYB1P1ia1GTPedOvbuibU/kDQIvgkUOVsOAnol2mJqi3DdniQxpTEaHu5zRG2xqyr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766836; c=relaxed/simple;
	bh=0rE1qMLzy7z7I9ShbbRpnBp9Fve6nx/WDT1TlmRdoQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HViG9dwzpoGtbaP/4HgPpbbz2ktJEpVcksFVtlOIE+CsdOGtcBihAdcAxYA9TuZJ9WP1Zb2V5oEzyWE09b+ag9r4JrU3++cDbV6OWkPXwtEO9O+LysYPpMMEEfLZ/y/Ift7zMIVvFpQCv2I8OLcpacdrMudSZmomsXzlL80t+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd1PpmDc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343684a06b2so2569743a91.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 15:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766834; x=1764371634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=spa8yr2+mp4zbu3ywxCsG+qoLVTSrXpwiRfXcPtXyz8=;
        b=cd1PpmDcAxF1dz5g+mYZ4yB+aQAbrWRrGKAwPRXTDxLNm4SCrGBIEBrYyPi22v6crC
         IE4YPuV6O6hKJRYlxZSEVqu/foIFln8i21HqBu6gFRx9HQAIMPjGV+tACTN3K9SUEw9d
         pCGiv75CruO2PANUMdT/9EYm25ZMulT3pfjGZPQOjuijaD/piknpX9xnFZ9mEdFU8k9C
         LCsB/1rtg3Iu5JVm/49JObUAk1EtnvV1TTif3KQWoQLh3Uy7yGLlZBlC+3XGkHHSO+L9
         D27x6upVLdsjq3drLSGcyKIMnonfsaqmxM+C4yHYekgRzDQAVGyTd74ScNynl6N04Xdr
         MW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766834; x=1764371634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spa8yr2+mp4zbu3ywxCsG+qoLVTSrXpwiRfXcPtXyz8=;
        b=PhoUH7qQUinlAozL28nEDZuI6UTknLQG9WcizfmPwyDuHf6T7c+0YPdC/zDFHKlzWX
         iXPo+Lak3ZRFEwC5cIe8g334KFBOC857eglhiKemf+cugYN37megaQ6oIeyPr7ECJq0S
         g7HaJbV4KuwuMKseWfpMt8OySvtq3VVOLqwX4gMrYMxLwlHYzEn9LIWdHUpZNT/VnUT4
         NaDHX8bxz+6jm/x2q9pb3XOOsGX6hFxvZRLr0c3dqW3CFSWiN4xXndC7LiMJCdrIKmMR
         m9coOb0ZM6nbdo1qaTODUK21QlXifxL9F4FFjmYBwvin/fkfEIRgy7LXnUVK9F4QYNQZ
         TRbw==
X-Gm-Message-State: AOJu0YxJlsQgj3vKUt0WC1MdolREL39+YIBTHV4eimitZhkCzLMzAMOM
	0RMd+PoSQqxltzfOnUYcUJO2lU/n03MVCKYWbN+PpP7Npd1scQENNbU1jPVUYA==
X-Gm-Gg: ASbGnctB19qnc1hFOR1fhMQhdLUrj1QE+KCZty3TMWNzWfFae+EVHAbEASSHu2X6Ooi
	MJQeG4B5o1DpnQlJdoNlbN1ixtWRfSGWxozo2SiHzlUc56pudfzE+Xu1RELKrxmuHRHOh0EcaHh
	x/7sQuGjPUPZPQ7OgFoolc4YkkcQjKaq059XClSvifSn7EldFcL36+7dXJUkaS+YAS1u04/u2l/
	ykWLkTeYeWQYLzHKxnjpUCDZs2rgePTt7c0pFU0PZ0M4g5U/fnZ9t0rrWuckIYvyltZhir18WC6
	XJsOp9Oe/LWs47WFIJFYuIybdkE0u0i8hKnbk9nmtdCI38iPnbwPI5OCkxL7MRpYOr8B5dAAhFF
	G9pHPAQDEI5UpnM05wbJbT4V3oCa9PC0Wct29oD0hyqRDeRZUtL0gDtJ4PUbvyDHCOxNqR6w/gL
	NZP3plUJf61o9beQ==
X-Google-Smtp-Source: AGHT+IEzChHgBQmpGtQaltF9fphPhlg/5YARydcBov6WatCIzU3EBz4e+04N800ARYj+llVKgUi8qQ==
X-Received: by 2002:a17:90b:2244:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-34733f23554mr4441615a91.19.1763766833950;
        Fri, 21 Nov 2025 15:13:53 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm65476245ad.25.2025.11.21.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:13:53 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 0/6] Support associating BPF programs with struct_ops
Date: Fri, 21 Nov 2025 15:13:46 -0800
Message-ID: <20251121231352.4032020-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset adds a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to
the bpf() syscall to allow associating a BPF program with a struct_ops.
The command is introduced to address a emerging need from struct_ops
users. As the number of subsystems adopting struct_ops grows, more
users are building their struct_ops-based solution with some help from
other BPF programs. For example, scx_layer uses a syscall program as
a user space trigger to refresh layers [0]. It also uses tracing program
to infer whether a task is using GPU and needs to be prioritized [1]. In
these use cases, when there are multiple struct_ops instances, the
struct_ops kfuncs called from different BPF programs, whether struct_ops
or not needs to be able to refer to a specific one, which currently is
not possible.

The new BPF command will allow users to explicitly associate a BPF
program with a struct_ops map. The libbpf wrapper can be called after
loading programs and before attaching programs and struct_ops.

Internally, it will set prog->aux->st_ops_assoc to the struct_ops
map. struct_ops kfuncs can then get the associated struct_ops struct
by calling bpf_prog_get_assoc_struct_ops() with prog->aux, which can
be acquired from a "__prog" argument. The value of the special
argument will be fixed up by the verifier during verification.

The command conceptually associates the implementation of BPF programs
with struct_ops map, not the attachment. A program associated with the
map will take a refcount of it so that st_ops_assoc always points to a
valid struct_ops struct. struct_ops implementers can use the helper,
bpf_prog_get_assoc_struct_ops to get the pointer. The returned
struct_ops if not NULL is guaranteed to be valid and initialized.
However, it is not guaranteed that the struct_ops is attached. The
struct_ops implementer still need to take steps to track and check the
state of the struct_ops in kdata, if the use case demand the struct_ops
to be attached.

We can also consider support associating struct_ops link with BPF
programs, which on one hand make struct_ops implementer's job easier,
but might complicate libbpf workflow and does not apply to legacy
struct_ops attachment.

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L557
[1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L754

---
v6 -> v7
   - Drop the guarantee that bpf_prog_get_assoc_struct_ops() will always return
     an initialized struct_ops (Martin)
   - Minor misc. changes in selftests
   Link: https://lore.kernel.org/bpf/20251114221741.317631-1-ameryhung@gmail.com/

v5 -> v6
   - Drop refcnt bumping for async callbacks and add RCU annotation (Martin)
   - Fix libbpf bug and update comments (Andrii)
   - Fix refcount bug in bpf_prog_assoc_struct_ops() (AI)
   Link: https://lore.kernel.org/bpf/20251104172652.1746988-1-ameryhung@gmail.com/


v4 -> v5
   - Simplify the API for getting associated struct_ops and dont't
     expose struct_ops map lifecycle management (Andrii, Alexei)
   Link: https://lore.kernel.org/bpf/20251024212914.1474337-1-ameryhung@gmail.com/

v3 -> v4
   - Fix potential dangling pointer in timer callback. Protect
     st_ops_assoc with RCU. The get helper now needs to be paired with
     bpf_struct_ops_put()
   - The command should only increase refcount once for a program
     (Andrii)
   - Test a struct_ops program reused in two struct_ops maps
   - Test getting associated struct_ops in timer callback
   Link: https://lore.kernel.org/bpf/20251017215627.722338-1-ameryhung@gmail.com/

v2 -> v3
   - Change the type of st_ops_assoc from void* (i.e., kdata) to bpf_map
     (Andrii)
   - Fix a bug that clears BPF_PTR_POISON when a struct_ops map is freed
     (Andrii)
   - Return NULL if the map is not fully initialized (Martin)
   - Move struct_ops map refcount inc/dec into internal helpers (Martin)
   - Add libbpf API, bpf_program__assoc_struct_ops (Andrii)
   Link: https://lore.kernel.org/bpf/20251016204503.3203690-1-ameryhung@gmail.com/

v1 -> v2
   - Poison st_ops_assoc when reusing the program in more than one
     struct_ops maps and add a helper to access the pointer (Andrii)
   - Minor style and naming changes (Andrii)
   Link: https://lore.kernel.org/bpf/20251010174953.2884682-1-ameryhung@gmail.com/

---

Amery Hung (6):
  bpf: Allow verifier to fixup kernel module kfuncs
  bpf: Support associating BPF program with struct_ops
  libbpf: Add support for associating BPF program with struct_ops
  selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
  selftests/bpf: Test ambiguous associated struct_ops
  selftests/bpf: Test getting associated struct_ops in timer callback

 include/linux/bpf.h                           |  16 ++
 include/uapi/linux/bpf.h                      |  17 ++
 kernel/bpf/bpf_struct_ops.c                   |  88 ++++++++
 kernel/bpf/core.c                             |   3 +
 kernel/bpf/syscall.c                          |  46 +++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  17 ++
 tools/lib/bpf/bpf.c                           |  19 ++
 tools/lib/bpf/bpf.h                           |  21 ++
 tools/lib/bpf/libbpf.c                        |  31 +++
 tools/lib/bpf/libbpf.h                        |  16 ++
 tools/lib/bpf/libbpf.map                      |   2 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 191 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     |  77 +++++++
 .../bpf/progs/struct_ops_assoc_reuse.c        |  75 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 18 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

-- 
2.47.3


