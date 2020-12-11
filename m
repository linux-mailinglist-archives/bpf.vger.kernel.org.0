Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92A2D81DC
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 23:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393872AbgLKWUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 17:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgLKWUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 17:20:33 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F62C0613D3
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 14:19:52 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id m13so12653878ljo.11
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhoimQ4TE80Yt43AyVKOmmGSRCJ6xQhz+9Gw3hSE5P0=;
        b=MdbBesD+ewQgAwbSmzpYytassAwftrwtvrix1dDl3gIt8Y9BHNN/NQZLEAXgvmqvBs
         a83FuobEOYujLAudMc9oWwp8GR5xDj31629toFGiL6bn7wj1R4fbMONH1IoeLjvF4awQ
         b948GicniREMnljXqJjepci2Rb3eGNtLlaEKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhoimQ4TE80Yt43AyVKOmmGSRCJ6xQhz+9Gw3hSE5P0=;
        b=sbwvUD0TqoRfoEiRJ8dqgitXr/A+bQOObDYjYmzQBlog2L3n2vYBHmMl2bGRiQK+0Y
         Q9XHB9ork6uHdsoA5PGjDMnNRBXSi3MEvhHV4iGNc1FEEmGTYcE/ezYlgwVstcdC5muQ
         Bgy2amRxYUl5zeOeF9TngGvH2hqwRTfEtUstS4okIpCp4wjyF1dgNEbkg3WWaPdmZqfv
         tU4hB22YPydxtf6UUkGdjiePN69zUQczyn3tycdwLadr5peQxPOLroy9BmpBImShjZ+D
         4BBQwgTTlnX+Sx3keezaSqXs0i0wRsBFrXpX+WkyRH5pIaVesKzoDwfnTk16qI3x/U8S
         H4mQ==
X-Gm-Message-State: AOAM531Wp7Xoh2gjghohBEPZj9Ft8lwYjsAfqE3mMzlWI2pEawr+RkA8
        8VfT2U139hulWkC5G+83b3KvQ0DrWXJ41g==
X-Google-Smtp-Source: ABdhPJxlh+0BGqLMO4dFMhpMcFK1nNEp68Rr9jcNcfoD6gFvVkZ1BA8WKd52MF43c5QDv8JOr4S8GQ==
X-Received: by 2002:a2e:b8d1:: with SMTP id s17mr6013431ljp.472.1607725190802;
        Fri, 11 Dec 2020 14:19:50 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w12sm1028314lff.181.2020.12.11.14.19.49
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 14:19:49 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id x23so12680863lji.7
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 14:19:49 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr3387676ljj.465.1607725189270;
 Fri, 11 Dec 2020 14:19:49 -0800 (PST)
MIME-Version: 1.0
References: <7c371fff2427c749f32523b9a4b834fe2dd1d58e.1607712517.git.daniel@iogearbox.net>
In-Reply-To: <7c371fff2427c749f32523b9a4b834fe2dd1d58e.1607712517.git.daniel@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Dec 2020 14:19:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK70-57sH3bnEYQcjPB-Q-GfmdS7G88d2uASSDJ3d2Hg@mail.gmail.com>
Message-ID: <CAHk-=whK70-57sH3bnEYQcjPB-Q-GfmdS7G88d2uASSDJ3d2Hg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix enum names for bpf_this_cpu_ptr() and
 bpf_per_cpu_ptr() helpers
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 11, 2020 at 1:36 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
>  [ Hi Linus, this small fix came unfortunately after we sent our last bpf
>    pull request to David's net tree, and as far as I'm aware no further pull
>    request for final 5.10 is planned at this moment from David's or Jakub's
>    side. If you could apply this last fix directly to your tree, that would
>    be very much appreciated. Thanks a lot! ]

Applied, thanks,

            Linus
