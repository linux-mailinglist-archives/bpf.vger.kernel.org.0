Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24781FEC99
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgFRHim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgFRHil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 03:38:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42BCC061755
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 00:38:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so5331169eja.7
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsqMnvCKFxJyhNC7ybidXGV1GRm2icRQ48QWOQjllRE=;
        b=Sl12n0Kum97AIsceam8gp1a92x2RrBKd5Y4Mz05DQQGla9CluMdC6oSvKGwzHvyANa
         lkhjC8K3a14kQvijkMRbYrH3e2lnEYC1I3t9UrKtUNu+sY/fL7dnxp9tMdn18MnAapQC
         VjsCMpzy5BNZnBqM+EIjWY+Xpe6WMm2mhYPVEsrQ+gOOD/xTHtLIyc+3YhUazDaNtauZ
         b5LF50zr5HVx1C+VTtkcyCIptThDt5MBf6nOmydxyM7dqRWJJ1nSCjEkjhbyPlKiatAA
         YrnpMj+mUu2OM4ubJCr1PblZ//JqjyRYdJEKvNF47VCTFyZtlxsC7ryZZBF9fHaXlodg
         Q4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsqMnvCKFxJyhNC7ybidXGV1GRm2icRQ48QWOQjllRE=;
        b=F2TvfHA9LxQiEWrsVbKpDd5j99G7QPR4NIensH1CsxiQLvLq5RruLW8cHQiYM0n/sN
         P7pfrEfL9uc7eLX15vp9oz2JRCNIE9Fk9l8cZP5zyNM15BpCnEQfkqsg+8giFBMROfds
         2hOfMxp+PwCPWTl3aK/kpW7We5SwdC4P6RW/X9ndag+B5efR4+zG0RRIBVOA57PczvMf
         caBIS8S78DorLVwZ3BVFgJXs+st/zQKHkw7nvotwZC8iYGDgoX3TZHNbsLTTwhD0s9BQ
         p83h4ZaLhL3xEGxUO9NYmMt30xmZ4lSG55eebpfOPqAR51Baq6GYNVHjR1Au98PJTOUY
         f8LQ==
X-Gm-Message-State: AOAM530lmb2PBMeqkx9j3+qm7gnt8rQB2Cn2/yffNzRgdv4YWZHNkrRx
        4vpkd2OqGRJCzrvoNfz+GGx/0FCTdx7x5+UzZkXChw==
X-Google-Smtp-Source: ABdhPJwiYE3EVwH1Gxwu4LmkBGUk+xTRMn97O31IQqCD83G3GqxIM1SXqhBcKJEJ7sdi+jI/MsfMNJuATGGApdc9gDQ=
X-Received: by 2002:a17:906:2c5b:: with SMTP id f27mr2876832ejh.413.1592465919019;
 Thu, 18 Jun 2020 00:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200617161832.1438371-1-andriin@fb.com> <20200617161832.1438371-2-andriin@fb.com>
In-Reply-To: <20200617161832.1438371-2-andriin@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 18 Jun 2020 00:38:27 -0700
Message-ID: <CA+khW7i2vjHuqExnkgAYMeHe9e556pUccjZXti3DxuTjPjiQQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/9] libbpf: generalize libbpf externs support
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 9:21 AM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Switch existing Kconfig externs to be just one of few possible kinds of more
> generic externs. This refactoring is in preparation for ksymbol extern
> support, added in the follow up patch. There are no functional changes
> intended.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---

[...]

> @@ -5572,30 +5635,33 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
>  {
>         bool need_config = false;
>         struct extern_desc *ext;
> +       void *kcfg_data;
>         int err, i;
> -       void *data;
>
>         if (obj->nr_extern == 0)
>                 return 0;
>
> -       data = obj->maps[obj->kconfig_map_idx].mmaped;
> +       if (obj->kconfig_map_idx >= 0)
> +               kcfg_data = obj->maps[obj->kconfig_map_idx].mmaped;
>
>         for (i = 0; i < obj->nr_extern; i++) {
>                 ext = &obj->externs[i];
>
> -               if (strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> -                       void *ext_val = data + ext->data_off;
> +               if (ext->type == EXT_KCFG &&
> +                   strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> +                       void *ext_val = kcfg_data + ext->kcfg.data_off;
>                         __u32 kver = get_kernel_version();
>
>                         if (!kver) {
>                                 pr_warn("failed to get kernel version\n");
>                                 return -EINVAL;
>                         }
> -                       err = set_ext_value_num(ext, ext_val, kver);
> +                       err = set_kcfg_value_num(ext, ext_val, kver);
>                         if (err)
>                                 return err;
> -                       pr_debug("extern %s=0x%x\n", ext->name, kver);
> -               } else if (strncmp(ext->name, "CONFIG_", 7) == 0) {
> +                       pr_debug("extern (kcfg) %s=0x%x\n", ext->name, kver);
> +               } else if (ext->type == EXT_KCFG &&
> +                          strncmp(ext->name, "CONFIG_", 7) == 0) {
>                         need_config = true;
>                 } else {
>                         pr_warn("unrecognized extern '%s'\n", ext->name);

Ah, we need to initialize kcfg_data, otherwise the compiler will give
a warning on potentially uninitialized data.
