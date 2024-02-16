Return-Path: <bpf+bounces-22172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E208C8584F7
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1240D1C212A5
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEAB1350C1;
	Fri, 16 Feb 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWER3eK6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD421339B8
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107386; cv=none; b=ErbYgSObnlketim50sPnlM9NNwIdU60ETSq3dT42TYaKr0OgEaPqFeGrxn+xflwfyk1tjL2xYplDoIzP6vfH7eRmRX1sFV0MCuafUg3NiJeDnr18bIP8+NNdK6VZ9vduLkzaTSfQELd8rG0FjhIgp0YRuDBlcW/R9KIXYi4OsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107386; c=relaxed/simple;
	bh=SyvBEghHbYF5S+M0CS2qHqh7yRWdHFFgn92RpWw6T/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IePTyYCx5jvngKiAtCPN+MxCwVXhxmZkO/XsWCXrmhx6bAagivXwaESLNP92MHx7fQbize/9/uHXLuDoJUkBsCmHQNbE36Hvzm+HUY8Tz0qI9YvphnRfBy8VQ+Uhqy5QMAnNVBjzjDVKQImMgCywWEg+mdjy1jtYDY3r2BkZt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWER3eK6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1926861a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708107383; x=1708712183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRbCFnFk5C+7YsC9JqpZ71rv4JdlqC9fsRAHzG4aXYk=;
        b=cWER3eK6+jrIQjc/mwshbUn9NgqbB5la46bjgwa226WZv5CNXXHzJYGP/5HsN+ZAUw
         zzRGLMYcle2Q4Z1AsIuu6C5v1g9A5TcyYq7jmXwqlmxzZT7v+LHnfwSeMgNOLscdIrNn
         PtkcVN3chAOoD+mBz4HlQ0Ghk4KbFWRXL615t66LtDI+ChFZ4B/Ug+X59hskS2/3wm6A
         zYkdE01TQF5UZ/+iwiOPMIxY6hzBjWUVOdW0JkNpQ0xm59p/HCT853EXdGMybs1JnQlG
         aZUPbKKVmn8lOQIUj6Jvb+RaM6RsQwtCXgBAyCM/6hOjpSQvIfboSz9IQddpGsKJWF5N
         AQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708107383; x=1708712183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRbCFnFk5C+7YsC9JqpZ71rv4JdlqC9fsRAHzG4aXYk=;
        b=tQeBlaIBpJeBN71F7jjwgS+MqiXyTt05fdMLZR/L7oCoodywcqsenxj//86dqEPGKK
         lCIqUXLDpVxkwCHUKOCZ/ICGWws4Wsg7DAOpgi7zV7BInlfzMAE/4Inv2GMqwCxUcYy9
         laKmtZkr07WhZvxdaIfNFUMPb7QVDCeQrCU1qXZbdYkkbKVJXFjaQJVcVI9DbnDiJBTC
         ua9uLl5WLynSPj6UYeid5DhU+nLlBdbHkat2sCJ5NdtgfftDYJPQ3hHxkQjG6Qyg/jf1
         rQdaRA2zUIA354Jnu1Vez3xG/O+qdDrm54BwJmLfgcEHEc5ibnP3xCRXlPhvzxJEjWJ1
         uvKg==
X-Gm-Message-State: AOJu0Yz5JlElepk4RgdFpHmgH9ZwpO4uSZ2iUygKGjFgLiFGYyY3t9em
	tzzJ9Fs4lqUQvWAHDKtT4kZ6tFSJU6vbEAD8ygttUJ4KziI42rursPh0+HX6nU2c+ctggO5OEiq
	sJb84FbJcIN9hGhIQzwxJLItQIN0=
X-Google-Smtp-Source: AGHT+IEVp9A2BSZCXJAARcYFDw+0s8ue2rM4/QM0T2btN5kTiYeNOQ4Ziq9HPtPQFHmFnU5CRzj+RKukIZVyry0YEjk=
X-Received: by 2002:a17:90b:1017:b0:299:3236:734 with SMTP id
 gm23-20020a17090b101700b0029932360734mr2823103pjb.42.1708107383304; Fri, 16
 Feb 2024 10:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216150334.31937-1-eddyz87@gmail.com> <20240216150334.31937-3-eddyz87@gmail.com>
