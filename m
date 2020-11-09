Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E328D2AC5D8
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 21:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgKIUSD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 15:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgKIUSC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 15:18:02 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93BC0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 12:18:01 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 10so5896804ybx.9
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHkDhTK4ojtZxmuJz3GYSM2EptQyBcHZuaD2mftZrZ4=;
        b=J3RnC8uYG7zJed9dBnOVr9FBEScgEh+PtTGGyHW+4dZ3m3m/vkqgckwK5jZQcwccrJ
         YOG5jaqNrjmT3Y6OtnGginFmSofvdG7IteV7myB26C30wp+RFd93HTBtvqjdu4kXkr2Z
         sC4fXH1aXxPySomxUsNWGCs17f7EHMFmCYTRkxLZPOWdvmPnH6Uo47MKZfuZNXelUkqH
         3fMkzbjOA3OV+byv6+MsLsa5vH6TEXc8k739lUqKCTQhEJli4jQo+oax2LCOuwSvW/O4
         M1I/LxHY5PvTrr7gPBPrjMOQCIs7M5BOCweiyE7YsHX52xQ3sc7Qp3ZQF2Gij23lZTOJ
         Crqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHkDhTK4ojtZxmuJz3GYSM2EptQyBcHZuaD2mftZrZ4=;
        b=fU+r17PEi8Kx1ktkBU3cNDIPKBb30eR2FWrnZAzC/ee+ucIrs/W3FBf0HfHtZf7iwp
         f34dZ4VLn16UcPdyNUqpRnlWeiSKIzTFDd2EY86f0gco43Gj9y82NroHVtYSB0vFz0WA
         pczjxj4UQPjRgKAr1d+/yjg4zem7IKOttSexpa0peOVoYaGUeaTbcrNAk6trorxpQ8xd
         nt7WzUG1cSLkXFd6NPCP6M9GVYmd0yRXiwGzkrhT9wBEXYI4vqGWBIB2ASi43qQuKSLr
         DzWn+C2fXaGec1ULsr6tL8EfuxTmmcYI545VMXLZ4IEG50mfNcB4Emjrl984FqBwEfqQ
         /Lkg==
X-Gm-Message-State: AOAM533THyx5caUJ/GvXjLNBuic67bTrBFpud4G0a5OYPHOaluBtb0AD
        oA619pAJ2xSOIAWKXdb3OU79+z1UWH0uPzTz/XA=
X-Google-Smtp-Source: ABdhPJx1xwNHihciP/uHrJVtvxHWzKW9/+1wkISR5FAnsBp4Sib0W03/sE3DNyaJEhS3l9CR1/5jnXpUde1Kirk5ASo=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr21607206ybl.347.1604953080233;
 Mon, 09 Nov 2020 12:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20201109110929.1223538-1-jean-philippe@linaro.org> <20201109110929.1223538-4-jean-philippe@linaro.org>
In-Reply-To: <20201109110929.1223538-4-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Nov 2020 12:17:49 -0800
Message-ID: <CAEf4Bzaw9Fox6FZcT+ipFsnrHFRKrno27Y4Uh13eiNpd08es2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] tools/bpftool: Fix cross-build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 9, 2020 at 3:11 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The bpftool build first creates an intermediate binary, executed on the
> host, to generate skeletons required by the final build. When
> cross-building bpftool for an architecture different from the host, the
> intermediate binary should be built using the host compiler (gcc) and
> the final bpftool using the cross compiler (e.g. aarch64-linux-gnu-gcc).
>
> Generate the intermediate objects into the bootstrap/ directory using
> the host toolchain.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/bpf/bpftool/Makefile | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 1358c093b812..0705c48e0ce0 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -19,24 +19,36 @@ BPF_DIR = $(srctree)/tools/lib/bpf/
>  ifneq ($(OUTPUT),)
>    LIBBPF_OUTPUT = $(OUTPUT)/libbpf/
>    LIBBPF_PATH = $(LIBBPF_OUTPUT)
> +  BOOTSTRAP_OUTPUT = $(OUTPUT)/bootstrap/
>  else

LIBBPF_OUTPUT is not set here, can you please fix that as well?

>    LIBBPF_PATH = $(BPF_DIR)
> +  BOOTSTRAP_OUTPUT = $(CURDIR)/bootstrap/
>  endif
>

[...]

> -clean: $(LIBBPF)-clean feature-detect-clean
> +clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean feature-detect-clean
>         $(call QUIET_CLEAN, bpftool)
>         $(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
> -       $(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> +       $(Q)$(RM) -- $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
>         $(Q)$(RM) -r -- $(OUTPUT)libbpf/
> +       $(Q)$(RM) -r -- $(BOOTSTRAP_OUTPUT)

Can you combine it with the previous line, maybe also specify more
explicitly $(LIBBPF_OUTPUT) instead of $(OUTPUT)libbpf/?

>         $(call QUIET_CLEAN, core-gen)
>         $(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
>         $(Q)$(RM) -r -- $(OUTPUT)feature/
> --
> 2.29.1
>
