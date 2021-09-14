Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FE40A4D8
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 05:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhINDrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 23:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbhINDrV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 23:47:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F0C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 20:46:05 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a93so25165886ybi.1
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOelykSEjBbOw3qDPbl78Y+Bn+ul9tsE/CzBphKYRkg=;
        b=MxTQucixwPzDh88yU/Q5n1jxKmNknYwmEC+tMvv4v1LlqIshiC4oOieLvoz5Jylnrj
         ak/21n0PCw63pI2r8f0XWaqUF8da9fGrbw0krcOodh0+OtmfAwdviri6KXzPotUqcs22
         yW60jalCujc6apHpUXVlr5/y8I6TgvIgHZMm+sJ96FFFHshrHmzIQxpAI8tp2vK2+T85
         4L9JUgx/WM6enpdlb2CiUDxn5KdLZya3lFSUucMBHKK0nbQYq1AWU3lxIREn7iNtJtVR
         jZPcqLyKOPNpVaIdYLzprQ7B3QKpP0Avr89Bni87qCj62iTVb6/ISgYyZy5uRoTEQG5Q
         Asxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOelykSEjBbOw3qDPbl78Y+Bn+ul9tsE/CzBphKYRkg=;
        b=FMnFYw4yFODvpjHRtYlZeJksR4cW5OXQUH00waINB17muYWeLdRbOunmIPe6eufXEf
         RYzARiC3/EiYyPi62IANiLJHccjt8tc/EL/4SAoT8wQcjYwFRoHfuqwU7iOLj4UPFnNa
         C8oh3gJ01B5C+C5uZJY6XlwFFpfUmclx3SqtIJT4regRB6djN1YZ/NGZFLTrinPfusmn
         31kHQF3m83KhlvyCtGSNjzh6KhCWUqluXz9QRdWBhsnqbMsKajUrGyqtB7fPPXWIf5mC
         Et95+J4c0KQJ2UQzFof+PMOLoPgL3as8CyDGXJTgkcj/6/LWvXeo0fkyjV82nHW4GxoJ
         ag8w==
X-Gm-Message-State: AOAM533RRqFO+cWrHAkdaIAJnJOGpLas+HcM7ybaovb3RSIJLfjvK6j4
        80GA1ZDdVn1tkAaVgE7s80kF+fykt0UoV3biuOwvljTZ
X-Google-Smtp-Source: ABdhPJxmPUBl9WSC27es3msQk+uWybr5vIW6mNmka8W9von9VPPDaTSuzteWsr0n2BvgvWjD/wI9Ya7uGGdDFZevx7M=
X-Received: by 2002:a5b:408:: with SMTP id m8mr20111885ybp.2.1631591164257;
 Mon, 13 Sep 2021 20:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210909204312.197814-1-grantseltzer@gmail.com>
In-Reply-To: <20210909204312.197814-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 20:45:53 -0700
Message-ID: <CAEf4BzZQi9QTRaZgvn7ip=DcoCL2qgeQBAjOTptnZ+3_kOPxHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add sphinx code documentation comments
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 9, 2021 at 1:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds comments above five functions in btf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/btf.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>

It's nice that you provided a test instance of readthedocs.io site, it
made it much easier to look at how all this is rendered. Thanks!

I'm no technical writer, but left some thoughts below. It would be
great to get more help documenting all the APIs and important libbpf
objects from people that are good at succinctly explaining concepts.
This is a great start!

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4a711f990904..f928e57c238c 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -30,11 +30,47 @@ enum btf_endianness {
>         BTF_BIG_ENDIAN = 1,
>  };
>
> +/**
> + * @brief **btf__free** frees all data of the BTF representation

I'd like to propose that we add () for all functions, I've been
roughly following this convention throughout commit messages and
comments in the code, I think it's makes it a bit clearer that we are
talking about functions

> + * @param btf

seems like the format is "<arg_name> <description of the argument>" so
in this case it should be something like

@param btf BTF object to free

> + * @return void

do we need @return if the function is returning void? What if we just
omit @return for such cases?

> + */
>  LIBBPF_API void btf__free(struct btf *btf);
>
> +/**
> + * @brief **btf__new** creates a representation of a BTF section
> + * (struct btf) from the raw bytes of that section

is there some way to cross reference to other types/functions? E.g.,
how do we make `struct btf` a link to its description?

> + * @param data raw bytes
> + * @param size length of raw bytes
> + * @return struct btf*


@return new instance of BTF object which has to be eventually freed
with **btf__free()**?

> + */
>  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> +
> +/**
> + * @brief **btf__new_split** creates a representation of a BTF section

"representation of a BTF section" seems a bit mouthful. And it's not a
representation, it's a BTF object that allows to perform a lot of
stuff with BTF type information. So maybe let's describe it as

**btf__new_split()** create a new instance of BTF object from provided
raw data bytes. It takes another BTF instance, **base_btf**, which
serves as a base BTF, which is extended by types in a newly created
BTF instance.

> + * (struct btf) from a combination of raw bytes and a btf struct
> + * where the btf struct provides a basic set of types and strings,
> + * while the raw data adds its own new types and strings
> + * @param data raw bytes
> + * @param size length of raw bytes
> + * @param base_btf the base btf representation

same here, "representation" sounds kind of weird and wrong here

> + * @return struct btf*
> + */
>  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> +
> +/**
> + * @brief **btf__new_empty** creates an unpopulated representation of
> + * a BTF section
> + * @return struct btf*
> + */
>  LIBBPF_API struct btf *btf__new_empty(void);
> +
> +/**
> + * @brief **btf__new_empty_split** creates an unpopulated
> + * representation of a BTF section except with a base BTF
> + * ontop of which split BTF should be based

typo: on top

> + * @return struct btf*q
> + */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
>  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> --
> 2.31.1
>
