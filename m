Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC54C32F4B6
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 21:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEUp2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 15:45:28 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37015 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhCEUpY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 15:45:24 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id F1741580424;
        Fri,  5 Mar 2021 15:45:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 05 Mar 2021 15:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=zAqAs406kSgCWanIWBxHYGBshfX
        hDqnnyJUinOPZdGc=; b=u8diWuj/f4D9mw5HLrsa4b76vKYl/Znn84uNn0jOq7i
        ED62LmTb5+i8mDVmcEfYHh/5S+jgV5WjgmgG+o0ZE0KsTDcHQ6xK9YvaHCpOknbt
        UaafCWuYaXL+cPN6Ho6gx+XHio4GrR91QhRFn2p6RWh7F38le6GoCg5pl2jcBoDx
        +qiHQOJw34OhqPsSsp7vrkJqU0zcrqClJbDMmKNtQ6wi52sLJH5XsHc1G8OnkKUT
        mf7dJAeyWIUOwsdckeIKuqy8ojdwfFothqkI5adT62htOFr4KDkU3dfPKINBIa4m
        U7ywkLwZU2XCQw1xdOwGnXmVbIhrs5uVFTe8CLpkFWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zAqAs4
        06kSgCWanIWBxHYGBshfXhDqnnyJUinOPZdGc=; b=tGTy/XkEXlo2+qnTb3qhkh
        MBeTeJl2zstBTExV0gUGK69DSSEUaHSzW6SdQKn6KgQ/Gfz3s+i3cA8XPqglqMxo
        d0O/pUzoVr5tA5nzkT4BxEEG3ya0qfGBzJkIS7ZXA1Ra1pO2Yyd0vdiSaaxXobPD
        LGbe/xq/h2tFoh8aCEoltaHrMcvcUE9HeH2Rz2T4PVzyxQwy9KG5c2z2uOBKPads
        WXicFVX+wHNgsl+Q7nzX+h2ntArj3XwWOiAdnH9qtICpdt1X4mM6zUSBNNl7537S
        4UqKfxZJnzIRXpXhRrPiqPezEA5cUXK8dDrF3a7nOTs1ieJpNt203ywzntQdMUfQ
        ==
X-ME-Sender: <xms:YphCYI8ZEsX5-iCAapgXvBOIsPM5I9I67hT-vyP-iiMAaxsBsj0LhQ>
    <xme:YphCYAt4dQUAcu_blXsj6LozDGWDCdlarn0jdz2XQmvtsWw47fFJ0N2IQDnnLAa-K
    1axfecvwUoqIDCmpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:YphCYOBWYghKnWj_2q6OCRmS_H6lPMxZf14zJPN28cdwTA6TH-uUxw>
    <xmx:YphCYIepT4ehBmrjRubZfCf1Tdr5Cptgw_GAmLUCsKVUXoZ0NQgg2w>
    <xmx:YphCYNM88sV3rBrj8AIHGmd6LRX5C3ILjNm2qZKb-d_PfOyCTwj5ng>
    <xmx:Y5hCYAo6zoiQQXj4J3bmpT01_qM7gROxzJW2rcK52XGksGQGlTpuqg>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 800D11080054;
        Fri,  5 Mar 2021 15:45:21 -0500 (EST)
Date:   Fri, 5 Mar 2021 12:45:19 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        kuba@kernel.org, ast@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH] x86: kprobes: orc: Fix ORC walks in kretprobes
Message-ID: <20210305204519.2znqdfykdpa4svns@maharaja.localdomain>
References: <d72c62498ea0514e7b81a3eab5e8c1671137b9a0.1614902828.git.dxu@dxuuu.xyz>
 <20210305182806.df403dec398875c2c1b2c62d@kernel.org>
 <20210305195809.a9784ecf0b321c14fd18d247@kernel.org>
 <20210305192515.6utyhm5kks4zexwn@maharaja.localdomain>
 <20210305193244.odtphdj5wm5cslf7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305193244.odtphdj5wm5cslf7@treble>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 05, 2021 at 01:32:44PM -0600, Josh Poimboeuf wrote:
> On Fri, Mar 05, 2021 at 11:25:15AM -0800, Daniel Xu wrote:
> > > BTW, is this a regression? or CONFIG_UNWINDER_ORC has this issue before?
> > > It seems that the above commit just changed the default unwinder. This means
> > > OCR stack unwinder has this bug before that commit.
> > 
> > I see your point -- I suppose it depends on point of view. Viewed from
> > userspace, a change in kernel defaults means that one kernel worked and
> > the next one didn't -- all without the user doing anything. Consider it
> > from the POV of a typical linux user who just takes whatever the distro
> > gives them and doesn't compile their own kernels.
> > 
> > From the kernel point of view, you're also right. ORC didn't regress, it
> > was always broken for this particular use case. But as a primarily
> > userspace developer, I would consider this a kernel regression.
> 
> Either way, if the bug has always existed in the ORC unwinder, the Fixes
> tag needs to reference the original ORC commit:
> 
>   Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> 
> That makes it possible for stable kernels to identify the source of the
> bug and corresponding fix.  Many people used the ORC unwinder before it
> became the default.

Got it. I'll change it in the next version if we get to V2 (another
ongoing discussion in Masami's patchset).

Thanks,
Daniel
