Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC3331A15
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 23:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCHWRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 17:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCHWQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 17:16:59 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5AC06174A;
        Mon,  8 Mar 2021 14:16:58 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d9so11856968ybq.1;
        Mon, 08 Mar 2021 14:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCh1I6AC1DmtJTGL+YMoytBx05+lD8Vumw6Zy/Ybg0Q=;
        b=KTNf2pwdJI2vrL6R7kl7l9XYHzlfeZRL5kv+ib6dAKX/im17iaRPmN70EltHNTczmS
         JF3svyI9GJuXN5jsu+d6aFa6qXtqcFcNTYk8Oj3MT//OwmFlsMIRbSFf2VYkgFlV9ESH
         GNPrmx+v3DVrCkdrjJ+0Hj/rAT3MowGoLHaT/pKfuKbOqF6bO0KJCl22TSmLd7ch+UYG
         2ytWdUCtotelL0G1G7WfX8SQ/2EY6KS28gk6BLdBgB01Zj5AUW6c61XjLwFJRJS4qG+N
         zrpeQBFK+t4hLdKEYep/6me0wdoSlBoW2WU4csyGwAmHT0i+fJYVt6xzEBE3hliyCuka
         +fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCh1I6AC1DmtJTGL+YMoytBx05+lD8Vumw6Zy/Ybg0Q=;
        b=CJs50Xj1GVl7wRIIg7Ek5cG+2Jdg9eOVfivcKkddOfzjDut86pwBjYIcnko18Jc39E
         Tlg9e+uFPZB9ZXNo7H1GYRAQj/0PY9gZsF4tNfeXxPSO9WteR//PCEPHxgvpjEoZ9zBk
         utAVKyzaIJJgdEBcy/h0Pr9PjpNmmXPXukek0ii2LOSfbbQjFNz59mQYAaRo86LYPJ1G
         LPY7CjHAc6JQ/R+FszIBjgBibMemTFO5DeY2I0HDAzX5yx0/1rNYJvLADBJCOsg4eFCA
         XEJI6Dxx+Bz+MYlg5fVA2I8Eo4F59uNsS2/gO+sTu4RGhsN34CAnFjLklvaCkIRZrOVs
         +nVA==
X-Gm-Message-State: AOAM531NcgsxO/0L7YpZyIKpzSprvhLJnNnOiW6uGhzMkHcEGu2MznsJ
        33fQC6TeuFJpGw+uDvWFb/PTrt2wFRa8BL96Wziy2YjJKqY=
X-Google-Smtp-Source: ABdhPJxZskMi7xp+KMV0+3PfsKeW+YCvli0A2xJ9VK2KdWw0AgB1u1Iv0GDmerXdStHxe9jWkwLCyeOQk2YEtB3ZMYI=
X-Received: by 2002:a25:c6cb:: with SMTP id k194mr35570966ybf.27.1615241818127;
 Mon, 08 Mar 2021 14:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20210306022203.152930-1-iii@linux.ibm.com> <CAEf4BzYvawU4jTKwoUagY0Bn0SYNwcSohb-ZAPq_rLvF5qLamg@mail.gmail.com>
 <YETSLwfibXxelBIN@kernel.org> <YETYtWwSFVMDAnCA@kernel.org>
 <YETaG9CZbrzMNmbh@kernel.org> <YETejOpEPkaP3UU1@kernel.org>
 <5042b6b4d47ac2a8bb919909d43b1fe826fd9441.camel@linux.ibm.com> <YEYgVmo0ryuM3SUY@kernel.org>
In-Reply-To: <YEYgVmo0ryuM3SUY@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Mar 2021 14:16:47 -0800
Message-ID: <CAEf4BzbHyg6xndiw=gNhW79ofWACzb1mtDt0ghEhkRMpOd70GQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Add support for the floating-point types
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 8, 2021 at 5:02 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Mar 08, 2021 at 04:02:58AM +0100, Ilya Leoshkevich escreveu:
> > On Sun, 2021-03-07 at 11:09 -0300, Arnaldo Carvalho de Melo wrote:
> > > Adding Jiri to the CC list.
> > > Em Sun, Mar 07, 2021 at 10:50:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Sun, Mar 07, 2021 at 10:44:21AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Now will build a kernel with this new version, reboot, then push
> > > > publicly.
>
> > > So now trying to build v5.12-rc2 with pahole supporting BTF_KIND_FLOAT:
>
> > >   AS      .tmp_vmlinux.kallsyms2.S
> > >   LD      vmlinux
> > >   BTFIDS  vmlinux
> > > FAILED: load BTF from vmlinux: Invalid argument
> > > make[1]: *** [/home/acme/git/linux/Makefile:1197: vmlinux] Error 255
> > > make[1]: Leaving directory '/home/acme/git/build/v5.12.0-rc2'
> > > make: *** [Makefile:215: __sub-make] Error 2
> > > [acme@five linux]$
>
> > > [acme@five linux]$ egrep BTF\|DWARF  ../build/v5.12.0-rc2/.config
> > > CONFIG_VIDEO_SONY_BTF_MPX=m
> > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > > CONFIG_DEBUG_INFO_BTF=y
> > > CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> > > CONFIG_DEBUG_INFO_BTF_MODULES=y
>
> > > Ideas?
>
> > So v5.12-rc2 does not have this series yet:
>
> > https://lore.kernel.org/bpf/20210226202256.116518-1-iii@linux.ibm.com/
>
> > pahole generates a BTF_KIND_FLOAT, but libbpf from v5.12-rc2 doesn't
> > know how to handle it and resolve_btfids fails.
>
> > I guess this is the first time a new BTF kind is added? I checked the
> > history, and kernel v5.2, which introduced DEBUG_INFO_BTF, already had
> > BTF_KIND_DATASEC.
>
> > So should I add a command-line option to pahole, which would tell it
> > the desired libbpf compatibility level?
>
> Yes, that would be best, some sort of capability querying and then a
> decision about using the new feature.

pahole could be used to add .BTF post-factum to vmlinux image of a
very old kernel, even the one that doesn't support BTF at all. So
whatever detection system is going to be added, we should make it easy
to turn it off.

>
> - Arnaldo
