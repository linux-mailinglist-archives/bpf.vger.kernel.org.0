Return-Path: <bpf+bounces-29018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C058BF644
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE78B21507
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13317730;
	Wed,  8 May 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvTatprD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4A4C6B
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149945; cv=none; b=N6m+FUi7sg0Mn8kNkMaXEEiTHvjHrrgMPz3jjqffWXHjuqNBt9FKd9VqDBMqE4ivb70edlEouoEqQdw+zrQ5j07mrg9gDenV53CE8+iNAUNsO43UZd9CQ/xuCexfv74j634Aqyb9Mymvv1vXzXFOg3zTiJ8adKXx/8+VZpc5E7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149945; c=relaxed/simple;
	bh=9rrHtPVv/gLG8XTIobQZAa31FU7h4bYtepCYDoNHK3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ly/Y1JDPoM4Yd4KaXnLOGAqomtNgr9SbrvFgS7Ur20TnaZdObGPdIe5Xoze7GutwcWXTHroh/fM3Ihz3CAaPZmAMMYICp4IEdwDvZwZKqVOiA7DaBeHYBtboiE1Ng18GR72U6IIuIcpb3ChVe7jWKzU5h9cATNB5vBtGKrv9i6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvTatprD; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23f2996b634so2216051fac.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149943; x=1715754743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFH/hrys97GhIaTClTV3M0sNg/m9KdKJCKlEuOhnpaI=;
        b=HvTatprDxxWEtO9RnqMmutpUAkRkm5RW2prCDpRGZhIFHHpmRHB5YSpw2wqIDmhdGf
         zy1NzZkT6LP6mmBNeu2U9Q7FLF1exgLtkTw8MzIYMC3SQ2Gso7aJTy3LYgM5v0Qm9lCi
         Y3ChZ7NgumJj7sfmJB8+6EVEa/CHZ2oNnctxTYqTGV/bjjZ5xLILfimUBMBttTaKOt2y
         4uJSHuos80+SVfeZwtN3UV6N2S6mugeZ241R2SIAn3zL8Pa14u6ThcNnVOdGZT38XetR
         A+9V+BrtA+2p91DSlbE+Fkv4KALImALFhdbY2k7dvpiDMBf+jbU96z7P1N8jwQVP2g6N
         0SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149943; x=1715754743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFH/hrys97GhIaTClTV3M0sNg/m9KdKJCKlEuOhnpaI=;
        b=HwGjDNojOxIJ0qFFBog4vHB8OJCLVmQtiLvWwyo2+yb6AIJy5bcCxxLDmkTGMOCNxH
         1zvrsdjIjRtF5a7IHUYbaiQeANRf5f0D1ReSVH+WX4cm8sdkbLEoH3vmc+3KOkUejrWc
         roAtrttMnlzd/jWB0eB6CqqL0ehCzzpG2MMLYMFlfi+NWZ5kkgja6Ht3gZ9njCRo4tOu
         zXy99u/Z04vbfh3CAO9Pr4ooNYO26drfCZdBKdRimZLkJA7nqT8Z7Fhzv5NWeXE3wAqk
         V1UnuLzKy9SpDWAwtLuGrs41jgS1p9jx74vB+PtRTFbTbp1YJgZw9o2qpeZwD71p1SNT
         D8gA==
X-Gm-Message-State: AOJu0Yyx+TSAiWQG9R9CBhkYDm9ZTQd7/SnEDTg52KlRR6xJN+X+EC0N
	L6yNkJPhw5wJRYB2ElMv63HAsKtNgvuHo8AphGHdptYAtCWQjxW02XDODw==
X-Google-Smtp-Source: AGHT+IEuvIprKa/vWDoW1/lXOJ1+++gyRdviM4HhGRkh+5aEgn0MW6atd7TtS8TDKhOcSJ/VVw+X2Q==
X-Received: by 2002:a05:6870:7309:b0:21f:d2a0:60f with SMTP id 586e51a60fabf-240989079cdmr1908172fac.51.1715149942669;
        Tue, 07 May 2024 23:32:22 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:22 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 0/9] Enable BPF programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head.
