Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E82241135
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 21:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgHJTyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 15:54:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728250AbgHJTyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 15:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597089277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWjirmYf2KllwjjlxHEJ7ZYiITKVAO+JLkechMz6PWk=;
        b=fqpnPsJfY5+M7ViMkz16iqDuUwzN9IzP9ixjVE/wgZ7NIfihjRw8FtPdIvc2ZzqxblExWm
        r0ZzcCePFgyIpCMNaqzgpt8lut/hF9oUxz4IcSv7VMhGFFzalbjCZ1SaPC/SufQhtDWeiF
        M2RvI0ogETX1Vqr+So3GczQUafxGbuE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-W4thl2gSPX6DpaFYkMxGLg-1; Mon, 10 Aug 2020 15:54:35 -0400
X-MC-Unique: W4thl2gSPX6DpaFYkMxGLg-1
Received: by mail-wr1-f72.google.com with SMTP id r29so4625190wrr.10
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 12:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWjirmYf2KllwjjlxHEJ7ZYiITKVAO+JLkechMz6PWk=;
        b=cT+WxJy+tSxr1zZQ1mUC2tUIaF4sfvXU9mpRyyzWk3LPHy85eMR+ynoOCdNyn999a5
         1uNT8sSfghLH/5D5cLuFW8pYGCrlrDeJ9TIywZyWMJEj43Oo0QjWisDubBzX1WMwhpjM
         sB4nRPcZCs2UeHOAKbN0P3lC0HxO6T03D6xJyteO0lB++Ym9paWX3PVV9gVt3Z45N6nB
         htRJbnlip1loRyXsrOgd/Qkz3kE/NAafyWvL1PAxnWC/YZUUe8QBeStfQWHashI4X7W7
         0BdVs0huMkhWeKHjYXmyGV6+MTL7gNP/8RsRih0E2IvjMHGE8cHmOBltsg3VfBLhwetX
         EVqQ==
X-Gm-Message-State: AOAM532KCc4/0UHPMYeuL7ptOWKS9TQzVUQisxglbaK3YGpcULaDQFRb
        hVTa80PvmGE1SEcYp2MUSShZ3eVhwxQLEqj1W9wrQgLZMKX3EdZOljDkGReSibFUdCUtZKCFXW1
        +2I1pROnF8t9NmJLJoWAichKZ9fAs
X-Received: by 2002:a5d:414e:: with SMTP id c14mr3085056wrq.57.1597089274238;
        Mon, 10 Aug 2020 12:54:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMEokWZdrNR7AC88zoH7EfPnPQDOgxJXPG1Ltbgy0Ba4WNRKOacAIw1WRck09Umra6dsRLgSk+A/83fpBQxB4=
X-Received: by 2002:a5d:414e:: with SMTP id c14mr3085033wrq.57.1597089273928;
 Mon, 10 Aug 2020 12:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200810153139.41134-1-yauheni.kaliuta@redhat.com> <20200810191254.l7dhhtpoq7cdsvzz@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200810191254.l7dhhtpoq7cdsvzz@kafai-mbp.dhcp.thefacebook.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Mon, 10 Aug 2020 22:54:17 +0300
