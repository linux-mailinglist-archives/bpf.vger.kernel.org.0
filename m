Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1959D183820
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgCLSAH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 14:00:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41916 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgCLSAH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 14:00:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id l21so5096807qtr.8
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vO7UxzMkajIaQhwuJsiFb8YBPZ6HsrvS9yZLO689IxY=;
        b=jBM4RfiISyPVaQ2tz0cZMNYPDB4Nb/uabwKEBcZALNXM09Vma8hT72mQGPNv0fFR10
         zLLF2cUKp26Kxp++n5bJbMBpNAu2FdS2EU2fsGm7tZGTzAr6QzviNJ1Jb/WmbqyXYnc1
         FsTej/uMXQ9SWrmajTlSFUgIBzP1ZiJ0vbjy29A3Mmx6FDY6FMMkXyJkd8MZrq4S9w7X
         kLK8XfB79w06771PJkFV2uevsI/ex9AQVyoVhLw5zU8CH2HYfuuSvticiBDKArtw3SUo
         HqY97kYbqsim9nwIl1xHgfUvI4aykJKzwZEmh+AsTzWowI8NF3SBM3rdSxm9ARyh94xa
         qcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vO7UxzMkajIaQhwuJsiFb8YBPZ6HsrvS9yZLO689IxY=;
        b=k7IP9apo+UoK3tk31Ju3m7Q5AV8xFmlUdnZiicl8GpS2wRjJhBMAqysPW72tuLSetQ
         1DODv5X8E54FFaWoq+eqp+E+urs5Uv1DqBnQgaQ7U6J4OkopGRChxBeXodK0NU7FVKri
         GGk5j2fhN7zoUQ1F2UZ+KlO43uImJoca9j/YyV13XKOVNBfxUvKleuHu/MgFNt2GTRbO
         /a7Lf9z769C1Df4bFwdG1icyiMAPnhdv79ptGlTnI21PjFXS82kq2XeTdcPFDYKn9IWN
         2mcl8TVX98Bl0K6K7SD4F+txB6+zPT2HXPpJm0oJX2CmDyhlN3Vu3ixiC9JkbUe5Bm3c
         jykQ==
X-Gm-Message-State: ANhLgQ2hgleMy+x8JJ43GpOSvPC38ycsJyREFZYj8nrFHhnVqL13ZlF0
        Rz49CiO0d40JPESGAGiZhQvWPSyAr9IIG0yc/baSINTwsRs=
X-Google-Smtp-Source: ADFU+vsKYxnKhXY1Z7SS2Te6xy4naXwrPGQ0YPhKv7ODFKZdJZxY13cLqTyWraaTxW7Y5TQD0A10jTw+Ya6DEruAsMs=
X-Received: by 2002:ac8:3f62:: with SMTP id w31mr1064467qtk.171.1584036006218;
 Thu, 12 Mar 2020 11:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200312105335.10465-1-tklauser@distanz.ch> <20200312130330.32239-1-tklauser@distanz.ch>
In-Reply-To: <20200312130330.32239-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Mar 2020 10:59:55 -0700
Message-ID: <CAEf4BzakzbN4+PVa4TFsOhH=Pnt_4mhPknH74kwsRkOApkKhOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: use linux/types.h from source tree
 for profiler build
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 12, 2020 at 6:04 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> When compiling bpftool on a system where the /usr/include/asm symlink
> doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
> the build fails with:
>
>     CLANG    skeleton/profiler.bpf.o
>   In file included from skeleton/profiler.bpf.c:4:
>   In file included from /usr/include/linux/bpf.h:11:
>   /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
>   #include <asm/types.h>
>            ^~~~~~~~~~~~~
>   1 error generated.
>   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
>
> This indicates that the build is using linux/types.h from system headers
> instead of source tree headers.
>
> To fix this, adjust the clang search path to include the necessary
> headers from tools/testing/selftests/bpf/include/uapi and
> tools/include/uapi. Also use __bitwise__ instead of __bitwise in
> skeleton/profiler.h to avoid clashing with the definition in
> tools/testing/selftests/bpf/include/uapi/linux/types.h.
>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/bpf/bpftool/Makefile            |  5 ++++-
>  tools/bpf/bpftool/skeleton/profiler.h | 17 ++++++++---------
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 20a90d8450f8..f294f6c1e795 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -120,7 +120,10 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
>         $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
>
>  skeleton/profiler.bpf.o: skeleton/profiler.bpf.c
> -       $(QUIET_CLANG)$(CLANG) -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
> +       $(QUIET_CLANG)$(CLANG) \
> +               -I$(srctree)/tools/include/uapi/ \
> +               -I$(srctree)/tools/testing/selftests/bpf/include/uapi \

Seems like I'm spoiling all the fun today :) But why are we ok with
bpftool build depending on selftests? This just makes it even harder
to have a stand-alone bpftool build eventually (similar to libbpf's
Github).

> +               -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
>
>  profiler.skel.h: $(OUTPUT)_bpftool skeleton/profiler.bpf.o
>         $(QUIET_GEN)$(OUTPUT)./_bpftool gen skeleton skeleton/profiler.bpf.o > $@
> diff --git a/tools/bpf/bpftool/skeleton/profiler.h b/tools/bpf/bpftool/skeleton/profiler.h
> index e03b53eae767..1f767e9510f7 100644
> --- a/tools/bpf/bpftool/skeleton/profiler.h
> +++ b/tools/bpf/bpftool/skeleton/profiler.h
> @@ -32,16 +32,15 @@ enum {
>  #else
>  #define __bitwise__
>  #endif
> -#define __bitwise __bitwise__
>
> -typedef __u16 __bitwise __le16;
> -typedef __u16 __bitwise __be16;
> -typedef __u32 __bitwise __le32;
> -typedef __u32 __bitwise __be32;
> -typedef __u64 __bitwise __le64;
> -typedef __u64 __bitwise __be64;
> +typedef __u16 __bitwise__ __le16;
> +typedef __u16 __bitwise__ __be16;
> +typedef __u32 __bitwise__ __le32;
> +typedef __u32 __bitwise__ __be32;
> +typedef __u64 __bitwise__ __le64;
> +typedef __u64 __bitwise__ __be64;
>
> -typedef __u16 __bitwise __sum16;
> -typedef __u32 __bitwise __wsum;
> +typedef __u16 __bitwise__ __sum16;
> +typedef __u32 __bitwise__ __wsum;
>
>  #endif /* __PROFILER_H */
> --
> 2.25.1
>
