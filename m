Return-Path: <bpf+bounces-21091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E9847C0A
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ABC1F2D905
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CE8592A;
	Fri,  2 Feb 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbgqXi1+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CC136981
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911522; cv=none; b=Un0D/6VtuC7SWGhlYs/CAyU6SvACGuqkGWzwCp8w5fzjXxDIY/hNDm9Kgyf7ymR9w6KG2ZAqiCzr43+7Dgcem8fI36GNlQ4pMrbgck1XnpWKJI2jCUvvU0CT2P5FwXQVA8vQQgke0q+WsC3kyfD9RIVHOz45bHWw1JbqxYsN41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911522; c=relaxed/simple;
	bh=yt06Pt1WqJK4cmdjKNejb5oJjDn6ypc543cbUyL7fl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQTr/32Hm6YQntFk1UHuEwz6K11vH2I0Q5FTl7mm9HTtuUoVAfdlFqrh8heDQ16ARnTjKtpSUQVdRGEnwwXZTle05e49JgqE8noKkgyYNYk1K5RzPufV0mui1M0K+oPvPHAlSfS4QeV7kcrecKVIVVY28hpPmUT1RdMoUxy9wBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbgqXi1+; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-603c5d7997aso23830717b3.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911519; x=1707516319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DrOqBaxly16qzhq+b1K5iNtYW3MXVRJH/9ceMzvXqxM=;
        b=hbgqXi1+w3Sj9Wmma/DTtHPv7Cn+4q87kDwVUsnUagBgK65LHChyUBRAX3hf5EVJhT
         yLJGN/1BfrQ2S5mNh8Os/ytYZHUkBQcdbGldmeW6jYB9uZAfFeLxIYvc88qa52TwiJHk
         tf8cqcB086njrYTY8Xm3IO2Jtw5UdnFaNcigx6nsmWyJqP/+Iy1JH/KrN2J2N1zS+7s1
         XD50/ebECeGcbldhW0NKaxaxleNVbvBVePDhbE4sk05wS9jqN/+3UFLMncutRKZGkEua
         ppniOIugmyWyPLk4Cl0hv1S9VnfuFT3CdeMIzQ4bAkAE8R0Ebga0erL0fB7bfo/cPDvS
         wZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911519; x=1707516319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrOqBaxly16qzhq+b1K5iNtYW3MXVRJH/9ceMzvXqxM=;
        b=Ct/POvxr0XsQ7mncQjuus9bIKjl4liLMA8UMZBVemG/lDifF+/9D0C8zQGFYf/MIEu
         6nYJywJh68bY6rOdQIUIIH2hmz3IoBbfPnR0idL8HX6D+TcMVaeZ1IOJ2vSUE+7+tUrd
         WO1pT0zkF7eFfEVrqxGvLWgEfM5JQoS3LDFoAf6H3VZSNfw9EgMPV8/1k3j9RgkOSKLS
         q7Nmou5nCn1SnDkzMqIhzd2X/FsSwIaqvkEGqxh12Ldv39Uc5FW4h5z7Muk84huTgJ4M
         tcy78wZVkWtoU0310r81OIhPrVY6wmMS+VgRWxKHjIwmuDdRpIxDnccZo48oYg8Ptldx
         uZ4Q==
X-Gm-Message-State: AOJu0Yw8lW3oaKW67l5cVueJbHjAd606XCoEIx3BTN79Vfj+l/HL7R15
	lA/LIX2OPVKaE3qXqe4mRltb06XX1Zf8dN0gLZJ2I+LCmjxqVHL01P+y9gevg5c=
X-Google-Smtp-Source: AGHT+IESDF76e/UMKyoS0xv4JmF4Xv2uqJqnC+ug23yHOq3Ybg8ZsKPV8H4gMqGNreEFTww8BbJJzg==
X-Received: by 2002:a0d:e241:0:b0:5ff:846c:7084 with SMTP id l62-20020a0de241000000b005ff846c7084mr3909859ywe.26.1706911519413;
        Fri, 02 Feb 2024 14:05:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFkUrXMkmG49DO8g9fj5BofS7XZUpmIRMN1aOGo+ZGPZ6flTYd5qUeIuaLMFZ+DTiOEp4sxuBlRh0Dx+oyFeyF+g1KMIAbn5J4ePd6hgAd/GTU6GYEjGdJ5z8Cr2yJM9AWqwyRPLawl4n/WfrTJasNMGhfj1JnvazjRqyVLdFonartwo+ylqkfsj5CI/zq4pFGzytTccs03se9XldpxebRfyP75osEcjFDIo+Nav/ML1Rt5aYOaJWtlVEB7uYAkN3tOpY2I3riaaGlPhxNldlgQgOQazDFmCHP7A27v4c7ZzI=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id z70-20020a814c49000000b006042345d3e2sm630696ywa.141.2024.02.02.14.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:05:18 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 0/6] Support PTR_MAYBE_NULL for struct_ops arguments.
