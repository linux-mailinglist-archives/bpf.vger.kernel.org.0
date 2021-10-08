Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2BF4270AA
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 20:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJHSXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 14:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhJHSXw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 14:23:52 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19DC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 11:21:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id h2so22875797ybi.13
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JrxrUY4R+4M5AxficRU0nwkjbj53ZJ5h6qVPqEbiU1A=;
        b=gUKDFnr7eF5UdCgOvOVPQ/LrIra5gf19AZk0HwgG2Xpb9wTJrK/f2qC5SeatO93q2Y
         kJaUPYwct80pse8fOCkjqpRVSlxQ/5XIt0SFXCsjOfii1fcc2G45InXVgMzjwdolElF3
         BH5b1eMX9TQy75oAotcWUPfqXmlijmoB87Ytly0/CZz2hiWujveREYcx2Cb+1LnlE+ho
         iKOs7L857/MHelaQTl8bTrrqenNJTEhQPOjQDclazrChSONDhbXyeVA8ezDa30ttNOGu
         qUR9pKGgBCj+DomFtIjAFygtNRcMs8OIoIdXpVQg7oMe8Hao9ZCQmV8HPdUvV8PVlsfW
         KyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JrxrUY4R+4M5AxficRU0nwkjbj53ZJ5h6qVPqEbiU1A=;
        b=Ns9zIlVYfeyglC/T4g0PTbdshHMLFIQ1ucQn+Iz2VfVoi6MwjAAYevjP84NCBHeQsM
         DULuWWYsPgWNrue6iXEWyMXYuQcVjer90qslH/wsk57sXLkto+hieVaomZBUKrbd5svn
         Me8dKYwHVN4k93ZIy3st3aTrxhEgufDsB32rRGoGGNTzAZqKqG5w+QanGfeOqhXEfsLX
         KHoYEAnpciU1LIu3HBTcMuyGYSxq9omFLwFBkZDVB/6NC7olFIVB3LwWETL40qk7MAv/
         ZkO2QP1KMLLIlal0aS8cuv73HF3A+lbEjgTnPdmDPnKax7guJc70J1PWfMSpJAUbbXRG
         KsWw==
X-Gm-Message-State: AOAM531qKjvSlZj5x4F6dZdA1rkvYcvWs5xk6tgAA3wTaSf7T57uq1zn
        hty6q0qXMaHPPEVXd3t+85Cu0sxRmtwrIaPEJCo=
X-Google-Smtp-Source: ABdhPJwyxt14UMDzbfBTF3wmV9YlKc9Mk9em0a8F/pXRAHxxxQjBC2M+tBGUGEimwwwgtS0azvJSTFNfCmWZG/Ec5Wg=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr4641180ybj.433.1633717315655;
 Fri, 08 Oct 2021 11:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
 <87pmsfl8z0.fsf@toke.dk>
In-Reply-To: <87pmsfl8z0.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 11:21:44 -0700
Message-ID: <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 10:31 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> andrii.nakryiko@gmail.com writes:
>
> > From: Andrii Nakryiko <andrii@kernel.org>
> >
> > Map name that's assigned to internal maps (.rodata, .data, .bss, etc)
> > consist of a small prefix of bpf_object's name and ELF section name as
> > a suffix. This makes it hard for users to "guess" the name to use for
> > looking up by name with bpf_object__find_map_by_name() API.
> >
> > One proposal was to drop object name prefix from the map name and just
> > use ".rodata", ".data", etc, names. One downside called out was that
> > when multiple BPF applications are active on the host, it will be hard
> > to distinguish between multiple instances of .rodata and know which BPF
> > object (app) they belong to. Having few first characters, while quite
> > limiting, still can give a bit of a clue, in general.
> >
> > Another downside of such approach is that it is not backwards compatibl=
e
> > and, among direct use of bpf_object__find_map_by_name() API, will break
> > any BPF skeleton generated using bpftool that was compiled with older
> > libbpf version.
> >
> > Instead of causing all this pain, libbpf will still generate map name
> > using a combination of object name and ELF section name, but it will
> > allow looking such maps up by their natural names, which correspond to
> > their respective ELF section names. This means non-truncated ELF sectio=
n
> > names longer than 15 characters are going to be expected and supported.
> >
> > With such set up, we get the best of both worlds: leave small bits of
> > a clue about BPF application that instantiated such maps, as well as
> > making it easy for user apps to lookup such maps at runtime. In this
> > sense it closes corresponding libbpf 1.0 issue ([0]).
>
> I like this approach. Only possible problem I can see is that it might
> be confusing that a map can be looked up with one name, but that it
> disappears once it's loaded into the kernel (and the BPF object is
> closed).
>
> Hmm, couldn't we just extend the kernel to accept longer names? Kinda
> like with the netdev name aliases: support a secondary label that can be
> longer, and have bpftool display both?

Yes, this discrepancy can be confusing. I'd like all those internal
maps to be named after their corresponding ELF sections, tbh. We have
a mechanism now to make this transition (libbpf_set_strict_mode()),
but people have complained before that just seeing ".data" won't give
them enough information.

But if we are going to extend the kernel with longer map names, then
I'd rather stick to clean ".data.custom" naming from the very
beginning, and then switch all existing .data/.rodata/.bss/.kconfig
map naming to the same convention as well (guarded by opt-in flag in
libbpf_set_strict_mode() until libbpf 1.0). In the kernel, though,
instead of having two names (i.e., one is alias), I'd just allow to
provide one long name and then all existing UAPIs that have char[16]
everywhere would just be a potentially truncated prefix of such a
longer name. All the tooling can be updated to use long name when
available, of course. WDYT?

>
> -Toke
>
