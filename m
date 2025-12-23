Return-Path: <bpf+bounces-77346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69334CD8429
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3B4E300CD73
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3852FFDCB;
	Tue, 23 Dec 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNa7pIs0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC428682
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471592; cv=none; b=A868pGNh9MTDwwES/jKyrxQOAz8h/DPSegTlQKi+921FIq77H87utqXrqsg9TDrlmQ9f7n19KV9KHmJjjHAWJ3piWQQTEdugmqM/LI2vSEK+vr774lIHDolK27Bb7qguilpHPoFDYTf4Ofa4Y7eGeV/s3l4zGQffu86MuQnCGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471592; c=relaxed/simple;
	bh=/opdXYTcKn4d+jSs9pzOsAzTTz0Z/OBsFis2udrY0AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEp/kHm+pSzdzb5UG98CRkuZ+vjw+36sLE3LkmQk2Dg8045TQRKhMlrWr90s3T9KisFpbOZVRrgyauOMZ2nwbuEMd+90JpxS4cwU/338/aMEHlxCOvSaOahYKtwvktmB2zHBy+8lqJpXxT82wtHTLDII45PAEp0doYPsoTjA1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNa7pIs0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso30699405e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 22:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766471588; x=1767076388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVud5hKf1SdEHoVrpZgJkLYYvoiChlkSO0Xv+KqqVxo=;
        b=iNa7pIs0KmMnlrzcGuch6Q773Ovc7hMAHKAI0FR46qOfoTbG0DIcNVlTthz99U0IRR
         8P4/10k6ZVugzQWtecQbGehC+OsEj2mlH18QPIOKinWiaksXwB0A11tqtlH7Jc9EJENU
         9euErH6iyVtZ57la8KrOERa6XTEfYibrPMV/sxiXTX1JXMiqIz3ebvlfdMbMiA/pPbA5
         azcOVbqGs6RiF7zgGZLZZWv9lb5og7q4Bdqvn/itqcY2pO7QineWTNBZkh0TTwMSHsVF
         WACw6Evx+K7XFPEG7u9N288WZDxznHdCu1WGP/yEbuqGXb6w2BZsS7+T/hVL9VhI3K5Z
         1TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766471588; x=1767076388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVud5hKf1SdEHoVrpZgJkLYYvoiChlkSO0Xv+KqqVxo=;
        b=NXpHYO83i9YP4whI3a5p59JxtRaxoVtVU/p7IaspXP2XXd+0VVPplznaX4zBuxZFqP
         7d/6lNIgF1YJQVD1w5YXLk7NoAqTNcF/7sZm1Qjyaa4Nx7dskH6i4cbk9JOzfx09EDJB
         +bvk1BuJpvxZ4otMGzcJJ8mKDOX8HQl6AGWvjEOP1bvd1L662rcP+yw10E3IR8uyT/WC
         mJnHTjzBlfYtsxqLgh4Ii0MzFCmr8ZtmsABoBSYZWKL6nUgXOe0ZTP29xv8m03E7uuza
         szGAikNJ+LzQa6wXDc4hf6EvABq9fNWM+xZriUBkrQ4ojq5t8qDNQvmyKf8fsHYVWVz0
         215A==
X-Gm-Message-State: AOJu0Yz0kGTgxqYuK5G8iLrjdGWcOYcmjGVZddqVjgd5ttOWq0KAW8Q6
	bp8DHg5TZHQA1HcRTAz3kKGrFsKtQQlx8MilM84gxDTyc46TL+Xz5K3ilEfJDsVnSYoEOERE0b9
	e3KSksdmobLkdYn689KmjTS2LrMP696Y=
X-Gm-Gg: AY/fxX4Ws32f8BTRFpKSultTZrpVaToTqpp8yZuyR4onvHYIDaz5UsPjD0YHZ3h99I8
	emGZjdEhGMoWkOWT67BW9oADhw9icHCjWFBw6XKPyu6JL6Jb/Tv3TZGHLu/Er3MqUZb1moSFowR
	bTM1XuTVqvaFUDA2HE7FR05oy+nj1+mD1wWX77A2Bj3AqhCnz7xtaclgTmErRyUY5+Bmm8pPIbm
	jkCfnSSohfVyKQl/UrAHSJ4/j3Z8OyHwB4Oc34qS+V76yhZGIcdUebH5WWq4HKMuDsoNLHHDVu3
	0lHuwrw=
X-Google-Smtp-Source: AGHT+IEK8Tj3+gk5u38AaUT3lhBrXN2mKo45RRTLgPq8UbJ7RBENtmzj0UxYKFHC1ehARXayXMdrErvqN+UqFVVyzk4=
X-Received: by 2002:a05:600c:5288:b0:47a:75b6:32c with SMTP id
 5b1f17b1804b1-47d19532f91mr111861935e9.2.1766471588264; Mon, 22 Dec 2025
 22:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222185813.150505-1-mahe.tardy@gmail.com>
