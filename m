Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85C8334BE6
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCJWqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:46:47 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58045 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229971AbhCJWqU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 17:46:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1E9AC5808BE;
        Wed, 10 Mar 2021 17:46:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Mar 2021 17:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fqHKekVL58z0DURkIIVUuGxcCbm
        DS+6dW7+MDwBQFQo=; b=BOpxUaYcSyzpXZt8UP+ml7BFutjbfPMECG0TJAlPHN8
        uSLxLxm7s+uUDqhgGx6o+9x1vyS+ifZh9XT8dQ3EZbY6+EwJuAawexeGPyqgd88q
        uWNZvzN+3QzrNqo/2Nko0goOFtHCS0bNmEfWiBTmLinjtYuAWuPoLM0COpCMB78I
        h7y2WfFowwi/khdUJj1lDryxRIKwtWpqn2YjcyyiaRda/spHAC5DCzCHUcaeTQod
        FIVqO6zTGEr6IU9FyfznlizW51eJ/aTIKDk75SSKhIPHg975sqLbXoNxM31nVHY3
        6MSMpiIHj3gCAPTWc9ZSLUlCoUNrhbdtowcrFbVui6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fqHKek
        VL58z0DURkIIVUuGxcCbmDS+6dW7+MDwBQFQo=; b=LYwoddpFTYA6ICPXKLbsAT
        XNWtimnqKlIce+9EP/mFxkqgvnTTvS08h7IfZEiDe9QeGsMTGYK9TRW8WoEOOKmr
        ITOyNXbOTV4yQ1FM/jdFGNWxAJH8IbiimYEpRDG3Ca/LMJn4jWRhyc1Q4T4YvsIe
        2GsZR0f6ZLx3K5WUMpJiczDMxlNqOmNmGb+zFTIyn1HHFeKbQT+dxxspUtkyiM1U
        eg2J4C18TlxdmIoUIleW82ecbaH1VhR10//XI3hz5fbBv/QJZXisd8MdGzDEJBoE
        xKGMs4iKhHz2NRdpqojEHVqZj/tKmiC7umDnCI5eeL09Ik6UFiyqrIkaMM9G01MQ
        ==
X-ME-Sender: <xms:O0xJYEss_pi14woAEjHVD20mGXqnnhrxuJyeFpgZBnuGvAtqyusz5A>
    <xme:O0xJYBdaHqcw8yNaiJXPgn8mvJTlJMbqSBN589oqpLExrJ08vWTIzXYJLIPScbLgQ
    gp4uGnaCG07vSM7mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeuuddvjeefffelgfeuveehfeegfeetfeetueduudfhudfhheev
    leetveduleehjeenucfkphepudeifedruddugedrudefvddrjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:O0xJYPxdcWM_kopvCmukL6I_F3E6IWESKHQ25-rgcJX9r3uyXXsBmg>
    <xmx:O0xJYHPY6KLXRNXjd-ZFpbrvYfrAYvkuHJ8Wf_8wgiWDr6_EW-wTQQ>
    <xmx:O0xJYE8_4w_1bm3sSUvvbHiDHfumFrBkwd1VDbpejHBAfVhPfjSAXw>
    <xmx:PExJYF1DZK8viRnUqLAoFKwLamlU61qwnnSn7OX5_fQLeS6diaXh8w>
Received: from dlxu-fedora-R90QNFJV (unknown [163.114.132.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B89A24005C;
        Wed, 10 Mar 2021 17:46:17 -0500 (EST)
Date:   Wed, 10 Mar 2021 14:46:14 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210310224614.7piyiurdiiumqa5e@dlxu-fedora-R90QNFJV>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
 <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
 <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
 <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
 <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
 <20210309011945.ky7v3pnbdpxhmxkh@treble>
 <20210310185734.332d9d52a26780ba02d09197@kernel.org>
 <20210310150845.7kctaox34yrfyjxt@treble>
 <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 12:55:09AM +0900, Masami Hiramatsu wrote:
> Hi Josh and Daniel,
<...>

> commit aa452d999b524b1851f69cc947be3e1a2f3ca1ec
> Author: Masami Hiramatsu <mhiramat@kernel.org>
> Date:   Sat Mar 6 08:34:51 2021 +0900
> 
>     x86/unwind/orc: Fixup kretprobe trampoline entry
>     
>     Since the kretprobe replaces the function return address with
>     the kretprobe_trampoline on the stack, the ORC unwinder can not
>     continue the stack unwinding at that point.
>     
>     To fix this issue, correct state->ip as like as function-graph
>     tracer in the unwind_next_frame().
>     
>     Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

I applied your original patchset + Josh's patch + this patch and can
confirm it works for bpftrace + kretprobes.

Tested-by: Daniel Xu <dxu@dxuuu.xyz>
