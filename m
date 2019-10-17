Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117A2DB33D
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440720AbfJQRZu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 13:25:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39032 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRZt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 13:25:49 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:5314:1b70:2a53:887e])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2383313EC182C;
        Thu, 17 Oct 2019 10:25:49 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:25:48 -0400 (EDT)
Message-Id: <20191017.132548.2120028117307856274.davem@davemloft.net>
To:     bigeasy@linutronix.de
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, tglx@linutronix.de,
        ast@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        peterz@infradead.org
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191017154021.ndza4la3hntk4d4o@linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
        <20191017145358.GA26267@pc-63.home>
        <20191017154021.ndza4la3hntk4d4o@linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 10:25:49 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 17 Oct 2019 17:40:21 +0200

> On 2019-10-17 16:53:58 [+0200], Daniel Borkmann wrote:
>> On Thu, Oct 17, 2019 at 11:05:01AM +0200, Sebastian Andrzej Siewior wrote:
>> > Disable BPF on PREEMPT_RT because
>> > - it allocates and frees memory in atomic context
>> > - it uses up_read_non_owner()
>> > - BPF_PROG_RUN() expects to be invoked in non-preemptible context
>> 
>> For the latter you'd also need to disable seccomp-BPF and everything
>> cBPF related as they are /all/ invoked via BPF_PROG_RUN() ...
> 
> I looked at tracing and it depended on BPF_SYSCALL so I assumed they all
> do… Now looking for BPF_PROG_RUN() there is PPP_FILTER,
> NET_TEAM_MODE_LOADBALANCE and probably more.  I didn't find a symbol for
> seccomp-BPF. 
> Would it make sense to override BPF_PROG_RUN() and make each caller fail
> instead? Other recommendations?

I hope you understand that basically you are disabling any packet sniffing
on the system with this patch you are proposing.

This means no tcpdump, not wireshark, etc.  They will all become
non-functional.

Turning off BPF just because PREEMPT_RT is enabled is a non-starter it is
absolutely essential functionality for a Linux system at this point.
