Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5155393BE2
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 05:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhE1DXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 23:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhE1DXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 23:23:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1EC061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 20:22:03 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f9so3621564ybo.6
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpSO3wak9pYbjU8bVRU1mx3RmZJ6cjV0xgjWhYreMhU=;
        b=QPIQ8CvxxmEvIIBUsdW6hXnK5PoAPdgENGNDIBG0JZD494qsCc9/qmN2ew/ieXx0mO
         hKh8mG9r2hkzj8svdeslXdn+KbRON7BMldkgDu5Iuo/p4VRXtDbhlHP1Y9h6s1Wqtmhz
         MzDDxQ1GsqAapG7F0yVd5nFkI6/Xx6drQLzsqagWtJKiOIQM3Ubh6liNb79596ouP705
         LxeidZ8fIhUwKYtRNSMw6pI4orpgr5GLimJglZrv0uKU6qARN2BKrFm60ECxZyXfC4Xm
         YvLV7yqZwxowk3XwaoC5EA8H/5is5zv0ydNkPZSvYYOhWKhEcbFSVA2hnyfZrkKL5g9t
         8g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpSO3wak9pYbjU8bVRU1mx3RmZJ6cjV0xgjWhYreMhU=;
        b=Fu678C8FPnTjAa5Xssz9OTw67SjgSoU7WztNg2l8zEHr0BP0hitRbczKCMSqLtFyw0
         YhFXhD4tIme7Mv2P1Z0WJRhOdqI3ldF7gFcAFmne5v7Cr07oIwGpJ8VWgzbMSRg3tG2/
         VFX8hWJGMTb9uAHOx8hEmbAFTBjReoxn55NvorZQls9eRhCVZxpklb/yu2RFkh4kgW5/
         ANRI4ACMUbAY/+eeit17IZAcoM/3j4MEpf4ghhCaMUJdh4Jz5L+TA0eREs264cwAHEZF
         kFJzHArAbbZDX3XtbYHgvogNIuLEXhl8SAItKgO+xCo9qBGyNa2HtsLddnZRCZqXekWs
         k8dw==
X-Gm-Message-State: AOAM530QqvPJytXTDhhCEnoAp1eVWxJXDNN2MfRMyiNSuc200iNpeLXT
        G1svOogh5PSmiKtTbdd2bAyMapW1AahGLdD/kIM=
X-Google-Smtp-Source: ABdhPJzBOI2LFzQa6pIGPRUk2nYhCbgkmQJvi+ohw5HzCriawKhc0PM0dS2EUAN8I6ciQZ/1gNsU4tfINMuZOMAmMG4=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr9225881ybr.425.1622172122504;
 Thu, 27 May 2021 20:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210527201341.7128-1-zeffron@riotgames.com> <20210527201341.7128-4-zeffron@riotgames.com>
 <CAEf4Bzb=ECAtJAikaeSLomQCcwNC7JnwZxPc=j3=YnPjnfaycg@mail.gmail.com> <CAC1LvL1JM4Wu43XU4aVHHheChtSQQmKRx7RaVBG5Kmkt-edbBA@mail.gmail.com>
In-Reply-To: <CAC1LvL1JM4Wu43XU4aVHHheChtSQQmKRx7RaVBG5Kmkt-edbBA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 20:21:51 -0700
Message-ID: <CAEf4BzZ-DdZk2rnzc40aoepJn=zS1o=-mdW15uz5Cm4Vi6rH5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 7:11 PM Zvi Effron <zeffron@riotgames.com> wrote:
>
> On Thu, May 27, 2021 at 6:28 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 27, 2021 at 1:14 PM Zvi Effron <zeffron@riotgames.com> wrote:
> > >
> > > +
> > > +       /* Data past the end of the kernel's struct xdp_md must be 0 */
> > > +       bad_ctx[sizeof(bad_ctx) - 1] = 1;
> > > +       tattr.ctx_in = bad_ctx;
> > > +       tattr.ctx_size_in = sizeof(bad_ctx);
> > > +       err = bpf_prog_test_run_opts(prog_fd, &tattr);
> > > +       ASSERT_ERR(err, "bpf_prog_test_run(test2)");
> > > +       ASSERT_EQ(errno, 22, "test2-errno");
> >
> > by the time you are checking errno it might get overwritten. If you
> > want to check errno, you have to remember it right after the function
> > returns
>
> Is it sufficient to simply make the errno ASSERT the first thing after
> the function returns? Or would we still need to preserve it into a
> local variable?

Yes, doing ASSERT_EQ(errno, 22, "test2-errno") right after
bpf_prog_test_run_opts() will work reliably.
