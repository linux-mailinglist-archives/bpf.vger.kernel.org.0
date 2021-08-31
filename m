Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8207E3FCDE0
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhHaTeW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbhHaTeU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 15:34:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1185EC061575
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 12:33:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so280745pjx.5
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeZDQrDqcQAGLQrz/I7TpVM8SJTv7M0K+gxKgXhgs68=;
        b=sihN7oBbJ5I86jLv3PK9u4Byc4gBeGvz8Ye0A6na+tMx6ajWusgiLhlbPCBC33ST84
         OVb95mkFiuQJaB3sPO0WgKOT1n8azLxkx7WiOUAao7p4XE88p1K7e23eHtbn/HMO0y7D
         1xJj89LKE+NvPnPr/4gQKEVWuQlOPbmAVvfE2dP71dh+UpnsLa2TW0Eqpq92cvCv2tEK
         HrtjDGGV5IKRxxmKu7EiHYls0suFwx3IU0o+HqpUFqIwPxNmGqyGqaNOq4qGkFj+cs79
         tHzBNvlYCUqeFQAz1XFdRVIq9TnLOD0UTwn/Viqw4G0WwC8nTyCMZz+kRIjbleGxQKz8
         cabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeZDQrDqcQAGLQrz/I7TpVM8SJTv7M0K+gxKgXhgs68=;
        b=Gm9G4FA7d0aVjUEP45UTg+NlXXhdTE0HPmEztw7ubvMFUf57fTKTU7og01hs04al5o
         t6pHawKJHQ8XBiPodLPLINsleGA6inOBUKSWd7Dw7sMY9ZHoEMq/GBvgLpwi+VwjjTfj
         ZD9fwgl8JcUDozeS3DlhrehKLkxraen31BO35PMLyma1Kx70dfbh1mXet99J3eA8mXo3
         L9Bf/yeLFt+Rp2FWtJkA4i9eloI/lwlk1hs3cTnf7JYxP5GCILkdWlkgV5YbbH1DY5vA
         CI9dEyCMwqGm67ietznWB04j6P0VGF5mpRk1btUNN12bhNxVs3g5oLqYzI7fUBh/Xj7x
         bR9A==
X-Gm-Message-State: AOAM530W4UMpcMgAS45sTBXY+J5edzv+mG1Lll7LwiEFZGO6B0Nh2Bpy
        R3o53f3CFrWL9g4h1WNhNxq5rM4jIKXeY7nRfeM=
X-Google-Smtp-Source: ABdhPJytBhVukO2jdqYC6k6SfCzt4JsmdxqHHkEEWxRwvqIsxz7eLQH16MWYU6EaEI4ygIG46RGrmte4IOlnGrkI+HU=
X-Received: by 2002:a17:90a:a0a:: with SMTP id o10mr7301603pjo.231.1630438404514;
 Tue, 31 Aug 2021 12:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com> <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
In-Reply-To: <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 31 Aug 2021 12:33:13 -0700
Message-ID: <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "sunyucong@gmail.com" <sunyucong@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 12:08 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 26, 2021 at 11:18 AM sunyucong@gmail.com
> <sunyucong@gmail.com> wrote:
> >
> > Reporting back: I tried a select() based approach, (as attached below)
> >  but unfortunately it doesn't seem to work. During testing,  I am
> > always getting full timeout errors as the socket never seems to become
> > ready to read(). My guess is that this has something to do with the
> > sockets being created through sockpair() , but I am unable to confirm.
> >
> > On the other hand, the previous patch approach works perfectly fine, I
> > would still like to request to apply that instead.
>
> Ok. Applied your earlier patch, but it's a short term workaround.
> select() should work for af_unix.
> I suspect something got broken with the redirect.
> Cong, Jiang,
> could you please take a look ?

Like I mentioned before, I suspect there is some delay in one of
the queues on the way or there is a worker wakeup latency.
I will try adding some tracepoints to see if I can capture it.

Thanks.
