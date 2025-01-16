Return-Path: <bpf+bounces-49124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32E7A144E9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105A77A46CB
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1F22FDE1;
	Thu, 16 Jan 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ3Nr842"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A881CEAD3;
	Thu, 16 Jan 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068213; cv=none; b=apDQ0mJw9jSTycFemsXQafJIXtXLcpZsZVLUKcqhn0qXUY29gmgNRHhr054DKNerE1livIA3DSmMTKFphcg7Mold7jihWXvzDuxRN2HUtheRaqab9jKYcXa3GGIO2lX9LKYGuo7o5q8wT2h37QHYKboDU6LGU4jx6bs+oQWxcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068213; c=relaxed/simple;
	bh=Mex2tkfubjD2m2TyJzmFUWwlrZJZ5e+IpBs+rXATQKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnvL9KrBszS+tca705ApP6hudBvR5b2LrHDI7CHCoQv0Q6weBdqwdcbhcvx17ByYCM8yNLFikDb0Wl5X6ugA6fH4V30nWwiLIT9g3IriQa10dJO8jsdw8ZtHruM2f5+96ld3z4jbjwZZINhLmkBdMjntCkPw7eaqMAZMOPZg9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ3Nr842; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC62C4CEE4;
	Thu, 16 Jan 2025 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737068212;
	bh=Mex2tkfubjD2m2TyJzmFUWwlrZJZ5e+IpBs+rXATQKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NZ3Nr842Rez++RBDXsQAvRKRzihAADRdZbbU0c130U59Pa2oR3jkIV8A2zILfIHCj
	 MTJqlh6PD6VXkHaUa9niF8+SHSZ32+aYsR2sA9b5bY/WidTiQNfNvN+lB9Eoqcqqsk
	 6xaV2/mNXiNMdyloNzTc131EJ0fu1ky+FLZ9sjg8P1/w6dIrntDmlPi76Uj2730yqG
	 o38XLqMThx4ZNUAewhkg90unLPLavggA6vmLPybF5l6pxOPOnr1FIO0AUPT6I0Pp3I
	 nSf9SCw7qjidB9Ps0h6FgR3PCrNHdBZu4zsWv9X+aVY+vxgZYV4CUIyoufADQvsR5g
	 3b2xfDRaKrnnQ==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso5099915ab.2;
        Thu, 16 Jan 2025 14:56:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVoaEtdprxviZikOucfBuDMcpLrorUMvXlfK0Rc4iXGDi4voardebrTCLpZBnFCFS4OXA=@vger.kernel.org, AJvYcCVO2Sez7ItZ4IN6dBmPDkzpaoNCOoFVnEiT7mcL/TQrwZFC3blhPntG4KJghGeM7RyrhmtHYetlbI6MUJSD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4qPleaJdd+3q1Yh6s6otEALDg4TALIT7Vy9vXROlj0ndWkcA
	1/7hvH19LBKt7Icc8stiTIr2vOIQEwWL47dObn7lnD5HkV/mgJW+DMXBSJh2BX21KNSd8R69AI9
	a+7Z2ULGwuFXPXexwvN4wMmBoSIY=
X-Google-Smtp-Source: AGHT+IFWGL2YHPY7hJlByVVJAv+bEZjBE/cV2f8wFXpolSmTBkSB4n8MNl6uhVY/WMClz0pcQPG0KdGbwNmYV9YD88o=
X-Received: by 2002:a05:6e02:20c1:b0:3ce:6aa8:6c4c with SMTP id
 e9e14a558f8ab-3cf744bbe36mr3679835ab.21.1737068212125; Thu, 16 Jan 2025
 14:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508044E85205F344C4DA4B5F991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB508044E85205F344C4DA4B5F991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Song Liu <song@kernel.org>
Date: Thu, 16 Jan 2025 14:56:40 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4F5uyJKa2Gg1QYRy8_FBERgaj=z4smxtjKa5NF_Zac8w@mail.gmail.com>
X-Gm-Features: AbW1kvZA87B3yuVgHXtzmgJtmXpkSJ3YayVx5bg3GqBSHb--M6cQUxarREgpX5g
Message-ID: <CAPhsuW4F5uyJKa2Gg1QYRy8_FBERgaj=z4smxtjKa5NF_Zac8w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add enum bpf_capability
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, tj@kernel.org, 
	void@manifault.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:43=E2=80=AFAM Juntong Deng <juntong.deng@outlook=
.com> wrote:
>
> This patch adds enum bpf_capability, currently only for proof
> of concept.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  include/uapi/linux/bpf.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2acf9b336371..94c21d4eb786 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1058,6 +1058,21 @@ enum bpf_prog_type {
>         __MAX_BPF_PROG_TYPE
>  };
>
> +enum bpf_capability {
> +       BPF_CAP_NONE =3D 0,
> +       BPF_CAP_TEST_1,
> +       BPF_CAP_TEST_2,
> +       BPF_CAP_TEST_3,
> +       BPF_CAP_SCX_ANY,
> +       BPF_CAP_SCX_KF_UNLOCKED,
> +       BPF_CAP_SCX_KF_CPU_RELEASE,
> +       BPF_CAP_SCX_KF_DISPATCH,
> +       BPF_CAP_SCX_KF_ENQUEUE,
> +       BPF_CAP_SCX_KF_SELECT_CPU,
> +       BPF_CAP_SCX_KF_REST,
> +       __MAX_BPF_CAP
> +};
> +

I don't think we need to handle these in the core verifier.
Instead, we can put the same logic in:

    fetch_kfunc_meta =3D>
       btf_kfunc_id_set_contains =3D>
           __btf_kfunc_id_set_contains =3D>
              hook_filter->filters[i]()

Thanks,
Song

>  enum bpf_attach_type {
>         BPF_CGROUP_INET_INGRESS,
>         BPF_CGROUP_INET_EGRESS,
> --
> 2.39.5
>

