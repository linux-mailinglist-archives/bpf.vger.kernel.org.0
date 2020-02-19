Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7841652FB
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSXRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 18:17:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXRu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 18:17:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so2199966ljh.5
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpfxaO/zTgCK8om1Vh4obRVS3E0kHYDHNiD5CyjQBGE=;
        b=uBOgLfsVpbq8J3MwclBluq/B5nHqNWQGAqfKKJfhfG/fBivstMhKYml3VUz6p9qmJu
         abdeVSze26+0mU3IMCfwBPaf8WVEwIeA1tTC4BmakEiZvWfPV9fV4RfrboskI3rpODlK
         0ZP0TNsaEm7QKlHUYTC3niUwV5VOm5Zq/+XvLoOVDjfkv/NSjOQiWOL89Er+b/Q+ZLkd
         LgHbfCieN9MoePsFeg+pbdQ3Zel6C9z4uPc7UxmGls1I4fXCdSjnmEAkhHjRQxIurglq
         VSwtCuVvmRHjvLDR1iOW6RXmghMfJyFEa/04XYlX+Erm+DARIrUmgj+2ewJ1iy6W8cth
         Ng2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpfxaO/zTgCK8om1Vh4obRVS3E0kHYDHNiD5CyjQBGE=;
        b=CP7mS5s4faysKedvJjPVL7ixIyYg1iaSZZe40bUW5W30nm6vE4N5TqGp78DtStQJs8
         KcXzf218FRqEZIVA17vlJIj+/H+P02lhXAkmGS95Qr6EhgETK/oM3sRBV5aGRCHz14WN
         9QSpUHwlnIGRsA2eAh7isjI5bILzvK1tokqMIpc4x1runOsYYFL89T3cLcty2+8C+pyF
         //l6q6ixJynvgQdiT0ZYTA0dOOAU/fJLWZF35yMjMa0zmy1biU3VyXIldii3nn7Xct+r
         w3EHS3BpoF4sEk41jGU46QE0C6A/0ffWKzrcUUIuYGCYsCe/eL5pR8D3iG2vLmjZg/kr
         NX6A==
X-Gm-Message-State: APjAAAVMKEpom4dSG7VyR/WNe8nT4tNJWnQyq9PgZA0DChH5BtkFCVJo
        F1tlNMKdPkBxzUqo5kH9TjxDUxdAb6hsYE+Wa+E=
X-Google-Smtp-Source: APXvYqzG6AsZB3H56ctOyLlLVgD2ELwuNfCyO8Ph9t58wkc7gKppSxvItcVGQ7eg7iq7pOs17E+/UD7dpyrvmRYVnQ8=
X-Received: by 2002:a2e:b007:: with SMTP id y7mr16421844ljk.215.1582154267905;
 Wed, 19 Feb 2020 15:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20200219004236.2291125-1-yhs@fb.com> <956ccea3-0440-7c59-9c75-90cd7b25afb7@iogearbox.net>
 <CAADnVQLWJ+F8w0g9XaLbNHZEXKbcQeXt+AiAZX7gMX=L_PWrhw@mail.gmail.com>
In-Reply-To: <CAADnVQLWJ+F8w0g9XaLbNHZEXKbcQeXt+AiAZX7gMX=L_PWrhw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Feb 2020 15:17:35 -0800
Message-ID: <CAADnVQ+CtuOkpidngFxEXWU_efLOv9_ozj=eSgNo1os1w3b8Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: change llvm flag -mcpu=probe to -mcpu=v3
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 9:06 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 19, 2020 at 8:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 2/19/20 1:42 AM, Yonghong Song wrote:
> > > The latest llvm supports cpu version v3, which is cpu version v1
> > > plus some additional 64bit jmp insns and 32bit jmp insn support.
> > >
> > > In selftests/bpf Makefile, the llvm flag -mcpu=probe did runtime
> > > probe into the host system. Depending on compilation environments,
> > > it is possible that runtime probe may fail, e.g., due to
> > > memlock issue. This will cause generated code with cpu version v1.
> >
> > But those are tiny BPF progs that LLVM is probing. If memlock is not
> > sufficient, should it try to bump the limit with the diff needed and
> > only if that fails as well then it bails out to v1.
>
> with hundred parallel clangs running and all stamping on the same rlimit
> I don't think bumping that limit can work.
> Also building on older kernel should still do v3, since build should
> produce selftest binaries for the same vmlinux as this kernel tree.
> We hit this issue with github/libbpf CI. The vm used to do the build
> was too old. So far we cannot build vmlinux out of latest tree,
> boot into it and only then build selftests inside. It's too complex
> for CI system.
> So we build vmlinux and build selftests in that CI's VM, and then boot into it
> and run selftests.
> Upgrading VM is an easy fix for now, but the issue will cause the problems
> later. So imo fixing selftests build to predictable -mcpu=v3 is the
> most sensible way.

Applied. Thanks
