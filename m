Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA38334F8C5
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhCaG3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 02:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhCaG2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 02:28:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD24C061574
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 23:28:47 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a143so20025635ybg.7
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yV2Y2VTy81kt735cbWB+njli/gTW0yXIK6Lt5crzrNw=;
        b=ALOBwhOTrtJs/vg2jnXpQI2cyF1Pp1LBwMXQKVBAOfdxvbChg05XFQ0to7wVtCLd0u
         OJNU0eHFu9wcCa1R6W+uegdihV6Nb4DotakQQ/JpGRoFKyQP3GKo0d+7dO6h10SoIuvC
         Rt4754Sv0p6UVCffyVnHmnShlgGfglh2GS9m4nD6l+KOAL5zKcL1TPzo8yOX074A40K8
         qMOUL3Ua+/fbU4HOC+etk9r6Wf3lUKCokmjylIn4oxp1ixoVxpgsxRp89F9vHMTKVoYm
         RZOHuBqTgGEa18IV6ziiqnUwj0HAo/4Xwq90v4TJz0b6icvmEassdAhMxB0Or0EW1jU7
         +e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yV2Y2VTy81kt735cbWB+njli/gTW0yXIK6Lt5crzrNw=;
        b=OtNIgPecOnpfVHDnotpMiPVwhH4l43jhNaxj463xk8Q+y1bBnGbc5WE9/bcUbgAcb1
         rmHepmqZrd3ctr9dvBgdMcWZ0fdi0VGdDJ1If4LsUPW2EtZsJh+ZAHa594OWZxCc3oa1
         QnAWNnU4J2dX9HRG2LQ2X2KPFGgQEAOdC9ZEdAwsfeLFzRZ20t07vE0eAZSJzU/uz8Fm
         e+q+IqsPpn+om8iByT4bSF7es8JmDE1XgAek1O1f9BIfx29PWbSeQ0XZUANM/XEK5z90
         a31btfwlFT0zZMK1p7+ZmDm6lIoxpwPxTs5gOjeMdwZn+kSFjjQFgBL0smbxAe6HZB8d
         SWfg==
X-Gm-Message-State: AOAM533XXhtuGT2Ff2yt2RvkqdTbnkCe1piTo+hve/2+rZsK16WGi5IX
        9tjRN4DwDYdHHjSTXBx9e3fYwQJope14ZJsxKac=
X-Google-Smtp-Source: ABdhPJxIBU28JWIvSCykc1cLggY41f++6SJ/LiDOsSO0WllstPFT3lOuJM1VBdUXaZOBYus/B5+fE6eh47SoxANDWx4=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr2383573ybb.510.1617172127011;
 Tue, 30 Mar 2021 23:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210331014356.256212-1-iii@linux.ibm.com>
In-Reply-To: <20210331014356.256212-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Mar 2021 23:28:36 -0700
Message-ID: <CAEf4BzaF6WMz8pM2X03p_oQo95J1e-7Owi+8Y=GAOkXrx8H-aA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Generate BTF_KIND_FLOAT when linking vmlinux
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 30, 2021 at 6:44 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> pahole v1.21 will support the --btf_gen_floats flag, which makes it
> generate the information about the floating-point types.
>
> Adjust link-vmlinux.sh to pass this flag to pahole in case it's
> supported. Whether or not this flag is supported is determined by
> probing, which is chosen over version check for two reasons:
>
> 1) at this moment --btf_gen_floats exists only in master, which
>    identifies itself as v1.20.
> 2) distros may backport features, making the version check too
>    conservative.
>

Does anyone really cherry-pick and backport pahole patches, though? So
far we've been using strictly version checks for pahole (1.13, then
1.16, then 1.19 for modules), that keeps everything simpler and more
reliable, IMO. I'd stick with 1.21 check and just check with Arnaldo
when he's planning to release a new version.

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/link-vmlinux.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 3b261b0f74f0..f4c763d2661d 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -227,8 +227,13 @@ gen_btf()
>
>         vmlinux_link ${1}
>
> +       local paholeopt=-J
> +       if ${PAHOLE} --btf_gen_floats --help >/dev/null 2>&1; then
> +               paholeopt="${paholeopt} --btf_gen_floats"
> +       fi
> +
>         info "BTF" ${2}
> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> +       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} ${paholeopt} ${1}

we know that -J is always specified, so I'd leave it intact, and just
have "extra pahole options", potentially empty.

>
>         # Create ${2} which contains just .BTF section but no symbols. Add
>         # SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
> --
> 2.29.2
>
