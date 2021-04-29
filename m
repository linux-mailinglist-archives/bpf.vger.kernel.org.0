Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858C036E74C
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhD2IrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 04:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbhD2IrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 04:47:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74500C06138B
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 01:46:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e25so35839108oii.2
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYJ/i+SyDWuXeltdyQRtqtcL95TciOlmlQ2w0jknE48=;
        b=pL/eJr3nZ1xPXLcRvl0U4RW4El5I8fT5ZC3v52Qmlslf9BOJWoOnByIYODbo7VWxZN
         gvNtg2QGNUyVoKYRtfdyuchvx2ZUZczbs/bhGEgyt3Kyh73GiDnclQczVT3mWr1tNnVF
         n8jvU4dfHi25Dns1SHDJJW7HWJzxfAvoVX/Za5OJoueFl8wCOnNX5g40cfRddEas7dln
         4ooWV7jq0UDZwy6gz6025xNHxdIqg7qF9rhuiF3ds/2Sg9hjzM0JLq4ipWf4sxnj0dWW
         WvXstLLdiaOeVizGBD/xIIJBj7j+rNoCtfHxsn684meB9CcHSoHwTwapwZLWUr8Iz5KB
         F7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYJ/i+SyDWuXeltdyQRtqtcL95TciOlmlQ2w0jknE48=;
        b=FhgPJXmgRXfPZ5d9TgYvsCxKSOmqZHOMBzjl2wcH+Ep15dgW1X71zzUVeyCu5PZEt8
         A3cnen/pCYpS0ITu6Iy3JUitDo0P+wxYlZIBpOk8UcRlQqaTT6XBMCmXlrMzoWwDODVy
         C64YmQxCEJ6jZm7wd1P/aOxxlRn1ss2ij4Bw2p/qhkMMZAMcuxEaLfxmeWQrYbX8X5Py
         F7Ts1Z4lfOBNzzq7wxHNUc0DUgWytNsjZNYBabNHBsHECkPwyAss09EAshuZ5QP3gPp3
         /Zb4KDPl9kIEm3tKmI0dZXcQBsM4y5b4BFdS2sU2JEYAAGyWBroNvRqr/MeDP5XYbvYM
         1QxA==
X-Gm-Message-State: AOAM531+CTmdG9yb4Vp9wzu0RfUnUL6+CvEOf/s2H+a3GIttbn534X3j
        ic01S9pYSbmqfZ2Um1NSWip3mfN2mCaRAMYEUXwycA==
X-Google-Smtp-Source: ABdhPJyCkp8J3VRA0ewFkoQykIwlYkcZbVoeMyqGaTtHvZE/zViErogzzqFjCPiXR/2ErhCqVeYfbzmswfnNNdh7rQs=
X-Received: by 2002:aca:a814:: with SMTP id r20mr1142692oie.104.1619685978667;
 Thu, 29 Apr 2021 01:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210427170859.579924-1-jackmanb@google.com> <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
 <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com>
 <CAEf4Bzb+OGZrvmgLk3C1bGtmyLU9JiJKp2WfgGkWq0nW0Tq32g@mail.gmail.com>
 <CA+i-1C2bNk0Mx_9KkuyOjvQh_y7KFrHBU-869P+8oTFq8HdVcw@mail.gmail.com> <CAEf4Bzb1ZNotcB44cDauAkAbs4R=UvPRKP1KWNbLg1k1jH25mA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb1ZNotcB44cDauAkAbs4R=UvPRKP1KWNbLg1k1jH25mA@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Thu, 29 Apr 2021 10:46:06 +0200
Message-ID: <CA+i-1C3YJQt60FBaOg3pHD+BG6kuUK1Z8RiZ87O9+WSr1Ynbyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 28 Apr 2021 at 20:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
...
>
> Yep, let's cap. But to not penalize a hot loop with extra checks.
> Let's use int64_t internally for counting and only cap it before the
> return.

Cool, sounds good. Patch incoming but I'm on interrupts duty this week
so might not be today/tomorrow.
