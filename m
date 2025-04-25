Return-Path: <bpf+bounces-56746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC07A9D456
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263964C525B
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106F266567;
	Fri, 25 Apr 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPxkscWL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0C25CC75;
	Fri, 25 Apr 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617244; cv=none; b=t8pagh7O1SHbGhWuYcuXuJKre9oyPmLXi8LU2zIpPoIFpZLg7jrwc3TPTppMh6CCqkwatgl6REXQZ95pdI92FZ0bTsdO3sIgDON17EsNwY1Ngv6W1XB3pFq78UBXdLQ9YVnx5rRBschfo7lwygDWneM+ro24d5HcuZXgTV6LwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617244; c=relaxed/simple;
	bh=RNAAOYwYcwnpuTrbszkKfZ/uaeVGRO9nK6XhQ+2vEvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UbP30DYPbnXdNFFjvzH76u0tn3CM1xDQAxpjLpboS30ssfFz2iCrFDWw7GgcCPtFZFnrQ35xzemHhR7C/SGGNQC6agLCcC1YDPS6+k2Sc3KVGLsHiihStrDyIvKt9yJN9Du7g7A9ZDgftnYJ6gHtMGi5dI+BxdbVRQnssJAJSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPxkscWL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c3e7b390so3007111b3a.2;
        Fri, 25 Apr 2025 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745617241; x=1746222041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxOX8UI37aThGLDSj2NVeWYFvK02KLxnbsY52EwODlo=;
        b=PPxkscWLXr38Jxtp9mLUlHWjPe46QhWV2vldwssTAJRBCj3uXxjDHcwqzEOEmRCzaL
         52QDtMzgL8Dz3tUriOLQk2mSNMUzFC/bBfAxAguoAECKtItKm0dUP0M7zzzG8kr35XUg
         3n5FgEaKvJPFuC9MRZrAOHbQVwFjXG6PUjk60/8zn3LD4H3IKOftys45p2raaqhhmbBc
         rZHTOZ9tWo2DxWPWIHPqOog18bm520PFKykPX9xMpFbIj6C20goJ46RP2VLTQSKOILYm
         s026M2Z7bqvOw1Jr88vsQkxVUQEq75+oV/mpx9Qn8XapitsIuPeSbgRgOtDKG2v99eIE
         STRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617241; x=1746222041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxOX8UI37aThGLDSj2NVeWYFvK02KLxnbsY52EwODlo=;
        b=U1cvPuVOws/lSpYMGg2GApcJz5Zn5ow2z60lveEfotfMa6XkPhBzORpa8zN+31fp4L
         6l+0rdsfSDnk4J8HeEpaA7SI0zduhqraDp5qSei5uWpdODD0KzQPx41g4WfiHcMzvGiu
         Oh2IMcMMHKF6WUBpn66ZM9iu8c1A90Yt0qGEVbF0aOqaCguhmm6BsaEoqfFKOcLPbEOL
         7mbKif8C323L+Auw6EJEXXhtHT8I5kVk2RIKCyWM9Q6ueMWAUZreoyT0Nvh4kAT0iz15
         Azb6CGKUrUR5mUhJTnkgmwaXC9Zjp4XmDdA53bGqTstoKcLILdHc5Ve+6ciCzjOsYq9s
         X6uA==
X-Gm-Message-State: AOJu0Yx/2iNC9k7EjadHBoZyVm75zbG0KnIkdKhvS4xKHbZattU8MYcE
	3x3Da2Cs3kXVKVULZpXiQtPWgXyx/o7is7GRAX/j32Mvc1m8pVYdcJijEQ==
X-Gm-Gg: ASbGnctFVDB9sJS14x0WUYZsXKMtEvI/HOECHxZKRybtDFcIdKq5DX4CcB06K+ThtHV
	llvrnLkfu3crsUfTDIdcmOkYY5zkZUoCWYgk/87k5sXXgUVwZKIkqkUZ+GqLuvUwPAfXVSThpvU
	AneHvazlXhY+sZwaG7p7A7Vdf5QZC//qPENnyRNLHEAKLNxKoyeQmF03oUIwoRuRhcZBMu3ZbNr
	VfB4tChHnnRsZtOvS8Z7qSm2d4fcKUJIXLyoY3wv7bz0Vs8WGLizjAeyTZ10EV3qNrDacQ0H5+0
	UprM+3qAo2mdfEjFrMQRXGi42YDVAeM=
X-Google-Smtp-Source: AGHT+IGHN10yxSNMBgiA/C7QSjo6cPI8Fox6lYIrdvMp/vJgqUbGXjce33xSClJZAUuj0lPB7rF14Q==
X-Received: by 2002:a05:6a00:b92:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-73fd6fddccamr5079364b3a.6.1745617241276;
        Fri, 25 Apr 2025 14:40:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6b462sm3659640b3a.114.2025.04.25.14.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:40:40 -0700 (PDT)
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
Subject: [PATCH RFC v3 0/2] Task local data API
Date: Fri, 25 Apr 2025 14:40:32 -0700
Message-ID: <20250425214039.2919818-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This a respin of uptr KV store. It is renamed to task local data (TLD)
as the problem statement and the solution have changed, and it now draws
more similarities to pthread thread-specific data.

