Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0C49D333
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 21:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiAZUMj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 15:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiAZUMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 15:12:39 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56463C06161C
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 12:12:39 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q204so990350iod.8
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgbONfI5ser5lzFgGEQWqz6/pbdUQJNhcTgmk5rsjpw=;
        b=P1TLx5hxDpeWsz6zhsyS4nfCpVfs0mo11M/SUF2+DIFiH90W8ni/0/Py0plk1pLPol
         VZCnA9s9msAleBkL5MM6jce7/+czWoDaLYQ5ALdflq/5PYm+OmKImDAVEcORop53sli3
         7E1njSUjOx1qgjAztGiJ4Z7MGMxlvlmmmWoP6dSDYhw2l8WdKCyJFukS8aSvwRSxbv2U
         AqinpkATWzehc5K457PaEbJeRN/+gVnCcZTML9dpWaPl6PPgAqmeQfvWG7xgdGVRHyyH
         ecsSQjLbKVCJmYj/sKI3k/94X7WOiItulzgDx+YGe33vJ1xTI8jCQeVwcnOaMl3gBJtx
         VBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgbONfI5ser5lzFgGEQWqz6/pbdUQJNhcTgmk5rsjpw=;
        b=4EFn2b9CqeaxOLoBl53Fy5NT+hPOoQyzk2ovoMovVkG1zGlv4zRCyxloFBQeQTQgFN
         5ENsco5VQYgxhIh9U8x38FGWzP5cJN+hSiuftGFpbCVm7TPxhnYxT1KnKH74LgfREk4p
         z1ZZfwPCdmrA7sY5xa6GwkYyZbypkunJM5QF/xuUicROei8z/sHNQc8iE3jNbxH4j+wK
         +bGBto5zUzwcSM4CckLirTYeTvPJKGQoJvrZGMbjqcutrRBC3UUsL9kk+ak7QyXWetQi
         HpZ4j0VkQ0cxaL/OxLTvdA3E+7a897wD1c25GyuF67gyuR+QRd71aE53N5h/d7rSN2NI
         WkTA==
X-Gm-Message-State: AOAM530/31Nw1YPpqft3Rgx5pW3bu9wUZ9ASkgSw18ZSKLiZI1qP9RUr
        qM0SYPorJGLyuhP+r8PFSZ+3xoqGJ7XSQSzg/tM=
X-Google-Smtp-Source: ABdhPJwPndFmg8TDdHQUPqiko0RlwD/d/rQtZafzGwUonsZZHReql8KZ1I6rzTCkaKmm8q6VL6bFR4lqs10zat/ePYU=
X-Received: by 2002:a5e:a806:: with SMTP id c6mr164043ioa.112.1643227958717;
 Wed, 26 Jan 2022 12:12:38 -0800 (PST)
MIME-Version: 1.0
References: <Yd82J8vxSAR9tvQt@lore-desk> <8735lshapk.fsf@toke.dk>
 <47a3863b-080c-3ac2-ff2d-466b74d82c1c@redhat.com> <Yd/9SPHAPH3CpSnN@lore-desk>
 <CAADnVQJaB8mmnD1Z4jxva0CqA2D0aQDmXggMEQPX2MRLZvoLzA@mail.gmail.com>
 <YeC8sOAeZjpc4j8+@lore-desk> <CAADnVQ+=0k1YBbkMmSKSBtkmiG8VCYZ5oKGjPPr4s9c53QF-mQ@mail.gmail.com>
 <e86ccea8-af77-83bf-e90e-dce88b26f07c@redhat.com> <CAC1LvL3M9OaSanES0uzp=vvgK23qPGRPpcAR6Z_Vqcvma3K5Qg@mail.gmail.com>
 <CAEf4BzZAMtmqW4sMfhEX8WtAzmQoVQ=WupqeqXa=5KbYXAbQNA@mail.gmail.com> <YfFyv8l6xDNM70eZ@lore-desk>
