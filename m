Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BDE2F6A65
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbhANTC0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 14:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbhANTC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 14:02:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD7C0613CF
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 11:01:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j13so3747496pjz.3
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgzrtQA6cwJYVB4E+QNjELHwDOFxgcKkT8fmdOGWavA=;
        b=cHUsrtVUjHWrRt8uN1wTfHAjVTtrQqPYCbw0TudSvG0y9MS2oJIGaTktyAVs+u97L5
         ZELo/PrBHZENopegoW6a1zsd1iJ0+82vFLVOEGjUOSrivLaDetWHjniL1SDPTLjrxQLT
         wZe+nJQn2LcIdqS77nAkRRQhrz9epWAiqdrMdeeqGEvIEFbY5xUehDX+CsYYdg/1pi30
         ZNKAk41whmdadOJDdrQ9aZ7jUk5KakgMPQUu/sEaeLIfBVPh8BDQakfakqvpc3B9ARaQ
         JYi25ObubEE8O/V7imwxj39EBMzf2LuzDC5wEBMkCRgTz60XRDL8kZiMojjRfEFXDcTw
         4b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgzrtQA6cwJYVB4E+QNjELHwDOFxgcKkT8fmdOGWavA=;
        b=kVHabNLa8mfZklveJMkN6a6C6yY85Ykr6EJPrm7Q0RE1vmb+zVvMYfTCIS2i10922j
         fJ3fl3aNv8bHsDxim7SHHIFdeW2nlsLQTjqavY2fb0j881b6Fz8RI6W96bNnpIfcPJi+
         s1XMvjv6zofpnHIpgjW4ogqvFb/tddFHg3VS9WWVR+DY3nDnqXNhK6rkrlNZEwkRZvcv
         zb2n/zbMV+DEhpwO0YkfvP1z8xiBuE1fySz1KWrF2RIqOVUD3AQhsXEF5R0DR9VqMNoZ
         Vt3IS5ZQ2fcTM13YKEJ+2qfP+Hv8Vpni7gdgKKH2Eu6mm5sb6whDFNulf71JRouVcLaV
         0UWQ==
X-Gm-Message-State: AOAM532lLQ0eyQkzvfQah5w24655fyuHOdIONT1w4L9HNCWUnJ0JwGej
        gDz/lFBfDX6iq1Tg/ZotUJN924UDM3D+SB+U8PF5fw==
X-Google-Smtp-Source: ABdhPJz/QRK68GKtm5VaqKhYbXT+qwpe/ZDqCQn4fKTRLN84/HdWqUG3yzN4E+3+QA08lQme2JibGlOvmUZ4MSom8CU=
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr6220744pjf.25.1610650905813;
 Thu, 14 Jan 2021 11:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com> <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
In-Reply-To: <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 11:01:35 -0800
Message-ID: <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 10:53 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jan 13, 2021 at 10:18 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Wed, Jan 13, 2021 at 11:25 PM Caroline Tice <cmtice@google.com> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 3:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>
> > >> Unfortunately, I see with CONFIG_DEBUG_INFO_DWARF5=y and
> > >> CONFIG_DEBUG_INFO_BTF=y:
> > >>
> > >> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x3f0dd5a> not handled!
> > >> die__process_function: DW_TAG_INVALID (0x48) @ <0x3f0dd69> not handled!
>
> I can confirm that I see a stream of these warnings when building with
> this patch series applied, and those two configs enabled.
>
> rebuilding with `make ... V=1`, it looks like the call to:
>
> + pahole -J .tmp_vmlinux.btf
>
> is triggering these.
>
> Shall I send a v4 that adds a Kconfig dependency on !DEBUG_INFO_BTF?
> Does pahole have a bug tracker?

FWIW, my distro packages pahole v1.17; rebuilt with ToT v1.19 from
source and also observe the issue.
-- 
Thanks,
~Nick Desaulniers