* Overview *

This patchset is a continuation of the original UPTR work[0], which aims
to provide a fast way for user space programs to pass per-task hints to
sched_ext schedulers. UPTR built the foundation by supporting sharing
user pages with bpf programs through task local storage maps.

Additionally, sched_ext would like to allow multiple developers to share
a storage without the need to explicitly agreeing on the layout of it.
This simplify code base management and makes experimenting easier.
While a centralized storage layout definition would have worked, the
friction of synchronizing it across different repos is not desirable.

This patchset contains the user space plumbing so that user space and bpf
program developers can exchange per-task hints easily through simple
interfaces.

* Design *

BPF task local data is a simple API for sharing task-specific data
between user space and bpf programs, where data are refered to using 
string keys. As shown in the following figure, user space programs can
define a task local data using bpf_tld_type_var(). The data is
effectively a variable declared with __thread, which every thread owns an
independent copy and can be directly accessed. On the bpf side, a task
local data first needs to be initialized for every new task once (e.g.,
in sched_ext_ops::init_task) using bpf_tld_init_var(). Then, other bpf
programs can get a pointer to the data using bpf_tld_lookup(). The task
local data APIs refer to data using string keys so developers
does not need to deal with addresses of data in a shared storage.

 ┌─ Application ─────────────────────────────────────────┐
 │                          ┌─ library A ──────────────┐ │
 │ bpf_tld_type_var(int, X) │ bpf_tld_type_var(int, Y) │ │
 │                          └┬─────────────────────────┘ │
 └───────┬───────────────────│───────────────────────────┘
         │ X = 123;          │ Y = true;
         V                   V
 + ─ Task local data ─ ─ ─ ─ ─ ─ +
 | ┌─ task_kvs_map ────────────┐ |  ┌─ sched_ext_ops::init_task ──────┐
 | │ BPF Task local storage    │ |  │ bpf_tld_init_var(&kvs, X);      │
 | │  ┌───────────────────┐    │ |<─┤ bpf_tld_init_var(&kvs, Y);      │
 | │  │ __uptr *udata     │    │ |  └─────────────────────────────────┘ 
 | │  └───────────────────┘    │ |
 | │  ┌───────────────────┐    │ |  ┌─ Other sched_ext_ops op ────────┐
 | │  │ __uptr *umetadata │    │ |  │ int *y;                         ├┐
 | │  └───────────────────┘    │ |<─┤ y = bpf_tld_lookup(&kvs, Y, 1); ││
 | └───────────────────────────┘ |  │ if (y)                          ││
 | ┌─ task_kvs_off_map ────────┐ |  │     /* do something */          ││
 | │ BPF Task local storage    │ |  └┬────────────────────────────────┘│
 | └───────────────────────────┘ |   └─────────────────────────────────┘
 + ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ +

* Implementation *

Task local data API hides the memory management from the developers.
Internally, it shares user data with bpf programs through udata UPTRs.
Task local data from different compilation units are placed into a
custom "udata" section by the declaration API, bpf_tld_type_var(), so
that they are placed together in the memory. User space will need to
call bpf_tld_thread_init() for every new thread to pin udata pages to
kernel.

The metadata used to address udata is stored in umetadata UPTR. It is
generated by constructors inserted by bpf_tld_type_var() and
bpf_tld_thread_init(). umetadata is an array of 64 metadata corresponding
to each data, which contains the key and the offset of data in udata.
During initialization, bpf_tld_init_var() will search umetadata for
a matching key and cache its offset in task_kvs_off_map. Later,
bpf_tld_lookup() will use the cached offset to retreive a pointer to
udata.

* Limitation *    

Currently, it is assumed all key-value pairs are known as a program
starts. All compilation units using task local data should be statically
linked together so that values are all placed together in a udata section
and therefore can be shared with bpf through two UPTRs. The next
iteration will explore how bpf task local data can work in dynamic
libraries. Maybe more udata UPTRs will be added to pin page of TLS
of dynamically loaded modules. Or maybe it will allocate memory for data
instead of relying on __thread, and change how user space interact with
task local data slightly. The later approach can also save some troubles
dealing with the restriction of UPTR.

Some other limitations:
 - Total task local data cannot exceed a page
 - Only support 64 task local data
 - Some memory waste for data whose size is not power of two
   due to UPTR limitation

[0] https://lore.kernel.org/bpf/20241023234759.860539-1-martin.lau@linux.dev/


Amery Hung (2):
  selftests/bpf: Introduce task local data
  selftests/bpf: Test basic workflow of task local data

 .../bpf/prog_tests/task_local_data.c          | 159 +++++++++++++++
 .../bpf/prog_tests/task_local_data.h          |  58 ++++++
 .../bpf/prog_tests/test_task_local_data.c     | 156 +++++++++++++++
 .../selftests/bpf/progs/task_local_data.h     | 181 ++++++++++++++++++
 .../bpf/progs/test_task_local_data_basic.c    |  78 ++++++++
 .../selftests/bpf/task_local_data_common.h    |  49 +++++
 6 files changed, 681 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data_basic.c
 create mode 100644 tools/testing/selftests/bpf/task_local_data_common.h

-- 
2.47.1


