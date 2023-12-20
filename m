Return-Path: <bpf+bounces-18380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6889819FDA
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2E91C2224A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9802D639;
	Wed, 20 Dec 2023 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEeYvOF/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44A36AF0
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553eb74df60so605572a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703079262; x=1703684062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tlj3Z37x4Lh7ukk/9bezq6tpGSwDJWTHQGdeWlDcsMg=;
        b=FEeYvOF/H1EcZApxg4LizwUKfQVu3ekjzyi+mupItQ25DYZYOKjyqXp3k6RErgKNxL
         H00ygwZ7A6pURc8Im4hqhTpz8dwBttflXKKtEGXt9NIg690YlkypHoGqslHlhmhqJ1K2
         ydkoDASrGK5/GyF4wBGSueGTRjN/xqiA8wzEPgfXGn50wP/kJXjIipjxIxyRrNy9viyk
         MG+2vsS+HqGWD6TjuK2zsVGMhO0x90EjvbWE647uZhojJX33hnA4Fvuf1vuY3vD4TF0u
         GONyCyu07m+AmW31p3bhUm9p3hmcCWzXRGB8Tm899yxnIb+xUtBHwRD7EcidGP6wwLGO
         7wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079262; x=1703684062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tlj3Z37x4Lh7ukk/9bezq6tpGSwDJWTHQGdeWlDcsMg=;
        b=UyD0nkyGp3WvDHkaHQZPQD2478KX8NfRBBpCV+zt0VWF5Ny/urNkaucmHOBS6xkgKy
         2tO2ujy+ekCGoXFYugmU/zAQAnwWMtuRLQxsghICg84IvFfWF1o3Lc0x1XpaPSRl175z
         aw3o3vRr/1E9BMgG8T1MQBlc4fSkHKv5aQp9Oa7z+w79dmPqVJ4WL7iHhnQpZikjPfqd
         GX6AhFSJ1F6IZcCPvUZJjn15b8Vo8hW/hfm04duc94v6J9gXGSRGeM8m7QT+3bPVMZc0
         L2bEoamjN0ASYbyWXlwc1/5aiWTWJa6H0+ilwir3t3fCoQODmUgM4YWklU3oIc0KqHvw
         0Ynw==
X-Gm-Message-State: AOJu0YyzvY6N4Omkcx40EwxoXcT6CVY67PuoPob47vB8GmMbFYt1YM4X
	PCDHKvZGvtQziheB4I1rtoCMy7clUOQ=
X-Google-Smtp-Source: AGHT+IG/veNq2bBHNzgw2RmOxNtMF9rHkrlPhw6Rxtmx++qBifpscSFRU85Reoy0g57a1Fud7uhYzA==
X-Received: by 2002:a17:906:1d7:b0:a23:6bc9:40ac with SMTP id 23-20020a17090601d700b00a236bc940acmr1760088ejj.102.1703079262259;
        Wed, 20 Dec 2023 05:34:22 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vs4-20020a170907a58400b00a22fb8901c4sm9951032ejc.12.2023.12.20.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:34:21 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC v3 0/3] use preserve_static_offset in bpf uapi headers
Date: Wed, 20 Dec 2023 15:34:08 +0200
Message-ID: <20231220133411.22978-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For certain program context types, the verifier applies the
verifier.c:convert_ctx_access() transformation.
It modifies ST/STX/LDX instructions that access program context.
convert_ctx_access() updates the offset field of these instructions
changing "virtual" offset by offset corresponding to data
representation in the running kernel.

For this transformation to be applicable, access to the context field
shouldn't use pointer arithmetics. For example, consider the read of
__sk_buff->pkt_type field.
If translated as a single ST instruction:

    r0 = *(u32 *)(r1 + 4);

The verifier would accept such code and patch the offset in the
instruction, however, if translated as a pair of instructions:

    r1 += 4;
    r0 = *(u32 *)(r1 + 0);

The verifier would reject such code.

Occasionally clang shuffling code during compilation might break
verifier expectations and cause verification errors, e.g. as in [0].
Technically, this happens because each field read/write represented in
LLVM IR as two operations: address lookup + memory access,
and the compiler is free to move and substitute those independently.
For example, LLVM can rewrite C code below:

    __u32 v;
    if (...)
      v = sk_buff->pkt_type;
    else
      v = sk_buff->mark;

As if it was written as so:

    __u32 v, *p;
    if (...)
      p = &sk_buff->pkt_type;  // r0 = 4; (offset of pkt_type)
    else
      p = &sk_buff->mark;      // r0 = 8; (offset of mark)
    v = *p;                    // r1 += r0;
                               // r0 = *(u32 *)(r1 + 0)

Which is a valid rewrite from the point of view of C semantics but won't
pass verification, because convert_ctx_access() can no longer replace
offset in 'r0 = *(u32 *)(r1 + 0)' with a constant.

Recently, attribute preserve_static_offset was added to
clang [1] to tackle this problem. From its documentation:

  Clang supports the ``__attribute__((preserve_static_offset))``
  attribute for the BPF target. This attribute may be attached to a
  struct or union declaration. Reading or writing fields of types having
  such annotation is guaranteed to generate LDX/ST/STX instruction with
  an offset corresponding to the field.

