Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECB29A29
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbfEXOj3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 10:39:29 -0400
Received: from foss.arm.com ([217.140.101.70]:44338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390885AbfEXOj3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 10:39:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F1A80D;
        Fri, 24 May 2019 07:39:29 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E44AD3F575;
        Fri, 24 May 2019 07:39:27 -0700 (PDT)
Date:   Fri, 24 May 2019 15:39:22 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     catalin.marinas@arm.com, daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yoshihiro.shimoda.uh@renesas.com, kuninori.morimoto.gx@renesas.com
Subject: Re: [PATCH 1/2] arm64: insn: Fix ldadd instruction encoding
Message-ID: <20190524143922.GA7870@fuggles.cambridge.arm.com>
References: <20190524125220.25463-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524125220.25463-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 24, 2019 at 01:52:19PM +0100, Jean-Philippe Brucker wrote:
> GCC 8.1.0 reports that the ldadd instruction encoding, recently added to
> insn.c, doesn't match the mask and couldn't possibly be identified:
> 
>  linux/arch/arm64/include/asm/insn.h: In function 'aarch64_insn_is_ldadd':
>  linux/arch/arm64/include/asm/insn.h:280:257: warning: bitwise comparison always evaluates to false [-Wtautological-compare]
> 
> Bits [31:30] normally encode the size of the instruction (1 to 8 bytes)
> and the current instruction value only encodes the 4- and 8-byte
> variants. At the moment only the BPF JIT needs this instruction, and
> doesn't require the 1- and 2-byte variants, but to be consistent with
> our other ldr and str instruction encodings, clear the size field in the
> insn value.
> 
> Fixes: 34b8ab091f9ef57a ("bpf, arm64: use more scalable stadd over ldxr / stxr loop in xadd")
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Cheers, I've picked up this patch with Daniel's Ack, and also the other
patch as-is.

Will
