Return-Path: <bpf+bounces-76698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9BFCC15E2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 08:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33E97301F3D2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF9E33554F;
	Tue, 16 Dec 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYcmp/QI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465B29A31C
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871438; cv=none; b=L2PFomYN+qiVVbvRmIAMraxsslOjXqgoFPhkZQsomezkd/oNuqM35QxPewYGQynPuKajie4Y/7alodUZMo2fX9kIqwp8kx2KQp505J6fZLtexo91/JIKA9aDkyCHkLwoIugIPoQqRKeEUQHXC1/ncWWMnZxzGNSHn+xiAA/K/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871438; c=relaxed/simple;
	bh=N1eOdsZCPtGGJFhSjQRnYdCQveWQTc9yUeGEV5JChdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIirSstsiLXvO1sbI7LSHlClfD9gdIF9p1vx+myuJrcDy4iTvb6eRhTAcxc8c7S+HM9F4p9+mBxuumWgLiQNzr6yz+16TPU2TAXOBRohMI+QNV/3mtPwCUI7sLwhvZts4veFidPSjTn3/2PBLtqeMw0qlRe+UI0LMPhCSw4NQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYcmp/QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0F2C19423
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871437;
	bh=N1eOdsZCPtGGJFhSjQRnYdCQveWQTc9yUeGEV5JChdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WYcmp/QIOw/5Twv5cUvTWCcTRYS3+cOKoXZBI04Emu4HXhRYk7NnKYTStTtuqWBPd
	 ChdtR0kglEgXnd5Fc/8gfle5y2sc8AcY51nY5PAIykOaa/thlByo6LxpZt0z/lx4fl
	 uwYc7+qscIQZRslou1e3y8QyDRBDPhG3L+iaMDIdu2uqzd4jkuK7Cse/J+7CKaX2Nc
	 XFtS5d4H69kPIS84NZeG2Ywy/9TPC08on7A3C/2tngxvyekeGJh0eqyeGDF8bBbjV6
	 bcwQVuwGJguyT05SdQcjGe/Xw15LHx5fA+UKXai48FwnBHDBHgT/WJ6Hl9R+rzswPO
	 D6vmrjWe3e4Sg==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a3d2f3299so18389836d6.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 23:50:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUL5WWLJBIkDxdhhc36VvFoXO/C0m8umB0CoPMawvZV4XOMmJSUdsMQvTSVno+5W9Ie7OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRwSTTjbSp7ZFVQ9PrURHFOXIFpNzPzLr5HIPW7X4aSEK3hh2
	g3IgpfxWSsAuk/2tdAmYX8a2o84/NmiWwAOxHLN6gns5dYSs/ax+pjPP5nn4pbv+Hd9L3prUGfP
	G/Vkcy/xOvn3Gm7vaPps2tDIMajSIEyQ=
X-Google-Smtp-Source: AGHT+IFGn8+befq4gjmUqAVNQZ1EMjmvNo7OQz6oVUmfDoTLU02D9kMpMdLpkW4Kkdg7SgfLCYcA85gPjCiUHkxnoD0=
X-Received: by 2002:a05:622a:1804:b0:4ee:278c:bde7 with SMTP id
 d75a77b69052e-4f1d04bfa00mr185781411cf.23.1765871436774; Mon, 15 Dec 2025
 23:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
 <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com> <CAADnVQKHEOusNnirYLuMjeKnJyJmCawEeOXsTf2JYi4RUTo5Tw@mail.gmail.com>
In-Reply-To: <CAADnVQKHEOusNnirYLuMjeKnJyJmCawEeOXsTf2JYi4RUTo5Tw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Dec 2025 16:50:24 +0900
X-Gmail-Original-Message-ID: <CAPhsuW5WohBuOKbHs-GoT3vsaj0RqhY=MD8=+NKqGbPizu1ihw@mail.gmail.com>
X-Gm-Features: AQt7F2pFSZQchLCqvTFcg5Dj2U-_qHkBeygodz9gpQQC5BYyBZrFcIXG1zntDKU
Message-ID: <CAPhsuW5WohBuOKbHs-GoT3vsaj0RqhY=MD8=+NKqGbPizu1ihw@mail.gmail.com>
Subject: Re: fms-extensions and bpf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 5:24=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 15, 2025 at 3:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Dec 3, 2025 at 8:30=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Hi All,
> > >
> > > The kernel is now built with -fms-extensions and it is
> > > using them in various places.
> > > To stop-the-bleed and let selftests/bpf pass
> > > I applied the short term fix:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?i=
d=3D835a50753579aa8368a08fca307e638723207768
> > >
> > > Long term I think we can try to teach bpftool
> > > to emit __diag_push("-fms-extensions"..)
> > > at the top of vmlinux.h.
> > > Not sure whether it's working though.
> >
> > Something like the following works for me. But I am not sure
> > whether it is the best solution.
>
> Great. Pls submit an official patch targeting bpf tree,
> since without the fix the vmlinux_6_19.h won't be usable in older setups.
>
> > Thanks,
> > Song
> >
> > diff --git i/tools/bpf/bpftool/btf.c w/tools/bpf/bpftool/btf.c
> > index 946612029dee..606886b79805 100644
> > --- i/tools/bpf/bpftool/btf.c
> > +++ w/tools/bpf/bpftool/btf.c
> > @@ -798,6 +798,9 @@ static int dump_btf_c(const struct btf *btf,
> >         printf("#define __bpf_fastcall\n");
> >         printf("#endif\n");
> >         printf("#endif\n\n");
> > +       printf("#pragma clang diagnostic push\n");
> > +       printf("#pragma clang diagnostic ignored \"-Wmissing-declaratio=
ns\"\n");
>
> what about pragma GCC ? gcc-bpf is gaining traction...
> will pragma clang or pragma GCC work for both?

Turns out "#pragma GCC diagnostic" works for both.

However, I think we cannot use this in the long term, because it
effectively removes the anonymous member from the enclosing
struct. For example, if I add

struct __test_ms_extensions {
       int ms_extensions_id;
};

struct task_struct {
        /* ... */
        struct __test_ms_extensions;
};

We cannot access ms_extensions_id from BPF program:

        task =3D bpf_get_current_task_btf();
        /* the following doesn't work */
        ms_extensions_id =3D task->ms_extensions_id;

I think there are two options moving forward:

1. Ask the users to add "-fms-extensions  -Wno-microsoft-anon-tag"
    to the makefile.
2. Teach bpftool to unfold the anonymous member struct/union. For
    example, the above code will be like the following in vmlinux.h:

        struct task_struct {
                /* ... */
                int ms_extensions_id;
        };

Thanks,
Song

