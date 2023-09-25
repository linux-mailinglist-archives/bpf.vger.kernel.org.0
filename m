Return-Path: <bpf+bounces-10805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F657AE1E9
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 50C7E281622
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AC221A08;
	Mon, 25 Sep 2023 22:50:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AAF14010
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30618C433C9
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695682245;
	bh=F/OGTAcc/1HkdLFjixsWrd+pFJELaQPtXaIgtxGmHw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UaUxEUuv6vMaAYJViaA778OMlKAn/mHqRedcNDSFAliM+u9AmlaJ5zvNeqFVH+TJt
	 gjfeyRReOjIwOF4zbKSwYkiRb7voy2+LllKk6kKQpY4vG5edlIlEcWkZG2mHBBd1JY
	 QO2XYzynkD/mOuamEemImPZWnY9A8LmKt8T6nBz/2w0AN2qTYd7+DkjgrCORF1T36W
	 bwv0M8xQNqlmPUyv+PiDvrcLD5A1269iJaeGEwPNP/ewvmY0d0P/wgSoaevlLJjWH0
	 S6FVuBRuoAVoKO9RsgefCY2kX2o85zJRnS544UsmqoXcalRxRLC4A52/xk7+ggXuGf
	 hcdVcL/zYBivQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5043120ffbcso11276057e87.2
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:50:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yys9eY8CWoPOyTmvnOnulJzwoCYoDv16s01XyevWiTVghZN2Rhp
	zuCknTpJnWHi5fUN8uemjP1VYz8gT8G49hj+KGY=
X-Google-Smtp-Source: AGHT+IGDsdoah2MqZB6XhwZSWquY7e0vwfXUxSH0WQ2aaNmqIRLlZn6QJkEMhc8yeZWwnTagNzcs+kbYjK2Vcs4c5d4=
X-Received: by 2002:a05:6512:2815:b0:503:343a:829f with SMTP id
 cf21-20020a056512281500b00503343a829fmr8621570lfb.23.1695682243384; Mon, 25
 Sep 2023 15:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908132740.718103-1-hbathini@linux.ibm.com> <20230908132740.718103-5-hbathini@linux.ibm.com>
In-Reply-To: <20230908132740.718103-5-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Mon, 25 Sep 2023 15:50:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6p1+mqG_soSS8q_FFio7iHGtUyyDfH5cyXs_Py8f-Pmg@mail.gmail.com>
Message-ID: <CAPhsuW6p1+mqG_soSS8q_FFio7iHGtUyyDfH5cyXs_Py8f-Pmg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] powerpc/code-patching: introduce patch_instructions()
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 6:28=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.com=
> wrote:
>
> patch_instruction() entails setting up pte, patching the instruction,
> clearing the pte and flushing the tlb. If multiple instructions need
> to be patched, every instruction would have to go through the above
> drill unnecessarily. Instead, introduce function patch_instructions()
> that sets up the pte, clears the pte and flushes the tlb only once per
> page range of instructions to be patched. This adds a slight overhead
> to patch_instruction() call while improving the patching time for
> scenarios where more than one instruction needs to be patched.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

I didn't see this one when I reviewed 1/5. Please ignore that comment.

[...]

> @@ -307,11 +312,22 @@ static int __do_patch_instruction_mm(u32 *addr, ppc=
_inst_t instr)
>
>         orig_mm =3D start_using_temp_mm(patching_mm);
>
> -       err =3D __patch_instruction(addr, instr, patch_addr);
> +       while (len > 0) {
> +               instr =3D ppc_inst_read(code);
> +               ilen =3D ppc_inst_len(instr);
> +               err =3D __patch_instruction(addr, instr, patch_addr);

It appears we are still repeating a lot of work here. For example, with
fill_insn =3D=3D true, we don't need to repeat ppc_inst_read().

Can we do this with a memcpy or memset like functions?

> +               /* hwsync performed by __patch_instruction (sync) if succ=
essful */
> +               if (err) {
> +                       mb();  /* sync */
> +                       break;
> +               }
>
> -       /* hwsync performed by __patch_instruction (sync) if successful *=
/
> -       if (err)
> -               mb();  /* sync */
> +               len -=3D ilen;
> +               patch_addr =3D patch_addr + ilen;
> +               addr =3D (void *)addr + ilen;
> +               if (!fill_insn)
> +                       code =3D code + ilen;

It took me a while to figure out what "fill_insn" means. Maybe call it
"repeat_input" or something?

Thanks,
Song

> +       }
>
>         /* context synchronisation performed by __patch_instruction (isyn=
c or exception) */
>         stop_using_temp_mm(patching_mm, orig_mm);
> @@ -328,16 +344,21 @@ static int __do_patch_instruction_mm(u32 *addr, ppc=
_inst_t instr)
>         return err;
>  }
>