Date: Tue,  7 May 2024 23:32:09 -0700
Message-Id: <20240508063218.2806447-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some types, such as type kptr, bpf_rb_root, and bpf_list_head, are
treated in a special way. Previously, these types could not be the
type of a field in a struct type that is used as the type of a global
variable. They could not be the type of a field in a struct type that
is used as the type of a field in the value type of a map either. They
could not even be the type of array elements. This means that they can
only be the type of global variables or of direct fields in the value
type of a map.

The patch set aims to enable the use of these specific types in arrays
and struct fields, providing flexibility. It examines the types of
global variables or the value types of maps, such as arrays and struct
types, recursively to identify these special types and generate field
information for them.

For example,

  ...
  struct task_struct __kptr *ptr[3];
  ...

it will create 3 instances of "struct btf_field" in the "btf_record" of
the data section.

 [...,
  btf_field(offset=0x100, type=BPF_KPTR_REF),
  btf_field(offset=0x108, type=BPF_KPTR_REF),
  btf_field(offset=0x110, type=BPF_KPTR_REF),
  ...
 ]

It creates a record of each of three elements. These three records are
almost identical except their offsets.

Another example is

  ...
  struct A {
    ...
    struct task_struct __kptr *task;
    struct bpf_rb_root root;
    ...
  }

  struct A foo[2];

it will create 4 records.

 [...,
  btf_field(offset=0x7100, type=BPF_KPTR_REF),
  btf_field(offset=0x7108, type=BPF_RB_ROOT:),
  btf_field(offset=0x7200, type=BPF_KPTR_REF),
  btf_field(offset=0x7208, type=BPF_RB_ROOT:),
  ...
 ]

Assuming that the size of an element/struct A is 0x100 and "foo"
starts at 0x7000, it includes two kptr records at 0x7100 and 0x7200,
and two rbtree root records at 0x7108 and 0x7208.

All these field information will be flatten, for struct types, and
repeated, for arrays.

---
Changes from v3:

 - Refactor the common code of btf_find_struct_field() and
   btf_find_datasec_var().

 - Limit the number of levels looking into a struct types.

Changes from v2:

 - Support fields in nested struct type.

 - Remove nelems and duplicate field information with offset
   adjustments for arrays.

Changes from v1:

 - Move the check of element alignment out of btf_field_cmp() to
   btf_record_find().

 - Change the order of the previous patch 4 "bpf:
   check_map_kptr_access() compute the offset from the reg state" as
   the patch 7 now.

 - Reject BPF_RB_NODE and BPF_LIST_NODE with nelems > 1.

 - Rephrase the commit log of the patch "bpf: check_map_access() with
   the knowledge of arrays" to clarify the alignment on elements.

v2: https://lore.kernel.org/all/20240412210814.603377-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/bpf/20240410004150.2917641-1-thinker.li@gmail.com/

Kui-Feng Lee (9):
  bpf: Remove unnecessary checks on the offset of btf_field.
  bpf: Remove unnecessary call to btf_field_type_size().
  bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
  bpf: create repeated fields for arrays.
  bpf: look into the types of the fields of a struct type recursively.
  bpf: limit the number of levels of a nested struct type.
  selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
  selftests/bpf: Test global bpf_rb_root arrays and fields in nested
    struct types.
  selftests/bpf: Test global bpf_list_head arrays.

 kernel/bpf/btf.c                              | 303 ++++++++++++------
 kernel/bpf/verifier.c                         |   4 +-
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +
 .../selftests/bpf/prog_tests/linked_list.c    |  12 +
 .../testing/selftests/bpf/prog_tests/rbtree.c |  47 +++
 .../selftests/bpf/progs/cpumask_success.c     | 133 ++++++++
 .../testing/selftests/bpf/progs/linked_list.c |  42 +++
 tools/testing/selftests/bpf/progs/rbtree.c    |  77 +++++
 8 files changed, 515 insertions(+), 108 deletions(-)

-- 
2.34.1


