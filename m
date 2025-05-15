Return-Path: <bpf+bounces-58362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2C2AB9178
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2693AC9E7
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219525A2C4;
	Thu, 15 May 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFs/Bifq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71441FFC59;
	Thu, 15 May 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343770; cv=none; b=WokFLpXHkgBMkl3M40up7vBcvuKhFMeSyzPGrvKJl0w8zuyoHObAfSfVDeagVjwDR78JqfQClI6clo/P57WvrzlgNCiWKXhFLFDaJV+42LVgnT9Rw6O2oEycA5FW+T48bi8qFzVZb/4ZFnbynlwAjFh3iU+tpdSGWUEGwPmTj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343770; c=relaxed/simple;
	bh=AcBrIDsPF4SGq9K728+c++kvfXIvzuEBEc1vhBulNjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jOY0HoUpivjmueO7/VLKprfGY7jd58dExwg9pk3IqafAendc8bVBmMCWuXKSu3iaFDhM+vojKY1oiS6rhRviT3cSrcsHC/FcCmx+8D5J0GzvXI/WrE8fZuaCMEhOXOMDuX4W2t8UkFdvD8DBqbnAFLl4Ihd5JIzrtdqTrdLp9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFs/Bifq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22fac0694aaso11307525ad.1;
        Thu, 15 May 2025 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343768; x=1747948568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5qe3pbOPN71oPXXzHR/CJkJVse+mtVX/cQ+ivTcRyU=;
        b=TFs/Bifqc7MTrzL0Ld8DJtD2rqEXEcIJxaRu0pQZxNTIUhjsahXUbpfgYdxDk3SRyz
         J2pcobmZAiYb+DR+M7YsOghfQTIf2B36MozIuq6mRsGtIsUMNvAofa/MLm8rCNOX5wvt
         LwROORDuBwS+NJXnMIinH/w67bBrDojiDuZUxYyDx6CzIHVqkSjAAAm110oq6aWNDmCo
         OrnfUS5JRIGNL53vBOrpPAbm+LqNh0bYT/eQEnG5ap5lMOL3qArc9+zMAw5XxHrX40e/
         bs6kWYajo66Na5H1wIJ8qj6Lpeddspr/F61isfgljbzo9++Ju2nDEMUbwTjF6QvVw9xz
         W+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343768; x=1747948568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5qe3pbOPN71oPXXzHR/CJkJVse+mtVX/cQ+ivTcRyU=;
        b=w8yAXeumD/r6tlir/WGE3SvbJZgskF5D+kg7yK5+3KaJKuJiPymU+EvbBZVDu3hfeP
         FVh9Zks5nO/fKcPGFAV4M23CFrm9t5ScW+7TbCeZsclSLFah7lIvvgrtL8g59JApr7oA
         elKnOP/GYFUHv6ryAuMmjB+0UYor6IcUw564Qv4fHpZ7oC49qo7vwstEVWmhnoCrYmcu
         Fr5ogZAvbP8TQCsmjGJhgm8oITAdbndRZ8Dc65SiFgGeFhKAubF7HNNQcWUtoR8+R6Fo
         XBkLfpkvQvznllVWOpcmIgk+0URYWujkKGfO2ppoCY875wERstKjfPWbypihJIpcSJsr
         I4bQ==
X-Gm-Message-State: AOJu0YxCzbNq4KInRBrxZvOc8SaqkBMofUySLr3L34otdB0LjpJZJrOq
	Nz4GycO8YYA9dFxkRZYIgzoNtJUBkFdiU/Er1iz32Cv+50+BoXx1q3ZmItXLeQ==
X-Gm-Gg: ASbGnctVAkB7Coyo7QVHTof4MotdQgZEtsUKEQMSad2xrinsI1XV2BY3Po85FUMf6+O
	HY84PaTZS1nMbJtP+DwaFikvEYvPvhjBDlVzup+eNhTwBHNs1Tn6niJmDo9oHngwnFQ87lUjlOk
	l38/0+GsYMGh3+R/R6oywMY/qAVRolwepVfa049WSmkS4+ynIGb8RTZq22E+rJcvGOtzu0Hpnq7
	mFhXJxCxes0Ym6LfA+IYLmXAeWQxI6Kp1N/cE4sGwtLQQorR01MD/2RBCB01PcTkuRqzfBmSdAm
	+1cj76Jv0b6PZQLKGgKvRU2htUwP3n4BFGYU4a6eaJg=
X-Google-Smtp-Source: AGHT+IGO2j8/p9u1JFpR3wLXMPzcZBKAStGCSTzxkuEXN6Rbnnyy4dDdfu3zFYvASRei8C37lj+xPQ==
X-Received: by 2002:a17:902:f54a:b0:231:b7a6:df1a with SMTP id d9443c01a7336-231de3ba25fmr572465ad.50.1747343767611;
        Thu, 15 May 2025 14:16:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba4bcsm2078795ad.182.2025.05.15.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 14:16:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 0/3] Task local data
Date: Thu, 15 May 2025 14:15:59 -0700
Message-ID: <20250515211606.2697271-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Overview *

Task local data defines an abstract storage type for storing data specific
to each task and provides user space and bpf libraries to access it. The
result is a fast and easy way to share per-task data between user space
and bpf programs. The intended use case is sched_ext, where user space
programs will pass hints to sched_ext bpf programs to affect task
scheduling.

Task local data is built on top of task local storage map and UPTR[0]
to achieve fast per-task data sharing. UPTR is a type of special field
supported in task local storage map value. A user page assigned to a UPTR
will be pinned by the kernel when the map is updated. Therefore, user
space programs can update data seen by bpf programs without syscalls.

