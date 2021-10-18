Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D895143185B
	for <lists+bpf@lfdr.de>; Mon, 18 Oct 2021 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJRMCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Oct 2021 08:02:41 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:34092 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhJRMCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Oct 2021 08:02:41 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2027292009D; Mon, 18 Oct 2021 14:00:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 18D7E92009C;
        Mon, 18 Oct 2021 14:00:27 +0200 (CEST)
Date:   Mon, 18 Oct 2021 14:00:27 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        paulburton@kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        yangtiezhu@loongson.cn, tony.ambardar@gmail.com,
        bpf@vger.kernel.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/7] mips: uasm: Add workaround for Loongson-2F nop CPU
 errata
In-Reply-To: <20211005165408.2305108-3-johan.almbladh@anyfinetworks.com>
Message-ID: <alpine.DEB.2.21.2110181359111.31442@angie.orcam.me.uk>
References: <20211005165408.2305108-1-johan.almbladh@anyfinetworks.com> <20211005165408.2305108-3-johan.almbladh@anyfinetworks.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 5 Oct 2021, Johan Almbladh wrote:

> This patch implements a workaround for the Loongson-2F nop in generated,
> code, if the existing option CONFIG_CPU_NOP_WORKAROUND is set. Before,
> the binutils option -mfix-loongson2f-nop was enabled, but no workaround
> was done when emitting MIPS code. Now, the nop pseudo instruction is
> emitted as "or ax,ax,zero" instead of the default "sll zero,zero,0". This

 Confusing typo here, s/ax/at/.

  Maciej
