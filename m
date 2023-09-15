Return-Path: <bpf+bounces-10126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77237A139A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 04:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D301C20B76
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 02:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C31A4A;
	Fri, 15 Sep 2023 02:13:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471AA32
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 02:13:25 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E441FCC
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 19:13:24 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1d4e0c2901bso902478fac.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 19:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694744004; x=1695348804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSKO2avnAZx7/DlbfDBZ5AxZf8mTXmlkg0S8NR9KFQs=;
        b=ZGDjj9AisZubujSRnJ38S6X/9TOzKvZFyD8+DC4e/iZI2zmxtddd9EXRf3RrMw8rCu
         a+doF8QUOZsNO4Wi0WVlyS2YHHfZtlJQ/KQI5FhcRoejJ0JvtrK7z+fSRLzxo0Vg9glG
         M+t5s1+moHanPNbd/1oWZD50stbr54yTxm/L3lS1aUXQebqLOd6o7/YcC3LLXrF8h9ue
         d3nX3hlF/00vEqD4ke5rmkMwE0vO3WSdov822GBO4ZbZmSC5MSijjhfxyIoO8kcDtT8p
         N1F6yX/RylDV8Nuy0q2kanKOgTGg200+ycX8+FinrAeUoDv28Pk4vh62MpkiWccPBxmJ
         r/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694744004; x=1695348804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSKO2avnAZx7/DlbfDBZ5AxZf8mTXmlkg0S8NR9KFQs=;
        b=Pq3KBuS7eNPq6+hfgErt3ceTZc4teVO52nY5MTLvmEcn2/MbyCXZzM6oRUerWIT77R
         ircUSiqXW70fju+tmWg2Qhk0zrN95yVlIzDpqw9SZLU/Lt5cPlBxa/frJzcNaKoGf80Q
         MkvJLbL02i1D8xKPwBJWypPpz81L9QmufOf4nVSjlqRVp1qQbhzNOSi9aX1G9iP03u/4
         IErzmwpBcPUSXIMP4lc1PM+vM9/hrf52j+uutQV+0YJY4dGqk3Gta5oUJ0Zf6e8mJjdi
         nuZ6rUI3UWF9fi802YA0hBfWWLSipsvYkd1PierLYRJyDBIEnMqtdGZfYmRKS3qiMdqb
         F8wA==
X-Gm-Message-State: AOJu0Yzp/OEWR5kbPHJVa8T2PsFedBxvTCJJT5iEDZwIElpl6eTI34JT
	mwSkRraEmov8r60VNn5oPt2jUeOdCBkV0OCAmkYnnCmVJTq6G4Q3
X-Google-Smtp-Source: AGHT+IE2eCqeVHMvCaxrCVbtdFNXH9VhW21dVMla94WsEpS2zrQPM1DgOJWSFtTPYUt10mv1yB6FotWLnQtv0/fQEoM=
X-Received: by 2002:a05:6870:468e:b0:1bb:90c3:bb09 with SMTP id
 a14-20020a056870468e00b001bb90c3bb09mr507564oap.9.1694744004091; Thu, 14 Sep
 2023 19:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914145126.40202-1-hffilwlqm@gmail.com>
In-Reply-To: <20230914145126.40202-1-hffilwlqm@gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 15 Sep 2023 10:13:13 +0800
Message-ID: <CAEyhmHRAvR=Ch-DjMpmpB0zeUsbQYcTXkMqyTSL9iwmZukcTgw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix tr dereferencing
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, toke@redhat.com, sdf@google.com, lkp@intel.com, 
	dan.carpenter@linaro.org, maciej.fijalkowski@intel.com, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 10:51=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> w=
rote:
>
> Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.
>
> Like 'bpf_trampoline_get_progs()', return 'ERR_PTR()' and then check by
> 'IS_ERR()'. As a result, when CONFIG_BPF_JIT is turned off, it's able to
> handle the case that 'bpf_trampoline_get()' returns
> 'ERR_PTR(-EOPNOTSUPP)'.
>
> Fixes: 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to multipl=
e attach points")
> Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  kernel/bpf/syscall.c    | 4 ++--
>  kernel/bpf/trampoline.c | 6 +++---
>  kernel/bpf/verifier.c   | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6a692f3bea150..5748d01c99854 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3211,8 +3211,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>                 }
>
>                 tr =3D bpf_trampoline_get(key, &tgt_info);
> -               if (!tr) {
> -                       err =3D -ENOMEM;
> +               if (IS_ERR(tr)) {
> +                       err =3D PTR_ERR(tr);
>                         goto out_unlock;

IS_ERR does not check the null case, so this should be IS_ERR_OR_NULL inste=
ad.

>                 }
>         } else {
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e97aeda3a86b5..1952614778433 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -697,8 +697,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *=
prog,
>
>         bpf_lsm_find_cgroup_shim(prog, &bpf_func);
>         tr =3D bpf_trampoline_get(key, &tgt_info);
> -       if (!tr)
> -               return  -ENOMEM;
> +       if (IS_ERR(tr))
> +               return PTR_ERR(tr);
>
>         mutex_lock(&tr->mutex);
>
> @@ -775,7 +775,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>
>         tr =3D bpf_trampoline_lookup(key);
>         if (!tr)
> -               return NULL;
> +               return ERR_PTR(-ENOMEM);
>
>         mutex_lock(&tr->mutex);
>         if (tr->func.addr)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 18e673c0ac159..054063ead0e54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19771,8 +19771,8 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>
>         key =3D bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_bt=
f, btf_id);
>         tr =3D bpf_trampoline_get(key, &tgt_info);
> -       if (!tr)
> -               return -ENOMEM;
> +       if (IS_ERR(tr))
> +               return PTR_ERR(tr);
>
>         if (tgt_prog && tgt_prog->aux->tail_call_reachable)
>                 tr->flags =3D BPF_TRAMP_F_TAIL_CALL_CTX;
>
> base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
> --
> 2.41.0
>

