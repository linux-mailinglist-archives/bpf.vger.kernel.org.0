Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD62CE49E
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 01:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgLDAyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 19:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgLDAyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 19:54:18 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0965C061A51
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 16:53:37 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so4643954ljj.10
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmM+CWw/NxNIbgWm/O+v7G+4NZMyDNsXwDn3Z6jGoSs=;
        b=CtABN3e5juvtOrsey+qfp+AszQYd2vzhOKXqR8YckVPTRqWRAChsMNUv4Cz1G4/RoR
         Y0075SpeS9dSD4SlClQjJXaUCkRzelkwIQNL1+gNFOLB4FXPgfFy5AByKiOWkg0rlZjp
         KhiZSRg0qGWMYhczIksn9MvKLOzQRHpoxuRaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmM+CWw/NxNIbgWm/O+v7G+4NZMyDNsXwDn3Z6jGoSs=;
        b=VKK2w3TUid1YPN7CK6kqoGy1UrfKq/BQRshMgYgosYB/n243qH7wF/0eiNOesZKNwF
         GwVZTxPsRepdyfvQseKQ+x/LPliPyrBRUdS/9VPKxkxeVjdvWGu3qgLWb5MgnyT2cp+P
         XVJtC7F4NSW7H8X1erIQ3x0lPdVlIf5KWpyY13lvDBx3kM5blC3fBrsKTg3Ss4LgmA2c
         Ag8tX2L2wGrZN0UZglrwIW4dQePMWAarnWQh/kT/3LKRcYKlUGLKcEaN6QTFGS3l4czi
         T+ZJmxFazbp8Wb9uZ4+vcRRJ0daWbRPe0vULLU1udhGc/pyh1lQ82R9maduxVpKMHG2r
         UOEw==
X-Gm-Message-State: AOAM531S0yZXbZVn0+aTW620p97h08+bvi80FPBJt2sJ8Qb+GRU+NIU6
        TA/EYFEraqF/ypQlSzjhRSE/At/ayvF+E+fqeX8CJg==
X-Google-Smtp-Source: ABdhPJxxTxgm6wz2UDT5lzirxlSlrr5UxCLm74RLNtjQw1qrXhdQ8PWQ7uFCzSrDrShMSB7RMmR2E83CpYmvzTa0xG8=
X-Received: by 2002:a2e:80c6:: with SMTP id r6mr2279546ljg.83.1607043216519;
 Thu, 03 Dec 2020 16:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20201203191437.666737-1-kpsingh@chromium.org> <CAEf4BzbAg5AG=J_9ZNz5BikpP0HvbSPH0oCbaQPgXzret5HiSw@mail.gmail.com>
In-Reply-To: <CAEf4BzbAg5AG=J_9ZNz5BikpP0HvbSPH0oCbaQPgXzret5HiSw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 4 Dec 2020 01:53:25 +0100
Message-ID: <CACYkzJ5mjs9ThxU8P53KMEgfZO6AnjJwMeA0haWSz6idt95KNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/4] Fixes for ima selftest
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> output from dd and maybe other commands:
>
> 10+0 records in
> 10+0 records out
> 10485760 bytes (10.0MB) copied, 0.037096 seconds, 269.6MB/s
> Filesystem label=
> OS type: Linux
> Block size=1024 (log=0)
> Fragment size=1024 (log=0)
> 2560 inodes, 10240 blocks
> 512 blocks (5%) reserved for the super user
> First data block=1
> Maximum filesystem blocks=262144
> 2 block groups
> 8192 blocks per group, 8192 fragments per group
> 1280 inodes per group
> Superblock backups stored on blocks:
>         8193
>
> Please follow up at your earliest convenience to silence those in
> default (non-verbose) mode.

Thanks, fixed. I added a verbosity flag to ima_setup.sh
and am using env.verbosity to toggle this extra output. I will send
in my patch tomorrow.

[...]
