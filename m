Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470943A1CC4
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFISc2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFISc0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 14:32:26 -0400
Received: from mail-vs1-xe63.google.com (mail-vs1-xe63.google.com [IPv6:2607:f8b0:4864:20::e63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98610C061574
        for <bpf@vger.kernel.org>; Wed,  9 Jun 2021 11:30:17 -0700 (PDT)
Received: by mail-vs1-xe63.google.com with SMTP id c1so464381vsh.8
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 11:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=P8ncQkYfJttnA9Tg9slRy28srWXb/ZWaRC2Lyws5mjo=;
        b=KkOwrzUI2EgTVKPAo/sVw4WMZOWGW3S0X4yg4JzN2CHi15FTYN66UHvb5QlmgonkRC
         G2LxyVjIerPZhTbqnyDH1bgrx4jAgXII/1doRnFTkVQ5FnZJjV6/M3iw4O/+lV9evFCu
         Zentotxntgb1DmDhtCMydFuFcrM3i+gnPH/6KK9EziGy1x47JqMKjkBHA3ELIfL3KqCz
         CDzZrlwH8jJp+vbS8lGkGOn8p1Rwo1QF5KaNEdgHREwXCFq6hZN3ZitY8ViHMkLRbNaf
         KIdhNmC0mttUJ2GQRWLf7PNhKdBbhn7OfPF0XpduCK6s3GZq5NunSUdE9tXVZleGIAyw
         om9Q==
X-Gm-Message-State: AOAM532baDbLnAT0ReuU88lcvFhU2TJmrl1YA3v/rr44wrY+iyfV5FRS
        ODFkZMb7jdf0NGFthjIgFA+MbvabCsBGq9lZo5sLOvpB8ejZeg==
X-Google-Smtp-Source: ABdhPJwMhAJtnELWHC0jWoCBitiBl2aH2/rqZcmkGla3zcUAvlvEhzZgUA9YPtGh9EgPh8QQIOFoew6KW00d
X-Received: by 2002:a05:6102:1d:: with SMTP id j29mr1934241vsp.38.1623263415230;
        Wed, 09 Jun 2021 11:30:15 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.46])
        by smtp-relay.gmail.com with ESMTPS id j133sm417139vkc.9.2021.06.09.11.30.14
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 11:30:15 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.47)
    by restore.menlosecurity.com (13.56.32.46)
    with SMTP id bb4107e0-c950-11eb-9f82-cd4c43447d88;
    Wed, 09 Jun 2021 18:30:15 GMT
Received: from mail-ej1-f71.google.com (209.85.218.71)
    by safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.47)
    with SMTP id bb4107e0-c950-11eb-9f82-cd4c43447d88;
    Wed, 09 Jun 2021 18:30:15 GMT
Received: by mail-ej1-f71.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so5540631eju.22
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8ncQkYfJttnA9Tg9slRy28srWXb/ZWaRC2Lyws5mjo=;
        b=W+Nd1BELLKmOzlbe/rMacIanlv7QjgijShRi2uqgDwwx7tiGLouhp7MIxFg29JKdTp
         D8GzpTMaC/oMAwdILFtr5+DD8ok29HB/cmSjAZcLMGwsA6kVvzLuIc1LbK26ljBGoYKh
         R0eAJsJkdw9Efg99Tw/hOJEACYSkpvFtebTxA=
X-Received: by 2002:a17:906:24d8:: with SMTP id f24mr1169999ejb.188.1623263412402;
        Wed, 09 Jun 2021 11:30:12 -0700 (PDT)
X-Received: by 2002:a17:906:24d8:: with SMTP id f24mr1169989ejb.188.1623263412264;
 Wed, 09 Jun 2021 11:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
In-Reply-To: <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Wed, 9 Jun 2021 11:30:01 -0700
Message-ID: <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
Subject: Re: bpf_fib_lookup support for firewall mark
To:     David Ahern <dsahern@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thanks for the quick response. I appreciate it.
A couple of quick follow up questions:
1. Do you have any performance data that would indicate how much of a
performance drop adding an extra 4 or 8 bytes to the structure would
cause?
2. If I patch locally the structure in libc and the kernel by adding
an extra _u32 mark member is there anything that such a modification
would break?

Regards,
Rumen Telbizov


On Tue, Jun 8, 2021 at 6:21 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 6/8/21 4:59 PM, Rumen Telbizov wrote:
> > Dear BPF list,
> >
> > I am new to eBPF so go easy on me.
> > It seems to me that currently eBPF has no support for route table
> > lookups including firewall marks. The bpf_fib_lookup structure itself
> > has no mark field as per
> > https://elixir.bootlin.com/linux/v5.10.28/source/include/uapi/linux/bpf.h#L4864
> >
> > Additionally bpf_fib_lookup() function does not incorporate the
> > firewall mark in its route lookup. It explicitly sets it to 0 as per
> > https://elixir.bootlin.com/linux/v5.10.28/source/net/core/filter.c#L5329
> > along with other fields which are used during the regular routing
> > policy database lookup.
> >
> > Thus lookups from within eBPF and outside of it result in different
> > outcomes if there are rules directing traffic based on fwmark.
> > Can you please advise what the rationale for this is or if there
> > anything that I might be missing.
> >
> > Let me know if I can provide any further information.
> >
>
> The API (struct bpf_fib_lookup) is constrained to 64B for performance.
> It is not possible to support all of the policy routing options that
> Linux has in 64B. Choices had to be made.
