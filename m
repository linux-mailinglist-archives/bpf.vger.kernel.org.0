Return-Path: <bpf+bounces-62635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D44AFC0E3
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5181AA5AA4
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57789224AEB;
	Tue,  8 Jul 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsfyybdg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051B1754B;
	Tue,  8 Jul 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942151; cv=none; b=a6i5hszl4i/PXiCcb43l2Co9v/Uz6zMwMcj4boXCy4JtfWfIp1yyuy1bnR6S3rTNhOMBfVngyEYoH8Chded355JMA2aU12wyfpWaDJnVeeoHkBCSxrMJdJjwTnxu8HYE0pdiTLo1V4g/XNVzjyadpxlUGXiBJCkskyZzXYoRWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942151; c=relaxed/simple;
	bh=xwN98Ie+Ge+4VCXovYlapB/UrNLjSdLTeF7FfmKCAVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEpkkasNl0qkTdzH1AYCGYvnmp/B4yLY+Cy+K3ak7MCjJJ5SuErKLDh71QSd5EpLEA3oJbJ9rC+ygaswD1NgqqYJNYaZafKNcbwOSA56gH2sF7+PL42iv+vmq43RxZ8jOUvcysCOOgbcr6lCXeuCVQjUEDqdEaLU7VoKqYntEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dsfyybdg; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-70e75f30452so25159997b3.2;
        Mon, 07 Jul 2025 19:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751942148; x=1752546948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiDhU6jpJ3qy0WQW/Fh8N4Y4B4SIEwwHTiIUQXJqy28=;
        b=DsfyybdggO8hU9EFxJBkmuMnIBjk2r1GtJ61Ivlr2P7fVzT/6cW/bj+MC4WkVncqDc
         qlp/l9tG8Hw1eM7LJrTDc+gUR+PTzRavUMxNyFEApmVPP6uDunzhUcn7nePxs++PXuJF
         Ds3sUB6LxUTy5KtI80PGsTFNlENk0y4j7wySNMjueaBpnTxitpoU8G918FQz7eiTIgoK
         puTKUksuTQNIiJVf8DzQFiCEZFWe83P6k/IZGPditq6OyhR7fye+/EXt3nSNntmH/Y1+
         ZSCTMMBupApw06qzRPeWnMJijitdcHuABy0vwUTuWyE8m4SMYdRPSR5Pu7qXTHFV4kmw
         IcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751942148; x=1752546948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiDhU6jpJ3qy0WQW/Fh8N4Y4B4SIEwwHTiIUQXJqy28=;
        b=A7h1q2FwX23kVbx00ZqZpekXev2lcFS97C3ga5jBJcf7gSTtej6KwPwUqXV7aOy75M
         75KmPtt2ZhRHQ+oM8hMazxFSerg0+USAkvP+kTafUqzX3v9yTLRow6SMIyo+yDvCIix4
         4R8MqEQTu8SIhb5/dbzDf6C722dJHBc1/TbpgqIntsYF19VJ+qiqhPSpNdQ9/78Lwzoz
         Dq57qwzFsLVLRy8UDJVYxa9073r2EUn6SL4WfqmyHgqfe0k8eY7o4jSGAU+gINCZ5CMQ
         4mNtWubeqi9C0rdOOp5Co5o3pRWR3o/IIAr9OmtqsNJHcpM/c04XgaWr97fokCZ39Kff
         6CHw==
X-Forwarded-Encrypted: i=1; AJvYcCXRJeFzpQ4RiBMwaiLKj4IpNCQ34qgYxtNkyYgi79W15VTmoI2pTDxVzf/u6OV5YP/ieiGvwbWHrXIEsmIF@vger.kernel.org, AJvYcCXbxtS5AkmkzlC9oZZRnxrrOVfaElU8eEg5WhaZCSk1uL8N7g3VDgAmkfhp2jmafTiGRTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvs27qFpeQUisF4OHxlEbH8iwwbkX8y+CCFNbqtz6roOj2NnuO
	ePtTazthDuBD1R8RT21Wrq8hHVS73SrzUKXgpNBr7ZcrzkZk3tRyCPiWjvCtDdZM+3wYad140/x
	juT7frhySB82BVmo52hYry4UuO7dHzNKGO9tbkAw=
