Return-Path: <bpf+bounces-54494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6CA6B007
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396403A66D6
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF38221F02;
	Thu, 20 Mar 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSr7m9BA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8002AE6A
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506870; cv=none; b=uTALxCN2r5i93o8ry8Suwph64Xm7C673sEqc0L2EVsWSic83bZHpWThyn68eEzwx05HJofNLSkA6F8FPiYUb+3NDHypoxej31yJTde6oq65AuvTTeOqh/QTlDYPDIoDIjAq1WfS6BGI6ZfjNlbCD/Sg6MHGBKfFeFY+L13gHcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506870; c=relaxed/simple;
	bh=65cRKhIvDFubWB+ZUYeMdXG9Dq6Whzq/xG12/0aWzVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huDuk7JQ4cJaw7HO37Q40JuGIQVq5xJPwGxLcE8ZzMTqShaot+ca3maT1JBKa50b6J/4eTcdp2AnZM0oZfOFD2nppK4NBCwIUHWjh1oCjKqP2acqYVFz4jgAPYusEl2rkCQtOIT9psw72WgQ4AP/yO4kvXvjdd8YYmFRaVHp0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSr7m9BA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2239c066347so29914365ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742506868; x=1743111668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxS8ipd7iLtKBIB9OGtCz2y9XVrD9HSGdhgFOUWQ/ps=;
        b=FSr7m9BAvNgRnRjARLMmYXfxEZp8Pg+NVmlKGkzvqSddNjbUGpXeVZNKobyjyqx1xT
         AxNzhPIPh//1pupqlI2+Nizjet8/c7zJbSXh2RrfC+vuwVYiRx+pALJFV13UMlEsPiLH
         HazS73ShmH2JxvHHG5DqZ5FuWtO4UzoqpGJbvl/8KJCXmIzfMyXzoRlaPzjpP5SHPoKN
         rxchVItccFlBsg6uU27CC6+uaSQy0q5uAXEOd/lOVtVvvQjK4rkEUDrTu5Hr6RtlBk+o
         4BAOONfWKl4kP2UF6eSUV0xdzlgC2Q4seVukoZg/WkWpJmZAnsU637FXgQL7/BLLoEK6
         zslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506868; x=1743111668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxS8ipd7iLtKBIB9OGtCz2y9XVrD9HSGdhgFOUWQ/ps=;
        b=PynsdQg3mcBHWnmdDxZ2+YxXVaDds+XBuGCbacGbBlj7MaaVLam1GoZhd/SCBWdmln
         U6uMXnHfviAEdT4oHpnxdButyhX+yIariF2ClT5zGzwLTkcLx3sKoge5AkU1UbWnbpb4
         xexZjTR6eRX35YalFXyXc+sM7TNfLnFq6uFc8K2iITuuexJjbfyvMEI8+48dwR1hQWWv
         q/P/hfzTP1yuSR9KA/NcIEG8emxxwyMFYNczKglLCwtvMshIpvoFWt0PL54W7BsfLpLy
         lFBIRWvJXv/t8XOA2GzI+FzygFfuCLxjYP5JjByr0rACtetKHtH2hseMIklfo4ZYshG0
         sL8A==
X-Gm-Message-State: AOJu0YzoaDzJf86ryIB62Q/u/DA6epzdRimQ1XkqDav3AqbqnLFYgIzU
	/iw5wJKysZ15+o8OC67YzRBqVBxQ2InOLPN9GB7bPVnXEyK9B6MEbpO+a7Ft4FE=
X-Gm-Gg: ASbGnctTv0O/YbUOVdV+hR0GqRnBTBsdjMNhpV4lYMhAVcI0XD8hhoNZUz7G9XDOaBh
	knMia0pQG0VSw6tNrcuLczl28m0o6/hGTj/aoX6pMNTjP+Uj2upJPCeO2R2qOmqQ7Ft+qsbeI9O
	q6z9kiMc2AYln57F22whXy+RI1M0I0VX6QnyrSncbVZN+T036mQoNUVbFjDSHcG8JVaLj9TjvUC
	1fHVym8HJpCs7dvqPRylP8aLknGllTUYzgESpSvw1CzjvHU/y2eYZ28z9bKHJIlDeBUki7PKNXX
	jx7unw6BuTQkC7ddymAuU8i67x6TfN+DMn/qyqln398YL9fVwwubb7EHGqGNV7PX7hbcmpjFFE7
	O5ZwwvvACuzG+sJMe69A=
X-Google-Smtp-Source: AGHT+IE1VqT4GhQJi8WnqKy6n+DiSVTwylfYWQ+7twqXb6ULJ5bL0TSNMYEhx/Ze6BfH6PPFDnlWog==
X-Received: by 2002:a05:6a00:1393:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-7390599a0f7mr1480325b3a.11.1742506867415;
        Thu, 20 Mar 2025 14:41:07 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e59esm321135b3a.170.2025.03.20.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:41:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH 0/4] uptr KV store
