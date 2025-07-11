Return-Path: <bpf+bounces-63001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5704B013CC
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F173BB41CFE
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A21E1A3F;
	Fri, 11 Jul 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Vx+vLe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751991DF73A;
	Fri, 11 Jul 2025 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215852; cv=none; b=GEq7vWMeBcD/TFMgaXEn7GZXzpToR6bu3per8N1soLyJUgAmAjz3j3gG2HtFGB2GLUQTPUPPNVeAMgODZdo1TSUKXugZOdNfOXBHKRU0BHHssNxYjuQYWwW5GGRttD8mzt5V+ZW4h//Bg9gS6L62l6s8Jy/DTa7MoSpiYpGGjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215852; c=relaxed/simple;
	bh=Gw34TIF2O3A/92nLaUOA5hD86g0IzCMO6c4WBPZaod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8INQAXaK13AZ+sgg60MoUOJNdDMuIuTxJN78AZRyQy98XesDEvaNt27pvWQCk/IYRY+T7SxX4eaYHc4U6lrIXf4OqzGhEkmuLx+2NYEdza5mhD18xi3MN3+flsZIDMrArdYtjCRXa0hslpbV1KA/xIN64MAeb+56zKFGww4FNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Vx+vLe; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e818a572828so1205161276.1;
        Thu, 10 Jul 2025 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752215848; x=1752820648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQfdRyeJLZsCKrWpI38VIbdzPscXUDG+QOWG3WgPudw=;
        b=i0Vx+vLeUhpyLjDtPewpat6WHi1O6kAjUQvuzfB3ngl/EJwUkPqV3L1IAledx5i9EF
         OlMaAfhgG/mrDNFd2avHwkM7SqTv2Ww1b0/vjWfObCnos1iZhKzYMET6EWJcZpbwSPkG
         564iOCHOfU3huW0luu9b++AS4mpx7Rlvf0WqbG3BwP70TwZ82gCf7veQpVEyS0k8pDNe
         IpB22IcwM5IX+yFRBqIbL8unOXE3pKHrFnqcPpd1hd5kf8czUG6M9AxlH/1OQ3QA1jwQ
         A00ys+G6RSqteelNKkuzWHQ1EwdTjkNAaK3dP0iu06qfEaIKVsr0RJ67Zdbg70F81wqN
         RcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215848; x=1752820648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQfdRyeJLZsCKrWpI38VIbdzPscXUDG+QOWG3WgPudw=;
        b=vtom1f5c09CzuROYx84p2jukzdGWw5dx58JBbYEO4+iHXhBfFut2waqFRW2eOrGnoH
         ihpHS+8Q5NaO9mcxI64gOcmRU1jh/R8uaf6yjuElr5sKlzDVErPC8GMNXX8GGDGBdHxA
         lCFjlYnTwpQrwBcSYZ5dLWJXGw+HdrTHyB3ZZB0LhblpGmHDmz9+4sMbBblvYAEtLAab
         PzBshqBb1iMrrg47l5JD1khDYKVGqQ7IXzAMAYc4pRLBESEW3WNwOU3vV4UM68KMLNHK
         dc+dudqVaOqav0gsNPOAqQ/0opglPWX6wcxkC5Wbu/mkCSyZBfetXHArlQLyTyo+xinL
         kqYA==
X-Forwarded-Encrypted: i=1; AJvYcCU42c5/plaVAb4+fQD0hJvzF/OY9oahhlKQzJJcJ9Vqp38pnKNdCY2y9YCgAGbGuCwIybM=@vger.kernel.org, AJvYcCVKi0Rs/zFLu8T3Fo+iNK3E+y89ijcXFcBpwZFF6GsOaMTXvPJrr+8/8DL2XtZ7buyS/1P6BzG8xAIp6MC8@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKps7UkTi7i03ZCSoet7fmmzRbhmZOrIAnsWL8HW29AJAIrLG
	bHmsSc/tRLEfb2Ms5plka8YB6T7j9OsTJh2w/Dd68j0sSkP0TPAhfIQR42nkoBGhu2KkmIVIpCl
	jjEyVoTObRSAqlF/3wL3wiCujFA/CIuE=
X-Gm-Gg: ASbGncvW0p2dBmu4MIw0qYZ4+ffixUzsrdMG1b2d/P++GJ+QfLhswgN88ajKA/xzHVl
	IP0pCKPSA/dWgWNfM1LfpQi1EV1wRFE6RtFkkjFyGhbL8ldBVkDGMRfk0P0OqTs8A+DKD2vTYqp
	GXpZ2J69p4NBnunCWxkrt5HPkcZrRVM6xzSN9+9ZwdLTK+5sR8FatTevIL03pQqhjP18fZ7G7wP
	LkLZ/A=
