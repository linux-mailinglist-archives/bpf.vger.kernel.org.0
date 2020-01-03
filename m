Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E137512FF47
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2020 00:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgACXxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jan 2020 18:53:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgACXxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jan 2020 18:53:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so31266356wru.4
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2020 15:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dz/v20Hft+ZxPT9oFbtS2gq/bqz6agzFQsRm4OWF9jI=;
        b=dManOXxGrlMaiJ/ynRgu1yCFdEcpD/AOSQkNls79QUWBWSYjqzY2BKe0B0CrbI6idm
         /dTj664fZOcZ3w0IhkkGvGKo0ZgQ5ovhCuxPUi0qIp8QbhJLqznWHjkdBBukcve8aOSq
         D6Arnnq/Btsydx/BvYbkVW+yAtU/2+76NlCYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dz/v20Hft+ZxPT9oFbtS2gq/bqz6agzFQsRm4OWF9jI=;
        b=qYNo3dfeKchTB23XAuzdzZXCnvb4SpBZ5izaItIx5ONTs9U7wWz/2amLbJ8JCGyghN
         Qe5Ya7AGc6kadl9Ar5H7ueBNsjpgZOs2rtrdmQ7d6SIpLgdDxDb7CkIdaVfSzPxcSsxp
         +9gNyqDJNKU7o6bYs336KsTrxGM5hU6S58FY3yHItC8F2rG4+Nn9X7td25ZP0dVSVgxA
         MrxrW1O+y3bkfNiF7Szv+agtNoVHkX9ykoJbyrXgwlR6J+WhJn5sT1gZYj1OfnboLv05
         fqns81a6FUK3Pcw4l+WYUas+vOeqCrYIP9UJG43qHsRlNYm92OPJecbVF6rVM5GzJF0d
         s+qw==
X-Gm-Message-State: APjAAAVpek4zXDyQH/0PDrQYnEB3mPpKl63k2KdTCXKfCTpf/D1xNiVB
        m1SgzfM6532jyRZzf3qFtJyAPw==
X-Google-Smtp-Source: APXvYqyy67BT7vikizrc7raGZc5Z2eAyOslGHtOakkXofnQQZkbJeV/hbYbJMF/rPU0jTVIAfDRp1g==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr87185425wrs.376.1578095579772;
        Fri, 03 Jan 2020 15:52:59 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id n14sm13436895wmi.26.2020.01.03.15.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:52:59 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sat, 4 Jan 2020 00:53:13 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files
 in securityfs
Message-ID: <20200103235313.GA23199@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-7-kpsingh@chromium.org>
 <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com>
 <20191230153711.GD70684@google.com>
 <201912301119.B475C474@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912301119.B475C474@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 30-Dez 11:20, Kees Cook wrote:
> On Mon, Dec 30, 2019 at 04:37:11PM +0100, KP Singh wrote:
> > On 23-Dec 22:28, Andrii Nakryiko wrote:
> > > On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> > > [...]
> > 
> > Good catch! You're right. These macros will not be there in v2 as
> > we move to using trampolines based callbacks.
> 
> Speaking of which -- is the BPF trampoline code correctly designed to be
> W^X?

Thanks for pointing this out!

I don't think this is the case as of now.

The dispatcher logic and the tracing programs allocate one page where
one half of it is used for the active trampoline and the other half is
used as a staging area for a future replacement. I sent a patch as an
attempt to fix this:

   https://lore.kernel.org/bpf/20200103234725.22846-1-kpsingh@chromium.org/T/#u

- KP

> 
> -- 
> Kees Cook