The convert_ctx_access() transformation is applied when the context
parameter has one of the following types:
- __sk_buff
- bpf_cgroup_dev_ctx
- bpf_perf_event_data
- bpf_sk_lookup
- bpf_sock
- bpf_sock_addr
- bpf_sock_ops
- bpf_sockopt
- bpf_sysctl
- sk_msg_md
- sk_reuseport_md
- xdp_md

For context types that are not subject of the convert_ctx_access(),
namely:
- bpf_nf_ctx
- bpf_raw_tracepoint_args
- pt_regs

Verifier simply denies access via modified pointer in
__check_ptr_off_reg() function with error message:
"dereference of modified %s ptr R%d off=%d disallowed\n".

From my understanding, BPF programs typically access definitions of
these types in two ways:
- via uapi headers linux/bpf.h and linux/bpf_perf_event.h;
- via header include/net/netfilter/nf_bpf_link.h;
- via vmlinux.h.

This RFC seeks to mark with preserve_static_offset the definitions of
the relevant context types within uapi headers, and modify bpftool to
emit said attribute in generated vmlinux.h.

In headers the attribute is abstracted by '__bpf_ctx' macro.
As bpf.h and bpf_perf_event.h do not share any common include files,
this RFC opts to copy the same definition of '__bpf_ctx' in both
headers to avoid adding a new uapi header.

Note:
This RFC does not handle type pt_regs used for kprobes/
This type is defined in architecture specific headers like
arch/x86/include/asm/ptrace.h and is hidden behind typedef
bpf_user_pt_regs_t in include/uapi/asm-generic/bpf_perf_event.h.
There are two ways to handle struct pt_regs:
1. Modify all architecture specific ptrace.h files to use __bpf_ctx;
2. Add annotated forward declaration for pt_regs in
   include/uapi/asm-generic/bpf_perf_event.h, e.g. as follows:

    #if __has_attribute(preserve_static_offset) && defined(__bpf__)
    #define __bpf_ctx __attribute__((preserve_static_offset))
    #else
    #define __bpf_ctx
    #endif

    struct __bpf_ctx pt_regs;

    #undef __bpf_ctx

    #include <linux/ptrace.h>

    /* Export kernel pt_regs structure */
    typedef struct pt_regs bpf_user_pt_regs_t;

Unfortunately, it might be the case that option (2) is not sufficient,
as at-least BPF selftests access pt_regs either via vmlinux.h or by
directly including ptrace.h.

If option (1) is to be implemented, it feels unreasonable to continue
copying definition of __bpf_ctx macro from file to file.
Given absence of common uapi exported headers between bpf.h and
bpf_perf_event.h/ptrace.h, it looks like a new uapi header would have
to be added, e.g. include/uapi/bpf_compiler.h.
For the moment this header would contain only the definition for
__bpf_ctx, and would be included in bpf.h, nf_bpf_link.h and
architecture specific ptrace.h.

Please advise.

Changelog:
- V2 [3] -> V3:
  - bpftool now generates preserve_static_offset when
    btf_decl_tag("preserve_static_offset") is present
    (as discussed with Quentin);
  - bpftool now correctly filters BTF types that need preserve
    static offset annotation when commands like
    "bpftool btf dump map pinned ... value format c"
    are used;
  - changes in __bpf_ctx definition to include said decl tag;
  - test_bpftool.py extended to check for preserve static offset
    in "bpftool btf dump map pinned ... value format c" output.
- V1 [2] -> V2:
  - changes to bpftool to generate preserve_static_offset
    (by hard-coding context type names as suggested by Yonghong
     and Alexei, including BPF_NO_PRESERVE_STATIC_OFFSET
     option suggested by Alan);
  - added "#undef __bpf_ctx" in relevant headers (Yonghong);
  - added __bpf_ctx for the missing context types (Yonghong);

[1] https://clang.llvm.org/docs/AttributeReference.html#preserve-static-offset
[2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/
[3] https://lore.kernel.org/bpf/20231212023136.7021-1-eddyz87@gmail.com/

Eduard Zingerman (3):
  bpf: Mark virtual BPF context structures as preserve_static_offset
  bpftool: add attribute preserve_static_offset for context types
  selftests/bpf: verify bpftool emits preserve_static_offset

 include/net/netfilter/nf_bpf_link.h           |  12 +-
 include/uapi/linux/bpf.h                      |  34 +++--
 include/uapi/linux/bpf_perf_event.h           |  12 +-
 tools/bpf/bpftool/btf.c                       | 135 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  34 +++--
 tools/include/uapi/linux/bpf_perf_event.h     |  12 +-
 .../bpf/progs/dummy_no_context_btf.c          |  12 ++
 .../selftests/bpf/progs/dummy_prog_with_map.c |  65 +++++++++
 .../selftests/bpf/progs/dummy_sk_buff_user.c  |  29 ++++
 tools/testing/selftests/bpf/test_bpftool.py   | 100 +++++++++++++
 10 files changed, 418 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_no_context_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_prog_with_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c

-- 
2.42.1


