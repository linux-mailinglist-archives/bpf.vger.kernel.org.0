Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7357C854EA
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 23:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfHGVHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 17:07:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41185 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729960AbfHGVHO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 17:07:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 26AD721540;
        Wed,  7 Aug 2019 17:07:13 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Wed, 07 Aug 2019 17:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=7XfQ6neWKgG4FY+EaloGsx/DhHFLq0i
        ul8n3nG8iLNo=; b=HUh2wwRIOU0IkJGEF9RbappV2N4W0Y0q0tue/gCVmiERfvh
        b6PcHE2aTAcsuXYSdEMMjnOjGv0wsDvdZdqYwu0dEV6vvkoN39+yfkXughvc6Iz1
        VClt5lOcCIUG7yA0H+O++ma0tSLg1CQEBl3E+nUvDcW9p4dG+xoiFuC13wiBXeLr
        3tlVcHbDRzEIHbkzaPHhxsZlFTxAL9J5Q+ZKWjtG7QTDXqlIHTFXA9gJiXFT0ntN
        TuppBxuCtecAx3mpxPwLZVz706Qjyk47friEdgYwYvkESw+YZYab6zqgx8oZksRe
        RG+IoVB2oK5d4CtNqBEfjWaVTNjHyl0Npp0sxYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7XfQ6n
        eWKgG4FY+EaloGsx/DhHFLq0iul8n3nG8iLNo=; b=I/hR/m+201PHbjhdPtHXRO
        YVJMqgDgFpok+l+peTQ9ajKt30u/x8LKmkWwYkUAc/XwEj/jRRE5L3lzw8/8utlD
        yvt/rPooSS5+mb1ol7eUfmtjWImR/7zxBEWjW8qiw7aq2gkBA9eEPIUxIVneOcUm
        nx/DZhqHJi9byQWWEctO/JT++7ol7g4CBH7GVBZHyHe/3buMlfhC+nEByRhJMOfC
        FC4/cG70Aw8cbAj8BLgR1ktzR4qXy6RGQdp+7Y1gFDI3FdAEFaZLuiGQZ3qPZj1L
        qlL08iWAQyRr9tS6ovpt/79+kNpcJqNk43RRZRntBbQtH3nRpozyw+RUc9pTibVQ
        ==
X-ME-Sender: <xms:gD1LXSsiljx5GxLSUuf5KaOVy7zv49uDC8nDOyt2Vtb5YFhKJYpsag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduvddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiienucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gD1LXctBIC8-beBjbXyWpnk0kiCiZ2yz26k8b4zhCfXy78WEuUJg0g>
    <xmx:gD1LXQa1SOHu-c6t8R01uYpDYvvSmxfSaOqgRaf3u0lGOtg6vYvz5A>
    <xmx:gD1LXc6T5xXG97eVgt_0BYXPzMBYp61z-qU_BVgS2z83l2EeEvcO9A>
    <xmx:gT1LXTz33mzUfmy19G1sAZwPso0JQDDUg7FV3Qs4tKZJuMZFJWLTjQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8012C14C0066; Wed,  7 Aug 2019 17:07:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-808-g930a1a1-fmstable-20190805v2
Mime-Version: 1.0
Message-Id: <08d10274-8d4f-4c59-a33e-07f217a23f09@www.fastmail.com>
In-Reply-To: <f4a1ca0c-3fa1-5a20-2f41-133dc2ec1445@fb.com>
References: <20190806234131.5655-1-dxu@dxuuu.xyz>
 <f4a1ca0c-3fa1-5a20-2f41-133dc2ec1445@fb.com>
Date:   Wed, 07 Aug 2019 14:07:12 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Yonghong Song" <yhs@fb.com>, "Song Liu" <songliubraving@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 6, 2019, at 10:52 PM, Yonghong Song wrote:
> 
> 
> On 8/6/19 4:41 PM, Daniel Xu wrote:
> > It's useful to know kprobe's nmissed and nhit stats. For example with
> > tracing tools, it's important to know when events may have been lost.
> > There is currently no way to get that information from the perf API.
> > This patch adds a new ioctl that lets users query this information.
[...]
> > +/*
> > + * Structure used by below PERF_EVENT_IOC_QUERY_KPROE command
> 
> typo PERF_EVENT_IOC_QUERY_KPROE => PERF_EVENT_IOC_QUERY_KPROBE

Ok. Whoops.

> 
> > + * to query information about the kprobe attached to the perf
> > + * event.
> > + */
> > +struct perf_event_query_kprobe {
> > +       /*
> > +        * Size of structure for forward/backward compatibility
> > +        */
> > +       __u32   size;
> 
> Since this is perf_event UAPI change, could you cc to
> Peter Zijlstra <peterz@infradead.org> as well?

Ok. Will add in V2.

> 
> We have 32 bit hole here. For UAPI, it would be best to remove
> the hole or make it explicit. So in this case, maybe something like
>            __u32   :32;
> 
> Also, what is in your mind for potential future extension?

The idea is we can extend this API if more kprobe stats are added. Similar
to how perf_event_open(2) has a size field. Not sure if it's a silly idea but
we could also make the size field a u64 to fill the hole.

> 
> This will only handle FD based kprobe. If this is the intention, best to
> clearly state it in the cover letter as well.
> 
> I suspect this should also work for debugfs trace event based kprobe,
> but I did not verify it through codes.
> 

Ok. Will update cover letter in v2.

[...]
> > +
> > +	if (copy_to_user(&uquery->nmissed, &nmissed, sizeof(nmissed)) ||
> > +	    copy_to_user(&uquery->nhit, &nhit, sizeof(nhit)))
> > +		return -EFAULT;
> 
> You can use put_user() instead of copy_to_user() to simplify the code.
> 

Ok.
