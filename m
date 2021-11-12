Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9444EE12
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhKLUrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 15:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhKLUrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 15:47:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A5C061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:44:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so42668880edd.10
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=htlSI9PbweXay3zAqrSqMP+DpA1ClH8JSrIOkKm4ThM5VQWQeSQcQTuWqsEfU+IDbe
         QIUllEebtflPJL8Cv/ENnzIJTDRXjeJPxnccsg30WJ4yh/6GCPQx8bZfjt8NAF4Bh6Vd
         1rJPvM8EESgHfctOmZ+HPr1SV7NkIGVI9BqW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=FQm1ODsryr0WMD3lrR3ZqnVz9V03+Igzc/UYcRb5jb8V1KADfsPmDdzlkxpnDdqREf
         yyGg6JnPrOUDintmfmpr1jWxH4Qv7iX3j0l7J7N0Eu2WEbe2ySX+f6BXZaoE45U3/mq0
         Tzw4D1is5LCVQRw1d7BI+wh6ht2PU7DGZ6TaSeGWI5d78vJ4fBQkSObHBmsNj0Vvm1te
         CItiAnpK2mCzegy2xwwn8NBdyOVmxHBtHNinfJkhOzKuMvarwFGoePE0MVE/rjD2ZjE5
         5BU5d3TivEF56sqFryzMZeYnPhIx11Lt1wteIMAc2AlHRp7J9JMn9PmuyFC5dEjejeFL
         a3fQ==
X-Gm-Message-State: AOAM533VZEZDemC1w/77+eeCItX1/86FsQ7h2/ev3zNyy9EGOqBu2qJV
        Sr/KafU9oKF+XXMqq2yf6NXF8CQxhkHfjn98YwQ=
X-Google-Smtp-Source: ABdhPJzTUYFlUz89jn8LVR7xTgs8ETAb5WnI3ApWYDl2izovRJIQVMHZD//nrnH+K3ayxp/R5mqvIg==
X-Received: by 2002:a17:907:9156:: with SMTP id l22mr22895339ejs.220.1636749858713;
        Fri, 12 Nov 2021 12:44:18 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id em21sm2963523ejc.103.2021.11.12.12.44.17
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 12:44:18 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id n29so17609912wra.11
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:44:17 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr22056131wrm.229.1636749857666;
 Fri, 12 Nov 2021 12:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20211111163301.1930617-1-kuba@kernel.org> <163667214755.13198.7575893429746378949.pr-tracker-bot@kernel.org>
 <20211111174654.3d1f83e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 12:44:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Subject: Re: 32bit x86 build broken (was: Re: [GIT PULL] Networking for 5.16-rc1)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 6:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>   +#include <linux/io-64-nonatomic-lo-hi.h>

I committed that fix just to have my tree build on x86-32.

If the driver later gets disabled entirely for non-64bit builds,
that's fine too, I guess. Presumably the hardware isn't relevant for
old 32-bit processors anyway.

                Linus