In-Reply-To: <20251222185813.150505-1-mahe.tardy@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Dec 2025 20:32:57 -1000
X-Gm-Features: AQt7F2rfK3ADakYh_YLhk_rTnDxSgd2uqldJSIy5-UBpR3DozNmZ-u7AmUCWmrM
Message-ID: <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers print
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 8:58=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> Explicitly printing where prune points are placed within the
> instructions allows for better debugging of state pruning issues.
>
>         Live regs before insn, prune points (p), and force checkpoints (P=
):
>               0: ..........   (b7) r1 =3D 0
>               1: .1........   (63) *(u32 *)(r10 -4) =3D r1
>               2: ..........   (bf) r2 =3D r10
>               3: ..2.......   (07) r2 +=3D -4
>               4: ..2.......   (18) r1 =3D 0xffff8cb747b16000
>               6: .12.......   (85) call bpf_map_lookup_elem#1
>               7: 0..345.... p (bf) r6 =3D r0
>               8: ...3456... p (15) if r6 =3D=3D 0x0 goto pc+6
>               9: ...3456...   (b7) r1 =3D 5
>              10: .1.3456...   (b7) r2 =3D 3
>              11: .123456... p (85) call pc+5
>              12: 0.....6... p (67) r0 <<=3D 32
>              13: 0.....6...   (c7) r0 s>>=3D 32
>              14: 0.....6...   (7b) *(u64 *)(r6 +0) =3D r0
>              15: .......... p (b7) r0 =3D 0
>              16: 0.........   (95) exit
>              17: .12....... p (bf) r0 =3D r2
>              18: 01........   (0f) r0 +=3D r1
>              19: 0.........   (95) exit
>
> Also uses uppercase P for force checkpoints, which are a subset of prune
> points (a force checkpoint should already be a prune point).
>
>         Live regs before insn, prune points (p), and force checkpoints (P=
):
>               0: .......... p (b7) r1 =3D 1
>               1: .1........ P (e5) may_goto pc+1
>               2: ..........   (05) goto pc-3
>               3: .1........ p (bf) r0 =3D r1
>               4: 0.........   (95) exit
>
> Existing tests on liveness tracking had to be updated with the new
> output format including the prune points.
>
> This proposal patch was presented at Linux Plumbers 2025 in Tokyo along
> the "Making Sense of State Pruning" presentation[^1] with the intent of
> making state pruning more transparent to the user.
>
> [^1]: https://lpc.events/event/19/contributions/2162/
>
> Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  kernel/bpf/verifier.c                         |   9 +-
>  .../bpf/progs/compute_live_registers.c        | 172 +++++++++---------
>  .../selftests/bpf/progs/verifier_live_stack.c |  18 +-
>  3 files changed, 102 insertions(+), 97 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d6b8a77fbe3b..a82702405c12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24892,7 +24892,7 @@ static int compute_live_registers(struct bpf_veri=
fier_env *env)
>                 insn_aux[i].live_regs_before =3D state[i].in;
>
>         if (env->log.level & BPF_LOG_LEVEL2) {
> -               verbose(env, "Live regs before insn:\n");
> +               verbose(env, "Live regs before insn, pruning points (p), =
and force checkpoints (P):\n");
>                 for (i =3D 0; i < insn_cnt; ++i) {
>                         if (env->insn_aux_data[i].scc)
>                                 verbose(env, "%3d ", env->insn_aux_data[i=
].scc);
> @@ -24904,7 +24904,12 @@ static int compute_live_registers(struct bpf_ver=
ifier_env *env)
>                                         verbose(env, "%d", j);
>                                 else
>                                         verbose(env, ".");
> -                       verbose(env, " ");
> +                       if (is_force_checkpoint(env, i))
> +                               verbose(env, " P ");
> +                       else if (is_prune_point(env, i))
> +                               verbose(env, " p ");
> +                       else
> +                               verbose(env, "   ");

tbh I don't quite see the value. I never needed to know
the exact pruning points while working on the verifier.
It has to work with existing pruning heuristics and with
BPF_F_TEST_STATE_FREQ. So pruning points shouldn't matter
to the verifier algorithms. If they are we have a bigger problem
to solve than show them in the verifier log to users
who won't be able to make much sense of them.

It's my .02. If other folks feel that it's definitely
useful we can introduce this extra verbosity,
but all the churn in the selftests is another indication
of a feature that "nice, but..."

pw-bot: cr

