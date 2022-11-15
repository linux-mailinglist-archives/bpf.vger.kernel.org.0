Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5326629D07
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 16:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKOPJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 10:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiKOPJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 10:09:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC317AB2;
        Tue, 15 Nov 2022 07:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF22A61821;
        Tue, 15 Nov 2022 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4499BC433D6;
        Tue, 15 Nov 2022 15:09:42 +0000 (UTC)
Date:   Tue, 15 Nov 2022 15:09:37 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tomislav Novak <tnovak@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Gosselin <sgosselin@fb.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Message-ID: <Y3OrsU9M+X2UUcRG@arm.com>
References: <20220923203644.2731604-1-tnovak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923203644.2731604-1-tnovak@fb.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 01:36:45PM -0700, Tomislav Novak wrote:
> On ARM platforms is_default_overflow_handler() is used to determine if
> hw_breakpoint code should single-step over the watchpoint trigger or
> let the custom handler deal with it.
> 
> Attaching a BPF program to a watchpoint replaces the handler with
> bpf_overflow_handler, which isn't recognized as a default handler so we
> never step over the instruction triggering the data abort exception (the
> watchpoint keeps firing):
> 
>   # bpftrace -e 'watchpoint:0x10000000:4:w { printf("hit\n"); }' ./wp_test
>   Attaching 1 probe...
>   hit
>   hit
>   hit
>   [...]
> 
> (wp_test performs a single 4-byte store to address 0x10000000)
> 
> This patch replaces the check with uses_default_overflow_handler(), which
> accounts for the bpf_overflow_handler() case by also testing if the handler
> invokes one of the perf_event_output functions via orig_default_handler.
> 
> Signed-off-by: Tomislav Novak <tnovak@fb.com>
> Tested-by: Samuel Gosselin <sgosselin@fb.com> # arm64
> ---
>  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
>  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
>  include/linux/perf_event.h        | 22 +++++++++++++++++++---
>  3 files changed, 25 insertions(+), 9 deletions(-)

It looks like this slipped through the cracks. I'm fine with the patch
but could you split the arm and arm64 parts in separate patches? Unless
rmk acks it and we can take the patch through the arm64 (or perf) tree.

-- 
Catalin
