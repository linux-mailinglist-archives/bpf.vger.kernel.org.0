Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86D426473
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 08:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhJHGIE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 02:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhJHGID (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 02:08:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFF9D60FE8
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633673168;
        bh=rPh596Z/KAVn5hWqebvpNlSrx1YN1kPppcmkCAQHhmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PG3nGqg8tS8KHmaA8RHOGLKATd231XjwvZBoflZk3ei+fO4HjYtuFErY7vc4na151
         JTcMCvCbvTNc1BzjDcDnx8e8jwJrRgyCF3csyNzDxMxHVJ8HuKUrsj7M4AR0YmeM5q
         0BmLml7ZEinM3rL1itB1c/gxj1ve7x/HZU/M8Rv8ckwV8zYuZj3IDZI4A6JzWrQyZD
         /w0eUM1ZUDmj4up8wyvitpBDNQWTsTA2nxLfRBis3QuhKiVE8WbPwJNktee+AN0JXJ
         aCQMXA7417aeZz14X2MHykzy2H1AYhFUhz7aADEW4NzCgEEZff46+UQaZa0ttQoso8
         noG1a7DiYN0jw==
Received: by mail-lf1-f42.google.com with SMTP id z11so26300686lfj.4
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 23:06:08 -0700 (PDT)
X-Gm-Message-State: AOAM532YvbBfV8mHsSROVHQxXJP6ZCn5ZBXduVImve/J9eLocyx7r65c
        zien1JUn+j6h1oBdA8zfPa29GWoE5ade8zY1kDM=
X-Google-Smtp-Source: ABdhPJza79Ei4tf+JX6CN+89sdpYstcq2msZlsZoOAXhEYyOjNxFUxSouvaG+ti0vfgq5E58HgC6m9brGaNSzFE/tEU=
X-Received: by 2002:a05:6512:3d88:: with SMTP id k8mr4746667lfv.114.1633673167261;
 Thu, 07 Oct 2021 23:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-5-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-5-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 23:05:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4T2OkzdJu3+D8nVitWBPCBSRtCGwxcgDh4JRDksmrWsQ@mail.gmail.com>
Message-ID: <CAPhsuW4T2OkzdJu3+D8nVitWBPCBSRtCGwxcgDh4JRDksmrWsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] libbpf: remove assumptions about
 uniqueness of .rodata/.data/.bss maps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:04 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Remove internal libbpf assumption that there can be only one .rodata,
> .data, and .bss map per BPF object. To achieve that, extend and
> generalize the scheme that was used for keeping track of relocation ELF
> sections. Now each ELF section has a temporary extra index that keeps
> track of logical type of ELF section (relocations, data, read-only data,
> BSS). Switch relocation to this scheme, as well as .rodata/.data/.bss
> handling.
>
> We don't yet allow multiple .rodata, .data, and .bss sections, but no
> libbpf internal code makes an assumption that there can be only one of
> each and thus they can be explicitly referenced by a single index. Next
> patches will actually allow multiple .rodata and .data sections.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
