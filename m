Return-Path: <bpf+bounces-29420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233888C1BE8
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E631C218FA
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055F13A87A;
	Fri, 10 May 2024 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+vOykjc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C7137907
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303597; cv=none; b=VDX7iqeu3QwG3RP93d9zcQRMKUeBar/AqjWUKbLMx59SFhygmCSQ9DiSy9UmgKY0AwZNGhw5VVmM7WHt3ZKHDj0+L6G2ULCkn2up5P6AyAWSbwdMFcDieIcKLAmnumwbaNSKgwY+1o45BwWdV24+wJwInjZcRpd57AlheVKri2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303597; c=relaxed/simple;
	bh=OMfUM+oVH+GAFE7dcKPWUnu20R8fFAi2vjp344H583I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r8NEny/rwfME6JRiUmvFgoBtdHCVRKSOxfTK6g3HXHfrzam53yTtfB/Kei/Q4a4xe12YA+AbO8FCE6q2Z5FaCkA+JbTLepD9OW8J9yRrsKDmaZ/V5yB3MOMUfM8CmE7s/CNhHPHhHFja6cAw4zL53vdm8I85yT044wY59+KtvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+vOykjc; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-240de3847cdso778864fac.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303595; x=1715908395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znk2MCClYX7eFQ8nfJntTqBtL23fcZP2oB9Vi8ynH0g=;
        b=K+vOykjcN0YjOFHOfsZjRfFlk3XNBzKAKbHXqEAFHFCkaEA/FZwEjgzWPMkDe2f0AB
         ib08sfDjZBZeulzNZUDPVKGIDxkjivZhrupusdK+zBOVI4ECdJPnLsixBeqpzG7TdIoy
         Xcl+1s/8PMMJ8T5FsM2mlZIefi+mxmPpV8eHmz68LD5VcMyNUEYRv6vrBWQpWlE3jN+s
         IICWqybTaQu9zUa8Q4qgErgvIKlkODqkeWCNT7l3/8gvxVTfn3EvYI/akulp2gQcC0/Y
         KbkhVodJ/9F5TOl27NzHLvNG8EVBqsb6sMUoyZbzaA8sxHcCOYZAWtReel4bRVgLmCwY
         Vw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303595; x=1715908395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znk2MCClYX7eFQ8nfJntTqBtL23fcZP2oB9Vi8ynH0g=;
        b=OTryOR+d1/oYFWMo3B6Zn+yPt4cJuq0DVPL2TCpgStWlEVPVSWpWVOarvtCbw/7TKR
         2jCI/1WpFi/Jati0xGlHRHtOssGLqhmp00fKNMsjVNTnEcgkBAkC+H87BAwRRWp7zwKd
         bwe469MXWEXZzTbQ89/4pflMK38R0ZmtA/TDHV30RiGJHkN/XnPxNO0EwoT3VNBpwRMv
         T2hts90RS2ya8R+ExxlYh4up6/jYlf87Z68Zbj1CTIQSD2PjJZqQA8frs44onir0Z3xh
         zuVwE+y2+z0NmIXptCRO86NCsEkRDAsFohLe3FZZmRnZ69BvkmSafyCJga+IZcg/Xgyf
         N2ng==
X-Gm-Message-State: AOJu0YxKV8ph1fQ6kZkZ5sEefcT4XdCrPVG95S1pFUziiNNJ6moS3z9i
	7ZvtiNnAfVjIUZvaZTQh//67M8rK89gzLhjWsxKllTGoYHnhSjen4+JEqA==
X-Google-Smtp-Source: AGHT+IEANL1iF+McMQbvVyUW6ZR5B2W9S3COW/K/lTRVQfKSwlmtcCiPtGKMIWRubfCP8u64QD+m9w==
X-Received: by 2002:a05:6870:a68b:b0:22e:93a0:fcbb with SMTP id 586e51a60fabf-24172911422mr1430753fac.34.1715303594964;
        Thu, 09 May 2024 18:13:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/9] Enable BPF programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head.
Date: Thu,  9 May 2024 18:13:03 -0700
Message-Id: <20240510011312.1488046-1-thinker.li@gmail.com>
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
Changes from v4:

 - Return -E2BIG for i == MAX_RESOLVE_DEPTH.

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

v4: https://lore.kernel.org/all/20240508063218.2806447-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240501204729.484085-1-thinker.li@gmail.com/
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

 kernel/bpf/btf.c                              | 305 ++++++++++++------
 kernel/bpf/verifier.c                         |   4 +-
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +
 .../selftests/bpf/prog_tests/linked_list.c    |  12 +
 .../testing/selftests/bpf/prog_tests/rbtree.c |  47 +++
 .../selftests/bpf/progs/cpumask_success.c     | 133 ++++++++
 .../testing/selftests/bpf/progs/linked_list.c |  42 +++
 tools/testing/selftests/bpf/progs/rbtree.c    |  77 +++++
 8 files changed, 517 insertions(+), 108 deletions(-)

-- 
2.34.1


