Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90362336962
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCKBCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 20:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCKBCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 20:02:15 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7FCC061574
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 17:02:15 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 81so20068994iou.11
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 17:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xHQQRSrPspqfjD8VajcT1T5pnMz9SvYxRto3JqdH5Ws=;
        b=U209v8VEe2Za/DyAoFNAe82MiDJmXUh7PaxxxJ2u5En2pA5nFD6oH2y88ETjHS/dWQ
         0c8/mhlO6ifoKlZmZgVWhz36tFPvomvW0k1iqqhm/yntEVbwUD1DeXa9H+4Txmchtb3D
         z20erHSOeXOYV2Pusv0uEARknAxxorf38r7jLHqgNoPA03wgbEmyTqX5/g14jlJt9CRT
         8EDym55c1CHWg5O21TPNx4By+FWBDaY355NV+fxZN8JopFBJcyOvQlfofXDXDB1B3jV8
         h1iTREttiSAAAG2ezAwKiT5b8vi8qUHhUbPJHyDhjrWutn0699hwwrP6xdCMQ+4UMFXO
         C+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xHQQRSrPspqfjD8VajcT1T5pnMz9SvYxRto3JqdH5Ws=;
        b=LL6I6Ld+8JhT0vYJXtR3umSsDEw3Fc0JjWdjEl+iVBDhjBP8N3vrMKb2whjqB9mw98
         K5mcBDS+4cpPM8A6v5grfNnfH+DNl1i3boZG8TrsEENFXGYhLprXi2DrB5xRogyddjfM
         yQDSTXSTTUrYb54L52sNJSoqXUxV57h/G8pRPl4nDuoMqrbTWHTtAqvsOvCeRce5Zp1p
         d3BPxRr7zIIwq2KEuDO3OEC7GdRjOpB+Tcj6l+g8RYVIUH6PKxkDVH1hB6Xdq+Enj9oZ
         iLQd56a5DZT/0Ec5d1rPF6OLwWlO9hWwxIwsz/BdauvGJfI7xmJ89JSLcxC3EWUSJ8Uw
         2UEw==
X-Gm-Message-State: AOAM530jelH8vWBx3I3lYMujm8+jBiPlq2+ZoA0eh8S54GAvbDz1MYr8
        qACNmgRyiGvCaHbXY4fpQ40=
X-Google-Smtp-Source: ABdhPJyn4w9i5iI+oTqprUMKMThq1WhJdJzVA8VT2te0DzkGc2XjeJlz6yzEG0VwSil/UNPgkUts5Q==
X-Received: by 2002:a02:4087:: with SMTP id n129mr1190336jaa.143.1615424535037;
        Wed, 10 Mar 2021 17:02:15 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id i8sm493884ilv.57.2021.03.10.17.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 17:02:14 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:02:06 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>
Message-ID: <60496c0e1b624_154e120813@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzaE2FR8=ktp=L8Z2VyJcnkszkvyk-ssptA9qD2EvKgFHg@mail.gmail.com>
References: <CAEf4BzapVMa4dnXpwU0uwj3oHqyYutVp_YCbuwrPWNbVjdH08A@mail.gmail.com>
 <CAEf4BzbzsK8A8-tjigcde2zUY0JkHY495LDd3OYRxokG4wfAJg@mail.gmail.com>
 <5fe2f279bfc6f_1b18d20838@john-XPS-13-9370.notmuch>
 <CAEf4BzYeSU6hAO1Yk06bFzh5=ufWD2pwd6+xvoip3GW_1gT77A@mail.gmail.com>
 <CAEf4BzaE2FR8=ktp=L8Z2VyJcnkszkvyk-ssptA9qD2EvKgFHg@mail.gmail.com>
Subject: Re: Warnings in test_maps selftests in test_sockmap parts
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Wed, Dec 23, 2020 at 12:13 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Dec 22, 2020 at 11:32 PM John Fastabend
> > <john.fastabend@gmail.com> wrote:
> > >
> > > Andrii Nakryiko wrote:
> > > > On Tue, Dec 22, 2020 at 11:44 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > Hi John and Martin,
> > > > >
> > > > > I've noticed that all our CIs (libbpf and kernel-patches) started to
> > > > > emit kernel warning when running test_maps test. I've narrowed it down
> > > > > to test_sockmap() part of it. If I disable it, the warning goes away.
> > > > > The warning looks like this:
> > > > >
> > > > > Failed sockmap unexpected timeout
> 
> So this is still happening, quite often. It would be good to take care
> of it, it makes test_maps quite unstable and just reduces the
> signal-to-noise ratio of kernel-patches CI :(

Thanks for the poke, I'll look into it now. Thanks.
