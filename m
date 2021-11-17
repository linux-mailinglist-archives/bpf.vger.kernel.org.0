Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E32454CB0
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 19:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhKQSDT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKQSDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 13:03:19 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5FC061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 10:00:20 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y16so4348062ioc.8
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Udu+2Q74S4jusvte/BlYcN0FlSODYwWqYbM2tCviQCA=;
        b=SNCNc/uK3rLV+/ZT8T7jhhx3OYcqeon4/CdNtvn5nTN9lNOwuWon+CQbJNUCXoF1vG
         FCi5uM/eA+FQpI0QhCWXb+ORK2/yGE6EbTcHZNUuZie0DDWmPkm6qM76IKcCFleoQ6pO
         ZagA02Zb9C6LtTG9alYvw1sbv5n4JMFM7a5AoWJ/PldZtLICVBvZaPw07IjA5nJeV4HH
         V8pzbfdgH0zAXZjFAp2YvgblbQHTo96Zy60hadZ6H5oZI4+xAJXaN34epRnKV0+J7r0w
         oHJoxvy4f/LbOaC1ipUI654ssd1c3JkJQSTDTkE/HCkusxdwVndoTpd2cB7G1PFHivtV
         zPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Udu+2Q74S4jusvte/BlYcN0FlSODYwWqYbM2tCviQCA=;
        b=0AEPcjuKHec1mvAxib1aTg/Lpcghfs2L3vs+2WkaHcLyV9ueef7CQeKL6L9b3fA5fN
         dPtcialcVo1ZAsixICth7H9ehEK9MFNhrQu3fAJ4uVvBISFwAF+MOGM7gY4Num0iAB+E
         hH3eN+adXA/Zx3nUHHydxDsT3VU8k7Q4zA+kOVLbkm5ggFvCKQ6VqoIzibln5UFSXVYK
         P+zkhRd+H8vHLrpvwTwNbQFfVIBRNpwvNFp320XAnMgOqDQ6XZdFJNUcWtCt0Sloo3Tp
         wOhVHWm9vX2mrxsmCVCydtPXkf2thVcicsB4y2QlUEE6hBB29bwcfBZBteGNanoUv9uy
         Np7Q==
X-Gm-Message-State: AOAM530rZ3FvrxoJt8giSqz9Vs2+MpLcjiIUxm0PYx+u1/YeNcG5xRn2
        0595KbME53J+Hi4jr86H5ds=
X-Google-Smtp-Source: ABdhPJzk46J+NIfVM3QoWVrxLa+kZhFGdGIqnXU0bwV99TKqNY5fQIUYqzjXxfhEMq+HGtY1MGVHhw==
X-Received: by 2002:a05:6638:2647:: with SMTP id n7mr14946012jat.10.1637172020176;
        Wed, 17 Nov 2021 10:00:20 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id 11sm505616ilx.55.2021.11.17.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:00:19 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:00:11 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jussi Maki <joamaki@gmail.com>
Message-ID: <6195432baf114_1f40a208aa@john.notmuch>
In-Reply-To: <CAEf4Bza3OC1pAvVvwoPhyuixf8_VpA1w0F7HAsX09x2DSYbYbA@mail.gmail.com>
References: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
 <6191ee3e8a1e1_86942087@john.notmuch>
 <CAEf4Bza3OC1pAvVvwoPhyuixf8_VpA1w0F7HAsX09x2DSYbYbA@mail.gmail.com>
Subject: Re: sockmap test is broken
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Sun, Nov 14, 2021 at 9:21 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Alexei Starovoitov wrote:
> > > test_maps is failing in bpf tree:
> > >
> > > $ ./test_maps
> > > Failed sockmap recv
> > >
> > > and causing BPF CI to stay red.
> > >
> > > Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.
> > >
> > > Please take a look.
> >
> > I'll look into it thanks.
> 
> Any updates, John? Should we just disable test_maps in CI to make it
> useful again?

I'm debugging this now. Hopefully I'll have a fix shortly (today I hope).
Maybe, it makes sense to wait for EOD and if I still don't have the fix
disable it then. Anyways fixing it is top of list now.

> 
> >
> > .John


