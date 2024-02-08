Return-Path: <bpf+bounces-21481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B039C84DA5F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F3F2871E7
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B2692EE;
	Thu,  8 Feb 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq3jHzXn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715969975
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375070; cv=none; b=bVMstljBB/yKxDY4UBSAqDP3ikeoqJLbcjKRThIG1XfhpVngx7vlTWEq6XUfgkc43S2IcK6f8nJkWAWL2aJSbGzIw7Z7JtSbsmFadQo9XRgbi33E0S+AkyKJloFoq8YotFgM3x1pNw18fgiS9tM3b2o6KOH1wDExUz9vsmXTDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375070; c=relaxed/simple;
	bh=nCCz8n5qaDg6icX3dDRqQKmvEF7x39MELeUs5IcvGG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OcxkmlueYgDzsx+oGa/cV5YJ6Lu+ZSZpTwuXph9F+tTnKcUvZ7R4fEngi37KFc4ABwKH1Ea2Cca8QCxO2LHWC/Coh1dlYXOMaCvjpkNcxw76qwpC6iAuh4pZ9zo6+lLxWYp0xpNmy81LPgXCzD75xyryExlM4M15I9Uk3zghHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq3jHzXn; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604aaf2d047so1278617b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 22:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707375067; x=1707979867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XMKJbcNarsMWRGUlPDkeorNmMQ3GfwLxkCxPNKWwm0=;
        b=Qq3jHzXnowy7TR0kjlVViAtwpI01+jfE6DiHfyuaPtXnKMpDT16pxFdCh4x3Bmva1B
         LVPOOAtFCn3Il4l5XcFGVQjtPCPH4/HllWZqq1+xsWo0ynUid/H5qJ1F8tfE+rcY+f53
         9rlA/Fs+o3d2wlKz9PZWYPHY+ZPWDoRs3P/9DiTJANXl8MdutSfkUj1bt6O308d58PwQ
         LXbXivi5iNH0X+ap+fB4p56/l7e5pp8faBaee+caY54/lCihvWFQ0a6K/YDpY4nABiVx
         kR/WnvIJV1AeloWbcKdd6QCMWF1M4G88H8YB5UnGHz/RrgCfbyxvsDoM+pSYvMm+HHM2
         Wueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707375067; x=1707979867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XMKJbcNarsMWRGUlPDkeorNmMQ3GfwLxkCxPNKWwm0=;
        b=Y5VCdNfeKvJYyajY3L0zzVbbpfLbd3QHILo46oQ6s0O2Fzkz3siVlFpYCYLIlflkzF
         9hIOJXGDto+y51pmJn6J5YaLfXtlvByJAD063fV9yL5BFIDwKSgzq5Jo9/R2Z+BSScUg
         cm+NbGJHfURqW1M6Dlr1RiaRCSiFbdnKEPHDfiZlUlTrqDWHmGdJN2QwvaMtIh3UHNAj
         EL5MXvHdXsWKwpEQyWmB0vvW8xFhgbbcXgcWdKtTLxf/LclzCDKuZT2SagHimO9wGCeM
         RgCfRaecDxCbmgegINTfXj5KCm6+ttGNfDUOAUUYF4hIvK9F061yGwaC07KPPCexdTP9
         BFbw==
X-Gm-Message-State: AOJu0Yxtzt1bFZpWF2me+SCVwTktQmH/ekz/ww/bp5SvVc6d7dEv1Ga/
	oSQGR8Oj65Feu7C0lLLFV0tZbaHfOGsD1C9Alxc8XJEgSmgjCfgcD7VqlT+tgiE=
X-Google-Smtp-Source: AGHT+IHi1KmRT6MI34hpRfh5EHZW542QD6tdPmh7kce0qdQ4eUyQsV1mXLs6eRxqJ18V3G/B9iRlQA==
X-Received: by 2002:a81:738b:0:b0:604:9d77:3a0 with SMTP id o133-20020a81738b000000b006049d7703a0mr3050570ywc.49.1707375066630;
        Wed, 07 Feb 2024 22:51:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7S0CXfciORQBaPOoc3R63XH7Rkf2ZmmNMIul3BVYZlph0xv92fepEf/i5G0DtfqzIKeq4BjLp+U8YBjiamtlYAPahStDZ2QGbKcKfVXvxYE5uhmIvjRYHLPyoBvIrrp4nEEVzBUq1vWFg/QHCyuNFhXCREkdEk+mqWJQhKUyN2yuPZ8I1DLay5Hh8e9ezriI/98Ujp3yU7C9cH67smHtnU6SUqKg2QAWFuq4Vi9azHohfna1qxRQPxbJru33NR/CAWQ8k0wgRdrpg6HBuylghbzC8FjBQq60iTWLvGy5YUUo=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1d02:e957:f461:9a61])
        by smtp.gmail.com with ESMTPSA id u203-20020a8184d4000000b0060467650c64sm596917ywf.62.2024.02.07.22.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 22:51:06 -0800 (PST)
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
Subject: [PATCH bpf-next v6 0/4] Support PTR_MAYBE_NULL for struct_ops arguments.
Date: Wed,  7 Feb 2024 22:50:59 -0800
Message-Id: <20240208065103.2154768-1-thinker.li@gmail.com>
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

 - Rename all member_arg_info variables.

 - Refactor to bpf_struct_ops_desc_release() to share code
   between btf_free_struct_ops_tab() and bpf_struct_ops_desc_init().

 - Refactor to btf_param_match_suffix(). (Add a new patch as the part 2.)

 - Clean up the commit log and remaining code in the patch of test cases.

Major changes from v5:

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

v5: https://lore.kernel.org/all/20240206063833.2520479-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20240202220516.1165466-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240122212217.1391878-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240118224922.336006-1-thinker.li@gmail.com/

Kui-Feng Lee (4):
  bpf: add btf pointer to struct bpf_ctx_arg_aux.
  bpf: Move __kfunc_param_match_suffix() to btf.c.
  bpf: Create argument information for nullable arguments.
  selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.

 include/linux/bpf.h                           |  23 ++
 include/linux/btf.h                           |   6 +
 kernel/bpf/bpf_struct_ops.c                   | 197 +++++++++++++++++-
 kernel/bpf/btf.c                              |  53 ++++-
 kernel/bpf/verifier.c                         |  44 ++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  13 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../prog_tests/test_struct_ops_maybe_null.c   |  46 ++++
 .../bpf/progs/struct_ops_maybe_null.c         |  29 +++
 .../bpf/progs/struct_ops_maybe_null_fail.c    |  24 +++
 10 files changed, 402 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

-- 
2.34.1


