Return-Path: <bpf+bounces-15243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B57EF687
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306621F26FFB
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CFA3D393;
	Fri, 17 Nov 2023 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxdVHyAO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53381A4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso3249633a12.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239621; x=1700844421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IuotkcIh49hKuFio5R8KGItcNPj0ZLButyLRX1K5A4=;
        b=CxdVHyAOfdQTvwElTdqICwrr5h6Z5W6JyzFm22gQVTme0Qk5TUpMgPVYYkPoxqPW2V
         jiqsLHUbJAJr41J1e0xr21vjlqU3aWlH36YN5r+acDYHRZfeBt82my6iTb5tuQOhKXIX
         Itz2ho6lERuneOXZ7RIT1Uf+SJMY+lrpqYuxAS8CaJGgLnPQXBiuRbvY5kTBmQSa+cAn
         PMhE1e75UnS8cnuCtYAwdlL3A3dVOfOBdJuDv58BAieYUQj7RnK6UatTtpsasGjXTuok
         LPb5lbymbdD21o88fxEYG40tNEisoiKkeWtoQS3g5cjjQw5rk0SNhRsE6lmZpIhZpSab
         JNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239621; x=1700844421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IuotkcIh49hKuFio5R8KGItcNPj0ZLButyLRX1K5A4=;
        b=uUICNeqE6ayCeTDXfQPC0h5XghVWN/SlIspANr7xATHBsXLAawN7F0yoeVxXoohAXu
         3Mohux4v3EzHSmYd+AwWxXxXZo8kq/jRocPsJbxtRI1LmdZ3p7zsTNKpIHTQ3WieGP/k
         DDNlLPwvGMwHMNOr5cR6xVnFROwF34dMNynPCTxnDfNXLz+Yb+ua6jjtG847ZI6Tusoq
         3x+FlytnPN98BejFTpvpE+T4utyKdqIv5D65xx1NVExsSm6HqF0qcPynGE0wjE0EXXcR
         r9D2fNi+1Nq1yjLgBWYgh4Y2MaDvKxB8JmTL4yoVMNs3sAYfk6GLKTkFvbllOqT3uSYz
         4KrQ==
X-Gm-Message-State: AOJu0Yy35n/mwuG7+y9vCAwDIwPtcu+OLOP1uQKLFmuwuMpdivStqlt2
	SCFAco8aHmyygYHQmwcrTXdlQJ8Qb3PPtdgF/c8=
X-Google-Smtp-Source: AGHT+IHzW8JXfuxJQr4EndDLH4UcozbJQ0329Z141n2j13hdDFI1iCkDX5DvhojEjZcLzcI/S0SX/TpIlImt4GbWDrE=
X-Received: by 2002:a05:6402:3582:b0:548:4d43:ad70 with SMTP id
 y2-20020a056402358200b005484d43ad70mr1433963edc.40.1700239620758; Fri, 17 Nov
 2023 08:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-6-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-6-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:49 -0500
Message-ID: <CAEf4BzZWcWOU8VTKc1TAFQ2P1AmN-VW6NqW_7SH6Fkn90HQ4dg@mail.gmail.com>
Subject: Re: [PATCH bpf 05/12] bpf: extract setup_func_entry() utility function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Move code for simulated stack frame creation to a separate utility
> function. This function would be used in the follow-up change for
> callbacks handling.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 87 +++++++++++++++++++++++++------------------
>  1 file changed, 51 insertions(+), 36 deletions(-)
>

LGTM, minor nit below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0576fc1ddc4d..d9513fd58c7c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9542,11 +9542,10 @@ static int set_callee_state(struct bpf_verifier_e=
nv *env,
>                             struct bpf_func_state *caller,
>                             struct bpf_func_state *callee, int insn_idx);
>
> -static int __check_func_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
> -                            int *insn_idx, int subprog,
> -                            set_callee_state_fn set_callee_state_cb)
> +static int setup_func_entry(struct bpf_verifier_env *env, int subprog, i=
nt callsite,
> +                           set_callee_state_fn set_callee_state_cb,
> +                           struct bpf_verifier_state *state)
>  {
> -       struct bpf_verifier_state *state =3D env->cur_state;
>         struct bpf_func_state *caller, *callee;
>         int err;
>
> @@ -9556,13 +9555,56 @@ static int __check_func_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                 return -E2BIG;
>         }
>
> -       caller =3D state->frame[state->curframe];
>         if (state->frame[state->curframe + 1]) {
>                 verbose(env, "verifier bug. Frame %d already allocated\n"=
,
>                         state->curframe + 1);
>                 return -EFAULT;
>         }
>
> +       caller =3D state->frame[state->curframe];
> +       callee =3D kzalloc(sizeof(*callee), GFP_KERNEL);
> +       if (!callee)
> +               return -ENOMEM;
> +       state->frame[state->curframe + 1] =3D callee;
> +
> +       /* callee cannot access r0, r6 - r9 for reading and has to write
> +        * into its own stack before reading from it.
> +        * callee can read/write into caller's stack
> +        */
> +       init_func_state(env, callee,
> +                       /* remember the callsite, it will be used by bpf_=
exit */
> +                       callsite,
> +                       state->curframe + 1 /* frameno within this callch=
ain */,
> +                       subprog /* subprog number within this prog */);
> +       /* Transfer references to the callee */
> +       err =3D copy_reference_state(callee, caller);
> +       if (err)
> +               goto err_out;
> +
> +       err =3D set_callee_state_cb(env, caller, callee, callsite);
> +       if (err)
> +               goto err_out;

given we are touching and moving this code, it might make sense to
make it a bit more succinct with this pattern:

err =3D copy_reference_state(...);
err =3D err ?: set_callee_state_cb();
if (err)
    goto err_out;


Error handling is a bit less distracting this way.

> +
> +       /* only increment it after check_reg_arg() finished */
> +       state->curframe++;
> +
> +       return 0;
> +
> +err_out:
> +       free_func_state(callee);
> +       state->frame[state->curframe + 1] =3D NULL;
> +       return err;
> +}
> +

[...]

