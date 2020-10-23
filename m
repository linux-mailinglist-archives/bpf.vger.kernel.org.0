Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8C297836
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 22:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756033AbgJWU1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756082AbgJWU1x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 16:27:53 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653CC0613CE
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 13:27:53 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c3so2248698ybl.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFXm37Qr5xXi36i8NUhvr6aKhojTpRtpohdMplDqryw=;
        b=W2kEhKQ/kBhsqERVmQrIizVahLcu+yz0wJ3dmoSn5SPZfmrHxQ8qcyoD9CdpwQc/H/
         Y69GMMtU5efOkU/72dTXoUE7zdRKcZTCYOlHfTIxtB9AbzwLuVOYrtwDiRUZrhEK3dBf
         g/a++UQMdLADO5dGP1xSIN+oBTW6E1axOrPgZmZXnBY3QNpfkpxsLWHYaDEQ+7Dzp17M
         zyr7AYCEUE9QdAJdy7i2wVqzj9Ez+PNKHpP1QGpcOGl3rXK7ilF4ONaWazuIM7e1l0u2
         3I8v+ypzcay/EbtPfFicFHnZ5j39wueSasK5xKFXdQ+NU8EChXQirEJSR48sOMymmvn2
         SJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFXm37Qr5xXi36i8NUhvr6aKhojTpRtpohdMplDqryw=;
        b=M23Jj1/sthACSzLPZyHZIs7bswBR9jp6JcF6SouykaO63mnwX2A5kTuolv03JPl/Uz
         oVoxRCyiddl6q2aYu1YsYhqRudG5MwG8rYCtS8IZPGYacJGxw4PGt19fMkAdyhidzN7T
         oDuANeooE7iKNzIjpM1c7vZPWzM15toDZqYYNkG44gGXE1D0HD9OnU+H5t9p5bjQXw9C
         ek6b+LQjChzthl6nDVDGJSftWC2oUsHna54vNY/oxlrVRMZEyzohSOC9WTr8f7oGQwqA
         lV0xXj1NNBcIRUi1OOawHkXBBU9u15PCk9glkclf09MWzbTz1UEdJb3NQqHTW5Y6P8ke
         +ZBg==
X-Gm-Message-State: AOAM531mxI79oIYdmc9rtpkP4AwsuI+sK1VR89QIsEUyXWpFB7xjMXOQ
        mhICTwMcmCoXYqqSCELSy5ZxdURFqZTVGW0e4LE=
X-Google-Smtp-Source: ABdhPJzxOAUST4a6puV252W2th1Q5oaPSKJJN0h9vPNBpU3fxEI9vryxrbiXqQRtQleJbbhR9zvl2sKAvubctwU8LKU=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr5897854ybf.425.1603484872899;
 Fri, 23 Oct 2020 13:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200922190234.224161-1-dev@der-flo.net> <20201013144515.298647-1-dev@der-flo.net>
 <5f87ce648edd5_b7602085a@john-XPS-13-9370.notmuch> <20201023163518.GA4777@der-flo.net>
In-Reply-To: <20201023163518.GA4777@der-flo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Oct 2020 13:27:42 -0700
Message-ID: <CAEf4BzZ4OYxA9YBtV+NcktT5EvA7a05xzn_ry8gWgVcN5GstJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Lift hashtab key_size limit
To:     Florian Lehner <dev@der-flo.net>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 9:38 AM Florian Lehner <dev@der-flo.net> wrote:
>
> On Wed, Oct 14, 2020 at 09:21:56PM -0700, John Fastabend wrote:
> >
> > OK the check appears unnecessary. It seems a bit excessive to have
> > such large keys though.
> >
> > Daniel, Alexei I couldn't find this patch in patchworks, not sure
> > where it went.
> >
> > Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> Is there something left I have missed to address?
> Or should I rebase the patch and send it in again?

Yeah, please rebase and resubmit. There were some problems with
patchworks and a bunch of patches didn't make it to the system. Yours
might have been one of them.

>
> Thanks,
>  Florian