X-Gm-Gg: ASbGncuXB85qBgv9e3N5rl3wQtmVlViYtW4fuslWFxNnHoLCw7swypszWkhJsE6FgC8
	LfOjFSCiymYwhYYAmzncd0xMKkitJ4BdToghbvxUREgd3y0ulID8mPgii2JO9jv3H3ITWXuR41n
	d++ZSe1yctKD9gm6NMTZ0veixycS23AH8jmo/PmMsNGKQ=
X-Google-Smtp-Source: AGHT+IH+bHSPK8AJQkedLWdhq56VIRLFi0nDA4bYiFydrt2rdTQENNnQ5w78o5BY4JHSEIdXOCNHUZB52lR5LdxxDjA=
X-Received: by 2002:a05:690c:60c9:b0:6ef:5097:5daa with SMTP id
 00721157ae682-717a03dfa25mr14438407b3.34.1751942147661; Mon, 07 Jul 2025
 19:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707113528.378303-1-dongml2@chinatelecom.cn> <dd816dfa-bb67-4544-b9fc-8de16af03fac@iogearbox.net>
In-Reply-To: <dd816dfa-bb67-4544-b9fc-8de16af03fac@iogearbox.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 8 Jul 2025 10:34:49 +0800
X-Gm-Features: Ac12FXwbbkSorz69IeDsKzO_mkpTwEq5xr1TgHl33NHEJaA9dA8cG89kXo3yiYE
Message-ID: <CADxym3bxQZGLdg=ZQG3vjtAEf4qZMeRu-A1XZj85ee9h5=EDCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make the attach target more accurate
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>, 
	alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:09=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 7/7/25 1:35 PM, Menglong Dong wrote:
> > For now, we lookup the address of the attach target in
> > bpf_check_attach_target() with find_kallsyms_symbol_value or
> > kallsyms_lookup_name, which is not accurate in some cases.
> >
> > For example, we want to attach to the target "t_next", but there are
> > multiple symbols with the name "t_next" exist in the kallsyms. The one
> > that kallsyms_lookup_name() returned may have no ftrace record, which
> > makes the attach target not available. So we want the one that has ftra=
ce
> > record to be returned.
> >
> > Meanwhile, there may be multiple symbols with the name "t_next" in ftra=
ce
> > record. In this case, the attach target is ambiguous, so the attach sho=
uld
> > fail.
> >
> > Introduce the function bpf_lookup_attach_addr() to do the address looku=
p,
> > which is able to solve this problem.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> Breaks CI, see also:

Yeah, I should run the whole selftests :/

>
> First test_progs failure (test_progs-aarch64-gcc-14):
> #467/1 tracing_failure/bpf_spin_lock
> test_bpf_spin_lock:PASS:tracing_failure__open 0 nsec
> libbpf: prog 'test_spin_lock': BPF program load failed: -ENOENT
> libbpf: prog 'test_spin_lock': -- BEGIN PROG LOAD LOG --
> The address of function bpf_spin_lock cannot be found
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test_spin_lock': failed to load: -ENOENT
> libbpf: failed to load object 'tracing_failure'
> libbpf: failed to load BPF skeleton 'tracing_failure': -ENOENT
> test_bpf_spin_lock:FAIL:tracing_failure__load unexpected error: -2 (errno=
 2)
> #467/2 tracing_failure/bpf_spin_unlock
> test_bpf_spin_lock:PASS:tracing_failure__open 0 nsec
> libbpf: prog 'test_spin_unlock': BPF program load failed: -ENOENT
> libbpf: prog 'test_spin_unlock': -- BEGIN PROG LOAD LOG --
> The address of function bpf_spin_unlock cannot be found
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test_spin_unlock': failed to load: -ENOENT
> libbpf: failed to load object 'tracing_failure'
> libbpf: failed to load BPF skeleton 'tracing_failure': -ENOENT
> test_bpf_spin_lock:FAIL:tracing_failure__load unexpected error: -2 (errno=
 2)
