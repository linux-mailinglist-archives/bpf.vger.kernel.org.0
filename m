Return-Path: <bpf+bounces-41593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11808998E10
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411C11C2465F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477919AD8C;
	Thu, 10 Oct 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqdLjD+p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458D19C560
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580190; cv=none; b=TLwnFmYxr867Sem4ayPoMbtiGQHYu2TAyuvkeJAncDFuRtGEQVdQUFF8ltkn8SThO4H72irQcjdds6ajruaAB6oQfI787oS1KtJtnkVGCTj6EL9bqChm62YzImqQwY185DeVA5BiKQjOOgTMJ7QbG5eX0XpvE2YCGBVdfCT4Q40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580190; c=relaxed/simple;
	bh=5x+JldR/LRqxCtrVtLNqo99PjIMwsRBuenM0cDeT4Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uW1Qe2sUF2CImfMoy3qR3H/ntjaK7wwFaHiznJB/zcN9wAFPI3ywXalx2Geagr3jSFzmF4Ig6CDbFfxTUdQRq0q+FWl4rRVtwD0hV0o7uNagtLW1etPxwTSVVF9G//kDYC2vvFAqb78eB7QKmRJHLRPSm69OQqRWjKpjBtxYAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqdLjD+p; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso683504f8f.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728580187; x=1729184987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly7lOZMOwdPR3q95x1mP8p6AahjPhZcz8EOLhfAFVeA=;
        b=lqdLjD+pL38sAY24x2TeJ7JCloA3UDrSJ7lblufESVDItGfH7xneU9vG0kMZgFcFp3
         MkdxieNuUeuy5TWR+E0wxeh4ABBmsE57fWgmZFfXJYB9KVEUgNW2TqnQAeD7NnBfaMaD
         rcTv/Ufr+oDukeV4fhsaY7BQP6SyZ+ml4v1JrEWx8qdk1FkPeN8zfVLpMTAV5Mo5BnG4
         CsJG8q6L3iBdcCkmkRNrUVO0gi/8tQAZdmm6bKB57+RfpTeeSpAB/dFf5FEmlMLtAx+8
         rD+xWSVQdqndF/JeJNTKjoG9gl+O+Xe2Ut1ZTbWCy29y9u7rubwapcl2tKsSsHamXqrZ
         H57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580187; x=1729184987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly7lOZMOwdPR3q95x1mP8p6AahjPhZcz8EOLhfAFVeA=;
        b=OV+kcom+WxolhWXRNcDnxgsqssPE/lYpScKKc8BTQGu4JaWDeYyrt7tB38gulXFdAJ
         VKPaXd7f1wnRGyq1q59GhE9BQZMuMPVAskbFkeyqDhguLLpk2cL1ZM563lMpCOC3Gnnj
         UhJETu8tjXhgs0vs1l38AWj+aESyTkiF5ucxyR/bKxE9ED/1Y48b+IxneNRJF2CEcL3t
         hw/CQ8cXQHbw//07uyMU9D7qsjR6KAy3Vr5Gd/cBJUT0Bp2t/RGct2jEz+OBsoxvcJGc
         oXfryrvGa49ofSEIWCNnpZEwRA20E1g1DAanXbKul5preYE+YSfp+zwUlAechTfLBifI
         TKSA==
X-Gm-Message-State: AOJu0YxfX8nrziyt1r+Htgs9nfEEDVMuel9AoSMYmDH16TkoRgAdNhfr
	q5e/gYRz4BrqX+huYRcoUfnmRmQ0BjYCYDJjsYW3VLhkLqAONSqIzIMkxBFZpMl0FjtT4BugpsC
	FNfE6HFnC0FbA170jqYFUMSpIVyU=
X-Google-Smtp-Source: AGHT+IEO7/ZGB+7I1cEBr3pHA+ihdUkTPuqDNHWfgt+bq14uqWDqI7uzZn3YKRi44wx+lXHP/q5t0PrPfKEGi7HFMC8=
X-Received: by 2002:a05:6000:1241:b0:374:c3e4:d6de with SMTP id
 ffacd0b85a97d-37d3aa70df4mr4656608f8f.41.1728580186682; Thu, 10 Oct 2024
 10:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010153835.26984-1-leon.hwang@linux.dev> <20241010153835.26984-2-leon.hwang@linux.dev>
In-Reply-To: <20241010153835.26984-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 10:09:35 -0700
Message-ID: <CAADnVQL8ie=xxCXt7td=ZhQwyY_hKtig-y9kHwWYwBG9MdfRQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Prevent tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 8:39=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> -static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struc=
t bpf_trampoline *tr)
> +static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> +                                     struct bpf_trampoline *tr,
> +                                     struct bpf_prog *tgt_prog)
>  {
>         enum bpf_tramp_prog_type kind;
>         struct bpf_tramp_link *link_exiting;
> @@ -544,6 +546,17 @@ static int __bpf_trampoline_link_prog(struct bpf_tra=
mp_link *link, struct bpf_tr
>                 /* Cannot attach extension if fentry/fexit are in use. */
>                 if (cnt)
>                         return -EBUSY;
> +               guard(mutex)(&tgt_prog->aux->ext_mutex);
> +               if (tgt_prog->aux->prog_array_member_cnt)
> +                       /* Program extensions can not extend target prog =
when
> +                        * the target prog has been updated to any prog_a=
rray
> +                        * map as tail callee. It's to prevent a potentia=
l
> +                        * infinite loop like:
> +                        * tgt prog entry -> tgt prog subprog -> freplace=
 prog
> +                        * entry --tailcall-> tgt prog entry.
> +                        */
> +                       return -EBUSY;
> +               tgt_prog->aux->is_extended =3D true;
>                 tr->extension_prog =3D link->link.prog;
>                 return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NU=
LL,
>                                           link->link.prog->bpf_func);

The suggestion to use guard(mutex) shouldn't be applied mindlessly.
Here you extend the mutex holding range all the way through
bpf_arch_text_poke().
This is wrong.

>         if (kind =3D=3D BPF_TRAMP_REPLACE) {
>                 WARN_ON_ONCE(!tr->extension_prog);
> +               guard(mutex)(&tgt_prog->aux->ext_mutex);
>                 err =3D bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
>                                          tr->extension_prog->bpf_func, NU=
LL);
>                 tr->extension_prog =3D NULL;
> +               tgt_prog->aux->is_extended =3D false;
>                 return err;

Same here. Clearly wrong to grab the mutex for the duration of poke.

Also Xu's suggestion makes sense to me.
"extension prog should not be tailcalled independently"

So I would disable such case as a part of this patch as well.

pw-bot: cr

