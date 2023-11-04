Return-Path: <bpf+bounces-14199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8667E0D76
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 04:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A821A28205D
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 03:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B651FC9;
	Sat,  4 Nov 2023 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmFKpHmL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726ED17CB
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 03:21:57 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F2D42
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 20:21:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso4467631a12.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 20:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699068113; x=1699672913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zytYXk6iqrg4nFsDXfyK5RKh8lyO0P5Y7vutu5SB0SE=;
        b=YmFKpHmL8XLAowakd2uGpZsSrvAp8DwwH8d6l49XETWPm/doYVFTUFKYc27qFLin4g
         b/fBv5Zo6DsSnN034nsIXX2eG6gIBO2WuZgDEXVq9X/pFbKo0x9KMPpnSfM6jPZ0++VI
         E4TByRiuDgmUfWZftAcgmYX1e9dNwKeaA5M1RI0yHRLuvmkMjuu6PqvFLQvXMQZKfIkW
         4MuA/Haz73A2PD1WhHM30U3d3DewBzAj0fzlcxEYGZzfJfXFIAWPhwdQV53dKp+Kt3qR
         6WsqAWM2rCy7kzBS8wwUsyifzxqxhOwmIjx2QJRhd3J2GtJg821MVhoFQDQ/kGf7T1ir
         4gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699068113; x=1699672913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zytYXk6iqrg4nFsDXfyK5RKh8lyO0P5Y7vutu5SB0SE=;
        b=M4TDajeb/j4ANxmBY0rEdtSMNoHBnCXfBKalN3KJjbA8QGc96ITP357PqAZ3tsaVQo
         EDhZsviJ5zKFiW+Kir9sOF6wW6uFbjt4twDPXv/TRpPWiqIW3R8HKTHLe31eWDv+5ERO
         296PtDcK2xVYHbwafxNBA0GXP/oR+YsfIQIo3c09dAGd8WdbtfggUQw/+nwkpigBqxd1
         cfa9xqpw15HQ8svThAkhfeHcpwMxTOSMsGL3XFX3sB2NmBatFczAXHM4+7OuM1G9du8l
         u75s157Vas2iVfE6LCN7jtjLp5g9dr/+Ejv4RoKn22foM769ai/iCkLtAGx7AzT2h1be
         DHUw==
X-Gm-Message-State: AOJu0YyOn5oKYIbc6IcfTGuVECnISlrHwXEClfVi8x/Q99wdocF2kKNZ
	Nh/1FOgHSvyP4j8XwGadVOJTHoB9iiZpJZXVzqE=
X-Google-Smtp-Source: AGHT+IEnStONUfrSK9LjQp7jRJQjr0THSLJcDfQkesH6nHKEtMGWEytJMgEF+M6JNhSyClKDeSW5qtrToBzrGmLYN10=
X-Received: by 2002:a17:906:dc8e:b0:9be:2963:5671 with SMTP id
 cs14-20020a170906dc8e00b009be29635671mr8711540ejc.69.1699068112799; Fri, 03
 Nov 2023 20:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104024900.1539182-1-yonghong.song@linux.dev>
In-Reply-To: <20231104024900.1539182-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 20:21:41 -0700
Message-ID: <CAEf4BzYizqBuOX8egEXVGLjwbHPmGtktzmWKzAp7acvYf4bigA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use named fields for certain bpf uapi structs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Vadim Fedorenko <vadfed@meta.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 7:49=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Martin and Vadim reported a verifier failure with bpf_dynptr usage.
> The issue is mentioned but Vadim workarounded the issue with source
> change ([1]). The below describes what is the issue and why there
> is a verification failure.
>
>   int BPF_PROG(skb_crypto_setup) {
>     struct bpf_dynptr algo, key;
>     ...
>
>     bpf_dynptr_from_mem(..., ..., 0, &algo);
>     ...
>   }
>
> The bpf program is using vmlinux.h, so we have the following definition i=
n
> vmlinux.h:
>   struct bpf_dynptr {
>         long: 64;
>         long: 64;
>   };
> Note that in uapi header bpf.h, we have
>   struct bpf_dynptr {
>         long: 64;
>         long: 64;
> } __attribute__((aligned(8)));
>
> So we lost alignment information for struct bpf_dynptr by using vmlinux.h=
.
> Let us take a look at a simple program below:
>   $ cat align.c
>   typedef unsigned long long __u64;
>   struct bpf_dynptr_no_align {
>         __u64 :64;
>         __u64 :64;
>   };
>   struct bpf_dynptr_yes_align {
>         __u64 :64;
>         __u64 :64;
>   } __attribute__((aligned(8)));
>
>   void bar(void *, void *);
>   int foo() {
>     struct bpf_dynptr_no_align a;
>     struct bpf_dynptr_yes_align b;
>     bar(&a, &b);
>     return 0;
>   }
>   $ clang --target=3Dbpf -O2 -S -emit-llvm align.c
>
> Look at the generated IR file align.ll:
>   ...
>   %a =3D alloca %struct.bpf_dynptr_no_align, align 1
>   %b =3D alloca %struct.bpf_dynptr_yes_align, align 8
>   ...
>
> The compiler dictates the alignment for struct bpf_dynptr_no_align is 1 a=
nd
> the alignment for struct bpf_dynptr_yes_align is 8. So theoretically comp=
iler
> could allocate variable %a with alignment 1 although in reallity the comp=
iler
> may choose a different alignment by considering other local variables.
>
> In [1], the verification failure happens because variable 'algo' is alloc=
ated
> on the stack with alignment 4 (fp-28). But the verifer wants its alignmen=
t
> to be 8.
>
> To fix the issue, the RFC patch ([1]) tried to add '__attribute__((aligne=
d(8)))'
> to struct bpf_dynptr plus other similar structs. Andrii suggested that
> we could directly modify uapi struct with named fields like struct 'bpf_i=
ter_num':
>   struct bpf_iter_num {
>         /* opaque iterator state; having __u64 here allows to preserve co=
rrect
>          * alignment requirements in vmlinux.h, generated from BTF
>          */
>         __u64 __opaque[1];
>   } __attribute__((aligned(8)));
>
> Indeed, adding named fields for those affected structs in this patch can =
preserve
> alignment when bpf program references them in vmlinux.h. With this patch,
> the verification failure in [1] can also be resolved.
>
>   [1] https://lore.kernel.org/bpf/1b100f73-7625-4c1f-3ae5-50ecf84d3ff0@li=
nux.dev/
>   [2] https://lore.kernel.org/bpf/20231103055218.2395034-1-yonghong.song@=
linux.dev/
>
> Cc: Vadim Fedorenko <vadfed@meta.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/uapi/linux/bpf.h       | 23 +++++++----------------
>  tools/include/uapi/linux/bpf.h | 23 +++++++----------------
>  2 files changed, 14 insertions(+), 32 deletions(-)
>

I think that's the best solution, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

