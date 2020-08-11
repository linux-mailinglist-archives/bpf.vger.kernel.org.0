Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6371D241423
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 02:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHKA0k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 20:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHKA0j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 20:26:39 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DAC06174A
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 17:26:39 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y134so6124563yby.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 17:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/wMn1yeQCNzJ2/0+PssboxsNheEyWcBHI63Lt5wHnw=;
        b=okm3TVCIi5oli7FRHqxsGa7WldjsOht74kdzzeDhGsvtC0zxYmnv6TeCi+uz9TwHB1
         C/F0z3WOvtz49+IKZjg4c5gohDk0H56+Y3vVm1lC9q0MPOGysbcDtkP+AUG6jUDuqscG
         nKYt+nrjgk612uZ4752d9vDIkIXvQPNaOTpyMDnvJF6VjXa4HT+CT+eh/H2XL7aNj+bA
         LGHJfb8+B68nh6G94IHQqBEsVLlxTwm23nYkuXvcEWoQmZwuDM4vye5G7pntGJcs2M3I
         eJ0ao+zSSn3noo54OR49+gIP7NbqD36tD9YgbE6rfg4GOaa7h+Q6mdRTcP2QytDRdRId
         HFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/wMn1yeQCNzJ2/0+PssboxsNheEyWcBHI63Lt5wHnw=;
        b=BqgQDd+E7QQ1shKWKz8ej55qOKuPpR2mxa0q+ohrrJUlAWIj9cIcPxyVSU6EyUawiL
         dzIhLtGKtMxgopbqoJ0zKA1OeUynWci1+95GSc3KS8xzmJteV/ZE1Hen1X9pvNVAqNH9
         6Q0iWDnEcicwV/0whY5NbefT6BKyIqt8QAw8gs4DLlcuORwfQbyTQTSmCeh8gHYwPRXo
         lrNSJ9/Ud+F4UvjV8r/UNL7eB1HnpgbGubkB5izX1xpjx/atixY8F9Q2aA0jV5RcnLF6
         Hlvg3Ev1566mMZ+msoa3fwwRERCU2jVZwa/0fu+FVcH5Inm6MG4GWHc8SR8VHcONEzwh
         20/w==
X-Gm-Message-State: AOAM532SKRlOxB0QDJQv7OGy6qBwLUPdgI0o7UE1PzesMhSnfoEcS2oz
        caCXinv1MVEZjhXDAkdZNQyKW6yvitRMcLOrZEQ=
X-Google-Smtp-Source: ABdhPJyfu+g0U77q53JU/bTgSKs4SB5qqMQ+knAMkcRUOqnbGxA8NnRUbAkWe1qVfBgSNX3MVPs7YQTLsCQcq7ENqe8=
X-Received: by 2002:a25:d84a:: with SMTP id p71mr46478068ybg.347.1597105597917;
 Mon, 10 Aug 2020 17:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200810153139.41134-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200810153139.41134-1-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Aug 2020 17:26:27 -0700
Message-ID: <CAEf4BzZkf5czhBHSD6z83mOwL+WtWXDutQghpMM=5mp=FzyRMw@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: mmap: reorder mmap manipulations of
 adv_mmap tests
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 8:32 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> The idea of adv_mmap tests is to map/unmap pages in arbitrary
> order. It works fine as soon as the kernel allocates first 3 pages
> for from a region with unallocated page after that. If it's not the
> case, the last remapping of 4 pages with MAP_FIXED will remap the
> page to bpf map which will break the code which worked with the data
> located there before.
>
> Change the test to map first the whole bpf map, 4 pages, and then
> manipulate the mappings.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

[0] is fixing the same issue with a slightly different approach by
"preallocating" 4 anonymous mmap pages. I think I like that one a bit
better. Please take a look as well.

  [0] https://patchwork.ozlabs.org/project/netdev/patch/20200810153940.125508-1-Jianlin.Lv@arm.com/

>  tools/testing/selftests/bpf/prog_tests/mmap.c | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>

[...]
