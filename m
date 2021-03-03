Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08DA32B315
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352552AbhCCDvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:19 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43003 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242893AbhCCBQq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Mar 2021 20:16:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A040C10F3;
        Tue,  2 Mar 2021 20:15:34 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Tue, 02 Mar 2021 20:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:date:from:to:cc:subject:content-type; s=
        fm2; bh=9FD8F+TWKvse0buYqi4uiNdfXk0YrVryNe2+KxwJxE4=; b=gYD8pcVL
        6TcQSIXYBfnJ61EoGimU174EVWiZy1rMp4FMx/vMfSwyy090/5AdSu9hZMAp/Zop
        mnQJho+dwSlzjPQKxs2SkjTJDtKGE1YNo7RVb3n8QWq+Nkrb2EUk2GonUyWyZE8W
        fHz+mh8S+1lOkNBTvDvH0y3Tg8v3INgBcyWi/wdxS1iOYHg89zCNKIR8fsBbolC/
        RhEGFTPFO8AMqSk+G5ci7TYiqfTleYAyFtkxSd4hul41vwYogt/y4dNx06crs+82
        LDBPiCDoycBU2YCV+dqpI7AXUC9XjQATJMHj0kQm94R4A8OjAJzTA5lxjMMSIfa4
        wSN4Yrvy/dxV+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=9FD8F+TWKvse0buYqi4uiNdfXk0Yr
        VryNe2+KxwJxE4=; b=oxJR9qtnr/ARq80jMHXCFWbFYqrhra5VL5ntorj/gq22i
        bCY8v2ZSsNnI+dol38EmwEB6kYWPr7O+4BSuogilaXlA3YuG2xO1MKDEjfvUaTx2
        cmTCzumVZLG9DnSQ107idEhhAH9zJNJiqtCBffrgAQjhN8CgtkdL3lavFMawtEz4
        I9lTPMXdBBf8iiGgNri4mGUFXShs9KTqdbnp/xz2UJNOxkPui9RLcXLDk/RHKvBA
        oUndCxYQ2mu2d2UB07nMSWoySgolH3+YjUpBC3gT7dmA/K6c+GNKh1OYKknxFtRH
        ASP9lVzKccH6XNRfsAHXiHOCKX/M+Xm+HRMDdHynA==
X-ME-Sender: <xms:NeM-YEXoZe7DX0SAAr4mNzM3p2KjSxTGoDsM7yYSfO97tvsy9YboXQ>
    <xme:NeM-YIn_o00Nq95ajwoNSHKIWUPuU7G3CKBNO9CQ0uYu6LRIdx513zw412d9Xu8o9
    19s5F0Jg_AIJbNyFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtuddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefofg
    ggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgedvvdeigfdthf
    ettdfghedtleeuteefueetiefhledvhfelleeutedufedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:NuM-YIY7Fb6if0_XPGrmk9R13LPbWO3iTVKT27Fr1gixd5W0XsKOIA>
    <xmx:NuM-YDUo8FqkYotLKhaYgRakmuDWSOQZMrenQtfN0TW1PKtqQNZwKA>
    <xmx:NuM-YOmAgL-MC4DgK7ngcpT0qYlEiraixoSaf9jf-byxoVwDQgg4vA>
    <xmx:NuM-YCsl7rfBUt8K524WUjp-wl-O9CNixx8eDQIxzZUJK0QN6iQehQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C739015A005D; Tue,  2 Mar 2021 20:15:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
Date:   Tue, 02 Mar 2021 17:15:13 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Broken kretprobe stack traces
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

Jakub reported a bug with kretprobe stack traces -- wondering if you've gotten
any bug reports related to stack traces being broken for kretprobes.

I think (can't prove) this used to work:

    # bpftrace -e 'kretprobe:__tcp_retransmit_skb { @[kstack()] = count() }'
    Attaching 1 probe...
    ^C

    @[
        kretprobe_trampoline+0
    ]: 1

fentry/fexit probes seem to work:

    # bpftrace -e 'kretfunc:__tcp_retransmit_skb { @[kstack()] = count() }'
    Attaching 1 probe...
    ^C
    
    @[
        ftrace_trampoline+10799
        bpf_get_stackid_raw_tp+121
        ftrace_trampoline+10799
        __tun_chr_ioctl.isra.0.cold+33312
        __tcp_retransmit_skb+5
        tcp_send_loss_probe+254
        tcp_write_timer_handler+394
        tcp_write_timer+149
        call_timer_fn+41
        __run_timers+493
        run_timer_softirq+25
        __softirqentry_text_start+207
        asm_call_sysvec_on_stack+18
        do_softirq_own_stack+55
        irq_exit_rcu+158
        sysvec_apic_timer_interrupt+54
        asm_sysvec_apic_timer_interrupt+18
    ]: 1
    @[
        ftrace_trampoline+10799
        bpf_get_stackid_raw_tp+121
        ftrace_trampoline+10799
        __tun_chr_ioctl.isra.0.cold+33312
        __tcp_retransmit_skb+5
  <...>

which makes me suspect it's a kprobe specific issue.

Thanks,
Daniel
