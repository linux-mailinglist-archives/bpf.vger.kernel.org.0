Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C15F5FB2
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 05:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJFDh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 23:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJFDh4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 23:37:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E9F7EFEA
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 20:37:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a13so1095421edj.0
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AECG9CTDeWJnEBPcHnDwufHM9I5Hzvj+jlt2ueysdDI=;
        b=HObtpq5SW3DD6zmYXdHaoJLJb8VVWW85a89S3od8h6YijoK32Lv80/YDoBqPIulubp
         L0YyXkHsINdbswA9nkDZ2zC74OMHYbtyY+PwFPSnCVnabUhjGoPgUM4eZ4T+XSNIFuE2
         xfwCKfh17UrX5Jp9ctQzM62mviSDWtqQypoeswFZ7nSpqsJZOJNkaH2NQ9CoBc4SXej9
         bynfKKDP9uvE/L9NUmzPj6YbDhSf4bvD3FoTNdW8LtjbzGreduISodWh70v/etlqA04p
         LLZ3aTtKBt4OHdNu6Gp0PPzB54qS+LdjqKqqgGXDFpd+CQ/En728Dn9V0tPy+4xTi3xq
         7wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AECG9CTDeWJnEBPcHnDwufHM9I5Hzvj+jlt2ueysdDI=;
        b=OueycgQNHLTa9KiMkiBHOjMW5jEJvSKfsy4Prw+ESn/Wa/Wi/jyDptHSmU3IlRYvT5
         0nD9CRU6hneU/2Mg0Bn1YPRqliwRCJ/GiC/tkGNk70vdho40+25ISdDlQhqoC4S3M7Sk
         Qz2IaVTqVt1rPj0wUO9Z4uD36AO9XC2qvEV72UYaJ8L5YbvmrxKvZbBl8izsKtfaxvaj
         K6Vao3P8gd4NtPjq0Lp8RgTKllbwhVU9jvckBtzjpprfokfMzh8LUhoPMA95Sy3IAtK6
         3vO3hxxFuSwhj4doXtc+8ON1pPoUQtxe+19Mdp2X6iUs2KkjggUsqV5IIFARw4FOpsCx
         frmQ==
X-Gm-Message-State: ACrzQf2JB0JNu0WDOjbxmnCTo8xf7O5Tks1Pg/DoogEhYzp0BlND+iUC
        ACEzk/Z/jJblqWt19VX32azI/c9frv0NamUYYP4=
X-Google-Smtp-Source: AMsMyM4YGlFXvsDbWLCeym0CopYwuEfB3TDdJCXgXOLCzq5SwqXVlt/EAErf+ZchU0Pad3PRB1oM3o7BcmoOpPJQUdI=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr2628871edv.232.1665027474136; Wed, 05
 Oct 2022 20:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221005180932.2278505-1-andrii@kernel.org> <20221006003654.dgjotl7vxpvpm53i@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20221006003654.dgjotl7vxpvpm53i@macbook-pro-4.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 20:37:42 -0700
Message-ID: <CAEf4BzbRvAiQhg4af0zZfWqTO+vxEgEj3DJT3buVjcqKyGg_Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: explicitly define BPF_FUNC_xxx integer values
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        timo@isovalent.com
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Quentin Monnet <quentin@isovalent.com>,
        Andrea Terzolo <andrea.terzolo@polito.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 5, 2022 at 5:37 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 05, 2022 at 11:09:32AM -0700, Andrii Nakryiko wrote:
> > Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
> > implicit sequential values being assigned by compiler. This is
> > convenient, as new BPF helpers are always added at the very end, but it
> > also has its downsides, some of them being:
> >
> >   - with over 200 helpers now it's very hard to know what's each helper's ID,
> >     which is often important to know when working with BPF assembly (e.g.,
> >     by dumping raw bpf assembly instructions with llvm-objdump -d
> >     command). it's possible to work around this by looking into vmlinux.h,
> >     dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
> >     bpf_helper_defs.h, etc. But it always feels like an unnecessary step
> >     and one should be able to quickly figure this out from UAPI header.
> >
> >   - when backporting and cherry-picking only some BPF helpers onto older
> >     kernels it's important to be able to skip some enum values for helpers
> >     that weren't backported, but preserve absolute integer IDs to keep BPF
> >     helper IDs stable so that BPF programs stay portable across upstream
> >     and backported kernels.
>
> I like the macro hack, but it doesn't really address the above goal.

Ok, cool, thanks for spotting these problems. I think we can fix them
pretty easily. I'll send v2 with bpf_doc.py updates.

> I tried:
> -       FN(map_delete_elem, 3, ##ctx)
>
> and got libbpf build error:
> Exception: Helper bpf_map_delete_elem is missing from enum bpf_func_id
>
> Then I tried to delete the comment describing map_delete_elem and got:
> Exception: Helper bpf_probe_read comment order (#3) must be aligned with its position (#4) in enum bpf_func_id
>
> So backporting process is a bit easier, but such uapi/bpf.h
> is unasable to build libbpf against.
> It's not a problem for github/libbpf, since it keeps bpf_helper_defs.h in the git,
> but still.
> Probably bpf_doc.py needs to get smarter.

Correct. And I'd still advocate to use Github version of libbpf for
building applications. But we do need to fix libbpf build in
backported kernel anyways because libbpf is used during kernel build
process itself.

>
> Maybe 2nd check in bpf_doc.py can be dropped?
> Meaning that the comments can now be made out-of-order?
> A good thing?
> I think we should probably still enforce the order in upstream kernel through code-review.

Yep, we should relax this check, I think. I'd still enforce that
helpers should be documented in correct order, it's just that enum
value != position in comment stream. I'll see how to adjust script to
accommodate that. This will handle both latest upstream and backport
case nicely.

>
> Also see cilium/ebpf/asm/func.go
> The change to FN() will break that hacky script, but it's an ok trade-off.

Yep, I think so too. And it should be very easy to fix up that script.
I've cc'ed Timo for heads up.
