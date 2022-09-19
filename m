Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BBF5BD339
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiISRGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 13:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiISRFp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 13:05:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478541D0D
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKExie7cc2776dnzOmIqC0+KqvbyLjYZ/uSxppzeE0w=; b=rcGbw7jr/sXX8jHAKTPG+MoP36
        TOpfrZGxdF1Fun1n9YK1knjrKgP+i1LuBIDXzBcVWWbK0RY8pFPaL95NijUGJ1HAAFscSIFJSP0fW
        T0jhw9Lq9aUEwQRUaCbk8yI4t+PXxZe2iIhAGtmPJ4nmlZSS5+HjvnEt2lGi1P2WNvr/XKS4nx05u
        l4JtpckrLV4ahppRF/UNQYcAJnNG0UWyfabtTE/aWWhILSLsxavGW8+IHUGcPTKB4WAFoauMbdsA1
        eGG0d1EbrgBDoN7cOP3vxaMiAXh7+VLGRogFtV5fZicnjAN6h8KZe2K4JvLzhBsuAfE057L2PKkpm
        q8W9JlJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaKBw-00D7QY-Gs; Mon, 19 Sep 2022 17:04:20 +0000
Date:   Mon, 19 Sep 2022 10:04:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Dave Thaler <dthaler@microsoft.com>, bpf <bpf@vger.kernel.org>
Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
Message-ID: <YyihFIOt6xGWrXdC@infradead.org>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyFzO205ZZPieCav@syu-laptop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 14, 2022 at 02:22:51PM +0800, Shung-Hsi Yu wrote:
> As discussed in yesterday's session, there's no graceful abortion on
> division by zero, instead, the BPF verifier in Linux prevents division by
> zero from happening. Here a few additional notes:

Hmm, I thought Alexei pointed out a while ago that divide by zero is
now defined to return 0 following.  Ok, reading further along I think
that is what you describe with the pseudo-code below. 

> While BPF ISA only supports direct call BPF_CALL[1], technically there is an
> opcode 0x8d (BPF_JUMP | BPF_CALL | BPF_X) that has the indirect call
> semantic, and Clang emit such indirect call instruction if user attempt to
> compile with -O0.
> 
> I think it worth mentioning in this document for better clarity, perhaps
> simply saying that indirect call is not part of BPF ISA is enough.

Which brings up another question:  Do we need a list of opcodes
that someone else defined somewhere that are not considered valid
eBPF?  Or how do we get clang and gcc to stop producing invalid
eBPF might be the better question.
