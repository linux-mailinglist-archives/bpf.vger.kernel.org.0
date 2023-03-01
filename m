Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C466A73F1
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCATCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCATCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:02:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D015148
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 11:02:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o15so55544531edr.13
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677697358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ppR2qhAb+JM5mcRnFqgag+CiTzBE1+fikRg9uZSOes=;
        b=FHPy0U3IPvRdOdfnT2GAjMippmcwVhcvqUcf4dMmeCyEHkm43INKt0+C/xiQ6DEQE/
         FlNvNruvURpxs7yEMV6mzQduAU1jjnirvaQ1YZdAE6oRBg26AIa83V2ee1N+RGxS6AKd
         iNQFKGYzdgdVRV1bvssBOlIOhnIFVpervqJryh09yPrY4JWKfnhqK/HjrfMQKWQOsna+
         2zWufjVRzh6/8T3JGRkyjZpHUtVTxvKZ8vQ8MGJoVUa6I+8aVL1f12plCAv2FZzQIVOb
         H2jq4uQQjIs6jTCvYbaHrb4Cv99DSeD/63Bpg1e5OKOBTSYriXeYM6z/wzPwojCWu5ng
         zZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677697358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ppR2qhAb+JM5mcRnFqgag+CiTzBE1+fikRg9uZSOes=;
        b=A6IW2qNBI2Aztcpmw1+adZBupUtOeb0pZeMlJiRbd7duDc7B8IhqQQUmxRTZZ3pzWc
         Jk8cr1f6vBjBAAg1Pk0B2TdA0HCS89qJPwug1A6qZcyLHqy7AWDsuwCjR41llsB1uF5b
         5UsbsTDtN8lsC3NFFvUwq6tYhO5SRFu35jFA4M+QWIm557kYN1xsb9AtVa5fPKTh+6Oa
         uhf4mtgIO571JlXi52NsUmU//OH39kIhqag7ICAoQaFKpYhdVblqePGxofXLOdWKFRLz
         itfZS9MZlCOfkpBXbPJD+1BcMhCy4ekLabM53W7uxpwWFrzm5AEp+I/W2WQJDFTygX4E
         sNQg==
X-Gm-Message-State: AO0yUKXCyagQXlaZ4vhHKsHsjZb8Ul9A0gy9wGVK97ctKksz+5S4wl05
        tveJmQ2+OL3eVCSiMfKYgoNBRAPdVvEddUznM4E=
X-Google-Smtp-Source: AK7set/bOM4m7jb9CYEYLLIFwIaubWA/MX+0urBf4nrOrzepyD3PMLLvZwsirEZ4r8nlYamPxWqSQ7LvmcL5wwwF74g=
X-Received: by 2002:a17:906:720e:b0:8de:c6a6:5134 with SMTP id
 m14-20020a170906720e00b008dec6a65134mr3467401ejk.15.1677697358237; Wed, 01
 Mar 2023 11:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20230228142531.439324-1-9erthalion6@gmail.com>
In-Reply-To: <20230228142531.439324-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Mar 2023 11:02:25 -0800
Message-ID: <CAEf4BzYz5dmJBzTuEvihDqjYyWqUcQE6YLUH1WdC_RDifu7FpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Use text error for btf_custom_path failures
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 6:26=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Use libbpf_strerror_r to expand the error when failed to parse the btf
> file at btf_custom_path. It does not change a lot locally, but since the
> error will bubble up through a few layers, it may become quite
> confusing otherwise. As an example here is what happens when the file
> indicated via btf_custom_path does not exist and the caller uses
> strerror as well:
>
>     libbpf: failed to parse target BTF: -2
>     libbpf: failed to perform CO-RE relocations: -2
>     libbpf: failed to load object 'bpf_probe'
>     libbpf: failed to load BPF skeleton 'bpf_probe': -2
>     [caller]: failed to load BPF object (errno: 2 | message: No such file=
 or directory)
>
> In this context "No such file or directory" could be easily
> misinterpreted as belonging to some other part of loading process, e.g.
> the BPF object itself. With this change it would look a bit better:
>
>     libbpf: failed to parse target BTF: No such file or directory
>     libbpf: failed to perform CO-RE relocations: -2
>     libbpf: failed to load object 'bpf_probe'
>     libbpf: failed to load BPF skeleton 'bpf_probe': -2
>     [caller]: failed to load BPF object (errno: 2 | message: No such file=
 or directory)
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---

I find these text-only error messages more harmful, actually. Very
often their literal meaning is confusing, and instead the process is
to guess what's -Exxx error they represent, and go from there.

Recently me and Quentin discussed moving towards an approach where
we'd log both symbolic error value (-EPERM instead of -1) and also
human-readable text message. So I'd prefer us figuring out how to do
this ergonomically in libbpf and bpftool code base, and start moving
in that direction.

>  tools/lib/bpf/libbpf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 05c4db355f28..02a47552ad14 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5683,7 +5683,10 @@ bpf_object__relocate_core(struct bpf_object *obj, =
const char *targ_btf_path)
>                 obj->btf_vmlinux_override =3D btf__parse(targ_btf_path, N=
ULL);
>                 err =3D libbpf_get_error(obj->btf_vmlinux_override);
>                 if (err) {
> -                       pr_warn("failed to parse target BTF: %d\n", err);
> +                       char *cp, errmsg[STRERR_BUFSIZE];
> +
> +                       cp =3D libbpf_strerror_r(err, errmsg, sizeof(errm=
sg));
> +                       pr_warn("failed to parse target BTF: %s\n", cp);
>                         return err;
>                 }
>         }
> --
> 2.31.1
>
