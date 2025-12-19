Return-Path: <bpf+bounces-77066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566AACCE040
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 419D1301EFBB
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E33E288D2;
	Fri, 19 Dec 2025 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoySe/xs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC810F2
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102525; cv=none; b=Yet3J/5bEQWwxN/t4NpecF5CXzVp1xo8Xtt1S4nlz5rmCJta85CGCHSxBc1sD9WwWMcDoGXAkMdgQEben79H4Zq2dJU4v1k6eXBt5Yzl32rH4KVUSR4TpDsAHDl+bCKSd8Vm0l4LB1iL2ZGZIt3a6cWoSg8mp6kVAVUcgQbauMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102525; c=relaxed/simple;
	bh=y42yHe7h5itNutJ6BcpYD580GemjAajrykySPRYHgHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SagKCoNOlB8bDtPHsDrstnYmXib4X4QfZNOFDpF8C/lmszKoUxyp8SyfYN1qLp8da/cFhrUD1mifraOX4Bzpg53a+mG65xLRaAA117X/Swa97hZ/bnyXVU2p8aHT1YI/7BQZKH75H6g+FF+RfqTo/J9VqR1fgNHaZ6VNmJPuOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoySe/xs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f0f875bc5so16745445ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766102523; x=1766707323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgkR4unLvcii9pudK3L7mhyrK82WLfD2ks1H1p5VaII=;
        b=ZoySe/xsiaT7da5S1b3/mXq1yqQpBW9CBaHLDEyicP1dyzaoGSELV7R4RWmE4HzHBE
         yM5uOIYfDE4ST/Rh4gvFPGBcD3YOwOECykWyg1fxE2QqLIvSCjz2jE2CqGRTg6+m2xYA
         U8eMfCOlVuaGyETTqGlTQa/N2XSZuBhkqv+jGmQ3kPkNDl7sMUWvTLnz4vQfpbKp0rAU
         z9HU47yCSrGYt0mm6/Ppf+L2O2YEmIvTT34qu+yr3I10NBC1GFpNeIa3m13Zs07Ea8Oy
         pLC7WWUKEy4icTjuSsrxzJzfQhinzIg8BmpHJLzS1BCaOiYfFcbz0GVsbtrSP96A7/Ua
         BpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766102523; x=1766707323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgkR4unLvcii9pudK3L7mhyrK82WLfD2ks1H1p5VaII=;
        b=d7ROp99zSIcaoo2WcsBoJlEWqBDz4osJ+mjEv80zH2zabQ2gPQ/4m/LFTJjWhpUf+e
         KX/fgb6zq6DdLBeq7Flyfh0HRYGGVQYq1xB31Vriu6x1tWlxB5CU0hZZZc2N2PHyJEN2
         /37/KfjOl2hlgyeH0wO8fHf97yAOuEliZ2bAaJ1QwxjMwWTYKeCrrgG8/5ZDX4GTuRc2
         m1uMixiHl0tWrq5CPYuw8W4rW7DMF+YOg5sET5wfZA8qmvUlpRQAycnTAXqbexQE567o
         kq9MrMzZuPzuVhqtsv3mBEAk+a9RJHhzks6rdkxXx67AvtzlCeaRekOY4ATESTIBcPyF
         UPNw==
X-Forwarded-Encrypted: i=1; AJvYcCW/w3dflSsJCzKUWJ9zgs0A7v9vGcdWodO3/NZU1asbuHDijOXRPOTSMNEm+wyzq2Fkfuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLfzPh6M6ESrHgfg8U2M0Dv3RtZgHJ1YCsHa6eUePGKP5/bvwY
	VxWIU9J/QxSJk2SU0roN8a3tCaFk2sBDEUx8aedqLCfv04JylYUIoJxGPMuq7cjJ+nJm1cId8c6
	q+xe4rFbsHbFXrYqn5+IZ/I3RmdqErZ4=
