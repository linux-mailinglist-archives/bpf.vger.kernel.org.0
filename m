Return-Path: <bpf+bounces-66071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB3B2D8BA
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E766F1C47AE1
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405012DECC0;
	Wed, 20 Aug 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3/vUVAf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7D27877B;
	Wed, 20 Aug 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682519; cv=none; b=YnuH6nWIB7yCs8mIIoxs5Y+erY8Q814QTlmnsE+z8VGx2gKteLYKCCcu//j6vVUe/LODL/vCxRzLfZhsdpn849sAnrjcrA7vNF3ikHPGrvlC5AQ/LvqRPCHxRLCKvF368neJ8SBLDX7w864Rws60yqBFMDtIuRQ/hDAX2JGOkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682519; c=relaxed/simple;
	bh=5GwCI12CU1GJTHyQ3tDi8JEL/+TYDbAU4gqgrpA0C0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmhYhrNN8r4z3BR2LBJ0aRfcybnM9RpBaS6oN2Id3m6qT5quwimREASVX1NO9+1hP+/nJ1t64AwRdte10X7Pq/ZijcN11jNJhKdBesV7I+FMOadeKuOfddwsuokWadKRdiOCnb1zK11WEQLNyWhnm/t4zjPT5sUrJrvbBGDtk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3/vUVAf; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6188b5b11b2so7705500a12.0;
        Wed, 20 Aug 2025 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755682516; x=1756287316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNVeEm5XhdBpT7eUdLFg7DGJnmMc3Txy3EfKiydyTJk=;
        b=f3/vUVAfiyQZCOCG7yiptF9fQv3MF7gHzcJUUoS9f2Sw6Ypj937NjPPZAyyviWvZpd
         ASOvyaGPb0dELD8TlGpPXMTKPhlvMuMQk+kSyXsa0nQ/mP7g7NC/sHad2z/oo6e0Zk8C
         DRkIW9wR1AjF5GiXn0JB5kGd/h8fuCVbZyTf9TFyGnjJGQeLWO8NURAWZbEFD0unMwoV
         c/kgimPHDGprH+gRsxVoU9FFwknJMa0npw1/AHxZhQhf/VxPI7X/YLnlQfQWP4OZI8mq
         bkNHcZpzOSMqIIp2LkwCSsOkN3gJhhIC7ReYOs287hEEGjf3AwPB5ARCDzV0LO/99A4d
         DkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682516; x=1756287316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNVeEm5XhdBpT7eUdLFg7DGJnmMc3Txy3EfKiydyTJk=;
        b=AWDTTlissKVygJXlhCufxXFMQPjK4C33zb6VCP0SG0bYS92OClBGm/YvZjAhzKni3G
         uZLlrLLYUOZTPNaFjA389Wcmg3CIJ8N1IclY38FCuH77QHtS7x10HNX3WcvVB2u9Rk5q
         si+ka0ocRCCgCJhsErcL908w1BppqDBz1DOiZ1NetNhpBkBb42TGUtfz7phEswZSGqbU
         moYTc48l9B8Rq1oF9UGRFpK3KeQQvbwkV9n+uh67egLL7Uaog6dV5ct8oqoSzJjYVgG8
         YUtJPowSUlPCfKvKIq5XlJeCLaMtwWEV8/TFod7HtTy2nXdwAlSZ/tOxw+4ydP18l8si
         T5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVlyP+7YCbqfwsCQxLvmxSONrtJVTJXOg5cdiY6rCq9HyPRki9eOn6Z7Mo7NTWuqxoWTdkzia719/elx/Ov@vger.kernel.org, AJvYcCWM7rjTJn7w13RGm3xP+dCOcClKOhX7/tFLs8fRYM64DhsM0kSFgmXt6MnP3SkHlJXcgzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEo2ZSnjpCKL4Od2r3U/K3FA+NeHHLglaP/XmjcC4iHq29Abae
	0CRyX3cGygv++BetIW5I02lDqUT426XdmrjleAem1pO/6iUHbq0bZPaIxwh61CakGtAGueFfFF8
	u6F6/XW6BrXmqctv8X0FZMMDJecfxUWg=