Date: Fri,  2 Feb 2024 14:05:10 -0800
Message-Id: <20240202220516.1165466-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

With this RFC, I specifically need comments/feeback on the part 2. It
extends PTR_TO_BTF_ID to support pointers to scalar types, enum types,
pointer types and array types. The purpose of extending PTR_TO_BTF_ID
is to support pointers to non-struct types as nullable arguments of
BPF struct_ops programs. Is it a good way to do it? Other options?

Allow passing null pointers to the operators provided by a struct_ops
object. This is an RFC to collect feedbacks/opinions.

The previous discussions against v1 came to the conclusion that the
developer should did it in ".is_valid_access". However, recently, kCFI for
struct_ops has been landed. We found it is possible to provide a generic
way to annotate arguments by adding a suffix after argument names of stub
functions. So, this RFC is resent to present the new idea.

The function pointers that are passed to struct_ops operators (the function
pointers) are always considered reliable until now. They cannot be
null. However, in certain scenarios, it should be possible to pass null
pointers to these operators. For instance, sched_ext may pass a null
pointer in the struct task type to an operator that is provided by its
struct_ops objects.

The proposed solution here is to add PTR_MAYBE_NULL annotations to
arguments and create instances of struct bpf_ctx_arg_aux (arg_info) for
these arguments. These arg_infos will be installed at
prog->aux->ctx_arg_info and will be checked by the BPF verifier when
loading the programs. When a struct_ops program accesses arguments in the
ctx, the verifier will call btf_ctx_access() (through
bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_access()
will check arg_info and use the information of the matched arg_info to
properly set reg_type.

For nullable arguments, this patch sets an arg_info to label them with
PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifier to
check programs and ensure that they properly check the pointer. The
programs should check if the pointer is null before reading/writing the
pointed memory.

The implementer of a struct_ops should annotate the arguments that can
be null. The implementer should define a stub function (empty) as a
placeholder for each defined operator. The name of a stub function
should be in the pattern "<st_op_type>__<operator name>". For example,
for test_maybe_null of struct bpf_testmod_ops, it's stub function name
should be "bpf_testmod_ops__test_maybe_null". You mark an argument
nullable by suffixing the argument name with "__nullable" at the stub
function.  Here is the example in bpf_testmod.c.

  static int bpf_testmod_ops__test_maybe_null(int dummy,
                                              struct task_struct *task__nullable,
                                              u32 *scalar__nullable,
                                              u32 (*ar__nullable)[2],
                                              u32 (*ar2__nullable)[])
  {
          return 0;
  }

This means that the argument 1 (2nd) of bpf_testmod_ops->test_maybe_null,
which is a function pointer that can be null. With this annotation, the
verifier will understand how to check programs using this arguments.  A BPF
program that implement test_maybe_null should check the pointer to make
sure it is not null before using it. For example,

  if (task__nullable)
      save_tgid = task__nullable->tgid

Without the check, the verifier will reject the program.

Since we already has stub functions for kCFI, we just reuse these stub
functions with the naming convention mentioned earlier. These stub
functions with the naming convention is only required if there are nullable
arguments to annotate. For functions without nullable arguments, stub
functions are not necessary for the purpose of this patch.

---
Major changes from v3:

 - Move the code collecting argument information to prepare_arg_info()
   called in the loop in bpf_struct_ops_desc_init().

 - Simplify the memory allocation by having separated arg_info for
   each member of a struct_ops type.

 - Extend PTR_TO_BTF_ID to pointers to scalar types and array types,
   not only to struct types.

Major changes from v2:

 - Remove dead code.

 - Add comments to explain the code itself.

Major changes from v1:

 - Annotate arguments by suffixing argument names with "__nullable" at
   stub functions.

v3: https://lore.kernel.org/all/20240122212217.1391878-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240118224922.336006-1-thinker.li@gmail.com/

Kui-Feng Lee (6):
  bpf: Allow PTR_TO_BTF_ID even for pointers to int.
  bpf: Extend PTR_TO_BTF_ID to handle pointers to scalar and array
    types.
  bpf: Remove an unnecessary check.
  bpf: add btf pointer to struct bpf_ctx_arg_aux.
  bpf: Create argument information for nullable arguments.
  selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.

 include/linux/bpf.h                           |  18 ++
 kernel/bpf/bpf_struct_ops.c                   | 185 ++++++++++++++++--
 kernel/bpf/btf.c                              |  83 +++++++-
 kernel/bpf/verifier.c                         |   6 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  23 ++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  10 +
 .../prog_tests/test_struct_ops_maybe_null.c   |  61 ++++++
 .../bpf/progs/struct_ops_maybe_null.c         |  41 ++++
 .../bpf/progs/struct_ops_maybe_null_fail.c    |  98 ++++++++++
 9 files changed, 500 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

-- 
2.34.1


