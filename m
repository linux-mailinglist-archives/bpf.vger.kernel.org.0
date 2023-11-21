Return-Path: <bpf+bounces-15474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79AF7F22B5
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77F51C216C2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0817FC;
	Tue, 21 Nov 2023 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdN1REfy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410B191
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:00:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso669656366b.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700528421; x=1701133221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbdPzgGW7nI2xDI4hvVSwesoqb8IyN3xeNO5hRdi2Gc=;
        b=bdN1REfyv+mpFfwvbAbpxcnVg1C6/13WhQ5SRU0Jc1pSvmbp2lm272PhOlCJwtxJfH
         b4fllgJE6H3T3VaVz101XuAqf1q8a4zzAp3gd/80Z3kH4gStkipM+9UWiP6JLVAeoZhU
         kqss4qAa/26ce7jctd2b6xUf8CW4N8zWEVf2HzJXMG3Rigs6r+b2nlsPI+I/+WmmQL3h
         hn54dKnO2YKpM9VgJgwV1t/pPmJHNv0x257iftn44qBMJ+5Tp6ywvX2OPDwrU/DxvA/y
         APfjQIuCGQGaASChAyLwEsh8KEVYhBegb6tQOD0/3J/mQfE4/s2D87twckKzoQNoFLuA
         ilsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700528421; x=1701133221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbdPzgGW7nI2xDI4hvVSwesoqb8IyN3xeNO5hRdi2Gc=;
        b=IC3u/U/C+iWeFfjuWxOJh8TQsbZunTbtKosyNKix2YUhh6qB9XKg51ja166f2s+mi2
         DAgZTHLsY9MJc2yvuI2ELO59vQLCuUkAnGoxI6Dn5+2H+2fkgMhp2XFQMF0JcPAIlexy
         JROUIYirAT6rPKIlvJyI96RwVBkd9M2HRBhAmntYXUHHjqYtZeT58egJequwLvbpaPdr
         Xn9GZFO3V8wEZV6qduQ7N/TsqQ7XfqdysUwdU6t36gTUZZFeqsxPUi3Fb0zXiVo94IBo
         BrwVnf3Bs4j0JfLsxxnrJXoLfUTknDBu0TvD8509vF2OsW7C1RfZcwhaWAx34A5B3uLm
         +yzw==
X-Gm-Message-State: AOJu0YxEYwNJoNrpuFVQRLEW/YI/8isN5S5JO1A7DED0bmKakD7DVLhb
	GhrQMvJIItu4lanaWckQbZnwPDjwFjPRPuTAdvw=
X-Google-Smtp-Source: AGHT+IFI0/zcWBDAJvrXpswY6FYkbIeCjgiPI309m6x3JG7435mJ2/USlZc5PSJjKQwRBO77iMXi9o4h1xcnXJWJKWk=
X-Received: by 2002:a17:906:739e:b0:9fa:a075:c329 with SMTP id
 f30-20020a170906739e00b009faa075c329mr7255296ejl.61.1700528420449; Mon, 20
 Nov 2023 17:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120225945.11741-1-eddyz87@gmail.com> <20231120225945.11741-7-eddyz87@gmail.com>
In-Reply-To: <20231120225945.11741-7-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Nov 2023 17:00:08 -0800
Message-ID: <CAEf4BzZLU3LxG9FVAGqEmvsqpU8+X1grWj_F7Fvjvv1E8xj6Nw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 06/11] bpf: verify callbacks as if they are called
 unknown number of times
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 3:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Prior to this patch callbacks were handled as regular function calls,
> execution of callback body was modeled exactly once.
> This patch updates callbacks handling logic as follows:
> - introduces a function push_callback_call() that schedules callback
>   body verification in env->head stack;
> - updates prepare_func_exit() to reschedule callback body verification
>   upon BPF_EXIT;
> - as calls to bpf_*_iter_next(), calls to callback invoking functions
>   are marked as checkpoints;
> - is_state_visited() is updated to stop callback based iteration when
>   some identical parent state is found.
>
> Paths with callback function invoked zero times are now verified first,
> which leads to necessity to modify some selftests:
> - the following negative tests required adding release/unlock/drop
>   calls to avoid previously masked unrelated error reports:
>   - cb_refs.c:underflow_prog
>   - exceptions_fail.c:reject_rbtree_add_throw
>   - exceptions_fail.c:reject_with_cp_reference
> - the following precision tracking selftests needed change in expected
>   log trace:
>   - verifier_subprog_precision.c:callback_result_precise
>     (note: r0 precision is no longer propagated inside callback and
>            I think this is a correct behavior)
>   - verifier_subprog_precision.c:parent_callee_saved_reg_precise_with_cal=
lback
>   - verifier_subprog_precision.c:parent_stack_slot_precise_with_callback
>
> Reported-by: Andrew Werner <awerner32@gmail.com>
> Closes: https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=3D6eMcfr1mFG0=
F3g7rbg-sedGKW3w@mail.gmail.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

LGTM!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf_verifier.h                  |   5 +
>  kernel/bpf/verifier.c                         | 274 +++++++++++-------
>  tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
>  .../selftests/bpf/progs/exceptions_fail.c     |   2 +
>  .../bpf/progs/verifier_subprog_precision.c    |  71 ++++-
>  5 files changed, 240 insertions(+), 113 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 24213a99cc79..6e21d74a64e7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -400,6 +400,7 @@ struct bpf_verifier_state {
>         struct bpf_idx_pair *jmp_history;
>         u32 jmp_history_cnt;
>         u32 dfs_depth;
> +       u32 cumulative_callback_depth;

nit: depth and cumulative in this case doesn't make much sense to me,
tbh. Cumulative is generally a sum of something. You don't seem to
ever decrement this, so I guess "max_callback_depth" or
"cur_callback_depth" would also make sense? "callback_unroll_depth" is
another name that came to mind. But it's honestly not that important
to me, the use of this field is very minimal in the code base.

>  };
>
>  #define bpf_get_spilled_reg(slot, frame, mask)                         \
> @@ -511,6 +512,10 @@ struct bpf_insn_aux_data {
>          * this instruction, regardless of any heuristics
>          */
>         bool force_checkpoint;
> +       /* true if instruction is a call to a helper function that
> +        * accepts callback function as a parameter.
> +        */
> +       bool calls_callback;
>  };
>
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */

[...]

