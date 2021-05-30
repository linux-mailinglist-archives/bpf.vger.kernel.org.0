Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7B394EAE
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhE3AmI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 May 2021 20:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhE3AmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 May 2021 20:42:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD5FC061574;
        Sat, 29 May 2021 17:40:29 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p184so11082695yba.11;
        Sat, 29 May 2021 17:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+QLZNDdFIlxF7UzDUY6YTc7hx2a7m+YGBRUhRmiWLE=;
        b=Dv81vMWt0sqzezDkVJcdxUSiwY8ViWsXCunQHqu/HOHMkXttb+3BN0xOo099nc90QG
         E9aqLdAA9tI4wqgfg1Ap5q3LmOfHah5/oGmVGxH48KG/P544eCzuK3HinHdhpvKM0KJb
         qY5wwIPtrIRw7+ucXw0vmvGd6dIsX0aNUBo/xoc9sNvZE6DTj85cw/Jqgn4a31sz1hJb
         bd6ShSCpsaez4ZZqfOM4ceAqDohzxdsWjN6h+u0+Fon1iiK8qzVF5O0GojlbtnwwztNY
         enoTv/Nfr+NqDvXhqEJbwwRXuFLSITjdqx7FUcxsahd8QMVAkQwchcqmHTXVQsRzwCTU
         jc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+QLZNDdFIlxF7UzDUY6YTc7hx2a7m+YGBRUhRmiWLE=;
        b=s62UhHeY3xgQQ0oZeciCqVYsqJqjH1vy2b+A/MKmWL3euUKCsY60F+DHQ/0apFhjcn
         pRwEnKi7Lbq3bpmY4XOBB6hbU2Q3z01PETssScgHGTIEFyk8Mn+gfNAGtF/uPrKMqojz
         wxoTc235VSLuq2O/hQ37jsnoD5aFDZF0H63OTMbwLCecUB4oPj0OXmdX751DQDzGuLyv
         gD3NuFTOPbKUOrfwe8jncEQPUjXnKkn5nZltYNJRA3MX6kjKJOr+pK4Jle6EJ4AsgCjf
         whmUIAfaZwFFx7zGXmfBrF3ODm9whHAXSekQgNMh2rtNPyQNiXxB2mAZbxBg0bUL89Lt
         Xiew==
X-Gm-Message-State: AOAM532DbJ1KskM2nHaUOdpq6Jx6uFAnQRwLLGR63tRNxNxqq4/qYlvZ
        l+KzQiT+BTObFBbXiu+WJX905jJK781lx0wchTg=
X-Google-Smtp-Source: ABdhPJx6lqqfyTEsze5wehDuyxE1+npbADRpDrlXF7hY7JJ/93ImQDbZ8sMwC/Au7OcyCbWsAhHdjU7e3qyLNfGk8v8=
X-Received: by 2002:a25:4182:: with SMTP id o124mr3363739yba.27.1622335228185;
 Sat, 29 May 2021 17:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com> <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com> <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
In-Reply-To: <YLFIW9fd9ZqbR3B9@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 29 May 2021 17:40:17 -0700
Message-ID: <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
Subject: Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 28, 2021 at 12:45 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, May 27, 2021 at 01:41:13PM -0700, Andrii Nakryiko escreveu:
> > On Thu, May 27, 2021 at 12:57 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
> > > On May 27, 2021 4:14:17 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > >If we make 1.22 mandatory there will be no good reason to make 1.23
> > > >mandatory again. So I will have absolutely no inclination to work on
> > > >this, for example. So we are just wasting a chance to clean up the
> > > >Kbuild story w.r.t. pahole. And we are talking about just a few days
> > > >at most, while we do have a reasonable work around on the kernel side.
>
> > > So there were patches for stop using objcopy, which we thought could
> > > uncover some can of worms, were there patches for the detached BTF
> > > file?
>
> > No, there weren't, if I remember correctly. What's the concern,
> > though? That detached BTF file isn't even an ELF, so it's
> > btf__get_raw_data() and write it to the file. Done.
>
> See patch below, lightly tested, now working on making pahole accept raw
> BTF files out of /sys/kernel/btf/
>
> Please test, and if works as expected, try to bolt this into the kbuild
> process, as intended.

