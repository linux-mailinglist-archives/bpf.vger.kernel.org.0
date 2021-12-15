Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4947524D
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 06:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbhLOFyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 00:54:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36108 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhLOFyO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 00:54:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884D0617E4
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 05:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8B1C34600;
        Wed, 15 Dec 2021 05:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639547652;
        bh=ZPuBBOpWLWazP1OV4WCOLIQTJE2UodXrDdUnitvcNa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M52K7/4WNpCQj6pp8pgfN9un+UaKP0NPWn0qZNYH/8Mdjqacn56XztKxesbX1X42J
         gEc3oIuHkUCKl3+u72/v4EdDUbLnXw7KteRgUDVCQoMBLnV7BVYz7yHecUg/SSKwAJ
         E1zlI/rIauaBliwzZZShIS/3O35nGrD91mQGbZOKucFVNSntB4onxcwGc0tkFd2mCs
         d6hstis2+KynHb3ps+xXNwOG4RWiaMLHSnc+4mgHdF0KlJ8vUqO70vy0WXJAO7iFpK
         BbaXnFR0yvpuQIRjFeJ3BQgWf0M/982IDGIAvWRBiT1V0FE0C1wHzAci4rjRMG7eyl
         f30y1zY2dAh4A==
Date:   Tue, 14 Dec 2021 21:54:11 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/4] bpf: remove the cgroup -> bpf header
 dependecy
Message-ID: <20211214215411.3c987215@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAADnVQKfi9BFxjEjvRLLdimoF5Rrbe8LnX+g94MbGCt6_NTomw@mail.gmail.com>
References: <20211215023126.659200-1-kuba@kernel.org>
        <20211215023126.659200-5-kuba@kernel.org>
        <CAADnVQKfi9BFxjEjvRLLdimoF5Rrbe8LnX+g94MbGCt6_NTomw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 14 Dec 2021 21:15:15 -0800 Alexei Starovoitov wrote:
> On Tue, Dec 14, 2021 at 6:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > Now that the stage has been set and actors are in place
> > remove the header dependency between cgroup and bpf.h.
> >
> > This reduces the incremental build size of x86 allmodconfig
> > after bpf.h was touched from ~17k objects rebuilt to ~5k objects.
> > bpf.h is 2.2kLoC and is modified relatively often.

> >  #ifndef _BPF_CGROUP_H
> >  #define _BPF_CGROUP_H
> >
> > -#include <linux/bpf.h>
> > +#include <linux/bpf-cgroup-types.h>
> > +#include <linux/bpf-link.h>  
> 
> Borked rebase with stale header I guess ?
> 
> Could you try just patch 1 with bpf-cgroup-types.h
> and do s/bpf.h/bpf-cgroup-types.h/ here in bpf-cgroup.h
> as patch 2
> while moving cgroup_storage_type() function to bpf.h ?
> Patch 1 will add +#include <linux/bpf-cgroup-types.h>
> to linux/bpf.h,
> so cgroup_storage_type() will have everything it needs there.
> 
> I could be still missing something.

Right, I must misremembered the reasoning, move to bpf.h should work
just fine.
