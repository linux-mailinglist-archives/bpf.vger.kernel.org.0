Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B594198A6
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhI0QOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhI0QOf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 12:14:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3675C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:12:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b22so1332481pls.1
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGb6i7lYdOZENAK8ZyWY7U78F1HxGX0juLEzvXJT4FI=;
        b=OS2XeGfguExhTcYZA5Wnkc5ITtnUVLvAGg6cm7BnIy7jP0kXrwp9l5q5J+jVjpAPhL
         zmxtQpbq+TblsdrupwNugiK9iSSQE4rsgm5FwukaLS94BKvP9TajrS3aTfUjhtQy0LyZ
         AQp43e22ldSw3rJ5vn3qQiY3CUl84Px4HxGAwGw9HTEGuByYZA/0HsVUOh+e0SRxe8tj
         /4aWHUtHI7k5BIUtnG6Cy3ksoyqjNkc1OqCxzmAe+6KGy4S31fKCypJ+UxDL317NTnEQ
         Z9ZCyzF+QMPZ3xS8mIGOFnJK9H/ruTJB+Rodtuqal2SD+OsClXETGco1a7/QDFhAisjs
         b5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGb6i7lYdOZENAK8ZyWY7U78F1HxGX0juLEzvXJT4FI=;
        b=NfOJ7FsTbvnoXR7+lpLOtLJfrhBQj44MJJ2c98U2XVVEGMBXiIgdgZk8XbXHDRW8tT
         EKjHx7NgS6cQ1noXWTWHe8q9jcJT6wA+tjRxNTbwFbhcwfhh/mtLo7mpZxBdL2T4jdoK
         abwlfP2jeUxl6LefBpfjAPKH9BoAsQ40pWklqw9DTPFJ0J/WtWauoKvSiPmnZeRNHjxT
         +Ybpg2HLzZccW+1sCiDhLsFJcW4V01H3vLBzADQMxaTRYIDsc19jZC8RvV1ObNQD+2s+
         I0491GWHUBeAVKUsd1FilFd6zGtAh1R1LxBt9rjc+X49IeJe7FUOlY+xjJbtQrLi97qO
         AeQw==
X-Gm-Message-State: AOAM532z59phvUoTMiG8dax9GsJVtGAFgYvJlIjWgM0AA00OOurjwQ1f
        UD3HeaXZ0IsuIrheTb3YI3b6AdCER/CFl6sndxs=
X-Google-Smtp-Source: ABdhPJyNd5Ualy8flOJVkgIpUpF+XAZDR1ktuATJpk0gn89yp5Dk/EiPrLrZlyH7DhXhX/xJzrW2tDePRc2URKC3imo=
X-Received: by 2002:a17:90b:e0e:: with SMTP id ge14mr847631pjb.138.1632759177491;
 Mon, 27 Sep 2021 09:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210922234113.1965663-1-andrii@kernel.org> <20210922234113.1965663-3-andrii@kernel.org>
 <270e27b1-e5be-5b1c-b343-51bd644d0747@iogearbox.net>
In-Reply-To: <270e27b1-e5be-5b1c-b343-51bd644d0747@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Sep 2021 09:12:46 -0700
Message-ID: <CAADnVQJvpTOBcOOUJtDPR3b=o2QCpzSog1_v=wiVQ72uC+U3-Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] selftests/bpf: normalize
 SEC("classifier") usage
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 8:14 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/23/21 1:41 AM, Andrii Nakryiko wrote:
> > Convert all SEC("classifier*") uses to strict SEC("classifier") with no
> > extra characters. In reference_tracking selftests also drop the usage of
> > broken bpf_program__load(). Along the way switch from ambiguous searching by
> > program title (section name) to non-ambiguous searching by name in some
> > selftests, getting closer to completely removing
> > bpf_object__find_program_by_title().
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> > index fe818cd5f010..7d0256d7db82 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> > @@ -16,31 +16,31 @@ volatile const __u32 IFINDEX_DST;
> >   static const __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
> >   static const __u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
> >
> > -SEC("classifier/chk_egress")
> > +SEC("classifier")
>
> Can be a follow-up, but lets just deprecate the whole "classifier" terminology
> for libbpf since tc BPF programs do significantly more than just that since long
> time and it's otherwise just a confusing UX. The whole "classifier" / "action"
> terminology is just remains from legacy tc. See also libbpf.h's 'TC related API'
> where there is no notion of "classifier". Given you have SEC("xdp"), lets name
> all these in here SEC("tc"), and for compat we can keep the old "classifier" name
> as a hidden option in libbpf if we have to.

That's a great idea. SEC("tc") makes much more sense.
Let's do it as part of this series, so the same lines don't need to be
touched twice.
