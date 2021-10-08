Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5590242647D
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 08:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhJHGMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 02:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJHGMR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 02:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1697561108
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633673423;
        bh=1hXPrrPgpfYYLhtxKgr6ypHQZmjcscspjb5JZQvTgLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KLb5124IJ32Suqapc9kNYTrxFYs8DlyHdOKviTF9+mQRYs9KtLlMtSaBkDyc4xdqh
         p6ITj7wV504kgmE2DernHGXSnbVkvL4k7NA5ZNdhFs94720C3mthw2vYsLj9P2cXKS
         7KpAbxTfdkfYpqHs1lzsIdTKexAGGxakbpWEo2nA8DUMvUckeKH9XEypyNVuvFujK4
         ImCwuHlJxFQzeLfOdV8W1VmI82MHNPtfzAINy8UFr5Ehci86Ca8AqUERasl7moFpHr
         /6yDlFuTgY+UN1RxXSzA6wunf0loBoEbR6ByAqSf/rpbWDPvyRSg4k6AVP7WyP5Z81
         GxixKiuoHzgTw==
Received: by mail-lf1-f44.google.com with SMTP id r19so32968156lfe.10
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 23:10:22 -0700 (PDT)
X-Gm-Message-State: AOAM530l+L6bLZEiTYTvDYPFQNX/Dkg2HKDycfi4u1bTLFwvp6FTtG0t
        5hXEtz3PbOFoJD0y4S7N4RvviybWqIqOndsrrKM=
X-Google-Smtp-Source: ABdhPJzrSI277uqQdK5e7BifG4Mg9XZAjvCackMoaNVxBPMqLrJ6ZUAuij62EVuG2rQqR0nG0uTVF/VtmOSAIPOBP5E=
X-Received: by 2002:a05:6512:3d88:: with SMTP id k8mr4763036lfv.114.1633673421347;
 Thu, 07 Oct 2021 23:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-4-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-4-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 23:10:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Xez_FHRNnMPraFA-SiNc46XvBT1KuA5ZWbN3K8uy_bg@mail.gmail.com>
Message-ID: <CAPhsuW7Xez_FHRNnMPraFA-SiNc46XvBT1KuA5ZWbN3K8uy_bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] libbpf: use Elf64-specific types
 explicitly for dealing with ELF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:37 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Minimize the usage of class-agnostic gelf_xxx() APIs from libelf. These
> APIs require copying ELF data structures into local GElf_xxx structs and
> have a more cumbersome API. BPF ELF file is defined to be always 64-bit
> ELF object, even when intended to be run on 32-bit host architectures,
> so there is no need to do class-agnostic conversions everywhere. BPF
> static linker implementation within libbpf has been using Elf64-specific
> types since initial implementation.
>
> Add two simple helpers, elf_sym_by_idx() and elf_rel_by_idx(), for more
> succinct direct access to ELF symbol and relocation records within ELF
> data itself and switch all the GElf_xxx usage into Elf64_xxx
> equivalents. The only remaining place within libbpf.c that's still using
> gelf API is gelf_getclass(), as there doesn't seem to be a direct way to
> get underlying ELF bitness.
>
> No functional changes intended.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
