Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711682FDE84
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 02:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbhAUBKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 20:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387955AbhAUBIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 20:08:39 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668FC061757;
        Wed, 20 Jan 2021 17:07:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q12so174803lfo.12;
        Wed, 20 Jan 2021 17:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=af8uGqPNbWOtj2lXGhOrp3lNnRFLV41/jmYgbh0DDyw=;
        b=Rah5x9v7JkbaQ4n4PKUPnIa1iWBztdlO2QWBpiJmfKZF7VCtJAplypvtJCanlKLh8c
         cCxUwJdHCJNPEUQ+3kAQNCyOMLZi3JKn1vqARmlm1YIAbXdE6ZHv39zUUq/prN7AsLi9
         1TV1zpvn/1bF9B/Sc0NWAYLnGcwNqAoDi/zBGT8NuGOBJ5FAw9BAyz8dyjB73IRbq/gO
         +qIDsDOeoDLXoqyKwXFervRVofhZ5VojimZ3QiwQwqP4ju76EBWVA/3ue4nxYG0vgL/t
         tY75qhBvXT5BygLZU624LXsQbfaqqwchePf3GdKeF0DAHqDfzVEWwiLsCUV1TsvA36Tf
         7fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=af8uGqPNbWOtj2lXGhOrp3lNnRFLV41/jmYgbh0DDyw=;
        b=qy3H6b/27ZaOoKkshMdltPIxx47FSBdTpdE1oM4Eqj04q7H9LXkJlYcGYR2Qh7fdU7
         jSE1R6n5UBO+hELX6OuRq6ydXQNLdAPJHAaMXqMthXJf2LmlzvB17zea7pKZwISVSAdO
         lKgSG1PrIGmk9qVrzhJxccYMKOUF1X4J0sxYL2na+CCg0xHS32rirnzUxtBBmQ0ZHrUU
         nh6VKxSp6YqocfT8rWQK7fnp/wtLul8YEtCRW2v4bFEgAUpI9SnQH+VzNYjRmqUO7SDC
         9hU9ErV/0W32PElTsFHfP/2e/+9y6v4uelSLPemUf30J3Ceb8MO1xcmGtyzadxcmqm6R
         VAHQ==
X-Gm-Message-State: AOAM5339oumw7JO5FUEs6WSSbjWXo5zkQsPtTul3mvpm2lOPgNn7Sdv5
        bdW7XMGIBuk8OJZ/QkCxMKXhuqXb+/gUi57udKKLLer3
X-Google-Smtp-Source: ABdhPJzH2gtAdO871xVRD5ps8Vj2EJhYvwPW2zpeUgOIm18BZ5w6hBUBhwCBYZ8qJmiL9u40KXk6krqa4p2RKmtrlz8=
X-Received: by 2002:a19:8983:: with SMTP id l125mr5193184lfd.182.1611191276166;
 Wed, 20 Jan 2021 17:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20210120133946.2107897-1-jackmanb@google.com> <20210120133946.2107897-3-jackmanb@google.com>
 <CAKXUXMxw4JP4q-iGTMsnS2j4KYfU7WDRTLbAdWu4DrvCa=R+NQ@mail.gmail.com>
In-Reply-To: <CAKXUXMxw4JP4q-iGTMsnS2j4KYfU7WDRTLbAdWu4DrvCa=R+NQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 Jan 2021 17:07:44 -0800
Message-ID: <CAADnVQLGnsc0r0ZXbZys7N5cpxiRSP8BfUOr9PO5vYwQPMzWpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] docs: bpf: Clarify -mcpu=v3 requirement
 for atomic ops
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 11:57 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Wed, Jan 20, 2021 at 2:39 PM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > Alexei pointed out [1] that this wording is pretty confusing. Here's
> > an attempt to be more explicit and clear.
> >
> > [1] https://lore.kernel.org/bpf/CAADnVQJVvwoZsE1K+6qRxzF7+6CvZNzygnoBW9tZNWJELk5c=Q@mail.gmail.com/T/#m07264fc18fdc43af02fc1320968afefcc73d96f4
> >
>
> It is common practice to use "Link: URL" to refer to other mail
> threads; and to use the "permalink":
>
> https://lore.kernel.org/bpf/CAADnVQJVvwoZsE1K+6qRxzF7+6CvZNzygnoBW9tZNWJELk5c=Q@mail.gmail.com/
>
> which is a bit shorter than the link you provided.

I fixed it up while applying.
Thanks everyone.