In-Reply-To: <YfFyv8l6xDNM70eZ@lore-desk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Jan 2022 12:12:27 -0800
Message-ID: <CAEf4BzYP3W-FuoF_gO09RGbOku--f+YRVdiy5dCOBxZO=+4RKQ@mail.gmail.com>
Subject: Re: [PATCH v21 bpf-next 18/23] libbpf: Add SEC name for xdp_mb programs
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Zvi Effron <zeffron@riotgames.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        john fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 8:11 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > On Fri, Jan 14, 2022 at 10:55 AM Zvi Effron <zeffron@riotgames.com> wrote:
> > >
> > > On Fri, Jan 14, 2022 at 8:50 AM Jesper Dangaard Brouer
> > > <jbrouer@redhat.com> wrote:
> > > >
> > > >
> > > >
> > > > On 14/01/2022 03.09, Alexei Starovoitov wrote:
> > > > > On Thu, Jan 13, 2022 at 3:58 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > > >>>
> > > > >>> Btw "xdp_cpumap" should be cleaned up.
> > > > >>> xdp_cpumap is an attach type. It's not prog type.
> > > > >>> Probably it should be "xdp/cpumap" to align with "cgroup/bind[46]" ?
> > > > >>
> > > > >> so for xdp "mb" or xdp "frags" it will be xdp/cpumap.mb (xdp/devmap.mb) or
> > > > >> xdp/cpumap.frags (xdp/devmap.frags), right?
> > > > >
> > > > > xdp.frags/cpumap
> > > > > xdp.frags/devmap
> > > > >
> > > > > The current de-facto standard for SEC("") in libbpf:
> > > > > prog_type.prog_flags/attach_place
> > > >
> > > > Ups, did we make a mistake with SEC("xdp_devmap/")
> > > >
> > > > and can we correct without breaking existing programs?
> > > >
> > >
> > > We can (at the very least) add the correct sections, even if we leave the
> > > current incorrect ones as well. Ideally we'd mark the incorrect ones deprecated
> > > and either remove them before libbpf 1.0 or as part of 2.0?
> > >
> >
> > Correct, those would need to be new aliases. We can also deprecate old
> > ones, if we have consensus on that. We can teach libbpf to emit
> > warnings (through logs, of course) for such uses of to-be-removed
> > sections aliases. We still have probably a few months before the final
> > 1.0 release, should hopefully be plenty of time to people to adapt.
>
> If we all agree on old cpumap/devmap sec deprecation and replace them with
> xdp/cpumap and xdp/devmap, would it be ok something like the patch below or
> would be necessary something different?
>
> Regards,
> Lorenzo
>
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6575,6 +6575,12 @@ static int libbpf_preload_prog(struct bpf_program *prog,
>         if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>                 opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>
> +       if (strstr(prog->sec_name, "xdp_devmap") ||
> +           strstr(prog->sec_name, "xdp_cpumap")) {
> +               pr_warn("sec_name '%s' is deprecated, use xdp/devmap or xdp_cpumap instead\n",
> +                       prog->sec_name);
> +       }

This time it's actually a clear use case for a flag, SEC_DEPRECATED.
:) We can look through other SEC_DEF()s and see if some of them have
to go.

> +
>         if ((prog->type == BPF_PROG_TYPE_TRACING ||
>              prog->type == BPF_PROG_TYPE_LSM ||
>              prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
> @@ -8618,8 +8624,10 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("iter.s/",              TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
>         SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),
>         SEC_DEF("xdp.frags/devmap",     XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
> +       SEC_DEF("xdp/devmap",           XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
>         SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
>         SEC_DEF("xdp.frags/cpumap",     XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
> +       SEC_DEF("xdp/cpumap",           XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
>         SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
>         SEC_DEF("xdp.frags",            XDP, BPF_XDP, SEC_XDP_FRAGS),
>         SEC_DEF("xdp",                  XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
>
>
> >
> > > --Zvi
> > >
> > > > > "attach_place" is either function_name for fentry/, tp/, lsm/, etc.
> > > > > or attach_type/hook/target for cgroup/bind4, cgroup_skb/egress.
> > > > >
> > > > > lsm.s/socket_bind -> prog_type = LSM, flags = SLEEPABLE
> > > > > lsm/socket_bind -> prog_type = LSM, non sleepable.
> > > > >
> > > >
