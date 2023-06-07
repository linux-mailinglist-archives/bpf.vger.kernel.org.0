Return-Path: <bpf+bounces-2037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85477270A0
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A0728159D
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8BB3B8AF;
	Wed,  7 Jun 2023 21:40:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3812B79
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:40:31 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1E2109
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:40:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso2128209a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174026; x=1688766026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoP/jWWtShP2f7OWxQBwbrE+OcK9/IhgC/Jp9jkE65A=;
        b=eavvtwYEvuyX/+9DXUrGT/JqZfIL2+uPJR5zwNBK92oCHxo/sopZeD+A/YuUHGzQol
         kKHGvT5YABiykDy4nreOChyaT+Ndm5U8nJANZqGoQP4ZI4fKOj1YQWkFSFPlF/9DM5ow
         3tEMprGkLCcktpyBUOoOUuQjl9ZvmCLIOPH0z5hk/jYjo83vicOY11aGEQZRJGqZWmBV
         Bxy2RfO26FuiDN7wHKWMDww347jTteOvf7C74BWvrQI80bSShxqC8mVybeFlK9HGDd6d
         D6eyOgLv+Mry6uCiNbLvwByisrXmBZJ880FASYBcKw8N4jJJXhI2vYjW2vkFnQQV6gRu
         uZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174026; x=1688766026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoP/jWWtShP2f7OWxQBwbrE+OcK9/IhgC/Jp9jkE65A=;
        b=FA3d7CNP4blRmRisVxJ4Y10M9hWsJdj0pXlSkgIZxb2Woy+qx21R/tHiwXz3d66pjd
         q6zu1VviF4XnbfI52VwpWTTM7KP9CPHiR5ZAyFchET5Isvh2YaCW2xlsvM0WGxXCRsf7
         1HxMh9AEBLwbw5vOFl07kOAqmrP8bAIPavS9+JNuNCTm9F8qXAOEIw3p2GNwBwlZ1Kbc
         zUeCI1cwKA2gQfmV2s6ZhmK5fy74RLPYVGU2KcF3VuDaC0bD69Xgt+AARB/HtbYX3QvN
         siqwjkdAHPKgF4BgnwOwGOdhyzFLBQyXfJ11jN9p3HW2tdjuEC/RaANfahzL+PmPcY7U
         qAmw==
X-Gm-Message-State: AC+VfDwNStQ/diP41XHS1z47hZfY8t81DFPBlOlPzUNhOZgI9zrcSba4
	ZGFVrPcdSZ7YdqDj8rD6vSFEGAT+eSEtdhXZpXM=
X-Google-Smtp-Source: ACHHUZ5sAc6dehqi1Lyzu9+2dtrFFIhMxmcKrEgh9rNBBAQDFTzx9ONTRsTR4O+ltnZEorcAHeFSuCm+ZjhH0jw8FpI=
X-Received: by 2002:a05:6402:1a48:b0:516:a009:6fdb with SMTP id
 bf8-20020a0564021a4800b00516a0096fdbmr1908978edb.22.1686174026138; Wed, 07
 Jun 2023 14:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-5-eddyz87@gmail.com>
In-Reply-To: <20230606222411.1820404-5-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 14:40:13 -0700
Message-ID: <CAEf4Bzaam9ayi7z6tmUjX+7JwoSySqqw29XJsHnAHEMgriuCyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: verify that check_ids() is
 used for scalars in regsafe()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Verify that the following example is rejected by verifier:
>
>   r9 =3D ... some pointer with range X ...
>   r6 =3D ... unbound scalar ID=3Da ...
>   r7 =3D ... unbound scalar ID=3Db ...
>   if (r6 > r7) goto +1
>   r7 =3D r6
>   if (r7 > X) goto exit
>   r9 +=3D r6
>   *(u64 *)r9 =3D Y
>
> Also add test cases to check that check_alu_op() for BPF_MOV instruction =
does
> not allocate scalar ID if source register is a constant.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_scalar_ids.c | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>

[...]

