Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29009641923
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 21:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiLCU6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 15:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLCU6l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 15:58:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FE1B9F7
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 12:58:39 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670101117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=BqfCLn7bZHOUBcGvmtVJYpLj50IzdShCNo2WG6T9+CY=;
        b=yH/7vUcXfCU05YGuuFIV3X3YgjG0in+XcrSW1/enJSKobPMdsjxhRRyZmUVtOES9NXZ4t6
        3n9W/366mj/Zlwxau8W8Qh8bu/VF/O6JuYzo/d9PU8peZaI4GN3DhFrDoRIkdCIVMmzoxE
        Bqz/zZ22wWoQ3PhmR7h9u9sgD/Ct1gqPaMfCZy1/ydBtfKXRqtzJqXB9/Q8K5wXflv5OD0
        t0DSv4zaPVIeO6kd6PpNUCfCLw4QzoBtOzva8DMQSeloL9+PPwr5vmjtNt5NKovut2rVnH
        tQwkW/rEXZUMMVsGdp5ScbiedA7Xl+gm3BZaKVrPIyz7nBUkLU1JJ2Nm84AmVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670101117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=BqfCLn7bZHOUBcGvmtVJYpLj50IzdShCNo2WG6T9+CY=;
        b=gJVJzxFT2vA+2YS53faI0fsq1CMcOc45zmMQdCUlmu5eG0DEvr7Jr+a4q6IgTNdoMCAIOr
        dq/h8Y5XaJHwzwBg==
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <Y4thNkNW30x8Wcx8@kernel.org>
Date:   Sat, 03 Dec 2022 21:58:36 +0100
Message-ID: <871qpggq6b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 03 2022 at 16:46, Mike Rapoport wrote:
> On Thu, Dec 01, 2022 at 11:34:57PM +0100, Thomas Gleixner wrote:
>> If you mix this, then you end up with RWX for the whole 2M page. Not an
>> option really as you lose _all_ protections in one go.
>
> I meant to take one 2M page from the direct map and split it to 4K in the
> module address space. Then the protection could be done at PTE level after
> relocations etc and it would save the dance with text poking.

I see what you meant.

> But if mapping the code with 2M pages gives massive performance
> improvements, it's surely better to keep 2M pages in the modules
> space.

Yes.
