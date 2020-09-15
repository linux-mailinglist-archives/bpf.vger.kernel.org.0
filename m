Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A6269FAF
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgIOH0i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIOH0b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 03:26:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72ECC061788
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 00:26:30 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so3004370ioo.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I20/YlnKFLvgynG9gensIdC6w9HC3kjLYYIzv6ULk00=;
        b=aSfguaPSdg2lhOs2iyPdm8WIYlitmq3fXyFWTEoTEwh6fqma4TiiXvwpAVOQ89pIeE
         jK+wkZg52lzbtWQaY3SEA/hmmlSHrj2Scxcnh/ohwfNH+2Lzn5JnSPiFAYA2K750HiCm
         QMyvhLDP3umYMyZQMNqCTV7wf3zhzSugPtY/X394XdD0vh5Evl4kpVEv5CibxvJ7fvSH
         vHXqnkVxM6Q7oM5fLdRRB1yqKmTWN/hgKLgG2jLDwQFKGLhDOxrQtLPLMB1mob8FCq64
         oEh1MJpB9JShbowNaATjP52bQTbOdcXH2UaHb/Q5t+s4MKxkPyYvZrjLwO1w6HXR0ruW
         cp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I20/YlnKFLvgynG9gensIdC6w9HC3kjLYYIzv6ULk00=;
        b=cjwqts190GhFOnBXBdRFzDvz/jzHPf0YWETD1kGCKqpObfDbXK1BuodRbuS1aqFxHf
         WQRcWH3AxjDvlMQF4wrvQXfBcDmdsarOPvAFqLemg4ghPyNGSKEQCUXbty6KzJFylB00
         fkz90aFBcgDASHFGcmL6Zl/tljirB3sap20fsvVR5g0xqoXqOoj7BDHd1tBfpL0rLE/G
         OmwDdRCSz8nNuGLgsJ8iUkyNtXzH0NkoceZ1nzJH0thw7+9OY2ejtH0ebIbqMeacV5j8
         wmJu2ta62dqasVF0CbmMJnv4LzvcoU9njc+0tUUEjR2FWKAdhxor25u9wsQ8CuUs4YMh
         xYew==
X-Gm-Message-State: AOAM531C4LJaW2jyMb+9scaBLe2gmw/XJzNauk+sM7HPePM5hlKOXrOU
        lN9kPIH/PPW1ju/WBjKSzAe1ntbqbgclpRs2HHMk9fRdjhkgfg==
X-Google-Smtp-Source: ABdhPJyZeFhzp1ZpNPQ/H78V7ESXVXvW5t4U9jOM5bvWYjC0UYG/9WstygfVZbEEWANBwJo4KqfgiIg0MuLqu0UvqD8=
X-Received: by 2002:a5e:c906:: with SMTP id z6mr14113956iol.86.1600154789948;
 Tue, 15 Sep 2020 00:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaXCwN6XLNM6u6r+2_DuqQ+GFbqdZah345P38U9xOntMeQ@mail.gmail.com>
 <CAEf4BzaoXN9HfUmZ-3HdCyS4+ykey2Mz4vrdz9jWe9r7rwSG6g@mail.gmail.com>
In-Reply-To: <CAEf4BzaoXN9HfUmZ-3HdCyS4+ykey2Mz4vrdz9jWe9r7rwSG6g@mail.gmail.com>
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Tue, 15 Sep 2020 09:26:19 +0200
Message-ID: <CAGeTCaXRBuwSSwc9b9sWSM1PQj=D2GBPNqmwdxQsZ8iYVoituA@mail.gmail.com>
Subject: Re: map_lookup_and_delete_elem for BPF_MAP_TYPE_HASH
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 1:15 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 11, 2020 at 10:03 AM Borna Cafuk <borna.cafuk@sartura.hr> wrote:
> >
> > Hello everyone,
> >
> > As far as I can see, `map_lookup_and_delete_elem` is implemented only for
> > `BPF_MAP_TYPE_QUEUE` and `BPF_MAP_TYPE_STACK` [0]. It might be useful to be
> > able to do this operation on other kinds of maps, e.g. `BPF_MAP_TYPE_HASH`.
> >
> > If I'm not mistaken, it would have benefits over `bpf_map_lookup_elem` followed
> > by `bpf_map_delete_elem` in regards to avoiding race conditions.
>
> Yes, for a case when you know the key. But for the more general
> iteration cases, in which you go over all elements, read, and later
> remove element, not so much, because removing element would
> essentially break iteration. But I do agree, for some cases it should
> be quite useful.
>
> >
> > Is there a reason this functionality wasn't implemented?
>
> Probably no one had a specific use case for this.
>
> > Is it planned for any time soon?
> >
>
> No, as far as I'm aware.

Alright, thank you for the information.

>
> > I'm looking forward to your input.
>
> Feel free to implement this and send a patch. It doesn't seem to
> impose any extra limitations on use of BPF_MAP_TYPE_HASH, so I don't
> see why this can't be done.

Great, we'll begin looking into implementing it and submitting a patch.

>
> >
> > Best regards,
> > Borna Cafuk
> >
> > [0] https://elixir.bootlin.com/linux/v5.9-rc4/source/kernel/bpf/syscall.c#L1501
