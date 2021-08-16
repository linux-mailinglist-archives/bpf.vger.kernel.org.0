Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABD73EE011
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 00:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhHPWr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 18:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhHPWrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 18:47:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E0C061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 15:46:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i32-20020a25b2200000b02904ed415d9d84so18288878ybj.0
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=go5gEr/LK1ikMjcMOeCWMGgc9H7TA/C/hnBeQvGa1/s=;
        b=uJYQ3qp1mzmZbNi0iFWt9KGYsrFJHOAvGNqOz5cdMFsESdKF13hc6bITYbqdtObkIk
         Jovb8zjwNW1AQQcPumXP7YQZ/aUBE3jhZHbI54iCCj/BH2VH+6ZLx96KUplPv5n4NgFS
         oHDovPjuhfCrhis55Bg45hZG8uBlTDBtT+lTnO40Jru5HlYYuD/liep1TKHoMd80KCh7
         z7zG55c//RryYp4IL9UvcvYQimk05RVPMzQho+crhmShSUxvynVJy7tLhyErmCILhPOp
         IIjzVBPlauf0JH6PWsJ28HCYlIPFcE5gMewWF9OWTfeZZQHi884txCrK41W3wGuHt2VC
         7a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=go5gEr/LK1ikMjcMOeCWMGgc9H7TA/C/hnBeQvGa1/s=;
        b=lU6TArH5a9XOzSq1MbBl0tQv8lz9kBCLMbUFpdzRWr4sYVv+hDsPEzJuimS+XetBZU
         RYbEcVco6+KU+97/SQpPcu9PWYNpnPh8qfMoyLPTKV8MivOK4gfmBuGiS8e/drJCpXcB
         xVKxUhpiqGzGyvXMU2SwaH/LbjUhWEr0DqvKJsoEhEXbUez78cFKpWfYWGMTuPtlRtWC
         tTsWfIpi+xxaQMwIQ+Tz1wsvZDg+K2uUO2hY6niNope/XBGAejGEVZL1cHwOJro8IJvS
         dpa52dzld/sqzgqjZTNCAZLg4e4Gd9iBbXhjGqUPCCPEMDyZ1wOWfTGk18mPqbupRi5U
         4vNg==
X-Gm-Message-State: AOAM530izjcvyCDb4pCL+tSQpx+ICEz692U/SNOoyymbsuN56e6v32la
        PVjycj2F5LL39/9wjJ1lBoxtpxY=
X-Google-Smtp-Source: ABdhPJwO+8jkIUXp40zgAdtCUJmwbqGpOfo9f6s4gIzmSiABgsE2Tfyk6CI/XUbV93YAlWsS6yI4T5I=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:afa2:caa8:d56a:b355])
 (user=sdf job=sendgmr) by 2002:a25:c08a:: with SMTP id c132mr420862ybf.511.1629154012379;
 Mon, 16 Aug 2021 15:46:52 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:46:50 -0700
In-Reply-To: <CAEf4Bzb5A06ZP5k4uDwspBp7KfzY8n3=D7kr9K=6Xbf9cj4-Tw@mail.gmail.com>
Message-Id: <YRrq2qqIJmY124mq@google.com>
Mime-Version: 1.0
References: <20210816164832.1743675-1-sdf@google.com> <1b3cb059-9ecb-a0c9-3c99-805788088d09@iogearbox.net>
 <CAEf4Bzb5A06ZP5k4uDwspBp7KfzY8n3=D7kr9K=6Xbf9cj4-Tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use kvmalloc in map_lookup_elem
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/16, Andrii Nakryiko wrote:
> On Mon, Aug 16, 2021 at 2:43 PM Daniel Borkmann <daniel@iogearbox.net>  
> wrote:
> >
> > On 8/16/21 6:48 PM, Stanislav Fomichev wrote:
> > > Use kvmalloc/kvfree for temporary value when looking up a map.
> > > kmalloc might not be sufficient for percpu maps where the value is  
> big.
> > >
> > > Can be reproduced with netcnt test on qemu with "-smp 255".
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >   kernel/bpf/syscall.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 9a2068e39d23..ae0b1c1c8ece 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -1076,7 +1076,7 @@ static int map_lookup_elem(union bpf_attr *attr)
> > >       value_size = bpf_map_value_size(map);
> > >
> > >       err = -ENOMEM;
> > > -     value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
> > > +     value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> > >       if (!value)
> > >               goto free_key;
> >
> > What about other cases like map_update_elem(), shouldn't they be adapted
> > similarly?

> And in the same vein (with keys potentially being big as well), should
> we switch __bpf_copy_key() to use vmemdup_user() instead of
> memdup_user()?

Those are good questions :-)

I'm assuming that whatever is doing kmalloc on top of
bpf_map_value_size() should definitely use kvmalloc since
bpf_map_value_size() can blow up the value size. (will resend)

For __bpf_copy_key I'm less sure, but it might be a good idea as well.
Let me try to look at bit more into it, but feels like there shouldn't
be any downsides?
