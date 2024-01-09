Return-Path: <bpf+bounces-19287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C1B829012
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C941C24EE2
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4D3DBBB;
	Tue,  9 Jan 2024 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBtYCA8Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235D3E462
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so14121915e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 14:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704840443; x=1705445243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEwLbxnPVV+Bk56xSftZvjowhdQvqTEg3fFS2bNS+eM=;
        b=lBtYCA8ZOGP2cJM9ZPDdhoH4izko65nLn2ojg9CkvtT/eK6pr8YmVgKbfnzuaSesgd
         YlyCH5BABWoR8oN6U3bQ4aB7cyTAwC+1zmCpJOALyM71DKWfC7P+hgJQcbm2sMjaJUNl
         L1uwoWsvxp8m1pxklfEQakKKu20l07+6qvxnQ+9Gd8z5OkaumDDkExwA1uL6fYghLQzP
         O0v6yDg6Fyp4ogy1Mvyf6uuRHjuK79sEVPZWd87YCdiumMAtovrVuaGmWSIOtzMSxrny
         +u7p5yhHjVXNvFzk3XTAahG/QS6pgEVTfkyyqXdy7dRk9cdKXH57j19E5h0BXoSBNFAE
         YwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704840443; x=1705445243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEwLbxnPVV+Bk56xSftZvjowhdQvqTEg3fFS2bNS+eM=;
        b=hh7ZF2atLiYv8r/JOSDemN5K38gtXLVlo7LNj1BSoGJ6E14FWborQW0ddCi5qfMccM
         NJ+5Daiptt/MmUg0wYsOa4O3p8IIo16WEimc95N3KQzJeAQ0cZQCdwIG5dfq7LCRD7M/
         IToIczg/7NfXpqE7JgrmpTb6q+dHz9si3tNj32oLlUAwD1vWrOrWdt1PoTnVXloqzjF7
         tHa8Tcax5N/1Hx2QQBe8oycG6Sy44lM1BD19D3fxh8/wShf9jcSDAiwZX5xjCCS/OewT
         6MtlRwJbOlX0sePTsAbR3lRxtPfXnXbQFVMQuQ0ZgER/Rb3g3GLPixut3kkVEfr8x9c8
         Qulg==
X-Gm-Message-State: AOJu0YyxmqYIXrjloBW8tF4EXiFLndhNIXE4ZRwJYPMGLoXJw5Ro1qWB
	UpwFpE1BMfyBrcsB6DIPCCRxFvHV2zzWh9ejQxg=
X-Google-Smtp-Source: AGHT+IHdOVda+8m2dDzD9qAwRZENF8d7nX6gdMkjBxpjcC3JpCWUjVrnmmft4MM/PI8ZNToPghh9uG4c6obnh7asIUw=
X-Received: by 2002:a5d:670a:0:b0:336:c32d:a850 with SMTP id
 o10-20020a5d670a000000b00336c32da850mr22014wru.112.1704840443145; Tue, 09 Jan
 2024 14:47:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109040524.2313448-1-yonghong.song@linux.dev> <20240109040529.2314115-1-yonghong.song@linux.dev>
In-Reply-To: <20240109040529.2314115-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 14:47:11 -0800
Message-ID: <CAEf4Bzb1xyfBNnSKVbUOdfSA_xWD965BWSKHVfwn7Q1D3UkbXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add a selftest with
 not-8-byte aligned BPF_ST
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 8:05=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Add a selftest with a 4 bytes BPF_ST of 0 where the store is not
> 8-byte aligned. The goal is to ensure that STACK_ZERO is properly
> marked for the spill and the STACK_ZERO value can propagate
> properly during the load.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/progs/verifier_spill_fill.c | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index d4b3188afe07..6017b26d957d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -583,6 +583,50 @@ __naked void partial_stack_load_preserves_zeros(void=
)
>         : __clobber_common);
>  }
>
> +SEC("raw_tp")
> +__log_level(2)
> +__success
> +/* fp-4 is STACK_ZERO */
> +__msg("2: (62) *(u32 *)(r10 -4) =3D 0          ; R10=3Dfp0 fp-8=3D0000??=
??")
> +/* validate that assigning R2 from STACK_ZERO with zero value doesn't ma=
rk register
> + * precise immediately; if necessary, it will be marked precise later
> + */

this comment is not accurate in this test, this unaligned write
doesn't preserve register and writes STACK_ZERO, so there is no
precision going on here, right?

Other than that LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +__msg("4: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp-8=
=3D0000????")
> +__msg("5: (0f) r1 +=3D r2")
> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 4: (71) r2 =3D *(=
u8 *)(r10 -1)")
> +__naked void partial_stack_load_preserves_partial_zeros(void)
> +{
> +       asm volatile (
> +               /* fp-4 is value zero */
> +               ".8byte %[fp4_st_zero];" /* LLVM-18+: *(u32 *)(r10 -4) =
=3D 0; */
> +
> +               /* load single U8 from non-aligned stack zero slot */
> +               "r1 =3D %[single_byte_buf];"
> +               "r2 =3D *(u8 *)(r10 -1);"
> +               "r1 +=3D r2;"
> +               "*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
> +
> +               /* load single U16 from non-aligned stack zero slot */
> +               "r1 =3D %[single_byte_buf];"
> +               "r2 =3D *(u16 *)(r10 -2);"
> +               "r1 +=3D r2;"
> +               "*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
> +
> +               /* load single U32 from non-aligned stack zero slot */
> +               "r1 =3D %[single_byte_buf];"
> +               "r2 =3D *(u32 *)(r10 -4);"
> +               "r1 +=3D r2;"
> +               "*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
> +
> +               "r0 =3D 0;"
> +               "exit;"
> +       :
> +       : __imm_ptr(single_byte_buf),
> +         __imm_insn(fp4_st_zero, BPF_ST_MEM(BPF_W, BPF_REG_FP, -4, 0))
> +       : __clobber_common);
> +}
> +
>  char two_byte_buf[2] SEC(".data.two_byte_buf");
>
>  SEC("raw_tp")
> --
> 2.34.1
>

