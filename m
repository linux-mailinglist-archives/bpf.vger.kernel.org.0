Return-Path: <bpf+bounces-62714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA34AFDB8E
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE511171653
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3D22E3E8;
	Tue,  8 Jul 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTGPQW5U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73E22D79F
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016109; cv=none; b=DPUii0DDv7PTPQIQfzJ4+MDQmOBFSNog4N4UZhQkOaLjRz8NjQzolZLd3Jibe73+1mAf4lQIaJQ/KJwETbj4ykBkTIE0Otk1H54w9zDjvFCHZsokEXByYVNMYRP1VbhvAYNuoSsG4L/h9ghyyqDsJl7+kG1eiQ7XCJa1UpvWSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016109; c=relaxed/simple;
	bh=4/znmI8FLtMOu7vjCVfRQk5IhgrnluW72ZPJRNl3VJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djYqssfJDYV+C2ZeF0gcAK7JPMSazWijdKsmvnWGODx2ysvWu20t3qWq6L4BsLhbToahtMzPGZ3BC7MSmI5fnvkC/WQB8Q4hgmqbY3jKHtt/shuueD7cPqHomEvf4fKeyzR+gWU81yaMRurXbVZSUIdNy3DWNkYU4HVnjQtHuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTGPQW5U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167b30so50371425ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016107; x=1752620907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBxrE3IV5L6oyVIgfChCBaOrLr/BUH7aFqUV6jKt8DM=;
        b=lTGPQW5UxmCM+19gQq5fvzHz9OvWj666zWO5rmXOPY0xIreHLIrTqPJ04hG1htpy3Q
         TwIoRpcv727+mOiNMk2NcFewP5KmTXgdLcdP7l1z6DsUxgd5BC1Glmh069auWg/YUM7B
         oJ7yIeMs/hK2hy5cjw/YQYmVOmj1SjUlLrE2XwLKBa7yxSKnqEl5pO1q26+33rS97h6L
         aktYhX3b4gWGVOG8VQ0I258Kgvnb05x6hxfMeLmLuJlg8qPWC2Ez1EknNeoY0pNvfY3x
         /rdr/wtQmMo0rkTKbgaj92bn8GkulUuMHJn8ySEdAI+b5uxl4ALLqtVnWkTZwpfTB7ZH
         efkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016107; x=1752620907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBxrE3IV5L6oyVIgfChCBaOrLr/BUH7aFqUV6jKt8DM=;
        b=oqnJstxO9WeBshgD0tUq5hPgWa63p1hltIcOsAKkPTk6y3iCGmhTxOcGiggKftqqGh
         q1UDf0on1G7+TGVePUNXRX7fA9hVstbOlaXHhpd1Vj8pUFZYKcaPe1c90QoUwlOHJrAg
         7ydtlpQMzgejnJxunQyNyM10Jb9vsCvwPTVapwUofoQJy7gjDj9Xb3ImCwI4jJLKTrPn
         NcK1ejhQg/4g1anXV5eHOeK1Ny92Mtww+5kCeiwSx0GACVM/hEi3eh6pE0r9YxOgTU0h
         xwmj/3M83wLy8vFI9l+yeCCSbRKks0a13RVwI3iFneaMy3amobSmCpjGPs0MF7MzQiZR
         eLKw==
X-Gm-Message-State: AOJu0YzKUmxzkuzk6G/DhRu0fTuLE4AGxXOXFmQROez3FhGyrbyWwFdB
	TM8DmbwR6TEYrEwCVpVRs7B0QoJbFfp32dVUzHmxUmXARcuSt9WwnKhRyf5G9g==
X-Gm-Gg: ASbGncvPLBZgUd05Zf/tUc49DFcMVX7rZvAtS8eqRuHqNivzqa4UaK5S4nyPYaIEulM
	vlwxvKBpcr5+8tgkyZk3T7uVaBqlkK0FurNG89nNDi30YCPxNpbhsq7kmUIVfj0F53EctOy3ZVu
	hMLI9Wd+BcQPoDVsBjDzrq2CTikakIVGqVeMTWIoDMjZYUfOdSbkCOZKTks99SIUTpHjCXok6PW
	NPefeW1aYh8MkiIjGhkT9Upau6AgdyI5Gz11BYL0F/Sn9Q1kBuAQoBcqFZKl8NdGiTsV5qENecA
	k+jpmrVyYac5klfLZKfbIvZ8gy5X0ooGgHmVz5Pfx69XK4DdzsFFnA==
