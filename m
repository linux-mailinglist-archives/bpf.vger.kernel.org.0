Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9132C1FE
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449771AbhCCWx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:59 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54743 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1387412AbhCCT7D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 14:59:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 736495C00B2;
        Wed,  3 Mar 2021 14:58:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Mar 2021 14:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jrqwzBr2/xUB65npQg1PNunXWcT
        /Jw+Tr1Bo6J3HzTE=; b=BZD9izVdwiqTr7tZOwUdYMJPQbXWChfr40pFv/kbPi5
        hdHL+fZKBmLVA0IrmTlHwSZ40/vYc0CNKXkDdGupAOoPfj+9vCroUW1/hG+Gp9HB
        NMaGJcAIIhHdCzAqdXW+DJgjeazaYRUKZJPJUzNceLtBCB5z6q8LD14zW18n6zm3
        QbnnIgLkAL2xtCYJvjvNGFZKtnGsoQBIaSUSFNsDKfhyQjNkF9rpqtNWt71yDRwO
        4XQd5tEPyvpdxSnZkqjApv/RN8LF/thxhY2XQ6muhkYIAcpNhlWuvulihSMEVOI3
        oOjvwvRLB0EZKZakXpHLP0Er+nI39sLIKG/fZ5LiZTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jrqwzB
        r2/xUB65npQg1PNunXWcT/Jw+Tr1Bo6J3HzTE=; b=aOd+NnSiuW71vwsV05jyiL
        HDWbZGE9qyxZYEGjby62EEMqRWDb6udN8A9xpl4iyFBo8u184Bbmqrwh0uT3nFVi
        WSwQGM306ityPgraLe+z5CB5hfbCXSUff3iXgk2XnhU2FB6CwIqOG8Ju1NQO5eI1
        EWMnWyU6myXJ2jzn2YJRLEVn++J9zQYiSbDY1qldgvlwUn7xE0lcrbgo2vGEk8XP
        9RsagGbGgcV1AGOzJl29FIA0GEAodf4/yUwU1WUJ3jFKvc9KxCQbMeVC1SHuAm7w
        C3zhFJTYiFWud442ti4OLcbr8cWBp7NAg9QcPP+jnF3ggD2BaPh8bFF49gJby4jQ
        ==
X-ME-Sender: <xms:WOo_YHCA9KEJM8N8n-N5hziCVu7yt6mMOuMi3q9h7HMrhgxdzBpnHA>
    <xme:WOo_YNhrtW-iJFpC_j8GK-eqJ44DD6AlFnT0wLauDsB9M04JaWmnniWF8_z2LXCjS
    0PylAyXlJmI6M0udQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:Weo_YClTo0ETVr2hNPE-y9tic-EhN4KkTGQRJsp3fH2GPNgoiravWw>
    <xmx:Weo_YJyq8CvgOwEUfQ9nkvbPTp9wOjqLIjJJbe3ivCKxXnMKUiV9Sw>
    <xmx:Weo_YMSQ1LoWhD9jiW3rzvLxf5yg82p7ZVJH_R1bX-qeEE6E7g8hVA>
    <xmx:Weo_YHdyb4Cm731Ah6nVcF8Y6GDvdYWQ69_y6-zoxPLGfitl5CsQpw>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7FA23240065;
        Wed,  3 Mar 2021 14:58:15 -0500 (EST)
Date:   Wed, 3 Mar 2021 11:58:12 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: Broken kretprobe stack traces
Message-ID: <20210303195812.scqvwddmi4vhgii5@maharaja.localdomain>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
 <20210303134828.39922eb167524bc7206c7880@kernel.org>
 <20210303092604.59aea82c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303092604.59aea82c@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 09:26:04AM -0500, Steven Rostedt wrote:
> On Wed, 3 Mar 2021 13:48:28 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > 
> > > 
> > > I think (can't prove) this used to work:  
> 
> Would be good to find out if it did.

I'm installing some older kernels now to check. Will report back.

<...>

Thanks,
Daniel
