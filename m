Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310785258DB
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359713AbiEMAIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 20:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEMAIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 20:08:42 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41119273F44
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:08:41 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id 63so2607255uaw.10
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kk8tlPTdr9wmQlxn4uNlZZ3gf8/QugkdKYrakb5b8M4=;
        b=evoR07Ttrm1P7jNw95WXqBzEbxjLN2Oho5VYCZuNvTMpQG/a1m8TVhXrDuFttJTaq2
         e+jiFuStJ1SbkS9PzKV742TnGZt80487u/BcsA+B3SPOaMZSbVRZuiV2lyZHGN//lCCG
         23gsiRlOcf7cgth+KEFynaMtHjRr/9NMGlxix2+8EQjFqoxEtwNzeIm9upu4r8oBEhOH
         oVnTGBxQ+tpM5xOYwE+b39c0JL2yOXKU1dHBD76kzOhx7UXg7krX2cg4Azo4R5DXcxpp
         j2d2fUnwp61IMqBnsWDVlLMtvQcESGvqJ0FixqEHkRrtFtRKx2dk6HkN9bPR3yt9sLar
         P1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kk8tlPTdr9wmQlxn4uNlZZ3gf8/QugkdKYrakb5b8M4=;
        b=lqWEvxtBh76RmKBgvZExMPPAjOGIV63k8dUBJcwzDmVf43QMX2OO7HOEX1HYBi+EwI
         nKMxUTlaTVOA+HeTZY6A3w8O5YfJeJkbkDxnv4r39pp0fG2ZyyvsqJqTXGwpPfZCGwmB
         guKZn+79UfXU6XGea7/yL8KOZfcyT6IXQjDXGI/aw1LtDZxy2xpJqqdz+Sia0r3ANS7U
         8jkSipJygibR/jY8OWGf7uUp+KRtMaWmviFKo9HaW6hFP48iI6bwjtyHDYNaG25vuyQn
         EVioJgTkap8lKlQq4hIkE2jgqyXpE6xS53KrNE6yqK7hTdGmJNH0zphXoG2QHVsDKAam
         33Qw==
X-Gm-Message-State: AOAM5311lkwIyryol+occz9+FjC0MhEvhxgV+ZxsgxAwayJYj3nGHJ2c
        +VGBTxF3xt06w7eEYkfqBNSiCnh9RhMPrNwdsqg=
X-Google-Smtp-Source: ABdhPJzc8P0x31HHwdpB13Adycr5T5i3HmKYkyEwgZdhVjoljkA0bw5uhP9iIQWd497Nge80wZZY3NCWh7Xch8XU8xY=
X-Received: by 2002:ab0:5387:0:b0:35f:d5e8:d22c with SMTP id
 k7-20020ab05387000000b0035fd5e8d22cmr1417987uaa.11.1652400520328; Thu, 12 May
 2022 17:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220512234332.2852918-1-deso@posteo.net>
In-Reply-To: <20220512234332.2852918-1-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 17:08:29 -0700
Message-ID: <CAEf4BzZ0q9Avxie9oAFi0M6s93P85OX7c7rpd1GZjvfwnCJV6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Hardcode /sys/kernel/btf/vmlinux
 in fewer places
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 4:44 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> Two of the BPF selftests hardcode the path to /sys/kernel/btf/vmlinux.
> The kernel image could potentially exist at a different location.
> libbpf_find_kernel_btf(), as introduced by commit fb2426ad00b1 ("libbpf:
> Expose bpf_find_kernel_btf as a LIBBPF_API"), knows about said
> locations.
>
> This change switches these two tests over to using this function
> instead, making the tests more likely to be runnable when
> /sys/kernel/btf/vmlinux may not be present and setting better precedent.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/testing/selftests/bpf/prog_tests/libbpf_probes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/too=
ls/testing/selftests/bpf/prog_tests/libbpf_probes.c
> index 9f766dd..61c81a9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> @@ -11,8 +11,8 @@ void test_libbpf_probe_prog_types(void)
>         const struct btf_enum *e;
>         int i, n, id;
>
> -       btf =3D btf__parse("/sys/kernel/btf/vmlinux", NULL);

Selftests go hand in hand with kernel and generally assume specific
kernel features enabled (like BTF and sysfs) and having very recent
(if not latest) kernel. So there is nothing bad about loading
/sys/kernel/btf/vmlinux, I think, it's actually more straightforward
to follow the code when it is used explicitly. Libbpf's logic for
finding kernel BTF in other places is for older systems. So I'd leave
it as is.

> -       if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +       btf =3D libbpf_find_kernel_btf();
> +       if (!ASSERT_OK_PTR(btf, "libbpf_find_kernel_btf"))
>                 return;
>
>         /* find enum bpf_prog_type and enumerate each value */
> @@ -49,8 +49,8 @@ void test_libbpf_probe_map_types(void)
>         const struct btf_enum *e;
>         int i, n, id;
>
> -       btf =3D btf__parse("/sys/kernel/btf/vmlinux", NULL);
> -       if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +       btf =3D libbpf_find_kernel_btf();
> +       if (!ASSERT_OK_PTR(btf, "libbpf_find_kernel_btf"))
>                 return;
>
>         /* find enum bpf_map_type and enumerate each value */
> --
> 2.30.2
>
