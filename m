Return-Path: <bpf+bounces-30411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427F8CD93E
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD5328382F
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044413EA66;
	Thu, 23 May 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw+sYIW5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D012E75
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486129; cv=none; b=ERuciSPg9KZvbrw4pOlq4+RB80e0p6qSvEmLTnDBQK3R8rUWFnWverJhY7QRw0E9msoGKIv4JsEmQND/c6m5T8bPCg+B0aM2E5HCIfX9I4zdRoj9lDibR/xSfcu/GWvFKw1Ng7M7AnKF3zP36eNOW9FhaeOfUVfnz6E1A4BsvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486129; c=relaxed/simple;
	bh=27/Bj3jvCkTTM7IlvEJLsqF5mrKyuFWUyk/jxPDJuv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFFGQYEvvYok48O1rdgW4QMMaaudz29zxbCMDjKxM9DX1gHBH6trEm8aYSTIDTRX36OsiCbrXTQTvbqkiHqtS6sfOfB6Xjr9ywKDRvOiEp2BUvTOt2cElNPWZdTLmW1rrLaC61Djh9wUtTcyo+n6UW8XnM/kwjmcFSCdPm19kxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw+sYIW5; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-628c1f09f5cso11536607b3.1
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486126; x=1717090926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9AuNRUvCwaQbHmr5og6PA+dTEy3hc+c3d8G7FOtsvs=;
        b=Dw+sYIW5N6jfW1bGSqm5KVn9Sfyp1ED6d+/wZD/0lvDcfnxPqrhO0B26uMuro08JlJ
         fa8g8eWKf8rWyBZFiZc2dEWFXP9EvcQu9JuwA6h9C2sFzH1+czfAGcySuEej694V0Ti1
         aDkyI4DK0iNpD1FAjUq7Tnl1d2ZlPYrOdWgSckvqdIf3Rx2vRM+DiXrim2VHIPo+APOd
         dJ3/hoXyDgtGKrm2O3Q4IVt02ZKXGZaRQJc1hlHcAWSB5RQpzS3RsAG1jzxApDDXjV8M
         CQmDehvrPsATfsXDtFvQeS4SgDRhZxCpEHmOh34hAq+HQ/GQ7RNjGV4dRWuChSjHFWHH
         L7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486126; x=1717090926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9AuNRUvCwaQbHmr5og6PA+dTEy3hc+c3d8G7FOtsvs=;
        b=Smn4ikKJowlGuTXt6A+lk8I0sJM0QwPTLBqj4GNDp+R/GGlql4i9qFqRJs6A/Zdddv
         YSL27ZETNPP6jW92cb4EI06hEruzSjrVz+vLXeo3bxjlHaujlMe4gEghQBS6tciCu5nq
         Fbf7TirpOygv4optSWBl6O2h+arQJZnS3/tpShwJ5/c/IR8wdU6azizjO7I5DilKo8ek
         zGhhmwH7SH307BMrQz/ogB+ErCRKvZcpPLHHEhBDtm5ioV7GdsDFihkQazdW/NUDumJD
         /LayP0qMZDwOM8YbBl8aFjxTbXOoQZWLNR6/tpsSw/masEN/idBD6LmNmM1w7y2ZS2pg
         MJjQ==
X-Gm-Message-State: AOJu0Yxqm7lWNQK1q2ZQsGnXgU5wrO1/3MaaVvW/CX1+ErlM98X10fx3
	DRO0WkuUM86CeNL0elyjJpQxL7DQ804aSQZFNfAayL45jX2Q09fadgGgTw==
X-Google-Smtp-Source: AGHT+IE3n0aFKrEPJF6U4CUpusSLAR8GdN5fs94QpQN7yQsXFjNtCX35fbknkhdiPPSRiijz0lcOvg==
X-Received: by 2002:a05:690c:f16:b0:615:800d:67b2 with SMTP id 00721157ae682-627e46d2ca5mr85342967b3.29.1716486126053;
        Thu, 23 May 2024 10:42:06 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:05 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 0/9] Enable BPF programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head.
Date: Thu, 23 May 2024 10:41:53 -0700
Message-Id: <20240523174202.461236-1-thinker.li@gmail.com>
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
Changes from v6:

 - Return BPF_KPTR_REF from btf_get_field_type() only if var_type is a
   struct type.

   - Pass btf and type to btf_get_field_type().

Changes from v5:

 - Ensure field->offset values of kptrs are advanced correctly from
   one nested struct/or array to another.

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

v6: https://lore.kernel.org/all/20240520204018.884515-1-thinker.li@gmail.com/
v5: https://lore.kernel.org/all/20240510011312.1488046-1-thinker.li@gmail.com/
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

 kernel/bpf/btf.c                              | 310 ++++++++++++------
 kernel/bpf/verifier.c                         |   4 +-
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +
 .../selftests/bpf/prog_tests/linked_list.c    |  12 +
 .../testing/selftests/bpf/prog_tests/rbtree.c |  47 +++
 .../selftests/bpf/progs/cpumask_success.c     | 171 ++++++++++
 .../testing/selftests/bpf/progs/linked_list.c |  42 +++
 tools/testing/selftests/bpf/progs/rbtree.c    |  77 +++++
 8 files changed, 558 insertions(+), 110 deletions(-)

-- 
2.34.1