X-Google-Smtp-Source: AGHT+IF+hnrAvAs5PUGAQiuzc5rqeOCol/PHznwL+InIRM1WGnipn0Fow62VHBbUAYgXMjVAK72VbcBVGnz3CPIF8uk=
X-Received: by 2002:a05:690c:6208:b0:70d:f673:1412 with SMTP id
 00721157ae682-717d5930274mr40774157b3.0.1752215848241; Thu, 10 Jul 2025
 23:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev> <ffcbe060-a15d-44d7-bf5e-090e74726c31@linux.dev>
 <CADxym3YGF6jCg=J1bQs60SePEwigh7S+7yfXAdU+yc3WX9HAGQ@mail.gmail.com>
In-Reply-To: <CADxym3YGF6jCg=J1bQs60SePEwigh7S+7yfXAdU+yc3WX9HAGQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 11 Jul 2025 14:37:25 +0800
X-Gm-Features: Ac12FXyOL_t2NlT12a7bO87pBIHPfPGSaCPUG9yKTsgii7W5iCxAzwIz-DcAR8s
Message-ID: <CADxym3Yt7ngKw1NL_i56ZZ22ExB7LYcuN28k8iZEDtfc83Oqow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:51=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, Jul 11, 2025 at 11:46=E2=80=AFAM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >
> >
> >
> > On 7/10/25 8:10 PM, Yonghong Song wrote:
> > >
> > >
> > > On 7/10/25 12:08 AM, Menglong Dong wrote:
> > >> For now, we lookup the address of the attach target in
> > >> bpf_check_attach_target() with find_kallsyms_symbol_value or
> > >> kallsyms_lookup_name, which is not accurate in some cases.
> > >>
> > >> For example, we want to attach to the target "t_next", but there are
> > >> multiple symbols with the name "t_next" exist in the kallsyms, which
> > >> makes
> > >> the attach target ambiguous, and the attach should fail.
> > >>
> > >> Introduce the function bpf_lookup_attach_addr() to do the address
> > >> lookup,
> > >> which will return -EADDRNOTAVAIL when the symbol is not unique.
> > >>
> > >> We can do the testing with following shell:
> > >>
> > >> for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
> > >> do
> > >>    if grep -q "^$s\$"
> > >> /sys/kernel/debug/tracing/available_filter_functions
> > >>    then
> > >>      bpftrace -e "fentry:$s {printf(\"1\");}" -v
> > >>    fi
> > >> done
> > >>
> > >> The script will find all the duplicated symbols in /proc/kallsyms, w=
hich
> > >> is also in /sys/kernel/debug/tracing/available_filter_functions, and
> > >> attach them with bpftrace.
> > >>
> > >> After this patch, all the attaching fail with the error:
> > >>
> > >> The address of function xxx cannot be found
> > >> or
> > >> No BTF found for xxx
> > >>
> > >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > >
> > > Maybe we should prevent vmlinux BTF generation for such symbols
> > > which are static and have more than one instances? This can
> > > be done in pahole and downstream libbpf/kernel do not
> > > need to do anything. This can avoid libbpf/kernel runtime overhead
> > > since bpf_lookup_attach_addr() could be expensive as it needs
> > > to go through ALL symbols, even for unique symbols.
>
> Hi, yonghong. You are right, the best solution is to solve
> this problem in the pahole, just like what Jiri said in the V2:
>   https://lore.kernel.org/bpf/aG5hzvaqXi7uI4GL@krava/
>
> I wonder will we focus the users to use the latest pahole
> that supports duplicate symbols filter after we fix this problem
> in pahole? If so, this patch is useless, and just ignore it. If
> not, the only usage of this patch is for the users that build
> the kernel with an old pahole.

Sorry that I forgot to Cc Jiri :/

