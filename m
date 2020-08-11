Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7002415C5
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 06:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgHKEis (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 00:38:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46130 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgHKEiq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 11 Aug 2020 00:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597120725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNJb32zHgiYiDXb9KVb6gngimCyrMa43Dr+Q6o5fkTU=;
        b=daFKdJQTblwxLcH3SHwpvUnW8b8QsDdJp9zxD7Qeb+w/+8aEBTKIqUJ1iRn9+MjSNeYb+k
        AkAxlvR+L/V3ajRw3uFN94s3RN97C2GibIjtD9hdgEKKXt7erVtEffw6vJamsKThEZrwVo
        d8ZRuNuA1aAZ0xYB1p30/FT/4Oirktc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-UL8UVNb9PhSEHsXVUj_SnA-1; Tue, 11 Aug 2020 00:38:39 -0400
X-MC-Unique: UL8UVNb9PhSEHsXVUj_SnA-1
Received: by mail-wr1-f70.google.com with SMTP id z12so5087570wrl.16
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 21:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNJb32zHgiYiDXb9KVb6gngimCyrMa43Dr+Q6o5fkTU=;
        b=S0spi5bdRQ6AQj/gBNt4uSVvaT354DRtY9tmjKpI2TlDBqOLaNGDUC5/yLvrEQjje2
         aCuUSc35xxOZd1+0guyQItUeEDBSxkxs5Z3gMtCNi0GacMoZ15nWKQHUOXe9iIyS3V6f
         73HFxDPYso8ih2UQ+FSjNub2QKXqb/Bf9tbxTqYBC2I4uGxOdmjNWKIkKn9YBm4P7YSj
         N5VKv7NEVrjwRujaCU4ZrDb8D4zct9x8BNWSjUoQpIEBjIXvh3fC+FzYtogfpSMTmTPh
         J+LJJFz0T6oztsunnDeNeEpfh8bW8OItLQXuN16uU/Z4gEIJV9/HYAuPULxqKwfsjksL
         0duQ==
X-Gm-Message-State: AOAM533RNJHWtMkjB9PevQTNosH7lOD9IXFlLZxviIFlj0t9oyyBtITo
        6u8Pr2PeKCzVuIuOxaTCnC2FxawxtG+8HtIw6EcL7bIXYE15F21GZ89LSH9l33rAudcIVdgqLp/
        /9v9yyaLHM+bpDeATT81Q+9H1uxoy
X-Received: by 2002:a5d:414e:: with SMTP id c14mr4600760wrq.57.1597120718838;
        Mon, 10 Aug 2020 21:38:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqtRmEQKx33zLdnsxbKwm7582C8GrgFklSNCjlqTggDlG4c4+Y9Fru6OuIiPYYewkR9d2+LG0H1Cd2CRuf9f0=
X-Received: by 2002:a5d:414e:: with SMTP id c14mr4600743wrq.57.1597120718571;
 Mon, 10 Aug 2020 21:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200810153139.41134-1-yauheni.kaliuta@redhat.com> <CAEf4BzZkf5czhBHSD6z83mOwL+WtWXDutQghpMM=5mp=FzyRMw@mail.gmail.com>
In-Reply-To: <CAEf4BzZkf5czhBHSD6z83mOwL+WtWXDutQghpMM=5mp=FzyRMw@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Tue, 11 Aug 2020 07:38:22 +0300
Message-ID: <CANoWswk2drSf=+KbKKkF16+p-OtyHQ7ZYUS76iCHM6TZVVJPew@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: mmap: reorder mmap manipulations of
 adv_mmap tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 11, 2020 at 3:26 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 10, 2020 at 8:32 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > The idea of adv_mmap tests is to map/unmap pages in arbitrary
> > order. It works fine as soon as the kernel allocates first 3 pages
> > for from a region with unallocated page after that. If it's not the
> > case, the last remapping of 4 pages with MAP_FIXED will remap the
> > page to bpf map which will break the code which worked with the data
> > located there before.
> >
> > Change the test to map first the whole bpf map, 4 pages, and then
> > manipulate the mappings.
> >
> > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > ---
>
> [0] is fixing the same issue with a slightly different approach by
> "preallocating" 4 anonymous mmap pages. I think I like that one a bit
> better. Please take a look as well.

Fine for me. Thanks!

>
>   [0] https://patchwork.ozlabs.org/project/netdev/patch/20200810153940.125508-1-Jianlin.Lv@arm.com/
>
> >  tools/testing/selftests/bpf/prog_tests/mmap.c | 23 ++++++++++++-------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
>
> [...]
>


-- 
WBR, Yauheni

