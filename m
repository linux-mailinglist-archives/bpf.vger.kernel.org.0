Return-Path: <bpf+bounces-58072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB6BAB481A
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 02:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82D716B5E5
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E902904;
	Tue, 13 May 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/GT9rdX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF8A50
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094648; cv=none; b=Tap0smf0er24IFr89qFX3Ee816bCOHym/Q4zlRCnJOXR+xV3V+CAfzLD4TcEyFt1HEttLLDX15yO6GVhFfBgIhPOTBK4nMIRvSyLAOw2WBXvwHf/dkk2ovxWBSvk4BsdXirUEhNtR/91GyJevIudJIpfW5nDf6Mi/tWQgw2Gd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094648; c=relaxed/simple;
	bh=0rYqSIzbWDhIng9XUwXJy5y21lNjI3qwcPeQ6e9uYio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHEqRBVejUC4m6fI6qrBNlfOKPvPJcgpC5MUSowKUqrjXhq0ByFMquXEcQWkFc+jKPu7CtHVY8BXl2qrYAoMzlO0RbMvjuCJEsSv926f76ACd5f5du9s518PkM5TtMVksKvs8YAzUF4MAOWMeBcbZmCfpA5LLjToDQQk6BXtTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/GT9rdX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0bdcd7357so3444565f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094644; x=1747699444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00cBKkgSeRUoMww7st3tRmee8skuEWyxAbYnAFe6F20=;
        b=f/GT9rdXQXiAdsYyGOPyzBd4kX87a15xN+a2Ic65daiOQEjkaHfipqz9x936/2loDU
         R21P4AV6Bjfit2ExaB6MYlQj9Uceap5npL9HyfREGZJFVAxjTLydLsK2Bh2v+DF6GI32
         azkvEWWxjGFRzlYWxJSiiZc1rfexGmZLREvG/IVdBMMo+MGqskgp1qxCkILtLgrWaq+k
         SIOoFdZTz0N7XIrHQMZP7rmGlGAeLW8u5TWgO0AmJmMYvcishb3yDU56iL4D9WfD6z2x
         Sm+Dr0duUXmnervvgbqIBNRt2TPCl1eO2Qq3APF0pJ1FQetJA4spSsP9cxvUtA/YDKU/
         Mz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094644; x=1747699444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00cBKkgSeRUoMww7st3tRmee8skuEWyxAbYnAFe6F20=;
        b=cfKQwbElTmRyT5iyaZHpqQhvWMMXnYlugsntzItuNXpdYZLoRMOuPetQWoNZZ7K+fQ
         rtpcAIHowTplaSQcREnLTYMvA5imMdTo70tQ1TACHP2QNy9hLW1gNI3iKWfpsVqLLzFS
         Avybwyy0Ks9EHzG23fXr8vhrufD6xaE/8pmIxXd85s4hSc0JwXFQ64szq4QhiTwGRR15
         8guQNrrIQoskcHdzRjge7fImHP+SH6LQnWpgZn/2NWbs0d5a92Ws4uFECTyJonw43mlp
         tdbt4+ibnlb6zAEtkoF0YEETOPzoYpJ1L9WFoq2LpHZ+/NevObXZHUbnYr+3lCwZpJuk
         LV7g==
X-Gm-Message-State: AOJu0YzCjzG25ZhaKUyjiX2Ghv0Eph6Jw7UTJi6IeOiVKSNJ7aZ1nYTt
	DQFCBulW0Z0RQ9KMOqAzviSdXerzZP8Ed4hbWOSY5heXW/KeTBImCVEMozprZ12TCw00N1Sop2P
	2vovZ1u52kQy70j5EEf3yA38BmGY=
X-Gm-Gg: ASbGncuZ6VAsQ9GHF20TiIWe4aR8CJzuxkGFoZMORn5j94oJfb1TXB82CJ6eYQvfbAg
	RhooUjsiI81nlZp+FCxseLXYIrV5IE1MRIaxevSyJ5oYukBDSaeo1OsICiAGAI8/RvAQ0uNaMji
	zdg145K4KZ1He4/wvfA7yzKuhZT0hSjoKagKTJ0JuxtJA97azmN5iCd+Y+P3G15Q==
X-Google-Smtp-Source: AGHT+IEpMLE5EpU4Emq8CHn0W2T+rtieOU9YgBXloIdPJjUj9epkmUYSdW/xwdmglt99yA2kZ4NCdUBb3BaM4jL5bPc=
X-Received: by 2002:a05:6000:144c:b0:3a0:9de8:8a45 with SMTP id
 ffacd0b85a97d-3a1f64772d3mr12249024f8f.32.1747094643782; Mon, 12 May 2025
 17:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210246.3741193-1-memxor@gmail.com>
In-Reply-To: <20250512210246.3741193-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 17:03:52 -0700
X-Gm-Features: AX0GCFuub8nB2OIBEdrTY_2D-nB2WBGF_3LAPCFtZaVK19QDNB8_kx8GldybMFM
Message-ID: <CAADnVQ+6vYFkBKvwbFMiALVCAOgC2mXd-oM2Xw26uioudMbZGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Add __aux tag to pass in prog->aux
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:02=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Instead of hardcoding the list of kfuncs that need prog->aux passed to
> them with a combination of fixup_kfunc_call adjustment + __ign suffix,
> combine both in __aux suffix, which ignores the argument passed in, and
> fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
> passed into them without having to touch the verifier.
>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/helpers.c         |  4 ++--
>  kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
>  3 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9734544b6957..1d90e44a1d04 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -606,6 +606,7 @@ struct bpf_insn_aux_data {
>         bool calls_callback;
>         /* registers alive before this instruction. */
>         u16 live_regs_before;
> +       u16 arg_prog_aux;
>  };
>
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fed53da75025..2b6bac4bf6e3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3012,9 +3012,9 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, uns=
igned int flags)
>  __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
>                                          int (callback_fn)(void *map, int=
 *key, void *value),
>                                          unsigned int flags,
> -                                        void *aux__ign)
> +                                        void *aux__aux)

aux__aux is an odd name.
"__aux" as a suffix also looks strange.

How about "__prog" suffix ?
It will be similar to the existing "__map" suffix.

We can also standardize the argument name as
__bpf_kfunc int bpf_wq_set_callback_impl(.. , void *aux__prog)

then the name is more or less explanatory.

>  {
> -       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__ign;
> +       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__aux;

and here it will be:

+       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__prog;

which looks ok to me.

pw-bot: cr

