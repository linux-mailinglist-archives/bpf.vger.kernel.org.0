Return-Path: <bpf+bounces-62998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97147B01301
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 07:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEF37A87EC
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 05:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2C1C84D7;
	Fri, 11 Jul 2025 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORwrHJDa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8E17A300;
	Fri, 11 Jul 2025 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213096; cv=none; b=hcOle6Io6WSQX8uelVg9W1qGQV0SMlbBrm9YGi+j/iJY3pPSmddyZHJUliQyYb/6ziHZ5f/TiS4oOPDw13I9CdxvK3bsJwzMEIz4UfjEUk4nbvlqW9ZyznAWgYenAVuXIc3TcrXhZCujwF8Bk/SJs/qxYB1RVK54D4UKHDm7Rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213096; c=relaxed/simple;
	bh=jNsGupoBgwkp5RDX4ibpgNUay2qHWr/Leph5FYAPlOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsjNINnNmvK87WkL0/xiJdiJRk2I4QZWqmbqEdiNsjiKW35sDLBOPjbilLSkMfBrKYQfY2Hb1T2CYH8i4LWRMcJQWBo91e4mO9xonG4D2BqGHtgoR/ANzt1u+JxsinAuop2gRgTUEcrenJ8+UnTRuYyHI0F87mJdNbVAsob9ZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORwrHJDa; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e740a09eb00so1417302276.0;
        Thu, 10 Jul 2025 22:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752213093; x=1752817893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s15kRBz3DosUsTKGgSKKOINpNlddbEfVm+2y2VNaNrQ=;
        b=ORwrHJDaPcg4THpyrp/AcS4BgCUsB2yPx5qMp49eHvAqVJbM46fQOiPBJii8ThhOsn
         c1tSITJuxTsICkEh1LDMGSPnNUZvIO0R7Xgh7NbMfq2lCNjO1Xh9KG23V8aMTDODDtXt
         iqv7Tlg23NvcEcoZF3n4c35o6COTea59jH5SVjc6IfJAzYvIw0bV+AstO+QS7CjcHAmw
         2QUGoH/T8G/Oks3MW3VuRuKbvBuILaT07ydOXS62bPgeRk1maFfW/RIeKzUWKqDBBjtL
         mpMqwrBt3k2JYqxhJPnOUPDCUNWMjZGYudowzMxnRWPX+WaFgMIv2/BXitwg0BtNjnJ/
         JdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752213094; x=1752817894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s15kRBz3DosUsTKGgSKKOINpNlddbEfVm+2y2VNaNrQ=;
        b=AFBA/vNJSWYbqpFDdcae0THxt+bI7ZSiorPlcQAV7vhrYFAMwp4EDfdUhcaEdGL8Xn
         dmG00N8CfCGu3FYf45erQcJ6n9QIEwsMiNwwLnoKjP9Myc5SnDer92Jg8365dXbPll1t
         znqcwlbACJlblvT/UHKw/LsSNFw9noPtYc6ZaTMLHE+DvxrpTYup61IKxWQTUK+cYAZn
         Y5Eybkj+/XRUnPn9EWgRNBN1JQLcTctSzbQIe1npRDrUD9Hz/mhpJxTdItCq+bMDoxxu
         u9r1G3l9iowBcKFaqpzX2xshKb45jo5NI9Su9FAbGoW5uNvl6BnRiCZ5eOsFSbL4FqVC
         Hg5A==
X-Forwarded-Encrypted: i=1; AJvYcCUnoDXK+ggsarb8e7Td7zH3g1xJB4qEtx6vfFgKBFFfI0JQGZ9QXL69OtPm0w/yjUvMVQM=@vger.kernel.org, AJvYcCWB7XdxpPm5Qma7VFPFvjHdGQ5dpqUgs1y7uUGiRz8QrUJrfm1BuOH2VefQzFyngETwF8s6CJ+vLBhbMbdr@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUh/ofFBkfGaH3YUGzFglkyUFfezR2ubZaw99ZkPDGUZSHdg6
	wn7WkG+uUZFMoyLHICDQrolbsy8tZu34D635Bb7nMK62qwXoaYhA5XJWlfkgb5k6FkmmcPTyEU1
	3891qwqeTyiUC3Ll2O6ZPta5RYXLdjlQ=