X-Gm-Gg: ASbGnctXqA3tE8Zs9DP9HnFbrYGdqT5dHz+oXcjZohc151uD5/SHTLstGL6CffaWB3X
	t5VHL8mYIhb4/VDGX9rkS3BaU77jN//p7+oeCFXTgiKJztWogkW/D95mAqnHnnWuwrc10k7psbR
	uYpM/Opaggm3GV7UfhXyrpqMrZhqdQEfmYbo9w6QgAJy+Don6loKc07elwgthZcf04P5c6NUbC0
	pe1OxGquO/Bdo6HGssb
X-Google-Smtp-Source: AGHT+IHBth0y2AoBjyW+FSstnXpJk7GFg8YiBsBpirEqa2CurHSrua29TJ4cbd0mGJpW+ZWyp820YdytDUDw2fC5XFs=
X-Received: by 2002:a05:6402:524c:b0:615:274e:6509 with SMTP id
 4fb4d7f45d1cf-61a9754e59emr1633953a12.9.1755682516017; Wed, 20 Aug 2025
 02:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-7-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-7-roman.gushchin@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Aug 2025 11:34:39 +0200
X-Gm-Features: Ac12FXxn2NcyTwhNtOzVYKNCNtBqfk-dMrPX2NDgw7posh_y0GfGmoA2HZDRcuA
Message-ID: <CAP01T777JF7wvHDaQ-Bz-Vp_dFM=NXvpAK0RY7kLjs2amEd85Q@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] mm: introduce bpf_out_of_memory() bpf kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 19:02, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
>
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
>
> If the wait_on_oom_lock argument is not set, only one OOM can be
> declared and handled in the system at once, so if the function is
> called in parallel to another OOM handling, it bails out with -EBUSY.
> This mode is suited for global OOM's: any concurrent OOMs will likely
> do the job and release some memory. In a blocking mode (which is
> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
>
> The function is declared as sleepable. It guarantees that it won't
> be called from an atomic context. It's required by the OOM handling
> code, which is not guaranteed to work in a non-blocking context.
>
> Handling of a memcg OOM almost always requires taking of the
> css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
> also guarantees that it can't be called with acquired css_set_lock,
> so the kernel can't deadlock on it.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/oom_kill.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25fc5e744e27..df409f0fac45 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1324,10 +1324,55 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>         return 0;
>  }
>
> +/**
> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
> + * @memcg__nullable: memcg or NULL for system-wide OOMs
> + * @order: order of page which wasn't allocated
> + * @wait_on_oom_lock: if true, block on oom_lock
> + * @constraint_text__nullable: custom constraint description for the OOM report
> + *
> + * Declares the Out Of Memory state and invokes the OOM killer.
> + *
> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oom_lock
> + * is true, the function will wait on it. Otherwise it bails out with -EBUSY
> + * if oom_lock is contended.
> + *
> + * Generally it's advised to pass wait_on_oom_lock=true for global OOMs
> + * and wait_on_oom_lock=false for memcg-scoped OOMs.
> + *
> + * Returns 1 if the forward progress was achieved and some memory was freed.
> + * Returns a negative value if an error has been occurred.
> + */
> +__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
> +                                 int order, bool wait_on_oom_lock)

I think this bool should be a u64 flags instead, just to make it
easier to extend behavior in the future.

> +{
> +       struct oom_control oc = {
> +               .memcg = memcg__nullable,
> +               .order = order,
> +       };
> +       int ret;
> +
> +       if (oc.order < 0 || oc.order > MAX_PAGE_ORDER)
> +               return -EINVAL;
> +
> +       if (wait_on_oom_lock) {
> +               ret = mutex_lock_killable(&oom_lock);
> +               if (ret)
> +                       return ret;
> +       } else if (!mutex_trylock(&oom_lock))
> +               return -EBUSY;
> +
> +       ret = out_of_memory(&oc);
> +
> +       mutex_unlock(&oom_lock);
> +       return ret;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_oom_kfuncs)
>  BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_oom_kfuncs)
>
>  static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
> --
> 2.50.1
>

