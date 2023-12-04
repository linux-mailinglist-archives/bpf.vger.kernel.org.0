Return-Path: <bpf+bounces-16606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B4803CA7
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E958328113D
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027102EB0A;
	Mon,  4 Dec 2023 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXVa1+7A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEDCA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 10:19:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso19173075e9.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713954; x=1702318754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDcLWwPn84Rum9lqk213YzffGVrQ/KdTi+vzBbg2/to=;
        b=HXVa1+7ADWHZ63hnLqo0ICAX8oIkbIo1aCCGzpsu/Rt07GGxuWA1JhwyjzG9Tl+A9c
         Qr1XjM0MO731qYQy2h6wWn097rXHfk4W8Bykqh3sRHsoGD53lJjIjjAWZEsgF1FAkg75
         5t/m79joB1sLwH1elNGol60dqifJTKvDgcO1phf5lVwB+Vz9yICwfE6dmX80k8U+HCZJ
         abUPgxS8uJND+EnH3jk7A2YN+fxjBQGHOT4ieT9D5v3DYWn7Sm2KKNdhOc3b25PWRudd
         p0iJYc8CIZ3XCHuex8TOkzZJXoI1B1U7uMQDRtsRuDO3u/jxymYU5247nYr3DwstoNbe
         3jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713954; x=1702318754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDcLWwPn84Rum9lqk213YzffGVrQ/KdTi+vzBbg2/to=;
        b=UEKbeDaHFkuc6BgmlrQUk9opZE+s81/fxb77qQQxp/Orgm2LfZaxxlQHnH8ya8Bw0H
         k+oAklh230lAbhIhoaZR3QjWrmp0Cl7QXlCYQ41FszvmyZ2zKukMOeC1bcLU7q0/4gpx
         LgnIl+HuDBfpk9buQtqQGW2Fk/uvbNT0oual7D1RgZOLV0ugnzr4kmOyIOd/Pk2ZR2PD
         YmMw2gD8JpXKa9HcV4D60y0qTnx/18qjAF1NC9sMAvSMyEND4sVYM9teJ+CQMo8HB6mR
         I22RI9AatCgEGk9A9qRkMJHo0tAyjDJ2qcBawnJr2OnHb6cHl4aTGVRMyVhopbQmg7XR
         j+Hg==
X-Gm-Message-State: AOJu0YwE1X1kCY9+1bEcRPAWqrCUnGtMMPkM4zrthh/fYI1FQCFODMvZ
	x/K1tbmDEZFzLy+1aJStx9EfmFNNgLWqreJ/st0+MvM4
X-Google-Smtp-Source: AGHT+IGsNYjqtJziPJfZA7r8EoWy3dI4CR5bUgU8OPAaA5B8eEDexr8osai6Ju1bF8Yuv7qqkB/I4UTt2hKQscaYR20=
X-Received: by 2002:a05:600c:3c9a:b0:40b:4c54:3d67 with SMTP id
 bg26-20020a05600c3c9a00b0040b4c543d67mr2781001wmb.23.1701713953684; Mon, 04
 Dec 2023 10:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202230558.1648708-1-andreimatei1@gmail.com> <20231202230558.1648708-3-andreimatei1@gmail.com>
In-Reply-To: <20231202230558.1648708-3-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 10:19:01 -0800
Message-ID: <CAEf4BzbOf6UEU6pU5JDs6+E0MTM1D1Xq+bfMSx4A_WGPEZgcxg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: fix accesses to uninit stack slots
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 3:07=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> Privileged programs are supposed to be able to read uninitialized stack
> memory (ever since 6715df8d5) but, before this patch, these accesses
> were permitted inconsistently. In particular, accesses were permitted
> above state->allocated_stack, but not below it. In other words, if the
> stack was already "large enough", the access was permitted, but
> otherwise the access was rejected instead of being allowed to "grow the
> stack". This undesired rejection was happening in two places:
> - in check_stack_slot_within_bounds()
> - in check_stack_range_initialized()
> This patch arranges for these accesses to be permitted. A bunch of tests
> that were relying on the old rejection had to change; all of them were
> changed to add also run unprivileged, in which case the old behavior
> persists. One tests couldn't be updated - global_func16 - because it
> can't run unprivileged for other reasons.
>
> This patch also fixes the tracking of the stack size for variable-offset
> reads. This second fix is bundled in the same commit as the first one
> because they're inter-related. Before this patch, writes to the stack
> using registers containing a variable offset (as opposed to registers
> with fixed, known values) were not properly contributing to the
> function's needed stack size. As a result, it was possible for a program
> to verify, but then to attempt to read out-of-bounds data at runtime
> because a too small stack had been allocated for it.
>
> Each function tracks the size of the stack it needs in
> bpf_subprog_info.stack_depth, which is maintained by
> update_stack_depth(). For regular memory accesses, check_mem_access()
> was calling update_state_depth() but it was passing in only the fixed
> part of the offset register, ignoring the variable offset. This was
> incorrect; the minimum possible value of that register should be used
> instead.
>
> This tracking is now fixed by centralizing the tracking of stack size in
> grow_stack_state(), and by lifting the calls to grow_stack_state() to
> check_stack_access_within_bounds() as suggested by Andrii. The code is
> now simpler and more convincingly tracks the correct maximum stack size.
> check_stack_range_initialized() can now rely on enough stack having been
> allocated for the access; this helps with the fix for the first issue.
>
> A few tests were changed to also check the stack depth computation. The
> one that fails without this patch is verifier_var_off:stack_write_priv_vs=
_unpriv.
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=3D1qbuZUi20tGoUXoU0=
7FPf-5FLvhOKOY+Q@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 67 ++++++++-----------
>  tools/testing/selftests/bpf/progs/iters.c     |  2 +-
>  .../selftests/bpf/progs/test_global_func16.c  |  2 +-
>  .../bpf/progs/verifier_basic_stack.c          |  8 +--
>  .../selftests/bpf/progs/verifier_int_ptr.c    |  5 +-
>  .../selftests/bpf/progs/verifier_raw_stack.c  |  5 +-
>  .../selftests/bpf/progs/verifier_var_off.c    | 62 ++++++++++++++---
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ---
>  tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
>  9 files changed, 93 insertions(+), 73 deletions(-)
>

LGTM, thanks! (and yes, changing prog type for test is fine)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index af2819d5c8ee..bdef4e981dc0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1685,7 +1685,10 @@ static int resize_reference_state(struct bpf_func_=
state *state, size_t n)
>         return 0;
>  }
>

[...]

