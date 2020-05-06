Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422211C7CDC
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 23:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgEFVxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 17:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729675AbgEFVxy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 17:53:54 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC75C061A41
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 14:53:54 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id f5so1812987ybo.4
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0EebI0wRb/tvCNXlsGxxNrmG0tMY7mj+ffgbYSbdE0=;
        b=UFXjgemcco3wS+VML2EXMGYsw4wBSNxjKeNKGP2VQLQpBCDRbOWS3ejRsjb8/MLwVB
         i44cyTIAOyIGEL+wG8PZ0kJ9esTwBGXdx1zh1tGCCnHhNK7xnhqyfssDgOfJsCnc6LBq
         Y/o2XLAjh5ZzlmDVZ4/xuF759eOvsb+adnnL9vX2PtjVSDSxvuwI/7S3i836Ws1zEaJr
         HttwrrK4q8cCP7sMvkDPaC9kC2+rXJ9azKf15LY7RvcFueycEHCNZ6g32E2lhLfRpyFn
         GwI02VwqdYfZze5r4HE4SrZYbdMcWEv54HwOEWeME7Qh0f2TtH+Y7LpKH2iSuGul9/Hw
         hjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0EebI0wRb/tvCNXlsGxxNrmG0tMY7mj+ffgbYSbdE0=;
        b=NBXdsGXcxCojXHABbIVb/D/Ie7uhM3n0N/hwW9hgxAX4GG4eN6LPWNHuhrvMmjQXnd
         PkmCRlhuUcApxA5TNNLxDFl0ppM5xTBlxs67seLYI0uxgJlm96T97eOK2HQUhFSjTjRf
         knN5+cfN1C4MXyJ41kjh5KAbrY5u+VFGzvIzB4imx41f9WhyzHwUDTsOypEPyo1sgxtw
         e4q4uVpEbpf0JCpS89zhBZVQ2bMAikhbG3WLOsYL/plYFFdIbKg3qJSt7wa3Fz/0VTgx
         sCE3aj1K0C/1nAWPpmp1GK/g1Qoi7YswymhaaaI2dnLQ3g/QersPXw1elSCj5pcy6nhS
         t/Yw==
X-Gm-Message-State: AGi0PuapqKt514IqI5nvQtExnusJWtjfAQGXzatqVFrPMqbTStnkNXYc
        866oIhnlm7oXUgZ2PblhmQ50/VTVMZ2XdtC3d4H4/g==
X-Google-Smtp-Source: APiQypIZ2lS5JPETs/hxM32Qe7xXAMoWoXTnHt9xQRKtH2nGeflyJrnujdzb/J6oXE99NJCr1duB3JFM88kNT6eEST0=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr15709759ybc.47.1588802033385;
 Wed, 06 May 2020 14:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200506205257.8964-1-irogers@google.com> <20200506205257.8964-3-irogers@google.com>
 <CAEf4BzYJanGO+XrTBQoEzGoB_D6xQYYm9tT70+Kie4hyKCxhjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYJanGO+XrTBQoEzGoB_D6xQYYm9tT70+Kie4hyKCxhjQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 May 2020 14:53:41 -0700
Message-ID: <CAP-5=fW97DB0CTLN=5iKPUF_tJW-yZgC+jiikdU0goSD_ADYkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/bpf hashmap: fixes to hashmap__clear
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 6, 2020 at 2:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 6, 2020 at 1:55 PM Ian Rogers <irogers@google.com> wrote:
> >
> > hashmap_find_entry assumes that if buckets is NULL then there are no
> > entries. NULL the buckets in clear to ensure this.
> > Free hashmap entries and not just the bucket array.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> This is already fixed in bpf-next ([0]). Seems to be 1-to-1 character
> by character :)
>
>   [0] https://patchwork.ozlabs.org/project/netdev/patch/20200429012111.277390-5-andriin@fb.com/

Thanks!
Ian

> >  tools/lib/bpf/hashmap.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
> > index 54c30c802070..1a1bca1ff5cd 100644
> > --- a/tools/lib/bpf/hashmap.c
> > +++ b/tools/lib/bpf/hashmap.c
> > @@ -59,7 +59,13 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
> >
> >  void hashmap__clear(struct hashmap *map)
> >  {
> > +       struct hashmap_entry *cur, *tmp;
> > +       size_t bkt;
> > +
> > +       hashmap__for_each_entry_safe(map, cur, tmp, bkt)
> > +               free(cur);
> >         free(map->buckets);
> > +       map->buckets = NULL;
> >         map->cap = map->cap_bits = map->sz = 0;
> >  }
> >
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
