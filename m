Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBDB56923D
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiGFSzh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiGFSzc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 14:55:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B726105
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KZFsk7y7JYTxqy6VfuUQHbE8FIEJpo9MA6tv6wo/JGs=; b=Oz2uJccQVkLS55Lx5ytdPT/WJR
        ruo6qPnDUq+tLeOgV2yw6UzYtTAe+aRFvCWXgY7tPCnNkF5D49fZp7p3j5Ba5LYSRQtcIKMnyhX0s
        aQwUGE5/j4+4gsa2o073inbxPUvlTKsWi7eqiM9LYGupnC8U/OZC1n6uwbhAA+HAZjM/Y6w9jjld5
        e5b0YhYimRsDVo4t02BAiDHbc7hdS55K6gr3b9Jdz7bGSQ3UtbVCf31d4raNlD9Vs/ihq998nrc5S
        XbcCKEqYMlmT3JHaYkh5YyFj39K7AVfAAJ0zAoLOhyIbvrA+pYkGkr1PXo/eTei7nOPHVWSxfeFT/
        7Qyn9RcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9ABB-001ta8-3z; Wed, 06 Jul 2022 18:55:17 +0000
Date:   Wed, 6 Jul 2022 19:55:17 +0100
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
Message-ID: <YsXalc6kgFNBVKTP@casper.infradead.org>
References: <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <YsXSqSMxsvq13dV4@casper.infradead.org>
 <20220706182635.ccgt6zcr6bkd3rjc@MacBook-Pro-3.local>
 <YsXVBnLUiLSFxge4@casper.infradead.org>
 <20220706183619.3mmtsyi72c6ss5tu@MacBook-Pro-3.local>
 <YsXXLDy3u1AXDuGc@casper.infradead.org>
 <20220706185103.jdybh757u5esokt3@MacBook-Pro-3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706185103.jdybh757u5esokt3@MacBook-Pro-3.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 11:51:03AM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 06, 2022 at 07:40:44PM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 06, 2022 at 11:36:19AM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jul 06, 2022 at 07:31:34PM +0100, Matthew Wilcox wrote:
> > > > On Wed, Jul 06, 2022 at 11:26:35AM -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Jul 06, 2022 at 07:21:29PM +0100, Matthew Wilcox wrote:
> > > > > > On Wed, Jul 06, 2022 at 11:05:25AM -0700, Alexei Starovoitov wrote:
> > > > > > > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > > > > > > > For example, I assume that a BPF program
> > > > > > > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > > > > > > Right?
> > > > > > > 
> > > > > > > No. It's constrained by memcg limits only. It can allocate gigabytes.
> > > > > > 
> > > > > > I'm confused.  A BPF program is limited to executing 4096 insns and
> > > > > > using a maximum of 512 bytes of stack space, but it can allocate an
> > > > > > unlimited amount of heap?  That seems wrong.
> > > > > 
> > > > > 4k insn limit was lifted years ago.
> > > > 
> > > > You might want to update the documentation.
> > > > https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html
> > > > still says 4096.
> > > 
> > > No. Please read what you're quoting first.
> > 
> > I did read it.  It says
> > 
> > : The only limit known to the user space is BPF_MAXINSNS (4096). It’s the
> > : maximum number of instructions that the unprivileged bpf program can have.
> > 
> > It really seems pretty clear to me.  You're saying my understanding
> > is wrong.  So it must be badly written.  Even now, I don't understand
> > how I've misunderstood it.
> 
> huh? Still missing 'unprivileged' in the above ?
> and completely ignoring the rest of the paragraph in the link above?

Are you saying that unprivileged programs are not allowed to allocate
memory?  Or that there is a limit on the amount of heap memory that
unprivileged programs are allowed to allocate.

> > > > > bpf progs are pretty close to be at parity with kernel modules.
> > > > > Except that they are safe, portable, and users have full visibility into them.
> > > > > It's not a blob of bytes unlike .ko.
> > > > 
> > > > It doesn't seem unreasonable to expect them to behave like kernel
> > > > modules, then.  If they want to allocate memory in NMI context, then
> > > > they should get to preallocate it before they go into NMI context.
> > > 
> > > You're still missing 'any context' part from the previous email.
> > 
> > Really, this is not a productive way to respond.  I want to help
> > and you're just snarling at me.
> 
> To help you need to understand what bpf is while you're failing
> to read the doc.

Part of working with other people is understanding that they don't know
as much as you do about your thing, and at the same time understanding
that you don't know as much as they do about their thing.  That means
explaining things in a way which makes sense to them instead of getting
all huffy when they don't understand the details of your thing.
