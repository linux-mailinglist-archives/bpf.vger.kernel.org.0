Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986E33F808F
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 04:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhHZCik (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Aug 2021 22:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhHZCik (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Aug 2021 22:38:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3121C061757
        for <bpf@vger.kernel.org>; Wed, 25 Aug 2021 19:37:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l18so2196949lji.12
        for <bpf@vger.kernel.org>; Wed, 25 Aug 2021 19:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dw4jmFR5+z230mWRQD4X+DFvdgqwuIKCL2M+TMs3IA4=;
        b=XFayuPEva2P4PCJ4EtXLvBDrC338nhOKgOsmwmqCyTKwgO1rabnDZUnG+QDOw8dzf7
         SES/F4dyK3QIuWfXv22XHVnB12g6bICIiGOoe3W9BaMmwi+LkcV2z9dpuhWbRRcUoRsG
         gLf/IkYvoz761ipT70FfhzQL18POc7WGWuwHJYztGHtGQo0+1l8ro639WYtJaqZoj5zA
         OCJAib+1LaVX5AzTs2ozvwG7GrCIis5Al7S8baAnJXR32FWRr1jKet4a4Bx8YcaWVFyt
         2LpxFSbWiKB0m3rytNNdNUg6QkbmFhe3qBsVitr+KmAT1k2O4r4vqebr59Ac849mA3F1
         VmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dw4jmFR5+z230mWRQD4X+DFvdgqwuIKCL2M+TMs3IA4=;
        b=aunEaKyaGcsIraPY9vktMUCPd5idiQERPN1xZtbRcxdhOjsse3HOb1SXSty4luWT3K
         YagjJoPAPq55aLHfWVSybHd7CC3VzmuwnI71GQbJcjtaqOcCK/utfImXem3X2zEfTME3
         AJHxZA9zydxY5xJ6AwO0rmSOwAx9oZ6UomimRS2W6lRnU8sIGI0TTxq1/E/f/f8gAghS
         nL8IdvW/VwLXi743owf/rLaEQ41B2C3y9tMIp09w+FhCwtvEe3xDeqkOg8a6OkiOuFca
         1nLN1fwbMbe5U52eD6dfY8Cz5SNTSxQ+zzPz0KBnT54eyhlgsyjELtJeEAMfFGgJXJv2
         fNsQ==
X-Gm-Message-State: AOAM5309oBzwmFRM8mn7k51r6DdtYIhmanRZALB/BYWIfqOxBfdaZshn
        UfQ2pUR8v1MVrA9EsFgRnNSLqNSXWCzWacedwgM=
X-Google-Smtp-Source: ABdhPJxo6ElP/E5dEJW4Bq/J9t2EQNFU2CddE7o64Ob8IuS8ucUQVZaR48G1JDgn+CUjUju42kRwEdAc7sZteBN75pc=
X-Received: by 2002:a05:651c:247:: with SMTP id x7mr1037880ljn.151.1629945471007;
 Wed, 25 Aug 2021 19:37:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:9c7:0:0:0:0 with HTTP; Wed, 25 Aug 2021 19:37:50
 -0700 (PDT)
In-Reply-To: <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Wed, 25 Aug 2021 19:37:50 -0700
Message-ID: <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> TCP was fixed differently in
> commit 30b4cb36b111 ("selftests/bpf: Fix spurious failures in accept
> due to EAGAIN").
> Would a similar approach work here?
>

I think so, will send a update patch to switch all read to poll_read() instead.
