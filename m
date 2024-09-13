Return-Path: <bpf+bounces-39864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65105978A2B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 22:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A3B2847BB
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FD148855;
	Fri, 13 Sep 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVzIps/x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994242042;
	Fri, 13 Sep 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260405; cv=none; b=GOKwKcioVrx2bYm2t9rvAzpZ2dVL0+B1Lg+kXJ9yh2rHJVKuOXlx1ymPqDNynNySDRV+jWfZR426HPiKIsczH55OEcVwIYg1fnaH9mCjWaV0heCWaKUq1w42/OcM54SMMqtbbKuku6p8H5oxjtVg1y2X9b+qH+kZIBEyYFk+QLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260405; c=relaxed/simple;
	bh=8QO493V5gDQW1JwVI7PbImqe0AmlBESE61nMl2OdgDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrlLROsYWY0yiT9auF3TQMrjjYCtJQ4uSxSq+2ENxDqOmAcqw0APPXBxrKi8+csG4VNrzrf8uTVLhB/Xv3bX1Coes9h6EGbqdK5AIYXaMJ7+cx/mw/qWCqJPq7dPj0miB5rnuYuz0VgGgpS7F7rpHJnofzM+U2lSY+tVBYmxkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVzIps/x; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so1061553a91.0;
        Fri, 13 Sep 2024 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726260403; x=1726865203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1rIisakoYY0JHr3z7K81gp3DmWikTdWj2NdLF7eWas=;
        b=dVzIps/xQNAHrpdS+yHmP02mZSIeQwC4MeGA9V28irm99LGVphDhUA0nxQfDxr62Go
         IhcSeT8MVXfhQlBoEny83JNfeFznmAwdRrr+/AIW7c/lZHOH1Jv5B5zY1YOW8Y1ZcJ60
         KIJ/iQtGx4Fb35LkM5w/Wy0SBmupUllHIcc4iNHRTxjkkdNN7Czie/LXBaDGiR/YG//y
         gDMue4augq94KGuH+55Bm1gt03levs8FlcuPy9x0zlnO4p6NCTFqLqRF/yNDm30Y6vf+
         yTjSH0yhE5K6+ChAImCITwKyyDRf0We3EBuxGtrVSbYcoB1UAzoRA2j9iURCUrpZgJIN
         kb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726260403; x=1726865203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1rIisakoYY0JHr3z7K81gp3DmWikTdWj2NdLF7eWas=;
        b=YZnmJmSPROSUrlCiT45QNQYEcHsRCzC2fU16j3R7b9vx2AUI9/lM3uqPrZo286tFG7
         7EdcmFpvFxe/93I0LaHJ0Lzdk+woYbuFT41kT0Y3btU/RbTQYTI9MerRydXHpoR262FH
         hspypiscc99rMy/SHMFSAIhw/RpWI4FmVRJI5rpjnV39bPHOD4UjM7BJTTo4TuGe3F28
         tqtMmkgmxxTTkpzhZdyDjCa7dRlFmAmbYlEilt12j/RqCZB+xvAXjudn7ksKZWB1B5bz
         4GSTGWnPOfkWxH+Tf3CvsLuz2/mqI3ZRJJgVilbTAvlSegjxK/c3zdXSiWlEtrHvS4rX
         vgWA==
X-Forwarded-Encrypted: i=1; AJvYcCUPgR4KgjYMO6AvIvr1bux/KnhCIs0vPrCCZftLxP10nz3G6EhB+zDjlBCGdpCkQW3TME4=@vger.kernel.org, AJvYcCWrZdAevcefK0Vnog6SMHLwB49b1h5tiaOIWqb2IvM2hABcHV3wyncrOH4Vlv3xus9pwN3+IwkzYr7c0NGU@vger.kernel.org
X-Gm-Message-State: AOJu0YxePOot3wpuLOgLcfdQAFnwv52vO9c8RNfQCGxQGuwjQPwWowoI
	pZHgH1uLncQTB0RD58ApVirhXr7KNuLaIN5Jkpaik9bZ2TwCZU5fQqpy16vcjS0bUGUi06rXnpa
	kiwTdx9/bWA7etTjDJYO1JROGEVQ=
X-Google-Smtp-Source: AGHT+IGOu4nS4TWR5RHP+/GEUmcs0XBWbnbqRXt0TtO6FXHPfmHgiGwUxBc12KdF0h3K94dkAuOlZBCYOsCJniaPGBE=
X-Received: by 2002:a17:90a:cf0f:b0:2d8:8ce3:1e9d with SMTP id
 98e67ed59e1d1-2dbb9dbda04mr4687116a91.3.1726260403402; Fri, 13 Sep 2024
 13:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913164355.176021-1-chen.dylane@gmail.com>
In-Reply-To: <20240913164355.176021-1-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Sep 2024 13:46:31 -0700
Message-ID: <CAEf4BzZk4onktrnK-i7CQUrFAPEo24G9p5RZhpg0nrhYxU5EvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next RESEND v2] libbpf: Fix expected_attach_type set
 when kernel not support
To: Tao Chen <chen.dylane@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 9:44=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> The commit "5902da6d8a52" set expected_attach_type again with
> filed of bpf_program after libpf_prepare_prog_load, which makes
> expected_attach_type =3D 0 no sense when kenrel not support the
> attach_type feature, so fix it.
>
> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_progra=
m__attach_usdt")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Change list:
> - v1 -> v2:
>     - restore the original initialization way suggested by Jiri
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 219facd0e66e..df2244397ba1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7353,7 +7353,7 @@ static int libbpf_prepare_prog_load(struct bpf_prog=
ram *prog,
>
>         /* special check for usdt to use uprobe_multi link */
>         if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MU=
LTI_LINK))
> -               prog->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;
> +               opts->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;
>

Ok, took me a bit to understand what the issue is. But the above is
not quite correct, for the above case of setting
BPF_TRACE_UPROBE_MULTI we do want to record BPF_TRACE_UPROBE_MULTI in
prog->expected_attach_type, because user might want to query that
later.

So I agree with the part of the fix below, but here I think we need
*both* update opts' and prog's expected_attach_type, so we will have:

       prog->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;
       opts->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;

pw-bot: cr

>         if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>                 int btf_obj_fd =3D 0, btf_type_id =3D 0, err;
> @@ -7443,6 +7443,7 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>         load_attr.attach_btf_id =3D prog->attach_btf_id;
>         load_attr.kern_version =3D kern_version;
>         load_attr.prog_ifindex =3D prog->prog_ifindex;
> +       load_attr.expected_attach_type =3D prog->expected_attach_type;
>
>         /* specify func_info/line_info only if kernel supports them */
>         if (obj->btf && btf__fd(obj->btf) >=3D 0 && kernel_supports(obj, =
FEAT_BTF_FUNC)) {
> @@ -7474,9 +7475,6 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>                 insns_cnt =3D prog->insns_cnt;
>         }
>
> -       /* allow prog_prepare_load_fn to change expected_attach_type */
> -       load_attr.expected_attach_type =3D prog->expected_attach_type;
> -
>         if (obj->gen_loader) {
>                 bpf_gen__prog_load(obj->gen_loader, prog->type, prog->nam=
e,
>                                    license, insns, insns_cnt, &load_attr,
> --
> 2.25.1
>

