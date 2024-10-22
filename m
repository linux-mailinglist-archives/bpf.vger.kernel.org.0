Return-Path: <bpf+bounces-42725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2469A9627
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEAF283F1B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2412FF72;
	Tue, 22 Oct 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzcna/RP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206987F460
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 02:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563501; cv=none; b=B6gzWd+iGwOwsKo+vT7tXfQui7+oY0J3uyhqGtOOCgViLflDVTFaay7fWcXGN/bU53PDmxWjZNuyWCem5UKbxDGQ7haLoxVON+yTlDiJTHvwAQ7WD38IUyhnv9wWgHhqvO43NdP39vAQN82g81jT0Z9HmQz4IADrz7IFndURtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563501; c=relaxed/simple;
	bh=+ZWgRaMukwEFLbe4I3ekE46Oy2tJvZZoN/fo5U93Yjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1IjvThyfuOekMt8PIupS2I5mEgdy9SHGuwM+9zzFvdTtskFmIa7deMBBnfG6HcHHQHZSPQ2023WXKb4NefRIresn+h0jFVDnv/zKf67X/NNdsZ9zEtfGeFRf6Wr5cJCFFyD08x0C7hB2MaqJ3RqOK9o3Os1vTc7px9eo9wWhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzcna/RP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314f38d274so70119425e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 19:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729563498; x=1730168298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4eVkAWw27Pg+A2gbl+axkruGaKbpsaMdIvCtecgk/E=;
        b=Wzcna/RPGmW83c2RONRIKNIRVtbYJYdl1/otP3pM9Waq2q2L9990EkSfxdZ2mq4HbV
         8eBMl/Y2O7iU4IAmx6tNBfJakgSb2zX1GEp+5Ldo7gn+BjcxYyFOBuRZeXJu6PkGOFNC
         HjatwXYKQ97cm7YwG5C0PqO9qaix6EKLvzMjRKNxlZcUnZpYYk0wKjLOpjBgUFuZdxPr
         vKFOryixjOjfFqO3ieVDqvwwJfamsdhl3HLg6Q1cOxtgupCGr3rnT3E3c3JdeA68Ecfh
         PSwSHtv37NMb8DfoYs5PNwMqkjj+XWhpe7jzy8g8xguFFZEI1OIUzHUsB0pwZr6D/grr
         ycFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729563498; x=1730168298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4eVkAWw27Pg+A2gbl+axkruGaKbpsaMdIvCtecgk/E=;
        b=NXO1EhHipTBejc+ig+VveV6uTTTr6bHFXfvf+jUxgneajt36XRaPFFSG+H6w2cfErZ
         ehix5TyHaMb6lNzqHJVyCpHFVrx6KJQykr4Hgh9IxrKN2AoXPgDdtCF4mgeDdFcrFvWo
         7OG9KXuOLYOCLLVeY/R85ryEEw4uKBUA41ypLoKsTdKSHqxIhDHfRi6oFz5PUX+4P81j
         w+obLeDHD7YurygoiWKfDzhPv6ocPwsN3RNAp3wUCvOUBjZ5151gSlWow6xBoXkO/350
         c45us+7ubVL0wV3fY0CK6a01iUO+uscNiMpLLNn4EGIWMX9L9HMK0y/htwz6JDu3pcIX
         kL2w==
X-Gm-Message-State: AOJu0YyRObCu1kZ/7CcUBhP3ed0t/vid+ykWSRhPM6KBCpApqprJewom
	BLGJuKomGPv0xlRJtA8EAar363zx4qWbYb/jGZ6A1dgJ3THeIljF74H1+uYReopCxSPgJTa8qCr
	nyhRSKPaWpSOppvgUwEStIa4FTJg=
X-Google-Smtp-Source: AGHT+IFjJo2cXX9Onr7XYVZSv3/pQPSegT/d2MUR0sXQvav+wt++y33jQEXuH07DTZIceUbudwClkyeRtOX15rLEi9Y=
X-Received: by 2002:a05:600c:c84:b0:431:6083:cd30 with SMTP id
 5b1f17b1804b1-4316161ee40mr149410355e9.6.1729563498272; Mon, 21 Oct 2024
 19:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020307.1766906-1-eddyz87@gmail.com>
