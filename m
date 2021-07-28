Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1C3D94E6
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhG1SBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhG1SBY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DCAC0617A4
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 11:01:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nb11so6012373ejc.4
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MO1myk+oIo6b7WtOvt4qRY7WM2gouFRETzf85aAngQ=;
        b=qxCUOqOSiIiqa1/UPibWvWOS1A8c5ob4j0sJHaaFQfHVRszEJfe8w+lZjAFkkJ/Znx
         6ubaEUYeBLSHcmFYQlaxWqq97th7hwAaN+xRrd8PKkulsNV78jG/hsxxiOYyBxKpvIk+
         quFHLXC/NtqFo+kZokdxIk2uNHCtV5soQzCfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MO1myk+oIo6b7WtOvt4qRY7WM2gouFRETzf85aAngQ=;
        b=lu7EfUKWL43HRDWufpOpGVMPuFEWCOxWddiXeZsrRSHvDXserxjHU7kVhk45u4HeGA
         ea5NLbMPP90mF48ax/6N+Cp2npyA6nJJAe2Yqn22Ert+hT5lzciYtvMZVER31VtgJqHy
         5h1DqX6uhRPAuDbHjaBbU05wWkPJ6NssOBfHTU3xogNJX4wqRosQIvBg6TN1DgkPRygI
         nkb81TgCvuqKrg4tHgrNtGfwyxfumZd7TSIYwWaM2Ba/PiK5PMRodgpDU1V8Gh9dxVCy
         rjtSHOg0A+PkAj9wKbE2WePsOMhGFY0QBwTVevgIGZzRYCxJakk7IFwCoYzyGkdwzi4T
         xpyg==
X-Gm-Message-State: AOAM530NrrkZ5/E02gBXrc7Uxx1yDIEd9iXF+FnxWeA1uUPER2cv94yg
        7+zdMEvn/6FyYAieI6sDEyi1Lk6qucPokjRMwWNyDQ==
X-Google-Smtp-Source: ABdhPJyQJCrRAyCRnN1/A1ZecZyfNdDk8QNibSQCk4oweLYvAGVjkpDq1zIo7zp3lnwEg+SInZyMxRx3Ig14KHrcQqY=
X-Received: by 2002:a17:906:828a:: with SMTP id h10mr650820ejx.15.1627495271884;
 Wed, 28 Jul 2021 11:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <384aaee4.1b40.17aeb053a78.Coremail.chapterk93@163.com>
In-Reply-To: <384aaee4.1b40.17aeb053a78.Coremail.chapterk93@163.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Wed, 28 Jul 2021 11:01:00 -0700
Message-ID: <CAC1LvL11BVD38bnivBQMFnFdADe4SU5zNOutVco0pdnVXZCbcA@mail.gmail.com>
Subject: Re: using "BPF_MAP_TYPE_DEVMAP" when pinning it to a global path
To:     G <chapterk93@163.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 8:05 PM G <chapterk93@163.com> wrote:
>
> Hi BPF Experts
>
> I'm having an issue with using "BPF_MAP_TYPE_DEVMAP" when pinning it to a global path for sharing with multiple programs.
> I used iproute2 to load the program, the parameters for creating a map are as follows:
> ----------------------------------------------------------------------------------
>     struct bpf_elf_map BPFM_SEC_MAPS dev_map_test = {
>         .type                = BPF_MAP_TYPE_DEVMAP,
>         .size_key       = sizeof(int32),
>         .size_value   = sizeof(int32),
>         .max_elem   = 1,
>         .flags               = 0,
>         .pinning         = PIN_GLOBAL_NS,
>     };
> ----------------------------------------------------------------------------------
>
> Here I set the flags to 0, but the actual map is created with flags 0x80, so when the second program is loaded, map parameter check is incorrect.
> When I tried to set the flags directly to 0x80, I failed with the parameter error `-EINVA`  when the first program was loaded
> The general process for iproute2 to create a map with a pin tag is as follows:
> -----------------------------------------------------------------------------------
> bpf_map_attach
> -> bpf_probe_pinned
>     bpf_map_selfcheck_pinned
>     -> bpf_derive_elf_map_from_fdinfo
>          bpf_map_pin_report
>          -> if (obj->flags != pin->flags)
>                    fprintf(stderr, " - Flags:        %#x (obj) != %#x (pin)\n", obj->flags, pin->flags);
> -----------------------------------------------------------------------------------
>
> I have tried to read the relevant kernel code :
> -----------------------------------------------------------------------------------
>     // kernel/bpf/devmap.c
>     #define DEV_CREATE_FLAG_MASK \
>          (BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
>
>     static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
>     {
>        ...
>         /* check sanity of attributes */
>         if (attr->max_entries == 0 || attr->key_size != 4 ||
>                 attr->value_size != 4 || attr->map_flags & ~DEV_CREATE_FLAG_MASK)
>                 return -EINVAL;
>
>         /* Lookup returns a pointer straight to dev->ifindex, so make sure the
>          * verifier prevents writes from the BPF side
>          */
>         attr->map_flags |= BPF_F_RDONLY_PROG;
>         ...
>     }
> -----------------------------------------------------------------------------------
>
> At the time of check , it does not allow 0x80 to be set (DEV_CREATE_FLAG_MASK) , but then the code sets the 0x80 flag itself.

It looks like the kernel itself is setting the flags to 0x80 when it
initializes a devmap[1]. (Note: BPF_PROG_READONLY is 0x80.[2])

I believe you do not need to worry about setting this flag when you call the
BPF_MAP_CREATE syscall.

[1] https://elixir.bootlin.com/linux/v5.13.5/source/kernel/bpf/devmap.c#L126
[2] https://elixir.bootlin.com/linux/v5.13.5/source/include/uapi/linux/bpf.h#L1179

> So I'm not sure if we should allow 0x80 on the check here as well ? If anyone has suggestions please let me know, thanks.
> -----------------------------------------------------------------------------------
>     #define DEV_CREATE_FLAG_MASK \
>          (BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY | BPF_F_RDONLY_PROG)
> -----------------------------------------------------------------------------------
>
> Best regards
> W.Gao