In-Reply-To: <20240216150334.31937-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Feb 2024 10:16:11 -0800
Message-ID: <CAEf4BzaF8tEt9aTOhKfst9_LoMX5OCV-9iUxHrbk76oet552=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 7:03=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> When comparing current and cached states verifier should consider
> bpf_func_state->callback_depth. Current state cannot be pruned against
> cached state, when current states has more iterations left compared to
> cached state. Current state has more iterations left when it's
> callback_depth is smaller.
>
> Below is an example illustrating this bug, minimized from mailing list
> discussion [0].
> The example is not a safe program: if loop_cb point (1) is followed by
> loop_cb point (2), then division by zero is possible at point (4).
>
>     struct ctx {
>         __u64 a;
>         __u64 b;
>         __u64 c;
>     };
>
>     static void loop_cb(int i, struct ctx *ctx)
>     {
>         /* assume that generated code is "fallthrough-first":
>          * if ... =3D=3D 1 goto
>          * if ... =3D=3D 2 goto
>          * <default>
>          */
>         switch (bpf_get_prandom_u32()) {
>         case 1:  /* 1 */ ctx->a =3D 42; return 0; break;
>         case 2:  /* 2 */ ctx->b =3D 42; return 0; break;
>         default: /* 3 */ ctx->c =3D 42; return 0; break;
>         }
>     }
>
>     SEC("tc")
>     __failure
>     __flag(BPF_F_TEST_STATE_FREQ)
>     int test(struct __sk_buff *skb)
>     {
>         struct ctx ctx =3D { 7, 7, 7 };
>
>         bpf_loop(2, loop_cb, &ctx, 0);              /* 0 */
>         /* assume generated checks are in-order: .a first */
>         if (ctx.a =3D=3D 42 && ctx.b =3D=3D 42 && ctx.c =3D=3D 7)
>                 asm volatile("r0 /=3D 0;":::"r0");    /* 4 */
>         return 0;
>     }
>
> Prior to this commit verifier built the following checkpoint tree for
> this example:
>
>  .------------------------------------- Checkpoint / State name
>  |    .-------------------------------- Code point number
>  |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c}
>  |    |   |        .------------------- Callback depth in frame #0
>  v    v   v        v
>    - (0) {7P,7P,7},depth=3D0
>      - (3) {7P,7P,7},depth=3D1
>        - (0) {7P,7P,42},depth=3D1
>          - (3) {7P,7,42},depth=3D2
>            - (0) {7P,7,42},depth=3D2      loop terminates because of dept=
h limit
>              - (4) {7P,7,42},depth=3D0    predicted false, ctx.a marked p=
recise
>              - (6) exit
>          - (2) {7P,7,42},depth=3D2
> (a)        - (0) {7P,42,42},depth=3D2     loop terminates because of dept=
h limit
>              - (4) {7P,42,42},depth=3D0   predicted false, ctx.a marked p=
recise
>              - (6) exit
> (b)      - (1) {7P,7P,42},depth=3D2
>            - (0) {42P,7P,42},depth=3D2    loop terminates because of dept=
h limit
>              - (4) {42P,7P,42},depth=3D0  predicted false, ctx.{a,b} mark=
ed precise
>              - (6) exit
>      - (2) {7P,7,7},depth=3D1
>        - (0) {7P,42,7},depth=3D1          considered safe, pruned using c=
heckpoint (a)
> (c)  - (1) {7P,7P,7},depth=3D1            considered safe, pruned using c=
heckpoint (b)
>
> Here checkpoint (b) has callback_depth of 2, meaning that it would
> never reach state {42,42,7}.
> While checkpoint (c) has callback_depth of 1, and thus
> could yet explore the state {42,42,7} if not pruned prematurely.
> This commit makes forbids such premature pruning,
> allowing verifier to explore states sub-tree starting at (c):
>
> (c)  - (1) {7,7,7P},depth=3D1
>        - (0) {42P,7,7P},depth=3D1
>          ...
>          - (2) {42,7,7},depth=3D2
>            - (0) {42,42,7},depth=3D2      loop terminates because of dept=
h limit
>              - (4) {42,42,7},depth=3D0    predicted true, ctx.{a,b,c} mar=
ked precise
>                - (5) division by zero
>
> [0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linu=
x.dev/
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Missing Fixes: tag? Also, shouldn't this go into bpf tree instead of bpf-ne=
xt?

Otherwise everything looks good.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 011d54a1dc53..c1fa1de590dc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16705,6 +16705,9 @@ static bool func_states_equal(struct bpf_verifier=
_env *env, struct bpf_func_stat
>  {
>         int i;
>
> +       if (old->callback_depth > cur->callback_depth)
> +               return false;
> +
>         for (i =3D 0; i < MAX_BPF_REG; i++)
>                 if (!regsafe(env, &old->regs[i], &cur->regs[i],
>                              &env->idmap_scratch, exact))
> --
> 2.43.0
>