Message-ID: <CANoWswkAHhJyY4fNoTMQVBm89Y6FOYqxsM9Tg56HUH1Oh2_+0g@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: mmap: reorder mmap manipulations of
 adv_mmap tests
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 10:13 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Aug 10, 2020 at 06:31:39PM +0300, Yauheni Kaliuta wrote:
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
> >  tools/testing/selftests/bpf/prog_tests/mmap.c | 23 ++++++++++++-------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mmap.c b/tools/testing/selftests/bpf/prog_tests/mmap.c
> > index 43d0b5578f46..5768af1e16a7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mmap.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mmap.c
> > @@ -183,38 +183,45 @@ void test_mmap(void)
> >
> >       /* check some more advanced mmap() manipulations */
> >
> > -     /* map all but last page: pages 1-3 mapped */
> > -     tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
> > +     /* map all 4 pages */
> > +     tmp1 = mmap(NULL, 4 * page_size, PROT_READ, MAP_SHARED,
> >                         data_map_fd, 0);
> >       if (CHECK(tmp1 == MAP_FAILED, "adv_mmap1", "errno %d\n", errno))
> >               goto cleanup;
> >
> > -     /* unmap second page: pages 1, 3 mapped */
> > +     /* unmap second page: pages 1, 3, 4 mapped */
> >       err = munmap(tmp1 + page_size, page_size);
> >       if (CHECK(err, "adv_mmap2", "errno %d\n", errno)) {
> >               munmap(tmp1, map_sz);
> >               goto cleanup;
> >       }
> >
> > +     /* unmap forth page: pages 1, 3 mapped */
> > +     err = munmap(tmp1 + (3 * page_size), page_size);
> > +     if (CHECK(err, "adv_mmap3", "errno %d\n", errno)) {
> > +             munmap(tmp1, map_sz);
> 1, 3, and 4 are mapped here but only one munmap() with "map_sz" is used.

Actually works for me:

7ffff7dd4000-7ffff7dfd000 r-xp 00000000 fd:05 3147480
  /usr/lib64/ld-2.28.so
7ffff7fe3000-7ffff7fe4000 r--s 00000000 00:0e 10298
  anon_inode:bpf-map
7ffff7fe5000-7ffff7fe7000 r--s 00002000 00:0e 10298
  anon_inode:bpf-map
7ffff7fe7000-7ffff7fee000 rw-p 00000000 00:00 0
7ffff7ff1000-7ffff7ff5000 r--s 00000000 00:0e 10298
  anon_inode:bpf-map

After such unmap:

7ffff7dd4000-7ffff7dfd000 r-xp 00000000 fd:05 3147480
  /usr/lib64/ld-2.28.so
7ffff7fe7000-7ffff7fee000 rw-p 00000000 00:00 0
7ffff7ff1000-7ffff7ff5000 r--s 00000000 00:0e 10298
  anon_inode:bpf-map

>
> > +             goto cleanup;
> > +     }
> > +
> >       /* map page 2 back */
> >       tmp2 = mmap(tmp1 + page_size, page_size, PROT_READ,
> >                   MAP_SHARED | MAP_FIXED, data_map_fd, 0);
> > -     if (CHECK(tmp2 == MAP_FAILED, "adv_mmap3", "errno %d\n", errno)) {
> > +     if (CHECK(tmp2 == MAP_FAILED, "adv_mmap4", "errno %d\n", errno)) {
> >               munmap(tmp1, page_size);
> >               munmap(tmp1 + 2*page_size, page_size);
> 1 and 3 are mapped here.  However, multiple munmap() are used.
>
> Both will work the same?

For the case when we do not care about the already unmapped page.
But may be I should unify and do it the same how it was done before.

Thanks!

>
> >               goto cleanup;
> >       }
> > -     CHECK(tmp1 + page_size != tmp2, "adv_mmap4",
> > +     CHECK(tmp1 + page_size != tmp2, "adv_mmap5",
> >             "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
> >
> >       /* re-map all 4 pages */
> >       tmp2 = mmap(tmp1, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
> >                   data_map_fd, 0);
> > -     if (CHECK(tmp2 == MAP_FAILED, "adv_mmap5", "errno %d\n", errno)) {
> > +     if (CHECK(tmp2 == MAP_FAILED, "adv_mmap6", "errno %d\n", errno)) {
> >               munmap(tmp1, 3 * page_size); /* unmap page 1 */
> >               goto cleanup;
> >       }
> > -     CHECK(tmp1 != tmp2, "adv_mmap6", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
> > +     CHECK(tmp1 != tmp2, "adv_mmap7", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
> >
> >       map_data = tmp2;
> >       CHECK_FAIL(bss_data->in_val != 321);
> > @@ -231,7 +238,7 @@ void test_mmap(void)
> >       /* map all 4 pages, but with pg_off=1 page, should fail */
> >       tmp1 = mmap(NULL, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
> >                   data_map_fd, page_size /* initial page shift */);
> > -     if (CHECK(tmp1 != MAP_FAILED, "adv_mmap7", "unexpected success")) {
> > +     if (CHECK(tmp1 != MAP_FAILED, "adv_mmap8", "unexpected success")) {
> >               munmap(tmp1, 4 * page_size);
> >               goto cleanup;
> >       }
> > --
> > 2.26.2
> >
>


-- 
WBR, Yauheni