Additionally, unlike most bpf maps, task local data does not require a
static map value definition. This design is driven by sched_ext, which
would like to allow multiple developers to share a storage without the
need to explicitly agree on the layout of it. While a centralized layout
definition would have worked, the friction of synchronizing it across
different repos is not desirable. This simplify code base management and
makes experimenting easier.

In the rest of the cover letter, "task local data" is used to refer to
the abstract storage and TLD is used to denote a single data entry in
the storage.


* Design *

Task local data library provides simple APIs for user space and bpf
through two header files, task_local_data.h and task_loca_data.bpf.h,
respectively. The usage is illustrated in the following diagram.

An entry of data in the task local data, TLD, first needs to be created
in the user space by calling tld_create_key() with the size of the data
and a name associated with the data. The function returns an opaque key
object of tld_key_t type, which can be used to locate a TLD. The same
key may be passed to tld_get_data() in different threads, and a pointer
to data specific to the calling thread will be returned. The pointer will
remain valid until the process terminates, so there is not need to call
tld_get_data() in subsequent accesses.

On the bpf side, programs will also use keys to locate TLDs. For every
new task, a bpf program must first fetch the keys and save them for later
uses. This is done by calling tld_fetch_key() with names specified in
tld_create_key(). The key will be saved in a task local storage map,
tld_key_map. The map value type, struct tld_keys, __must__ be defined by
developers. It should contain keys used in the compilation unit. Finally,
bpf programs can call tld_get_data() to get a pointer to a TLD that is
shared with user space.


 ┌─ Application ───────────────────────────────────────────────────────┐
 │ tld_key_t kx = tld_create_key(fd, "X", sizeof(int));                │
 │ ...                           ┌─ library A ────────────────────────┐│
 │ int *x = tld_get_data(fd, kx);│ ky = tld_create_key(fd, "Y",       ││
 │ if (x) *x = 123;              │                     sizeof(bool)); ││
 │                               │ bool *y = tld_get_data(ky);        ││
 │                         ┌─────┤ if (y) *y = true;                  ││
 │                         │     └────────────────────────────────────┘│
 └───────┬─────────────────│───────────────────────────────────────────┘
         V                 V
 + ─ Task local data ─ ─ ─ ─ ─ +  ┌─ sched_ext_ops::init_task ────────┐
 | ┌─ tld_data_map ──────────┐ |  │ tld_init_object(task, &tld_obj);  │
 | │ BPF Task local storage  │ |  │ tld_fetch_key(&tld_obj, "X", kx); │
 | │                         │ |<─┤ tld_fetch_key(&tld_obj, "Y", ky); │
 | │ data_page __uptr *data  │ |  └───────────────────────────────────┘
 | │ metadata_page __uptr *metadata
 | └─────────────────────────┘ |  ┌─ Other sched_ext_ops op ──────────┐
 | ┌─ tld_key_map ───────────┐ |  │ tld_init_object(task, &tld_obj);  │
 | │ BPF Task local storage  │ |  │ bool *y = tld_get_data(&tld_obj,  ├┐
 | │                         │ |<─┤                        ky, 1);    ││
 | │ tld_key_t kx;           │ |  │ if (y)                            ││
 | │ tld_key_t ky;           │ |  │     /* do something */            ││
 | └─────────────────────────┘ |  └┬──────────────────────────────────┘│
 + ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ +   └───────────────────────────────────┘


* Implementation *

Task local data defines the storage to be a task local storage map with
two UPTRs, data and metadata. Data points to a blob of memory for storing
TLDs individual to every task. Metadata, individual to each process and
shared by its threads, records the number of TLDs declared and the
metadata of each TLD. Metadata for a TLD contains the key name and the
size of the TLD in data.

  struct data_page {
          char data[PAGE_SIZE];
  };

  struct metadata_page {
          u8 cnt;
          struct metadata data[TLD_DATA_CNT]; 
  };

Both user space and bpf API follow the same protocol when accessing
task local data. A pointer to a TLD is located by a key. tld_key_t
effectively is the offset of a TLD in data. To add a TLD, user space
API, tld_create_key(), loops through metadata->data until an empty slot
is found and update it. It also adds sizes of prior TLDs along the way
to derive the offset. To fetch a key, bpf API, tld_fetch_key(), also
loops through metadata->data until the key name is found. The offset is
also derived by adding sizes. The detail of task local data operations
can be found in patch 1.

[0] https://lore.kernel.org/bpf/20241023234759.860539-1-martin.lau@linux.dev/

v3 -> v4
  - API improvements
      - Simplify API
      - Drop string obfuscation
      - Use opaque type for key
      - Better documentation
  - Implementation
      - Switch to dynamic allocation for per-task data
      - Now offer as header-only libraries
      - No TLS map pinning; leave it to users
  - Drop pthread dependency
  - Add more invalid tld_create_key() test
  - Add a race test for tld_create_key()
  v3: https://lore.kernel.org/bpf/20250425214039.2919818-1-ameryhung@gmail.com/

Amery Hung (3):
  selftests/bpf: Introduce task local data
  selftests/bpf: Test basic task local data operations
  selftests/bpf: Test concurrent task local data key creation

 .../bpf/prog_tests/task_local_data.h          | 263 ++++++++++++++++++
 .../bpf/prog_tests/test_task_local_data.c     | 254 +++++++++++++++++
 .../selftests/bpf/progs/task_local_data.bpf.h | 220 +++++++++++++++
 .../bpf/progs/test_task_local_data.c          |  81 ++++++
 4 files changed, 818 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c

-- 
2.47.1


