Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3672310D8A2
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2019 17:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfK2Qsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Nov 2019 11:48:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49167 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfK2Qsu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Nov 2019 11:48:50 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iajRi-0002HW-7q; Fri, 29 Nov 2019 17:48:42 +0100
Date:   Fri, 29 Nov 2019 17:48:42 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: xdpsock poll with 5.2.21rt kernel
Message-ID: <20191129164842.qimcmjlz5xq7uupw@linutronix.de>
References: <CAD56B7dwKDKnrCjpGmrnxz2P0QpNWU3CGBvOtqg3RBx3ejPh9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD56B7dwKDKnrCjpGmrnxz2P0QpNWU3CGBvOtqg3RBx3ejPh9g@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-11-12 17:42:42 [-0500], Paul Thomas wrote:
> Any thoughts would be appreciated.

Could please enable CONFIG_DEBUG_ATOMIC_SLEEP and check if the kernel
complains?

> thanks,
> Paul

Sebastian
