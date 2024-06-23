Return-Path: <bpf+bounces-32844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B3913BCA
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC5CB21343
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A358F181BBA;
	Sun, 23 Jun 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANnkqqKB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E71EB25
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719153365; cv=none; b=pK7i/myIRL7GsL0pItcOygaFmygTQIPHayzNGLiyhrz3ztqMwzl74emmqO6P13l6oEBnrAPFestK0USgviZ7nS40W42J6QEA/28Zho8xcmEuWtndeaFLWMzoQKQqCy6QGZY7IexA8FYxEex0AeAQMIaO9/wEyQ2km9TEU8NT1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719153365; c=relaxed/simple;
	bh=//VNWIbwQKq7O7Loy6tiF/8/9AACAhtg4/mzZMVFTeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO63zrpLNcbZjWfDRXqCOSNSW5/azycvtLuy80+919jucrjdm9oF3mn9XzkuUBor4CplNJZ1lE73nDeTE0Ho57J0LdqD5zVovFtzLpE2mGMp8pj8zblcIaMd7kq5HolomX2czrpx8kb6SSTe5TNpqrQVFE/Z+hW+6V74yfRwA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANnkqqKB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so29906465e9.2
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719153362; x=1719758162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIJqTaogFrJafdOWDDUeQAFvjHB+YfO9F41uxi9LsJo=;
        b=ANnkqqKBz/dk4oyuNR58PihTErGRBPw5Q7WUsEWYktegGXOgOhaVoLoX/Of+Lkt7Sf
         efSlIDLanmxXHb1m1T8qChXUvw3IU6BT52RtoDq3h5/7zDQ2JVK9MbYkmvtOefDS6UVB
         OMWQkFNML3qmKT6UfUbIqkS7k07tKgV7zB96S43+Fkq4Htdb5GGHD/arFZX1YedLvpNh
         AkItzZeWhsWcVJZXlOc7Xb35TTJrRZ2upg/gm8ZJ9cx4Ii7Pyw8LCSrbytEi3PlxDXQZ
         eEkVAs5hsfa5vFtk2SWOYpstAxShg50QxqkckYqFPFHsciyq0tPN/Q2GHpMt7aJd4R2K
         fUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719153362; x=1719758162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIJqTaogFrJafdOWDDUeQAFvjHB+YfO9F41uxi9LsJo=;
        b=t5TgNTNPKzVwAlBVfNR2SoUnxIE78UN71ChgphjkT5+uL36htMqZDfSokP+4Q7ej2P
         6hz7BGm9uHbFs6vOA5gabnEqyk3OyIPi/80ZyIaXr8bV2QyZDbhpmlXVseQQ33Fqisif
         yGFC0Zb0u+PgK5MbJcl4z6dSlKabNnxKEzgogq2UiF5RD1+wPRTwDIC0PMDv1kw3OhpY
         plLwlweu8Y2C4Gx06UL3yL07nwkMUV10U1BcJ6hn4KO86C51PweRG97IsNnG4s6jON/V
         ccNXiHVAQbi7NZPBXvHRcGJGslpELsiPjYm/Sz9sakPfmj7ZziC7netCYqJNMTIgSfxL
         nkAw==
X-Forwarded-Encrypted: i=1; AJvYcCWVEH9e50sq3ilRPM1pOr4BPUuOoGVSL3XLFDEmtM2s1c1NnfY2v1PeSep6Zdj76MvVCeC2F0xkm2hjd9CfceKNPXeJ
X-Gm-Message-State: AOJu0Yx6uGjtdAymdBx5ThXQyNt0jO7rqy2HO/MyhlNidsACuCHvGQ0Q
	6/HfN96vCIdR08QcD8YkUI1gzAtG9mq9xQ0AiwFWPxdmtxp0n4qXzYDktpBaKo2D948DXfCH1YM
	Kls/g0Ctc+HV3iRg7/iMEulTnPH0=
X-Google-Smtp-Source: AGHT+IFTNouMTp6/5EGIs3Y/1WD1pP2SSZxso6yerhG3vRi0JqRIXxCfgDooFo9pBFm//l65fnlTN+pAgDZUWwIyGDg=
X-Received: by 2002:adf:eec9:0:b0:362:c971:d97c with SMTP id
 ffacd0b85a97d-366e962cb55mr1225052f8f.63.1719153361647; Sun, 23 Jun 2024
 07:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623135224.27981-1-alan.maguire@oracle.com>
In-Reply-To: <20240623135224.27981-1-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 23 Jun 2024 07:35:50 -0700
Message-ID: <CAADnVQJ_s3FyRo3J3cNTETd3ZSFsFdTvxWy+HnRDzT9LuKrSSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix build when CONFIG_DEBUG_INFO_BTF[_MODULES]
 is undefined
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, bpf <bpf@vger.kernel.org>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 6:52=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Kernel test robot reports that kernel build fails with
> resilient split BTF changes.
>
> Examining the associated config and code we see that
> btf_relocate_id() is defined under CONFIG_DEBUG_INFO_BTF_MODULES.
> Moving it outside the #ifdef solves the issue.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406221742.d2srFLVI-lkp@i=
ntel.com/
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8e12cb80ba73..4ff11779699e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6185,8 +6185,6 @@ struct btf *btf_parse_vmlinux(void)
>         return btf;
>  }
>
> -#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> -
>  /* If .BTF_ids section was created with distilled base BTF, both base an=
d
>   * split BTF ids will need to be mapped to actual base/split ids for
>   * BTF now that it has been relocated.
> @@ -6198,6 +6196,8 @@ static __u32 btf_relocate_id(const struct btf *btf,=
 __u32 id)
>         return btf->base_id_map[id];
>  }
>
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +

It doesn't fix it all. The 32 build is still failing:

../kernel/bpf/btf.c: In function =E2=80=98btf_populate_kfunc_set=E2=80=99:
-../kernel/bpf/btf.c:8251:36: error: implicit declaration of function
=E2=80=98btf_relocate_id=E2=80=99; did you mean =E2=80=98btf_relocate=E2=80=
=99?
[-Wimplicit-function-declaration]
- 8251 |                 set->pairs[i].id =3D btf_relocate_id(btf,
set->pairs[i].id);
-      |                                    ^~~~~~~~~~~~~~~
-      |                                    btf_relocate
-

See build_32, build_clang, build_allmod failures in CI:
https://patchwork.kernel.org/project/netdevbpf/patch/20240623135224.27981-1=
-alan.maguire@oracle.com/

