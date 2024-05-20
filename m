Return-Path: <bpf+bounces-30042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5138CA366
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BC11F21CBE
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D1139584;
	Mon, 20 May 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYqXzhHl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E30D27A
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237624; cv=none; b=Bv2Hpsu5d8x+EXF3oQgHc92SfDKMxaYfYlxdY37wyhbCDuY84aCiQRhI+rW7GfFm6n5TjyroNRcWjd2lBFdscHq1OjSWFGSH6nCDCxn1vJhs8ZKcuLtYt8dQ6iC3PItQo8mE3s+tlu7LbpKxsUxYWru5wU325uNWeuSsdSYhXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237624; c=relaxed/simple;
	bh=Z34m4hi6lSARnzUiceNp7Vp3JSZg1ZSz/+i8V0HQ2K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HtS+LHH4y1xHzP6g99yYJolsC5EemYseG0hVbNRv57/XiO/qKkH0F5rPXFuq3kljV98XIkWJ91iiO8yBQTN288vi7IcHDx9/8o2oo2wW3JWajJRzAehq+fbvSc7WIDYGZ001jodWOhtjidMpM1XVGTXvI1UWxpo7//OIvKGIf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYqXzhHl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bec6bab2bso32194467b3.1
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237622; x=1716842422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FUQnvBPVqNsatIXrl6th39bMh0UfEcy11SlYemx7Bg=;
        b=KYqXzhHlMwmxbY0Ol6NtzJzQLqszYZFex60NfU8v5dxuVZI2mD63J0hNQ1Ic2kame/
         KRKg0k9CT3Wf8Eh1IcyE4hkU88mSB0wjyIBh6UXsVyigzqOuVnPn0qm/m0R4CIp9EdlA
         GUweFNUcw6iHIENtdCbtt1T9oTzRxkfkcNhJFBWgm5fCiXAkj4k98yKYbRLnWy29k1Bx
         /xubEksHdyxX5M/dgpTHW6ljoZKVReB4n53UwMxkoCj9m+Yz19PVKb2seCs7tADpE/yS
         vv9atSnfNKxzKxklnICuw2L4mnTwsT/Ve2DOuosedxh2SYwwf2wALDcq6q7jxo9WWy0y
         HNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237622; x=1716842422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FUQnvBPVqNsatIXrl6th39bMh0UfEcy11SlYemx7Bg=;
        b=OpyTWTuhLfG/JEWStnRi35WAXXLcFANs0upgU6Cj8OJqQ9koBCjBAuVjJWaKw6FnCC
         kW18tCurBpT892MonlQK3jYUPIu5HQAKnCbTzA4+hde+uGlpviZytEWFIFGZ1jumTnB2
         MVkvjlsYLrEd2ECd0fbewiGnhGe+2DwSz0ZB+0SBkDAgF54NmdSQK585QwUbHAbwenfy
         x99tlbo5Psc6FZWZo3RRZys70Pw5ngh/h4kKjeReS0VO/Q1qFICYw19f9nuxzG9iwiRd
         DbVh22wh4nmqpF5wcR7ajbpeMJTwfGWF0MOOwIP7rPx7SLUXMH4M96jTQNr54/84JRfc
         FSCA==
X-Gm-Message-State: AOJu0YzZMfx1n15ige9n1OwsO5a3rymH9x7TVha0K0HCgCIBKloM0fSC
	9jPcIjK7DXaykeTLdK9/SPkFKHbTzKqj5iLzISARosyQDLznPTftCL1eIw==
X-Google-Smtp-Source: AGHT+IFOiGlblgIkWZ6kArjvv3+HQW4vMwsE7IZYeGoM7JBm3voaCumru5OpL9HVqiroc1IpUXSBkw==
X-Received: by 2002:a05:690c:6d0c:b0:618:9025:d313 with SMTP id 00721157ae682-622aff3c08amr313090187b3.3.1716237622002;
        Mon, 20 May 2024 13:40:22 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/9] Enable BPF programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head.
Date: Mon, 20 May 2024 13:40:09 -0700
Message-Id: <20240520204018.884515-1-thinker.li@gmail.com>
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

 kernel/bpf/btf.c                              | 305 ++++++++++++------
 kernel/bpf/verifier.c                         |   4 +-
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +
 .../selftests/bpf/prog_tests/linked_list.c    |  12 +
 .../testing/selftests/bpf/prog_tests/rbtree.c |  47 +++
 .../selftests/bpf/progs/cpumask_success.c     | 171 ++++++++++
 .../testing/selftests/bpf/progs/linked_list.c |  42 +++
 tools/testing/selftests/bpf/progs/rbtree.c    |  77 +++++
 8 files changed, 555 insertions(+), 108 deletions(-)

-- 
2.34.1