Date: Thu, 20 Mar 2025 14:40:54 -0700
Message-ID: <20250320214058.2946857-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I'd like to discuss uptr KV store in LSFMMBPF'25. This is just an RFC and
the code definitely needs more work, but I hope it delivers the high level
idea.

* Overview *

The uptr KV store implements a key-value store based on existing bpf
features with one small change to the bpf verifier code. A motivation of
this work is to make rolling out a new bpf program with changes to map
value layouts easier. Currently, there is not a simple and easy way to do
it. One may try to create a new map that has the new map value layout,
copy old values into the new one, and then starts the new program.
However, this process is not trivial to automate. uptr KV store provides
an alternative to this. By replacing a structure in a map with the use of
KV store with multiple key-value pairs, changing map layout becomes just
adding/deleting key-value pairs. In addition, by maintaining a manifest
of key-value pairs, the roll out process and be easily automated.

* Design & implementation *

- User space and bpf API

  The uptr KV store provides basic user space and bpf API (get/put/
  delete). In addition, there are APIs for managing space that are only
  provided to the user space. It is assume that all keys are known
  before deploying a bpf program. To use it, the user space program first
  needs to initialize the KV store by calling kv_store_init() and
  initializes all key-value pairs using kv_store_put(). Then, the bpf
  program and user space program can start using the KV store. 

- Single global map lookup in KV store bpf API

  Making the KV store performant enough for use in bpf programs on the hot
  paths is one of the design goal. To achieve this, a key is to keep map
  lookups as little as possible. The current implementation only requires
  one task local storage lookup during one program invocation. Then, get/
  put/delete only involves memory accesses in the uptr regions in the local
  storage.

  The uptr KV store mainly consists of two uptr regions, metadata and data.
  The metadata is an array of metadata indexed by key, where each metadata
  contains the page index and page offset and the size of the key-value
  pair. The data region are pages allocated on-demand for storing values,
  and one page is allocated initially.

  If using string key is desired, the metadata can be moved to a bpf
  hashmap indexed with string keys. However, this will add one hashmap
  lookup to every basic KV store operation.

- 1K max int keys; 1B - 4KB value

  The KV store is indexed by integer keys and the maximum number of keys
  supported is 1K. This is limited by the maximum number of metadata as
  shown below that can be stored in a 4KB uptr metadata array. The largest
  size of a value is also bound to 4KB for the same reason.

  struct kv_store_meta {
        __u32 page_idx:3;
        __u32 page_off:12;
        __u32 size:12;
        __u32 init:1;
  }

- Growable storage backed by uptr

  To be able to accommodate future storage space needed for new key-value
  pairs or temporarily storing old and new key-value pairs at the same
  time during transition, the KV store is growable. This is possible as
  the KV store leverages uptr, which can be allocated in user space on
  demand. The current implementation supports 8 pages, but this maybe
  chanaged if it is too big or small.

- Variable-size data copy with dynptr

  get/put involves copying variable-size data between uptr region and
  stack. Since llvm does not support emitting bytecode for memcpy with
  variable size, byte-by-byte copy in a for loop needs to be used.
  This can be improved by using dynptr. Please refer to the patch 1 for
  details.

* Todo *

- Allocate smaller chunks of memory and grow on demand 


Amery Hung (4):
  bpf: Allow creating dynptr from uptr
  selftests/bpf: Implement basic uptr KV store
  selftests/bpf: Test basic uptr KV store operations from user space and
    bpf
  selftests/bpf: Test changing KV store value layout

 include/uapi/linux/bpf.h                      |   4 +-
 kernel/bpf/verifier.c                         |   3 +-
 .../bpf/prog_tests/test_uptr_kv_store.c       | 154 ++++++++++
 .../selftests/bpf/prog_tests/uptr_kv_store.c  | 282 ++++++++++++++++++
 .../selftests/bpf/prog_tests/uptr_kv_store.h  |  22 ++
 .../selftests/bpf/progs/test_uptr_kv_store.c  |  46 +++
 .../bpf/progs/test_uptr_kv_store_v1.c         |  46 +++
 .../selftests/bpf/progs/uptr_kv_store.h       | 120 ++++++++
 .../selftests/bpf/test_uptr_kv_store_common.h |  22 ++
 .../selftests/bpf/uptr_kv_store_common.h      |  47 +++
 10 files changed, 744 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/test_uptr_kv_store_common.h
 create mode 100644 tools/testing/selftests/bpf/uptr_kv_store_common.h

-- 
2.47.1


