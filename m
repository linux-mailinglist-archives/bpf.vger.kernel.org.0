Return-Path: <bpf+bounces-13103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D17D46C2
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 06:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0259228181A
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E15538B;
	Tue, 24 Oct 2023 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkxLS32n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848EB1FA5
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 04:57:30 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FAA1
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 21:57:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32ded3eb835so2016853f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 21:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698123446; x=1698728246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG/diypKuR8nTyMvRAZU14xkHri54HvRMckeEqsX+vE=;
        b=GkxLS32nInFFn0yzAe4Mj9eXzaVbWRKXzMvvlutj7d8d4HgNYf+Kpiu0U5QUGuYR7I
         +6O0HkW2gktJjny1MNEdkA+OGQgyOdi6IbDoCZGO52yaYI1cd3fsmPS916ozuy/Dn/IQ
         eKqNLlygG3Lj7nSG8SAXfFtXgHgO/S1NDhk/Iw2WYjY/oGRtXlFXDe0ktGzxgRW6/oDV
         VqmrTtuU2nWBsBWzRbH32qgJmnA6hVI3Yh/12EpoIbhrueZQ1MkJPOO/TNpH6rYIKDLj
         zytTpsZBimniHNPzITb8wcgCFPyKdgkrNmGwEvsvREHlIQrvU2X8nT2I2C1I3bwK1GBr
         M9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698123446; x=1698728246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG/diypKuR8nTyMvRAZU14xkHri54HvRMckeEqsX+vE=;
        b=LrtVARO/fIPUnjj7COzWcLDp+8gbGZCSlxfEmxnCqGppbXlgiL2W1aekx9afDYh1+x
         qamkksnUo8naFzUGztEYGM7Lmax5zGKJiELBmydOqw4sJERRqSh55EE9oepesgmrNqak
         pccOsdD2f4eAH/6UAMW6lV6OZIG9Z6Pu2b3kcp0DXmteyj/BSRJR3bNO4N4Nz9Tl5j0e
         EzTDv9uWpQCZy48bqq9yyKV4vP6DzXqX9kNNBy9j74LcuRKTd61thmvDtXlXQMmCjdgo
         McwSaefPMvuu5EV7OBoxsd5KCbpSaloQfc/AS8JewGyOKqUH9vNH2YiDiYN+bvRcYdqA
         UTWA==
X-Gm-Message-State: AOJu0YxiurhaG5lSKDPnjmNOC66g169TFG7QCJkCDrY4C56/wTjggIj1
	guYPCys1TFWiEz8dql4VPV8CbqFWO78idcp4KGLviE6iXWQ=
X-Google-Smtp-Source: AGHT+IEap4qc/8WtBfvP+hwkOIO1SdUvkb5CO8KJ+F4dRqXRaRvMpSplUXFU+Enq1KKVf69acqjwhTSBKJg4rGtiFkY=
X-Received: by 2002:adf:e182:0:b0:32d:95ef:3b57 with SMTP id
 az2-20020adfe182000000b0032d95ef3b57mr12533128wrb.2.1698123446240; Mon, 23
 Oct 2023 21:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024024240.42790-1-zhouchuyi@bytedance.com> <20231024024240.42790-2-zhouchuyi@bytedance.com>
In-Reply-To: <20231024024240.42790-2-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Oct 2023 21:57:14 -0700
Message-ID: <CAADnVQJRhyn4Xpd5f0_iJp7F2iZrs_qp+E0DZPNc3aKc0SGzCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Relax allowlist for css_task iter
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 7:42=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> The newly added open-coded css_task iter would try to hold the global
> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be careful =
in
> where it allows to use this iter. The mainly concern is dead locking on
> css_set_lock. check_css_task_iter_allowlist() in verifier enforced css_ta=
sk
> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>
> This patch relax the allowlist for css_task iter. Any lsm and any iter
> (even non-sleepable) and any sleepable are safe since they would not hold
> the css_set_lock before entering BPF progs context.
>
> This patch also fixes the misused BPF_TRACE_ITER in
> check_css_task_iter_allowlist which compared bpf_prog_type with
> bpf_attach_type.
>
> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs=
")
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/bpf/verifier.c                         | 21 ++++++++++++-------
>  .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e9bc5d4a25a1..9f209adc4ccb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11088,18 +11088,23 @@ static int process_kf_arg_ptr_to_rbtree_node(st=
ruct bpf_verifier_env *env,
>                                                   &meta->arg_rbtree_root.=
field);
>  }
>
> +/*
> + * css_task iter allowlist is needed to avoid dead locking on css_set_lo=
ck.
> + * LSM hooks and iters (both sleepable and non-sleepable) are safe.
> + * Any sleepable progs are also safe since bpf_check_attach_target() enf=
orce
> + * them can only be attached to some specific hook points.
> + */
>  static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
>  {
>         enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>
> -       switch (prog_type) {
> -       case BPF_PROG_TYPE_LSM:
> +       if (prog_type =3D=3D BPF_PROG_TYPE_LSM)
>                 return true;
> -       case BPF_TRACE_ITER:
> -               return env->prog->aux->sleepable;
> -       default:
> -               return false;
> -       }
> +
> +       if (env->prog->expected_attach_type =3D=3D BPF_TRACE_ITER)
> +               return true;

I think the switch by prog_type has to stay.
Checking attach_type =3D=3D BPF_TRACE_ITER without considering prog_type
is fragile. It likely works, but we don't do it anywhere else.
Let's stick to what is known to work.

> -SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> -__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s=
")
> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
> +__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and =
sleepable progs")

Please add both. fentry that is rejected and fentry.s that is accepted.