> +/* Similar to check_ids_in_regsafe.
> + * The l0 could be reached in two states:
> + *
> + *   (1) r6{.id=3DA}, r7{.id=3DA}, r8{.id=3DB}
> + *   (2) r6{.id=3DB}, r7{.id=3DA}, r8{.id=3DB}
> + *
> + * Where (2) is not safe, as "r7 > 4" check won't propagate range for it=
.
> + * This example would be considered safe without changes to
> + * mark_chain_precision() to track scalar values with equal IDs.
> + */
> +SEC("socket")
> +__failure __msg("register with unbounded min value")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void check_ids_in_regsafe_2(void)
> +{
> +       asm volatile (
> +       /* Bump allocated stack */
> +       "r1 =3D 0;"
> +       "*(u64*)(r10 - 8) =3D r1;"
> +       /* r9 =3D pointer to stack */
> +       "r9 =3D r10;"
> +       "r9 +=3D -8;"
> +       /* r8 =3D ktime_get_ns() */
> +       "call %[bpf_ktime_get_ns];"
> +       "r8 =3D r0;"
> +       /* r7 =3D ktime_get_ns() */
> +       "call %[bpf_ktime_get_ns];"
> +       "r7 =3D r0;"
> +       /* r6 =3D ktime_get_ns() */
> +       "call %[bpf_ktime_get_ns];"
> +       "r6 =3D r0;"
> +       /* scratch .id from r0 */
> +       "r0 =3D 0;"
> +       /* if r6 > r7 is an unpredictable jump */
> +       "if r6 > r7 goto l1_%=3D;"
> +       /* tie r6 and r7 .id */
> +       "r6 =3D r7;"
> +"l0_%=3D:"
> +       /* if r7 > 4 exit(0) */
> +       "if r7 > 4 goto l2_%=3D;"
> +       /* Access memory at r9[r7] */
> +       "r9 +=3D r6;"
> +       "r0 =3D *(u8*)(r9 + 0);"
> +"l2_%=3D:"
> +       "r0 =3D 0;"
> +       "exit;"
> +"l1_%=3D:"

complete offtopic, feel free to ignore:

I must say that this "l0_%=3D" pattern is so ugly that I instead choose
to use local labels and specify forward/backward mark:

    goto 1f; /* forward */

1:
    ...

    goto 1b; /* backward */

I can see why _%=3D is good for the code generation approach (and even
then it probably is not hard to determine this b/f mark during
codegen), but for manual code I'm not convinced it's worth it :)

> +       /* tie r6 and r8 .id */
> +       "r6 =3D r8;"
> +       "goto l0_%=3D;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* Check that scalar IDs *are not* generated on register to register
> + * assignments if source register is a constant.
> + *
> + * If such IDs *are* generated the 'l1' below would be reached in
> + * two states:
> + *
> + *   (1) r1{.id=3DA}, r2{.id=3DA}
> + *   (2) r1{.id=3DC}, r2{.id=3DC}
> + *
> + * Thus forcing 'if r1 =3D=3D r2' verification twice.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("11: (1d) if r3 =3D=3D r4 goto pc+0")
> +__msg("frame 0: propagating r3,r4")
> +__msg("11: safe")

would this detect that `if r1 =3D=3D r2` happens twice, if it did?

maybe we should check the number of verified states instead? We
control branching and checkpointing, so this should be stable, right?


> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void no_scalar_id_for_const(void)
> +{
> +       asm volatile (
> +       "call %[bpf_ktime_get_ns];"
> +       /* unpredictable jump */
> +       "if r0 > 7 goto l0_%=3D;"
> +       /* possibly generate same scalar ids for r3 and r4 */
> +       "r1 =3D 0;"
> +       "r1 =3D r1;"
> +       "r3 =3D r1;"
> +       "r4 =3D r1;"
> +       "goto l1_%=3D;"
> +"l0_%=3D:"
> +       /* possibly generate different scalar ids for r3 and r4 */
> +       "r1 =3D 0;"
> +       "r2 =3D 0;"
> +       "r3 =3D r1;"
> +       "r4 =3D r2;"
> +"l1_%=3D:"
> +       /* predictable jump, marks r3 and r4 precise */
> +       "if r3 =3D=3D r4 goto +0;"
> +       "r0 =3D 0;"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +

[...]