X-Gm-Gg: AY/fxX7JIL3ISB2CecH7DYjQ9NoOlsW6wE5ope27EUrMNK/OxlsKNj9gV5BvT9RJMTy
	DFfx/Oed2q7PMKLtzLjetRJB2chQqQqKUcDXB1xkaM7jTc2UmXwn/u5torqKzE6R12EyRFwQGs/
	3IJdhA3cUPRvLISvmHV+RAwiyG8E40izDT6hKr/LRAQQtOZOSud2JF4jYqtE2oPhlYN/ctL128r
	tbFKHQeCX5dFdj0h7JlpuYzui1sqZkdAVyaCwwFfoKYySABTawJHAuebU9TE2se8mTj8pUaD/Rj
	qqF4znv/vfg=
X-Google-Smtp-Source: AGHT+IGsAaSUWVKD+HDn3sgoWJ4fNNnwmotq4sFc2x1jW34Pv5Pn78+XTKUqLilyX3a5bo7OAv84KhiZrnY+zOamnYQ=
X-Received: by 2002:a17:90b:582c:b0:340:5c27:a096 with SMTP id
 98e67ed59e1d1-34e92113697mr810164a91.6.1766102522975; Thu, 18 Dec 2025
 16:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-10-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-10-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:01:50 -0800
X-Gm-Features: AQt7F2o99RRCMDvVphXofwc0R_czMXdIYg_MNZoDOkK4l59yCA6bXbyIqG47vsA
Message-ID: <CAEf4BzZVFMbP+XXTOedDESKL4jred6vg2L8Dv5C-mmKMp9sicQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 09/13] bpf: Optimize the performance of find_bpffs_btf_enums
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Currently, vmlinux BTF is unconditionally sorted during
> the build phase. The function btf_find_by_name_kind
> executes the binary search branch, so find_bpffs_btf_enums
> can be optimized by using btf_find_by_name_kind.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/inode.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 9f866a010dad..050fde1cf211 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -600,10 +600,18 @@ struct bpffs_btf_enums {
>
>  static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
>  {
> +       struct {
> +               const struct btf_type **type;
> +               const char *name;
> +       } btf_enums[] =3D {
> +               {&info->cmd_t,          "bpf_cmd"},
> +               {&info->map_t,          "bpf_map_type"},
> +               {&info->prog_t,         "bpf_prog_type"},
> +               {&info->attach_t,       "bpf_attach_type"},
> +       };
>         const struct btf *btf;
>         const struct btf_type *t;
> -       const char *name;
> -       int i, n;
> +       int i, id;
>
>         memset(info, 0, sizeof(*info));
>
> @@ -615,30 +623,18 @@ static int find_bpffs_btf_enums(struct bpffs_btf_en=
ums *info)
>
>         info->btf =3D btf;
>
> -       for (i =3D 1, n =3D btf_nr_types(btf); i < n; i++) {
> -               t =3D btf_type_by_id(btf, i);
> -               if (!btf_type_is_enum(t))
> -                       continue;
> +       for (i =3D 0; i < ARRAY_SIZE(btf_enums); i++) {
> +               id =3D btf_find_by_name_kind(btf, btf_enums[i].name,
> +                                          BTF_KIND_ENUM);
> +               if (id < 0)
> +                       goto out;
>
> -               name =3D btf_name_by_offset(btf, t->name_off);
> -               if (!name)
> -                       continue;

return -ESRCH, why goto at all?

> -
> -               if (strcmp(name, "bpf_cmd") =3D=3D 0)
> -                       info->cmd_t =3D t;
> -               else if (strcmp(name, "bpf_map_type") =3D=3D 0)
> -                       info->map_t =3D t;
> -               else if (strcmp(name, "bpf_prog_type") =3D=3D 0)
> -                       info->prog_t =3D t;
> -               else if (strcmp(name, "bpf_attach_type") =3D=3D 0)
> -                       info->attach_t =3D t;
> -               else
> -                       continue;
> -
> -               if (info->cmd_t && info->map_t && info->prog_t && info->a=
ttach_t)
> -                       return 0;
> +               t =3D btf_type_by_id(btf, id);
> +               *btf_enums[i].type =3D t;

nit: drop t local variable, just assign directly:

*btf_enums[i].type =3D btf_type_by_id(btf, id);

>         }
>
> +       return 0;
> +out:
>         return -ESRCH;
>  }
>
> --
> 2.34.1
>

