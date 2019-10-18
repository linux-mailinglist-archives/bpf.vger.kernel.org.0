Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8024DC017
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404406AbfJRIiN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 04:38:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfJRIiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 04:38:13 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLNlv-0001vH-EG; Fri, 18 Oct 2019 10:38:07 +0200
Date:   Fri, 18 Oct 2019 10:38:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Miller <davem@davemloft.net>
cc:     Clark Williams <williams@redhat.com>,
        Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
In-Reply-To: <20191017.215739.1133924746697268824.davem@davemloft.net>
Message-ID: <alpine.DEB.2.21.1910181031040.1869@nanos.tec.linutronix.de>
References: <20191017.132548.2120028117307856274.davem@davemloft.net> <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de> <20191017214917.18911f58@tagon> <20191017.215739.1133924746697268824.davem@davemloft.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 17 Oct 2019, David Miller wrote:

> From: Clark Williams <williams@redhat.com>
> Date: Thu, 17 Oct 2019 21:49:17 -0500
> 
> > BPF programs cannot loop and are limited to 4096 instructions.
> 
> The limit was increased to 1 million not too long ago.

Assuming a instruction/cycle ratio of 1.0 and a CPU frequency of 2GHz,
that's 500us of preempt disabled time. Out of bounds by at least one order
of magntiude for a lot of RT scenarios.

Thanks,

	tglx


