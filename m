Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8C128120
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 18:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTRKN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 12:10:13 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:41399 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfLTRKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 12:10:09 -0500
Received: by mail-qt1-f177.google.com with SMTP id k40so8778566qtk.8;
        Fri, 20 Dec 2019 09:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ferOHgTa8+mlLQrIZxEyrkrIqrPKTFyh2LphB/p/Y74=;
        b=Ap0rfrdfbbLbLNGVD/0/6sdxw7QE6ImhrXMatl7LwaEfi8kmACmuENu/+EjXFWhad0
         SyEHb9WaxymkZzKML9Gvm9r7jBw1HjLi6w8CrBmVLVK49Hq9tnvXd1sFi0hWlAnFk5Sq
         OniO8I0UMWWNv0HVOTxbOG7KL7v1Zl/KQDkdx0xhpFGjM+JiC0og1VvAdFIhfdmVTfAK
         o4DQBbwDYgL+Dd2LyKOCnEC9cJPufcceU/oLvKp8tWFycR8wjuWv3S6oWTG4R+kEL7LK
         hK+S3IycE5CIgNFq8lmo2SBSkjB6Q4ZptbAiM9dTXqcLJWx286T5fi4mgZe3+676meyU
         6g7g==
X-Gm-Message-State: APjAAAWuFvohAKWvKyjlfGLPHLhxfdQ9OCC7Z9x92Hs8XZAxVznj4YfU
        ZDwYZNWC4Qj2r/ifOZjC9TQ=
X-Google-Smtp-Source: APXvYqy9wmFFx+y+koK6r++euYWrETDk9FOrHZXQe7LsY/ExxBcxq/00ERtiYrgP1BLTF9s2xAQK7w==
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr12533978qth.311.1576861808329;
        Fri, 20 Dec 2019 09:10:08 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::8d30])
        by smtp.gmail.com with ESMTPSA id k14sm2977023qki.66.2019.12.20.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 09:10:07 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:10:04 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Percpu variables, benchmarking, and performance weirdness
Message-ID: <20191220171004.GA8596@dennisz-mbp.dhcp.thefacebook.com>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
 <20191220103420.6f9304ab@carbon>
 <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
 <alpine.DEB.2.21.1912201536120.16819@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912201536120.16819@www.lameter.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 03:36:51PM +0000, Christopher Lameter wrote:
> On Fri, 20 Dec 2019, Tejun Heo wrote:
> 
> > On Fri, Dec 20, 2019 at 10:34:20AM +0100, Jesper Dangaard Brouer wrote:
> > > > So, my question to the uarch/percpu folks out there: Why are percpu
> > > > accesses (%gs segment register) more expensive than regular global
> > > > variables in this scenario.
> > >
> > > I'm also VERY interested in knowing the answer to above question!?
> > > (Adding LKML to reach more people)
> >
> > No idea.  One difference is that percpu accesses are through vmap area
> > which is mapped using 4k pages while global variable would be accessed
> > through the fault linear mapping.  Maybe you're getting hit by tlb
> > pressure?

bpf_redirect_info is static so that should be accessed via the linear
mapping as well if we're embedding the first chunk.

> 
> And there are some accesses from remote processors to per cpu ares of
> other cpus. If those are in the same cacheline then those will cause
> additional latencies.
> 

I guess we could pad out certain structs like bpf_redirect_info, but
that isn't really ideal.
