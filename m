Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31885847FB
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 00:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiG1WLN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 18:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiG1WLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 18:11:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A6328715;
        Thu, 28 Jul 2022 15:11:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so5373165eju.10;
        Thu, 28 Jul 2022 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WHDO6VegvmCbpcvdu9GkyCSavGLPepAIPCu9N4+1D9k=;
        b=C+AdNgpndlAqT1YWQ88biNbXLw5UVcaaMGXaetVij/eBX95My1XNx0SReUiFBjpr6K
         6Vbuu+z7XBppeY7r+VMWOutYFQzhPk/Zh6CaFXljReyxtmgdb7q8hwtjQmhhJecbkCH3
         XgK6u65WvYOLMU6CzotK65mHlX0Psh9zQ8dxPbAkx33LPQ1WzsGzviC5UtMPD1OzhJh2
         q4zvsUAF3HuylO/+nei4x8TCFhjsLbpYACLYBHhoynkmCGCbSWwdpCL4eCaAUfarpz45
         KBHv9ZvFz5wtzrEbdd6XP6JkJ+p0fGLqgdGQxIDTZlqc/0ZTU5UrywfPPV7fCdLL4Qt/
         0q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WHDO6VegvmCbpcvdu9GkyCSavGLPepAIPCu9N4+1D9k=;
        b=BDs47Hlqm7HkpfvBcEsSb1eeJ6kAC9ZU4ykTp+4+uXH+z6q32ci/X0JjzwDQ7wjDh3
         3S36le+It2+eSj2gBeZICFip2nuQ6dc3P11cSx7ZPm62SYSkxuFC0A62iraEc/gJ3epI
         KWv4MTgWvr4bbsoXS1BDu9ficXCDNVUmHQAgvMmY4VxaaPl85R1zk5nd+cjxMfSiL44p
         7g5xHjdI5SW72i1Y1Kpv/pF5Jbnh3WgVjKY4p2VYFbM6bmrjTv5e/TFlEnXsVyXFDtPz
         G5JIwiXXOLoh+KPkLU0+O9K7JWWvny1shm3YhdFkK30haKU42GLztzoiyJT1cGOaZNVf
         7a1g==
X-Gm-Message-State: AJIora+foCwT3dnQMmtkwblIKL/3UNiZwK8uBCDXWsc5teaNHRRrXht5
        IQBD5+xyZKyhV4qc8jCCz5dDJ70uVq3Wi4yAMmM=
X-Google-Smtp-Source: AGRyM1vhJfYvaLqFgXtV4wzdkzBl35oMohiGUu7zcQUs3ZpA7w/A4eV6IRslqa0bj7XwXZAxcfLMM2vZJzFwsW57dZM=
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id
 hg12-20020a1709072ccc00b0072b6907fce6mr703919ejc.115.1659046268498; Thu, 28
 Jul 2022 15:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <YtZ+/dAA195d99ak@kili> <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
 <CAADnVQLS=asNdrmdK-jgW4AZmJih00OTvXZg_RA55wLY=bHMZg@mail.gmail.com> <46ca78ec-17b5-3cf1-a42d-7659563c6cf7@oracle.com>
In-Reply-To: <46ca78ec-17b5-3cf1-a42d-7659563c6cf7@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Jul 2022 15:10:57 -0700
Message-ID: <CAEf4BzbmoZH_04sA5GjQfFBB9XryYJwWXAMtA3EK9CiWGQ8+rQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 12:48 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 19/07/2022 18:51, Alexei Starovoitov wrote:
> > On Tue, Jul 19, 2022 at 10:19 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >>
> >> On Tue, Jul 19, 2022 at 12:53:01PM +0300, Dan Carpenter wrote:
> >>> The return from strcmp() is inverted so the it returns true instead
> >>> of false and vise versa.
> >>>
> >>> Fixes: a1c9d61b19cb ("libbpf: Improve library identification for uprobe binary path resolution")
> >>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>> ---
> >>> Spotted during review.  *cmp() functions should always have a comparison
> >>> to zero.
> >>>       if (strcmp(a, b) < 0) {  <-- means a < b
> >>>       if (strcmp(a, b) >= 0) { <-- means a >= b
> >>>       if (strcmp(a, b) != 0) { <-- means a != b
> >>> etc.
> >>>
> >>>  tools/lib/bpf/libbpf_internal.h | 6 +++---
> >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> >>> index 9cd7829cbe41..008485296a29 100644
> >>> --- a/tools/lib/bpf/libbpf_internal.h
> >>> +++ b/tools/lib/bpf/libbpf_internal.h
> >>> @@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
> >>>       size_t str_len = strlen(str);
> >>>       size_t sfx_len = strlen(sfx);
> >>>
> >>> -     if (sfx_len <= str_len)
> >>> -             return strcmp(str + str_len - sfx_len, sfx);
> >>> -     return false;
> >>> +     if (sfx_len > str_len)
> >>> +             return false;
> >>> +     return strcmp(str + str_len - sfx_len, sfx) == 0;
> >> Please tag the subject with "bpf" next time.
> >>
> >> Acked-by: Martin KaFai Lau <kafai@fb.com>
> >
> > Alan,
> >
> > If it was so broken how did it work earlier?
> > Do we have a test for this?
> >
>
> We have tests for automatic path determination, yes, but those
> tests specify libc.so.6, so are testing the strstr(file, ".so.")
> predicate below:
>
>         if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
>
> Problem is, on many systems, libc.so is a GNU ld script rather
> than an actual library:
>
> cat /usr/lib64/libc.so
> /* GNU ld script
>    Use the shared library, but some functions are only in
>    the static library, so try that secondarily.  */
> OUTPUT_FORMAT(elf64-x86-64)
> GROUP ( /lib64/libc.so.6 /usr/lib64/libc_nonshared.a  AS_NEEDED ( /lib64/ld-linux-x86-64.so.2 ) )
>
> ...so we can't rely on system library .so files actually containing
> the library to instrument.
>
> Maybe we can do something with liburandom_read.so now we have it
> there; I was looking at extending the auto-path determination
> to usdt too, so we could add a new test to cover this then I think.

Library path resolution should already work for USDTs (note that I
reuse resolve_full_path() in bpf_program__attach_usdt()), but having
explicit tests would be great. It might be simplest to temporarily
override LD_LIBRARY_PATH with a path to liburandom_read.so? So please
consider sending a patch with tests, thanks!

>
> Alan
