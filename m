Return-Path: <bpf+bounces-21284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1359B84AE6F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE22286AEB
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340E12837C;
	Tue,  6 Feb 2024 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5/xaVSB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A641802A
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201519; cv=none; b=AE8RQQ5OyTg+LDSIGmmSfE+i7u1bcXgkGPyXseSg0GweIzZYIBZeZwrspeGD7WeV0ZJBKGKNRQQt8TbV7YJ8TwGU4S7Tt272UtkkrczdKepx3KOZuyIHVH5uukU8Qm2vsm6Xe7wKoOoEcrzY88WdvF8vHQr+Zws1AGIGqdGxrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201519; c=relaxed/simple;
	bh=/6ejPhGpd3Ur6G0inhLoCAgZ+tthFmIXJTuUBaSxYWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nUiob8DBL5ICM4V6ePoLkeOet2Ah6i30R51ofMKH42p175PnQYzlV3ksK9ayjaejbdY12L93KFi6yLSpCUOmIeSTxI8Nj7DGbAZnEibtnkJPS4WGDbjHcUgKXplmFan8NDHhv4Nz/uB8QykLggfQ5UZJtmAW9ZOtbe8JomYSuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5/xaVSB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60403c28ff6so58535357b3.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 22:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707201516; x=1707806316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGuhu/hkOFBz/4TltsARr6VFkoYTj2gkLLsTzuLwCiM=;
        b=m5/xaVSBzB4dQaSVe4Kx0xCStoa0VqSyx9yHF/lXNvugc9UzPIprC4VrOKaUgl37wG
         Vv1YgFkqOc8E3HcfCTZRwONA/nt8NEU5ZFcA+OIvxBPcgB3NU0HlIQaJQVwO3KW7lf2g
         EkbaExWxOUME5jNp+c3lz3TRDF0CaF3dhjapFP1Lf8SBoTimBPEOZIKK8Auaiw8tN8GT
         ZwkVlRYJQVR9WUg9zSyGfxnqwqvCUB1pkPoNSNkZakB3r0suGza4yh5+p6Nc60NGMTTy
         H+21haaNeikpBzbLJFkorkYI5V6ha+fQwf6g+jPrrJdnZp70dVLe1MlVOu8KriBSmKOc
         8r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707201516; x=1707806316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGuhu/hkOFBz/4TltsARr6VFkoYTj2gkLLsTzuLwCiM=;
        b=rcOWnfGvwfE3keDXdwkvGYuCHeYwwgZ//eCPgKS8pnM8og4stkKJSAfoM9zabRquqD
         WuQCklxHWe4v+Tvuwa/5nc4MuTGKNIFpqaDjITnlHM+IjkOHYN76nbbcavjuZiSJIRlA
         JY42avfZt0iPoIywiX3TghmSTqdaiEswGdLSM+pp8eQ1TrRADhgU+NNq5z+cxEtYZx2G
         VMRHwBKlQ5d5tyO/aV0JmKjYng6VyD4/TFoxJHmBwLmX7Armi0wN3wQaotjkyUTI5/rs
         tO723uXom9CF8Qrht/2ZdRj/tQf15Oskc1z2qc5l9YbgSwX9dSahSfoV4Cr+8tZgfqAS
         pVlg==
X-Gm-Message-State: AOJu0Yw/Ie53wR+x94ff7ri6zUkW+GkvxcZA2cPF3Tg9Ibi6QTuTTAy6
	XZBDOC3447plC1hTTAQvzOyZZODtyiNEi7Qi3h4M62Pmr6wxIZ+iGHRv6AhkT9U=
X-Google-Smtp-Source: AGHT+IEPscmAJ0qgehqR4JQUDhksOtTVQW+1PM9oqvmaC2HAkl3iLWxkFK+k2GI6gR9kd27m1xYnkQ==
X-Received: by 2002:a81:e203:0:b0:604:6aed:e27c with SMTP id p3-20020a81e203000000b006046aede27cmr792211ywl.16.1707201516359;
        Mon, 05 Feb 2024 22:38:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVmZiA3yx1Kp+RtZ1FyZ/ZYWrvWMvCb8qZryW0JAJ5hf36UEMYptDjzuu1kc0IRC2SiG825ea+w2nvI1aBSCTWewkrf1h3Uc/ehIFFjWs6r/oVYZ5rwysgpqs8tz3GApPSOEfpjTX73mImgajNBvtnw3nWmLLYxsZ/TxOiHgo8HOs7xoU8SJqPAUOhsrUf4XWDMhmi4wXa1aOpeihImjYI3VVYb02y9VvSxxtf0Ot6s+KO6VkMpV8gX0mdqAieeCzYL34puHajktoo3GgJLpskWkllpbGp6Dt9I554CssDVho=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3a27:6d1a:7c79:c81e])
        by smtp.gmail.com with ESMTPSA id ez9-20020a05690c308900b005ffb91a94e6sm64277ywb.59.2024.02.05.22.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:38:35 -0800 (PST)
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
Subject: [PATCH bpf-next v5 0/3] Support PTR_MAYBE_NULL for struct_ops arguments.
Date: Mon,  5 Feb 2024 22:38:30 -0800
Message-Id: <20240206063833.2520479-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Allow passing null pointers to the operators provided by a struct_ops
object. This is an RFC to collect feedbacks/opinions.

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
                                              struct task_struct *task__nullable)
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
Major changes from v4:

 - Remove the support of pointers to types other than struct
   types. That would be a separate patchset.

   - Remove the patch about extending PTR_TO_BTF_ID.

   - Remove the test against various pointer types from selftests.

 - Remove the patch "bpf: Remove an unnecessary check" and send that
   patch separately.

 - Remove member_arg_info_cnt from struct bpf_struct_ops_desc.

 - Use btf_id from FUNC_PROTO of a function pointer instead of a stub
   function.

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

v4: https://lore.kernel.org/all/20240202220516.1165466-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240122212217.1391878-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240118224922.336006-1-thinker.li@gmail.com/

Kui-Feng Lee (3):
  bpf: add btf pointer to struct bpf_ctx_arg_aux.
  bpf: Create argument information for nullable arguments.
  selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.

 include/linux/bpf.h                           |  19 ++
 kernel/bpf/bpf_struct_ops.c                   | 185 +++++++++++++++++-
 kernel/bpf/btf.c                              |  42 +++-
 kernel/bpf/verifier.c                         |   6 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  12 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   7 +
 .../prog_tests/test_struct_ops_maybe_null.c   |  47 +++++
 .../bpf/progs/struct_ops_maybe_null.c         |  31 +++
 .../bpf/progs/struct_ops_maybe_null_fail.c    |  25 +++
 9 files changed, 365 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

-- 
2.34.1


