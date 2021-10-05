Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3F421B5C
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 03:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhJEBCQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 21:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhJEBCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Oct 2021 21:02:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C856613AC
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 01:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633395626;
        bh=rp21O60UYE997DVUvkT3TldnnC2zBF9x5e4nRap9kuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UvVtaulvj7/joaFDeTBAV+PylmhLtNcSFVr2F0oDzzJLB/mEEOXLFNVcHQ6wXqwcU
         NrUmhJZ/KevNQ06tTQT2ciWJYbKFeyhlVipUcHJnnYxC7C4MRQYiVzTa8ntB5SvRqi
         80Evxq50Yb8xzl8/8qO9b5BlqVjKJaNO/Gsytsw/IQ0sxLoc62azmk09Q78nodEPij
         R8D4mUDf7yHfxl52CJOXCwGhR71gtEPVqJVBNz9xbV0N2THu8h5TLUT/vL7zJxWbwO
         JZhSx5FkT4TTNn3+vc0hI4BTuynmxT8ouDEHmU30MCLcZLK45H3QPQXlVsQmo5k2ln
         D56Ai/Pg+AJog==
Received: by mail-lf1-f47.google.com with SMTP id y26so79461630lfa.11
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 18:00:25 -0700 (PDT)
X-Gm-Message-State: AOAM5333/67GXo1qQUoTk7gvgWeGHxysVcHxk0ALrS+zqu4ZQCz5G07i
        qkX5IUDjePXTAybJbz5WfZ+m23njuHpdx/noVJU=
X-Google-Smtp-Source: ABdhPJzFm9XjQY7rnKIWvoNVrFBw7LpmDeB9S+qsyHNja9cyAztBfVqcrX9ZWWIWTSZJJ10JYBl5bi2ORGVAHxqza6U=
X-Received: by 2002:a05:6512:1052:: with SMTP id c18mr315176lfb.223.1633395624373;
 Mon, 04 Oct 2021 18:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211004215644.497327-1-grantseltzer@gmail.com>
In-Reply-To: <20211004215644.497327-1-grantseltzer@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 4 Oct 2021 18:00:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6MZ8-iHd95OLjV-xZCiq8m=satUjqHOhcoh1PENcL5=g@mail.gmail.com>
Message-ID: <CAPhsuW6MZ8-iHd95OLjV-xZCiq8m=satUjqHOhcoh1PENcL5=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add API documentation convention guidelines
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 4, 2021 at 4:51 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds a section to the documentation for libbpf
> naming convention which describes how to document
> API features in libbpf, specifically the format of
> which API doc comments need to conform to.
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  .../bpf/libbpf/libbpf_naming_convention.rst   | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> index 9c68d5014ff1..5f42f172987a 100644
> --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> @@ -150,6 +150,46 @@ mirror of the mainline's version of libbpf for a stand-alone build.
>  However, all changes to libbpf's code base must be upstreamed through
>  the mainline kernel tree.
>
> +
> +API documentation convention
> +============================
> +
> +The libbpf API is documented via comments above definitions in
> +header files. These comments can be rendered by doxygen and sphinx
> +for well organized html output. This section describes the
> +convention in which these comments should be formated.
> +
> +Here is an example from btf.h:
> +
> +.. code-block:: c
> +
> +        /**
> +        * @brief **btf__new()** creates a new instance of a BTF object from the raw
> +        * bytes of an ELF's BTF section
> +        * @param data raw bytes
> +        * @param size number of bytes passed in `data`
> +        * @return new BTF object instance which has to be eventually freed with
> +        * **btf__free()**
> +        *
> +        * On error, error-code-encoded-as-pointer is returned, not a NULL. To extract
> +        * error code from such a pointer `libbpf_get_error()` should be used. If
> +        * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL is
> +        * returned on error instead. In both cases thread-local `errno` variable is
> +        * always set to error code as well.
> +        */
> +
> +The comment must start with a block comment of the form '/**'.
> +
> +The documentation always starts with a @brief directive. This line is a short
> +description about this API. It starts with the name of the API, denoted in bold
> +like so: **api_name**. Please include an open and close parenthesis if this is a
> +function. Follow with the short description of the API. A longer form description
> +can be added below the last directive, at the bottom of the comment.
> +
> +Parameters are denoted with the @param directive, there should be one for each
> +parameter. If this is a function with a non-void return, use the @return directive
> +to document it.
> +
>  License
>  -------------------
>
> --
> 2.31.1
>
