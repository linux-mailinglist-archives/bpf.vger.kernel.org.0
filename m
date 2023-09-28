Return-Path: <bpf+bounces-11076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636907B2722
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id A536FB20C3D
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508A15497;
	Thu, 28 Sep 2023 21:08:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63D15484
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80093C433C8
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695935302;
	bh=zaCFPlhX4CjApyMsI+ux3FYqYMzLJJDPmSwbblOu9sQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eZ6CojTHHUPJdS9yZ8o9RjW+NozQZ3wKrmgHBC7wLA3sfsSGutzqAteMht5UMP202
	 Q+3AR2/WfnEYRXdVJ9HO7MGcb6fB59Ju19qA9e6voMDlNJO3jOLf/Sxi/YzUEQXlo4
	 mUEINUP+plgIbRqKlbx1ygw5pkwWDJt6NvFeJfM27sPIZVWzfe4s6nLik/NUlxQoIi
	 qHN1hhTnbKLW15Pmuc9HS6hqO5qysUA9cNJteLY6wzBbqSGQXR8yPyqytztVafYYuv
	 pLMbhFjs6808p2euDZgy8atZZ3lIynYRHosV0znZHE98xzeGZ5m5G7Qga2nZW2iIWF
	 kzh24p3Y8wnSw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so12113949e87.1
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:08:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzVyUzRjzLitkKmVwlaRlVSrDyr4DXq0w+CNHnIYBApZgpTGzgt
	+ItWeZ3+nVpRalFpRMWbj0OG+HasCZV+78MhmvA=
X-Google-Smtp-Source: AGHT+IFrZt+ZbscgcI3C4pODbXatO/i+YHhKIKYRPg2R1kutDq89+/TEVrcO5097VkQfYJvqKBHf+eCE6BIJxtNVqvg=
X-Received: by 2002:ac2:549a:0:b0:500:75e5:a2f0 with SMTP id
 t26-20020ac2549a000000b0050075e5a2f0mr2202186lfk.51.1695935300695; Thu, 28
 Sep 2023 14:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928194818.261163-1-hbathini@linux.ibm.com> <20230928194818.261163-2-hbathini@linux.ibm.com>
In-Reply-To: <20230928194818.261163-2-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Thu, 28 Sep 2023 14:08:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6o+4STm0AUviP_M8c-xK9Y7Uzke1zouEsEreggVBofkw@mail.gmail.com>
Message-ID: <CAPhsuW6o+4STm0AUviP_M8c-xK9Y7Uzke1zouEsEreggVBofkw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] powerpc/code-patching: introduce patch_instructions()
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 12:48=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
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

Acked-by: Song Liu <song@kernel.org>

With a nit below.

[...]
> +/*
> + * A page is mapped and instructions that fit the page are patched.
> + * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
> + */
> +static int __do_patch_instructions_mm(u32 *addr, void *code, size_t len,=
 bool repeat_instr)
>  {
>         int err;
>         u32 *patch_addr;
> @@ -307,11 +336,15 @@ static int __do_patch_instruction_mm(u32 *addr, ppc=
_inst_t instr)
>
>         orig_mm =3D start_using_temp_mm(patching_mm);
>
> -       err =3D __patch_instruction(addr, instr, patch_addr);
> +       /* Single instruction case. */
> +       if (len =3D=3D 0) {
> +               err =3D __patch_instruction(addr, *(ppc_inst_t *)code, pa=
tch_addr);

len =3D=3D 0 for single instruction is a little weird to me. How about we j=
ust use
len =3D=3D 4 or 8 depending on the instruction to patch?

Thanks,
Song

[...]