X-Gm-Gg: ASbGncteO/JJ4PKsE3v7/tF0cOyZe4d40xJSlgTjdbvrdh0PEVEg8nR1QCLkkV7506g
	8uZk0IpFQVl+ayowt4Q8NnPzaHKI0hmdlDzFzrhbOZ8lcy8/CBZDbpDJMW/D6omKprvMhs7YSiG
	zxHHrqllZRc7N5wJ1KF01fYubrbrH7FU/oGp/zQhoV/5TvMjy93V4ozCd3oAagmYQVikPrgzrI0
	s2aO88=
X-Google-Smtp-Source: AGHT+IERE+v0OcXSMuyOLN1LpYSWLXq88YYT0bb9OVBfX5SbgkyM/k5Ofm+PXPIZgzHh56tkluyz04fLEceA9wxZvro=
X-Received: by 2002:a05:690c:55c3:10b0:717:d7d1:4697 with SMTP id
 00721157ae682-717d7d15b34mr18439917b3.30.1752213093556; Thu, 10 Jul 2025
 22:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev> <ffcbe060-a15d-44d7-bf5e-090e74726c31@linux.dev>
In-Reply-To: <ffcbe060-a15d-44d7-bf5e-090e74726c31@linux.dev>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 11 Jul 2025 13:51:31 +0800
X-Gm-Features: Ac12FXwUN2IQLfPZaothBP8FC6pjD8dQ52POIYDGAy3WNsBZX3GgBz_Cr82hdaE
Message-ID: <CADxym3YGF6jCg=J1bQs60SePEwigh7S+7yfXAdU+yc3WX9HAGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 11:46=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 7/10/25 8:10 PM, Yonghong Song wrote:
> >
> >
> > On 7/10/25 12:08 AM, Menglong Dong wrote:
> >> For now, we lookup the address of the attach target in
> >> bpf_check_attach_target() with find_kallsyms_symbol_value or
> >> kallsyms_lookup_name, which is not accurate in some cases.
> >>
> >> For example, we want to attach to the target "t_next", but there are
> >> multiple symbols with the name "t_next" exist in the kallsyms, which
> >> makes
> >> the attach target ambiguous, and the attach should fail.
> >>
> >> Introduce the function bpf_lookup_attach_addr() to do the address
> >> lookup,
> >> which will return -EADDRNOTAVAIL when the symbol is not unique.
> >>
> >> We can do the testing with following shell:
> >>
> >> for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
> >> do
> >>    if grep -q "^$s\$"
> >> /sys/kernel/debug/tracing/available_filter_functions
> >>    then
> >>      bpftrace -e "fentry:$s {printf(\"1\");}" -v
> >>    fi
> >> done
> >>
> >> The script will find all the duplicated symbols in /proc/kallsyms, whi=
ch
> >> is also in /sys/kernel/debug/tracing/available_filter_functions, and
> >> attach them with bpftrace.
> >>
> >> After this patch, all the attaching fail with the error:
> >>
> >> The address of function xxx cannot be found
> >> or
> >> No BTF found for xxx
> >>
> >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > Maybe we should prevent vmlinux BTF generation for such symbols
> > which are static and have more than one instances? This can
> > be done in pahole and downstream libbpf/kernel do not
> > need to do anything. This can avoid libbpf/kernel runtime overhead
> > since bpf_lookup_attach_addr() could be expensive as it needs
> > to go through ALL symbols, even for unique symbols.

Hi, yonghong. You are right, the best solution is to solve
this problem in the pahole, just like what Jiri said in the V2:
  https://lore.kernel.org/bpf/aG5hzvaqXi7uI4GL@krava/

I wonder will we focus the users to use the latest pahole
that supports duplicate symbols filter after we fix this problem
in pahole? If so, this patch is useless, and just ignore it. If
not, the only usage of this patch is for the users that build
the kernel with an old pahole.

>
> There is a multi-link effort:
>    https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinatele=
com.cn/
> which tries to do similar thing for multi-kprobe. For example, for fentry=
,
> multi-link may pass an array of btf_id's to the kernel. For such cases,
> this patch may cause significant performance overhead.

For the symbol in the vmlinux, there will be no additional overhead,
as the logic is the same as previous. If the symbol is in the
modules, it does have additional overhead. Following is the
testing that hooks all the symbols with fentry-multi.

Without this patch, the time to attach all the symbols:
kernel: 0.372660s for 48857 symbols
modules: 0.135543s for 8631 symbols

And with this patch, the time is:
kernel: 0.380087s for 48857 symbols
modules: 0.176904s for 8631 symbols

One more thing, is there anyone to fix the problem in pahole?
I mean, I'm not good at pahole. But if there is nobody, I still can
do this job, but I need to learn it first :/

