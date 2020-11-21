Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E92BBB6B
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 02:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgKUBNg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 20:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKUBNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 20:13:36 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BEC0613CF;
        Fri, 20 Nov 2020 17:13:35 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id w5so10246402ybj.11;
        Fri, 20 Nov 2020 17:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ft8L88GT3lAaYaRsAjU61GqzRVoNN74nPtET5KZG9qA=;
        b=o5tL2kEpR6g56zhEoPucepvOR61Dx4wv+xhmdcf6w5zh3mABeLk6H3jdlNE0Sp5jtW
         bL03FqwJVN+k/WM0weSByUTCVmhlWVC+8l1bOiKo7h358cw1OxXa2jBc2ebFU8sY/izQ
         vtWSeyrXbd30kVqvSvCd4Gh+kjdfQ3giQRz5vBV0MIlGOAOb+c6aePIvEPPMjC2AXnj2
         c9FKS+Vxvi12GNwvegyU7UGMLs8rfjXAuOpE9Ni8kLcBG4XLDxRdU8/H9POtOW82wlq9
         D84w0v8mydeFdC1MhRnwGgnbdWIg0x1M8wDKkwByKJFZ2GQA3nLROVSI8gk4WcAsR/Y3
         EpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ft8L88GT3lAaYaRsAjU61GqzRVoNN74nPtET5KZG9qA=;
        b=jgNLwVgchmUY4EO2Alg63qKLM7YPUfXsYY6/R2cuf0jit/9ER/gMsy64IO0Dx50OkS
         XFNP5JNjIFCRXBJaugNGvxh7EzGGl8t1YrQsIpSobp5x+0jk+R13xdw4mv/s3MG4Mxha
         HDjfG0bE1kKPA6iyLGAky0RzVmNAy4IWayfr6x0nxs6o0myuXZpxa4I+UhoFRGJ/083P
         NJ8nrGHPBj5xWM1Fw1Uz12FGipCvDpJ/DUvyOyylXSxJ9KApofiuX0noZ6cTriQX7oiy
         FIDd0qI+mvoyE0fWRW1JmsqpqlT9CJ98I/WZHobmwaWPT99lJhfWA5hrG+WHzRmgz+Aa
         /CdQ==
X-Gm-Message-State: AOAM531SlTInGzJPCZjWPkeMjSO6pJUUUNLCZy/pr3VyB8QErsZpPxMZ
        zv+lcY9eghoFxu/zlI62/aUGln3IZTlE4UrK28M=
X-Google-Smtp-Source: ABdhPJwwqaqbRN6i0wPVejaMV0dSNMrWUUIXY4BjuANd9Dz2IHTHkejz6415Tm+zym1+JSfb10DcU3kWF6aPnlfenYc=
X-Received: by 2002:a25:e701:: with SMTP id e1mr19844976ybh.510.1605921215168;
 Fri, 20 Nov 2020 17:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20201114223853.1010900-1-jolsa@kernel.org>
In-Reply-To: <20201114223853.1010900-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Nov 2020 17:13:24 -0800
Message-ID: <CAEf4BzZ-0exZK7skcB_UjyatAx_R=hNqAXKVZ8EXgmSsHmthFg@mail.gmail.com>
Subject: Re: [PATCHv3 0/2] btf_encoder: Fix functions BTF data generation
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 14, 2020 at 2:39 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> recent btf encoder's changes brakes BTF data for some gcc
> versions. The problem is that some functions can appear
> in dwarf data in some instances without arguments, while
> they are defined with some.

Hey Jiri,

So this approach with __start_mcount_loc/__stop_mcount_loc works for
vmlinux only, but it doesn't work for kernel modules. For kernel
modules there is a dedicated "__mcount_loc" section, but no
__start/__stop symbols. I'm working around for now by making sure
functions that I need are global, but it would be nice to have this
working for modules out of the box as well.

If you get a chance to fix this soon, that would be great. If not,
I'll try to get to this ASAP as well, because it would be nice to have
this in the same version of pahole that got static function BTFs for
vmlinux (if Arnaldo doesn't mind, of course).

>
> v3 changes:
>   - move 'generated' flag set out of should_generate_function
>   - rename should_generate_function to find_function
>   - added ack
>
> v2 changes:
>   - drop patch 3 logic and just change conditions
>     based on Andrii's suggestion
>   - drop patch 2
>   - add ack for patch 1
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (2):
>       btf_encoder: Generate also .init functions
>       btf_encoder: Fix function generation
>
>  btf_encoder.c | 86 +++++++++++++++++++++-----------------------------------------------------------------
>  1 file changed, 21 insertions(+), 65 deletions(-)
>
