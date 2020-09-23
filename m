Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC1275DB5
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIWQnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWQnt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 12:43:49 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E37C0613D1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:43:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x14so503356oic.9
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQxvaYNxyzuBe/2zrjgv7SCCpseqSt392kijnThrMG4=;
        b=BukdKgyckTaLJeKaLMkfTNxO+n6aKCPT/+EcFqVYWIYDNQ7cxeyWyeJOmXJ1qjWJbn
         vvoGIfqh/tCxwbcL51xliB7SZFgJYztXtRk4ONdjIbvUSDPjU6j6DPA+9JcZvZZ+Nd5+
         ffN0LfJmetXKZdR9MkvA+Gy7szk720bAhK+ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQxvaYNxyzuBe/2zrjgv7SCCpseqSt392kijnThrMG4=;
        b=cF2CwmO+XxhfYXwt7maPCgYiX+cCIueLhH1dmOoPb9t/KxjAddgh8xhWzpB+PRhGuY
         uLKAKFWYX7cnwomnQy1sYlLKk9x0DyM+dvQfi2RP8l4L9s9Xi3rgdgVa3GEkOYLSj0Xz
         ZOHuQyoQanxLQtKA3U9dFZmy10VwJ5bBTv8OxIzht3BN5V+WS4DRR5QUjyglpWFRdnGn
         p4Va/Z/uy2U99XM32ZnuA/pjlBmiXzewdy9xZSVm64mMOByNup/hVkYjS61TexjDaGQL
         MhQ9IEWdIkCIEUDxW87wtgemkhM7vDl7xFnUat52yK3SKxy5Io/a5dL8u7CqgHNGt6Yc
         PMFQ==
X-Gm-Message-State: AOAM530BypqL+RnObRt0xMId2RI4YT9CPYrEuU7jqnfdnIFl6GqyTScF
        uSv/rmSDvSrBBSi6PpJml7y6Lmb8To5DVQpqaKW/nw==
X-Google-Smtp-Source: ABdhPJxdpk2KpdkM4paPqdaSvoAA1gvtlKUOqKTQHivN4CmeCo2EmHl1d3xJkiCr86N0UeGKBhhmNlLPf56YXnFS3+0=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr233833oip.13.1600879428464;
 Wed, 23 Sep 2020 09:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200916211010.3685-1-maciej.fijalkowski@intel.com>
 <CAADnVQLEYHZLeu-d4nV5Px6t+tVtYEgg8AfPE5-GwAS1uizc0w@mail.gmail.com>
 <CACAyw994v0BFpnGnboVVRCZt62+xjnWqdNDbSqqJHOD6C-cO0g@mail.gmail.com> <CAEf4Bzakz65x0-MGa0ZBF8F=PvT23Sm0rtNDDCo3jo4VMOXgeg@mail.gmail.com>
In-Reply-To: <CAEf4Bzakz65x0-MGa0ZBF8F=PvT23Sm0rtNDDCo3jo4VMOXgeg@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 23 Sep 2020 17:43:37 +0100
Message-ID: <CACAyw9_WkndmJiwBZTn+P8fQa6OFfxmxH7uCxi0RTNOonbCzww@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 0/7] bpf: tailcalls in BPF subprograms
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 23 Sep 2020 at 17:24, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 23, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > On Fri, 18 Sep 2020 at 04:26, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > [...]
> > >
> > > Lorenz,
> > > if you can test it on cloudflare progs would be awesome.
> >
> > Our programs all bpf_tail_call from the topmost function, so no calls
> > from subprogs. I stripped out our FORCE_INLINE flag, recompiled and
> > ran our testsuite. cls_redirect.c (also in the kernel selftests) has a
> > test failure that I currently can't explain, but I don't have the time
> > to look at it in detail right now.
> >
>
> I've already converted test_cls_redirect.c in selftest to have
> __noinline variant. And it works fine. There are only 4 helper
> functions that can't be converted to a sub-program (pkt_parse_ipv4,
> pkt_parse_ipv6, and three buffer manipulation helpers) because they
> are accepting a pointer to a stack from a calling function, which
> won't work with subprograms. But all the other functions were
> trivially converted to __noinline and keep working.

Yeah, that is very possible. Keep in mind though that our internal
version has since become more complex, and also has a more
comprehensive test suite. I wasn't sounding the alarms, it's just an
FYI that I appreciate the work that went into this and have taken a
look, but that I need to do some more digging :)

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
