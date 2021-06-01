Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C53A397CBA
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 00:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhFAWvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 18:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAWvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 18:51:02 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0128C061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 15:49:18 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 68so165125uao.11
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JccSDXgU0yLpIj2ozQnwFQoDiyeXJ2fBxo4ycAlKLEo=;
        b=hdIDRiejKM3VWVXpe7GgBgEpkN0dDaACPH1vYniwbpdp2XdZONS1OD1DKXNXh2UL61
         rRkSHiImn29z79zT1/6/GJ8nYT2FZJ9pFcUWk2HKZf9BfXEdZP2yi1qU3EBKFO/8F6TC
         Iqk17ryhQJrSdtwa24dNE2J4OlrtwybqWCqqTo8Tm/A+mr1uOv054OfDmOMDrjP6uYmH
         g4vqDk7oIqq9zMQEEbVJjINP2MQppCmSTKArPgfoIr8TCcnqzL3JzfzBn2yeuzqbvRaO
         YM24Ewn6W586A3B5Vxp0Jwdik9rHPXR8gsk2ayAhZ/rzjwPt0EgkGzsnxaCFFw6o/LXR
         H+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JccSDXgU0yLpIj2ozQnwFQoDiyeXJ2fBxo4ycAlKLEo=;
        b=tNoDNjiCLVdxIb3f2MH/QD+Q2hBpu/QlQUvrJIaZhHzXFg4ouYC1Q73mVdHENWP37m
         x2wU8O/E2Vxzv/LbwjC2XwKz9kzGEI0SpUJSs9uetYW56x+59zfjiuxRBtOBuIIi0DaB
         UFpY8QfuEql2Itl9BH9ahZz6RO79TXnLTKVmQdpq4RhYeQ+w3uaKge00915np5jqkdgY
         X6PVss9XGYHzWiyr3xiljZY5FQ/emwuyVp4ZGdTKeOkVK4QLtJt6TJ4T17TSBcGiONc8
         /RWbOx9bWk7gU17PukCYxmOno7/pkpHwqafAdll+KPJ8CccsqHSfVHVvim9/gdDQyh7a
         r+QA==
X-Gm-Message-State: AOAM531dpgAj2fm1ge5RAyjFeziUlf2fTvwQdVhK4OqHaBJmYKRb3vpp
        0aPDnXM54Jyb2v+1oTqt89aWyxuPW09cDaOzKyU=
X-Google-Smtp-Source: ABdhPJzAPYR0uf8y2eNMmxED83Fb7s7endZB1liLwgdPoTxGWHX3OM4HVMDWV1qMp5srid7ojM+cakKmbAlZzMYcPas=
X-Received: by 2002:a1f:9909:: with SMTP id b9mr20020985vke.22.1622587757947;
 Tue, 01 Jun 2021 15:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
 <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
 <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com>
 <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
 <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com> <87wnrd9zp8.fsf@meer.lwn.net>
In-Reply-To: <87wnrd9zp8.fsf@meer.lwn.net>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 1 Jun 2021 18:49:06 -0400
Message-ID: <CAO658oW-_-bOX=xZNjzR=S89rY99gzuwh8Ln9MNtgA4zkwEh+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 1, 2021 at 3:01 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Grant Seltzer Richman <grantseltzer@gmail.com> writes:
>
> > Jonathan - am I missing something about how we can version libbpf
> > separately from the actual kernel docs?
>
> Sorry, I missed this before.  I guess I still don't understand the
> question, though; could you explain what the problem is here?  Apologies
> for being so slow...

No worries, thanks for your response and feedback! I made it confusing
by not including v2 in my second patch series (this is v1)

Andrii cuts releases of libbpf using the github mirror at
github.com/libbpf/libbpf. There's more context in the README there,
but most of the major distributions package libbpf from this mirror.
Since developers that use libbpf in their applications include libbpf
based on these github releases instead of versions of Linux (i.e. I
use libbpf 0.4, not libbpf from linux 5.14), it's important to have
the API documentation be labeled by the github release versions. Is
there any mechanism in the kernel docs that would allow us to do that?
Would it make more sense for the libbpf community to maintain their
own documentation system/website for this purpose?

>
> Thanks,
>
> jon