In-Reply-To: <20241018020307.1766906-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 19:18:07 -0700
Message-ID: <CAADnVQKtR96Dricc=JiOi3VR9OeHjgT6xLOto9k_QcpPQNsKJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is
 too long
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 7:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> A specifically crafted program might trick verifier into growing very
> long jump history within a single bpf_verifier_state instance.
> Very long jump history makes mark_chain_precision() unreasonably slow,
> especially in case if verifier processes a loop.
>
> Mitigate this by forcing new state in is_state_visited() in case if
> current state's jump history is too long.
>
> Use same constant as in `skip_inf_loop_check`, but multiply it by
> arbitrarily chosen value 2 to account for jump history containing not
> only information about jumps, but also information about stack access.
>
> For an example of problematic program consider the code below,
> w/o this patch the example is processed by verifier for ~15 minutes,
> before failing to allocate big-enough chunk for jmp_history.
>
>     0: r7 =3D *(u16 *)(r1 +0);"
>     1: r7 +=3D 0x1ab064b9;"
>     2: if r7 & 0x702000 goto 1b;
>     3: r7 &=3D 0x1ee60e;"
>     4: r7 +=3D r1;"
>     5: if r7 s> 0x37d2 goto +0;"
>     6: r0 =3D 0;"
>     7: exit;"
>
> Perf profiling shows that most of the time is spent in
> mark_chain_precision() ~95%.
>
> The easiest way to explain why this program causes problems is to
> apply the following patch:
>
>     diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>     index 0c216e71cec7..4b4823961abe 100644
>     \--- a/include/linux/bpf.h
>     \+++ b/include/linux/bpf.h
>     \@@ -1926,7 +1926,7 @@ struct bpf_array {
>             };
>      };
>
>     -#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
>     +#define BPF_COMPLEXITY_LIMIT_INSNS      256 /* yes. 1M insns */
>      #define MAX_TAIL_CALL_CNT 33
>
>      /* Maximum number of loops for bpf_loop and bpf_iter_num.
>     diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>     index f514247ba8ba..75e88be3bb3e 100644
>     \--- a/kernel/bpf/verifier.c
>     \+++ b/kernel/bpf/verifier.c
>     \@@ -18024,8 +18024,13 @@ static int is_state_visited(struct bpf_veri=
fier_env *env, int insn_idx)
>      skip_inf_loop_check:
>                             if (!force_new_state &&
>                                 env->jmps_processed - env->prev_jmps_proc=
essed < 20 &&
>     -                           env->insn_processed - env->prev_insn_proc=
essed < 100)
>     +                           env->insn_processed - env->prev_insn_proc=
essed < 100) {
>     +                               verbose(env, "is_state_visited: suppr=
essing checkpoint at %d, %d jmps processed, cur->jmp_history_cnt is %d\n",
>     +                                       env->insn_idx,
>     +                                       env->jmps_processed - env->pr=
ev_jmps_processed,
>     +                                       cur->jmp_history_cnt);
>                                     add_new_state =3D false;
>     +                       }
>                             goto miss;
>                     }
>                     /* If sl->state is a part of a loop and this loop's e=
ntry is a part of
>     \@@ -18142,6 +18147,9 @@ static int is_state_visited(struct bpf_verif=
ier_env *env, int insn_idx)
>             if (!add_new_state)
>                     return 0;
>
>     +       verbose(env, "is_state_visited: new checkpoint at %d, resetti=
ng env->jmps_processed\n",
>     +               env->insn_idx);
>     +
>             /* There were no equivalent states, remember the current one.
>              * Technically the current state is not proven to be safe yet=
,
>              * but it will either reach outer most bpf_exit (which means =
it's safe)
>
> And observe verification log:
>
>     ...
>     is_state_visited: new checkpoint at 5, resetting env->jmps_processed
>     5: R1=3Dctx() R7=3Dctx(...)
>     5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=3Dctx(...)
>     6: (b7) r0 =3D 0                        ; R0_w=3D0
>     7: (95) exit
>
>     from 5 to 6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
>     6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
>     6: (b7) r0 =3D 0                        ; R0_w=3D0
>     7: (95) exit
>     is_state_visited: suppressing checkpoint at 1, 3 jmps processed, cur-=
>jmp_history_cnt is 74
>
>     from 2 to 1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
>     1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
>     1: (07) r7 +=3D 447767737
>     is_state_visited: suppressing checkpoint at 2, 3 jmps processed, cur-=
>jmp_history_cnt is 75
>     2: R7_w=3Dscalar(...)
>     2: (45) if r7 & 0x702000 goto pc-2
>     ... mark_precise 152 steps for r7 ...
>     2: R7_w=3Dscalar(...)
>     is_state_visited: suppressing checkpoint at 1, 4 jmps processed, cur-=
>jmp_history_cnt is 75
>     1: (07) r7 +=3D 447767737
>     is_state_visited: suppressing checkpoint at 2, 4 jmps processed, cur-=
>jmp_history_cnt is 76
>     2: R7_w=3Dscalar(...)
>     2: (45) if r7 & 0x702000 goto pc-2
>     ...
>     BPF program is too large. Processed 257 insn
>
> The log output shows that checkpoint at label (1) is never created,
> because it is suppressed by `skip_inf_loop_check` logic:
> a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
>    onto stack and proceeds to (3);
> b. At (5) checkpoint is created, and this resets
>    env->{jmps,insns}_processed.
> c. Verification proceeds and reaches `exit`;
> d. State saved at step (a) is popped from stack and is_state_visited()
>    considers if checkpoint needs to be added, but because
>    env->{jmps,insns}_processed had been just reset at step (b)
>    the `skip_inf_loop_check` logic forces `add_new_state` to false.
> e. Verifier proceeds with current state, which slowly accumulates
>    more and more entries in the jump history.

I'm still not sure why it grew to thousands of entries in jmp_history.
Looking at the above trace jmps_processed grows 1 to 1 with jmp_history_cnt=
.
Also cur->jmp_history_cnt is reset to zero at the same time as
jmps processed.
So in the above test 75 vs 4 difference came from jmp_history
entries that were there before the loop ?

