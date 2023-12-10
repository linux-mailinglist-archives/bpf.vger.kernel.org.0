Return-Path: <bpf+bounces-17338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A671A80BA2B
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 11:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FD21F2107A
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE146ABC;
	Sun, 10 Dec 2023 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTNKbuLk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA712101
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 02:30:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso14818595e9.0
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 02:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702204242; x=1702809042; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASQFEa8YU0j++8wbTZrB7PVBLTKgEwqK4wP0FNt/vhA=;
        b=OTNKbuLkHACRiQ5m3H76U90QChFEmFMALgyjHwLBDVhLU+mS31XFXystglrfHhTeUs
         0a2A0swyUT27BnWKRWaYNetM21C8x21HhT1GrKqYcOly+huM5579Q8fXZnxpnLLwvI+M
         2ssWCq6Pw1IYBSClPpOookNTdoha5S0hy91YTj4zW66XrQYRXA0/ANOxRaGrfzNQtra5
         TLpk9qUCmCtwi6qUUTapAfJUYuNxz2wesn+nW6z0DMSEALzlVp7qkdXxjZBrHCIxfyJ6
         KuCM4aLxMiBqHqpk66tr7/DdFbwVVCMemIvMYXlnk7hYOIibk1Gn5En4jdyvLqC/IdFz
         FcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702204242; x=1702809042;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASQFEa8YU0j++8wbTZrB7PVBLTKgEwqK4wP0FNt/vhA=;
        b=P4Me2xAcS0+tiHa6ZQQEMMuQbCSir7oAFk7XXJoRnO3Exfvf8GHX7k7jSvMGDStOwH
         zYMlOfpwIr1ziLW8B/q10pXuNdjaf9Lj4IWRbWOeYHnvIEAXDc3j3tbJAhNegsVXQc4C
         fYeGgM8TozjAqP+zSx725e5eTc5AcDsymnjefKXtyg72e4pqalGfqUgXQWMBrXEUAsul
         7Qy3e6PBlitM68H0P4B++LgKu+8KH942+d1LN1adFKjE/hknUDnV6bouqfw2dV7q32n0
         EDABIbx8bs8oxzXuXRdGT9odrQfbM1/cO83LtXEdtbP4ROOwKIhbydnKDVed/TIFouPT
         3+Nw==
X-Gm-Message-State: AOJu0YzvLuwvtGmFLiSmiVBoYTXuEZk+ShEhItP9wGpnQx8WZIdc0d1V
	gxAikkbsZnBYZ+8yKoZDhQs=
X-Google-Smtp-Source: AGHT+IEekVnusrCQdqkx9Jz3CAqz8BjhCu8932HPBOn+XecuPGk4JGSPbSbp5F4g8mVEI/Et2rf5zg==
X-Received: by 2002:a05:600c:1503:b0:40c:2c5f:5887 with SMTP id b3-20020a05600c150300b0040c2c5f5887mr1246959wmg.22.1702204241897;
        Sun, 10 Dec 2023 02:30:41 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm11444693wms.33.2023.12.10.02.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 02:30:41 -0800 (PST)
Message-ID: <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, Anton Protopopov <aspsk@isovalent.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
	 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf
	 <bpf@vger.kernel.org>
Date: Sun, 10 Dec 2023 12:30:38 +0200
In-Reply-To: <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
	 <20231206141030.1478753-7-aspsk@isovalent.com>
	 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
	 <ZXNCB5sEendzNj6+@zh-lab-node-5>
	 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
	 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
	 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
	 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
	 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
	 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
	 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

How about a slightly different modification of the Anton's idea.
Suppose that, as before, there is a special map type:

    struct {
        __uint(type, BPF_MAP_TYPE_ARRAY);
        __type(key, __u32);
        __type(value, __u32);
        __uint(map_flags, BPF_F_STATIC_KEY);
        __uint(max_entries, 1);
    } skey1 SEC(".maps")

Which is used as below:

    __attribute__((naked))
    int foo(void) {
      asm volatile (
                    "r0 =3D %[skey1] ll;"
                    "if r0 !=3D r0 goto 1f;"
                    "r1 =3D r10;"
                    "r1 +=3D -8;"
                    "r2 =3D 1;"
                    "call %[bpf_trace_printk];"
            "1:"
                    "exit;"
                    :: __imm_addr(skey1),
                       __imm(bpf_trace_printk)
                    : __clobber_all
      );
    }

Disassembly of section .text:

0000000000000000 <foo>:
       0:   r0 =3D 0x0 ll
        0000000000000000:  R_BPF_64_64  skey1  ;; <---- Map relocation as u=
sual
       2:   if r0 =3D=3D r0 goto +0x4 <foo+0x38>   ;; <---- Note condition
       3:   r1 =3D r10
       4:   r1 +=3D -0x8
       5:   r2 =3D 0x1
       6:   call 0x6
       7:   exit

And suppose that verifier is modified in the following ways:
- treat instructions "if rX =3D=3D rX" / "if rX !=3D rX" (when rX points to
  static key map) in a special way:
  - when program is verified, the jump is considered non deterministic;
  - when program is jitted, the jump is compiled as nop for "!=3D" and as
    unconditional jump for "=3D=3D";
- build a table of static keys based on a specific map referenced in
  condition, e.g. for the example above it can be inferred that insn 2
  associates with map skey1 because "r0" points to "skey1";
- jit "rX =3D <static key> ll;" as nop;

On the plus side:
- any kinds of jump tables are omitted from system call;
- no new instruction is needed;
- almost no modifications to libbpf are necessary (only a helper macro
  to convince clang to keep "if rX =3D=3D rX");

What do you think?

Thanks,
Eduard