X-Google-Smtp-Source: AGHT+IEB7dLM5TenngmRjM4ynS1CnOOryfYB3o4s5cJfnY2eObt5G3Fnuc4EGLw493NvvFXQhFQTow==
X-Received: by 2002:a17:903:22c5:b0:234:8f5d:e3a4 with SMTP id d9443c01a7336-23ddb18ff20mr4720475ad.2.1752016106583;
        Tue, 08 Jul 2025 16:08:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8434ed23sm120186825ad.54.2025.07.08.16.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 16:08:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 0/4] Support cookie for link-based struct_ops attachment
Date: Tue,  8 Jul 2025 16:08:21 -0700
Message-ID: <20250708230825.4159486-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Motivation *

Currently, sched_ext only supports a single scheduler. scx kfuncs can
reference the calling scheduler simply with a global pointer, scx_root,
whether being called in struct_ops, tracing, syscall or async callback.
However, when sched_ext moves to support multiple scx schedulers,
scx kfunc without task_struct argument won't be able to easily refer
to the calling scheduler without passing additional information.

The vision is to be able to view struct_ops, tracing, syscall programs
and async callbacks in a file as part of a scheduler, and have the
ability to refer to the scheduler in kfuncs called from any of the
programs.

However, right now there is not a notion that connects bpf programs in a
file in the kernel. Until it is clear what that should be, as a
stopgap, we would like to reuse cookie to associate bpf programs
belonging to the same scheduler.

* Design *

The interim solution is to use bpf cookie as the scheduler id, and add
the cookie as an argument to scx kfuncs without task_struct. By
maintaining the cookie to scheduler mapping in sched_ext, kfuncs will be
able to refer to the calling scheduler internally using cookie.

For the user space loader, it should use the same cookie when attaching
bpf programs. In bpf programs, they will call bpf_get_attach_cookie()
to get the cookie and pass it to scx kfuncs.

The following patches are the first part of the kernel-side plumbing: to
support cookie for link-based struct_ops attachment. struct_ops already
uses bpf trampoline. The only problem is the trampoline is being populated
during map_update when the cookie is not known yet. This patchset moves
the trampoline preparation from map_update to link_create for link-based
struct_ops attachment. Then, we extend the UAPI to take the cookie and
propagate it all the way to the struct_ops link_create. Finally,
bpf_get_attach_cookie() is allowed to struct_ops programs. 

A problem that has not been addressed in this RFC is that by moving
trampoline preparation to link_create, creating multiple links
using the same struct_ops map becomes problematic. A simple solution
may be just disable if there is no obvious use case for it.

* Alternative *

Martin has suggested a way that involves less kernel changes: Using
struct_ops map id as the sched_ext scheduler id. Instead of further
complicating struct_ops, sched_ext can create the struct_ops map id
to scheduler mapping in reg(). The id will also be stored in a global
variable in the file referenced by different types of programs. The
rest is similar to the cookie approach: kfuncs without task_struct
will need to add an argument, and they will lookup the scheduler by
the id.

* Previous approach *

The previous solution was to set a "this pointer" pointing to the
struct_ops struct during struct_ops map_update. Then, kfuncs can get
a pointer to the scheduler with a __prog argument. However, this
approach is broken as it would only work for struct_ops programs.


Some thought after Martin brought up the idea

I think we should use the map id instead of cookie. Especially if we are
going to disable creating multiple links per map, the cookie effectively
becomes the same as the map id.


Amery Hung (4):
  bpf: Factor out bpf_struct_ops_prepare_attach()
  bpf: Support cookie for linked-based struct_ops attachment
  libbpf: Support link-based struct_ops attach with options
  selftests/bpf: Test bpf_get_attach_cookie() in struct_ops program

 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/bpf_struct_ops.c                   | 199 ++++++++++++------
 kernel/bpf/helpers.c                          |  18 ++
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/lib/bpf/bpf.c                           |   5 +
 tools/lib/bpf/bpf.h                           |   3 +
 tools/lib/bpf/libbpf.c                        |  14 +-
 tools/lib/bpf/libbpf.h                        |  10 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/test_struct_ops_cookie.c   |  42 ++++
 .../selftests/bpf/progs/struct_ops_cookie.c   |  48 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   1 +
 12 files changed, 280 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_cookie.c

-- 
2.47.1


