Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3532D9FE
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCDTFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 14:05:55 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43361 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237046AbhCDTFX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Mar 2021 14:05:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 12A815C00D3;
        Thu,  4 Mar 2021 14:04:37 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Thu, 04 Mar 2021 14:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=Dor9fMbf1MJZCldygU8+8JrRN4OICPX
        ihTNKjtxeqzE=; b=eu23mDg17L+PcgS+RRnxmmjK+Aij7q+yzaycbEeioaAQAtc
        YqXCNKX0G90tNM2HdGuixC+m4Lexj0YrzqYSUmP8zYaSVrmcfesZMTJF7EgrvT+M
        jwKXkOYaKZAa74lfbTAbLxzhC+g/5qnm6coyPbZWZAGYYUcMKMZQqrhy8iFaEeVe
        +TRO7l49zNPoL981/tWu2SDCpqSIu8kYg/O5yxA7YhPLMJiVsb220kVfZ99pJYGF
        zb2wIwdCUJA0SbEg9toqyPFSIWSOmW4+vuxBlgAR0AXMQywed/oeZO1UwSiSuTVT
        VLInCSFIamoYr0BBogpMgg4Pwswfx6ONKfLPyuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Dor9fM
        bf1MJZCldygU8+8JrRN4OICPXihTNKjtxeqzE=; b=wl9mgobBtouOsjXWA7iPhN
        gX2go4PuYQLKFE4HmSpKgCJnCYJevJP/8rTST67/2WiCeqyh2MwXUhll3IZF0nBA
        nYfQ0QsOjJ2eZPBkobD01YWbzNRKLqWxiM460AE1XioIuxBa6rMXVy9yYQhir+9v
        699Y6In7hXbLDZ7egPU244/WdK7FSoS2F0ap4a5vVBtizANFo6/lsl2VPJU/FoLq
        ycRv+14mgGhkHfe+PR1hyeIPO3LMeLouM8wHDt3jv+BIreOHXwY/DXMc9nuPg+f6
        Svw1MLhhQ0icTT4+z3ct5BarHD3nskBs/ptBQVmDhF4o4cTYEjz1jputZdcjbMyg
        ==
X-ME-Sender: <xms:RC9BYE2QubIdURspiogLbmV2rHZqC7AGtXNZY3g5-oKx0kfqPLLBOQ>
    <xme:RC9BYPG6meVds8g_KkiwE189e00EgaPZEO2uX6QljhBmaMDhM6lcQFYG1lscl05RT
    5gtQ5T7m8tK57Q3gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeejgfevtefhjeelgfefvddthffffeeutdffgeeihfek
    teefheffgeeitdeifefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:RC9BYM529SszgTfBvrb86p3UHogu-YtAIydW-yVmM_W1QKMwCJOZdQ>
    <xmx:RC9BYN0VDK_47bKNiuANKE4u3-a2KAGKxTiWvKzsv_P3YBc8TPmPsw>
    <xmx:RC9BYHGhyW1kMPMYeao5eUm2uigS-oeXtTSgaJ3VNVMomj6kdkwZbA>
    <xmx:RS9BYPAjbW0NCnBUBq_HRcHKI_f8HZDuW3hsXzWpPvPwRTFvgaNLTA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0D8B615A005D; Thu,  4 Mar 2021 14:04:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <cb71589f-f724-4e98-b9a7-39024a78f0b7@www.fastmail.com>
In-Reply-To: <20210304021819.hgam3z3xurxcq3re@maharaja.localdomain>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
 <20210303134828.39922eb167524bc7206c7880@kernel.org>
 <20210303092604.59aea82c@gandalf.local.home>
 <20210303195812.scqvwddmi4vhgii5@maharaja.localdomain>
 <4d68e8d9-38b0-4f32-90b6-1639558fce51@www.fastmail.com>
 <20210303153740.4c0cc0c5@gandalf.local.home>
 <20210304021819.hgam3z3xurxcq3re@maharaja.localdomain>
Date:   Thu, 04 Mar 2021 11:04:15 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Steven Rostedt" <rostedt@goodmis.org>, jpoimboe@redhat.com
Cc:     "Masami Hiramatsu" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: Broken kretprobe stack traces
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 3, 2021, at 6:18 PM, Daniel Xu wrote:
> On Wed, Mar 03, 2021 at 03:37:40PM -0500, Steven Rostedt wrote:
> > On Wed, 03 Mar 2021 12:13:08 -0800
> > "Daniel Xu" <dxu@dxuuu.xyz> wrote:
> > 
> > > On Wed, Mar 3, 2021, at 11:58 AM, Daniel Xu wrote:
> > > > On Wed, Mar 03, 2021 at 09:26:04AM -0500, Steven Rostedt wrote:  
> > > > > On Wed, 3 Mar 2021 13:48:28 +0900
> > > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >   
> > > > > >   
> > > > > > > 
> > > > > > > I think (can't prove) this used to work:    
> > > > > 
> > > > > Would be good to find out if it did.  
> > > > 
> > > > I'm installing some older kernels now to check. Will report back.  
> > > 
> > > Yep, works in 4.11. So there was a regression somewhere.
> > 
> > Care to bisect? ;-)
> 
> Took a while (I'll probably be typing "test_regression.sh" in my sleep
> tonight) but I've bisected it down to f95b23a112f1 ("Merge branch
> 'x86/urgent' into x86/asm, to pick up dependent fixes").
> 
> I think I saw the default option for stack unwinder change from frame
> pointers -> ORC so that may be the root cause. Not sure, though. Need to
> look more closely at the commits in the merge commit.
> 
> <...>
> 
> Daniel
>

Compiling with:

    CONFIG_UNWINDER_ORC=n
    CONFIG_UNWINDER_FRAME_POINTER=y

fixes the issues and leads me to believe stacktraces on kretprobes
never worked with ORC.

Josh, any chance you have an idea?

Thanks,
Daniel
