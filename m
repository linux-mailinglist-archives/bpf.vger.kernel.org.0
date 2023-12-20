Return-Path: <bpf+bounces-18421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E381A791
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 21:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120F4B23EB8
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E21487B4;
	Wed, 20 Dec 2023 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsFOp8wg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04E4879E
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2358a75b69so11022166b.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703103549; x=1703708349; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y2UZCUgS/FwiHH80VPz3kQUKybpXGfMuVngN2unU37o=;
        b=hsFOp8wgiiLrd0l1967Gpf6cZKShjE6ZSfZlAjjtwbOnoCFkPAk57qOFMZSu0hP4or
         MwXGa74UIIzJN7R8ICdvPWTJZ0qxLc9KLYk334HxS0dcVuSRz1H7Vw//hl/QkA/Q1DAq
         VKZTjAAUnA53SvOL9j4gnCkUJ7Ot/H+NbNN5w4y3Go+onj9/6tTids5iXBGIMpAMqNs9
         /LWm6ybiKjYdnCjKWCeOKKoa8hKCz3ytO6VMif9m9sj40AZrCcU3YT6xRYCZuyFl42cw
         Zq6B6LQExy3oUAsNK5P+Q0+FYu/LLVPr4bh0RsRXZOVSuMvHPTWsZYz5wM0VUdCrSdzz
         CmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703103549; x=1703708349;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2UZCUgS/FwiHH80VPz3kQUKybpXGfMuVngN2unU37o=;
        b=GDZ7LwbYKNlzKb2vX+hG6FKL2A70gYO5BTeNBTE7CNaZHEzMuPSekGoaEBFrmmKcfs
         gzR9S8MUTJSHZIvS/T70jfOERRDEk/pqMi/ODKuhd/iOo3QfhRNmSn+Nav9fbQoF7Wgi
         wTZl+xF88uw0bNpFMCi7yKhaWadWwvlJBlmkFKIpvzYoZp5qJchAANk7S53DRgdLv5/9
         bK3PLNb006Z43xEjPNXoxEcFPki9kBj2w6StlCGNSjCcOxizgHd3qYxh6XDdIEMwYQ+L
         nM065hW3LRzfpPFmEm9PYu1YurjD+HLw4mSOR2qAJ8dbfvr46eD4hKjtODyRvXQzPAuH
         yW9A==
X-Gm-Message-State: AOJu0Yy2gCR/GsNseXo1bZ7vYupIOKWqmgdr+VTLWKtKkEkHBoPIbEuS
	5M5uPbvnp2IpLUKT9RAsyzxKHXAFj8hL9Q==
X-Google-Smtp-Source: AGHT+IEreT/cnNYQ5ZpZH7qrH1+yxkWa2KAi68UVYr+O0R/xtwaLEkJ62eN9kB1n3v/eXp7IXBWipg==
X-Received: by 2002:a17:906:20d0:b0:a23:b64b:3dd4 with SMTP id c16-20020a17090620d000b00a23b64b3dd4mr3496039ejc.24.1703103548927;
        Wed, 20 Dec 2023 12:19:08 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id zs8-20020a170907714800b00a2686db1e81sm180648ejb.26.2023.12.20.12.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:19:08 -0800 (PST)
Message-ID: <e912efb0f87d91037c8b33ad1821f17fd7b3ddde.camel@gmail.com>
Subject: Re: [RFC v3 0/3] use preserve_static_offset in bpf uapi headers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Quentin Monnet
	 <quentin@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 20 Dec 2023 22:19:07 +0200
In-Reply-To: <CAADnVQJKbtFAKDo6LGTmufXO-eDptud6pymDJLA-=o-qtk4Z4w@mail.gmail.com>
References: <20231220133411.22978-1-eddyz87@gmail.com>
	 <CAADnVQJKbtFAKDo6LGTmufXO-eDptud6pymDJLA-=o-qtk4Z4w@mail.gmail.com>
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

On Wed, 2023-12-20 at 11:20 -0800, Alexei Starovoitov wrote:
> On Wed, Dec 20, 2023 at 5:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> > This RFC does not handle type pt_regs used for kprobes/
> > This type is defined in architecture specific headers like
> > arch/x86/include/asm/ptrace.h and is hidden behind typedef
> > bpf_user_pt_regs_t in include/uapi/asm-generic/bpf_perf_event.h.
> > There are two ways to handle struct pt_regs:
> > 1. Modify all architecture specific ptrace.h files to use __bpf_ctx;
> > 2. Add annotated forward declaration for pt_regs in
> >    include/uapi/asm-generic/bpf_perf_event.h, e.g. as follows:
> >=20
> >     #if __has_attribute(preserve_static_offset) && defined(__bpf__)
> >     #define __bpf_ctx __attribute__((preserve_static_offset))
> >     #else
> >     #define __bpf_ctx
> >     #endif
> >=20
> >     struct __bpf_ctx pt_regs;
> >=20
> >     #undef __bpf_ctx
> >=20
> >     #include <linux/ptrace.h>
> >=20
> >     /* Export kernel pt_regs structure */
> >     typedef struct pt_regs bpf_user_pt_regs_t;
> >=20
> > Unfortunately, it might be the case that option (2) is not sufficient,
> > as at-least BPF selftests access pt_regs either via vmlinux.h or by
> > directly including ptrace.h.
> >=20
> > If option (1) is to be implemented, it feels unreasonable to continue
> > copying definition of __bpf_ctx macro from file to file.
> > Given absence of common uapi exported headers between bpf.h and
> > bpf_perf_event.h/ptrace.h, it looks like a new uapi header would have
> > to be added, e.g. include/uapi/bpf_compiler.h.
> > For the moment this header would contain only the definition for
> > __bpf_ctx, and would be included in bpf.h, nf_bpf_link.h and
> > architecture specific ptrace.h.
> >=20
> > Please advise.
>=20
> I'm afraid option 1 is a non starter. bpf quirks cannot impose
> such heavy tax on the kernel.
>=20
> Option 2 is equally hacky.
>=20
> I think we should do what v2 did and hard code pt_regs in bpftool.

I agree on (1).
As for (2), I use the same hack in current patch for bpftool to avoid
hacking main logic of BPF dump, it works and is allowed by C language
standard (albeit in vague terms, but example is present).
Unfortunately (2) does not propagate to vmlinux.h.

Quentin, Alan, what do you think about hard-coding only pt_regs?

