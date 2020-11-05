Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE532A879D
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbgKETwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbgKETws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 14:52:48 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1ADC0613CF;
        Thu,  5 Nov 2020 11:52:47 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id s8so217819yba.13;
        Thu, 05 Nov 2020 11:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGAvsDHCD21Vv/DRAsTgB5pJSe8OiFDDHdh5DsJ556A=;
        b=BB+C9Lfy8Ks+tlBFsTgwDyO/hJmxsX6GNZcHKAT3ZWIGeFLNIbCSl0Py9qWGbIO0G7
         5rIuMi23TT6uNvgLY7Guq9X3K9WGieoT8ZKRyQ/azMCc9aOJOy/T4hfr95bFFrCtJ4kd
         kvSrg3PsAnQqcrynxi/hc2p6zY+/OnecdMCsoEO218qEgaWJT2G/qug8SwuJvy/jUjcZ
         OduKhuqY0tvvf1qk98PX+sdUmX+I2YM0ApJFbEAfKjldyeXjX7be9sNFqTlyf314rFkT
         FhZt9t9wY4i7PR8xrO5h6hMmDermmXC3gv+tBl0ZyHyWeo/o3CGehzhc/pOReOYwrlGJ
         rHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGAvsDHCD21Vv/DRAsTgB5pJSe8OiFDDHdh5DsJ556A=;
        b=iTvtJasjcJXyzQHV1SnzSHl7Bz8UzMf2Fl1YPIe6fV4ibUnN1luvKBxqMBT/i5JeIY
         Bgksq3CGC353scLUDUQ73rdYQk8YvkKc2Wk9V1vReO83j3rknBgHVMTcJO8gDM38uL/7
         UnBj9ooWYN2pTAnDtoS4J5EzK6mxtukQcpSRy4rxd9DAQc7drdPKPZaL0FzFF0O4Ad7Q
         g4+ADg3bCgApIBXE1FAG5WUJMGZ3rpsv9jrv2FdzVwkQkHsJoz6+E4u2TnLI29KDgTkI
         j6b1FGV3+Li0u+NVKaVXVFFadQboE3ojHBItztHN7eekDt3RTSCo8uPaSyQoJIYtQN85
         kJkQ==
X-Gm-Message-State: AOAM5309/NG5DKoPgZKPJFB1h405tWaRgheTq6PmWWSsT15SOOkyCq7P
        PeDp34CsXyL0KsjLC1G9IWeobqK0EmGW0IPwvfc=
X-Google-Smtp-Source: ABdhPJwWJLZuD3aiEQ1aV6xwHlW/yk0BZy5t6InZRyROeoW2tt+EO99/y9rZP37f18s7kWDulOmbcvflNoR33cxSQCA=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr5863946ybg.459.1604605966514;
 Thu, 05 Nov 2020 11:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20201104215923.4000229-1-jolsa@kernel.org> <20201104215923.4000229-4-jolsa@kernel.org>
In-Reply-To: <20201104215923.4000229-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Nov 2020 11:52:35 -0800
Message-ID: <CAEf4BzZaUyY0TA_Gq559ojEeT2mHtdc3aUbvB9Q_4u0pZ+WiWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken dwarf
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[

On Wed, Nov 4, 2020 at 2:01 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We need to generate just single BTF instance for the
> function, while DWARF data contains multiple instances
> of DW_TAG_subprogram tag.
>
> Unfortunately we can no longer rely on DW_AT_declaration
> tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
>
> Instead we apply following checks:
>   - argument names are defined for the function
>   - there's symbol and address defined for the function
>   - function is generated only once
>
> Also because we want to follow kernel's ftrace traceable
> functions, this patchset is adding extra check that the
> function is one of the ftrace's functions.
>
> All ftrace functions addresses are stored in vmlinux
> binary within symbols:
>   __start_mcount_loc
>   __stop_mcount_loc
>
> During object preparation code we read those addresses,
> sort them and use them as filter for all detected dwarf
> functions.
>
> We also filter out functions within .init section, ftrace
> is doing that in runtime. At the same time we keep functions
> from .init.bpf.preserve_type, because they are needed in BTF.
>
> I can still see several differences to ftrace functions in
> /sys/kernel/debug/tracing/available_filter_functions file:
>
>   - available_filter_functions includes modules
>   - available_filter_functions includes functions like:
>       __acpi_match_device.part.0.constprop.0
>       acpi_ns_check_sorted_list.constprop.0
>       acpi_os_unmap_generic_address.part.0
>       acpiphp_check_bridge.part.0
>
>     which are not part of dwarf data
>   - BTF includes multiple functions like:
>       __clk_register_clkdev
>       clk_register_clkdev
>
>     which share same code so they appear just as single function
>     in available_filter_functions, but dwarf keeps track of both
>     of them
>
> With this change I'm getting 38353 BTF functions, which
> when added above functions to consideration gives same
> amount of functions in available_filter_functions.
>
> The patch still keeps the original function filter condition
> (that uses current fn->declaration check) in case the object
> does not contain *_mcount_loc symbol -> object is not vmlinux.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Logic looks good, but the naming made it harder to understand what's
going on, had to jump back and forth more than usual.

Otherwise:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c | 261 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 259 insertions(+), 2 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 1866bb16a8ba..df89b4467e4c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -26,6 +26,174 @@
>   */
>  #define KSYM_NAME_LEN 128
>
> +struct symbols {

"symbols" is a bit generic name, something like funcs_layout seems to
convey the meaning a bit more precisely?


> +       unsigned long start;
> +       unsigned long stop;

start/stop mcount, right? mcount part is important is important

> +       unsigned long init_begin;
> +       unsigned long init_end;
> +       unsigned long init_bpf_begin;
> +       unsigned long init_bpf_end;
> +       unsigned long start_section;

start_section is quite ambiguous. That's the mcount section index, no?
mcount_sec_idx?

> +};
> +
> +struct elf_function {
> +       const char      *name;
> +       unsigned long    addr;
> +       bool             generated;
> +};
> +

[...]

> +       /*
> +        * Let's got through all collected functions and filter
> +        * out those that are not in ftrace and init code.
> +        */
> +       for (i = 0; i < functions_cnt; i++) {
> +               struct elf_function *func = &functions[i];
> +
> +               /*
> +                * Do not enable .init section functions,
> +                * but keep .init.bpf.preserve_type functions.
> +                */
> +               if (is_init(ms, func->addr) && !is_bpf_init(ms, func->addr))
> +                       continue;
> +
> +               /* Make sure function is within ftrace addresses. */
> +               if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> +                       /*
> +                        * We iterate over sorted array, so we can easily skip
> +                        * not valid item and move following valid field into
> +                        * its place, and still keep the 'new' array sorted.
> +                        */
> +                       if (i != functions_valid)
> +                               functions[functions_valid] = functions[i];
> +                       functions_valid++;
> +               }
> +       }

can we re-assign function_cnt = functions_valid here? and
functions_valid could be just a local temporary variable?

> +
> +       free(addrs);
> +       return 0;
> +}
> +

[...]
