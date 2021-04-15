Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED73604D5
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 10:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhDOItE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhDOItE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 04:49:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ABCC061756
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 01:48:40 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v3so1987145ion.12
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGpQmD8z18WLh24i3s/c04WSZmqln4MYd6I/+Ba9nTk=;
        b=gZmtcy+eX8ObZZFLaI6Ns1fmn0cWQTW+BKgfKD2iXzO4w/C5K8rsNDtwtLkCavP3Jd
         XI6AbAqT0Fse4062/D7Wo1yf+oCuoc4Rc+zkovlGQZlYwQx+XKdzAuLLjULdDdiBJQio
         egMdgYlBdh/VL7LGQc2JWLukOLfJCp71p+tuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGpQmD8z18WLh24i3s/c04WSZmqln4MYd6I/+Ba9nTk=;
        b=DrVKrMO528eeAF5TSgx89+fVKPhHpRxK6Ft429GTQ2rPShuct9aZ9ikLdHg4nW0FLJ
         TELyOq9D5lilPPtSgtwsRo7gZ+09aJnfbfqwMtKti6RP4RjKZL43xk2764bWr+IEoBaw
         jhlK1itXZQKp7FM2ERgT7WL29VfDbv1PAWQPgTsnghbE10KbJIWO8XYJODD8uTrsM/Ut
         NEss2JICZgtUl0hktT8oWgp9WyuzH4jiarmKw7Yy5BA64Z2E+PKNmGVpM1NV+ycvcFli
         dksskbhrXcWRxKDe/eZSHz5jyPPTgiOsk53c6KaNF4fxufnNSlv4rGf+fWWq3Qv2D4er
         DRGA==
X-Gm-Message-State: AOAM533zi7nW3GLwLGr5pAnQmN2/qFDoZ8Rbxi383FhGekA8BiCMNQVJ
        LPzMAN90yFZNWg4JfN1U35qmfphktkmEWZEjx0O6FQ==
X-Google-Smtp-Source: ABdhPJyqiY4Ia67vLGdEOkZLYYDMrE5kUb0hhhGrkKPhlpv+wW/ourPqX/Ka+p/fjnaN28eLFO88M6YcfUQIeYfxDnw=
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr1942822jat.110.1618476520114;
 Thu, 15 Apr 2021 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155632.737866-1-revest@chromium.org> <20210414185744.y6x4pmnkqph5tmnb@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYT6mvExWGKGBgrfJP9FCWc9uzcYK_mh5_-ZTUYAATZLA@mail.gmail.com>
In-Reply-To: <CAEf4BzYT6mvExWGKGBgrfJP9FCWc9uzcYK_mh5_-ZTUYAATZLA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 15 Apr 2021 10:48:29 +0200
Message-ID: <CABRcYmLdJoHB5tYsAV+huToqh0d1p5LhusQRNgrVRVNgobjkjg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix the ASSERT_ERR_PTR macro
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 15, 2021 at 2:28 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 14, 2021 at 11:58 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > On Wed, Apr 14, 2021 at 05:56:32PM +0200, Florent Revest wrote:
> > > It is just missing a ';'. This macro is not used by any test yet.
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > Fixes: 22ba36351631 ("selftests/bpf: Move and extend ASSERT_xxx() testing macros")
> >
>
> Thanks, Martin. Added Fixes tag and applied to bpf-next.
>
> > Since it has not been used, it could be bpf-next.  Please also tag
> > it in the future.

Sorry about that, I'll make sure I remember it next time :)

> > Acked-by: Martin KaFai Lau <kafai@fb.com>