So while looking through this I found --skip_encoding_btf_vars and I
just sent a fix to disable per-CPU var BTF generation for versions
1.18 through 1.21. I think that's a better solution than all the
previously proposed ones. But it also means we have no good reason to
force 1.22+ as minimal version.

But in either case, this is good feature and will definitely be useful
going forward. See my comments below.

>
> - Arnaldo
>
> commit b579a18a1ea0ee84b90b5302f597dda2edf2f61b
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri May 28 16:41:30 2021 -0300
>
>     pahole: Allow encoding BTF into a detached file
>
>     Previously the newly encoded BTF info was stored into a ELF section in
>     the file where the DWARF info was obtained, but it is useful to just
>     dump it into a separate file, do it.
>
>     Requested-by: Andrii Nakryiko <andrii@kernel.org>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>

Looks good, see few minor comments below. At some point it probably
would make sense to formalize "btf_encoder" as a struct with its own
state instead of passing in multiple variables. It would probably also
allow to parallelize BTF generation, where each CU would proceed in
parallel generating local BTF, and then the final pass would merge and
dedup BTFs. Currently reading and processing DWARF is the slowest part
of the DWARF-to-BTF conversion, parallelization and maybe some other
optimization seems like the only way to speed the process up.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/btf_encoder.c b/btf_encoder.c
> index 033c927b537dad1e..bc3ac72968cea826 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -21,6 +21,14 @@
>  #include <stdlib.h> /* for qsort() and bsearch() */
>  #include <inttypes.h>
>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +#include <unistd.h>
> +
> +#include <errno.h>
> +
>  /*
>   * This corresponds to the same macro defined in
>   * include/linux/kallsyms.h
> @@ -267,14 +275,62 @@ static struct btf_elf *btfe;
>  static uint32_t array_index_id;
>  static bool has_index_type;
>
> -int btf_encoder__encode()
> +static int btf_encoder__dump(struct btf *btf, const char *filename)
> +{
> +       uint32_t raw_btf_size;
> +       const void *raw_btf_data;
> +       int fd, err;
> +
> +       /* Empty file, nothing to do, so... done! */
> +       if (btf__get_nr_types(btf) == 0)
> +               return 0;
> +
> +       if (btf__dedup(btf, NULL, NULL)) {
> +               fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
> +               return -1;
> +       }
> +
> +       raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> +       if (raw_btf_data == NULL) {
> +                fprintf(stderr, "%s: btf__get_raw_data failed!\n", __func__);

indentation seems off here and in few places below

> +               return -1;
> +       }
> +
> +       fd = open(filename, O_WRONLY | O_CREAT);
> +       if (fd < 0) {
> +                fprintf(stderr, "%s: Couldn't open %s for writing the raw BTF info: %s\n", __func__, filename, strerror(errno));
> +               return -1;
> +       }
> +       err = write(fd, raw_btf_data, raw_btf_size);
> +       if (err < 0)
> +                fprintf(stderr, "%s: Couldn't open %s for writing the raw BTF info: %s\n", __func__, filename, strerror(errno));

nit: copy-pasted error message is wrong

> +
> +       close(fd);
> +
> +       if (err != raw_btf_size) {
> +                fprintf(stderr, "%s: Could only write %d bytes to %s of raw BTF info out of %d, aborting\n", __func__, err, filename, raw_btf_size);
> +               unlink(filename);
> +               err = -1;
> +       } else {
> +               /* go from bytes written == raw_btf_size to an indication that all went fine */
> +               err = 0;
> +       }
> +
> +       return err;
> +}
> +

[...]
