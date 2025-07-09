Return-Path: <bpf+bounces-62785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4062AFE904
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24EB177B8A
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3992D59E7;
	Wed,  9 Jul 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5X0rqvs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16274293443;
	Wed,  9 Jul 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064470; cv=none; b=D3bfTaMalzO3VOSER6foWb4s0+w/ehjUJFtnrovFVQjabvv1YaCq/t0LG295UcAOQONYbKCebI2o4q49V5ptzIu8o9jEyBm6oAG1X1L43sIRAUkSu+WvP6giYMVCImhILUqaYuQDF+BJLoXMScEjfGOtdSz02vycNciygZx+hA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064470; c=relaxed/simple;
	bh=neTciHf/GeoTxosoI4M7eHqhCpRePqdF2YwyjppWlMk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFELl3RjT7QxbM8sQeYVBxNyBRpdHrnLn5qzsSCha9ed5RPEfATP1dOBn/ixafwVDNmg3fMezvSR92p6FSlexpKWHpSn20fW8+gXsmAHeu40AYM3ggiTRUK+4lD54wMdMycdqGAhvQcNMKedPlXqCbTq+kJLCTwr/Nf8EtqhBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5X0rqvs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so9065896a12.1;
        Wed, 09 Jul 2025 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752064466; x=1752669266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0vXK1qyLaNeuC+9zg+Q2hpBM/UtHyJ+wP5c4OS2rpPo=;
        b=C5X0rqvsr/fHh4Y46nAkmPhu1Ct4Xh+LFCfwzxEPIf8gLKytkwgOmfr+ZR64Pw68t9
         jTI1Qcs9D0l1dAG89IhjEnUS94XK8jbxBDszch1hqjO/zvyOg+K5uQLH7+NGAZ+Yvsk0
         CIxs0SWPIr+k1H6LLzeJj1sbHd8z/70dN7hJO/MVw/c3oKynHgUj6k/OCZ2p5KOUOmPD
         /1RMc5xoBjy8atOSIrCP4iEggKsniRMTfKQV4h5gBbdY/G8GGF+/X2rB+PzYVG4jFQIu
         CQZhVP+EAdxMDQKxqdv5IChvz37+z45oWWkil1E5LQaWJlAGHQtjiSJJPFW2QYEJqrwC
         LK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064466; x=1752669266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vXK1qyLaNeuC+9zg+Q2hpBM/UtHyJ+wP5c4OS2rpPo=;
        b=TXqQTAgSybU6POCWC8Xp1DdxF+nuU+s+PpNOqArj7sisk7p7cOs97Vf2JvreQLA3Sj
         V8Cf3tkLQKWhGi0jG3Ky/mLGQi8JXT4Ki4dQNaKgKHX0L/nwI322beyluNFPe+Orw17r
         blMh8bi7HcjSzikJ/t/XvnVFMnGo4Hxb0+k4gBB0bRiEkRHGxqT7uZx3RvSYb7dKl3Fa
         8r6nN0JGCz3daccwfXdFBUzlNleUbU/kAkGb9/lmcPjiefKpGck5DlpzdJTNtBOr0p1Z
         O7GGde64HjYQ8CIYavIOM4ExC5mmSVvVVlE9jO5U3CLQQ3iwpkZ0BsjoNZrx34sKaBx8
         iz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAgCqbsJzJPCr4TzUGUPITNIzW5h0WUcHUynsPDyMEDdAKCAWABv/X98tNJNL1yc7N23s=@vger.kernel.org, AJvYcCUtngxcK5wwZZlWKv/d3ROSdZ4d8lUyljAp2lxg26NYE8k5wtp8aZbXuGpYwR6qSirrf78dT+ck5o2+faTe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+K42h18egejQygRcIwbGlqM4yyF6rsEevLmsnF7aqS0mnOrb5
	OX+l27ogqVDdUQao25asaL7sY0ZG93WB/RLh4gZYVkfjjT7d1caqJWX9
X-Gm-Gg: ASbGncs54ZvFxY/PHHnfzm/ECdxJFIRjGeCcCsIceUedL50+sdXqfYfpfGZbgXjzuVn
	FI2Y/p6k427Yg9qRWOojT7PEQc9idBVwQsiwFGQA09QVymHUFIzzthP1TUju8VmaC5FE8AQa6ed
	S/fhYfN1XFbTNvEfK1IcyeWO3ErpqHf3O/xITWTlvdr0QD19q/ne2B4zs6hHoVfKqhQ5yxgxW8s
	zNWIIeFrIIocE+Tn7YNFNY7czi/Y0SJDsRZ/EZsyWFYFG8ezRPYe3yY7D8bqvD7wRFiIrwwZlDA
	ETCG4qK+61lGILViysWhgj78+obtWmZNDrsGr+8ThZkV92pA
