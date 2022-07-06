Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ACD5691DB
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiGFSbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiGFSbs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 14:31:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50248E6
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f9Ii8tE/pObkkb4aqdBkut0D7NLGv6JCUxdmC2yBlGs=; b=otFVN+yBMpofUtTDojp391cjDf
        Gf8ovL4zYi98td5/7hPyIAn1p6KRRAQt1j5yx4JUvL0uc0gU2Opv014Abgc6DOfWH45lJixkv1NRr
        Sd+bRSVnxoaamdXph8tZ0k2EhsIxjNGChNsi4ZGdu5L05oPpxyiHTdnUf3vqKlBaZJ+VoDb+nQHo3
        P91DcF1PRpJnIl/cSXDk9Yxz/3BCEghGFeKP+Zw54eaJ67y8A91mW86moVCFJXNC5uj21VlR9TIC2
        KXu5ZfrnyWItObkTGJ1dgbZSTJKAGiiQyvewCEsZHuwEMTSF8A+BnTS29vIC7fFmPN/mPhhgLligR
        pYoAXf5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o99oE-001s9f-3o; Wed, 06 Jul 2022 18:31:34 +0000
Date:   Wed, 6 Jul 2022 19:31:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YsXVBnLUiLSFxge4@casper.infradead.org>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <YsXSqSMxsvq13dV4@casper.infradead.org>
 <20220706182635.ccgt6zcr6bkd3rjc@MacBook-Pro-3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706182635.ccgt6zcr6bkd3rjc@MacBook-Pro-3.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 11:26:35AM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 06, 2022 at 07:21:29PM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 06, 2022 at 11:05:25AM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > > > For example, I assume that a BPF program
> > > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > > Right?
> > > 
> > > No. It's constrained by memcg limits only. It can allocate gigabytes.
> > 
> > I'm confused.  A BPF program is limited to executing 4096 insns and
> > using a maximum of 512 bytes of stack space, but it can allocate an
> > unlimited amount of heap?  That seems wrong.
> 
> 4k insn limit was lifted years ago.

You might want to update the documentation.
https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html
still says 4096.

> bpf progs are pretty close to be at parity with kernel modules.
> Except that they are safe, portable, and users have full visibility into them.
> It's not a blob of bytes unlike .ko.

It doesn't seem unreasonable to expect them to behave like kernel
modules, then.  If they want to allocate memory in NMI context, then
they should get to preallocate it before they go into NMI context.
