Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E161C32C226
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391952AbhCCW66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388047AbhCCUiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 15:38:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8217564E90;
        Wed,  3 Mar 2021 20:37:42 +0000 (UTC)
Date:   Wed, 3 Mar 2021 15:37:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Daniel Xu" <dxu@dxuuu.xyz>
Cc:     "Masami Hiramatsu" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: Broken kretprobe stack traces
Message-ID: <20210303153740.4c0cc0c5@gandalf.local.home>
In-Reply-To: <4d68e8d9-38b0-4f32-90b6-1639558fce51@www.fastmail.com>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
        <20210303134828.39922eb167524bc7206c7880@kernel.org>
        <20210303092604.59aea82c@gandalf.local.home>
        <20210303195812.scqvwddmi4vhgii5@maharaja.localdomain>
        <4d68e8d9-38b0-4f32-90b6-1639558fce51@www.fastmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 03 Mar 2021 12:13:08 -0800
"Daniel Xu" <dxu@dxuuu.xyz> wrote:

> On Wed, Mar 3, 2021, at 11:58 AM, Daniel Xu wrote:
> > On Wed, Mar 03, 2021 at 09:26:04AM -0500, Steven Rostedt wrote:  
> > > On Wed, 3 Mar 2021 13:48:28 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > >   
> > > > > 
> > > > > I think (can't prove) this used to work:    
> > > 
> > > Would be good to find out if it did.  
> > 
> > I'm installing some older kernels now to check. Will report back.  
> 
> Yep, works in 4.11. So there was a regression somewhere.

Care to bisect? ;-)

-- Steve

