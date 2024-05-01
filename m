Return-Path: <bpf+bounces-28399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBB8B90CD
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18D9284B6C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2A1635DC;
	Wed,  1 May 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFADdhtw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172D249FE
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596461; cv=none; b=c56uehwbH/ZdR9XZaUjj0iGtNfZSjia9hKtY6Ca0t3QhKF86zO6+nF5jzyQS3C1amdNPx/ygOIWBvaDSCNXm4a8sMZ07ykkyzcI9HFcZRW4EK6sHx1PbJ1+spNcmObWUFIcuEIRJ9TdEhMw9hN5xYv5NCMFVztk6AJJMbNLc7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596461; c=relaxed/simple;
	bh=+lHkoLIkh/q5UAg4XzIgpawF3x/g2l4cZcAAMOVnkQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dVbmlHiiNyeeDpFbZBO5kjSD7ghn81sUXkBJOrRAc53/pqSw/cTrFuG/Tsi7x0FFeN7b5YVCsuZ9VJnZPkJ9rwV30JodojitBoDSJDrMQeBViAYf2Gl3Gx2buzSu9UHLsVCupgdhSOMJ3JcZkNmoMfqeL52qoMzb5XK1c63+FWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFADdhtw; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-233e41de0caso3708492fac.0
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596459; x=1715201259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Knc3yx7uOj7ag4aHVSg3hH22zzAvF1pohXVL8duaVNs=;
        b=KFADdhtwdhrxqqktNjd7fvG8mWnb92uejDcB9Cn4jX69EK6fh7ThQ8dfxuWUcn4IVx
         oYdCx6mo5JhhX+H8LG/iVpcngRefyaF6y7lo/2SQy5No76/6dpmWHTKebIt6WsFPzwax
         mwbXPPrudKMJ+6HdzC/OCOtH1lLPg568UgMCG5qpqRaUTQWukCMfRM4TeggsVFe+X4Yn
         ZtxrKo0Eb5qmH4GyrmeuNFwDKtzZ6nLB9eF3fM0rPSFGZ/cCgm7ndJbSH7lCSR/s8T+n
         9X6NZ+wAN4RmBPnmBuDDP/MC1FtqgMiyREjA5vdmlfTqxO2BDNqvom4oOuhfrQQ4onNN
         T9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596459; x=1715201259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Knc3yx7uOj7ag4aHVSg3hH22zzAvF1pohXVL8duaVNs=;
        b=se3979ScqKwaDBykBevoWdjVgU3XlL5wSeJLrQ0XrFcvTk+Wy7v9DJ/+lsxxgukUgW
         HnQb9pvunCXltXpt/6mirkHSEDk3kIseh+WNFHpeZoFECrZvefaC14VEoGYgNVvDL+nP
         IDT24XWC//fWm3n0kW613bc3Qlsf4KgyHl88n+CEUJZ5mB6ryjKb8NGIsKaCmfMACauF
         f14egTfcyC5tjqp9GgcInXpW1gdFgqefzG3OhdHvMZ8T1BgAnhaVf8jqG7R7IZLvj0FO
         TgayESNqj1pQ9aituMCNv3W7xuWn0wgWx8GdKEcT5JtF/Q2qhAPQ8F893iWxhNYCNJYx
         8DkA==
X-Gm-Message-State: AOJu0YxHQ6TFQeW5y7lbYsL75jyh6chpHxO55Hc8llYiTMnCkd01WMkg
	hyAB5Nf23z+a+SMi9pO94g8uuRWR//OqRCIzAXgCBFiefwtKvrM8XAZdtQ==
X-Google-Smtp-Source: AGHT+IEK2ZwlMlxCTxp5wkKAGhYbLtFmESnjZArQxIp9mBFEyzK3Iq23gAMbf5y9AwxiLsU4BemmyA==
X-Received: by 2002:a05:6870:e3cc:b0:22e:a3f8:38bc with SMTP id y12-20020a056870e3cc00b0022ea3f838bcmr143687oad.22.1714596458774;
        Wed, 01 May 2024 13:47:38 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id rx17-20020a056871201100b002390714e903sm5744408oab.3.2024.05.01.13.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:47:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/7] Enable BPF programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head.
Date: Wed,  1 May 2024 13:47:22 -0700
Message-Id: <20240501204729.484085-1-thinker.li@gmail.com>
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

Kui-Feng Lee (7):
  bpf: Remove unnecessary checks on the offset of btf_field.
  bpf: Remove unnecessary call to btf_field_type_size().
  bpf: create repeated fields for arrays.
  bpf: look into the types of the fields of a struct type recursively.
  selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
  selftests/bpf: Test global bpf_rb_root arrays and fields in nested
    struct types.
  selftests/bpf: Test global bpf_list_head arrays.

 kernel/bpf/btf.c                              | 161 +++++++++++++++++-
 kernel/bpf/verifier.c                         |   4 +-
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +
 .../selftests/bpf/prog_tests/linked_list.c    |  12 ++
 .../testing/selftests/bpf/prog_tests/rbtree.c |  47 +++++
 .../selftests/bpf/progs/cpumask_success.c     | 133 +++++++++++++++
 .../testing/selftests/bpf/progs/linked_list.c |  42 +++++
 tools/testing/selftests/bpf/progs/rbtree.c    |  77 +++++++++
 8 files changed, 473 insertions(+), 8 deletions(-)

-- 
2.34.1


