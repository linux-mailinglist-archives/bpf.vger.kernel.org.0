Return-Path: <bpf+bounces-1466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52A716FD5
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE3F1C20D4F
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3937F31F04;
	Tue, 30 May 2023 21:37:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B3200BC
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 21:37:23 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC48107
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 14:37:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so902780166b.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685482636; x=1688074636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEMPTEyi0YeLFGj0h/eOWrcbnUXFkk0SIIhLBvreOsM=;
        b=HMsrWJF9KPy8Y2weHFwgyRZwRAK+3N0gKKl5hXiMBlWQJgy5sfzd3iA3Yn41UUVqaK
         jyCxRa6xwZ+rZdqcqJCFiCFdMXVU2ph0QFHlTtGKicXBt3aOKC2WSy8PXK6R3HYfgitk
         FHeCPTwl8MQKUnkF1OIGSU/8jJpxBmncoQ2oaqSIREYhZkmbC+TRiwj/YvdrsUNTkfk2
         fT6sj6lKOGUBjcj+4pCvzRZC8NFVN64gjc8SK8ivBaNOibr39AvC1lHN5q0rT4LFTrPf
         QLMbbF+Kc6p9VQhw1XHNqiy1/6E9IkruIz7Qm7FfU35vF3d6CMus5sw99/HJoafga1dE
         w8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685482636; x=1688074636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEMPTEyi0YeLFGj0h/eOWrcbnUXFkk0SIIhLBvreOsM=;
        b=AZ+Q0YH3sAIb0SvOs5ctnp3a3qPTKgSTBzNhOzmwQl5MuwHclqC/ICcbIffxF4zfGO
         dYkJKeBtg7mTuJS8z7dgTZ4UqbL9MNztGCwqdUS9BihlXtiSsq6oeYGU8yRnfvwzk2wO
         uGweO13+1iSZjnEGqmrJpCGrnNDo917l8y/y1mBponuM/Orfge7M5DG0TlwR1zKishn+
         15HyY37nihgnwUpqOkJuP4dH7BzDqnmtJG02KPESyQ8iPRyuAiygbZovrlEIIhzCEKue
         nzDhvnmjTMMuU1h8lZT6sTn42CB5kfv/C/fsTOcw093zVKvVRR+mZFuTLiHD7vsaPwEN
         /IWA==
X-Gm-Message-State: AC+VfDx6DvNJb3Lhy3195rvqvaRDHDE0+VN1nAiciVh5BtqbOuPCm4qE
	RwAehNZ42gBF/Xan18yUw/f54r2H8GbDq5bQdE0=
X-Google-Smtp-Source: ACHHUZ4CA49REG9unjvei+IJezyMDYWAEQHEjH+Knpu4689YDWJ61wEkmGG/MUDyTFqqCAVGBa1CayH6MUWyaN2diIc=
X-Received: by 2002:a17:907:7293:b0:966:1984:9d21 with SMTP id
 dt19-20020a170907729300b0096619849d21mr3554567ejc.9.1685482636236; Tue, 30
 May 2023 14:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
In-Reply-To: <20230530172739.447290-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 May 2023 14:37:04 -0700
Message-ID: <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
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

On Tue, May 30, 2023 at 10:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Make sure that the following unsafe example is rejected by verifier:
>
> 1: r9 =3D ... some pointer with range X ...
> 2: r6 =3D ... unbound scalar ID=3Da ...
> 3: r7 =3D ... unbound scalar ID=3Db ...
> 4: if (r6 > r7) goto +1
> 5: r6 =3D r7
> 6: if (r6 > X) goto ...
> --- checkpoint ---
> 7: r9 +=3D r7
> 8: *(u64 *)r9 =3D Y
>
> This example is unsafe because not all execution paths verify r7 range.
> Because of the jump at (4) the verifier would arrive at (6) in two states=
:
> I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
>
> Currently regsafe() does not call check_ids() for scalar registers,
> thus from POV of regsafe() states (I) and (II) are identical. If the
> path 1-6 is taken by verifier first, and checkpoint is created at (6)
> the path [1-4, 6] would be considered safe.
>
> This commit updates regsafe() to call check_ids() for scalar registers.
>
> This change is costly in terms of verification performance.
> Using veristat to compare number of processed states for selftests
> object files listed in tools/testing/selftests/bpf/veristat.cfg and
> Cilium object files from [1] gives the following statistics:
>
>   Filter        | Number of programs
>   ----------------------------------
>   states_pct>10 | 40
>   states_pct>20 | 20
>   states_pct>30 | 15
>   states_pct>40 | 11
>
> (Out of total 177 programs)
>
> In fact, impact is so bad that in no-alu32 mode the following
> test_progs tests no longer pass verifiction:
> - verif_scale2: maximal number of instructions exceeded
> - verif_scale3: maximal number of instructions exceeded
> - verif_scale_pyperf600: maximal number of instructions exceeded
>
> Additionally:
> - verifier_search_pruning/allocated_stack: expected prunning does not
>   happen because of differences in register id allocation.
>
> Followup patch would address these issues.
>
> [1] git@github.com:anakryiko/cilium.git
>
> Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assig=
nments.")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index af70dad655ab..9c10f2619c4f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15151,6 +15151,28 @@ static bool regsafe(struct bpf_verifier_env *env=
, struct bpf_reg_state *rold,
>
>         switch (base_type(rold->type)) {
>         case SCALAR_VALUE:
> +               /* Why check_ids() for scalar registers?
> +                *
> +                * Consider the following BPF code:
> +                *   1: r6 =3D ... unbound scalar, ID=3Da ...
> +                *   2: r7 =3D ... unbound scalar, ID=3Db ...
> +                *   3: if (r6 > r7) goto +1
> +                *   4: r6 =3D r7
> +                *   5: if (r6 > X) goto ...
> +                *   6: ... memory operation using r7 ...
> +                *
> +                * First verification path is [1-6]:
> +                * - at (4) same bpf_reg_state::id (b) would be assigned =
to r6 and r7;
> +                * - at (5) r6 would be marked <=3D X, find_equal_scalars=
() would also mark
> +                *   r7 <=3D X, because r6 and r7 share same id.
> +                *
> +                * Next verification path would start from (5), because o=
f the jump at (3).
> +                * The only state difference between first and second vis=
its of (5) is
> +                * bpf_reg_state::id assignments for r6 and r7: (b, b) vs=
 (a, b).
> +                * Thus, use check_ids() to distinguish these states.
> +                */
> +               if (!check_ids(rold->id, rcur->id, idmap))
> +                       return false;

does this check_ids() have to be performed before regs_exact (which
also checks IDs, btw) *and* before rold->precise check?

Intuitively, it feels like `rold->precise =3D false` case shouldn't care
about IDs in rcur, as any value should be safe. But I haven't spent
much time thinking about this, so there might be some corner case I'm
missing.

I wonder if moving this check after we handled imprecise rold case would he=
lp.

Also, it might make sense to drop SCALAR register IDs as soon as we
have only one instance of it left (e.g., if "paired" register was
overwritten already). I.e., aggressively drop IDs when they become
useless. WDYT?

The u32_hashset.... Have you also measured verification time
regression with this? I wonder how much impact that change has?

>                 if (regs_exact(rold, rcur, idmap))
>                         return true;
>                 if (env->explore_alu_limits)
> --
> 2.40.1
>

