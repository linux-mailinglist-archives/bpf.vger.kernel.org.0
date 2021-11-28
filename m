Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC65146080A
	for <lists+bpf@lfdr.de>; Sun, 28 Nov 2021 18:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhK1RaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Nov 2021 12:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235073AbhK1R2H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Nov 2021 12:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638120290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2I2UUd/Y3ibOkvKx2aPdI/birA/k8JHGGbXx66nCrG4=;
        b=Cd9QsR9w57afm+UK6harx9yql6ylhng8pDrA/thoBkmURsEWG20qrOasD+ZIZ1raYVscKG
        sfHNwFIY7ZpYLbfDfGTXlLhnyuO+1GXGJrDUv7Jg4dCTexUEASLowZug/n0H25ufiCLp3G
        K+DMuJ7IJRncp1u9HcIu1nSt9D7rWt4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-O-8_RfwXN_23TQIIMzpBIg-1; Sun, 28 Nov 2021 12:24:48 -0500
X-MC-Unique: O-8_RfwXN_23TQIIMzpBIg-1
Received: by mail-wm1-f69.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso7728618wmd.8
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 09:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2I2UUd/Y3ibOkvKx2aPdI/birA/k8JHGGbXx66nCrG4=;
        b=Y1+fkBOrhnpojn2miRjajrlKcOd26ecOdmTHYq1F2/408lefMNjouNVGG0TprvLXvQ
         rjhow2BX+EYpOoRPa4TwlCrq48KfwXT4LQzJCz1W4TS9FiEPE8VISeTpODQk73jdmhgj
         Dz/TKMZz4EOpDlSKP3F1c6oyVUCmbE1xS1gN+3Z2kcJ7XOOfzY9nDV1uBBpAC6GL5Cs1
         32BRs+DbvmsK2rLcsrCC0qQaOxM9HI9ZiDSLhmS3ROfIFAwMMpBUwi3ONeJ7HXgZW5ZT
         DAejAxwUXM3PmWeBKiLYeN8iqGrvtwwECf1wd/G/1caKpbPjONUKeliz9pu6ojsQS/Zl
         1h3w==
X-Gm-Message-State: AOAM533esqfwmS9Fbgzs8w85sRz7343PcWNpMJ2v7Z35DDg7ClOMUZ39
        W+C7slAfX76fl+mM6bYR/GWkfSRcSe5ajitMcTpiKDvsKRNLfsY/yKKHjSbtcRBdab1hEu+hqn2
        aNwa4AOWYEFfG
X-Received: by 2002:a05:600c:1e8c:: with SMTP id be12mr31607830wmb.4.1638120287470;
        Sun, 28 Nov 2021 09:24:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOLjOGpE6bw3PNu3qXlEy1Mlm3200tLGAlZWOu64AOtlMwbqpNQLU0fzBoBTrngO5ptf/SBQ==
X-Received: by 2002:a05:600c:1e8c:: with SMTP id be12mr31607808wmb.4.1638120287275;
        Sun, 28 Nov 2021 09:24:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id x13sm11513672wrr.47.2021.11.28.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:24:46 -0800 (PST)
Date:   Sun, 28 Nov 2021 18:24:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next 08/29] bpf: Keep active attached trampoline in
 bpf_prog
Message-ID: <YaO7XAwPBmwp3ulP@krava>
References: <20211118112455.475349-1-jolsa@kernel.org>
 <20211118112455.475349-9-jolsa@kernel.org>
 <CAEf4BzbZZLedE+Xbsu5VewtJThEzJZYiEn4WMQ-AjfiGeTAAAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbZZLedE+Xbsu5VewtJThEzJZYiEn4WMQ-AjfiGeTAAAg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 01:48:09PM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 18, 2021 at 3:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Keeping active attached trampoline in bpf_prog so it can be used
> > in following changes to account for multiple functions attachments
> > in program.
> >
> > As EXT programs are not going to be supported in multiple functions
> > attachment for now, I'm keeping them stored in link.
> 
> can the same EXT program be attached twice? If not, why can't you just
> use the same prog->aux->trampoline instead of the if/else everywhere?

I recall that was my initial change, but it was clashing with
fentry/fexit programs because extensions are special

I'll re-check and try to make this generic

jirka

> 
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h  |  1 +
> >  kernel/bpf/syscall.c | 34 +++++++++++++++++++++++++++++-----
> >  2 files changed, 30 insertions(+), 5 deletions(-)
> >
> 