>
> >
> > There is a multi-link effort:
> >    https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinate=
lecom.cn/
> > which tries to do similar thing for multi-kprobe. For example, for fent=
ry,
> > multi-link may pass an array of btf_id's to the kernel. For such cases,
> > this patch may cause significant performance overhead.
>
> For the symbol in the vmlinux, there will be no additional overhead,
> as the logic is the same as previous. If the symbol is in the
> modules, it does have additional overhead. Following is the
> testing that hooks all the symbols with fentry-multi.
>
> Without this patch, the time to attach all the symbols:
> kernel: 0.372660s for 48857 symbols
> modules: 0.135543s for 8631 symbols
>
> And with this patch, the time is:
> kernel: 0.380087s for 48857 symbols
> modules: 0.176904s for 8631 symbols
>
> One more thing, is there anyone to fix the problem in pahole?
> I mean, I'm not good at pahole. But if there is nobody, I still can
> do this job, but I need to learn it first :/
>
> Thanks!
> Menglong Dong
> >
> > >
> > >
> > >> ---
> > >> v3:
> > >> - reject all the duplicated symbols
> > >> v2:
> > >> - Lookup both vmlinux and modules symbols when mod is NULL, just lik=
e
> > >>    kallsyms_lookup_name().
> > >>
> > >>    If the btf is not a modules, shouldn't we lookup on the vmlinux o=
nly?
> > >>    I'm not sure if we should keep the same logic with
> > >>    kallsyms_lookup_name().
> > >>
> > >> - Return the kernel symbol that don't have ftrace location if the
> > >> symbols
> > >>    with ftrace location are not available
> > >> ---
> > >>   kernel/bpf/verifier.c | 71 +++++++++++++++++++++++++++++++++++++++=
+---
> > >>   1 file changed, 66 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index 53007182b46b..bf4951154605 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -23476,6 +23476,67 @@ static int
> > >> check_non_sleepable_error_inject(u32 btf_id)
> > >>       return btf_id_set_contains(&btf_non_sleepable_error_inject,
> > >> btf_id);
> > >>   }
> > >>   +struct symbol_lookup_ctx {
> > >> +    const char *name;
> > >> +    unsigned long addr;
> > >> +};
> > >> +
> > >> +static int symbol_callback(void *data, unsigned long addr)
> > >> +{
> > >> +    struct symbol_lookup_ctx *ctx =3D data;
> > >> +
> > >> +    if (ctx->addr)
> > >> +        return -EADDRNOTAVAIL;
> > >> +    ctx->addr =3D addr;
> > >> +
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +static int symbol_mod_callback(void *data, const char *name,
> > >> unsigned long addr)
> > >> +{
> > >> +    if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) !=3D=
 0)
> > >> +        return 0;
> > >> +
> > >> +    return symbol_callback(data, addr);
> > >> +}
> > >> +
> > >> +/**
> > >> + * bpf_lookup_attach_addr: Lookup address for a symbol
> > >> + *
> > >> + * @mod: kernel module to lookup the symbol, NULL means to lookup
> > >> both vmlinux
> > >> + * and modules symbols
> > >> + * @sym: the symbol to resolve
> > >> + * @addr: pointer to store the result
> > >> + *
> > >> + * Lookup the address of the symbol @sym. If multiple symbols with
> > >> the name
> > >> + * @sym exist, -EADDRNOTAVAIL will be returned.
> > >> + *
> > >> + * Returns: 0 on success, -errno otherwise.
> > >> + */
> > >> +static int bpf_lookup_attach_addr(const struct module *mod, const
> > >> char *sym,
> > >> +                  unsigned long *addr)
> > >> +{
> > >> +    struct symbol_lookup_ctx ctx =3D { .addr =3D 0, .name =3D sym }=
;
> > >> +    const char *mod_name =3D NULL;
> > >> +    int err =3D 0;
> > >> +
> > >> +#ifdef CONFIG_MODULES
> > >> +    mod_name =3D mod ? mod->name : NULL;
> > >> +#endif
> > >> +    if (!mod_name)
> > >> +        err =3D kallsyms_on_each_match_symbol(symbol_callback, sym,
> > >> &ctx);
> > >> +
> > >> +    if (!err && !ctx.addr)
> > >> +        err =3D module_kallsyms_on_each_symbol(mod_name,
> > >> symbol_mod_callback,
> > >> +                             &ctx);
> > >> +
> > >> +    if (!ctx.addr)
> > >> +        err =3D -ENOENT;
> > >> +    *addr =3D err ? 0 : ctx.addr;
> > >> +
> > >> +    return err;
> > >> +}
> > >> +
> > >>   int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >>                   const struct bpf_prog *prog,
> > >>                   const struct bpf_prog *tgt_prog,
> > >> @@ -23729,18 +23790,18 @@ int bpf_check_attach_target(struct
> > >> bpf_verifier_log *log,
> > >>               if (btf_is_module(btf)) {
> > >>                   mod =3D btf_try_get_module(btf);
> > >>                   if (mod)
> > >> -                    addr =3D find_kallsyms_symbol_value(mod, tname)=
;
> > >> +                    ret =3D bpf_lookup_attach_addr(mod, tname, &add=
r);
> > >>                   else
> > >> -                    addr =3D 0;
> > >> +                    ret =3D -ENOENT;
> > >>               } else {
> > >> -                addr =3D kallsyms_lookup_name(tname);
> > >> +                ret =3D bpf_lookup_attach_addr(NULL, tname, &addr);
> > >>               }
> > >> -            if (!addr) {
> > >> +            if (ret) {
> > >>                   module_put(mod);
> > >>                   bpf_log(log,
> > >>                       "The address of function %s cannot be found\n"=
,
> > >>                       tname);
> > >> -                return -ENOENT;
> > >> +                return ret;
> > >>               }
> > >>           }
> > >
> > >
> >

