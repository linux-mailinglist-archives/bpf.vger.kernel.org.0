Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1832CA65
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 03:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCDCUA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 21:20:00 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50359 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhCDCTc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 21:19:32 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2751C5C0125;
        Wed,  3 Mar 2021 21:18:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Mar 2021 21:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=F/RocdRF7Pqs28TM5H8sAhTjZ7h
        Jr93UFoPWh+J/1D0=; b=IYJa6Hc7mVyAfj+W6Cizf+Cly5Vn81aImA/4slh9FTA
        qU3vaENIj2hEp7wyh/gmsguDkPrC3n3LQcRBTbNK6HHMwpSEbgmdw1ewyXhkOync
        RsAtC/ygUL9JHT5Lv8o9F2Ys4iwpob8ynMUoU2N9pXg8KD/9JueFnNGr/dW/rB7P
        sQh2DPDvKKbf66wOKv08FMIrIyPALi0C5mbCyCdKAh8PkK4rWIcbXDIKMg4redTY
        +0QvgbKGueh4vl6Xjn+VFcJfif3Kx1G/aTb0jjen6xy85i2eFeFBwN0YAxA2bIhk
        uPBjVC0z9RrxdhSgnWRXx8+WZK4UD/tiGrmSx36CGuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=F/Rocd
        RF7Pqs28TM5H8sAhTjZ7hJr93UFoPWh+J/1D0=; b=H77+7gZme140r8DsW3ySnv
        OgTzSNDmUbOIhQSK+pBapV10FtOTDlrBieMHu6Zb2LrKez42x5COtzZ53NhJqxRG
        htnOirQaLIx30aWCouCSG/fsQpQ7FOvpgk1vi+tAgM+tcJseP3YEKmmotkug3daG
        m+QkXhVGYjxHq3pJW26bT6GD6OOuaDwjePJAO95P4/rwL2ZSRx5tt4QuIO9ZCMPB
        0rDqiZX9LwtC/8XKtDk+XzRz7v3zJP618okWdewq4u5sCzqqxnYYgYDKbjnPh4GX
        7ZsGQxBozF0mSwehH67L70rv7DBMUY5sBqJAs1njsxviLNyqCm2DzXt40oVpFcnw
        ==
X-ME-Sender: <xms:bUNAYKR3bzd1p22W-jJU2XR1h5DpDOoJHc3VTvuYgBc3aZBaSNHXnQ>
    <xme:bUNAYPxkGYtnSALvcaPrYanV_lGMKWZMBfax2YX4s8MK5nfGxBdMLeaAdle0RV_u5
    MQ8adeUhomNSB_xAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeuuddvjeefffelgfeuveehfeegfeetfeetueduudfhudfhheev
    leetveduleehjeenucfkphepieelrddukedurddutdehrdeigeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:bUNAYH2_OqKgfFiEKpZXpB9vwlCZW-r5RbpfgTOtvFqCv0EvPB0EzQ>
    <xmx:bUNAYGBCLQ0N7Nzi-gcLHxetDVtVcOqDE5ITZB2reel-fmkCyncI6w>
    <xmx:bUNAYDhHq_KwCSipY4UTj5uG6xo3L0EZgOPpUhxWxMn2XMohA9Zn8g>
    <xmx:bkNAYGsDM3lgPeaB9Ms6sDH0ptpzjgj-oKbyd6GbfHBZdAivrj_vnQ>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 111E61080057;
        Wed,  3 Mar 2021 21:18:20 -0500 (EST)
Date:   Wed, 3 Mar 2021 18:18:19 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: Broken kretprobe stack traces
Message-ID: <20210304021819.hgam3z3xurxcq3re@maharaja.localdomain>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
 <20210303134828.39922eb167524bc7206c7880@kernel.org>
 <20210303092604.59aea82c@gandalf.local.home>
 <20210303195812.scqvwddmi4vhgii5@maharaja.localdomain>
 <4d68e8d9-38b0-4f32-90b6-1639558fce51@www.fastmail.com>
 <20210303153740.4c0cc0c5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303153740.4c0cc0c5@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 03:37:40PM -0500, Steven Rostedt wrote:
> On Wed, 03 Mar 2021 12:13:08 -0800
> "Daniel Xu" <dxu@dxuuu.xyz> wrote:
> 
> > On Wed, Mar 3, 2021, at 11:58 AM, Daniel Xu wrote:
> > > On Wed, Mar 03, 2021 at 09:26:04AM -0500, Steven Rostedt wrote:  
> > > > On Wed, 3 Mar 2021 13:48:28 +0900
> > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >   
> > > > >   
> > > > > > 
> > > > > > I think (can't prove) this used to work:    
> > > > 
> > > > Would be good to find out if it did.  
> > > 
> > > I'm installing some older kernels now to check. Will report back.  
> > 
> > Yep, works in 4.11. So there was a regression somewhere.
> 
> Care to bisect? ;-)

Took a while (I'll probably be typing "test_regression.sh" in my sleep
tonight) but I've bisected it down to f95b23a112f1 ("Merge branch
'x86/urgent' into x86/asm, to pick up dependent fixes").

I think I saw the default option for stack unwinder change from frame
pointers -> ORC so that may be the root cause. Not sure, though. Need to
look more closely at the commits in the merge commit.

<...>

Daniel
