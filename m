Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCB5742E0
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 06:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiGNE1j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 00:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiGNE06 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 00:26:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF74B2B1AF;
        Wed, 13 Jul 2022 21:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wvxNVC7v6IRfhPDvi+vlda/Ydr6xcl7uzGy3JRiwJsk=; b=h6zx/qtQBkYoU+/liavyngGoGQ
        qsOPbojToSP07GYfoD4L1Rj/BdqAn48dD0TbbkCv6s0frYjwB2NxyHfS8sg/zexGgCpRPzE/TYQFN
        Li5G/evrqQyw+eHnbHDEYkA4UPfWAFvroO4nVkNVpo0j73IBWKbiJAUxbwqIo60Snl76iyVaNU4i/
        PwqGuaMEcrYNxkwnJJxhEXZau/ZDirtLGlKAl9iQ27dKm5Nb57sDSzijqu4zBp3yAGRrB/+7UcQNB
        Eqroje4xhcnqhz99amuRSNTyDZf+KIL39W8xd/Abw/myVnEL3l8woK+0k4FNHzi/b7nJee72rFeH8
        mFG3QhHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBqOC-00AasH-TU; Thu, 14 Jul 2022 04:23:48 +0000
Date:   Wed, 13 Jul 2022 21:23:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys+aVKFJaQd130Pn@infradead.org>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6ZkDUhRZcmvPYy@infradead.org>
 <BE896037-B79C-4B38-B777-96002C5861F5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE896037-B79C-4B38-B777-96002C5861F5@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 03:49:45PM +0000, Song Liu wrote:
> 
> 
> > On Jul 13, 2022, at 3:08 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > NAK.  This is not something that should be an exported public API
> > ever.
> 
> Hmm.. I will remove EXPORT_SYMBOL_GPL (if we ever do a v2 of this..)

Even without that it really is not a vmalloc API anyway.  Executable
memory needs to be written first, so we should allocate it in that state
and only mark it executable after that write has completed.
