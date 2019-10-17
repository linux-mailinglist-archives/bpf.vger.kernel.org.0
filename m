Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF6DB992
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 00:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441596AbfJQWNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 18:13:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43006 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441586AbfJQWNj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 18:13:39 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 15D27103DF888;
        Thu, 17 Oct 2019 15:13:38 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:13:35 -0700 (PDT)
Message-Id: <20191017.151335.597242104804050107.davem@davemloft.net>
To:     tglx@linutronix.de
Cc:     bigeasy@linutronix.de, daniel@iogearbox.net, bpf@vger.kernel.org,
        ast@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        peterz@infradead.org, williams@redhat.com
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
References: <20191017154021.ndza4la3hntk4d4o@linutronix.de>
        <20191017.132548.2120028117307856274.davem@davemloft.net>
        <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 15:13:38 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 17 Oct 2019 23:54:07 +0200 (CEST)

> Clark might have some insight from the product side for you how much that
> impacts usability.

You won't even be able to load systemd, it uses bpf.

We're moving to the point where even LSM modules will be implemented in bpf.
IR drivers require bpf:

	https://lwn.net/Articles/759188/

I understand the problems, and realize they are non-trivial, but this hammer
is really destructive on a fundamental level.

To a certain extent, those who insert bpf programs are explicitly
changing the kernel so really the onus is on them to make sure the
programs complete in time which is not only finite (which is
guaranteed by BPF) but also within the RT constraints.
