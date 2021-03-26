Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7450234A0C5
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 06:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhCZFCA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZFBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 01:01:52 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6CC0613AA
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 22:01:52 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z1so4645265ybf.6
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3GuMw/N47oO3awzZred6Mmf0yHdw1TEnmD9BC45CAI=;
        b=CLHuLS76jOUsSnBSXCzocpQJSKJS9kbqnBkOyyZA6CCPkE1bve3HaYrdIg1qcasDw+
         UJhp/RyLDwzrwT652d+d8y3hfeq10hshFdvFfuS1kxPxoCl5WMm7t5BStn7d9cStrw/5
         greRnSdUZ1wv7QiLmOY+Zhzji3hAWSUI1BJs7SsK2ugjgLQV7G9HUb6Xp/w4U55kdDjt
         klRhOAYzfsH6CF69gKfInHu8IvF58K772667LUGgoL6H++P5Pj0xI0axeaUwEPI9MIgr
         Bc2S1NBN9/LWCNS7AyTJSXg+GW2FjI5CdnLEepeQ6Uly3CiJA0RuRbaWZUkp1OrD7xwQ
         HAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3GuMw/N47oO3awzZred6Mmf0yHdw1TEnmD9BC45CAI=;
        b=hOytXAQMz6EaAq0+nXbd4bevKauAjiP786ExAQoz6/I5SVXWpA6zxZZgjKMf6nKhud
         YMvKAOmmroTPav3yeNg+IhfdWrgZrhOvM5KOfqo9kXt5NViTmqcY01uyp9vpMlMOQcg8
         9A01MejOtrcWSGzba0jz/UUJHcRd3U1Zv4+gpo1bmW+iFgYLR7x2ElqQ8BPHswyi3SKO
         NW605jDnHPR7deFQJ9Lq9SRWOrKx7pPqaTKA7qKv/8SQhczVcS5aJZHDFoRPCeIuLb31
         9zXTRzddveluNLg5+VfVqTTEs76D98w46267oHp8wNbm1OQJc0LdXK6ehmthAZLvXsJp
         GqLA==
X-Gm-Message-State: AOAM532latiqokOL9H/PYd0xPvB9DNy5U7OWfv4Ov5k0mmaRcX1wKAO5
        Fgkg1KhII/3fAhFB/+cq7qwJmtSFS6H7tydEYtI=
X-Google-Smtp-Source: ABdhPJwUKfOg1e4qkufVaL8QyUainv+4kg/ZeaUieXzorf+iDiXsmFrS6NIyW7j1d33cBJ6AN5KNCYA8B8uq2Z4tTXc=
X-Received: by 2002:a25:874c:: with SMTP id e12mr16163650ybn.403.1616734911608;
 Thu, 25 Mar 2021 22:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99e288cPoBuxTjt17YfMy8AHT72AmS1W83EexxvWKaP3w@mail.gmail.com>
In-Reply-To: <CACAyw99e288cPoBuxTjt17YfMy8AHT72AmS1W83EexxvWKaP3w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Mar 2021 22:01:40 -0700
Message-ID: <CAEf4BzbQjBK+DSoYRnsW0_NrkQ2qZum4hUGxYkkNHJ9MEe+yrA@mail.gmail.com>
Subject: Re: Pinned link access mode troubles
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 24, 2021 at 11:45 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi list,
>
> BPF_OBJ_GET allows specifying BPF_F_RDONLY or BPF_F_WRONLY for
> file_flags. They are used to check that the current user has the
> necessary permissions in bpf_obj_do_get:
>
>     ret = path_permission(&path, ACC_MODE(flags));
>     if (ret)
>         goto out;
>
> The map code additionally uses the flags in bpf_map_new_fd to attach
> the permissions to the fd. Programs and links ignore flags (from
> bpf_obj_get_user):
>
>     if (type == BPF_TYPE_PROG)
>         ret = bpf_prog_new_fd(raw);
>     else if (type == BPF_TYPE_MAP)
>         ret = bpf_map_new_fd(raw, f_flags);
>     else if (type == BPF_TYPE_LINK)
>         ret = bpf_link_new_fd(raw);
>     else
>         return -ENOENT;
>
> For programs this probably isn't too exciting, since AFAIK they are

Oops, reviewed your patch before I got to this email. I think for BPF
programs it might be good to reject non-O_RDWR flags as well, at least
until we will have more nuanced read/write permissions checks.

> immutable from the user space. The same isn't true for links. Given a
> link that is pinned to a bpffs for which my user only has read access,
> I can call BPF_LINK_UPDATE and BPF_LINK_DETACH. To me this seems to
> break the privilege model. This is a real issue in our code base since
> we pin a link with 0664, which means that anybody on the system can
> detach our link. I can work around this by using 0660 mode for links,
> but I think there are several issues that need fixing:
>
> 1. BPF_OBJ_GET doesn't return an error when flags aren't useful, like
> in the program case.
> 2. BPF_OBJ_GET returns an fd that allows destructive actions even if
> BPF_F_RDONLY is passed.
>
> Based on some git archaeology I think we are in luck: the code in
> question was introduced in commit 70ed506c3bbc ("bpf: Introduce
> pinnable bpf_link abstraction") and has changed very little from what
> I can see, so backporting should be doable. Additionally, it seems
> like libbpf doesn't provide a way to specify file_flags when loading
> pinned objects. So the likelihood of breaking users is very low.
>
> I'd like to propose the following changes:
>
> 1. Return an error from BPF_OBJ_GET If file_flags is not 0 for
> programs and links. This we can backport.
> 2. (optional) Add code to respect BPF_F_RDONLY, etc. for links. This
> requires adding a new interface to libbpf.
>
> Opinions?
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
