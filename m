Return-Path: <bpf+bounces-17060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6E8096E6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 01:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF201C20BFA
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 00:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3B372;
	Fri,  8 Dec 2023 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0/lGtn9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805201724
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 16:05:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c0f3a7717so17528115e9.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 16:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701993948; x=1702598748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J74FOCsbk2GtrmgVJ9MX7vGaGV4a1E1quIZ7TsBkMsY=;
        b=S0/lGtn9oe5qAUrdKQV0JplDYXBrNB9M6uo9NRdhhj3lJ1axiB7Xt8ave3L+hKhml4
         xRPen8fhy7Wgn346wMgYqvn5rmEo5KZj1q0mYe33rOJivA5r9zq4+hh1KSFkFW1wD1WF
         gNCAM2mW3D/PpB2gms05+WmNFgfXPouh6qgX2ENfbKbY1NeFnA/G37VlcLZHzoYksFMO
         lyZTrbftOjNp0TLVe0A/lM82tSXvw3RfEKVlaC1MiAxlZGMmBqC7ek+D5a66lWDkRSrK
         zIwl7Yl2QhDaq6HFVU9YezupdL5Iolqwb6xC9lZxudhxRYh2koFJdY3NxPkwhArplx97
         /uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993949; x=1702598749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J74FOCsbk2GtrmgVJ9MX7vGaGV4a1E1quIZ7TsBkMsY=;
        b=LONOMeLA37JB53qDkFvNeDlAlUm+96oOidfUc7CzuFTgNn8e6OP/7+4BZ83ksQM+Mh
         hEJn4UgLj0+z6TTCTKo+ihkMxy3c/04Lmq8j+ltfYTYTsbugGsgpJWnwgXQFJNhCjZkc
         oSV6bPZhN+58mXasiNe5bwcTXQnQtBHY6ux162i6gAFdGMRuJx07Bl4asq4S3Q1Ligch
         rQp3CK8APmL6E6S/S99O4l7mWoW1+7sQLY1QuUuk9EgslLseHRDk3AQFQ7nOLqs2xD+N
         MUT1y7l1qex10BzzPKxdJwKbGd10vGVDExqiEFiiIKCFMPRBXFIpro7v0PF+g1133r2C
         J2UQ==
X-Gm-Message-State: AOJu0YwmJI0kr09/306cugJASUi/mPNvBRq0PZDreFFqEqhFzDvwOjC0
	1GkDURLFXidXamqjxfBVtimQn8sypPFO/A==
X-Google-Smtp-Source: AGHT+IFxDvWIQa8Mv+IO2xzufYmfCmbfnOJGoHPsUQF2ELgwpEieSKlP4YER+owlc0rFmgwkTkHBbQ==
X-Received: by 2002:a05:600c:4510:b0:40c:fc0:cff7 with SMTP id t16-20020a05600c451000b0040c0fc0cff7mr1185484wmo.82.1701993948483;
        Thu, 07 Dec 2023 16:05:48 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b00406408dc788sm3279155wmo.44.2023.12.07.16.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:05:47 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi headers
Date: Fri,  8 Dec 2023 02:05:30 +0200
Message-ID: <20231208000531.19179-1-eddyz87@gmail.com>
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

From my understanding, BPF programs typically access definitions of
these types in two ways:
- via uapi headers linux/bpf.h and linux/bpf_perf_event.h;
- via vmlinux.h.

This RFC seeks to mark with preserve_static_offset the definitions of
the relevant context types within uapi headers.

The attribute is abstracted by '__bpf_ctx' macro. 
As bpf.h and bpf_perf_event.h do not share any common include files,
this RFC opts to copy the same definition of '__bpf_ctx' in both
headers to avoid adding a new uapi header.
(Another tempting location for '__bpf_ctx' is compiler_types.h /
 compiler-clang.h, but these headers are not exported as uapi).

How to add the same definitions in vmlinux.h is an open question,
and most likely requires bpftool modification:
- Hard code generation of __bpf_ctx based on type names?
- Mark context types with some special
  __attribute__((btf_decl_tag("preserve_static_offset")))
  and convert it to __attribute__((preserve_static_offset))?

Please suggest if any of the options above sound reasonable.

[0] https://lore.kernel.org/bpf/CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com/T/#m4b9ce2ce73b34f34172328f975235fc6f19841b6
[1] 030b8cb1561d ("[BPF] Attribute preserve_static_offset for structs")
    git@github.com:llvm/llvm-project.git

Eduard Zingerman (1):
  bpf: Mark virtual BPF context structures as preserve_static_offset

 include/uapi/linux/bpf.h                  | 28 ++++++++++++++---------
 include/uapi/linux/bpf_perf_event.h       |  8 ++++++-
 tools/include/uapi/linux/bpf.h            | 28 ++++++++++++++---------
 tools/include/uapi/linux/bpf_perf_event.h |  8 ++++++-
 4 files changed, 48 insertions(+), 24 deletions(-)

-- 
2.42.1


