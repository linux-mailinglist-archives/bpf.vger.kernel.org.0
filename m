Return-Path: <bpf+bounces-21576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B9184EEDF
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7602E1F23804
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A2139B;
	Fri,  9 Feb 2024 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv/6uzer"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF24A24
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446276; cv=none; b=ULoqpS2Z0ZLI4qF8m42tmj3fCJNafnEBIKjyN8/0HwgHEbd7qoBBCb4X5MoQdPjw2oJx06AlJIOsI07tjOzYuRAptqUIrc7rZ8Im6eequyICE0hSKwSWCGI2lxEWoHXpwZ4Zpw6ujeA9NK+TVE7H7RFbMgmQIMzhV7LIZeg+gH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446276; c=relaxed/simple;
	bh=3Xnz1ggjW7sMIKtuSAU0oeskiZEsWoq0TiyZslTMFJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYQBhvbs8WtDBQ7nuGjYUOt64k1anGA+cGTUjvfJoRjZQeVUFbyc55+ltwB0sd/VX5OQBPkc/rOwA/5hqZ8nC1z4MwPLEkn99ZsenmhLhW/UxwKqXkwQeM71iSxlO9Xk2+wRbFjJ5uVNL3qWM25T+KZQQLA2nX7gX0EYJlBgC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv/6uzer; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6049ffb9cedso6632597b3.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707446274; x=1708051074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+FOQ+9ErVMSlAa5pFZMOs7kv7Wj4+OF4Cybjf4W4sU=;
        b=Wv/6uzer3W5cnZTiwESKES0luRKrgO3owmcfQ1aP7dn5mqEbH6pdqK5/k9Zqa4zVoA
         Dzs4mcO/d7AFnbtN0qOQSx4W7cVxtZp/5UWoYxkrJoUhN98fOWHwUDOQ9wRnAxvnGazC
         x7QIU4HXqF5nzb0F5AyJgK4d9nIFyc7bdiBHYGXiORC6WdzJPtPQPK8ZAbqR9wF6cVvi
         quXdQ1Nw40BtgVMRMrfK3gnxkk9PTLc4IxDFsvPrB2xEAkW/oQ8EcP7nCBLl41n2XqVH
         kD5hMmYh2QEmX9SkqtMxBcX0NgBLfqsmdM+C0vPci/k6RecPjiFDN7/yIjZLEb9cTQ1o
         ew5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707446274; x=1708051074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+FOQ+9ErVMSlAa5pFZMOs7kv7Wj4+OF4Cybjf4W4sU=;
        b=YH/7kXEnqxoJZu2W0qva+A4QuTo9j93XytrAJ3/mMwwRxD1s3u+n4wg25b7o58LIpl
         rR2zbOGRiq5a/R/izNxezJn7XRuPZn+kQ7yqdVpn2k/cID3lj5QqAqqLxzSsXO92q64n
         7nX0+zbRDDcI6dVg/HXkyFTBp+xB7Tw/pv8tcpCMnLtdXWVThBgBQZm172ETT8ZBTaho
         vlp/ESnqmu/gIE+KkS3PP5PIF1TnLjNsJoO3upMOz0Ctc/T48Go9kGVExsz6Xj/S/Jxd
         BnlM/VvYsXSmbQBozCeJbScpFc9tWyQwvTINKyHLoM5T8iKU21CDZLC6wuCzcZfOpo4P
         9r1g==
X-Gm-Message-State: AOJu0Yxby5WtypMZ+sfOvCU9uXFFlsr+wCscqsxcSRii2jEH9QIgZFPb
	Wow84qBGnVMXznwgBNRCkwxyiUeFPi76eFK8QyTv81340ovvifbWAv5suQJp6Kg=
X-Google-Smtp-Source: AGHT+IEanoYTy+rlo1Xq/S8POjYBWX0quxcLWDo07ogomAA3m5imc4QspzsWU1ehKBtZmx7nDd89ew==
X-Received: by 2002:a81:a50f:0:b0:5e8:8c2c:3d7e with SMTP id u15-20020a81a50f000000b005e88c2c3d7emr197841ywg.37.1707446273626;
        Thu, 08 Feb 2024 18:37:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLX0zUpnc9IGKieoJGJCITnaC7jM8iQgattO3oBcdc/lGDlF9CxcTGe1YPOVGXH+bP5wEBX2xiwLxVy8FgcFJqmnL0IluIXH9kLg/IEUkGdTBFd3aznNNPfZeS6+D0FOFyiPqxQrj5cnqUPWTL6TjE1/+lQmbBsoyJBss6ETJeF9gqr7r51orIbt2QQi7f2XBddm0QnTbICAKxy9kMIc7iEFiLXVxMLEnEBfPDh+MqeOslOPLL3MHam42QvaARzsnJyEfPX7TqaC1lkzVhURTaEW0GIQInRzQlzgUC6KFl9CE=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id i2-20020a0df802000000b005ff846d1f1dsm144949ywf.134.2024.02.08.18.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:37:53 -0800 (PST)
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
Subject: [PATCH bpf-next v8 0/4] Support PTR_MAYBE_NULL for struct_ops arguments.
Date: Thu,  8 Feb 2024 18:37:46 -0800
Message-Id: <20240209023750.1153905-1-thinker.li@gmail.com>
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
Major changes from v7:

 - Update a comment that is out of date.

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

v7: https://lore.kernel.org/all/20240209020053.1132710-1-thinker.li@gmail.com/
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
 kernel/bpf/bpf_struct_ops.c                   | 207 +++++++++++++++++-
 kernel/bpf/btf.c                              |  47 +++-
 kernel/bpf/verifier.c                         |  44 ++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  13 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../prog_tests/test_struct_ops_maybe_null.c   |  46 ++++
 .../bpf/progs/struct_ops_maybe_null.c         |  29 +++
 .../bpf/progs/struct_ops_maybe_null_fail.c    |  24 ++
 10 files changed, 400 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

-- 
2.34.1


