Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14EA43AAFD
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 06:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhJZEOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJZEOT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 00:14:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DFBC061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:11:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i65so30698684ybb.2
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIK9S3lqhapmhIUnkJLY2DJdo1Cj67KelLuQUYOagP0=;
        b=IdHdYO/upvXMYjtPYjp7rT46b/FqlLtvrSWLgn23WO+WAn+gOj9h2VA909eyL4XxZV
         7js4VF8d9YVgXWDZ+rbOgOqdauzMarrmMTzFJYx4IUJuz4nOfrI6hl6FuKf6RtFoSFmj
         F1F4YjOd54gF3s8lCLoKW5hr14fWmL6+P0kD8n5M1JgsUhKS0TEGln+KEwMHmlfN/yqP
         Yvbn6J05i3NnvypQuX2d8FHBryNKo5MJbdYhPXk4a6J9X9HgrlLFXT9Pb4V49K1mDdJ4
         yFf1ESAGBYS8PJP1rCykCY3p6yxqsnCm2pFxxzSaelRRkKpXfrRGK6AQrK3QiUXbsikx
         4mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIK9S3lqhapmhIUnkJLY2DJdo1Cj67KelLuQUYOagP0=;
        b=Vpx72j6VMn4YB9iOnMnHa8yStNw6jUFW0mKbnHyS2lny6LkOcykFttbqbTEu5qpb+p
         oV3qeK44cQ83si6UC5yYSoPRbSI36fVrR6iJUJK2gv8IaVqh5xlXM1fix4wTGxOC0iRs
         /xACcQL3aYpMEBlx+XQKfMQHFF0OsEyS4seWr1Q9e8oCIpnwRA5DLMu2kuQfmi80UuUT
         dLxIpp1VIJPn1d7TEqeTG0ItUjRMFseV0bdTABoVHo16EfvSVEBNUbDWrkpmoUbPZuYs
         7T3EOhr14QGI3Wtz0euxWlBuUeBYOGv3UztN9A4YYvPQsAysL9C0YNgBhcS4Oovo0272
         fHWQ==
X-Gm-Message-State: AOAM531AoHcZ/q+327N6tvLo6Mtw9TU4OG2RrYLMuoBL5MMECGRDNxc/
        xfr9tUSMXBA7aYUWmFGs3up2av1ZzQug4SOpy+jsQ8TTff0=
X-Google-Smtp-Source: ABdhPJyqx0zl3NGtzPg+k9q/r7V5gWY3cafYzxNDFwbPPR3uyGS9D0yJ9fuqB7Ham2z5GatNA8aAJBVIT8BKlCKN/cs=
X-Received: by 2002:a05:6902:701:: with SMTP id k1mr11843078ybt.225.1635221515620;
 Mon, 25 Oct 2021 21:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211025223345.2136168-1-fallentree@fb.com> <20211025223345.2136168-4-fallentree@fb.com>
In-Reply-To: <20211025223345.2136168-4-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 21:11:44 -0700
Message-ID: <CAEf4BzZUT+Y5_Aw-y9J1-C_B_vp4Gbza_CnsqRdLDWxuu3FAMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: fix attach_probe in parallel mode
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 3:33 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch makes attach_probe uses its own method as attach point,
> avoiding conflict with other tests like bpf_cookie.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/attach_probe.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 6c511dcd1465..d0bd51eb23c8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -5,6 +5,11 @@
>  /* this is how USDT semaphore is actually defined, except volatile modifier */
>  volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
>
> +/* attach point */
> +static void method(void) {

{ on separate line


let's also mark it as noinline just in case


> +       return ;

unnecessary return (also extra space before semicolon)

> +}
> +
>  void test_attach_probe(void)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> @@ -33,7 +38,7 @@ void test_attach_probe(void)
>         if (CHECK(base_addr < 0, "get_base_addr",
>                   "failed to find base addr: %zd", base_addr))
>                 return;
> -       uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
> +       uprobe_offset = get_uprobe_offset(&method, base_addr);
>
>         ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
>         if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
> @@ -98,7 +103,7 @@ void test_attach_probe(void)
>                 goto cleanup;
>
>         /* trigger & validate uprobe & uretprobe */
> -       get_base_addr();
> +       method();
>
>         if (CHECK(skel->bss->uprobe_res != 3, "check_uprobe_res",
>                   "wrong uprobe res: %d\n", skel->bss->uprobe_res))
> --
> 2.30.2
>
