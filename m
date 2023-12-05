Return-Path: <bpf+bounces-16672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B5A804341
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B612813DB
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A641657;
	Tue,  5 Dec 2023 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN8xQa0P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189FA101
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 16:23:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1b6b65923eso224419166b.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 16:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735813; x=1702340613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4erl9rvYBJF7+GyfYDY+q6CMHyP6y+Fe0EYbR9pcIE=;
        b=KN8xQa0PYCZyHDuqj9hLWJphctBXbem88BrVleqeTzO2Md2M19FH5htbhYF1JBGA0G
         H4hZOT0W00hCSztax6Jc/sH8XegLtNKxQJxmiASkWPJns2lhANklWTeXCnzNjJ3RdTNM
         vAEoFq9HsHkYZv41YxFeQgwVhKygsp95fjb1XWJg2tb4Zt7xKf43q9KSPtbpN3KcQ/mw
         HAoRKeV5L1N0iJIppKlwdcrgs/1MIkxDJ0u0iga8qQceCzSFTu5n0tEuUNUQgWM+AhKy
         WgMNtgoGO6HI0uy8M9Lf4rxU/KSretL55AmgOjNfF9fafreFzCU4yt1uDVvCizzhM7/r
         kNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735813; x=1702340613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4erl9rvYBJF7+GyfYDY+q6CMHyP6y+Fe0EYbR9pcIE=;
        b=V90KVGEMpRL4brM4UP5YbAgGpblaTTWM5l4cvD/cGSvLBMVcIs9d/bHFLSzW9zbWHp
         lKMwtWg9F9NiBGNMmXAHjbv2zpmK6cIq+uDmpUxMLNL2O3WcPLbjROsRxbOyNbBSghCj
         Icwsbr3H5ogQOuczfP4nH1lvxAgJ/tjpw6W5ZiE4twJmx3RjW8wVG082cTbXWM71lrqo
         P0rkHC6PUukH8+cskzH9RYVBxOHe1TbZ96R9Tm/t4KeGjLr5R2+SWLPHSCrk0w9fbCCB
         QqyDVUadJK9Go3MCO3YqbDcDkaYHN7QdWg4pPxjP8gkUwin+olwrXrml0ROWYAJn8I5O
         /i/A==
X-Gm-Message-State: AOJu0Yxu7NdG7Qxs1UZ0qgJv77C24vu68jJnt29z+MTDOi7LXIzrOHG5
	MhdEFaCJMCi8qjzPsquauiPzczxaTunrBm3cbt8=
X-Google-Smtp-Source: AGHT+IHO0/rYN51PVgVxFJWfUMp72ykCfMMVgJCzW1iSMfFI1bw3xoy73+hnkK21ZhdPEDs2Lp0Q1Ugm7amr80+NfmY=
X-Received: by 2002:a17:906:f20c:b0:a19:a19b:4230 with SMTP id
 gt12-20020a170906f20c00b00a19a19b4230mr2460062ejb.155.1701735813449; Mon, 04
 Dec 2023 16:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org> <20231204192601.2672497-4-andrii@kernel.org>
 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
In-Reply-To: <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 16:23:21 -0800
Message-ID: <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 2:12=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 11:25 -0800, Andrii Nakryiko wrote:
> [...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 4f8a3c77eb80..73315e2f20d9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4431,7 +4431,7 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
> >        * so it's aligned access and [off, off + size) are within stack =
limits
> >        */
> >       if (!env->allow_ptr_leaks &&
> > -         state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
> > +         is_spilled_reg(&state->stack[spi]) &&
> >           size !=3D BPF_REG_SIZE) {
> >               verbose(env, "attempt to corrupt spilled pointer on stack=
\n");
> >               return -EACCES;
>
> I think there is a small detail here.
> slot_type[0] =3D=3D STACK_SPILL actually checks if a spill is 64-bit.

Hm... I wonder if the check was written like this deliberately to
prevent turning any spilled register into STACK_MISC?

> Thus, with this patch applied the test below does not pass.
> Log fragment:
>
>     1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=
=3D(0x0; 0xffff))
>     2: (63) *(u32 *)(r10 -8) =3D r0
>     3: R0_w=3Dscalar(...,var_off=3D(0x0; 0xffff)) R10=3Dfp0 fp-8=3Dmmmmsc=
alar(...,var_off=3D(0x0; 0xffff))
>     3: (b7) r0 =3D 42                       ; R0_w=3D42
>     4: (63) *(u32 *)(r10 -4) =3D r0
>     attempt to corrupt spilled pointer on stack

What would happen if we have

4: *(u16 *)(r10 - 8) =3D 123; ?

and similarly

4: *(u16 *)(r10 - 6) =3D 123; ?


(16-bit overwrites of spilled 32-bit register)

It should be rejected, can you please quickly check if they will be
with the existing check?

So it makes me feel like the intent was to reject any partial writes
with spilled reg slots. We could probably improve that to just make
sure that we don't turn spilled pointers into STACK_MISC in unpriv,
but I'm not sure if it's worth doing that instead of keeping things
simple?

Alexei, do you remember what was the original intent?

>
> Admittedly, this happens only when the only capability is CAP_BPF and
> we don't test this configuration.
>
> ---
>
> iff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/to=
ols/testing/selftests/bpf/progs/verifier_basic_stack.c
> index 359df865a8f3..61ada86e84df 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> @@ -97,4 +97,20 @@ __naked void misaligned_read_from_stack(void)
>  "      ::: __clobber_all);
>  }
>
> +SEC("socket")
> +__success_unpriv
> +__naked void spill_lo32_write_hi32(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r0 &=3D 0xffff;                                   \
> +       *(u32*)(r10 - 8) =3D r0;                          \
> +       r0 =3D 42;                                        \
> +       *(u32*)(r10 - 4) =3D r0;                          \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index a350ecdfba4a..a5ad6b01175e 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -430,7 +430,7 @@ struct cap_state {
>  static int drop_capabilities(struct cap_state *caps)
>  {
>         const __u64 caps_to_drop =3D (1ULL << CAP_SYS_ADMIN | 1ULL << CAP=
_NET_ADMIN |
> -                                   1ULL << CAP_PERFMON   | 1ULL << CAP_B=
PF);
> +                                   1ULL << CAP_PERFMON /*| 1ULL << CAP_B=
PF */);
>         int err;
>
>         err =3D cap_disable_effective(caps_to_drop, &caps->old_caps);

