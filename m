Return-Path: <bpf+bounces-52416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1322A42C1B
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B417A4DE0
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CA2661BE;
	Mon, 24 Feb 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BClOkjuN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A626139E
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423420; cv=none; b=HnGofBSQkYqko1BYFk5HZITv91Fr3vOfrhQMh3cRAH7wyXwpq1ew5uHwdNaNrdN8IHgK0bNTgd+a1UGvpMSbMjHTv59nw3LlIngNiCp4lP02acnR29mEPayEdwGRPM4Zol8YaEEBKe41KQ9QocINZtKJO0mImWX6UMgWkEubV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423420; c=relaxed/simple;
	bh=qaJ4sxpWFCfTIv31RPgJe7a/YHxH5gtlWhcOaz6J/Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTB7n//IK2hssd7sfww/NFUq/8+ZFVbbDnUuMMzgXos9pZaHik8QOmAdXEb1loTQXam9iLWoM95QzQe0NYs6ZUciIsHCJIg01oTvN/seat/8fBB5+/MhdSvvhqoSeZonigX53aQW6+HKsfBCaTFkLF69Ninf0+7GAKkvXKbhRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BClOkjuN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fcc99efe9bso7383204a91.2
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 10:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740423418; x=1741028218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60IRre+NAGJNcYcYF/fwPYFMYyLJqAcJWFce7pU55c0=;
        b=BClOkjuNgRI5FX5GJLP4osQUkCurksAgD2Nau2FI03uW7BU8/NuIv92qgpEHe42zME
         H7+O+kTFujPWGdPY5feGtc84jM47P1opPM83S2IFixauYTh/ODfGQj0D6jVBccEnrKTE
         5WrDLPOBL19ezt/fhHSJlZPNKExOcb0gh489CZKUMv6C5qwiqUmqB+7Ws7ucqJDCoht1
         mdFVhIyxnubuvqWnMr3Y8DN+paWrKh9jMLnbh+iZUPI5HbGvLD9/ZWgCFl6HdX3v1A3+
         dkyrvrSM2aXFEY37GjkoNWoW4Hv7g3X8wmj4eQqj0nUXxJrR5VGSu+Z3v8zvSrgFTl43
         R3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423418; x=1741028218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60IRre+NAGJNcYcYF/fwPYFMYyLJqAcJWFce7pU55c0=;
        b=COZ4tyVaG6LI//7zMPNoWSRzNJhMU3QRhcJ00G73c+ZYVNkqv5yT3hl6WQoP2NE/Xy
         wjiJMbkj0RQi9TiG5O4avc5WsvSoWE5OyQ0rKM0gZwZIL/XO7wq9W36plgqoD7xdw32O
         8maS5cU+HjSxnlVQs2zPn15N9oKOuYNCCwOZbma5SyNq+ZrqeU/G9Btbe5YPs2NvDxAz
         UuD9yN/hrDSfi2vCtb6WUL/wtgB1HdWhJpBFip/3eznlNxhGysiSoWLQkfLKYh3anc7h
         EElIpUVyaH6qQF8eQ82ceb0hqayPwfCHCJ2ykIXe7JrJkFiG3CNACyNRm5FTRUe3vKbv
         wrqw==
X-Gm-Message-State: AOJu0Yw8GGp9QWSJoorrSRFbdjGxEYTd0dxGtLlqUBCAetWpqBDitOW0
	GKR7nMFlD+kQQERwfhStAx1ETR/KXwYhPFluXfGKYu/k/fjFUlbNJuldIv0VjMkQZLEzXufpcYa
	TvYlTy2zxf5EHBfxLOEq0GyDu7a8=
X-Gm-Gg: ASbGnct7iAQhZJTikbv/di7Kx8sFLwuJJ4Haju0qEHaKxGRdBhCnp7v73T9WCImNnao
	MYGr2riuTjttcevTiMrJ7JgZ9PIzOzzeWIWixTbbo/irr5mx9NPVMrXaxHwp8mGz+l2rPCQ0HXp
	64IcFROFdN+BQpW8eCxV0h5x8=
X-Google-Smtp-Source: AGHT+IEcfc7prN/cBGXtHbhdW5tnj33fyxo4yi1rTbjzTiih948v/5I7NEgZqwkUjqCVmUAsK+N7/BT4q6+6aiwF8dc=
X-Received: by 2002:a17:90b:548f:b0:2ee:d7d3:3008 with SMTP id
 98e67ed59e1d1-2fce86ae5d0mr26196508a91.12.1740423418162; Mon, 24 Feb 2025
 10:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215110411.3236773-1-eddyz87@gmail.com> <20250215110411.3236773-2-eddyz87@gmail.com>
