Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8A413D20
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhIUV7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 17:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbhIUV72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 17:59:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DDC061762;
        Tue, 21 Sep 2021 14:57:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d207so2868113qkg.0;
        Tue, 21 Sep 2021 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEJSiqyogr4SM4A4lDqjWLxllEFvyQtngCbOv9PrjxM=;
        b=h1EZ8S2Jp1p/lzEMg68zl/3Xo9HGjF+edGhOFJSKw6aMxsmrZ5ZZTta75fr5ZTyBwr
         p6BCQ5ATN/Dz3KncByhpPMKtq3fP7r08imNz9k31OU8uLVuRY/aQLkxpueGYA5ke3LZp
         8cxiCroH2wgGo6rSxO/v5I0iY/TYAg7ZitHuTvHQ28npEBMavAHOvJs0cCLrf2zfNzFO
         bdApcP874oK0+DYxl0wY4nS3ciX+ohCq7e2dBKOlts3u4h4Di2FhSdLJ4B59lVAqi7H1
         2mAvEGGNhmBt7m+rJYhoJkcbKLNzIUpSTo4yL5hr6KNoJO+jKHFG9n6FkYDVdvmsq8S3
         s3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEJSiqyogr4SM4A4lDqjWLxllEFvyQtngCbOv9PrjxM=;
        b=C76BoWHLY5u5XAMK9oUoffeRPAifd5Lma+YvYDnL7HeV7DLFPxRLvL8Iz1LkiCS5Mi
         ZsITYikhU3dpznz9eIGG4EhJVGfTogYRqFXRyHhDO/dZcSbnN0QlGyly1YsKnIw8hjly
         tNnulNYUfBa8LDNDWMXS1jxFvIsf1rykHB59Xhi5Sl6Q4zADE45BbOnaBS96wzj0AYYX
         GSvNcZtIseDpMz3ukfGE5+/dzdoA6iZDOohW2HfzIKOH2LrUG5cnYx5OcpKBp7OPknVX
         F90Xkl1LqxlgY+1U3uVCLBJpDyU6K5rBg4CwEn9xZ8stDVba/wY4RonGDje+gNEZGeSP
         XjXw==
X-Gm-Message-State: AOAM530X3aX0j8UU0pZ6Vf7US9LTVgC97z3ykYlMmD2ncIoKBJBaLakK
        fROOsyPaKhZnOBsdikgMJRUYsGMPWehFS8s63xMFuPP74ro=
X-Google-Smtp-Source: ABdhPJxbrju1AXc5iym3fn2w2b2woWDfdHBY8/lGj5PRdkqZqgbnKk6eAtClRn1rNQaPn1hoSWGZyvYDf1jaKIRTfBw=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr41595206ybj.504.1632261473577;
 Tue, 21 Sep 2021 14:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210920003545.3524231-1-yhs@fb.com> <20210920003550.3525047-1-yhs@fb.com>
In-Reply-To: <20210920003550.3525047-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 14:57:42 -0700
Message-ID: <CAEf4BzY7LxXZ2E0aezVPykDhXvEGeiLFWojirVNBLJ2j0qU2=w@mail.gmail.com>
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: parse dwarf tag DW_TAG_LLVM_annotation
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 19, 2021 at 5:36 PM Yonghong Song <yhs@fb.com> wrote:
>
> Parse dwarf tag DW_TAG_LLVM_annotation. Only record
> annotations with btf_tag name which corresponds to
> btf_tag attributes in C code. Such information will
> be used later by btf_encoder for BTF conversion.
>
> LLVM implementation only supports btf_tag annotations
> on struct/union, func, func parameter and variable ([1]).
> So we only check existence of corresponding DW tags
> in these places. A flag "--skip_encoding_btf_tag"
> is introduced if for whatever reason this feature
> needs to be disabled.
>
>  [1] https://reviews.llvm.org/D106614
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  dwarf_loader.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++----
>  dwarves.h      | 10 ++++++
>  pahole.c       |  8 +++++
>  3 files changed, 97 insertions(+), 6 deletions(-)
>

[...]
