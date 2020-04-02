Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF91D19CC36
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbgDBVDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 17:03:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33782 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBVDJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 17:03:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id v7so5827899qkc.0;
        Thu, 02 Apr 2020 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVjs2DH9m9fKgjs6n5kVRWIE0vGLsA/x3K/6uNiKORs=;
        b=daDolYs7NP3AZpiXGh8vMaDcVivAzxdICdi7a5NF4eji04bA84T747X4wiXOZfMH1J
         PNU/6IAUp2gnrVx3HcfMPiEYj3DWHUs4qsHQMDo/8VyrnqhbyL/TsfFtFZWlJkCad0tt
         364Ci6j98+J/faVYlvmIY+4UIDBWba5IvRCj9/RzlsszImRrZkEPx5xpJoA96RtuDcPb
         YpDWiyEPusaB0pnVTjDtQuAJhB74DWBcXrYhxOttkXswGEBqQ1KJ4gAnQEbiUNvm757G
         u2ylGGb36YA0ZpNX0UESKPW8vKTbUxfLeK/O0MdLC+bZkDXzMOVECnHORTppQ3y3WU1j
         T9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVjs2DH9m9fKgjs6n5kVRWIE0vGLsA/x3K/6uNiKORs=;
        b=b9hEV0Qex9KqLzRUnf1LNc0xNlSLKpWC+rL3LWtTFRMfhl9Pe32gs0qJn2WjmzKdeg
         v0V7qTngOfrL3cS2qFRCFZLcZ5Zg/1Yc8MrG3Qvu1q6F9o7GRzImPUC1t/0+HoywNkCF
         emrJK/E3/6FBJhd3RRSY79rPSSvtY/JrFz1qEtrkxstK0FyAHMc9sKnB/89gDCH70BWW
         Lx5SQ2rFOmunXDiEuRVdBhGVTRwfGWoaDkbKnZ23wUguw+dQ8selOgHFrC4QOirgYjNe
         yVifMZ1zbP5iEgsz8J5z1Q6PZgyhkBHycb/xOmVqLTXFLgplmyq2wVEZA+PG4NKq0rTa
         bNFA==
X-Gm-Message-State: AGi0PuZfNwufWZuCUGi1eG1XdgGOiFek+j3DNZi7ZK6lOLYa7GztvrQU
        yjq5ebXJEeq+qvD4zpflhb8/vCH1N49gUnwJVzU=
X-Google-Smtp-Source: APiQypI9U0BrOKkyTjQVQejiiAYGIbOCtFil/m6mRrtSQalLPzDZZy1MMaWsZIdOvgwQjFiGvhPG+t9P95gmvP0Beew=
X-Received: by 2002:a37:6411:: with SMTP id y17mr5760875qkb.437.1585861388455;
 Thu, 02 Apr 2020 14:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <202004021328.E6161480@keescook> <20200402204138.408021-1-slava@bacher09.org>
In-Reply-To: <20200402204138.408021-1-slava@bacher09.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Apr 2020 14:02:57 -0700
Message-ID: <CAEf4BzZxWTDCtcov5_TvGLR0Qp4p-JANh29WoZKEQ6FvmWrr9A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Kees Cook <keescook@chromium.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 2, 2020 at 1:44 PM Slava Bacherikov <slava@bacher09.org> wrote:
>
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
>
> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
>
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> Acked-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
> ---
>  lib/Kconfig.debug | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f61d834e02fe..6118d99117da 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -223,6 +223,8 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_BTF
>         bool "Generate BTF typeinfo"
>         depends on DEBUG_INFO
> +       depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
> +       depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST

Given what Kees explained, I think this looks good. Thanks!

>         help
>           Generate deduplicated BTF type information from DWARF debug info.
>           Turning this on expects presence of pahole tool, which will convert
