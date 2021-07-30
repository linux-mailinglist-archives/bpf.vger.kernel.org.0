Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FA3DB075
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhG3A64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 20:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhG3A6z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 20:58:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B231C061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 17:58:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a93so13194220ybi.1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpUXKTvcnP0OnYH60r148PIZ4bwmKiXkmW8xNA6/ZhQ=;
        b=coWAKlzmF8R6UCQL721p8txIuwBsmFlpGMlrkOaDNuafSt9OP2EGb2SYF2mWB215GO
         0NuJ6RBXLtqCAOEdygDPIS2STAhKoZAAGpVcXgxb6H2RI3U2X7hKyGujJilaZ1lHShhY
         qbSSaVDctA6SI69R7XNPy2bDeG4M4eG75877Jk41fb1TCiR6J2vRxnFkxOriTajaRfk2
         RVBLi/jbUPqyIl3ekgT4xghXoW4UfIMZfLKfPe0VJ85BuS5ofj+ZdyKo6+/cFNjR+Fr+
         24PHjM8UvPZiI/d/K2vfkulb0eLJiDnIeaTdIoIpkpmwYzcB7GeWFJaVTi5Qinscytzk
         ElKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpUXKTvcnP0OnYH60r148PIZ4bwmKiXkmW8xNA6/ZhQ=;
        b=sAMvHPKDBPB/8Ujtbkbr63ITS8+bEnshXcnjTU9tAJVcucpPcVIDu7Hp/FXFKs3iH5
         ce/+UO8PBna2lAdQwjhvZSwwRoagXfdEFBLHAPFFdI27k/if4dESp2d6mejafnqsSJJO
         z+meACSqDsXXCZcIUumn0IfbAovGNljuicSLCYlazelY11m0Eva8f00/+YjKKEHPzh2i
         3ufevzcsc6taeLbJZ5+YMUGOxGCuv8OFp5+EuvP2t8iPf6j3rzdpFoI2KsfdPyQeNA2O
         cEqXm5bo7/cBjgq+h3wSMGIpyQX1i91xvCFqqDDRTupvP7wgjXCMQKtKg70AiBx1S0/K
         iDGA==
X-Gm-Message-State: AOAM530Ah0jGAC3L8Nr3XJNQMTFbukDD4ZJgoJfzIYYrvYyANjzfDci3
        cCvUh0VIum7J1jz/TFJWaENgWT+BUlvrd+Tt71c=
X-Google-Smtp-Source: ABdhPJwLWgINBziXHaP+NVjiQdl9jpY32qMrn7CM2aqVf7Nx/HycW0+jbt5W06U+los4MK53OlssvlKRDjmx5t1SHbw=
X-Received: by 2002:a25:d691:: with SMTP id n139mr2052088ybg.27.1627606730166;
 Thu, 29 Jul 2021 17:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210730001801.994751-1-fallentree@fb.com> <20210730002953.1045142-1-fallentree@fb.com>
In-Reply-To: <20210730002953.1045142-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 17:58:39 -0700
Message-ID: <CAEf4Bzb-wgG8hy-ibfvyTssRPx301MSbKD2KOAoNiV0UKN4EiQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next] libbpf: Add bpf_object__set_name(obj, name) api.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 5:31 PM Yucong Sun <fallentree@fb.com> wrote:
>
> Tracking: libbpf/libbpf#291

Please provide a bit more elaborate commit summary. Just a link to
libbpf Github PR isn't a good commit message. Please explain
succinctly what is being added and why.

As for the PR reference itself, please include the full link. You can
use this form (which Quentin used pretty consistently already):

Reference: https://github.com/libbpf/libbpf/issues/291

>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
>
> ---
>
> V3 -> V4: handle obj is NULL case.
> V2 -> V3: fix code style errors
> ---
>  tools/lib/bpf/libbpf.c                                 | 10 ++++++++++
>  tools/lib/bpf/libbpf.h                                 |  1 +
>  tools/lib/bpf/libbpf.map                               |  1 +
>  .../selftests/bpf/prog_tests/reference_tracking.c      |  7 +++++++
>  4 files changed, 19 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a1ca6fb0c6d8..a628e94a41a4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7545,6 +7545,16 @@ const char *bpf_object__name(const struct bpf_object *obj)
>         return obj ? obj->name : libbpf_err_ptr(-EINVAL);
>  }
>
> +int bpf_object__set_name(struct bpf_object *obj, const char *name)
> +{
> +       if (!obj || !name)
> +               return libbpf_err(-EINVAL);

I think we shouldn't be checking !obj in every bpf_object's API (even
though we have a bunch of APIs like that). If user can't make sure
they pass non-NULL proper pointer, it's fine for them to debug
SIGSEGV.

> +
> +       strncpy(obj->name, name, sizeof(obj->name) - 1);

let's do two extra checks:

1. if bpf_object was already loaded, it's too late (maps were named
with its name, etc), so error out in that case
2. if provided name is too long, we can still truncate and set it, but
let's also return -E2BIG maybe?

BTW, static analyzers like to complain about strncpy not zero
terminating, add extra obj->name[sizeof(obj->name) - 1] = '\0'; at the
end to make them happier


Also, please add selftest validating that this name is actually taken
into account properly. First thing that comes to mind to check this
would be .data/.rodata map names check, but look around the source
code to see if there is something other that can be used as a check.


> +
> +       return 0;
> +}
> +
>  unsigned int bpf_object__kversion(const struct bpf_object *obj)
>  {
>         return obj ? obj->kern_version : 0;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 1271d99bb7aa..36a2946e3373 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -161,6 +161,7 @@ LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
>  LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
>
>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
> +LIBBPF_API int bpf_object__set_name(struct bpf_object *obj, const char *name);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
>  LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c240d488eb5e..3c15aefeb6e0 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -377,4 +377,5 @@ LIBBPF_0.5.0 {
>                 bpf_object__gen_loader;
>                 btf_dump__dump_type_data;
>                 libbpf_set_strict_mode;
> +               bpf_object__set_name;

please keep that list alphabetically sorted

>  } LIBBPF_0.4.0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> index de2688166696..4d3d0a4aec03 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> @@ -5,6 +5,7 @@ void test_reference_tracking(void)
>  {
>         const char *file = "test_sk_lookup_kern.o";
>         const char *obj_name = "ref_track";
> +       const char *obj_name2 = "ref_track2";
>         DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
>                 .object_name = obj_name,
>                 .relaxed_maps = true,
> @@ -23,6 +24,12 @@ void test_reference_tracking(void)
>                   bpf_object__name(obj), obj_name))
>                 goto cleanup;
>
> +       bpf_object__set_name(obj, obj_name2);
> +       if (CHECK(strcmp(bpf_object__name(obj), obj_name2), "obj_name",
> +                 "wrong obj name '%s', expected '%s'\n",
> +                 bpf_object__name(obj), obj_name2))
> +               goto cleanup;
> +

it's a bit too simple and doesn't test much. See how obj->name is used
for naming maps (and maybe something else as well), and validate that
it gets propagated properly

>         bpf_object__for_each_program(prog, obj) {
>                 const char *title;
>
> --
> 2.30.2
>
