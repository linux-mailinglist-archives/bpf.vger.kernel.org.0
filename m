Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5645AB46
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhKWSfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhKWSfi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 13:35:38 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1DCC061574;
        Tue, 23 Nov 2021 10:32:30 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id j2so25340505ybg.9;
        Tue, 23 Nov 2021 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkN6cHNpZJHGhsD6Qe/d+ZTHGrl47aqCVGHqvTGs5Iw=;
        b=MNE/Z9z19SHPijt3nHYq2UjoY+FZCklWbDg+gqqakj0m3yhe7o+73LhEGm/MYtkYDs
         c0cwJmk/6F1VlnXzsSLrrAqPYQPhMhn/PeaEZmb3LNYIRwuhcSutxba8J9+7vsSMDVWz
         mvdldHL/1ApGHIbUb+XOmgefZ32+TaBkFy4J8iELyW32Gcrrf7exf39cxCFofhFblKLL
         H8PM4Fi3kXcQtUCtNNds5JwQo82LXp2jhzvwtcaCbHrXsEX3ndpvIF/W54iNvcU4H/cN
         SyKOKTQvR1gG1N7R6DwKmoM41lrXfTqsPfFq2YvD0+uDK3T+nxEDwaJd5KW1zj7dD8NL
         2HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkN6cHNpZJHGhsD6Qe/d+ZTHGrl47aqCVGHqvTGs5Iw=;
        b=UzuVT+sXU++FGAdqy6mRM56G1J83VeEFaO3PI2HHLdcCtYPHm4I0Ivw1ZGe4KIKmxt
         HkTx0mArUEZi7Le5oirf/sYEHpm68iRmNidDanOfR0Pzr55hcC7RZhl0u9IBAckt3mvs
         TyP6xg8SzKlXusuopBohfJunZqKgGWRZkAuxHbKUHke3T//g0s6UfSyrjhC6IldJxEGM
         iWgkYkDLFXunP80qiB7VJPVvbnM7n25Ci3+FvX1baWFayBMHRSBfg1/UmphRIWrEBelW
         sFVXXXK8MN0zhvyxHHu3GKTL7APv5O03y/0H0C0NGEAkkRuIGkfFHxPCgYMTeXo0Cuis
         7THg==
X-Gm-Message-State: AOAM533ppO0T0BA/1NRI+5cGLsZLJAl97nIw+H7GW3M8pl4gsp0TU+fQ
        wqOCeRshvsFJ3uvJ0gvjurTl7CL+X2ofYWj2vUA=
X-Google-Smtp-Source: ABdhPJwW6suPgdDSkGUDJeKXHN7Ft3uKRlo+ggY7NF+39iY81m7jZLo1QL3mZHZ8fxUzw3LolPY92JyISMbGhFNtW0g=
X-Received: by 2002:a05:6902:114a:: with SMTP id p10mr8548275ybu.267.1637692349746;
 Tue, 23 Nov 2021 10:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20211123045612.1387544-1-yhs@fb.com>
In-Reply-To: <20211123045612.1387544-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Nov 2021 10:32:18 -0800
Message-ID: <CAEf4BzbEMzpXKQ18FmFxgozAmbx8Mz87YamONpbAWaKDCULGjg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 0/4] btf: support btf_type_tag attribute
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 8:56 PM Yonghong Song <yhs@fb.com> wrote:
>
> btf_type_tag is a new llvm type attribute which is used similar
> to kernel __user/__rcu attributes. The format of btf_type_tag looks like
>   __attribute__((btf_type_tag("tag1")))
> For the case where the attribute applied to a pointee like
>   #define __tag1 __attribute__((btf_type_tag("tag1")))
>   #define __tag2 __attribute__((btf_type_tag("tag2")))
>   int __tag1 * __tag1 __tag2 *g;
> the information will be encoded in dwarf.
>
> In BTF, the attribute is encoded as a new kind
> BTF_KIND_TYPE_TAG and latest bpf-next supports it.
>
> The patch added support in pahole, specifically
> converts llvm dwarf btf_type_tag attributes to
> BTF types. Please see individual patches for details.
>
> Changelog:
>   v1 -> v2:
>      - reorg an if condition to reduce nesting level.
>      - add more comments to explain how to chain type tag types.
>
> Yonghong Song (4):
>   libbpf: sync with latest libbpf repo
>   dutil: move DW_TAG_LLVM_annotation definition to dutil.h
>   dwarf_loader: support btf_type_tag attribute
>   btf_encoder: support btf_type_tag attribute
>

I thought that v1 was already applied, but either way LGTM. I'm not
super familiar with the DWARF loader parts, so I mostly just read it
very superficially :)

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  btf_encoder.c  |   7 +++
>  dutil.h        |   4 ++
>  dwarf_loader.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++---
>  dwarves.h      |  38 +++++++++++++-
>  lib/bpf        |   2 +-
>  pahole.c       |   8 +++
>  6 files changed, 190 insertions(+), 9 deletions(-)
>
> --
> 2.30.2
>
