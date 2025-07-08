Return-Path: <bpf+bounces-62657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00395AFCA36
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800D41888EB4
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 12:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611BD2DAFCA;
	Tue,  8 Jul 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP1TOrVc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCF2206B5;
	Tue,  8 Jul 2025 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977138; cv=none; b=R3WGUgES10A5D8o2P2W4XnWV0TxTUPtUMd6kP96APhrFypguGKv/nNNNiacs9OrwqO34JiM7o8DDwqC3xYxVw4c5Ufp1w6jcUebOKZHfWnVP4DV4LopJTVn5VcY6xnijj+TPPSHgHX4Yxb2l9jiOEas2Olp+165ridZT1yxxFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977138; c=relaxed/simple;
	bh=ZOE1qC8D4BhPXOrZ49i6yYMZL1dA5j0meaw6FA8gKD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK/xCYsfPDsiXRtihzst4rGnfTzwFT3Sh0SY0A+5Qh+YMVPcIppN9WyajDEzQspuJLkf7xAm+dORA7VMHGXPJH2lgDYTOCd6+Ea8mnNVtjC4WnwnzOd9LC/I9WpaKIKwdgptYtlj3BgsYvLzei6tWyATA/4BZzRGiY/qKMO6FnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP1TOrVc; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-70f94fe1e40so55955657b3.1;
        Tue, 08 Jul 2025 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751977134; x=1752581934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGaS3/Dj/Tf3dZjzLhKT1QfiTr2xhAALEFtTxRk7UZo=;
        b=eP1TOrVcKJ1V+QZhOrsZ8mWSNqGLU2CyU4KKxCD73rdz0J+79GhHmnX+RR5fDIJkWW
         ixoX/KJpiIAW72vfxheNKFORgU6NVm6g4jYOb27Ek57v/u/rq4kjDrbSowFxyzAygLuF
         axuHNMXrlKux9ACPM/E5YGvBkv0a2Wwx2m5kgSqBKqxk448CAsOJ73GKTYQ3oFLvF/vz
         7ASFjH0ZlhYxxD53IG05GzJS6TON4PmdNMqk2LL1ufeyEz4/YHC6/ooaRrQRghILxVzI
         vecunXh9nCO085Xl2Lu1rnSvDMPiFdj1ibE6rXt21OO1SatSRKYen9DNoAlG4brm/vud
         4Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751977134; x=1752581934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGaS3/Dj/Tf3dZjzLhKT1QfiTr2xhAALEFtTxRk7UZo=;
        b=CAahh1N8NEUaDkavIMEhOYm4XSRnQbUOlg8kqMA3utavzr3HZnsM/f1DJRBsUsFzO/
         YT3KnupN4bKLxEl6zd01xVquzyAl7U0cydccMm5mKgYZ+ii99ZnUH4KoDZMh70DJUqD/
         Wc/ZqCqd/uU3hHhD212o0ifUp3vUry+ztg653JZtLf6IL1OFIxFchS18sfgV8DAyidnC
         ysRPr4F8BXoJ2twHpRxTyn79rniz+X7VfQTauEqUWzfimDrm/mGWsDydn/Di3NJVK2pj
         iXe0lVa6nh8P3PJeRTvtJOrMWJbhQw/SbCxkPgpt0BF+dex3/rKmCJ3vVN/LHm2y5I4Q
         Ub6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHUeUTjFA/UcVyHOdkaPeZabYiwRMcor7jVCVxTPsKOQ3kI8OM4jtIMdIDNqyWNUDXorplGWpHUn9voBG9@vger.kernel.org, AJvYcCWLoh52ylqXKR2P28AIbm8y6IzNPN+Uifm/ZEwkmDJxMGAHfiIfaT5bDVRGOIv3KXIIan0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVC7HK2OPvOZtUJrs8IgQ9aBHIUdHUvSbdkldG8EQYTrpZbPg
	Ka6semmSWRgD7rWhoKHuXyk9bAoVJ/4wxG8NIqDdvRJ7HhN600/TGQjdEASNQK0KnBpBJYvvxkn
	W4IG5L34ivEO/MQ4/3MS5TgDiSSLEH6o=
X-Gm-Gg: ASbGncsxC8AjEl5Rdx85/fd8RdtElblrc/MbrHLxMK+jlRHNEHUViNg+1BPKg7MfrHi
	t9Y0Oy9jKdkhXnrRd659jLVBKXNuCIykNmov3Pz+s8nbiW0NnxtHhz9btxD4AzxK6K+4hgtQmIC
	C5LfOcVtvVCx/ybQ3JC21ii+QAfrqK/nTCHVXcKD2VRrY=
X-Google-Smtp-Source: AGHT+IFTLxF4dJ0DwJhQeLobR/yLrR1t0vuqJTRyoZ98EeGP0O8i/J0D0LkjtOrQjC/qaD9EHqoJFthg+6ZFEjAklmk=
X-Received: by 2002:a05:690c:881:b0:70e:2daa:65b7 with SMTP id
 00721157ae682-717a04108efmr34226267b3.12.1751977134372; Tue, 08 Jul 2025
 05:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708072140.945296-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250708072140.945296-1-dongml2@chinatelecom.cn>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 8 Jul 2025 20:17:55 +0800
