Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72F5209D7
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 02:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiEJAOI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 20:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiEJAOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 20:14:07 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF225E796
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 17:10:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s14so10357032ild.6
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZZv1prxqD+RzT9m2Q3YVoPzA5+C2m7byF/JU5a3Y/4=;
        b=acxAC9wnr19+fpTf2bc2iX6f2M5aj34dm8zb6a2p/q4iPrtSw8XeT+Dd27Ofu0ffbQ
         Fg4+Dse0JD5ktPy5xbdZcvvW0IvsUl5mcliNJBP9CWM0LuqaxHnXTNHldwNrwnLMqxPa
         eFQsyK8zqCyAGteiNwC9z6lFK827TxV+6+VxnKkiFvR5l9qSAniZ7LPsr94F5DEMw/Lp
         7JakvQTrHSqORMZA25+y/NIJEdeu+VVxDcqZ9MUNwlXgDoxlEux4AzM5fV6eqDwIyvh3
         5TgY5z+EACx64d4DbCXQ5HDdjdNjp9ajnaNmDJZc111QC4Ch+bo3kHp9C1NB7RviiEsW
         +bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZZv1prxqD+RzT9m2Q3YVoPzA5+C2m7byF/JU5a3Y/4=;
        b=MSVhqlxgqBWXaEE4jK4yT9xs7SEhddFCJmgw23b2757zKNhgGcpi0R1ZTCGsj6cAx4
         cOv/H6U8DXluiYTNkOxlJUTVyDL5y+SdvGfOM28Kic6Ppza74xII81BnyqLeULqbyQYx
         UXoWrx1NYVbA9kk2l+gv91gRnyuTSLn9K39iKwCY/uggLFaRdkoBaRpaX92MzTOTqOe9
         5ReC9C4c5mYQ/a7RrOP1Iabw/TtQ93tg9mETIcLzDJX3WpiOCQc68ynretOkzP341obx
         g2lGmrhYHp03MuboPP6NTAjCqpQ5lyif7A4DJ81vbxBB5bdSPuKSs+pUHI9Jn92EiylF
         ALRA==
X-Gm-Message-State: AOAM532cg6aC2GP4Pxr/oE+HY+HLgT30LTol4Zy9/QbUDzyzeXYLUviQ
        dOSLe8hHCL0IRyOva1Cy+avXAapCuvpcAMdcLO4=
X-Google-Smtp-Source: ABdhPJxpceiZY5M3bVkLgOvz2jq27Scitd5Uc5405LRmhIAMt1kn2XiOby8EjYhhlcAU1d8It3+s8n2HyHN12jWANRs=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr7882140ilb.305.1652141411662; Mon, 09
 May 2022 17:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop> <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
 <8735jjw4rp.fsf@brennan.io> <YjDT498PfzFT+kT4@kernel.org> <878rt9hogh.fsf@brennan.io>
 <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com>
 <87r15iv0yd.fsf@stepbren-lnx.us.oracle.com> <CAADnVQ+YuxB8gZGjx+RP=04z4SgYEmPjEjDa_=Q6HmUecxK8QQ@mail.gmail.com>
 <YnE+k33iUtLH7Lks@kernel.org> <87zgjy8qzi.fsf@brennan.io> <alpine.LRH.2.23.451.2205032254390.10133@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2205032254390.10133@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 17:10:00 -0700
Message-ID: <CAEf4BzZmJKqXaJMBxhKqFNXzjO=eN5gk2xQVnmQVdK2xd3HQ=g@mail.gmail.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Stephen Brennan <stephen@brennan.io>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf <bpf@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 3, 2022 at 3:32 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Tue, 3 May 2022, Stephen Brennan wrote:
>
> > >> Ideally we structure BTFs as a multi level tree.  Where BTF with
> > >> global vars and other non essential BTF info can be added to vmlinux
> > >> BTF at run-time. BTF of kernel mods can add on top and mods can have
> > >> split BTF too.
> >
> > I see what you mean. It does sound a bit frustrating to have an
> > additional BTF module to augment every external module, which would be
> > the third level of that tree.
> >
> > We'll need to allocate more module structs and pages within the kernel
> > for that data, I wonder whether it would be cheaper for the
> > "non-essential" module BTF to just reside in the same BTF section of
> > that module.
> >
> > I suppose I can run my modified pahole on some sample modules and see
> > the BTF size difference, rather than just speculating, I'll do that in a
> > follow-up here.
> >
> > > Yeah, reuses existing mechanizm, doesn't increase the kernel BTF
> > > footprint by default, allows for debuggers, profilers, tracers, etc to
> > > ask for extra info in the form of just loading btf_global_variables.ko.
> >
> > I agree, this is a quite elegant solution. Though it'll require a fair
> > bit of work to achieve, I do think it's important to keep the footprint
> > down. One thing I'd like to see in this world is a way to instruct the
> > kernel that "I always want the non-essential BTF loaded", maybe via
> > cmdline or sysctl. This way, the module loader would know to search for
> > "$MODNAME-btf" for each module which doesn't end with "-btf".
> >
>
> Hmm, could we just have a tristate CONFIG_DEBUG_INFO_BTF_EXTRA?
> If set to y, the extra vars are builtin to vmlinux BTF and
> modules, and if set to m, they reside in /sys/kernel/btf/vmlinux-btf-extra
> courtesy of the vmlinux-btf-extra.ko module (or whatever naming
> scheme makes sense). Looks like pahole already has an option to
> store encoded BTF elsewhere:
>
> --btf_encode_detached=FILENAME
>
> ...so maybe all we need is something like --btf_gen_var_only for
> the case where we build the btf-extra module
>
> pahole -J --btf_base vmlinux  --btf_gen_var_only
> --btf_encode_detached=vmlinux_btf_extra
>
> ?
>

So BTF dedup would take care of keeping only extra DATASEC in such
module while reusing all the types from vmlinux BTF, as long as the
module itself has all the vmlinux BTF types plus those variables. It's
just a question of having ability to enable/disable global variables
generation. Which honestly is not a bad idea in general to have
overall more or less granular control over which subsets of BTF pahole
should emit.

> That's still only 2-way split BTF (base vmlinux BTF
> plus vmlinux variables); we'd only need the
> three-way split for the case where modules use the
> -extra approach too, and I'd wonder about the viability
> of having an -extra BTF module for each module, especially
> if space-saving is the goal.
>

Yeah, it feels like having that for modules is taking this to another
level of complexity, while adding this for vmlinux only seems pretty
doable with minimal changes (we don't need any extra BTF functionality
as we will just leave current start-based topology with vmlinux BTF in
the center; it's only Kbuild/Makefile modifications). I also wonder if
it will allow saving much for modules, they are probably not having
that many global variables anyways and it's acceptable to have them in
module's BTF. We can also separately control VMLINUX_BTF_EXTRAS as
y/n/m and MODULE_BTF_EXTRAS as y/n (that is, none or built into the
module itself), for starters at least.

> Alan
