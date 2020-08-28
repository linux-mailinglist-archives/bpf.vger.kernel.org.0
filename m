Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0736255E26
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH1PtD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgH1PtB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 11:49:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527DC061264
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 08:48:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w10so1255078oti.2
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNBioXUgisakWGqK/Cs1GJe+aEWD26NKwe6C/oUz9Tg=;
        b=f5ptGErbwenf4w06PkBxarViE3TakJQKd5XThfbGFfK11hDKX/v7ZHb9oA0uf5H1zD
         lJpphboTz8kwrlOaPZMGP3flr0PMtuuOWBnxYqEFsj+HtqAkVIkPAurfYcy0I7LLdyeC
         hqvvbaTCKan1zndO/iTxqYrV3dVKied+CQoSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNBioXUgisakWGqK/Cs1GJe+aEWD26NKwe6C/oUz9Tg=;
        b=Zcsqkf4Ju0Xa+gb+T5TQfcOe2fMzitesmlHI7MdU3poTl7QFuHEdwePmbYyF5lgak0
         ndK9txKsYWG0zuE3C/1nrSf1NnH9TmIR9DyhTIixh+NKiY4lXe8poroMp2HJvtMuETe5
         w1ktmwoDsZDeCsHdljElIyPRoEiHitOWNaXEuLLH4w+6rmy5bH3aSdEI7rBucBQXiJpL
         3TYimdkNQoZXBoGhJrkzev2mcFkf6Rk9LxB+w8lXc1Bhl5WDg9FuiY6qgsmIL2TtcfdI
         hZoypJ59hT5VaV6RuQXXWDjt3T5BresXBdRYJF+/9u9Lbj3qgauPDiFLEW+VMNM+TGWU
         HRUg==
X-Gm-Message-State: AOAM530nTPg0rfb6cB6AUW1a1klW6F+0BKio9ggqC0fdTwowJ/o6zC89
        uCDJ6PdS7Nz/wK611+Igy2MSHac+2AW0RItRseQ2gw==
X-Google-Smtp-Source: ABdhPJx77I/9pRnCYj/qkZppKDWk7d/GEwqiCh13wxiCRQr9dAxALgZ0D6dRXhWvyrFZAFuQvouv/XRS2RExWFiJV7M=
X-Received: by 2002:a9d:618d:: with SMTP id g13mr1509976otk.147.1598629738451;
 Fri, 28 Aug 2020 08:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200828094834.23290-1-lmb@cloudflare.com> <20200828094834.23290-3-lmb@cloudflare.com>
 <87h7snrqlt.fsf@cloudflare.com>
In-Reply-To: <87h7snrqlt.fsf@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 28 Aug 2020 16:48:46 +0100
Message-ID: <CACAyw9_FJtXo0e73A9Z_+QwfDuM6B+HLRjkO7WQZ7UFqVk9xzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests: bpf: Add helper to compare socket cookies
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 28 Aug 2020 at 11:50, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Fri, Aug 28, 2020 at 11:48 AM CEST, Lorenz Bauer wrote:
> > We compare socket cookies to ensure that insertion into a sockmap worked.
> > Pull this out into a helper function for use in other tests.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >  .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 ++++++++++++++-----
> >  1 file changed, 37 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > index 0b79d78b98db..b989f8760f1a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > @@ -47,6 +47,38 @@ static int connected_socket_v4(void)
> >       return -1;
> >  }
> >
> > +static void compare_cookies(struct bpf_map *src, struct bpf_map *dst)
> > +{
> > +     __u32 i, max_entries = bpf_map__max_entries(src);
> > +     int err, duration, src_fd, dst_fd;
> > +
> > +     src_fd = bpf_map__fd(src);
> > +     dst_fd = bpf_map__fd(src);
>                              ^^^
> That looks like a typo. We're comparing src map to src map.

Oops, that's awkward! Luckily the tests still pass after fixing this.

Thanks for your other comments as well, I'll send a v2 once I have
some more reviews.

>
> > +
> > +     for (i = 0; i < max_entries; i++) {
> > +             __u64 src_cookie, dst_cookie;
> > +
> > +             err = bpf_map_lookup_elem(src_fd, &i, &src_cookie);
> > +             if (err && errno == ENOENT) {
> > +                     err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
> > +                     if (err && errno == ENOENT)
> > +                             continue;
> > +
> > +                     CHECK(err, "map_lookup_elem(dst)", "element not deleted\n");
> > +                     continue;
> > +             }
> > +             if (CHECK(err, "lookup_elem(src, cookie)", "%s\n", strerror(errno)))
> > +                     continue;
> > +
> > +             err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
> > +             if (CHECK(err, "lookup_elem(dst, cookie)", "%s\n", strerror(errno)))
> > +                     continue;
> > +
> > +             CHECK(dst_cookie != src_cookie, "cookie mismatch",
> > +                   "%llu != %llu (pos %u)\n", dst_cookie, src_cookie, i);
> > +     }
> > +}
> > +
> >  /* Create a map, populate it with one socket, and free the map. */
> >  static void test_sockmap_create_update_free(enum bpf_map_type map_type)
> >  {
> > @@ -106,9 +138,9 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
> >  static void test_sockmap_update(enum bpf_map_type map_type)
> >  {
> >       struct bpf_prog_test_run_attr tattr;
> > -     int err, prog, src, dst, duration = 0;
> > +     int err, prog, src, duration = 0;
> >       struct test_sockmap_update *skel;
> > -     __u64 src_cookie, dst_cookie;
> > +     struct bpf_map *dst_map;
> >       const __u32 zero = 0;
> >       char dummy[14] = {0};
> >       __s64 sk;
> > @@ -124,18 +156,14 @@ static void test_sockmap_update(enum bpf_map_type map_type)
> >       prog = bpf_program__fd(skel->progs.copy_sock_map);
> >       src = bpf_map__fd(skel->maps.src);
> >       if (map_type == BPF_MAP_TYPE_SOCKMAP)
> > -             dst = bpf_map__fd(skel->maps.dst_sock_map);
> > +             dst_map = skel->maps.dst_sock_map;
> >       else
> > -             dst = bpf_map__fd(skel->maps.dst_sock_hash);
> > +             dst_map = skel->maps.dst_sock_hash;
> >
> >       err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
> >       if (CHECK(err, "update_elem(src)", "errno=%u\n", errno))
> >               goto out;
> >
> > -     err = bpf_map_lookup_elem(src, &zero, &src_cookie);
> > -     if (CHECK(err, "lookup_elem(src, cookie)", "errno=%u\n", errno))
> > -             goto out;
> > -
> >       tattr = (struct bpf_prog_test_run_attr){
> >               .prog_fd = prog,
> >               .repeat = 1,
> > @@ -148,12 +176,7 @@ static void test_sockmap_update(enum bpf_map_type map_type)
> >                      "errno=%u retval=%u\n", errno, tattr.retval))
> >               goto out;
> >
> > -     err = bpf_map_lookup_elem(dst, &zero, &dst_cookie);
> > -     if (CHECK(err, "lookup_elem(dst, cookie)", "errno=%u\n", errno))
> > -             goto out;
> > -
> > -     CHECK(dst_cookie != src_cookie, "cookie mismatch", "%llu != %llu\n",
> > -           dst_cookie, src_cookie);
> > +     compare_cookies(skel->maps.src, dst_map);
> >
> >  out:
> >       test_sockmap_update__destroy(skel);
>


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
