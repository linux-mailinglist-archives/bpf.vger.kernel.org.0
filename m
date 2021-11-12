Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB78F44E07E
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 03:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhKLCvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 21:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbhKLCvx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 21:51:53 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E2C0613F5
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 18:49:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e7so1183291ljq.12
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 18:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dACq+SeisgPOtFcuavxVuy5MhjeTai5DO8RwpVx7m2c=;
        b=Fx96tFQ2JK6VrO9XjC8jFp7qrJiPRzHXwLrzyvTTPW5moGUkiXCUHVQ7BB67e6+dzX
         N1uc2L53iG9xqjlu805dgjxtNZ/bHdtonEAOv8TQmkx5YOYeDS6WIkr9LnMJ4NmNywOK
         qdrtNUkDqYq3XFWyRb/dW2/gEbAO5tROfWAtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dACq+SeisgPOtFcuavxVuy5MhjeTai5DO8RwpVx7m2c=;
        b=vWXDlSornPBFKM79M3zuyKJjF/vmR0yP8IApE3gNUVh0OaXcFyVptxevs55p1mMlg/
         sMVFYXuCWGupk6Soq5OQ4McOFAwOk8yWemEApGJOCvgv5n7Hfnpw0YjtSr2iP9CB+Umg
         10aGNdb3k/pfCOd77d3IunCgrEZRvsz273X3kWjUXiRRBqZRHX9Jj9lVIRK9YdYpyLmB
         qod3QVXjYI5tddrgrbF+PVgtJfMaSNDRNsw5WGg8JtlEUDlRiauz+IVRUHGAEsRybnjy
         VOFc2R7uGiQWx0hiC9EEegaK5fImAcsKvXCDDH7WfMKzMNvsLGzoQ3b/nnOesy6qXE1I
         wAag==
X-Gm-Message-State: AOAM530lj/mArvSMcQ8u4CXzYR4gy0KWDlFK/dCyi88OCO8I5moet2m4
        Y2B+Gzpg0UtidSUfQPZpEX7PjxgNrDmlQYFxh18=
X-Google-Smtp-Source: ABdhPJyS7LqPEoAwKWUvo6aWacRezjkuYz04BD4q/nW3be0geP6OS/dmbHfv7AJWO6Euv1VHgxdUcA==
X-Received: by 2002:a2e:6e12:: with SMTP id j18mr9970054ljc.527.1636685340759;
        Thu, 11 Nov 2021 18:49:00 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c12sm445607lji.29.2021.11.11.18.49.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 18:49:00 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id c32so18755035lfv.4
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 18:49:00 -0800 (PST)
X-Received: by 2002:a05:6512:23a7:: with SMTP id c39mr10942289lfv.655.1636685339562;
 Thu, 11 Nov 2021 18:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20211111163301.1930617-1-kuba@kernel.org> <163667214755.13198.7575893429746378949.pr-tracker-bot@kernel.org>
 <20211111174654.3d1f83e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211111174654.3d1f83e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Nov 2021 18:48:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
Message-ID: <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 5:46 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Rafael, Srinivas, we're getting 32 bit build failures after pulling back
> from Linus today.
>
> make[1]: *** [/home/nipa/net/Makefile:1850: drivers] Error 2
> make: *** [Makefile:219: __sub-make] Error 2
> ../drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In fun=
ction =E2=80=98send_mbox_cmd=E2=80=99:
> ../drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:37: =
error: implicit declaration of function =E2=80=98readq=E2=80=99; did you me=
an =E2=80=98readl=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    79 |                         *cmd_resp =3D readq((void __iomem *) (pro=
c_priv->mmio_base + MBOX_OFFSET_DATA));
>       |                                     ^~~~~
>       |                                     readl

Gaah.

The trivial fix is *probably* just a simple

    #include <linux/io-64-nonatomic-lo-hi.h>

to say that a non-atomic readq() is ok done low word first. IOW, just a

  --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
  +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
  @@ -7,6 +7,7 @@
   #include <linux/kernel.h>
   #include <linux/module.h>
   #include <linux/pci.h>
  +#include <linux/io-64-nonatomic-lo-hi.h>
   #include "processor_thermal_device.h"

   #define MBOX_CMD_WORKLOAD_TYPE_READ  0x0E

Of course, it depends on the hardware. It might not matter. Or maybe
it really wants the high word read first.

Looking at that driver, and how it didn't use to do 64-bit reads at
all, I suspect the answer is "doesn't matter".

                Linus