In-Reply-To: <20250215110411.3236773-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 10:56:45 -0800
X-Gm-Features: AWEUYZnWm8a1V0noRaIs7hDUsUBRFEQjDO4Tr-3ZNSdZuKLYPD2dV4Co_hTygQU
Message-ID: <CAEf4Bzb3B0-aC2CQeTajhsFDYpUtXEAEM1zq81TdpHr+QZW6QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/10] bpf: copy_verifier_state() should copy
 'loop_entry' field
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, tj@kernel.org, patsomaru@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> The bpf_verifier_state.loop_entry state should be copied by
> copy_verifier_state(). Otherwise, .loop_entry values from unrelated
> states would poison env->cur_state.
>
> Additionally, env->stack should not contain any states with
> .loop_entry !=3D NULL. The states in env->stack are yet to be verified,
> while .loop_entry is set for states that reached an equivalent state.
> This means that env->cur_state->loop_entry should always be NULL after
> pop_stack().
>
> See the selftest in the next commit for an example of the program that
> is not safe yet is accepted by verifier w/o this fix.
>
> This change has some verification performance impact for selftests:
>
> File                                Program                       Insns (=
A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
> ----------------------------------  ----------------------------  -------=
--  ---------  --------------  ----------  ----------  -------------
> arena_htab.bpf.o                    arena_htab_llvm                     7=
17        426  -291 (-40.59%)          57          37  -20 (-35.09%)
> arena_htab_asm.bpf.o                arena_htab_asm                      5=
97        445  -152 (-25.46%)          47          37  -10 (-21.28%)
> arena_list.bpf.o                    arena_list_del                      3=
09        279    -30 (-9.71%)          23          14   -9 (-39.13%)
> iters.bpf.o                         iter_subprog_check_stacksafe        1=
55        141    -14 (-9.03%)          15          14    -1 (-6.67%)
> iters.bpf.o                         iter_subprog_iters                 10=
94       1003    -91 (-8.32%)          88          83    -5 (-5.68%)
> iters.bpf.o                         loop_state_deps2                    4=
79        725  +246 (+51.36%)          46          63  +17 (+36.96%)
> kmem_cache_iter.bpf.o               open_coded_iter                      =
63         59     -4 (-6.35%)           7           6   -1 (-14.29%)
> verifier_bits_iter.bpf.o            max_words                            =
92         84     -8 (-8.70%)           8           7   -1 (-12.50%)
> verifier_iterating_callbacks.bpf.o  cond_break2                         1=
13        107     -6 (-5.31%)          12          12    +0 (+0.00%)
>
> And significant negative impact for sched_ext:
>
> File               Program                 Insns (A)  Insns (B)  Insns   =
      (DIFF)  States (A)  States (B)  States      (DIFF)
> -----------------  ----------------------  ---------  ---------  --------=
------------  ----------  ----------  ------------------
> bpf.bpf.o          lavd_init                    7039      14723      +768=
4 (+109.16%)         490        1139     +649 (+132.45%)
> bpf.bpf.o          layered_dispatch            11485      10548         -=
937 (-8.16%)         848         762       -86 (-10.14%)
> bpf.bpf.o          layered_dump                 7422    1000001  +992579 =
(+13373.47%)         681       31178  +30497 (+4478.27%)
> bpf.bpf.o          layered_enqueue             16854      71127     +5427=
3 (+322.02%)        1611        6450    +4839 (+300.37%)
> bpf.bpf.o          p2dq_dispatch                 665        791        +1=
26 (+18.95%)          68          78       +10 (+14.71%)
> bpf.bpf.o          p2dq_init                    2343       2980        +6=
37 (+27.19%)         201         237       +36 (+17.91%)
> bpf.bpf.o          refresh_layer_cpumasks      16487     674760   +658273=
 (+3992.68%)        1770       65370  +63600 (+3593.22%)
> bpf.bpf.o          rusty_select_cpu             1937      40872    +38935=
 (+2010.07%)         177        3210   +3033 (+1713.56%)
> scx_central.bpf.o  central_dispatch              636       2687      +205=
1 (+322.48%)          63         227     +164 (+260.32%)
> scx_nest.bpf.o     nest_init                     636        815        +1=
79 (+28.14%)          60          73       +13 (+21.67%)
> scx_qmap.bpf.o     qmap_dispatch                2393       3580       +11=
87 (+49.60%)         196         253       +57 (+29.08%)
> scx_qmap.bpf.o     qmap_dump                     233        318         +=
85 (+36.48%)          22          30        +8 (+36.36%)
> scx_qmap.bpf.o     qmap_init                   16367      17436        +1=
069 (+6.53%)         603         669       +66 (+10.95%)
>
> Note 'layered_dump' program, which now hits 1M instructions limit.
> This impact would be mitigated in the next patch.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 04d1d75d9ff9..01b31b718f4f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1659,6 +1659,7 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
>         dst_state->callback_unroll_depth =3D src->callback_unroll_depth;
>         dst_state->used_as_loop_entry =3D src->used_as_loop_entry;
>         dst_state->may_goto_depth =3D src->may_goto_depth;
> +       dst_state->loop_entry =3D src->loop_entry;
>         for (i =3D 0; i <=3D src->curframe; i++) {
>                 dst =3D dst_state->frame[i];
>                 if (!dst) {
> @@ -19243,6 +19244,8 @@ static int do_check(struct bpf_verifier_env *env)
>                                                 return err;
>                                         break;
>                                 } else {
> +                                       if (WARN_ON_ONCE(env->cur_state->=
loop_entry))
> +                                               env->cur_state->loop_entr=
y =3D NULL;

this would be a huge violation of invariant, so why wouldn't this be a
BUG()? At the very least, we should return -EFAULT ASAP, instead of
trying to "recover" from unknown broken state.

>                                         do_print_state =3D true;
>                                         continue;
>                                 }
> --
> 2.48.1
>

