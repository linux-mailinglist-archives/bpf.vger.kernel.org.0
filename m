Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6B2B25FD
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKMU4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMU4w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 15:56:52 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC19C0613D1;
        Fri, 13 Nov 2020 12:56:52 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s8so9892981yba.13;
        Fri, 13 Nov 2020 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kfpjvpm85ajGVPE55SrmMO8EF37vkVqtYX7l9onQlQg=;
        b=r6IZQ+NRSuTQe4C1W8jdV4DDMQhOk4KYQLz9e2hMvEQgf87RUHuwAX/woA64pBq9S4
         Kw+g61JSxS9Z+S429VtGSjgsj1dZW3jk7CaWymVxVs2Yx7p0JMhFqLMNWU5iOWFSDxen
         eshyqAbo/lBW1nw/mqicifFYDCCdnuUu44QZFpLSimV1YaQVd3du6i/6a2TzqV2ebjZk
         AEeDPjoDP41l+482uyX04iI6kpYyYHyJw7CCJVtEh+pnfm10gzW2a2Gy3K9iqvlKmAgE
         /kXOD6tX0Dl34ETepJTVXJMUgbpJfnGlHBtp6qzrawLufRubpNGzeogt7vdjg8ELT8qo
         Xr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kfpjvpm85ajGVPE55SrmMO8EF37vkVqtYX7l9onQlQg=;
        b=rSphLOL85HihZodCDaxRkpLqEtFKmd6jhxZTU2SEQZ5iNKIG0m5AFS2Hc5j4gRRA/1
         WuaR5PmDW2mLEE1TYrHn3wx4gdD2HPWt61oKQQMr5UrcqqsBV4JHTmgEJNogGOIRE1V7
         2QxQpeMDT4rtOkEZO0lqNTjakisKJE130W+yTvwltBqhPkTePaiOiFvWiDJ2YWtma2x+
         WC/geKjX5zdKQmSzQVBgbs2+elLWjUUpv887rA/cdjF2L52clkjf1qCdWC9u9bBK7/0N
         yvADCL+bHdR42IeM1zTj64IKUKu6OQ9/HdfG0keUcqy/PfCXe2WKRkYTCq2nvkt2h/PO
         2qGQ==
X-Gm-Message-State: AOAM53083OP2TPQFVcya/LNuf3xHUT8kyJ0Uewtvqtu4QPpGi5XxQ/nE
        TFeJ9Jz0pY0H+5ldAkJ8nFfyRBoxqVWY5nxaGuM=
X-Google-Smtp-Source: ABdhPJwn2C5JvJ6MlQELYCKPcgQVw4a3MZy20OnO8KuesDq0soTGq1qeFzbQs1g4shm9oHN4mXUbfhUmAJiuKrT5PBM=
X-Received: by 2002:a25:e701:: with SMTP id e1mr4309818ybh.510.1605301011270;
 Fri, 13 Nov 2020 12:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20201113151222.852011-1-jolsa@kernel.org> <20201113151222.852011-3-jolsa@kernel.org>
In-Reply-To: <20201113151222.852011-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Nov 2020 12:56:40 -0800
Message-ID: <CAEf4Bzb4yu4K+fk33n0Tas78XsKMFw+tofF2o5sOwumBC82u9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 7:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Current conditions for picking up function records break
> BTF data on some gcc versions.
>
> Some function records can appear with no arguments but with
> declaration tag set, so moving the 'fn->declaration' in front
> of other checks.
>
> Then checking if argument names are present and finally checking
> ftrace filter if it's present. If ftrace filter is not available,
> using the external tag to filter out non external functions.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

I tested locally, all seems to work fine. Left few suggestions below,
but those could be done in follow ups (or argued to not be done).

Acked-by: Andrii Nakryiko <andrii@kernel.org>

BTW, for some stats.

BEFORE allowing static funcs:

.BTF ELF section
=======================================
Data size:      4101624
Header size:    24
Types size:     2472836
Strings size:   1628764

BTF types
=======================================
Total        2472836 bytes (83310 types)
Struct:       920436 bytes (10305 types)
FuncProto:    638668 bytes (18869 types)
Func:         308304 bytes (25692 types)
Enum:         184308 bytes (2293 types)
Ptr:          173484 bytes (14457 types)
Array:         89064 bytes (3711 types)
Union:         81552 bytes (1961 types)
Const:         34368 bytes (2864 types)
Typedef:       32124 bytes (2677 types)
Var:            4688 bytes (293 types)
Datasec:        3528 bytes (1 types)
Fwd:            1656 bytes (138 types)
Volatile:        360 bytes (30 types)
Int:             272 bytes (17 types)
Restrict:         24 bytes (2 types)


AFTER allowing static funcs:

.BTF ELF section
=======================================
Data size:      4930558
Header size:    24
Types size:     2914016
Strings size:   2016518

BTF types
=======================================
Total        2914016 bytes (108282 types)
Struct:       920436 bytes (10305 types)
FuncProto:    851528 bytes (24814 types)
Func:         536664 bytes (44722 types)
Enum:         184308 bytes (2293 types)
Ptr:          173484 bytes (14457 types)
Array:         89064 bytes (3711 types)
Union:         81552 bytes (1961 types)
Const:         34368 bytes (2864 types)
Typedef:       32124 bytes (2677 types)
Var:            4688 bytes (293 types)
Datasec:        3528 bytes (1 types)
Fwd:            1656 bytes (138 types)
Volatile:        360 bytes (30 types)
Int:             256 bytes (16 types)

So 25692 vs 44722 functions, but the increase in func_proto is smaller
due to dedup. Good chunk is strings data for all those function and
parameter names.


>  btf_encoder.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d531651b1e9e..de471bc754b1 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -612,25 +612,21 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 const char *name;
>
>                 /*
> -                * The functions_cnt != 0 means we parsed all necessary
> -                * kernel symbols and we are using ftrace location filter
> -                * for functions. If it's not available keep the current
> -                * dwarf declaration check.
> +                * Skip functions that:
> +                *   - are marked as declarations
> +                *   - do not have full argument names
> +                *   - are not in ftrace list (if it's available)
> +                *   - are not external (in case ftrace filter is not available)
>                  */
> +               if (fn->declaration)
> +                       continue;
> +               if (!has_arg_names(cu, &fn->proto))
> +                       continue;
>                 if (functions_cnt) {
> -                       /*
> -                        * We check following conditions:
> -                        *   - argument names are defined
> -                        *   - there's symbol and address defined for the function
> -                        *   - function address belongs to ftrace locations
> -                        *   - function is generated only once
> -                        */
> -                       if (!has_arg_names(cu, &fn->proto))
> -                               continue;
>                         if (!should_generate_function(btfe, function__name(fn, cu)))

Seeing Arnaldo's confusion, I remember initially I was similarly
confused. I think this p->generated = true should be moved out of
should_generate_function() and done here explicitly. Let's turn
should_generate_function() into find_allowed_function() or something,
to encapsulate bsearch. Checking !p || p->generated could be done here
explicitly.

>                                 continue;
>                 } else {
> -                       if (fn->declaration || !fn->external)
> +                       if (!fn->external)

Hm.. why didn't you drop this fallback? For non-vmlinux, do you think
it's a problem to generate all FUNCs? Mostly theoretical question,
though.

>                                 continue;
>                 }
>
> --
> 2.26.2
>
