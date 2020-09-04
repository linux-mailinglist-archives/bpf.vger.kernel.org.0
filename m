Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E459725E3E2
	for <lists+bpf@lfdr.de>; Sat,  5 Sep 2020 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgIDWrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgIDWri (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 18:47:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECDDC061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 15:47:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a22so3370018ljp.13
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGP5i6HuAyowRxmC8z6hKdcpUuzr0tU71XINqMIMMpM=;
        b=vdPLW4iLoa2MGCqyNqlW/3eBKGS3dQ4EDkb5GuRPQGatVVccV74ZOjx/BzhHJwswsI
         tySoBAbpRfJGJNbnABJTyo7+lHBMJVeKx9aBdpknwvIGIEfXu/F52KSE3S9Ic1oA53bE
         T13AZbHfzA7ufD6dhtaRaxZO2psoG4Vf3VKiSYYyCKUq3YBj6wS9rj+xvhOCvHbg96PE
         15XJrcAYuFYJOQFeowyPWj3jqsmGvHP7a7ibX6iQWD8pqyfmO9zPC4IROFjvWfovdEok
         Bs7F+MAfdusX5nYl1eFBWvYzUv6DNkBDvhaZ4hPvFcQh9V7hnOikmggXMS0k//KWeyL5
         kIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGP5i6HuAyowRxmC8z6hKdcpUuzr0tU71XINqMIMMpM=;
        b=kS5ul+RJLAdtZdMWz7MqbXSrK6uHrvvGoP+6YEfe+JBie80mG/M+NSIx9x2UBbZcva
         FHNjghWGFIWZ846w/fdQnvp+3FGu3WWLdn/kjB5Cei4I59Woa+d/6WmhzgHw8UqJx+iU
         vSzpEVn13KHctG+pG7h5vvnlA0VyOnP741IL02e0g0LY0ufg9xF3QK/+Zv29ZKwFotSU
         pLLhDinUzup8pH7pF9l6uZjSWwb8KurVkQ5rpJh6LIgaT1K0aAI/PfJPrxj4bhiffxae
         k3hlV7B25FXVrs4H67kmwjMXzSSjwI2vvKHH58XmUtQx3f58VoivebJzbeHbLGa0qVdC
         HSAw==
X-Gm-Message-State: AOAM5321ZenIYfmj4mXr/xYSKmHLyox5FAdht++24ZL4mTJ5yOIbV6BW
        85DjZzLWJpCnwymjtzjfXCkFt7RyaD8hq+1zuoXCu5aUZ2o=
X-Google-Smtp-Source: ABdhPJxajVPuVBaVnkU9uI3tGPXUgZQnr+zYgsHr20lAJ0rYtBo7OoHFyihbHwfsaGDEFBxduzI1oHlN5KCguQda2og=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr5172529ljb.283.1599259655177;
 Fri, 04 Sep 2020 15:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
In-Reply-To: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Sep 2020 15:47:23 -0700
Message-ID: <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
To:     Borna Cafuk <borna.cafuk@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        KP Singh <kpsingh@google.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 7:57 AM Borna Cafuk <borna.cafuk@sartura.hr> wrote:
>
> Hello everyone,
>
> Judging by [0], the inner maps in BPF_MAP_TYPE_HASH_OF_MAPS can only be created
> from the userspace. This seems quite limiting in regard to what can be done
> with them.
>
> Are there any plans to allow for creating the inner maps from BPF programs?
>
> [0] https://stackoverflow.com/a/63391528

Did you ask that question or your use case is different?
Creating a new map for map_in_map from bpf prog can be implemented.
bpf_map_update_elem() is doing memory allocation for map elements.
In such a case calling this helper on map_in_map can, in theory, create a new
inner map and insert it into the outer map.

But if your use case it what stackoverflow says:
"
SEC("lsm/sb_alloc_security")
int BPF_PROG(sb_alloc_security, struct super_block *sb) {
    uuid_t key = sb->s_uuid; // use super block UUID as key to the outer_map
    // If key does not exist in outer_map,
    // create a new inner map and insert it
    // into the outer_map with the key
}
"
Then it would be more efficient, faster, easier to use if you could
extend the kernel with per-sb local storage.
We already have socket- and inode- local storage.
Other kernel data structures will fit the same infra.
You wouldn't need to hook into sb_alloc_security either.
From other lsm hooks you'll ask for super_block-local_stoarge and scratch
memory will be allocated on demand and automatically freed with sb.
