Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A077312843E
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 23:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLTWCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 17:02:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45034 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTWCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 17:02:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id t3so9473316qtr.11;
        Fri, 20 Dec 2019 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbGwMOUgd9d3+9XSi5Vb8fzDSP5GXsC9AtqNSEri7cQ=;
        b=mjU2e8nFeEpF9D5JbjQG3jnbToqItWMRqbp6FizZr/RR+Al/k0xkpWOpivSbXiwxFG
         sSvLfB3wVOwBC/tIXJIB49JLPneJk4JtF0d41clIPR/ZoJgRGl6cZrPytcnxBTMbofZt
         ym8ch/GrMH+HVoaSmduCkfhQwRD5bzb9+u4oKDqBATq6sh4FCJRplu1+u8WmwzmD3hLO
         bJIVB7sWCUBRJ8uaSU5ZUXIYK+p9ypVIHC0BkkpHhlkJ0uNz+UhT/P2pBrg4QcnjL8eE
         pRmECjee7EoWRjeQWsAG4IdOgaV1zml91ezdW+fkwfgtTH2XPL5vb/TlmXxVoLWjXHfw
         ne1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbGwMOUgd9d3+9XSi5Vb8fzDSP5GXsC9AtqNSEri7cQ=;
        b=TfgVu1n6mrSRqbFbFOOPniYxizlgx5CopNggBwBx4j42djwQ3+sFEUy3oE72s8vyD7
         w+WPg+nzDKj6EYU3hkZ18bXMzrWP+AFQu01lgBoMNyse/Kgs1Z1sb5FXTtpMAmWDPBFh
         RhhxYj/aUHk6BhBjZlXjRl+erH7I3txZRM4kHAuhI/bGoB+BQ2ty+kLxnYytzww3oFbh
         AcH1q9CS3vYS+nFFjfPg+btqg1eINssDSlgUYl6FgA+ehX24xb+s/C4AfBBNw41Uf6+5
         rmrNuPW1pGoSgRGNWUkM9Tl2NpTqxND8SNYQw8j/m9JK+mRqGlbLlSG2UDooZEWkvspv
         wMeQ==
X-Gm-Message-State: APjAAAXuX0Rn5T9TbFBN8naFEr+VoBWQhLAONLWIu68ZdUozMraX1M5B
        hIodFRuhzzGd6QsQWsW63JOE3J6NiH5riirdb5w=
X-Google-Smtp-Source: APXvYqxTOj4lrM4oOy2BlmCDw4mQNK7wK64SlnVixE0mdQR/RiA77nZ/xACY35QlcB24aVT/3ti/ugdAHMIMJ2BCSUY=
X-Received: by 2002:ac8:5457:: with SMTP id d23mr13091366qtq.93.1576879321519;
 Fri, 20 Dec 2019 14:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20191220032558.3259098-1-namhyung@kernel.org>
In-Reply-To: <20191220032558.3259098-1-namhyung@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Dec 2019 14:01:50 -0800
Message-ID: <CAEf4BzahazYCzutyULrugwjjz-Fxg_rzJ8v+pXUKpsmzpsHfJQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I got the following error when I tried to build perf on a read-only
> filesystem with O=dir option.
>
>   $ cd /some/where/ro/linux/tools/perf
>   $ make O=$HOME/build/perf
>   ...
>     CC       /home/namhyung/build/perf/lib.o
>   /bin/sh: bpf_helper_defs.h: Read-only file system
>   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
>   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
>   make[2]: *** Waiting for unfinished jobs....
>     LD       /home/namhyung/build/perf/libperf-in.o
>     AR       /home/namhyung/build/perf/libperf.a
>     PERF_VERSION = 5.4.0
>   make[1]: *** [Makefile.perf:225: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
>
> It was becaused bpf_helper_defs.h was generated in current directory.
> Move it to OUTPUT directory.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/bpf/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 99425d0be6ff..2f42a35f4634 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -159,7 +159,7 @@ all: fixdep
>
>  all_cmd: $(CMD_TARGETS) check
>
> -$(BPF_IN_SHARED): force elfdep bpfdep bpf_helper_defs.h
> +$(BPF_IN_SHARED): force elfdep bpfdep $(OUTPUT)bpf_helper_defs.h

btw, there is a lot of $(OUTPUT)bpf_helper_defs.h repetition, could
you please extract it into a variable, similar to BPF_IN_SHARED and
others? E.g., just BPF_HELPER_DEFS would work. Thanks!

>         @(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
>         (diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
>         echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
> @@ -177,12 +177,12 @@ $(BPF_IN_SHARED): force elfdep bpfdep bpf_helper_defs.h
>         echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
>         $(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"

[...]
