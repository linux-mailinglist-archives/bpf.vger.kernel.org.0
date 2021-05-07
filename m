Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5E37627A
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 10:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhEGJAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 05:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhEGJAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 05:00:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A55C0613ED
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 01:59:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n205so4815579wmf.1
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/nh1bbQT5CiK8IqERbTeRh4gKwm6+O6Vg+VARq82rio=;
        b=ddP9vw2/xz6l5rgNknMnioGUpBwslhkhK/Vqn+Kl45rxtCUI1B37VPu4ncHEAzfh5G
         lraIDVUeYC1DCwyViD6+lq/nLpHJ7NVA4UnG4dIh03OPLcXFQHOCKIsy6MTCyG7IvMTN
         ggSkExoADblSOWRHwZ8hPSr4yuGq19xGJhDe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/nh1bbQT5CiK8IqERbTeRh4gKwm6+O6Vg+VARq82rio=;
        b=IujjpF+aEUJOff7M462P6JFAJHnQtI4l2FS6OstGWAlMh4WPHwXvhw6ljB46lc1QAc
         WQ1lkBLnuy9hig35heyT3MpNvfuCPXFga0YKOAlz1nPEYtfdGepiiMhnAZVe319HZ1/q
         vy+R+DqTtQeyZz10DpWxIXQGKt7LASGeLbl3JUFpHsc+tYyAM7EhFaJe12+ZlsAbo7x0
         lE4nE1j+5dnfKI0ApehIBvYQptB5DbBXrkbXWttgQvWFW2zwX6vGXVWXQPSPGHLmfY3l
         GOg4nmffxTlum8yklVeq7oPFczm13/Ky/2q6IxEzOn/bwIGAAbUMvfqPDxd1uYzh1ZuJ
         hIGA==
X-Gm-Message-State: AOAM5323mxiG23Uujg7ufI0fbLAx2NX1xnQxy1P3O9itahMmzrS6VGRD
        vGpQsoIsho5XI1vnyXayERluPw==
X-Google-Smtp-Source: ABdhPJzduMczy9ysbmAMuqtbBG09rD7O4KiM9HF0LInaj4JHW6d0b9TrE4pquQXjf9xl813S56OsKA==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr19619041wmc.91.1620377980995;
        Fri, 07 May 2021 01:59:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q10sm7138710wre.92.2021.05.07.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 01:59:40 -0700 (PDT)
Date:   Fri, 7 May 2021 10:59:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Airlie <airlied@gmail.com>, Kenny Ho <Kenny.Ho@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Brian Welty <brian.welty@intel.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
Message-ID: <YJUBer3wWKSAeXe7@phenom.ffwll.local>
References: <CAOWid-czZphRz6Y-H3OcObKCH=bLLC3=bOZaSB-6YBE56+Qzrg@mail.gmail.com>
 <20201103210418.q7hddyl7rvdplike@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-djQ_NRfCbOTnZQ-A8Pr7jMP7KuZEJDSsvzWkdw7qc=yA@mail.gmail.com>
 <20201103232805.6uq4zg3gdvw2iiki@ast-mbp.dhcp.thefacebook.com>
 <YBgU9Vu0BGV8kCxD@phenom.ffwll.local>
 <CAOWid-eXMqcNpjFxbcuUDU7Y-CCYJRNT_9mzqFYm1jeCPdADGQ@mail.gmail.com>
 <YBqEbHyIjUjgk+es@phenom.ffwll.local>
 <CAOWid-c4Nk717xUah19B=z=2DtztbtU=_4=fQdfhqpfNJYN2gw@mail.gmail.com>
 <CAKMK7uFEhyJChERFQ_DYFU4UCA2Ox4wTkds3+GeyURH5xNMTCA@mail.gmail.com>
 <CAOWid-fL0=OM2XiOH+NFgn_e2L4Yx8sXA-+HicUb9bzhP0t8Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-fL0=OM2XiOH+NFgn_e2L4Yx8sXA-+HicUb9bzhP0t8Bw@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 06, 2021 at 10:06:32PM -0400, Kenny Ho wrote:
> Sorry for the late reply (I have been working on other stuff.)
> 
> On Fri, Feb 5, 2021 at 8:49 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > So I agree that on one side CU mask can be used for low-level quality
> > of service guarantees (like the CLOS cache stuff on intel cpus as an
> > example), and that's going to be rather hw specific no matter what.
> >
> > But my understanding of AMD's plans here is that CU mask is the only
> > thing you'll have to partition gpu usage in a multi-tenant environment
> > - whether that's cloud or also whether that's containing apps to make
> > sure the compositor can still draw the desktop (except for fullscreen
> > ofc) doesn't really matter I think.
> This is not correct.  Even in the original cgroup proposal, it
> supports both mask and count as a way to define unit(s) of sub-device.
> For AMD, we already have SRIOV that supports GPU partitioning in a
> time-sliced-of-a-whole-GPU fashion.

Hm I missed that. I feel like time-sliced-of-a-whole gpu is the easier gpu
cgroups controler to get started, since it's much closer to other cgroups
that control bandwidth of some kind. Whether it's i/o bandwidth or compute
bandwidht is kinda a wash.

CU mask feels a lot more like an isolation/guaranteed forward progress
kind of thing, and I suspect that's always going to be a lot more gpu hw
specific than anything we can reasonably put into a general cgroups
controller.

Also for the time slice cgroups thing, can you pls give me pointers to
these old patches that had it, and how it's done? I very obviously missed
that part.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