>
> >   kernel/bpf/verifier.c | 76 ++++++++++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 71 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f6cc2275695..9a7128da6d13 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23436,6 +23436,72 @@ static int check_non_sleepable_error_inject(u3=
2 btf_id)
> >       return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_i=
d);
> >   }
> >
> > +struct symbol_lookup_ctx {
> > +     const char *name;
> > +     unsigned long addr;
> > +};
> > +
> > +static int symbol_callback(void *data, unsigned long addr)
> > +{
> > +     struct symbol_lookup_ctx *ctx =3D data;
> > +
> > +     if (!ftrace_location(addr))
> > +             return 0;
> > +
> > +     if (ctx->addr)
> > +             return -EADDRNOTAVAIL;
> > +
> > +     ctx->addr =3D addr;
> > +
> > +     return 0;
> > +}
> > +
> > +static int symbol_mod_callback(void *data, const char *name, unsigned =
long addr)
> > +{
> > +     if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) !=3D 0=
)
> > +             return 0;
> > +
> > +     return symbol_callback(data, addr);
> > +}
> > +
> > +/**
> > + * bpf_lookup_attach_addr: Lookup address for a symbol
> > + *
> > + * @mod: kernel module to lookup the symbol, NULL means to lookup the =
kernel
> > + * symbols
> > + * @sym: the symbol to resolve
> > + * @addr: pointer to store the result
> > + *
> > + * Lookup the address of the symbol @sym, and the address should has
> > + * corresponding ftrace location. If multiple symbols with the name @s=
ym
> > + * exist, the one that has ftrace location will be returned. If more t=
han
> > + * 1 has ftrace location, -EADDRNOTAVAIL will be returned.
> > + *
> > + * Returns: 0 on success, -errno otherwise.
> > + */
> > +static int bpf_lookup_attach_addr(const struct module *mod, const char=
 *sym,
> > +                               unsigned long *addr)
> > +{
> > +     struct symbol_lookup_ctx ctx =3D { .addr =3D 0, .name =3D sym };
> > +     int err;
> > +
> > +     if (!mod)
> > +             err =3D kallsyms_on_each_match_symbol(symbol_callback, sy=
m, &ctx);
>
> This is also not really equivalent to kallsyms_lookup_name(). kallsyms_on=
_each_match_symbol()
> only iterates over all symbols in vmlinux whereas kallsyms_lookup_name() =
looks up both vmlinux
> and modules.

Yeah, my mistake. I'll fixup this logic in the next version.

Thanks!
Menglong Dong

>
> > +     else
> > +             err =3D module_kallsyms_on_each_symbol(mod->name, symbol_=
mod_callback,
> > +                                                  &ctx);
> > +
> > +     if (!ctx.addr)
> > +             return -ENOENT;
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     *addr =3D ctx.addr;
> > +
> > +     return 0;
> > +}
> > +
> >   int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                           const struct bpf_prog *prog,
> >                           const struct bpf_prog *tgt_prog,
> > @@ -23689,18 +23755,18 @@ int bpf_check_attach_target(struct bpf_verifi=
er_log *log,
> >                       if (btf_is_module(btf)) {
> >                               mod =3D btf_try_get_module(btf);
> >                               if (mod)
> > -                                     addr =3D find_kallsyms_symbol_val=
ue(mod, tname);
> > +                                     ret =3D bpf_lookup_attach_addr(mo=
d, tname, &addr);
> >                               else
> > -                                     addr =3D 0;
> > +                                     ret =3D -ENOENT;
> >                       } else {
> > -                             addr =3D kallsyms_lookup_name(tname);
> > +                             ret =3D bpf_lookup_attach_addr(NULL, tnam=
e, &addr);
> >                       }
> > -                     if (!addr) {
> > +                     if (ret) {
> >                               module_put(mod);
> >                               bpf_log(log,
> >                                       "The address of function %s canno=
t be found\n",
> >                                       tname);
> > -                             return -ENOENT;
> > +                             return ret;
> >                       }
> >               }
> >
>

