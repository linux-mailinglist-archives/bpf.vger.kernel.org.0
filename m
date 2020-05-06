Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB861C7782
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgEFRMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFRMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 13:12:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E078C061A0F;
        Wed,  6 May 2020 10:12:43 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWNb7-0000F7-Md; Wed, 06 May 2020 19:12:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1F961100C8A; Wed,  6 May 2020 19:12:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: pulling cap_perfmon
In-Reply-To: <CAADnVQJfD1dLVsfg4=c4f6ftRNF_4z0wELjFq8z=7voi-Ak=7w@mail.gmail.com>
References: <CAADnVQJfD1dLVsfg4=c4f6ftRNF_4z0wELjFq8z=7voi-Ak=7w@mail.gmail.com>
Date:   Wed, 06 May 2020 19:12:41 +0200
Message-ID: <87sggdj8c6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> I'd like to pull
> commit 980737282232 ("capabilities: Introduce CAP_PERFMON to kernel
> and user space")
> into bpf-next to base my CAP_BPF work on top of it.
> could you please prepare a stable tag for me to pull ?
> Last release cycle Thomas did a tag for bpf+rt prerequisite patches and
> it all worked well during the merge window.
> I think that one commit will suffice.

I'll have a look.
