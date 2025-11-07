Return-Path: <bpf+bounces-73932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E5CC3E524
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 04:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 302A84E8EAE
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCD21578F;
	Fri,  7 Nov 2025 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePR9FXCA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89952A41
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485362; cv=none; b=BBc3GwtNz0qGUpw0sNW6a9kvk7/BhCD26fGPVo8CUJYVgwJhkMaqxuT03/PU5XCaTbYNDixX2nmPA4o0iuquY2Qqqj4xHIc5nou7OpPPU38wRqQbyUNwhxZWgOmkRx9w5vYF4qpzq62Bnrm4HzbmTQbEYq0JlMRSQuwrHLFBcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485362; c=relaxed/simple;
	bh=qOndkeinio0OBXH+oxJilwVE2OASODwazwipOjfVY+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEWBaUwNR10ImpZqNd/ZNHXNz29XHg9XtqcGZu12zDrw5VQXlLCNeUC5yNGGvjeTH5RLSt+InNicCIrFxJiGnqlSpsFSDOIrzFECk9rSBsCjoZbmSOyWmArMxNXBT6NrpN1k8Rbp2kdP7Z3J3xiYVF7spzaLkUOIB/xsbV7IBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePR9FXCA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso113729f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 19:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762485359; x=1763090159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3uHhLvHuYBBRM31ZoWHXMvwzHpz2sb37ptEfDkKdxM=;
        b=ePR9FXCAJQ4/pTENUz89vjQlxrGKYXMBDe71a1bjew4Wm6Oauf6MbYZ73sumkHRFfw
         T/aKKhonlcaol1cuz9V0+xWRI7EQ2jMxXU202wLERy6zAiX/rgrTBXtOICT51/0hD8Cv
         JJqtknp+g/lgbkYwHVFfz/7lxBpWaKX1Wg1GIZekz6lDvlL1fpPYPWSUF7B1xKocobju
         STKiVjRK9HgRifmp7cAu+kgB/zhlST9mDD00IlpQ74NdfjQTgSWMM19xeQCzCk9xWrXa
         9Kq+5oF+vMmMEyz6MYGDAGhX+ZIbqaGYxbtN7AGN/TdhOUP9ctKSymDIY6Da7opkx1/u
         Td7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485359; x=1763090159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3uHhLvHuYBBRM31ZoWHXMvwzHpz2sb37ptEfDkKdxM=;
        b=uUywUYt8tgIJcBYLtffk8dd8H4AVp2bEUGp+ZlQu2rRM0cwYJ8E1gcMNlM/S4oNxws
         8Ax0yxuApjkwhFMECNaLcggvKfjyjlefvmuEX3xd1l+B0LwCl96df1+8TOwb48kBZhpc
         sJFO1+UBpuCyoPmIcYimf4yHFH3+MyA7dV1bIa8SeW9532JErmCfxJFTAFKGY26D7NSE
         FUrNeUpwnTD6lOoXqFVuHKh3QM6Gfzm3hrO6/Sng0kpDN0tlP6FlesYeJcM/XAKxpPOw
         kBEzuy8FZityWNeIAMwLS/Q+WMRvOuRPyu9BAyVKl/1DkvdnpjrgVVc35VUIoDU+cA7E
         IVcg==
X-Gm-Message-State: AOJu0YytKZpsmnbhFs+eJv5L7XsaXHF0tJUFxvOWu7CVfw4jIrM2jYAZ
	pySHkdxmuE4byj3jumTnMyF/u3rAKALiGfauDgvdO5mrAE6zjCsdvym14UVTVpIg95pemAAFVyo
	j5ATCryHTDAmg8e3WVvVnrNLlF0wmAvQ=
