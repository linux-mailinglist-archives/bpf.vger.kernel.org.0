Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161FB3FB237
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 10:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhH3IDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 04:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234059AbhH3IDp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 04:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630310572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rXrubIEC2DMSUpM/+V8SVHvpGY5IIt96CE00R1zKyYM=;
        b=U2gTqR0dHaS0kupjRZAICwc0KerwjRAnimtkWoCAANRBpsH6N3MhGChnC6lt5CeqMl4n5Y
        4Kqi3oRBnlBkDxHKohN45p/rskAV8rzDx6js344pmgSdjC5UlYHTEuWKKMMr+Z2xavYOug
        BsZf6qyNbiql4O/kwjByOcR6up7rNyY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-07vFYQNvMTqOeLLYcfpadg-1; Mon, 30 Aug 2021 04:02:49 -0400
X-MC-Unique: 07vFYQNvMTqOeLLYcfpadg-1
Received: by mail-ed1-f69.google.com with SMTP id o11-20020a056402038b00b003c9e6fd522bso2487614edv.19
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 01:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rXrubIEC2DMSUpM/+V8SVHvpGY5IIt96CE00R1zKyYM=;
        b=hlBskPxHmognSmQdO3CmAmLgu42ctiqyDkqxQ0zF6ipQetJUsa+/JrafY7e+VcWa2O
         Qufr88abN1rAaEetyTEGFQMtuI605AfRPP09QcfZr8S3Z1pGKeJRvO3JL+M1uEpyNcz0
         XksDK7AKtUBGA7TB+79Tm+hX0/AsnBytvGWON5caQtGnrG2AxuxASQihDyonXjK8jLrl
         WINqIPZVpUoHHXndtou/+xgzA+xdAU3bhYSRQwYTUpF7MGZb4BcHvpMSsyieW+igcft/
         0TOTC6qACUyO3Y+0rnv2cGByybo6AtEgx15mfmQF1XzV2AP1ielvrlXwKncnM7qNq6K1
         oY+w==
X-Gm-Message-State: AOAM530amKebPlQEi13sNRdTtBvHCAD3b0mNt34k3qjQSWVxGL1gB30+
        EBi7Rjq6vJTp4fjvU4R5cOZbznR0TgJyAAwtrLHyLN7Z3P1jODosmQpXY2te7UmzgKaaxxNxbUM
        SM8wmmH5JXkCP
X-Received: by 2002:aa7:d601:: with SMTP id c1mr16316428edr.143.1630310568104;
        Mon, 30 Aug 2021 01:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXcJW8oDEN0ZkObgpaUFwYy7NjLN/KkIEO0WkUwvPs1b+YMrZrZnVlhkNQV+KbC4oB0CA4+g==
X-Received: by 2002:aa7:d601:: with SMTP id c1mr16316412edr.143.1630310567996;
        Mon, 30 Aug 2021 01:02:47 -0700 (PDT)
Received: from krava ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id r28sm7351905eda.84.2021.08.30.01.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 01:02:47 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:02:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v4 00/27] x86/ftrace/bpf: Add batch support for
 direct/tracing attach
Message-ID: <YSyQpYCsrV3lm8/6@krava>
References: <20210826193922.66204-1-jolsa@kernel.org>
 <20210829170425.hd7zx2y774ykaedt@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829170425.hd7zx2y774ykaedt@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 29, 2021 at 10:04:25AM -0700, Alexei Starovoitov wrote:
> On Thu, Aug 26, 2021 at 09:38:55PM +0200, Jiri Olsa wrote:
> > hi,
> > sending new version of batch attach support, previous post
> > is in here [1].
> > 
> > The previous post could not assign multi trampoline on top
> > of regular trampolines. This patchset is trying to address
> > that, plus it has other fixes from last post.
> > 
> > This patchset contains:
> >   1) patches (1-4) that fix the ftrace graph tracing over the function
> >      with direct trampolines attached
> >   2) patches (5-8) that add batch interface for ftrace direct function
> >      register/unregister/modify
> >   3) patches (9-27) that add support to attach BPF program to multiple
> >      functions
> 
> I did a quick look and it looks ok, but probably will require another respin.
> In the mean would be great to land the first 8 patches for the upcoming merge
> window.
> Jiri,
> can you respin them quickly addressing build bot issues and maybe
> Steven can apply them into his tracing tree for the merge window?
> Then during the next release cycle we will only iterate on bpf bits in the
> later patches.
> Thoughts?

sounds good, will do

jirka

