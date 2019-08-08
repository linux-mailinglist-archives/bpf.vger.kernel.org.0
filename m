Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521FA86D48
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2019 00:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404670AbfHHWc1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Aug 2019 18:32:27 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42265 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfHHWc0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Aug 2019 18:32:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 68BF538C;
        Thu,  8 Aug 2019 18:32:25 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Thu, 08 Aug 2019 18:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=QMLmMC2THUGZXMqoqN+1vqTXcyCXgy6
        CcOzbwDdbEtY=; b=NHtxErjw0lvgJV1YcACxefTVaNCmTTguos85663wWyFBRNY
        2RF4bI8YAhw2WugRYGIFuPF5ELOnrvSmwbgq51dPLlYJWHHtauzUAl1Ye8T4FIRY
        FX25RjP2wQRPMu4fnZzBSvZ/HfstsBh42ZitCPrX70jYzYpYXlhMUh2vq8U0MKAx
        2N7SLi/3WQZvWPXJjqHvIVOpZS7AQ5Af0zKe8vIkjT1skGsyBXwdm5BhqvK5nyaC
        vM5VCNS4xVYZz1bVTCC0bXNvYhzhv23LWniDhf6OjJnpEnx0/imaYPMaMxnrD5PJ
        LAtq0E+2hjdUcMQb+lQ6rfzE9WrhO65Lk9FAj4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QMLmMC
        2THUGZXMqoqN+1vqTXcyCXgy6CcOzbwDdbEtY=; b=EQyT/Rhesf/Xsd7poFm5Gh
        SpghYIDOemEfl9xEBntk/BQeGSYFMW11UE5CvGBnRwFJPMOKneCS4EsoerKcAxGX
        H41dD+eaDdbmdR6yPF6p089EWE6w//aq2y+SqZzkHbJ9cir7ujoGPh0AMsiN3V8X
        K5OpIauYQYonn+tB4AtWD4bQyhNDRmBu8+EmAxOlVmZhZmfbJ27kKXjHywT3O2//
        MDnWkrzP6fs6Kjbiyy9Z9GP0LdYrRAATCCQrQf5xGdzAgalCzdmSBI8D6GpVvpG1
        5BrO8aXwBM+Zf3lPGGIgMdAvByQ0yin1nx9/g73hZQz5sf9Mai+JIXHBgwDVxEQg
        ==
X-ME-Sender: <xms:-KJMXZVcbHvlcA2rn1W1Xs-HmvKyJhqJM1fQ4yerMcVrZmpSb4M-Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:-KJMXVSCU-vUorWA_1LbKI7HYY_ghv7N1USm2I9T-81XpqKSwE0MSw>
    <xmx:-KJMXR33imcimA902OIdoBM4UqwlKof75lRltdp7V0eNQfI2TXKbRQ>
    <xmx:-KJMXVcdCUHWy06aet-MI7n8D1dssWTrhKDc33YiPNrXhuvrzhwvcw>
    <xmx:-aJMXfNuzZekOYTbf-_B3qooupC5v4ciH7oHkDh4OQKUAVxTef5JEA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 91E7214C0062; Thu,  8 Aug 2019 18:32:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-808-g930a1a1-fmstable-20190805v2
Mime-Version: 1.0
Message-Id: <d97ee4ce-06b6-45a6-a999-6e654e0236e4@www.fastmail.com>
In-Reply-To: <CAEf4BzbTeZLpMT0d0CchYZnMTUj3yYUxi4M0Ki6Urgo8_Lqz4w@mail.gmail.com>
References: <20190806233826.2478-1-dxu@dxuuu.xyz>
 <CAEf4BzbTeZLpMT0d0CchYZnMTUj3yYUxi4M0Ki6Urgo8_Lqz4w@mail.gmail.com>
Date:   Thu, 08 Aug 2019 15:32:24 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH 0/3] Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 7, 2019, at 12:03 PM, Andrii Nakryiko wrote:
> On Tue, Aug 6, 2019 at 4:39 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > It's useful to know kprobe's nmissed and nhit stats. For example with
> 
> Is nmissed/nhit kprobe-specific? What about tracepoints and raw
> tracepoints, do they have something similar or they can never be
> missed? At least nhit still seems useful, so would be nice to have
> ability to get that with the same API, is it possible?
> 

I'm still trying to grok all the tracepoint/ftrace machinery, but it appears
to me like it is kprobe/uprobe specific. My guess is that b/c tracepoints are
inline (and don't require trapping interrupts), it cannot really "miss".

This brings up a good point, though. I think we want the same querying
functionality for uprobes so it might be worthwhile to make this API generic.
Something like PERF_EVENT_IOC_QUERY_PROBE so we can later add in
uprobe stats. And maybe tracepoint if it makes sense.

Thoughts?
