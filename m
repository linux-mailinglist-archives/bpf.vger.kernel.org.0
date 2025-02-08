Return-Path: <bpf+bounces-50833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3504A2D2E2
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CF33A461B
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE11465A5;
	Sat,  8 Feb 2025 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU9g4qrZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABB8F5C;
	Sat,  8 Feb 2025 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980304; cv=none; b=VkAfTbUCkkUg8wmyxIQ3l5NfkdHrGSnltGlPlNWxggajxWq36mGtah4SRwlugkNdmQahCfTuIpKJOdvxcadoqtLZKYjCKEgbjas2L0QARorPJ0MR3jV2aJw0kJlzGvymUwjJ9VC/zmWyZPH+g4+z685Pk5mN1dr1bm5eNmftows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980304; c=relaxed/simple;
	bh=R/fQ8T18/YAfqZoU6ZIDT+mBbs9GK5KJ8HzhJiilrqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6SnTNT8MwI/oI7hsd1bmKbCLtRTKD2BDAiVokKa5WJ1D35VV2jaXbcbClorM8OELRdF1xNS8kiKejvsMuMCnhRqoFjlM9Yiv0XV3vYQeUnE4HjRIyFfEjE0MeW6ULNP1mA1u5zso7iihf2Z7EICOx0qA9T/yWwdKxMOx4dQJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU9g4qrZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dd4e26e79so28685f8f.1;
        Fri, 07 Feb 2025 18:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738980301; x=1739585101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLAWLSHy0TSwl7+tgWW0CQncnxmp+W5DE/5jbJvqW4U=;
        b=KU9g4qrZZnn/4+2altepSQenyOw4KfT3mlcO3lLdZPe5uiUlMYjFUezwgwB1WAq519
         lym4cQOXzEPrD2Aidq1KyRWeHvlHXp448kxrDbWWq6ACWZnYFRXFQ1Mo1OEzRLjYcPnd
         aketVcGKXF9yhXfXYIeT2T6fP3FjNlYUPbCkIiXWLlEj4y6w7TOKIPGRpKgv1HjokbUw
         L1nOeFQdgMtCADAIVVgUu/ClalBKGZug2zYHDYPF+8NaD36X1RZCQ0B5HIygb3pVFadX
         qIHvaX3iZBou8wR0uxoCjzovYelAN/pkqNVw4kskbLeOAtLoeAjyeFWRvY78lFSDwDdp
         /arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980301; x=1739585101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLAWLSHy0TSwl7+tgWW0CQncnxmp+W5DE/5jbJvqW4U=;
        b=sgJ2ZONoQ27eQAQ5fGIwVfMhrTe29G5IFKcBcPviQO7lm+w5SMgZGru9yXrlvYn5t5
         HilINeRB9a4NEGNjRFEIgxdaW8zPkEf0St0yt6wNEspu41GVxmfZw9Ap/e4Z6G+aC6a8
         xuNUjEfkEZFjXC5LP4aqnvL1st4LO+1t4fv6fqPbwrvgIauhdUmRc4rebeJ5pFpcWwaA
         YkUxGyEegxB0PUDKd+RdSg8/2N0hVBWCLZpSKbTPeZOiJoC5cNvXuap4BSY+D67h2lRE
         Wz9/vMO/t0/8IRndKn8b29Z2m0+SNoKrGn/UGSr8PJCJypogqL42pHRRkkH0WxmJgWrp
         JaSA==
X-Forwarded-Encrypted: i=1; AJvYcCXG4dn/rygbRGRU4vZavw0pQG98rdhK4wewUaoKQLzF++oZ/FGZxi/OyakxX/fv1/iK/gosiP/U39ThfFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBbtrQ6EdA/WCpDRcZrunJjF2KUlilqGZaxH7QTVPsvwoAyh/
	57g9CndukUFxAwYqK9htzWYj4x/kLJsaIOOeB8aT3VIA/RnVyrDk03acHG20VYAPRy77QAxZ1U9
	4pDPU8wIyidFSKRWG7sTYKjBE430=
X-Gm-Gg: ASbGnct8vtQr5yNxLB8mz+IOpdolw8u1McXOQ67gpmJTQ7h582Rk+wO53H+WCxPumxD
	RLoAS5Vx8c/uqSC5MYwJKc2LT7ZL3WoheFq6Gg5zh9PIB8tIm+l4k/Vl8WchjodOMXAn/O80hVl
	dM5wCrHRSwLRxv9pjy0g9x1hwh4rpy
X-Google-Smtp-Source: AGHT+IGLStgu8AXC9q/i8f9nQHUBuaSfxwvSq8Eg4fLl4TJeqHMutcRrjl7FjFaKlKFT+6nEI2m4IxYOG5h5nun2Xvk=
X-Received: by 2002:a5d:6d0d:0:b0:385:f1f2:13ee with SMTP id
 ffacd0b85a97d-38dc935f47dmr3503009f8f.46.1738980300974; Fri, 07 Feb 2025
 18:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-24-memxor@gmail.com>
In-Reply-To: <20250206105435.2159977-24-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 18:04:49 -0800
X-Gm-Features: AWEUYZlLTRyf_ClCJ_SG_e1Sm6AP8DlaHhKMYR5f6FACR-Jnh5gK8pkaAR7oKxc
Message-ID: <CAADnVQK8+-nkvDnBq=pVkadPX9zASdTSEDn6bUe7hqgs=Bm_iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 23/26] bpf: Handle allocation failure in acquire_lock_state
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:55=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> The acquire_lock_state function needs to handle possible NULL values
> returned by acquire_reference_state, and return -ENOMEM.
>
> Fixes: 769b0f1c8214 ("bpf: Refactor {acquire,release}_reference_state")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..d6999d085c7d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1501,6 +1501,8 @@ static int acquire_lock_state(struct bpf_verifier_e=
nv *env, int insn_idx, enum r
>         struct bpf_reference_state *s;
>
>         s =3D acquire_reference_state(env, insn_idx);
> +       if (!s)
> +               return -ENOMEM;

I'll grab this fix into bpf tree.
Next time just send it separately, so the fix is not lost
in the patch bomb.

