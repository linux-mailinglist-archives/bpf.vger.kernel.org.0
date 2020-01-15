Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE213B693
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 01:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgAOAo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 19:44:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46853 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAOAo4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 19:44:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so5970231pll.13
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 16:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WHHqoF7G3eQ3Ny8rGbXDHHGKElOG1NQW3RTfnqPrzLc=;
        b=JlkvcFWpDVlhlE2SFi7FGmK8hXCSuEUj8L8ujJS1QtSPQO6zmoCN/cNzWeQWCRybsc
         Sb9EXA+huWiwW7Ba6h4LtD7DnDao5Kp+HdCrEXwTlKJJ7GLBeMmZysxGo23pLiAhuDVr
         xVOnBA9U4LfmL0jqGuK/G3WD90MdDoYcf7lMMf84MQlKpDqx6RcDj8j8vnQSnDgHU7nr
         mz5wWr538cniuF0k7OMY2ZmRzjXCarMl6lAdLckP/94ls5fF/EO49GAr619FEPvawxuc
         WCiknQ+qK8io2eix2nsanTky9MLR64PAkU06VJUxM00XmQ7Zdg4r0kMOhhWvr1Vn62Do
         sDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WHHqoF7G3eQ3Ny8rGbXDHHGKElOG1NQW3RTfnqPrzLc=;
        b=DTCl+aR0dvVVzIehzeArFN7Knpa/pnhECCmlwe3Fqw+taj9mV5+BN9gSi6FAWmPD31
         o1SEmS7WmaEiM3NHk8GnFeVaEGrxlSuicJqb4em8DgAphJYNk6vGle3LKMPAXULZsv9y
         Yx1oJ006VE12w3bFQKbm30lGXpKii7pZakNMjl3SXCqJjW8hA8Cg/L6/TQbbBB3KUSq+
         7tPykekbpzm73G1kbuERugdzbR4YvqUB+qDPobmM06/zGqXiGD8hOSazZsNByuPjmeTb
         DJLYhy4v86ftRb88bLlKb3nEeOusf5M7uC92LciSF93iCylmJNawtw6PNpUVuUKQ8FIy
         0Dsg==
X-Gm-Message-State: APjAAAVhgSl+ldFBgUEu5/T1gc6sdL7yUbtKSNG7NuRsBoTpQhEWp2KI
        3e48U+bCKmwCqw9QXShC40GcVA==
X-Google-Smtp-Source: APXvYqw9r5GtpXojf4Po1mcsQV1ZM0hjaBKyzivg6od1ozMiO64yYmX0BIWgv05ndLpomtSDsybgzA==
X-Received: by 2002:a17:90a:cc16:: with SMTP id b22mr32015752pju.65.1579049095519;
        Tue, 14 Jan 2020 16:44:55 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id y203sm20186585pfb.65.2020.01.14.16.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:44:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 16:44:54 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Introduce function-by-function
 verification
Message-ID: <20200115004454.GB2308546@mini-arch>
References: <20200108072538.3359838-1-ast@kernel.org>
 <20200108072538.3359838-4-ast@kernel.org>
 <20200114233904.GA2308546@mini-arch>
 <CAEf4BzZUNKAT87UUQ9DKe8TvGG54PPDV-jPuK-J+Jx46Tm1oUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZUNKAT87UUQ9DKe8TvGG54PPDV-jPuK-J+Jx46Tm1oUA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/14, Andrii Nakryiko wrote:
> On Tue, Jan 14, 2020 at 3:39 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 01/07, Alexei Starovoitov wrote:
> > > New llvm and old llvm with libbpf help produce BTF that distinguish global and
> > > static functions. Unlike arguments of static function the arguments of global
> > > functions cannot be removed or optimized away by llvm. The compiler has to use
> > > exactly the arguments specified in a function prototype. The argument type
> > > information allows the verifier validate each global function independently.
> > > For now only supported argument types are pointer to context and scalars. In
> > > the future pointers to structures, sizes, pointer to packet data can be
> > > supported as well. Consider the following example:
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -2621,8 +2621,8 @@ static s32 btf_func_check_meta(struct btf_verifier_env *env,
> > >               return -EINVAL;
> > >       }
> > >
> > > -     if (btf_type_vlen(t)) {
> > > -             btf_verifier_log_type(env, t, "vlen != 0");
> > > +     if (btf_type_vlen(t) > BTF_FUNC_EXTERN) {
> > > +             btf_verifier_log_type(env, t, "invalid func linkage");
> > >               return -EINVAL;
> > Sorry for bringing it up after the review:
> >
> > This effectively teaches kernel about BTF_KIND_FUNC scope argument,
> > right? Which means, if I take clang from the tip
> > (https://github.com/llvm/llvm-project/commit/fbb64aa69835c8e3e9efe0afc8a73058b5a0fb3c#diff-f191c05d1eb0a6ca0e89d7e7938d73d4)
> > and take 5.4 kernel, it will reject BTF because it now has a
> > BTF_KIND_FUNC with global scope (any 'main' function is global and has
> > non-zero vlen).
> >
> > What's the general guidance on the situation where clang starts
> > spitting out some BTF and released kernels reject it? Is there some list of
> > flags I can pass to clang to not emit some of the BTF features?
> > Or am I missing something?
> 
> Isn't that the issue that 2d3eb67f64ec ("libbpf: Sanitize global
> functions") addresses by sanitizing those BTF_KIND_FUNC as static
> functions (with vlen=0)?
> 
> The general guidance is to have libbpf sanitize such BTF to make it
> compatible with old kernels.
Ah, that was the missing piece, thank you!
