Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F167569230
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiGFSvJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiGFSvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 14:51:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2D52A958
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 11:51:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y18so6360445plb.2
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qOVYbAeMuUTqqBL9cN7VNIllKUdudIxLEASAJ8q4pSo=;
        b=kiYMusPRoyf2MXU7Z6Oz6kTe1rl1jQNhCf3sPKcG05Un85jHHFyqHXAI07NeI+Pbo9
         Td3Kg5Aqf9GCry0uh4Ot6yFRZP6OzBCZ/UFtfc9oF/76q10jquN6ObefAsGn0qeoe+KT
         kbU50KqYB22AkAghu1TbGnCFVpJI/lZqVYKyoX6Vud0vogmfw9jrZ38u3D4yyJpgvDeH
         dzkikEE+QhkYSmCLb09G3xfpJ/qbQOOnNAGHso6Fh3a+f0PwuZ0AWwtVBdA3taqAsu/R
         DgzSP1lI69TSvEWjcaEMoPVpbcds3c2IcO2kA+OS1AXFC378Xjk5TqqM5ZbJvfxtg1ZL
         LeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qOVYbAeMuUTqqBL9cN7VNIllKUdudIxLEASAJ8q4pSo=;
        b=41x6DquiBHedt+NQ29uloKe4uOs+W0NpMFqv0cQHbq1Npfy3iav/ay2wPU/nEg544B
         ZO1y7Ds9YkRn28Y/VOIJ7HC8CdZW8KVyyjjxSiepDFP3x/QBqBCNfZ8XttIYAYLkWqJc
         QqIpvvCK4JIe/xYKo7gfQdmq5I8dn0Hb8GhtuSs2aq1QjWjxc2lIWGGWfSC5egpahyiO
         GZ/uFeQy8BjQSGvl6g17PpNgcQsEJGbnjxZ5SrhCxHmxoY0yl5tsd103PKGc+HC3Jbhb
         gMnMvVDMXUeNKTfh4aQ8OEOR36QLHJoGPIFH2fy0TNcv5L88jGwKXI6vjRbqXuwWmNei
         I5zg==
X-Gm-Message-State: AJIora/7P0pp4FZi0MqtWmGb2xcRQeKwufzuKiSrwKzenqUfaYBpP99P
        XhfeviUaeLEGmcv3d3rcE4Y=
X-Google-Smtp-Source: AGRyM1uFB0iL8cEYKSKELNOUTDYbEHc7nn7WNdRd8QL5L5frD1AGt8s2utJ8xxPHqgESUjcvOAfhng==
X-Received: by 2002:a17:902:cccf:b0:168:e13c:5cd9 with SMTP id z15-20020a170902cccf00b00168e13c5cd9mr48567088ple.53.1657133467180;
        Wed, 06 Jul 2022 11:51:07 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::2:8597])
        by smtp.gmail.com with ESMTPSA id ij7-20020a170902ab4700b0016bd8a76f67sm8603745plb.67.2022.07.06.11.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:51:06 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:51:03 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20220706185103.jdybh757u5esokt3@MacBook-Pro-3.local>
References: <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <YsXSqSMxsvq13dV4@casper.infradead.org>
 <20220706182635.ccgt6zcr6bkd3rjc@MacBook-Pro-3.local>
 <YsXVBnLUiLSFxge4@casper.infradead.org>
 <20220706183619.3mmtsyi72c6ss5tu@MacBook-Pro-3.local>
 <YsXXLDy3u1AXDuGc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsXXLDy3u1AXDuGc@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 07:40:44PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 11:36:19AM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 06, 2022 at 07:31:34PM +0100, Matthew Wilcox wrote:
> > > On Wed, Jul 06, 2022 at 11:26:35AM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Jul 06, 2022 at 07:21:29PM +0100, Matthew Wilcox wrote:
> > > > > On Wed, Jul 06, 2022 at 11:05:25AM -0700, Alexei Starovoitov wrote:
> > > > > > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > > > > > > For example, I assume that a BPF program
> > > > > > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > > > > > Right?
> > > > > > 
> > > > > > No. It's constrained by memcg limits only. It can allocate gigabytes.
> > > > > 
> > > > > I'm confused.  A BPF program is limited to executing 4096 insns and
> > > > > using a maximum of 512 bytes of stack space, but it can allocate an
> > > > > unlimited amount of heap?  That seems wrong.
> > > > 
> > > > 4k insn limit was lifted years ago.
> > > 
> > > You might want to update the documentation.
> > > https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html
> > > still says 4096.
> > 
> > No. Please read what you're quoting first.
> 
> I did read it.  It says
> 
> : The only limit known to the user space is BPF_MAXINSNS (4096). It’s the
> : maximum number of instructions that the unprivileged bpf program can have.
> 
> It really seems pretty clear to me.  You're saying my understanding
> is wrong.  So it must be badly written.  Even now, I don't understand
> how I've misunderstood it.

huh? Still missing 'unprivileged' in the above ?
and completely ignoring the rest of the paragraph in the link above?

> > > > bpf progs are pretty close to be at parity with kernel modules.
> > > > Except that they are safe, portable, and users have full visibility into them.
> > > > It's not a blob of bytes unlike .ko.
> > > 
> > > It doesn't seem unreasonable to expect them to behave like kernel
> > > modules, then.  If they want to allocate memory in NMI context, then
> > > they should get to preallocate it before they go into NMI context.
> > 
> > You're still missing 'any context' part from the previous email.
> 
> Really, this is not a productive way to respond.  I want to help
> and you're just snarling at me.

To help you need to understand what bpf is while you're failing
to read the doc.
