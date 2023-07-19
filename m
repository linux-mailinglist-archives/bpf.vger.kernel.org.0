Return-Path: <bpf+bounces-5260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E2E758FC9
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472D4280E74
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2D101EA;
	Wed, 19 Jul 2023 07:59:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD3C2EF
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 07:59:20 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FEE9D
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:59:19 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-3a43cbb432aso4027576b6e.3
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689753558; x=1692345558;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xosG6Cz8RSkRx9ERfUJ8JtZ9dkptBjdZphRA5cseR8Q=;
        b=EvsPhCoD9Jfy5msvvxr0rXuWm2jDiNdciPDivQdp8S2fpL//6pn3EJuCzDuGzcjzu+
         yq4vR3mUReSDDT/kVPTVlpZ+qZ2FYdjQeEXKyJU4/lNfGH2x5HO7vnLeOMiuL+XKSk7d
         vW0eInB18Z3xbrF6xb2j/CfzHG71ADv9isJykmUzXA1QBbekjC18uDOfceUb/WJo/2/b
         ivcdcLnBlgJ+F2Tv+k+8xs13PcFDm9+rRx4MCozxfxEv/WyDup7YG7h6o2j2xhTLdrXq
         yv9NAOCWxi9Gu6c8TkYvTxDbW//Pltrj4jtZ+1FOHIsL8rzF8Vgx5QZBdcM4iuMdoZSS
         K8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753558; x=1692345558;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xosG6Cz8RSkRx9ERfUJ8JtZ9dkptBjdZphRA5cseR8Q=;
        b=XTMUIi7t0359M2L+jq8QzlPhwGlBb/PK0Xjtfr+YsO0RmCV2uk2LVZaMO7t2LGyS9m
         UA+CAllwauYj8GRdju4YsmgqXmg8DsHF3+qs+Ow9AaCZcHfYk8xr4y3ck1Kp8yQiHs5F
         uphXXUmMq6kahPJ1vhR+kryhwJywgxDoVcVdT6JT4T7mESoAdAr8xmr/KIxGEUGI3NqR
         raFLH7NMjGpxF2baxTUfUPEoE5cdKUu1SMPy2dLfjwFDOpT7Di1cS8O1BDK/1+zdebD1
         SqevAv/lgdcEsp9ZyPp0SszMQI7OXhLnMtdS91DTOfhFHi6+hdf73jzgFcNvD1vGKj3H
         Vuhw==
X-Gm-Message-State: ABy/qLbhSmsrKZpMq4WWUWJk7/fZyVRWCnLO5XHdf7XSqg21kzvv4VjR
	Wbt7ZNLUuK4ZxDUj8HUIN3M=
X-Google-Smtp-Source: APBJJlGQlJCSILwxFj/jQdjA3Gz9+4irRw+mFVlVu2xDz/LabxKZyC+R/2mLo8btmIZA1Vq4At1kbw==
X-Received: by 2002:aca:745:0:b0:3a3:660c:bdb0 with SMTP id 66-20020aca0745000000b003a3660cbdb0mr17708164oih.54.1689753558259;
        Wed, 19 Jul 2023 00:59:18 -0700 (PDT)
Received: from smtpclient.apple ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id n18-20020a63ee52000000b0055c178a8df1sm2870456pgk.94.2023.07.19.00.59.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:59:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [bug report] bpf, x86: allow function arguments up to 12 for
 TRACING
