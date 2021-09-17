Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D77940FE35
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 18:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbhIQQ5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 12:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243102AbhIQQ5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 12:57:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E55EC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 09:56:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c7so13930638qka.2
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQ9qtIKo0WXyz/ieX4ClMivPq5Rw11WUawIiRMuqFlI=;
        b=GAZ9YbWZOAoIbFBCybwLUZQS32+t7Wli8sHKCPUxKeasR82YnlYqJ7UtaUyn1Xt2fv
         /Br7FyPIfZidgRsuqAi2kJD/z/z65eFaBCY0TpPG2jDx3alebNnoAacQI+ENp1h2KiPk
         XrR2wQOE34/30NY3DArneKUnsfd2fCpYKzO8yEIPdZP09N0J+O6DwXdhNVSPkAU4OIsx
         1ZZoO0ZtqQu0lxOOVlt0mRe8dxLG/pr8JKyLyt5VF1mpxmC8cqWqSWuo4xmdRG23X0Nl
         5ZbIXMvrRxGVUM8OeBkubD/TFVwDtr4fCbN6+cJFyk43so3YdQEHpsRtZ1Uf4osSqKug
         IQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQ9qtIKo0WXyz/ieX4ClMivPq5Rw11WUawIiRMuqFlI=;
        b=f8nQqrznO2Ln7C7a75luDNpX02EWCdOJIBFP/Pyx+cSas3I44DfScvyysdQEbBq5BH
         tr00iIdNt10Pe15r0xNPfRuPRh50RjD6Of+xEueQMJ3aslRjFlNjCBPgXBREr5zGtOPf
         Nc6Zu7mLo8GjUydJvQjJ7k6Maj7D1YufUKOUbLDdEhqYEhL+pu+a2VXt5AzHmDqj6CLc
         Lv1HiS2tDhNj+G1cSo1ZiNizNnkQCw71GK6UHQp+Tn9alGfq7DhWnsw/10qnBCtHfVgN
         0FiUHAdJJ9Xnf+2DgOi2tWtZE/zElfS1ePMs4CcNa9rQp88vjIn1TdOvb1xv5Exz8BKY
         nlnQ==
X-Gm-Message-State: AOAM5324Us69LirYN3y59XUDz2YuIMh2n3viZ90TiFyrgfhCffMIlHUx
        B2xtXWGQ8KTuOfoffvxWCbjaYrWxRJv+fw/rekQ=
X-Google-Smtp-Source: ABdhPJw1NvzxXBDxszUsTZIZrENA+USEzUOdV5yqSCJRVgU1PLtOR7efzsv1uql4fDmMTnH6ZnhXm8nHzIo5sGuHVdQ=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr14371371ybp.51.1631897778268;
 Fri, 17 Sep 2021 09:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210917152300.13978-1-grantseltzer@gmail.com>
