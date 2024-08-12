Return-Path: <bpf+bounces-36906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEC794F53D
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6B5B2471F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD4187571;
	Mon, 12 Aug 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoIX4hb5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A4187563
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481349; cv=none; b=okHsCsdq7M6xTbaubL8pPbBkx/f0b5fl03LKJFkcqfH22xiX/GmI3x0Z0WrypsJS6+yKj/VbEW5WDWryK8rNRWcUsFCEQEUchLfG5khJHiavAF99yglk9WC5RagVebSZ4NW9C39xz5mKcnoPSWQex16Fv1obq3udw3QPawLdWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481349; c=relaxed/simple;
	bh=BP7TWRyDeXH7ENHlbt5FUQ47M1ihLoi0BmnyZRymgt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl73qepYzIECKVtRQS5VpPolU3v8aGGPakVFbxmpmR5o1p8bFW0SlY3JViWp2/5gYBbE9ijgRVM5MZzzgHwkBG/PYTbO7x9Tu+1hYZCITqK9p6Fsn5uH+PRRSaYF81I4pyBrdrnSW/QPJkVzF7bQZpfVHE40fX9hzadsfpECD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoIX4hb5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3684407b2deso2492920f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481346; x=1724086146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmt/1HsWsM/9GY2vF2ONLo83AzZFiZAdl+K2TmhqP9U=;
        b=JoIX4hb5VNk8No6CY2Yeb3SsyiQ4k9e1NsYRFcmotYruyrJMDOW0cTkx+lYtafbsT4
         XMPZHVktreuLj3A2nxjae5TCBT2YDZ2tWS32XUQGD1uzM2tuSgjQSZdONPnpxwb2VIT5
         9mtwCFGBsiivldJ1v8UQBih+mVJz3ITgT5n42Xsor3pgMf4QuJESt5+vo5p0bY+AnKWO
         R0WuMpTckPwmvDkB0GYCjM1IB0dQq700M57wJkm/mSPFel3c3PdjJRl6aAm8pR2yU3in
         admemPUWPx3h5LnChvZWKdkJCHvJHKNE/NOWU6AjOxIj8Rp0hV0iABhFJRC/YRinBH0p
         HcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481346; x=1724086146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmt/1HsWsM/9GY2vF2ONLo83AzZFiZAdl+K2TmhqP9U=;
        b=IhhhGWiUgv/Q2UdyuDUgGZVyer0U1xPzRdv8X0SfYzvKV/2abYZqmgox2Aqeo7BoqQ
         mvQNTvQ5O3aZ0rhxhJ4KxytfazrQIkPVyYZh2PlwBbyhyzqNQES/aBLpH3KRomUoobC+
         VYmGpqIoUVpTz7PdpGQbSUSV9KwaAP/Zliwns54gIz8FX/jBwkzz8sHw5wjVpw8ltl3f
         JdL7KoAEs4Y/Kc81nnUR3O7YfGdjRnCO9GUmfFGQCaeyVhjA9Rq8sfzh+T1AFtt9dceT
         9/SQLNdUhRo6m3zHZXlsvSzW97KSMl3tMQTxNBWuCKJb/dzQog/eCF5rs2Xppi01mdgV
         a6Zg==
X-Gm-Message-State: AOJu0YzCibmFX31PJkqaRDIy7VvNQ1FkVGt+7zxfyWzGZo8c1UUSWNhK
	X9GpIrPvD38E6f0hGphzFfQTzAPoDZT7AzLh1074afw552wKfUtcQo1ruBYnajAYn/UOnd4B16T
	vtpE9BIuXFtBRL7Ke7MD+3k56rII=
X-Google-Smtp-Source: AGHT+IEVYCl8v9QnN4Rq+RUtD/j8q0gnyIRNotaaqoI567qQ2y5u9OaT0kyKR3VMalsnHWliKcmMiWiXsI5j5NaTMpg=
X-Received: by 2002:a5d:5043:0:b0:368:460b:4f8e with SMTP id
 ffacd0b85a97d-3716ccd74c4mr730713f8f.13.1723481346152; Mon, 12 Aug 2024
 09:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807235755.1435806-1-thinker.li@gmail.com> <20240807235755.1435806-3-thinker.li@gmail.com>
In-Reply-To: <20240807235755.1435806-3-thinker.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 09:48:55 -0700
Message-ID: <CAADnVQJdZgJi7=jo+Ur+hL1WtW3x06Zptupk+QOp-mMzSefzYw@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/5] bpf: Handle BPF_KPTR_USER in verifier.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:58=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com> =
wrote:
>
> Give PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_ALLOC | NON_OWN_REF to kptr_use=
r
> to the memory pointed by it readable and writable.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  kernel/bpf/verifier.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3be12096cf..84647e599595 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5340,6 +5340,10 @@ static int map_kptr_match_type(struct bpf_verifier=
_env *env,
>         int perm_flags;
>         const char *reg_name =3D "";
>
> +       if (kptr_field->type =3D=3D BPF_KPTR_USER)
> +               /* BPF programs should not change any user kptr */
> +               return -EACCES;
> +
>         if (btf_is_kernel(reg->btf)) {
>                 perm_flags =3D PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
>
> @@ -5483,6 +5487,12 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_en=
v *env, struct btf_field *kptr
>                         ret |=3D NON_OWN_REF;
>         } else {
>                 ret |=3D PTR_UNTRUSTED;
> +               if (kptr_field->type =3D=3D BPF_KPTR_USER)
> +                       /* In oder to access directly from bpf
> +                        * programs. NON_OWN_REF make the memory
> +                        * writable. Check check_ptr_to_btf_access().
> +                        */
> +                       ret |=3D MEM_ALLOC | NON_OWN_REF;

UNTRUSTED | MEM_ALLOC | NON_OWN_REF ?!

That doesn't fit into any of the existing verifier schemes.
I cannot make sense of this part.

UNTRUSTED | MEM_ALLOC is read only through exceptions logic.
The uptr has to be read/write through normal load/store.

