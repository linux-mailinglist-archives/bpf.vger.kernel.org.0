Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1371DB144
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406345AbfJQPkY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Oct 2019 11:40:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406343AbfJQPkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 11:40:24 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iL7sz-0002IC-D8; Thu, 17 Oct 2019 17:40:21 +0200
Date:   Thu, 17 Oct 2019 17:40:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191017154021.ndza4la3hntk4d4o@linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
 <20191017145358.GA26267@pc-63.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191017145358.GA26267@pc-63.home>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-10-17 16:53:58 [+0200], Daniel Borkmann wrote:
> On Thu, Oct 17, 2019 at 11:05:01AM +0200, Sebastian Andrzej Siewior wrote:
> > Disable BPF on PREEMPT_RT because
> > - it allocates and frees memory in atomic context
> > - it uses up_read_non_owner()
> > - BPF_PROG_RUN() expects to be invoked in non-preemptible context
> 
> For the latter you'd also need to disable seccomp-BPF and everything
> cBPF related as they are /all/ invoked via BPF_PROG_RUN() ...

I looked at tracing and it depended on BPF_SYSCALL so I assumed they all
do… Now looking for BPF_PROG_RUN() there is PPP_FILTER,
NET_TEAM_MODE_LOADBALANCE and probably more.  I didn't find a symbol for
seccomp-BPF. 
Would it make sense to override BPF_PROG_RUN() and make each caller fail
instead? Other recommendations?
 
Sebastian