In-Reply-To: <20210917152300.13978-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 09:56:07 -0700
Message-ID: <CAEf4BzZ+9NcE0r-+pYj2XWAtY+T55iFTXyXx+n2aecuGL710Gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add doc comments in libb.h
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 8:25 AM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds comments above functions in libbpf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org
>
> These doc comments are for:
> - bpf_object__find_map_by_name()
> - bpf_map__fd()
> - bpf_map__is_internal()
> - libbpf_get_error()
> - libbpf_num_possible_cpus()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h | 58 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2f6f0e15d1e7..27a5ebf56d19 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -478,9 +478,14 @@ struct bpf_map_def {
>         unsigned int map_flags;
>  };
>
> -/*
> - * The 'struct bpf_map' in include/linux/bpf.h is internal to the kernel,
> - * so no need to worry about a name clash.
> +/**
> + * @brief **bpf_object__find_map_by_name()** returns a pointer to the

this whole "a pointer" wording seems very low-level. It's clear that
it's a pointer just by looking at the function signature. Maybe let's
use a slightly higher-level terminology when talking about bpf_map,
bpf_program, bpf_object, etc. E.g., how about something like this:

"... returns BPF map of the given name, if it exists within the passed
BPF object." No need to describe what happens if it doesn't exist
here, because we have @return section, which can be:

"@return BPF map instance, if such map exists within BPF object; NULL,
otherwise.

> + * specified bpf map in the bpf object if that map exists, and returns

let's use BPF (all caps) consistently throughout documentation

> + * NULL if not. It sets errno in case of error.
> + * @param obj bpf object
> + * @param name name of the bpf map
> + * @return the address of the map within the bpf object, or NULL if it
> + * does not exist
>   */
>  LIBBPF_API struct bpf_map *
>  bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name);
> @@ -506,7 +511,15 @@ bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
>  LIBBPF_API struct bpf_map *
>  bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
>
> -/* get/set map FD */
> +/**
> + * @brief **bpf_map__fd()** gets the file descriptor of the passed
> + * bpf map
> + * @param map the bpf map instance
> + * @return the file descriptor or in case of an error, EINVAL

or -EINVAL, not EINVAL

> + *
> + * errno should be checked after this call, it will be EINVAL in
> + * case of error.

this last part is misleading. -EINVAL is returned directly so you
don't have to check errno. Let's maybe drop this sentence altogether,
it's going to be extremely repetitive to specify that for each API. We
should have a separate section about libbpf's approach to returning
errors, for low-level/high-level int-returning APIs and
pointer-returning APIs.

> + */
>  LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
>  /* get map definition */
> @@ -547,6 +560,15 @@ LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
>                                           const void *data, size_t size);
>  LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
> +
> +/**
> + * @brief **bpf_map__is_internal()** tells the caller whether or not
> + * the passed map is a special internal map

let's expand a little bit: "a special map created by libbpf
automatically for things like global variables, __ksym externs,
Kconfig values, etc"?

> + * @param map reference to the bpf_map
> + * @return true if the map is an internal map, false if not

s/if not/otherwise/

> + *
> + * See the enum `libbpf_map_type` for listing of the types
> + */
>  LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
>  LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
> @@ -558,6 +580,24 @@ LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
>  LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
>  LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
>
> +/**
> + * @brief **libbpf_get_error()** extracts the error code from the passed
> + * pointer
> + * @param ptr pointer returned from libbpf API function
> + * @return error code

"or 0, if no error happened"

> + *
> + * Many libbpf API functions which return pointers have logic to encode error
> + * codes as pointers, and do not return NULL. Meaning **libbpf_get_error()**
> + * should be used on the return value from these functions. Consult the
> + * individual functions documentation to verify if this logic applies.
> + *
> + * For these API functions, if `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)`
> + * is enabled, NULL is returned on error instead.
> + *
> + * If ptr == NULL, then errno should be already set by the failing

nit: "*ptr* is NULL", it's not a code, it's docs for humans, so
probably better to use conversational language here. Also do
parameters have to be enclosed in *...*? Or it's just a typographic
convention?


Also, I think it's worth noting here that `libbpf_get_error()` has to
be called right after the API itself with no other intervening calls
that could modify errno. You might get away with this in non-strict
mode, but in strict mode when pointer is NULL, the only way to get
error code is through errno variable (which is what libbpf_get_error()
is doing), but that assumes that errno is preserved. So probably worth
stating "Use libbpf_get_error() to extract error immediately after
calling an API function, with no intervening calls that could clobber
`errno` variable." or something along those lines?

> + * API, because libbpf never returns NULL on success and it now always
> + * sets errno on error.
> + */
>  LIBBPF_API long libbpf_get_error(const void *ptr);
>
>  struct bpf_prog_load_attr {
> @@ -822,9 +862,12 @@ bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
>  LIBBPF_API void
>  bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
>
> -/*
> - * A helper function to get the number of possible CPUs before looking up
> - * per-CPU maps. Negative errno is returned on failure.
> +/**
> + * @brief **libbpf_num_possible_cpus()** is helper function to get the

nit: is *a* helper function

> + * number of possible CPUs before looking up per-CPU maps.

"before looking up per-CPU maps" is too specific, it's not the only
case. So let's keep it generic. It's the theoretically possible number
of CPUs that a host kernel supports and expects.

> + * @return number of possible CPUs
> + *
> + * Negative errno is returned on failure.

errno is misleading here, is this about the thread-local errno
variable or an error code? Let's use "error code" consistently
throughout the docs.

>   *
>   * Example usage:
>   *
> @@ -834,7 +877,6 @@ bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
>   *     }
>   *     long values[ncpus];
>   *     bpf_map_lookup_elem(per_cpu_map_fd, key, values);
> - *
>   */
>  LIBBPF_API int libbpf_num_possible_cpus(void);
>
> --
> 2.31.1
>