X-Gm-Gg: ASbGnct2wNPtig0K8mNhurDY5Ru1G8CrOwBabNDIPL1EcSPDlrMgmm90q9CN2O5r7Vy
	lolWZHzcsKtL+6X0P7b5d9Ehp9P27pbknEHpdVhv3Y6PqnKq/qOOHK/QayjQeVKBaM2uy3/ShhD
	50SB72u1sgqOFxoWfcK29lNH5bnrsQI4OCtUPzV6JMZitgBw6NmK3f8Kyn3a4Pe+zK0tpkw6G00
	2B06mIJiT0pPixxw+7wXO8FeTOrtEEx16Vc+Nlo8wWkEMBSg4MMqVXHnt7kmPXmDkRcZRNqW1u8
	sVOPLiYW9u2zXght3Q==
X-Google-Smtp-Source: AGHT+IFJWa1vLjCNi2NTij1h52rsknCGoHFoGZpoObAED7d/ax0lDS3VQnJ/Kx5WAxIcCbpNS8gXiiW10bzu42WVbs8=
X-Received: by 2002:a5d:5d01:0:b0:429:cc35:7032 with SMTP id
 ffacd0b85a97d-42b26fc3d91mr127839f8f.23.1762485358711; Thu, 06 Nov 2025
 19:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com> <20251105-timer_nolock-v2-5-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-5-32698db08bfa@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Nov 2025 19:15:47 -0800
X-Gm-Features: AWmQ_bneToJK6puIFib1kf_JUPMsWHa6HMfLb4xJSMkFqVkLn2e2YTOWJ-A8egI
Message-ID: <CAADnVQK250aA9TjoJWwBtRP+e7j254d4CQ=_2Sr=0N0O2G0E2g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] bpf: remove lock from bpf_async_cb
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
> +
> +       guard(rcu)();
> +
> +       t =3D READ_ONCE(async->timer);
> +       if (!t)
> +               return -EINVAL;
> +
> +       /*
> +        * Hold ref while scheduling timer, to make sure, we only cancel =
and free after
> +        * hrtimer_start().
> +        */
> +       if (!bpf_async_tryget(&t->cb))
> +               return -EINVAL;
>
>         if (flags & BPF_F_TIMER_ABS)
>                 mode =3D HRTIMER_MODE_ABS_SOFT;
> @@ -1489,8 +1512,8 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *=
, timer, u64, nsecs, u64, fla
>                 mode |=3D HRTIMER_MODE_PINNED;
>
>         hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);

This doesn't pass the smell test for me.
I've seen your reply to Eduard, but
fundamentally RCU is a replacement for refcnt.
Protecting an object with both rcu and refcnt
is extremely unusual and likely indicates that
something is wrong with rcu or refcnt usage.
The comment says that extra tryget/put is there to prevent
the race between timer_start and timer_cancel+free,
but hrtimer_start/hrtimer_cancel can handle the race.
Nothing wrong with calling them in parallel.
The current bpf_timer implementation
prevents the race, but it's accidental. hrtimer logic can
deal with it just fine. So tryget/put prevents uaf,
but free is also done after call_rcu().
So the whole thing looks dodgy.
I bet state transitions can handle the race to
update cb, while rcu can handle lifetime.

The combination of state transition to BPF_ASYNC_BUSY
and xchg(prog) also looks weird. Why xchg() is needed
if BUSY indicates a prog being updated?
Because bpf_async_swap_prog() is called during the free part?
Then don't call it there and drop xchg.

Overall I see rcu, refcnt, cmpxchg(state), xchg(prog), cmpxchg(cb)
used to address various races and life time problems.
They're different mechanisms and typically are not combined together.
Mix and match makes them hard to follow and it will be hard to
change when/if we decide to support in_nmi() here.
I think the whole algorithm can be rewritten with couple
more states, then tryget/put can be dropped, and
xchg(prog) can be dropped too. refcnt will likely not be needed
anymore. We may need it back to support in_nmi() and
deferral to irq_work though.

Overall I feel we should decide whether we do in_nmi()
and design the whole thing.

pw-bot: cr

