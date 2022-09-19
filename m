Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424505BD2C0
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiISQ6Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiISQ6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 12:58:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96193A14B
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KO6mvc6wvq3xmKN8BDxSKfp1XgKzZyb0SPWgE9GVBic=; b=rS7jP5usS03ylHa9MpNy2+nBnN
        zrdbY4hwBAJzjoEm+PsB0+duWNXZWJ5Oix1B819x+eVRWbM1RSNmu3U4g5Cl7ktL/FZYCayEkWdNI
        TVA7cqvY9gyrlmyVgvY2oA+7wCJVx+7Fw28diwBhf59Vx5hFSvR0oQUhRXxTpye+xvTQg4Yl2PWFG
        E9buZN2DClpN/YMJg8duoahvZlOtHpDpGfX3W4Tizo7l2NwvOybiL0Jn/bIfZaXHDycTtxPHpQWNy
        UILZOQ2AlC/YHBnGhiQjDh9Bu4DvDIEqqS6xJnHiciCtnTGfzz3kCZEhHXwl18QrQLnr+4IVjA9Tq
        t0VPOVPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaK60-00D3fC-SV; Mon, 19 Sep 2022 16:58:12 +0000
Date:   Mon, 19 Sep 2022 09:58:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
Message-ID: <YyifpJR4uwZwvpkc@infradead.org>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Dave,

there is a lot of good thing in here, but it is a bit hard to review,
mostly because it is a giant patch instead of a single well-documented
patch per logical thing to change.

A bunch of nitpicks below, mostly style or organizational:


> +The current Instruction Set Architecture (ISA) version, sometimes referred to in other documents
> +as a "CPU" version, is 3.  This document also covers older versions of the ISA.

Hmm, I thought the versioning was a bit more complicated based on
the mailing list interactions and the call.  Especially with things
like the full atomics not even supported by all gits.

> +   **Note**
> +
> +   *Linux implementation*: In the Linux kernel, the exit value for eBPF
> +   programs is passed as a 32 bit value.

Is this Linux, a specific program type, or the ISA?

> +   *Linux implementation*: In the Linux kernel, all program types only use
> +   R1 which contains the "context", which is typically a structure containing all
> +   the inputs needed.  

I also think these Linux notes do not belong into the main instruction
set document, which tries to really just describe the ISA.

> - * the basic instruction encoding, which uses 64 bits to encode an instruction
> - * the wide instruction encoding, which appends a second 64-bit immediate value
> -   (imm64) after the basic instruction for a total of 128 bits.
> +* the basic instruction encoding, which uses 64 bits to encode an instruction
> +* the wide instruction encoding, which appends a second 64-bit immediate (i.e.,

Btw, can you explain why you de-indent these?  I picked the space before
the * because that seems to be what most Linux RST documents do.

> +   For ISA versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
> +   ``-Xclang -target-feature -Xclang +alu32``.

I also suspect the clang notes would be better off in a separate
document from the main ISA.

> -BPF_XOR | BPF_K | BPF_ALU means::
> +   *Linux implementation*: In the Linux kernel, uint32_t is expressed as u32,
> +   uint64_t is expressed as u64, etc.  This document uses the standard C terminology
> +   as the cross-platform specification.

I don't think this makes sense in the document.  Instead we probably
need a "Conventions" section that defines the type and syntax we use.