X-Gm-Features: Ac12FXwb4U--TZR-7QrC-26uqGdPAN9qdG9QTenekp4QKiClD19KpqcX1Y62zo4
Message-ID: <CADxym3ahi_CzXHDAnsGO5U+4Mz_i=O2MP-tW7yzUscazpFpwgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: make the attach target more accurate
To: ast@kernel.org, daniel@iogearbox.net
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 3:23=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> For now, we lookup the address of the attach target in
> bpf_check_attach_target() with find_kallsyms_symbol_value or
> kallsyms_lookup_name, which is not accurate in some cases.
>
> For example, we want to attach to the target "t_next", but there are
> multiple symbols with the name "t_next" exist in the kallsyms. The one
> that kallsyms_lookup_name() returned may have no ftrace record, which
> makes the attach target not available. So we want the one that has ftrace
> record to be returned.
>
> Meanwhile, there may be multiple symbols with the name "t_next" in ftrace
> record. In this case, the attach target is ambiguous, so the attach shoul=
d
> fail.
>
> Introduce the function bpf_lookup_attach_addr() to do the address lookup,
> which is able to solve this problem.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - Lookup both vmlinux and modules symbols when mod is NULL, just like
>   kallsyms_lookup_name().
>
>   If the btf is not a modules, shouldn't we lookup on the vmlinux only?
>   I'm not sure if we should keep the same logic with
>   kallsyms_lookup_name().
>
> - Return the kernel symbol that don't have ftrace location if the symbols
>   with ftrace location are not available
> ---
>  kernel/bpf/verifier.c | 77 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 72 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53007182b46b..4bacd0abf207 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23476,6 +23476,73 @@ static int check_non_sleepable_error_inject(u32 =
btf_id)
>         return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_i=
d);
>  }
>
> +struct symbol_lookup_ctx {
> +       const char *name;
> +       unsigned long addr;
> +       bool ftrace_addr;
> +};
> +
> +static int symbol_callback(void *data, unsigned long addr)
> +{
> +       struct symbol_lookup_ctx *ctx =3D data;
> +

Oops, the logic here is wrong, it should be:

static int symbol_callback(void *data, unsigned long addr)
{
    struct symbol_lookup_ctx *ctx =3D data;

    if (!ctx->ftrace_addr)
        ctx->addr =3D addr;

    if (!ftrace_location(addr))
        return 0;

    if (ctx->ftrace_addr)
        return -EADDRNOTAVAIL;
    ctx->ftrace_addr =3D true;

    return 0;
}

I'll send the V3 after more feedback :/

> +       ctx->addr =3D addr;
> +       if (!ftrace_location(addr))
> +               return 0;
> +
> +       if (ctx->ftrace_addr)
> +               return -EADDRNOTAVAIL;
> +       ctx->ftrace_addr =3D true;
> +
> +       return 0;
> +}
> +
> +static int symbol_mod_callback(void *data, const char *name, unsigned lo=
ng addr)
> +{
> +       if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) !=3D 0=
)
> +               return 0;
> +
> +       return symbol_callback(data, addr);
> +}
> +
> +/**
> + * bpf_lookup_attach_addr: Lookup address for a symbol
> + *
> + * @mod: kernel module to lookup the symbol, NULL means to lookup both v=
mlinux
> + * and modules symbols
> + * @sym: the symbol to resolve
> + * @addr: pointer to store the result
> + *
> + * Lookup the address of the symbol @sym. If multiple symbols with the n=
ame
> + * @sym exist, the one that has ftrace location is preferred. If more
> + * than 1 has ftrace location, -EADDRNOTAVAIL will be returned.
> + *
> + * Returns: 0 on success, -errno otherwise.
> + */
> +static int bpf_lookup_attach_addr(const struct module *mod, const char *=
sym,
> +                                 unsigned long *addr)
> +{
> +       struct symbol_lookup_ctx ctx =3D { .addr =3D 0, .name =3D sym };
> +       const char *mod_name =3D NULL;
> +       int err =3D 0;
> +
> +#ifdef CONFIG_MODULES
> +       mod_name =3D mod ? mod->name : NULL;
> +#endif
> +       if (!mod_name)
> +               err =3D kallsyms_on_each_match_symbol(symbol_callback, sy=
m, &ctx);
> +
> +       if (!err && !ctx.addr)
> +               err =3D module_kallsyms_on_each_symbol(mod_name, symbol_m=
od_callback,
> +                                                    &ctx);
> +
> +       if (!ctx.addr)
> +               err =3D -ENOENT;
> +       *addr =3D err ? 0 : ctx.addr;
> +
> +       return err;
> +}
> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>                             const struct bpf_prog *prog,
>                             const struct bpf_prog *tgt_prog,
> @@ -23729,18 +23796,18 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
>                         if (btf_is_module(btf)) {
>                                 mod =3D btf_try_get_module(btf);
>                                 if (mod)
> -                                       addr =3D find_kallsyms_symbol_val=
ue(mod, tname);
> +                                       ret =3D bpf_lookup_attach_addr(mo=
d, tname, &addr);
>                                 else
> -                                       addr =3D 0;
> +                                       ret =3D -ENOENT;
>                         } else {
> -                               addr =3D kallsyms_lookup_name(tname);
> +                               ret =3D bpf_lookup_attach_addr(NULL, tnam=
e, &addr);
>                         }
> -                       if (!addr) {
> +                       if (ret) {
>                                 module_put(mod);
>                                 bpf_log(log,
>                                         "The address of function %s canno=
t be found\n",
>                                         tname);
> -                               return -ENOENT;
> +                               return ret;
>                         }
>                 }
>
> --
> 2.39.5
>

