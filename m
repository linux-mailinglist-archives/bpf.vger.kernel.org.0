Return-Path: <bpf+bounces-64541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D9B140D2
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6817A188B1AA
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9902749E0;
	Mon, 28 Jul 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGDZZRMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91591273D96
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722001; cv=none; b=GQRVy/hM8TtQ5sCp1b/HT4tSW0ojRIKlFpW+KWmNEj+t80H4Z/cJPBk5DdA/wFY2FRMSRdTtIeWnQtMbCqPbOxY9pnpPDzq8sMfFBO2GEgzwqSnAQtrHXYad2VGTDzAlwU5EaLS1YFO2edNRh4fZ9qgB5Jkka5fIl/SuEQKLPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722001; c=relaxed/simple;
	bh=aCK/K2UyxTH4XLBqfgi/XtiY2G/4DUG9q68RsTl2yhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZxcoLscKTqFNo4mp2rRU0kG/HeetHRZPAf/umS/yq9fHLjVihqGczB54tDasOGEw0k3/sY/TFSn2mtuL5BdXXwtCrChh0t1DTfG3mEFWC/QO60b48JAVIoWsQDxFQoOnZao0XlxsSjufSCeTYIdHytJ0grfIFFFIH6t2z3J5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGDZZRMH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4560d176f97so49794135e9.0
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753721998; x=1754326798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlPrKXQq3sji8u7IaaJmvLbCd4Pm96Kvc5oMCwMMGmg=;
        b=AGDZZRMH2O3YLaxaFxCkdL7f8BmF+KwfejsLgnVYvGaWDufC8ahHGnr9npzt5zeeOG
         OFxlmve709sXfci9sfRmFX+k/TtiaSFrlHZvglouAmwCIfeRXtoo1fm+ObOFhTAZyzWb
         L13ojGv2gAPcL0RS0BuduH5KkuaPZpOfI9a+IfC1Zby3Dj1REqueH1ewzu8B6/EtOp+U
         5RWYZxkKFCDh/8LTtymDQWTpiAcaq6GoytA2D4oIwg0OhMS24bldfMS8ORyVhbd+VMyu
         7yDZAq1ALRkNDncPltJNyyI3XnWYg7WHYJoYmRdepGvmnLmsVjEKz9thNPFdbCiMwk3G
         WBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753721998; x=1754326798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlPrKXQq3sji8u7IaaJmvLbCd4Pm96Kvc5oMCwMMGmg=;
        b=vhD0+KvFevkgmjPyqvXpJrmZMj5B+UY0VcJkZ8VSxXo65sSZO0fqsfK/sBRM0uA4xG
         YLVNkbBkSDpzN3UU4cz1BhJDEFVNDhK4ILoJGnHklB3O3XFqDUr+72EIr6ZmAbuVh5VU
         Bg/PnxZQgvKE4br3RHdjfMq5YBGhjFOU0bKm8YHl3Q7SB+u5XoHOSNr+lVA2B143hh2z
         T1NI+0kdqRJ6QZtMDh7RIWJGPVznaW2cjDbLGLc7IU7cWMrIJRtdurVeEWTfFWLllBfT
         MikhYpBfJ74hwEvoqz9jk0xUpT1QnqL/aH2QN95hL4OCbHdfO3csGc3dswVFyFTwKQ0P
         Jp/g==
X-Forwarded-Encrypted: i=1; AJvYcCV85sLap+7Sum2jqMcOUJiLsxKb261SPYMQf8b5+nJB3UyT5b4W5V2XN1rqvzP+Qas+IEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdAsVKonq2Y5y4okyOrxy67nOeo28mVv8CP03zkI/QiWkPl26
	HGdQ8KDFp6A5w4XLGNOeDVjy49lDNgp4O2kW90TM1BW/bgYAq+FPJ3ENZbgz4bs2YjLJbvhiUOL
	QsGlg+6noSWPpIkeWZqkWJz3wJIDifx3i4YcJ
X-Gm-Gg: ASbGncujzXat0gpdAPV444ibXoH1K+EPierRbOyzX5+49V161gRzqfHzWLG9Z0p+hm5
	7Mrmb5aHMuAvaY31LpZe5pMXVFBld2Q35hEO7eboxbM5CGS+lNH38a87aAVytMhoCp2lH6pAmyA
	Vl+WEfwOJgvzVyEN99mzhhGqT4ASshdVwk+4WK3OiiBn9KRt1Y66OAyPfuYzXO+PrYilyKLwpIj
	FPu
X-Google-Smtp-Source: AGHT+IGWEgS7/oerh7YTzU8ncDy/tWgh+CmEqUgCe0A9GBv3lMVIHZ58QqfCf0oJJL+ArVqrlPRKVr2KZhyzmggh4bg=
X-Received: by 2002:a05:600c:450e:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-4587630f5a6mr127701655e9.10.1753721997423; Mon, 28 Jul 2025
 09:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727223223.510058-1-daniel@iogearbox.net> <20250727223223.510058-3-daniel@iogearbox.net>
In-Reply-To: <20250727223223.510058-3-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Jul 2025 10:59:45 -0600
X-Gm-Features: Ac12FXxHUXeqBnRH-JdXdd4xplHbsq_Zm2Tr-r_OC1PJDnxMTDFnqmP0P92pKgg
Message-ID: <CAADnVQ+QagS6Bad7fHwnU4-JzUnG_B_hvm_vaoOxccJgrkwWPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Move cgroup iterator helpers to bpf.h
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 4:32=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Move them into bpf.h given we also need them in core code, add also
> for_each_cgroup_storage_type_cond() which we'll be using in a
> subsequent change.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf-cgroup.h |  3 ---
>  include/linux/bpf.h        | 20 ++++++++++++--------
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 082ccd8ad96b..d1f01d1168a1 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -77,9 +77,6 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_t=
ype)
>  extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATT=
ACH_TYPE];
>  #define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_ena=
bled_key[atype])
>
> -#define for_each_cgroup_storage_type(stype) \
> -       for (stype =3D 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
> -
>  struct bpf_cgroup_storage_map;
>
>  struct bpf_storage_buffer {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a87646cc5398..a41dff574327 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -208,6 +208,18 @@ enum btf_field_type {
>         BPF_RES_SPIN_LOCK =3D (1 << 12),
>  };
>
> +enum bpf_cgroup_storage_type {
> +       BPF_CGROUP_STORAGE_SHARED,
> +       BPF_CGROUP_STORAGE_PERCPU,
> +       __BPF_CGROUP_STORAGE_MAX
> +#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
> +};
> +
> +#define for_each_cgroup_storage_type(stype) \
> +       for (stype =3D 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
> +#define for_each_cgroup_storage_type_cond(stype, cond) \
> +       for (stype =3D 0; (cond) && stype < MAX_BPF_CGROUP_STORAGE_TYPE; =
stype++)
> +

tbh I don't like this hidden condition.
It makes usage of this macro harder to follow.
Just open coded it in the callsite ?

Unrelated to the patch, but Dual #define for_each_cgroup_storage_type
for CONFIG_CGROUP_BPF vs not is ugly.
I don't understand why we added it.
I see no harm doing it once since enum bpf_cgroup_storage_type
is unconditional.

--
pw-bot: cr

