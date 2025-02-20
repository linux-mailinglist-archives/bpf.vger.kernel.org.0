Return-Path: <bpf+bounces-52117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B389A3E89C
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E455423CCB
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A267B20D504;
	Thu, 20 Feb 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am3M+a3Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE62B9AA
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094493; cv=none; b=n8rbGXvPzf9QHac4rjDRBGSbLBSfQbpXyykTAc6Z7iY83B4emDkkW67gPh/+w6GDafig+pjkKEZ4GYjrXjDVnnlBWPlxP2iwfxxyikqoTsKQUYVNSnK2GjsCFVxoMKcpCnZKkUtl4E+0cYJQRclaVyUjagVFU+vowrcfNRhgBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094493; c=relaxed/simple;
	bh=y3RojmpAJTTSS4BYHgp6AQN96uVRql1aqeNntTHchTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVh7FtIFXDoiBo99ZHb6c2JT1dcC8gb4AIyeieh2vIQweGNFgPqgHZlS5h87lnW+VosLeQEYSmicYhWXcnlUrFpSpbjRpCz81zQfthuhNPhDpaf8tE4GDckIJrK3Hc4QR0cZ0LkNfkK5lXtYLRyybqObJ5iqm7Kr9lpTJpI1QyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am3M+a3Q; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5ddd781316so1336864276.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 15:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740094490; x=1740699290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNMdc3s/suSP9sOP/a4rUwa8KlQipR9W11ep1/NXbPg=;
        b=am3M+a3QjhRHvx6iMfeHCCNEHAG4yIh95zp/I5JF915AGu4QKZ8ej3lPwBVoWH8mqG
         gpIrvVu8FrIhd1GAiIQrRO1qH6nbUUHzwDt4FVeoOJ0sexZOykht+GHfFkyPmOSkUdwf
         IMpq03/6hdBMDjtR0S40yLlT91z7MJ6C3NFfjlSxv+KJINb+glIT58VRKGmWsAG/dJ2c
         jGmPpvwfSV00MNNO6fAVvgVy9q+C+JT3M+nNQC01rRw6LvNbGm2X6nqrkkMPl/LFtT3V
         +FOUWBEn2B2Hd5yuwC02FKgjBU3YQLdO8kkag/cXIJ3qjA8yI2To1rR775zFeIGX7WxP
         vNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094490; x=1740699290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNMdc3s/suSP9sOP/a4rUwa8KlQipR9W11ep1/NXbPg=;
        b=SWXz6OSOW4epEj3WFdIieQt4axx/mbL5GFaDEJPj5c17wwSHDU4LcSocWbReyHYl/A
         74ePWIBJv3fe0cTpqxCAGpS9t2PEjbk4NPHMWatcaKv+gV4AFLWXbHpqq0VuYnQyt3OW
         ZR/N5sXt/Y9FG3g8WDt9xUOvwSBZ3pU5UXsrsj1lWouowWuBuCGnMISeAaV9gaBKw4H+
         KcsWBvy52kIUx4W99uSEt4ypPgTIOZJZiKS16lcnpfiXb4AxFBX5vk3NRSxnhW5WUc2O
         5el5NxycOrsR4tRHm5KeR0skEtcf5TfR7784I9xbDTEZa7kcMkQg3HktkATNiCBY7nab
         Yz1A==
X-Gm-Message-State: AOJu0YyQhO0n4/twmkLTmVPGKqMmBh1+0R9gh6CTT796AYPbwCaoSOKP
	Pj64I+Gx3COzwSRCD2ak1VvuRfVpSVDJ1CNvPlbkXuIz9V+LlH6P4IOTZCJiPjhVD8+wQs8Dm+A
	EK8WUCSo2K/5hOyHPBVT0b1oGvzGp7SZV
X-Gm-Gg: ASbGncvN/FkBlInoMrZOkR8F6VyNLuarHCEOGCao3e7+H134dluFAlVontuQ6h53Drl
	NnyEhzyBoAfvSglqQ9GR0lmw0prEcZAc6HywcCGCAZR7/gACsMiXebo3HpqjaCXW1mCNItb6K
X-Google-Smtp-Source: AGHT+IH3s7AYr7UzoP/E5ifarQbcZQK/MiMobsky2DiURuuy6H9Lk6yuc2nTef+JWeYWyylv11l+PUkoCHdJLXt3vLI=
X-Received: by 2002:a05:6902:3301:b0:e5d:ba97:b1af with SMTP id
 3f1490d57ef6-e5e8b04674cmr491794276.39.1740094490477; Thu, 20 Feb 2025
 15:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220212532.783859-1-ameryhung@gmail.com> <20250220212532.783859-2-ameryhung@gmail.com>
 <e83d842e9f6c5cb6f98fd8cb760ec1c8e17e419a.camel@gmail.com>
In-Reply-To: <e83d842e9f6c5cb6f98fd8cb760ec1c8e17e419a.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 20 Feb 2025 15:34:39 -0800
X-Gm-Features: AWEUYZkPz_AWUggyDSBV134GZkf7qytzbvZdMfgaIdA7_lF_VruW-tRa6YHwWgs
Message-ID: <CAMB2axNXpctJ8M9VgWJPFWKsMGt-u1cnt_KdXW=wBDNi6npBiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test gen_pro/epilogue that
 generate kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-02-20 at 13:25 -0800, Amery Hung wrote:
>
> [...]
>
> Given that prologue and epilogue generation is already tested,
> it appears that it would be sufficient to add only two tests:
> 'test_kfunc_pro_epilogue' / 'syscall_pro_epilogue'.
> Not sure if testing prologue and epilogue generation separately adds
> much value in this context, wdyt?
>

Agree. I will only keep the syscall_pro_epilogue test.

> [...]
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 6c296ff551e0..ddebab05934f 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -606,6 +606,7 @@ s32 bpf_find_btf_id(const char *name, u32 kind, str=
uct btf **btf_p)
> >       spin_unlock_bh(&btf_idr_lock);
> >       return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(bpf_find_btf_id);
>
> I think this is not necessary, see below.
>
> [...]
>
> > @@ -1410,6 +1493,13 @@ static void st_ops_unreg(void *kdata, struct bpf=
_link *link)
> >
> >  static int st_ops_init(struct btf *btf)
> >  {
> > +     struct btf *kfunc_btf;
> > +
> > +     bpf_cgroup_from_id_id =3D bpf_find_btf_id("bpf_cgroup_from_id", B=
TF_KIND_FUNC, &kfunc_btf);
> > +     bpf_cgroup_release_id =3D bpf_find_btf_id("bpf_cgroup_release", B=
TF_KIND_FUNC, &kfunc_btf);
>
> Maybe use BTF_ID_LIST for this?
> E.g. BTF_ID_LIST(bpf_testmod_dtor_ids) in this file, or
>      BTF_ID_LIST(special_kfunc_list) in verifier.c?
>
> (Just in case, sorry if you know this already,
>  BTF_ID_LIST declares are set of symbols with special suffix/prefix,
>  at build time tools/bpf/resolve_btfids looks for such symbols and patche=
s
>  their values to correspond to BTF ids of specified functions and structu=
res).
>

Ah yes. It is an artifact when I was testing a patch for generating
kfunc in module btf. But since there is no use case, I removed that
part. I will change it to BTF_ID_LIST. Thanks for catching this.

Thanks,
Amery

> > +     if (!bpf_cgroup_from_id_id || !bpf_cgroup_release_id)
> > +             return -EINVAL;
> > +
> >       return 0;
> >  }
> >
>
>