From: Menglong Dong <menglong8.dong@gmail.com>
In-Reply-To: <09784025-a812-493f-9829-5e26c8691e07@moroto.mountain>
Date: Wed, 19 Jul 2023 15:58:59 +0800
Cc: imagedong@tencent.com,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <61BFA874-6832-40FA-AAB7-A225BE2A7D8C@gmail.com>
References: <09784025-a812-493f-9829-5e26c8691e07@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B47=E6=9C=8817=E6=97=A5 22:48=EF=BC=8CDan Carpenter =
<dan.carpenter@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hello Menglong Dong,
>=20
> The patch 473e3150e30a: "bpf, x86: allow function arguments up to 12
> for TRACING" from Jul 13, 2023 (linux-next), leads to the following
> Smatch static checker warning:
>=20
> arch/x86/net/bpf_jit_comp.c:1999 save_args()
> error: uninitialized symbol 'first_off'.
>=20
> arch/x86/net/bpf_jit_comp.c
>    1925 static void save_args(const struct btf_func_model *m, u8 =
**prog,
>    1926                       int stack_size, bool for_call_origin)
>    1927 {
>    1928         int arg_regs, first_off, nr_regs =3D 0, nr_stack_slots =
=3D 0;
>    1929         int i, j;
>    1930=20
>    1931         /* Store function arguments to stack.
>    1932          * For a function that accepts two pointers the =
sequence will be:
>    1933          * mov QWORD PTR [rbp-0x10],rdi
>    1934          * mov QWORD PTR [rbp-0x8],rsi
>    1935          */
>    1936         for (i =3D 0; i < min_t(int, m->nr_args, =
MAX_BPF_FUNC_ARGS); i++) {
>    1937                 arg_regs =3D (m->arg_size[i] + 7) / 8;
>    1938=20
>    1939                 /* According to the research of Yonghong, =
struct members
>    1940                  * should be all in register or all on the =
stack.
>    1941                  * Meanwhile, the compiler will pass the =
argument on regs
>    1942                  * if the remaining regs can hold the =
argument.
>    1943                  *
>    1944                  * Disorder of the args can happen. For =
example:
>    1945                  *
>    1946                  * struct foo_struct {
>    1947                  *     long a;
>    1948                  *     int b;
>    1949                  * };
>    1950                  * int foo(char, char, char, char, char, =
struct foo_struct,
>    1951                  *         char);
>    1952                  *
>    1953                  * the arg1-5,arg7 will be passed by regs, and =
arg6 will
>    1954                  * by stack.
>    1955                  */
>    1956                 if (nr_regs + arg_regs > 6) {
>=20
> first_off is not set on else path.  It's also in a loop so maybe there
> is some guarantee that we will hit an else path...
>=20
>    1957                         /* copy function arguments from origin =
stack frame
>    1958                          * into current stack frame.
>    1959                          *
>    1960                          * The starting address of the =
arguments on-stack
>    1961                          * is:
>    1962                          *   rbp + 8(push rbp) +
>    1963                          *   8(return addr of origin call) +
>    1964                          *   8(return addr of the caller)
>    1965                          * which means: rbp + 24
>    1966                          */
>    1967                         for (j =3D 0; j < arg_regs; j++) {
>    1968                                 emit_ldx(prog, BPF_DW, =
BPF_REG_0, BPF_REG_FP,
>    1969                                          nr_stack_slots * 8 + =
0x18);
>    1970                                 emit_stx(prog, BPF_DW, =
BPF_REG_FP, BPF_REG_0,
>    1971                                          -stack_size);
>    1972=20
>    1973                                 if (!nr_stack_slots)
>    1974                                         first_off =3D =
stack_size;
>    1975                                 stack_size -=3D 8;
>    1976                                 nr_stack_slots++;
>    1977                         }
>    1978                 } else {
>    1979                         /* Only copy the arguments on-stack to =
current
>    1980                          * 'stack_size' and ignore the regs, =
used to
>    1981                          * prepare the arguments on-stack for =
orign call.
>    1982                          */
>    1983                         if (for_call_origin) {
>    1984                                 nr_regs +=3D arg_regs;
>    1985                                 continue;
>    1986                         }
>    1987=20
>    1988                         /* copy the arguments from regs into =
stack */
>    1989                         for (j =3D 0; j < arg_regs; j++) {
>    1990                                 emit_stx(prog, BPF_DW, =
BPF_REG_FP,
>    1991                                          nr_regs =3D=3D 5 ? =
X86_REG_R9 : BPF_REG_1 + nr_regs,
>    1992                                          -stack_size);
>    1993                                 stack_size -=3D 8;
>    1994                                 nr_regs++;
>    1995                         }
>    1996                 }
>    1997         }
>    1998=20
> --> 1999         clean_stack_garbage(m, prog, nr_stack_slots, =
first_off);
>    2000 }

Hello,

Thanks for the reporting. The variable =E2=80=98first_off=E2=80=99 that =
passed to
clean_stack_garbage() should be ok, as it is only used when
"nr_stack_slots =3D=3D 1=E2=80=9D, in which case =E2=80=9Cfirst_off=E2=80=9D=
 should already be
initialized.

(Anyway, maybe we should initialize it to avoid passing a
uninitialized variable to a function?)

Thanks!
Menglong Dong


> regards,
> dan carpenter
>=20