Thanks!
Menglong Dong
>
> >
> >
> >> ---
> >> v3:
> >> - reject all the duplicated symbols
> >> v2:
> >> - Lookup both vmlinux and modules symbols when mod is NULL, just like
> >>    kallsyms_lookup_name().
> >>
> >>    If the btf is not a modules, shouldn't we lookup on the vmlinux onl=
y?
> >>    I'm not sure if we should keep the same logic with
> >>    kallsyms_lookup_name().
> >>
> >> - Return the kernel symbol that don't have ftrace location if the
> >> symbols
> >>    with ftrace location are not available
> >> ---
> >>   kernel/bpf/verifier.c | 71 ++++++++++++++++++++++++++++++++++++++++-=
--
> >>   1 file changed, 66 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 53007182b46b..bf4951154605 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -23476,6 +23476,67 @@ static int
> >> check_non_sleepable_error_inject(u32 btf_id)
> >>       return btf_id_set_contains(&btf_non_sleepable_error_inject,
> >> btf_id);
> >>   }
> >>   +struct symbol_lookup_ctx {
> >> +    const char *name;
> >> +    unsigned long addr;
> >> +};
> >> +
> >> +static int symbol_callback(void *data, unsigned long addr)
> >> +{
> >> +    struct symbol_lookup_ctx *ctx =3D data;
> >> +
> >> +    if (ctx->addr)
> >> +        return -EADDRNOTAVAIL;
> >> +    ctx->addr =3D addr;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int symbol_mod_callback(void *data, const char *name,
> >> unsigned long addr)
> >> +{
> >> +    if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) !=3D 0=
)
> >> +        return 0;
> >> +
> >> +    return symbol_callback(data, addr);
> >> +}
> >> +
> >> +/**
> >> + * bpf_lookup_attach_addr: Lookup address for a symbol
> >> + *
> >> + * @mod: kernel module to lookup the symbol, NULL means to lookup
> >> both vmlinux
> >> + * and modules symbols
> >> + * @sym: the symbol to resolve
> >> + * @addr: pointer to store the result
> >> + *
> >> + * Lookup the address of the symbol @sym. If multiple symbols with
> >> the name
> >> + * @sym exist, -EADDRNOTAVAIL will be returned.
> >> + *
> >> + * Returns: 0 on success, -errno otherwise.
> >> + */
> >> +static int bpf_lookup_attach_addr(const struct module *mod, const
> >> char *sym,
> >> +                  unsigned long *addr)
> >> +{
> >> +    struct symbol_lookup_ctx ctx =3D { .addr =3D 0, .name =3D sym };
> >> +    const char *mod_name =3D NULL;
> >> +    int err =3D 0;
> >> +
> >> +#ifdef CONFIG_MODULES
> >> +    mod_name =3D mod ? mod->name : NULL;
> >> +#endif
> >> +    if (!mod_name)
> >> +        err =3D kallsyms_on_each_match_symbol(symbol_callback, sym,
> >> &ctx);
> >> +
> >> +    if (!err && !ctx.addr)
> >> +        err =3D module_kallsyms_on_each_symbol(mod_name,
> >> symbol_mod_callback,
> >> +                             &ctx);
> >> +
> >> +    if (!ctx.addr)
> >> +        err =3D -ENOENT;
> >> +    *addr =3D err ? 0 : ctx.addr;
> >> +
> >> +    return err;
> >> +}
> >> +
> >>   int bpf_check_attach_target(struct bpf_verifier_log *log,
> >>                   const struct bpf_prog *prog,
> >>                   const struct bpf_prog *tgt_prog,
> >> @@ -23729,18 +23790,18 @@ int bpf_check_attach_target(struct
> >> bpf_verifier_log *log,
> >>               if (btf_is_module(btf)) {
> >>                   mod =3D btf_try_get_module(btf);
> >>                   if (mod)
> >> -                    addr =3D find_kallsyms_symbol_value(mod, tname);
> >> +                    ret =3D bpf_lookup_attach_addr(mod, tname, &addr)=
;
> >>                   else
> >> -                    addr =3D 0;
> >> +                    ret =3D -ENOENT;
> >>               } else {
> >> -                addr =3D kallsyms_lookup_name(tname);
> >> +                ret =3D bpf_lookup_attach_addr(NULL, tname, &addr);
> >>               }
> >> -            if (!addr) {
> >> +            if (ret) {
> >>                   module_put(mod);
> >>                   bpf_log(log,
> >>                       "The address of function %s cannot be found\n",
> >>                       tname);
> >> -                return -ENOENT;
> >> +                return ret;
> >>               }
> >>           }
> >
> >
>

