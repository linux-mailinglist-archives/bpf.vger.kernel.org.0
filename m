Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEA830B2E7
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 23:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBAWpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 17:45:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhBAWpJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Feb 2021 17:45:09 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-0Vrm2Do7O66wT1R_krexIQ-1; Mon, 01 Feb 2021 17:43:39 -0500
X-MC-Unique: 0Vrm2Do7O66wT1R_krexIQ-1
Received: by mail-lj1-f199.google.com with SMTP id r23so10259537ljm.1
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 14:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqWi3VT4O1kkdP0WbRAaAMgjsUH9yk6C0OOgSZcyBoA=;
        b=jt6nqr06DRvkJMGk7Px6W31gGSjUrH+iWHRdHW5yNqpTHJJp/OUTqj2AJzIXQ0A9hy
         DnM+pI5IWfA2xkQm2rCz8xODqFNqkgLWfnoQnS7RMk2Fwp7m+YlU6iKVrlb1wTaLwZVr
         poglOZnh7hy6WXBLI3hL1ZR9FfoTgDDuxrDLsCzM+MtG0eYHLf/pOFdiGJ2VyVQJ0nO/
         WHXxf1dWWD34fix62xF7uYNYVoiGc2Gfs9EmZQAiTLF+zhFXh8lTsO6b+GBXh7NhC6v7
         5gLXRVtgvLQ4x/4QFys8XEVrQD4RRpF19Vwt2n7CzMT9fMv6PIC3THCVZwa6F21mUCPP
         +3Tg==
X-Gm-Message-State: AOAM531vYC/4yefNa1zgdtveHG1teFTtxA+Ttk4pKvLp4IrGE7qWXXU7
        MOdEPqYYiRJyVJtkhtOQhCemeDsJuT7JU7BiFOpCxC53DcrFpc3ESoRMW8xJUieT3bPr73yuHXs
        Bt/QiD0qULkfg6uA6kt0rWolcjny9
X-Received: by 2002:a2e:888d:: with SMTP id k13mr11459624lji.399.1612219417311;
        Mon, 01 Feb 2021 14:43:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqtZUSYYodgQNDIrBEP7PABUePCP/6Bkb7xDFPsWR9ZjqUjHyUsfwYGH2SBFs632Ivb0dw8LCmQzzFxRrUuE8=
X-Received: by 2002:a2e:888d:: with SMTP id k13mr11459616lji.399.1612219417125;
 Mon, 01 Feb 2021 14:43:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
 <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
 <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
 <YBXGChWt/E2UDgZc@krava> <YBci6Y8bNZd6KRdw@krava> <20210201122532.GE794568@kernel.org>
 <YBgVLqNxL++zVkdK@krava> <YBhjOaoV2NqW3jFI@krava>
In-Reply-To: <YBhjOaoV2NqW3jFI@krava>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Feb 2021 23:43:26 +0100
Message-ID: <CAFqZXNsjzQ-2x4-szW5pBg77bzSK-RmwPvQSN+UaxJXqqZ_2qA@mail.gmail.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 1, 2021 at 9:23 PM Jiri Olsa <jolsa@redhat.com> wrote:
> On Mon, Feb 01, 2021 at 03:50:22PM +0100, Jiri Olsa wrote:
>
> SNIP
>
> > > >
> > > > with Arnaldo's fixes I see less struct duplications,
> > > > but still there's some
> > > >
> > > > >
> > > > > I uploaded the build log from linking part to:
> > > > >   http://people.redhat.com/~jolsa/build.out.gz
> > > >
> > > > however looks like we don't handle DW_FORM_implicit_const
> > > > when counting the byte offset.. it was used for some struct
> > > > members in my vmlinux, so we got zero for byte offset and
> > > > that created another unique struct
> > > >
> > > > with patch below I no longer see any struct duplication,
> > > > also test_verifier_log is working for me, but I could
> > > > not reproduce the error before
> > > >
> > > > I'll post full dwarves patch after some more testing
> > > >
> > > > also I wonder we could somehow use btf_check_all_metas
> > > > from kernel after we build BTF data, that'd help to catch
> > > > this earlier/easier ;-) I'll check on this
> > >
> > > Seems like a good idea indeed :-)
> > >
> > > I'm applying the patch below with your Signed-off-by, etc, ok?
> >
> > ok, thanks
>
> Paul, Ondrej,
>
> I put all the recent fixes and made a scratch build:
>   https://koji.fedoraproject.org/koji/taskinfo?taskID=61049457
>
> if you have a chance to test and check your issue was resolved,
> that'd be great

I just built the current master branch of dwarves (d783117162c0, which
includes Jirka's patch) [1] in COPR [2] and then rebuilt the kernel
with it [3]. With the new dwarves, the issue seems to be fixed -
/sys/kernel/btf/vmlinux is back to ~4MB and the selinux-testsuite BPF
subtest passes.

Thanks everyone for getting to the bottom of this! Hoping to see an
updated dwarves in rawhide soon ;)

[1] https://github.com/acmel/dwarves/
[2] https://copr.fedorainfracloud.org/coprs/omos/kernel-btf-test/build/1930103/
[3] https://copr.fedorainfracloud.org/coprs/omos/kernel-btf-test/build/1930104/

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

