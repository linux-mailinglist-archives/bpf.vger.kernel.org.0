Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4163396F6
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhCLS4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 13:56:23 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47111 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233600AbhCLS4E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Mar 2021 13:56:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E5F8E5806DA;
        Fri, 12 Mar 2021 13:56:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Mar 2021 13:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=uq8KoorMFRJspDef7Zbl/mIHRgY
        g65/YZRWkmwTdX8A=; b=gg4RGTOkEnH37/Cnkt1YTKGfeytFjljmcQDJtIyL6wx
        AbbiCvABk4nWbmM2k8CaQmNQ70AdJ6aTPGVYeqL+QXKZl0r05PBj19qIV3kxRV24
        cjx8m+xwdvLJC++NB/JTqMQIMBWjQUFNJZ4DVDjDHh1fzSCg5IRuDuYA72e189mm
        YQiuwEzMsX4C2HiIcK8w2EkzPRWpj9jNgyRyvHuLVGMX9pUvAnwLUYtix25I6k+s
        k5dAT+M90jiVLOGUB4DXrMNRPIaiP1UZNbJRn9qWuc8NQVeu3idmFF9tvaUCHm9k
        a0tTWPLhoHJXclIi/Wr/ZUxmePZE2NLqxBofJ9MV5Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uq8Koo
        rMFRJspDef7Zbl/mIHRgYg65/YZRWkmwTdX8A=; b=fyerTbZpVZdjvKb7E3gALS
        iviv1ltgHZ24LSIDnf4+GUckoBXckE81kztFF1o/EhoHd/q4fudHr7CzAKlS6Wlu
        Sl7owsdYCa4jftL6yxpGc+JWojRp6M04RszFcN6opvRGR6ezPowOkEHXI9sI2Fcb
        pcnlBx8vWA3Ue3+7he2RpDRS33Gv16Jq6uaq9xRW7DfEn5th9ii6pVNm0J2ZL5SB
        s84J0VzMQttXUZ0loxqCA4lu6ewLrZQ4EHZzup6xdF0+FgbYwTEiEMF24NqU/7rS
        Ruc2OCc2D2w8j2qAncKOZ1Zl5DPi5fLW+1aL42f6OiscbhDAF4kifO4/ahC2avvA
        ==
X-ME-Sender: <xms:Q7lLYBdpBv5tjDfkH6OlLAoUpsF3TdY2sZNewek0OZK4x3_osb-IEg>
    <xme:Q7lLYDhU8VsUhVwkGm8_l7Y5P03AQUERm9imKBRLTs9UKbDsYYm0KRw2P7dC4WoPB
    20OZxCtxzlu9cllLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepuedtudehffetjeejueelleduvdefteeulefhjefghedttedv
    veefffegkedtjedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepieelrd
    dukedurddutdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Q7lLYJrenwZxZCtBT2KIb5wMaHg9bUCLZHGEHzARr7cUBQmpqCtzFg>
    <xmx:Q7lLYDEb2ufQu08AOesKOWju7tES4tv26faOJ5TifGCKjUFx0dOyNA>
    <xmx:Q7lLYDmi9W8-pRw4kyM1fW_n6ZMR4yWPTW6dTaiod6QjuwpGleIXcw>
    <xmx:Q7lLYH-M-H0qwTYoF_yQ_4ekrJmSykIftMKo7N4w0EQy2zFmyyOXWA>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5C491080064;
        Fri, 12 Mar 2021 13:56:01 -0500 (EST)
Date:   Fri, 12 Mar 2021 10:56:00 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v2 00/10] kprobes: Fix stacktrace with kretprobes
Message-ID: <20210312185600.2fziqmye77iufrgz@maharaja.localdomain>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161553130371.1038734.7661319550287837734.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 12, 2021 at 03:41:44PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> Here is the 2nd version of the series to fix the stacktrace with kretprobe.
> 
> The 1st series is here;
> 
> https://lore.kernel.org/bpf/161495873696.346821.10161501768906432924.stgit@devnote2/
> 
> In this version I merged the ORC unwinder fix for kretprobe which discussed in the
> previous thread. [3/10] is updated according to the Miroslav's comment. [4/10] is
> updated for simplify the code. [5/10]-[9/10] are discussed in the previsous tread
> and are introduced to the series.
> 
> Daniel, can you also test this again? I and Josh discussed a bit different
> method and I've implemented it on this version.

Works great, thanks!

Tested-by: Daniel Xu <dxu@dxuuu.xyz>

> 
> This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> the pt_regs passed to kretprobe user handler is correctly set the real return
> address. So user handlers can get it via instruction_pointer() API.

While this changes behavior a little bit, I don't think anyone will
mind. I think it's more accurate now.

<...>

Thanks,
Daniel
