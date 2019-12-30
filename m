Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3412D3DA
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 20:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfL3TWh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 14:22:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38325 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 14:22:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so33578299wrh.5
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 11:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JkX2oSDnh82+FOtFNWSP00gBv2TAto47pBCaokVhsVI=;
        b=MyCZhyESEZ0yOrjZ9KXf3D7EvtTFqrbHDr60Q7K11ad6u+gSWa4D6c3Ft2OGcKa+Yq
         Huy09DmlVd8yj+uRb0FJn5BgzSBsfZFxyqNPmLmxFRkt+wgiyUArhBPtTN9/f4YIB+0a
         oyJZIE3j3q1TG4pRSdanDgX/3xNebSHB78z5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JkX2oSDnh82+FOtFNWSP00gBv2TAto47pBCaokVhsVI=;
        b=AEDotNeNMU3M3EPBvUbt2tZzpiEN01MQnk3jAXHqO+6c/wgo77gm5nohO4ya7RlvqS
         FPwmqmV2FfYj0nBo7/K+D1o7BgBXzm0cZYg1FpgfBiFFgWr3LpHERCGgl42qZJl+dteR
         f3j8COjtticGwI5FS0KEja0F4vOEmaZnQ+G9JTsfLoBg88jO8R1v16yShifbH1nKZxQX
         +OPI2ArPkVjwgqPYUVJiZiIECOhvpI2eLomAfn+ssBnSFQgioWz0LhdM/vDEM5MUl+dB
         466O+PMtQgwXUCi2q/L/EehinAq6UYrye/aF82vNmY1JCj9hg+3sSkQsQKdcg6vdqFrA
         I2Xg==
X-Gm-Message-State: APjAAAXNTkIBVd65bCmtaWAXbGHORw1Q4ys/SGPzg1XySuPdiRShR1b8
        MyfPp93LRA4EByA5dK6wRr/4Bg==
X-Google-Smtp-Source: APXvYqzO25xLhTU4tJiAoLT017mrSm61RORVAkMV3VG9DIFbvIuQeAiXlFd29he6wihEbG2WuC5J1A==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr70138449wrm.345.1577733754642;
        Mon, 30 Dec 2019 11:22:34 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id i10sm46984941wru.16.2019.12.30.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:22:34 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 30 Dec 2019 20:22:45 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH bpf-next v1 04/13] bpf: lsm: Allow btf_id based
 attachment for LSM hooks
Message-ID: <20191230192245.GA18663@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-5-kpsingh@chromium.org>
 <CAEf4BzaJ7YdSofV9-_D5zGC4GrwRvdPY3xyx7p+1rPD=Km2aXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaJ7YdSofV9-_D5zGC4GrwRvdPY3xyx7p+1rPD=Km2aXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Dez 15:54, Andrii Nakryiko wrote:
> On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Refactor and re-use most of the logic for BPF_PROG_TYPE_TRACING with a few
> > changes.
> >
> > - The LSM hook BTF types are prefixed with "lsm_btf_"

Got rid of this for v2 as we are using trampoline. Will keep this in
mind if we ever need to generate type information. Thanks!

> 
> btf_trace_ and btf_struct_ops all have btf_ first, let's keep this consistent.
> 
> > - These types do not need the first (void *) pointer argument. The verifier
> >   only looks for this argument if prod->aux->attach_btf_trace is set.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  kernel/bpf/syscall.c  |  1 +
> >  kernel/bpf/verifier.c | 83 ++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 80 insertions(+), 4 deletions(-)
> >
> 
> [...]
> 
> > +
> > +       t = btf_type_by_id(btf_vmlinux, btf_id);
> > +       if (!t) {
> > +               verbose(env, "attach_btf_id %u is invalid\n", btf_id);
> > +               return -EINVAL;
> > +       }
> > +
> > +       tname = btf_name_by_offset(btf_vmlinux, t->name_off);
> > +       if (!tname) {
> 
> it can be empty, so better: !tname || !tname[0]

Will fix the usages in v2. 

- KP
> 
> > +               verbose(env, "attach_btf_id %u doesn't have a name\n", btf_id);
> > +               return -EINVAL;
> > +       }
> > +
> 
> [...]
