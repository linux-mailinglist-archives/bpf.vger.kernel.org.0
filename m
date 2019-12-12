Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95111D67C
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 19:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfLLS6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 13:58:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45898 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLLS6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 13:58:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1259995pfg.12
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gYPGE035C6lEVvvqqJzcqgZi6QzjwvA5z8YoBsh/CjI=;
        b=m0k9X5VOLcp9Br4ajlBHHaK+6pNEd9o63DVIO/RsLqmTirnxWr3TenqJwCAftb3OjI
         beF/jxctjFLaYQGGrw72ZwgXtvBKRIi2N8ggMI3esTBOJ/E1y3ZUUeBPUQXa423IZtp3
         oo20/lS83lIWMxo04iWXHSs52RpyT2ny72bAPDy23LzgdRknvBgIJ4NuBXXzEasg69mw
         hZCmlFfmBz02D1dJg89Md6fNhkVvrke57IznDIEhTiOG2De6Ng7A3nHqKF+Mk6aqdSjy
         er/fsvkubgws72c6LwA8wmeqSPMsub1tjJn2eNmiatyVbXSSPfIVoh/TPDtAozoS/HnB
         2wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gYPGE035C6lEVvvqqJzcqgZi6QzjwvA5z8YoBsh/CjI=;
        b=SBC7dEjta5ELzEUP6a5v2A/r6s1klHt+kEc6s1IS4OGK4mnp7E02Nh8xZgfRDOI/cI
         5fTfVl2RUmhJUb6n0C2JSJe441cACopNXCiEuLWG0FEar3wcApTAQCVE/e2j1ri6UwKo
         DZALozIsUkOOp9lDb9L/BsaqtXbtMTpuseDvlQW/6FxlmUKIkc5Wt/D1ijHyvxiubHAH
         za5uw+bGlfNi3rx4Yn2KmXbg1OJv3lflVLgVApfab4VlpqZ7/9NzaaDklIV8x1wBhVwe
         et3X93C60YnakiqCIZnJcjyIAyBorw/NHeyhJ4KYXUnnmdYC+fKbBKLJaARWm91U/FaI
         hs4g==
X-Gm-Message-State: APjAAAWHlSdvyVYM/TpA/Ug0k/nBLsJcJ08vsNqFuFk39yF78s2aaWmS
        rDrG66TOeFRBkAkw1rxpaYEeLA==
X-Google-Smtp-Source: APXvYqyfzzElgMjecVdtdThkcEg+f5Qrm1GjDF1/00FLifxW4Kv2estx0j0GVo0lHjd595kCCz+43g==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr11200168pfp.97.1576177112270;
        Thu, 12 Dec 2019 10:58:32 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id h64sm6894647pje.2.2019.12.12.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:58:31 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:58:31 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 11/15] bpftool: add skeleton codegen command
Message-ID: <20191212185831.GN3105713@mini-arch>
References: <CAEf4Bzb+3b-ypP8YJVA=ogQgp1KXx2xPConOswA0EiGXsmfJow@mail.gmail.com>
 <20191211191518.GD3105713@mini-arch>
 <CAEf4BzYofFFjSAO3O-G37qyeVHE6FACex=yermt8bF8mXksh8g@mail.gmail.com>
 <20191211200924.GE3105713@mini-arch>
 <CAEf4BzaE0Q7LnPOa90p1RX9qSbOA_8hkT=6=7peP9C88ErRumQ@mail.gmail.com>
 <20191212025735.GK3105713@mini-arch>
 <CAEf4BzY2KHK4h5e40QgGt4GzJ6c+rm-vtbyEdM41vUSqcs=txA@mail.gmail.com>
 <20191212162953.GM3105713@mini-arch>
 <CAEf4BzYJHvuFbBM-xvCCsEa+Pg-bG1tprGMbCDtsbGHdv7KspA@mail.gmail.com>
 <20191212104334.222552a1@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212104334.222552a1@cakuba.netronome.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/12, Jakub Kicinski wrote:
> On Thu, 12 Dec 2019 08:53:22 -0800, Andrii Nakryiko wrote:
> > > > > Btw, how hard it would be to do this generation with a new python
> > > > > script instead of bpftool? Something along the lines of
> > > > > scripts/bpf_helpers_doc.py that parses BTF and spits out this C header
> > > > > (shouldn't be that hard to write custom BTF parser in python, right)?
> > > > >  
> > > >
> > > > Not impossible, but harder than I'd care to deal with. I certainly
> > > > don't want to re-implement a good chunk of ELF and BTF parsing (maps,
> > > > progs, in addition to datasec stuff). But "it's hard to use bpftool in
> > > > our build system" doesn't seem like good enough reason to do all that.  
> > > You can replace "our build system" with some other project you care about,
> > > like systemd. They'd have the same problem with vendoring in recent enough
> > > bpftool or waiting for every distro to do it. And all this work is
> > > because you think that doing:
> > >
> > >         my_obj->rodata->my_var = 123;
> > >
> > > Is easier / more type safe than doing:
> > >         int *my_var = bpf_object__rodata_lookup(obj, "my_var");
> > >         *my_var = 123;  
> > 
> > Your arguments are confusing me. Did I say that we shouldn't add this
> > type of "dynamic" interface to variables? Or did I say that every
> > single BPF application has to adopt skeleton and bpftool? I made no
> > such claims and it seems like discussion is just based around where I
> > have to apply my time and efforts... You think it's not useful - don't
> > integrate bpftool into your build system, simple as that. Skeleton is
> > used for selftests, but it's up to maintainers to decide whether to
> > keep this, similar to all the BTF decisions.
> 
> Since we have two people suggesting this functionality to be a separate
> tool could you please reconsider my arguments from two days ago?
> 
>   There absolutely nothing this tool needs from [bpftool], no
>   JSON needed, no bpffs etc. It can be a separate tool like
>   libbpf-skel-gen or libbpf-c-skel or something, distributed with libbpf.
>   That way you can actually soften the backward compat. In case people
>   become dependent on it they can carry that little tool on their own.

[..]
> I'd honestly leave the distro packaging problem for people who actually
> work on that to complain about.
I'm representing a 'Google distro' :-D
