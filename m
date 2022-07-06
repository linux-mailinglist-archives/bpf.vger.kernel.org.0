Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805445691FC
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiGFShJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiGFSg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 14:36:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349C2B24A
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 11:36:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a15so15072716pfv.13
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EssyX2zYH+6lemVwgoSPIPUohN3bYwLSTLZWWFh3bMc=;
        b=nAv9iKvi+Z2hezH3BVj1RqYgFRSH8GlHcGNO822p+9reNEjxidqOXRh4f6EfR+S6cH
         L8UGY2JD9C4QMyjbZZvt83sQkndtrjynVrhdi3Lcb4iSs7zt/yN0k6gXW6SIT0U3SsgW
         F22M9TlNsNPlJR5tUDifYCWXuiV2o5eqqBMKtH0kbbi+rCkzasPmgNkib+CeBytZyW73
         cccFzES5PEFAaHJrQmsDsWTL1M4CjSYPs6moGo57w/Azo7yiCw7pxz112juHCayfm59b
         +jYO9jwsd3rB75cFytkLAHIm5T1csPIx721SB8qfurP86yki1LE4bquKeK5/hyfw7JGO
         KZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EssyX2zYH+6lemVwgoSPIPUohN3bYwLSTLZWWFh3bMc=;
        b=XtaKNGsyME/5TWGRh7N+J/EDX4n/NX1J9bTOCVZp1Gx7/TWCkcMnn+RBwjUzqRojq8
         Xo30zvH0rfXX9nfJ0vYhKLadktntSF1bl3KyesXWTi7q+BsOygVGNmuu9WxxFPdlwd1M
         1MxhYfOcU/PR6xnwh0jm4+7Vm0mrPZjIwv1rsg3aKbZmVkF2ftIn7NtO5RaMDBUQ4mCe
         jOg9BMSWnprWhcE3xkwIvhM1ivAkyU3JNqQGX7g2kRKzdaH857gAn7KZkUzQDwHyZJHl
         3qoL3Mzy99GVKQ7G8TCvYTpOeGZkJ+uSyyXcbLzdypHtb+Q7j8RFIL9gBqcRrSg81mUm
         2dSA==
X-Gm-Message-State: AJIora/4Rh+ObZxr8WixNwWcUOU4eVB/dIYf6ywmku69+UAP0h0ae+Yr
        aJ+TMx8jCnKk/TS5AvrYd2U=
X-Google-Smtp-Source: AGRyM1tGcz+2urZQJrC7c1PtUuqwXYtYj2W3BgNsAJuqpY2EfLA6pVsuusr2F2jwof+K6V0/mojVdw==
X-Received: by 2002:a63:e446:0:b0:412:937b:5a3c with SMTP id i6-20020a63e446000000b00412937b5a3cmr4857134pgk.316.1657132582886;
        Wed, 06 Jul 2022 11:36:22 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::2:8597])
        by smtp.gmail.com with ESMTPSA id y9-20020a056a001c8900b005254535a2cfsm24712822pfw.136.2022.07.06.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:36:22 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:36:19 -0700
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
Message-ID: <20220706183619.3mmtsyi72c6ss5tu@MacBook-Pro-3.local>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <YsXSqSMxsvq13dV4@casper.infradead.org>
 <20220706182635.ccgt6zcr6bkd3rjc@MacBook-Pro-3.local>
 <YsXVBnLUiLSFxge4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsXVBnLUiLSFxge4@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 07:31:34PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 11:26:35AM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 06, 2022 at 07:21:29PM +0100, Matthew Wilcox wrote:
> > > On Wed, Jul 06, 2022 at 11:05:25AM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > > > > For example, I assume that a BPF program
> > > > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > > > Right?
> > > > 
> > > > No. It's constrained by memcg limits only. It can allocate gigabytes.
> > > 
> > > I'm confused.  A BPF program is limited to executing 4096 insns and
> > > using a maximum of 512 bytes of stack space, but it can allocate an
> > > unlimited amount of heap?  That seems wrong.
> > 
> > 4k insn limit was lifted years ago.
> 
> You might want to update the documentation.
> https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html
> still says 4096.

No. Please read what you're quoting first.

> > bpf progs are pretty close to be at parity with kernel modules.
> > Except that they are safe, portable, and users have full visibility into them.
> > It's not a blob of bytes unlike .ko.
> 
> It doesn't seem unreasonable to expect them to behave like kernel
> modules, then.  If they want to allocate memory in NMI context, then
> they should get to preallocate it before they go into NMI context.

You're still missing 'any context' part from the previous email.
