Return-Path: <bpf+bounces-1852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F29722E4D
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E77F281367
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 18:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038122622;
	Mon,  5 Jun 2023 18:05:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E83AD2E
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 18:05:14 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FA2E68;
	Mon,  5 Jun 2023 11:04:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1b084620dso46963051fa.0;
        Mon, 05 Jun 2023 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685988285; x=1688580285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAS8KjW8aXhbcROMsGHD4vAxja4tcWVmSzN6Q5h/kKA=;
        b=krXrUQQsE02mGtZwrvqP4k8TSbvyXI2+wF1qLsFZ3hLPbaNHk1NFeRzqB6qdW2vCSR
         JqbJTI801dKZlhGsq9JIXQXvnJY3iZT1w1tWJ3CkEtZ4DyZN2AHCH5TYaQk+jmCy9vtk
         RaD2qrHu1FO9mAmiOFuR19LY5hTZj/4IoT+y+Jv+ySkx1waPGvztOdVqN3/eiBAYLQRj
         aRlo769d/ysWywYuRhv6MFDXb6mo7MPuaNHO86j5MBa/H5xEz5qWT4xG8Wu5+RefHauf
         6glX6kMdnRb3kBN5Mu4CNNuTN1DNzKU2jn6qP5Gd+SeATq07vAcF4nKqtCepfvLVC3Od
         zHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988285; x=1688580285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAS8KjW8aXhbcROMsGHD4vAxja4tcWVmSzN6Q5h/kKA=;
        b=hggS3seeJWYRlQk1mWbUFBh6ZD+ct3xWTGY2G6n0hgUD1PIksgd/NeJWZZGXxpQ3/A
         a5G1HRlhyMTxIXzc2j2EzMuL1UZqhD7sTkPsNvyN77M7Wa0yIAvV/gg0pXhhfKlrhnSt
         Wpr9rsghbUm+P/6bX/JFhCNctpvbMHUnN8Vsx3WbhTJSDKVu1Zz8ZXOXB1yTICsJvY/n
         F9a5jff18dDWRjoRImVuY0jXKiLJ4aHQoUm4fYGFy29A6/TyQ/6ziFrbmoEkjHjNtL3K
         Q5Dw0exBhIiswu5fmok7IyFwr4Frpk6lGDY4lES2fLILodCZjIJSpTb0tqpCU3Zq3kjC
         Ak8Q==
X-Gm-Message-State: AC+VfDwWGywj7qsjlKBvcdfL11nz36TQ3ANrgcxo/Tlgngci/Z6HeEWG
	9DDTYwT506INbbUkfXr9tRSrxlY3IAuVFM+JOO7VW8fgER/ltg==
X-Google-Smtp-Source: ACHHUZ5DIiBGFRkxgZRim7IgGbCYpyYs4F+cZxiyBQhpoDr6bKiePBzeUbm4XFjMCxNRz7LSsx+iQFYQEQT9nOywmI8=
X-Received: by 2002:a05:651c:145:b0:2a8:ac69:bfe with SMTP id
 c5-20020a05651c014500b002a8ac690bfemr4880809ljd.42.1685988285076; Mon, 05 Jun
 2023 11:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com>
 <20230605074024.1055863-3-puranjay12@gmail.com> <CAPhsuW5-+eBuNGFes3i5-A4vA_f3woLwL_WbUcg6gNXssyi_Xg@mail.gmail.com>
In-Reply-To: <CAPhsuW5-+eBuNGFes3i5-A4vA_f3woLwL_WbUcg6gNXssyi_Xg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 5 Jun 2023 20:04:34 +0200
Message-ID: <CANk7y0jOkTTKPFse96GNZ24GGc3n8qRFHL6ZE4+QTX5nwN5Bsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] arm64: patching: Add aarch64_insn_copy()
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, catalin.marinas@arm.com, mark.rutland@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 6:42=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jun 5, 2023 at 12:40=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > This will be used by BPF JIT compiler to dump JITed binary to a RX huge
> > page, and thus allow multiple BPF programs sharing the a huge (2MB)
> > page.
> >
> > The bpf_prog_pack allocator that implements the above feature allocates
> > a RX/RW buffer pair. The JITed code is written to the RW buffer and the=
n
> > this function will be used to copy the code from RW to RX buffer.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> Acked-by: Song Liu <song@kernel.org>
>
> With a nit below.
>
> > ---
> >  arch/arm64/include/asm/patching.h |  1 +
> >  arch/arm64/kernel/patching.c      | 39 +++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm=
/patching.h
> > index 68908b82b168..dba9eb392bf1 100644
> > --- a/arch/arm64/include/asm/patching.h
> > +++ b/arch/arm64/include/asm/patching.h
> > @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
> >  int aarch64_insn_write(void *addr, u32 insn);
> >
> >  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> > +void *aarch64_insn_copy(void *addr, const void *opcode, size_t len);
> >
> >  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
> >  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> > diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.=
c
> > index b4835f6d594b..48c710f6a1ff 100644
> > --- a/arch/arm64/kernel/patching.c
> > +++ b/arch/arm64/kernel/patching.c
> > @@ -105,6 +105,45 @@ noinstr int aarch64_insn_write_literal_u64(void *a=
ddr, u64 val)
> >         return ret;
> >  }
> >
> > +/**
> > + * aarch64_insn_copy - Copy instructions into (an unused part of) RX m=
emory
> > + * @addr: address to modify
> > + * @opcode: source of the copy
> > + * @len: length to copy
> > + *
> > + * Useful for JITs to dump new code blocks into unused regions of RX m=
emory.
> > + */
>
> nit:
> I understand "addr" and "opcode" are used by x86 text_poke_copy(). But ma=
ybe
> we should call them "dst" and "src" or "to" and "from" or something simil=
ar?

Sure, I will call it "dst" and "src" in the next version.

Thanks,
Puranjay

