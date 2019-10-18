Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F38DC55E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633981AbfJRMs5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 18 Oct 2019 08:48:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56818 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634008AbfJRMsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 08:48:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iLRgL-0007C8-O7; Fri, 18 Oct 2019 14:48:37 +0200
Date:   Fri, 18 Oct 2019 14:48:37 +0200
From:   Sebastian Sewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191018124837.vzfh425lasxrf7dv@linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
 <20191017145358.GA26267@pc-63.home>
 <20191017154021.ndza4la3hntk4d4o@linutronix.de>
 <20191017.132548.2120028117307856274.davem@davemloft.net>
 <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com>
 <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de>
 <20191018055222.cwx5dmj6pppqzcpc@ast-mbp>
 <alpine.DEB.2.21.1910181256120.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.DEB.2.21.1910181256120.1869@nanos.tec.linutronix.de>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-10-18 13:28:21 [+0200], Thomas Gleixner wrote:
> The local lock is a 'sleeping' spinlock on RT (PI support) and as any other

it is a "per-CPU 'sleeping' spinlock on RT". Which means that it can be
acquired on multiple CPUs simultaneously (same like
preempt_disable(),…).

> RT substituted lock it also ensures that the task cannot be migrated when
> it is held, which makes per cpu assumptions work - the kernel has lots of
> them. :)
…
> 	tglx

Sebastian
