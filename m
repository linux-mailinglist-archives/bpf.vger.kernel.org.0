Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB803FE80E
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 05:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhIBDgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhIBDgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 23:36:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ACEC061575
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 20:35:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k13so1114787lfv.2
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 20:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNFRmYdZ90m1mnu+27sss0ykNq7w/OI56P2XvK0br9c=;
        b=R/LKVvJC5P8YudwWQi55SQhoqMz2vhTBnAArJyI+gANH4WpahcA0Gs5Ytcn0v9NMGK
         0Tit+jJcan4wA0js0LM5FXGb388mNKPpCf+KfBeIx7nc8jkZiiP7ZxpB3q1B0iDJpoHt
         sByRlM9UZhrIQtkmceqH8sRScsmRzo30YvMcbLBYs9F8YS9IOGkTLHegna2ac6C8hk4w
         JFWahnMHQcm3F2riOgGfxH62TEEvHOeHgrIFpxyjO4itq7SDif8bdSybWbSipP0C409l
         WllBwJXlXOCzLn5RBWz4IjAh8Q4n7Sb1Lm/eIFkp1GXfmADnOJ63p4Dt/fPsuUbkFqo7
         52nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNFRmYdZ90m1mnu+27sss0ykNq7w/OI56P2XvK0br9c=;
        b=fYEgVIMBdGPJBo596MvPNvHPbRsPRUXRHLcxyE3hZY694tUjBhiOecUAJ2Av6xGI59
         o8KBBL68Caub0rogWMhm00VPLKJfQJ2gpDdyQT4QqR+s5dHUzd07BBZew6sWq3cqP8Pc
         Yxe67k5160aBfdZVW8DzpHgVgJ8CghqWg1abQw5l+tQVv5exOjJmGK6wFKORkcNjS1gl
         Tmp022QCt6dCE8OK78zl6zyqRmfmg/ZBW0PWW81cmJVrNBmNd6Ty8rgWWlXuBjW6f+t1
         vGes6qcboDu9Hde8Cf+l6bYg4se5f62uyanbfSZgiWr9GUY2IprZf/PydcKvBCNeMuoP
         t12g==
X-Gm-Message-State: AOAM533Xkxpomf00sGx4Lo8duaJAG5qdWDVENfc8FBoDPdYt9AKSpqqm
        niMNk39QF9yi/e5OKRhAyjiqOCYURstoQiI2+/g=
X-Google-Smtp-Source: ABdhPJzhbCYGE+nLAuzXCoJQiel/1mt5iBBeu6zRdtgycKy4WOv6vuDwit8jK0w1Doqwqx8P0GEHh/h1vNdHDsUR41I=
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr948894lfs.384.1630553711387;
 Wed, 01 Sep 2021 20:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
 <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com> <CAM_iQpUG30QL03Uh9D_ACy_29TLWG+YfDO9_GvcqzW2f0TbpYw@mail.gmail.com>
In-Reply-To: <CAM_iQpUG30QL03Uh9D_ACy_29TLWG+YfDO9_GvcqzW2f0TbpYw@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Wed, 1 Sep 2021 23:34:45 -0400
Message-ID: <CAJygYd2f8S5Oq_B8724p-3rQvXaJKMBGgBKLS_0R7fxTew2oeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 1, 2021 at 9:33 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Tue, Aug 31, 2021 at 12:33 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > Like I mentioned before, I suspect there is some delay in one of
> > the queues on the way or there is a worker wakeup latency.
> > I will try adding some tracepoints to see if I can capture it.
> >
>
> I tried to revert this patch locally to reproduce the EAGAIN
> failure, but even after repeating the sockmap_listen test hundreds
> of times, I didn't see any failure here.
>
> If you are still interested in this issue, I'd suggest you adding some
> tracepoints to see what happens to kworker or the packet queues.
>
> It does not look like a sockmap bug, otherwise I would be able to
> reproduce it here.
>

Cong, the issue is not that read() sometimes returns EAGAIN.

It is that when using select on the redirected socket,  it will hang forever.

> Thanks.
