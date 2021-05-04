Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF30372BBD
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhEDONL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhEDONK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 10:13:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF305C061574;
        Tue,  4 May 2021 07:12:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c3so9443444lfs.7;
        Tue, 04 May 2021 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTDqIV7/k9DScfd/QwCSAXbGgOt4/aGNOklhhuChvNM=;
        b=AGnjSPU5vDFxQnP8n3dvBczS1CaaMqkCegNn25+aOcgU4QpTmICPVDdvKTeZJ6jWWH
         +WMoy1CGZRZvKA1ikD3Bil0OWgQWEHLezy0CKQu6uS3CK43m6h0u9jZiG7HEp0be0nc+
         B72MtZmPSNnBNk5S9QaZJ0Vs092yUmcvClwaIxWBVtrcxLson1ZAdKj/opFc/m3g+ycD
         wZChMvdDXsN9kFQADbEil59mFFjAixQZ1QkirXOGCd0zbHgrqdhTKVzd8epAp7eJB2EU
         U8o9Y96Dy7AQnU1zL+Np1A/ZEuukct3tJPkQDPP2G2dj/uSgOQCSlRcSDW0T6V46QuzO
         1U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTDqIV7/k9DScfd/QwCSAXbGgOt4/aGNOklhhuChvNM=;
        b=QmOOZODvaqhfxVKvEUC+lX6JSTdURm/OuH5K8G5myKRq3hDTdqTkNaaYWTrFlv9DRM
         bI67Cy7BVS+A+OqxsErgzygiI6HinjwgXFuzcYtLvFhkyf1YvW546MwVGUUU0c11ryBo
         TOxJUhHEW/NOXtl8l4pngiZkUwEoGdIaiCLUCnzUxDZRd09kM+176NmuUZS+VPOOKoFe
         7HcMKWMNY50km3ttaAsSejXsm0Rmytg0SeOW+4o08DY2B/iySh+wbYUMlDiWq+Lmbcmx
         oMxs0uonGAVVPixFkPQlExA06NTGfvxSf6CDgGPBEtuU+ySaE9p8Q+SFc9trPpnC7BkN
         R2kQ==
X-Gm-Message-State: AOAM530frRiQGxt/SSYc++k7UyMpghEVCXsmDO9pJcr1LEQ4c975zGmZ
        GTEI8hxISp32qKbbBuvsUFJfARw0xnEteouhsFk=
X-Google-Smtp-Source: ABdhPJxQFkUhvT82spmdlrtrb+tk7HQF+yOJcDpm93nb5OLIvaQOCU9vjN7QJ8uZh4g1UFv1A19bsALcRpiHSZY9B7Q=
X-Received: by 2002:ac2:5b1a:: with SMTP id v26mr4491543lfn.534.1620137532998;
 Tue, 04 May 2021 07:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com> <20210504110519.16097-1-alx.manpages@gmail.com>
In-Reply-To: <20210504110519.16097-1-alx.manpages@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 May 2021 07:12:01 -0700
Message-ID: <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zackw@panix.com>,
        Joseph Myers <joseph@codesourcery.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 4, 2021 at 4:05 AM Alejandro Colomar <alx.manpages@gmail.com> wrote:
>
> Some manual pages are already using C99 syntax for integral
> types 'uint32_t', but some aren't.  There are some using kernel
> syntax '__u32'.  Fix those.
>
> Some pages also document attributes, using GNU syntax
> '__attribute__((xxx))'.  Update those to use the shorter and more
> portable C11 keywords such as 'alignas()' when possible, and C2x
> syntax '[[gnu::xxx]]' elsewhere, which hasn't been standardized
> yet, but is already implemented in GCC, and available through
> either --std=c2x or any of the --std=gnu... options.
>
> The standard isn't very clear on how to use alignas() or
> [[]]-style attributes, so the following link is useful in the case
> of 'alignas()' and '[[gnu::aligned()]]':
> <https://stackoverflow.com/q/67271825/6872717>
>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: glibc <libc-alpha@sourceware.org>
> Cc: GCC <gcc-patches@gcc.gnu.org>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: bpf <bpf@vger.kernel.org>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Zack Weinberg <zackw@panix.com>
> Cc: Joseph Myers <joseph@codesourcery.com>
> ---
>  man2/bpf.2 | 49 ++++++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/man2/bpf.2 b/man2/bpf.2
> index 6e1ffa198..04b8fbcef 100644
> --- a/man2/bpf.2
> +++ b/man2/bpf.2
> @@ -186,41 +186,40 @@ commands:
>  .PP
>  .in +4n
>  .EX
> -union bpf_attr {
> +union [[gnu::aligned(8)]] bpf_attr {
>      struct {    /* Used by BPF_MAP_CREATE */
> -        __u32         map_type;
> -        __u32         key_size;    /* size of key in bytes */
> -        __u32         value_size;  /* size of value in bytes */
> -        __u32         max_entries; /* maximum number of entries
> -                                      in a map */
> +        uint32_t    map_type;
> +        uint32_t    key_size;    /* size of key in bytes */
> +        uint32_t    value_size;  /* size of value in bytes */
> +        uint32_t    max_entries; /* maximum number of entries
> +                                    in a map */

For the same reasons as explained earlier:
Nacked-by: Alexei Starovoitov <ast@kernel.org>
