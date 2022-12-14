Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B804864D016
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiLNTa5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 14:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiLNTaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 14:30:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE05240A5
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 11:30:54 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v8so24058484edi.3
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAj/AUS9uDQOFWtQNLTyFQP3TjGhdZziIo7t6N/rw5M=;
        b=bZTgr1NwTkG4P5Gqu/VKJM1PPjy+syeeqrtkB39d2u7KBJjNM43V0C6smrDrr9HjWb
         THkcn8oskYoffzvRz5JpOJd90daQVr5Q3fJo1BSZWr/f3aF1QNhPoJV/0l7E11tidPoH
         8UyjTfEWegva6cSjCWCgNTEyiGX4zX8H7hdztRjf8UYyhdNVTiGz12kOWXi7CuuPshEm
         oY1HGwVUPxWmvmQlfcpbTqxrb7DDvWddf94XVxP+ktUF8/CqPlsD1R7FfLCIhSg0wlTF
         6qCWIej81EyII8NePrda1U/RO7AUP9PXDdFsJ9Z1pDHzEeO3mq7lLc+YGvdkTQepETpJ
         Rofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAj/AUS9uDQOFWtQNLTyFQP3TjGhdZziIo7t6N/rw5M=;
        b=8SHIuL26sKhVbWeg42NWu4jXFd8QhSXjmSeKBIFrupkEgyBajd44ZVfmTR+YGKAhje
         BNouIO2++IYkpV7OARVfEmgxeURDUqtDf0p5GzctpEQM93kohUH2Ru3jD0AgH7LQvBcY
         vSOa0yTW5syHj98dN+HX4G7Q242tN7z5KOR11gHvy2mItDTSl9rF+OShtZF8P7jtcN0/
         P9HD2t4BrPpgCTCkMGNeD5CujirfRFfzEnAgqULRqz90dJ5lmDdvHSY0AGW1Gjf2oxFO
         9yf8Z3QX9yq33BY1qdqbbRc6JnfjgtU8ye4RTHKli0/DdWrXvp/zH9kcpCDQ2fq3SKDJ
         obfA==
X-Gm-Message-State: ANoB5pknF2g3Cf8Y3Ka0rVMyi0jsoJmKxxWLbkdXI98U/eGlyVrRLDdE
        A9/3dR4IXx5/UUdy0MUJR2UofRhc/ucyflhcRhU=
X-Google-Smtp-Source: AA0mqf7MhRGnNalO7mgYq2FBCJ7VUJY6pQgDYVKhVJlqyh5JB/JvrjDNh6TBctqlc2yzwid2fbPpXVDPeSoGzXW/0+Q=
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id
 t33-20020a056402242100b00461524fa8f4mr87121606eda.260.1671046252834; Wed, 14
 Dec 2022 11:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20221214010046.668024-1-toke@redhat.com>
In-Reply-To: <20221214010046.668024-1-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Dec 2022 11:30:40 -0800
Message-ID: <CAEf4BzZOYD7YEgzWz08Q7sZ8wMVf+kiP7Aw1tm4_wN0_mNDrhA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix signedness confusion when using libbpf_is_mem_zeroed()
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
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

On Tue, Dec 13, 2022 at 5:01 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> The commit in the Fixes tag refactored the check for zeroed memory in
> libbpf_validate_opts() into a separate libbpf_is_mem_zeroed() function.
> This function has a 'len' argument of the signed 'ssize_t' type, which in
> both callers is computed by subtracting two unsigned size_t values from
> each other. In both subtractions, one of the values being subtracted is
> converted to 'ssize_t', while the other stays 'size_t'.
>
> The problem with this is that, because both sizes are the same
> rank ('ssize_t' is defined as 'long' and 'size_t' is 'unsigned long'), th=
e
> type of the mixed-sign arithmetic operation ends up being converted back =
to
> unsigned. This means it can underflow if the user-specified size in
> opts->sz is smaller than the size of the type as defined by libbpf. If th=
at
> happens, it will cause out-of-bounds reads in libbpf_is_mem_zeroed().

hmm... but libbpf_is_mem_zeroed expects signed ssize_t, so that
"underflow" will turn into a proper negative ssize_t value. What am I
missing? Seems to be working fine:

$ cat test.c
#include <stdio.h>

void testit(ssize_t sz)
{
        printf("%zd\n", sz);
}

int main()
{
        ssize_t slarge =3D 100;
        size_t ularge =3D 100;
        ssize_t ssmall =3D 50;
        size_t usmall =3D 50;

        testit(ssmall - slarge);
        testit(ssmall - ularge);
        testit(usmall - slarge);
        testit(usmall - ularge);
}

$ cc test.c && ./a.out
-50
-50
-50
-50


>
> To fix this, change libbpf_is_mem_zeroed() to take unsigned start and end
> offsets instead of a signed length. This avoids all casts between signed
> and unsigned types and should hopefully prevent a similar error from
> reappearing in the future.
>
> Fixes: 3ec84f4b1638 ("libbpf: Add bpf_cookie support to bpf_link_create()=
 API")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/lib/bpf/libbpf_internal.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 377642ff51fc..92375a86b15c 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -267,13 +267,14 @@ void *libbpf_add_mem(void **data, size_t *cap_cnt, =
size_t elem_sz,
>                      size_t cur_cnt, size_t max_cnt, size_t add_cnt);
>  int libbpf_ensure_mem(void **data, size_t *cap_cnt, size_t elem_sz, size=
_t need_cnt);
>
> -static inline bool libbpf_is_mem_zeroed(const char *p, ssize_t len)
> +static inline bool libbpf_is_mem_zeroed(const char *obj,
> +                                       size_t off_start, size_t off_end)
>  {
> -       while (len > 0) {
> +       const char *p;
> +
> +       for (p =3D obj + off_start; p < obj + off_end; p++) {
>                 if (*p)
>                         return false;
> -               p++;
> -               len--;
>         }
>         return true;
>  }
> @@ -286,7 +287,7 @@ static inline bool libbpf_validate_opts(const char *o=
pts,
>                 pr_warn("%s size (%zu) is too small\n", type_name, user_s=
z);
>                 return false;
>         }
> -       if (!libbpf_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts=
_sz)) {
> +       if (!libbpf_is_mem_zeroed(opts, opts_sz, user_sz)) {
>                 pr_warn("%s has non-zero extra bytes\n", type_name);
>                 return false;
>         }
> @@ -309,11 +310,10 @@ static inline bool libbpf_validate_opts(const char =
*opts,
>         } while (0)
>
>  #define OPTS_ZEROED(opts, last_nonzero_field)                           =
     \
> -({                                                                      =
     \
> -       ssize_t __off =3D offsetofend(typeof(*(opts)), last_nonzero_field=
);     \
> -       !(opts) || libbpf_is_mem_zeroed((const void *)opts + __off,      =
     \
> -                                       (opts)->sz - __off);             =
     \
> -})
> +       (!(opts) || libbpf_is_mem_zeroed((const void *)opts,             =
     \
> +                                        offsetofend(typeof(*(opts)),    =
     \
> +                                                    last_nonzero_field),=
     \
> +                                        (opts)->sz))
>
>  enum kern_feature_id {
>         /* v4.14: kernel support for program & map names. */
> --
> 2.38.1
>
