Return-Path: <bpf+bounces-11147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FE7B3D57
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 02:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 174A528219C
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 00:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048264F;
	Sat, 30 Sep 2023 00:42:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2676361
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 00:42:03 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897B94
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 17:42:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3231d67aff2so11070698f8f.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696034519; x=1696639319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UsBW6d7itlN26O/ITe6J3vHkaS0u1XE9RNsodDpmXs=;
        b=SH34l5Vpk/W7l5mzb/LpXRCbXprKLyyADBvZdv3Kgiy+XDwc2aE0aLptFU1ORipqz4
         EYNglsD5Lm9/c1vcLwxgECYxMRp5V6j1XVrK41bw94XD3ZmCD3NOKdDbgxTY0m//xV9H
         oB/iNBGC1lKapzAgba3x8RRyk2bLP/gGlZ2O6ck9DMrb77R3xlOmRvnLoWlPY9JrcMTX
         um+oH0k0eY9FJnX1JBo0uceYfSfXlAyo+om7RuCGfezTpYHSD4h+QxgT7VC4EIKD8LAW
         DbfIHT0hBQhnrxzj/CwUYKeUoY18GX+TP6YT1xn0O5PKrqr9JqtxevmkGi558j7LQTFh
         +dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696034519; x=1696639319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UsBW6d7itlN26O/ITe6J3vHkaS0u1XE9RNsodDpmXs=;
        b=ixinFRKQveTgplaOLng+yZ5AGaQhXehuTFSRmHlf7Y8IJ7VhOoKM1ilHhDgbWf2Q3E
         CdJjYecV3YsHhs86hFtHsMZh0icEDEuwPb37Pe6KyWc4oZsxaHXPmrMD0woTYfTXlL3H
         7RKYZjCNEjOmYpivgigQtIoPf8pMzrhBj3u8PY//3WHkGGNve5w9DVR0Mycb6iqBLcoN
         oF9v/UAJKIlXWH+cPZBkN7RTlK9ft94WP92YKhzfnGDS2skGgRpGOQRgtugrW6WFdg69
         Y8+5itNyRy3VyW/TST6iuctMxWXArCuWRblQYYnG9qyBXIZ87P7E/monIFFQNDhrPes3
         5iGw==
X-Gm-Message-State: AOJu0YwAG5Bhtq7AG7DTj+vMJNOWHvnLB/ldigWUZIg/Ah6rPDtE0Nih
	6uuxqBVshZYgQrz0c1dcQIXmY2ynWTCI7KQHzzZoDmcJifE=
X-Google-Smtp-Source: AGHT+IEPmwAEV31RNYeuP4bIwbK8Z+Ibd/lbdZgsoaCWGcQFNcYL1g1Zr3NmRC4Qn1/UG+Us0sRmKsA6NUY0Urp9khM=
X-Received: by 2002:a05:6000:1085:b0:323:2c39:bb3d with SMTP id
 y5-20020a056000108500b003232c39bb3dmr4751036wrw.64.1696034518885; Fri, 29 Sep
 2023 17:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
 <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
 <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
 <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
 <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
 <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
 <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
 <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
 <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
 <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com> <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
In-Reply-To: <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Sep 2023 17:41:47 -0700
Message-ID: <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 6:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
>  static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  {
>      ...
>      while (sl) {
>          ...
>          if (sl->state.branches) {
>              ...
>              if (is_iter_next_insn(env, insn_idx)) {
>                  if (states_equal(env, &sl->state, cur)) {
>                      ...
>                      iter_state =3D &func(env, iter_reg)->stack[spi].spil=
led_ptr;
>                      if (iter_state->iter.state =3D=3D BPF_ITER_STATE_ACT=
IVE) {
> +                        // Don't want to proceed with 'cur' verification=
,
> +                        // push it to iters queue to check again if stat=
es
> +                        // are still equal after env->head is exahusted.
> +                        if (env->stack_size !=3D 0)
> +                            push_iter_stack(env, cur, ...);
>                          goto hit;

I suspect that neither option A "Exit or Loop" or B "widening"
are not correct.
In both cases we will do states_equal() with states that have
not reached exit and don't have live/precision marks.

The key aspect of the verifier state pruning is that safe states
in sl list explored all possible paths.
Say, there is an 'if' block after iter_destroy.
The push_stack/pop_stack logic is done as a stack to make sure
that the last 'if' has to be explored before earlier 'if' blocks are checke=
d.
The existing bpf iter logic violated that.
To fix that we need to logically do:

if (is_iter_next_insn(env, insn_idx))
  if (states_equal(env, &sl->state, cur)) {
   if (iter_state->iter.state =3D=3D BPF_ITER_STATE_DRAINED)
     goto hit;

instead of BPF_ITER_STATE_ACTIVE.
In other words we need to process loop iter =3D=3D 0 case first
all the way till bpf_exit (just like we do right now),
then process loop iter =3D=3D 1 and let it exit the loop and
go till bpf_exit (hopefully state prune will find equal states
right after exit from the loop).
then process loop iter =3D=3D 2 and so on.
If there was an 'if' pushed to stack during loop iter =3D=3D 1
it has to be popped and explored all the way till bpf_exit.

We cannot just replace BPF_ITER_STATE_ACTIVE with DRAINED.
It would still be ACTIVE with sl->state.branches=3D=3D0 after that
state explored all paths to bpf_exit.

