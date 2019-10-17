Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47202DB341
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440722AbfJQR0E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 13:26:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQR0D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 13:26:03 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:5314:1b70:2a53:887e])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E492813AE684A;
        Thu, 17 Oct 2019 10:26:02 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:26:02 -0400 (EDT)
Message-Id: <20191017.132602.1403118968555353816.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     bigeasy@linutronix.de, bpf@vger.kernel.org, tglx@linutronix.de,
        ast@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        peterz@infradead.org
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191017145358.GA26267@pc-63.home>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
        <20191017145358.GA26267@pc-63.home>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 10:26:03 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 17 Oct 2019 16:53:58 +0200

> On Thu, Oct 17, 2019 at 11:05:01AM +0200, Sebastian Andrzej Siewior wrote:
>> Disable BPF on PREEMPT_RT because
>> - it allocates and frees memory in atomic context
>> - it uses up_read_non_owner()
>> - BPF_PROG_RUN() expects to be invoked in non-preemptible context
> 
> For the latter you'd also need to disable seccomp-BPF and everything
> cBPF related as they are /all/ invoked via BPF_PROG_RUN() ...

+1  Right, we can't do this, no way.
