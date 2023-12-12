Return-Path: <bpf+bounces-17480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E680E1EA
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CAD28276B
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 02:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D31FCF;
	Tue, 12 Dec 2023 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG/kfzl4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BF2132
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-336166b8143so2618399f8f.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348339; x=1702953139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpYJFVRPKcoumNOI7sbxOJ0way3A03nHX5bM9O5R3qo=;
        b=aG/kfzl4tGhFuBNs/32sDxusOnmfBWE2JKm8R3B7SZfF/fs8cOV9JGjNEh1FMsIWY3
         r6IxmRlQhRS+Rb78OS8FuLDhaAU/7OioF6Oraq+lwkKapdVG5BB6CRrClK9F7M+bDiDm
         LBwyjbIqfuLOgGupvw1HBJBLbLBVyUdjUb+AapRiiGiG2QkkPEqqLUmH54eNoU5Cxr4x
         rq8KmEi0PqKnJcaLfedjPp7PEQrm4HOJn8jKxZwDUmcy2tQatgpTwKQRZ7AQDV3CWBHo
         K5wu+1e1J4tnc+R4xfRHu+2z06CtMyKu2FMtIEqraTKAznYrXHqjqrVWUy84RG4mtaq0
         /edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348339; x=1702953139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpYJFVRPKcoumNOI7sbxOJ0way3A03nHX5bM9O5R3qo=;
        b=ELYz6XUwJ9C8TSqnhEAIB+xF3QlfDQIHqUBxZfwF7sb4+TZzGoLu6FlYh+ZC+yq6gY
         ufjQz79GpQypdsj25CL3JZ5+UrSv68O31VjO1EM05hje4LXJ2b3S/FlfONi/t1IEfj46
         +UvMCUv0s5uLcK7qw3PaW5OjvBOKWvP2DHgGr7lLGzHLbjSalYqMXCJM44OVn8aolr00
         rf0mHo1pnYmyyly6icfWnoYoemV6MWSEsd2EFAGvPuKMI3monLvtZg9VkDUbNIxPjd+B
         gs80vmRfL/NeoOcek266jjoRnptJhfsHLVdxWAOgmqj2AbTqCNGT6ui5O6gjM5RXTisD
         kW7Q==
X-Gm-Message-State: AOJu0Ywi2boSy35ExUlnDx3FWT2BmvKnYHyS76x9rGxHUG99jbIM9KB9
	xwTChL53tb1xN63kFVTLNjCGZyvfOIE=
X-Google-Smtp-Source: AGHT+IHenEh3t3hLK+VBLYw1dZiDtIrHRnGpuyQWanQJh2BYMot5JGo9TUL1haWXQ/MpgwE5QaFE5Q==
X-Received: by 2002:adf:f68b:0:b0:333:39a8:bddd with SMTP id v11-20020adff68b000000b0033339a8bdddmr3193221wrp.117.1702348338615;
        Mon, 11 Dec 2023 18:32:18 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e12-20020adfe38c000000b003332fa77a0fsm9659900wrm.21.2023.12.11.18.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:32:17 -0800 (PST)
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
Subject: [RFC v2 0/2] use preserve_static_offset in bpf uapi headers
Date: Tue, 12 Dec 2023 04:31:33 +0200
Message-ID: <20231212023136.7021-1-eddyz87@gmail.com>
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

For this transformation to be applicable access to the context field
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

For context types that are not subject of the
convert_ctx_access(), namely:
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
- V1 [2] -> V2:
  - changes to bpftool to generate preserve_static_offset
    (by hard-coding context type names as suggested by Yonghong
     and Alexei, including BPF_NO_PRESERVE_STATIC_OFFSET
     option suggested by Alan);
  - added "#undef __bpf_ctx" in relevant headers (Yonghong);
  - added __bpf_ctx for the missing context types (Yonghong);

Eduard Zingerman (3):
  bpf: Mark virtual BPF context structures as preserve_static_offset
  bpftool: add attribute preserve_static_offset for context types
  selftests/bpf: verify bpftool emits preserve_static_offset

 include/net/netfilter/nf_bpf_link.h           |  10 +-
 include/uapi/linux/bpf.h                      |  32 +++--
 include/uapi/linux/bpf_perf_event.h           |  10 +-
 tools/bpf/bpftool/btf.c                       | 131 ++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |  32 +++--
 tools/include/uapi/linux/bpf_perf_event.h     |  10 +-
 .../bpf/progs/dummy_no_context_btf.c          |  12 ++
 .../selftests/bpf/progs/dummy_sk_buff_user.c  |  14 ++
 tools/testing/selftests/bpf/test_bpftool.py   |  61 ++++++++
 9 files changed, 270 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_no_context_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_sk_buff_user.c

--
2.42.1