X-Google-Smtp-Source: AGHT+IGwxnQheSEuEmYpFP/GrFer7O+dhlqHJYnq4DMRHXwKwv+Mj81hELzobLAyXVHz7euPFkw4GQ==
X-Received: by 2002:a17:907:7252:b0:ae3:b654:165b with SMTP id a640c23a62f3a-ae6cf5fecfcmr236466666b.24.1752064465970;
        Wed, 09 Jul 2025 05:34:25 -0700 (PDT)
Received: from krava ([173.38.220.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6d94bb016sm62100566b.90.2025.07.09.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 05:34:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 9 Jul 2025 14:34:22 +0200
To: Menglong Dong <menglong8.dong@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v2] bpf: make the attach target more accurate
Message-ID: <aG5hzvaqXi7uI4GL@krava>
References: <20250708072140.945296-1-dongml2@chinatelecom.cn>
 <aG4roiqyzNFOvu2R@krava>
 <CADxym3adDgLaoQcQZLW=-fwELDi2-HTJ6tvA+HdF97+mKDErsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxym3adDgLaoQcQZLW=-fwELDi2-HTJ6tvA+HdF97+mKDErsQ@mail.gmail.com>

On Wed, Jul 09, 2025 at 06:33:08PM +0800, Menglong Dong wrote:
> On Wed, Jul 9, 2025 at 4:43 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Jul 08, 2025 at 03:21:40PM +0800, Menglong Dong wrote:
> > > For now, we lookup the address of the attach target in
> > > bpf_check_attach_target() with find_kallsyms_symbol_value or
> > > kallsyms_lookup_name, which is not accurate in some cases.
> > >
> > > For example, we want to attach to the target "t_next", but there are
> > > multiple symbols with the name "t_next" exist in the kallsyms. The one
> > > that kallsyms_lookup_name() returned may have no ftrace record, which
> > > makes the attach target not available. So we want the one that has ftrace
> > > record to be returned.
> > >
> > > Meanwhile, there may be multiple symbols with the name "t_next" in ftrace
> > > record. In this case, the attach target is ambiguous, so the attach should
> > > fail.
> >
> > could you reproduce this somehow (bpftrace/selftest) for some symbol?
> > I'd think pahole now filters all such symbols out of BTF and you need
> > BTF func record to load the program in the first place
> 
> Hi, what's the version of pahole that does such filtering? I have
> compiled the latest pahole, and such symbols exist. The version
> of the pahole is v1.30
> 
> pahole --version
> v1.30
> 
> It can be reproduced easily, just try to attach to the symbol t_next.
> The "t_next" has multiple definition:
> 
> bpftrace -e 'fentry:t_next {printf("1");}'
> Attaching 1 probe...
> ERROR: Error attaching probe: fentry:vmlinux:t_next
> 
> This is the symbol information of t_next:
> 
> cat /proc/kallsyms | grep ' t_next'
> ffffffff8142d9c0 t t_next
> ffffffff81440e80 t t_next
> ffffffff8144f1f0 t t_next
> ffffffff8145ae90 t t_next
> ffffffff81735b30 t t_next
> 
> cat /tracing/available_filter_functions | grep '^t_next'
> t_next
> 
> The related patch is here:
> https://lore.kernel.org/bpf/CADxym3Y-Jbzp0FupUgBDJB99GhsbDHyuV71Q6m9xyTpFze4ESg@mail.gmail.com/
> 
> (I just distclean and rebuild the kernel, the problem still exists)
> 

ah right.. I guess they all have same prototype, so the current pahole
filter won't trigger

I wonder pahole could filter out functions that have multiple instances
with different address, because those can't be resolved properly in
trampoline attachment

or we could mitigate that in runtime with your change

Alan, Ihor, any idea?

thanks,
jirka


> Thanks!
> Menglong Dong
> 
> >
> > jirka
> >
> >
> > >
> > > Introduce the function bpf_lookup_attach_addr() to do the address lookup,
> > > which is able to solve this problem.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > > v2:
> > > - Lookup both vmlinux and modules symbols when mod is NULL, just like
> > >   kallsyms_lookup_name().
> > >
> > >   If the btf is not a modules, shouldn't we lookup on the vmlinux only?
> > >   I'm not sure if we should keep the same logic with
> > >   kallsyms_lookup_name().
> > >
> > > - Return the kernel symbol that don't have ftrace location if the symbols
> > >   with ftrace location are not available
> > > ---
> > >  kernel/bpf/verifier.c | 77 ++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 72 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 53007182b46b..4bacd0abf207 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -23476,6 +23476,73 @@ static int check_non_sleepable_error_inject(u32 btf_id)
> > >       return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
> > >  }
> > >
> > > +struct symbol_lookup_ctx {
> > > +     const char *name;
> > > +     unsigned long addr;
> > > +     bool ftrace_addr;
> > > +};
> > > +
> > > +static int symbol_callback(void *data, unsigned long addr)
> > > +{
> > > +     struct symbol_lookup_ctx *ctx = data;
> > > +
> > > +     ctx->addr = addr;
> > > +     if (!ftrace_location(addr))
> > > +             return 0;
> > > +
> > > +     if (ctx->ftrace_addr)
> > > +             return -EADDRNOTAVAIL;
> > > +     ctx->ftrace_addr = true;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int symbol_mod_callback(void *data, const char *name, unsigned long addr)
> > > +{
> > > +     if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) != 0)
> > > +             return 0;
> > > +
> > > +     return symbol_callback(data, addr);
> > > +}
> > > +
> > > +/**
> > > + * bpf_lookup_attach_addr: Lookup address for a symbol
> > > + *
> > > + * @mod: kernel module to lookup the symbol, NULL means to lookup both vmlinux
> > > + * and modules symbols
> > > + * @sym: the symbol to resolve
> > > + * @addr: pointer to store the result
> > > + *
> > > + * Lookup the address of the symbol @sym. If multiple symbols with the name
> > > + * @sym exist, the one that has ftrace location is preferred. If more
> > > + * than 1 has ftrace location, -EADDRNOTAVAIL will be returned.
> > > + *
> > > + * Returns: 0 on success, -errno otherwise.
> > > + */
> > > +static int bpf_lookup_attach_addr(const struct module *mod, const char *sym,
> > > +                               unsigned long *addr)
> > > +{
> > > +     struct symbol_lookup_ctx ctx = { .addr = 0, .name = sym };
> > > +     const char *mod_name = NULL;
> > > +     int err = 0;
> > > +
> > > +#ifdef CONFIG_MODULES
> > > +     mod_name = mod ? mod->name : NULL;
> > > +#endif
> > > +     if (!mod_name)
> > > +             err = kallsyms_on_each_match_symbol(symbol_callback, sym, &ctx);
> > > +
> > > +     if (!err && !ctx.addr)
> > > +             err = module_kallsyms_on_each_symbol(mod_name, symbol_mod_callback,
> > > +                                                  &ctx);
> > > +
> > > +     if (!ctx.addr)
> > > +             err = -ENOENT;
> > > +     *addr = err ? 0 : ctx.addr;
> > > +
> > > +     return err;
> > > +}
> > > +
> > >  int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >                           const struct bpf_prog *prog,
> > >                           const struct bpf_prog *tgt_prog,
> > > @@ -23729,18 +23796,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >                       if (btf_is_module(btf)) {
> > >                               mod = btf_try_get_module(btf);
> > >                               if (mod)
> > > -                                     addr = find_kallsyms_symbol_value(mod, tname);
> > > +                                     ret = bpf_lookup_attach_addr(mod, tname, &addr);
> > >                               else
> > > -                                     addr = 0;
> > > +                                     ret = -ENOENT;
> > >                       } else {
> > > -                             addr = kallsyms_lookup_name(tname);
> > > +                             ret = bpf_lookup_attach_addr(NULL, tname, &addr);
> > >                       }
> > > -                     if (!addr) {
> > > +                     if (ret) {
> > >                               module_put(mod);
> > >                               bpf_log(log,
> > >                                       "The address of function %s cannot be found\n",
> > >                                       tname);
> > > -                             return -ENOENT;
> > > +                             return ret;
> > >                       }
> > >               }
> > >
> > > --
> > > 2.39.5
> > >

