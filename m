Return-Path: <bpf+bounces-21569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F884EEC5
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8101C24353
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB84C9B;
	Fri,  9 Feb 2024 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDWSC0M6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8084C80
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444059; cv=none; b=X843Q3I4+kkD8msz5yltZsmFk0BZVJwDX2eJcmvMpoycDMuPJEt3OHFA/+KhZdghSwVXNQUAD+Vg4KSiA+oHviwWmHgJwjeAvInBUD7MjNct/5056x7WYxqlfp+8RRblCLqXWvWSh/BXWNkVs7xPpZ/3ByCzbDcIvE0c90eMsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444059; c=relaxed/simple;
	bh=5RpSlsQyOL8c2yPMtoRv8h3W4FVjqf0dKelG6tBMRS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q6Fuznhn9lC/LwPaEBGhtVQiBXO8iC0SJmYMAgrSE5njnn2Ws1LOk6dxmiKUqhMhgme9pG+3e+0oUPRW9P4AgMdfs0O6pwXJV6+T87qJdRxJv/7J6r4OXtGQSRKOmMLlUIDJ+LWNQGpp4I1ALQ0ZRCd1guA3bfAxHrJEjGGC0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDWSC0M6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-604a20f86f9so6119287b3.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707444056; x=1708048856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBCUrZgw0hM6wFM+2B1dXSyVJU8jdftWXXBlfElT6Fw=;
        b=CDWSC0M6PPeYCTD1k4oDA6gRvwWslGs9Zk4ThGku7unTUcQM3jH4G7OkZzFQIgJCDL
         kStnsRa2xc0U3RhMdWKW1JMcS0zSOJjKIgikgd68949PUQMxgBUg6DRWWD8EwKiqWLDe
         UBCjb/IlszfHyo+46zveHf3VBgFbjJqLAn5TM5LcDHwC2KKz1Ed65LOFLXUA9DSwtPPx
         5p5YXTyzJrPQ/rMtxM7UwRuS53tyvLhPegRBPzpAbSZLb1e+OGiMJAVr1Tg7KYCrf6do
         /sZa84/J4lwRVX26e8sGyXt82aNLcz7TJPmA1Yq9k8Y9YMjOwFgu+fjWPlV6k4jYDzHF
         TV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707444056; x=1708048856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBCUrZgw0hM6wFM+2B1dXSyVJU8jdftWXXBlfElT6Fw=;
        b=LWFXfmW5uGE9ZEPJKw1xiwCLlUJZZ3hTFOgMaNwHNGqQVCNZVpPAXzFzyjYxmo6QHU
         waEyLuf8+slT5hiLgEBbyXsKsz5STu2shrwy6oPC3YPQWoTs8GcrcMXsHUK3Fy7SMABG
         UmMv0Z/BHNHsoIaRkhfgdo46yfOBr3X+zUbSrUSZylM6mKp5t9R7vicFbjSRnfQAT21n
         QqNY1xZE7k2w7Niamc62qPvPEJi6RWfbQoCbS/qbyIZtv15PO+DGnKXH+2TC/3eN0+b9
         qlVpH2Yk7zcpohOt09PalVWpmNr1xWLxwTe+z9Pm7J4BsDvjnIVgGYVRkNzCIz9HWqpO
         dVdA==
X-Gm-Message-State: AOJu0YwN8odi6f1iK8JreNBviUQQbVIdX3ZfVe+xsUnNoniVNjX25bI1
	NG3mCMWiCimf40pTQoRR1QpniRFgP/9CQZ5UtLfMiW7RkVES4cR6ghdVEpXtCGs=
X-Google-Smtp-Source: AGHT+IGPT5TSGZ2nRMG7CpNZcXH5R4fcbxyrWKrCbQUTgiVcKv4BUj9DBPn806F78YW2vfiRv14pMA==
X-Received: by 2002:a81:de4f:0:b0:5ff:fdd5:d368 with SMTP id o15-20020a81de4f000000b005fffdd5d368mr199004ywl.44.1707444055850;
        Thu, 08 Feb 2024 18:00:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqHv9ce4um+qaOKoZ+HHzEiMZqqDlH8MQ52gYxgyccVDUq+VKOdQE7K+cpKtQA/xhyXma9II0RBhJavFzM8mUKvj/dzh3ixvIwRuRMNxvfmUreyUc5DJ3IFtgiqz4oD7gTZ+tfsmP5B8K+F7u0LqHh6EvqHcAEdbgcDNrdHjxMuxM6vy+kPBvADhAEwYHndbHmsA1HnwqvTB5C8MfesU8JluGrg4E8GTipX3MftK64EGemAohK84Qfszzpfsg5GgMTXp1gUhntgcrDh39kLVWAuIfM2+wqfcBf9XEOIy/4WZ8=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id h123-20020a0dc581000000b006041f5a308esm134982ywd.133.2024.02.08.18.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:00:55 -0800 (PST)
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
Subject: [PATCH bpf-next v7 0/4] Support PTR_MAYBE_NULL for struct_ops arguments.
Date: Thu,  8 Feb 2024 18:00:49 -0800
Message-Id: <20240209020053.1132710-1-thinker.li@gmail.com>
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
Major changes from v6:

 - Remove "len" from bpf_struct_ops_desc_release().

 - Rename arg_info(s) to info, and rename all_arg_info to arg_info in
   prepare_arg_info().

 - Rename arg_info to info in struct bpf_struct_ops_arg_info.

Major changes from v5:

 - Rename all member_arg_info variables.

 - Refactor to bpf_struct_ops_desc_release() to share code
   between btf_free_struct_ops_tab() and bpf_struct_ops_desc_init().

 - Refactor to btf_param_match_suffix(). (Add a new patch as the part 2.)

 - Clean up the commit log and remaining code in the patch of test cases.

 - Update a comment in struct_ops_maybe_null.c.

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

v6: https://lore.kernel.org/all/20240208065103.2154768-1-thinker.li@gmail.com/
v5: https://lore.kernel.org/all/20240206063833.2520479-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20240202220516.1165466-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240122212217.1391878-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240118224922.336006-1-thinker.li@gmail.com/

Kui-Feng Lee (4):
  bpf: add btf pointer to struct bpf_ctx_arg_aux.
  bpf: Move __kfunc_param_match_suffix() to btf.c.
  bpf: Create argument information for nullable arguments.
  selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.

 include/linux/bpf.h                           |  22 ++
 include/linux/btf.h                           |   6 +
 kernel/bpf/bpf_struct_ops.c                   | 210 +++++++++++++++++-
 kernel/bpf/btf.c                              |  47 +++-
 kernel/bpf/verifier.c                         |  44 ++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  13 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../prog_tests/test_struct_ops_maybe_null.c   |  46 ++++
 .../bpf/progs/struct_ops_maybe_null.c         |  29 +++
 .../bpf/progs/struct_ops_maybe_null_fail.c    |  24 ++
 10 files changed, 403 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

-- 
2.34.1


