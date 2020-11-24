Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798052C22A3
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 11:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbgKXKRF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 05:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbgKXKRE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 05:17:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B816C0613D6;
        Tue, 24 Nov 2020 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/3aXByI6bMVnI2xSKBiJLrwoPXo5PJB6CawKv/IS7m4=; b=gdU7ME06fB7+n99iu6TMoZyUUc
        sPWz41w/lixVtkjHShfW4nAkMt3M6sIfTW42NCTlX4WIsUuOG1F0mImYZ2krw93cGRS6I7DEe5HII
        OEHyNkFq6BuV51iduvF160XWFREuEoFgNYbx4IoO/a+Ht4UG/KKYbZgx4r8n3+HpyqXNdg8CgjzvQ
        jxIf8JNzDHBDJ5Y+jYIOoCCGoUhwbjuHSpvTGQndYczBsdOgvRrWtUTnd74Gpc+EgdRF0mb5SK8z6
        QmHLq9r/UVn+t2sT59R6omg7hX4NamRC2LtrrU5qQH5nV0/t8lbGIJH1osf6QfhFcaSyXOdWb09VX
        vMbxqhRw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khVNY-0002hO-VT; Tue, 24 Nov 2020 10:16:57 +0000
Date:   Tue, 24 Nov 2020 10:16:56 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Message-ID: <20201124101656.GA9682@infradead.org>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
 <20201120202426.18009-2-rick.p.edgecombe@intel.com>
 <CALCETrUjpdSGg0T8vehkXszDJKx5AS0BHP9qFRsakPABzPM2GA@mail.gmail.com>
 <90d528be131a77a167df757b83118a275d9cb35f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d528be131a77a167df757b83118a275d9cb35f.camel@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 12:01:35AM +0000, Edgecombe, Rick P wrote:
> Another option could be putting the new metadata in vm_struct and just
> return that, like get_vm_area(). Then we don't need to invent a new
> struct. But then normal vmalloc()'s would have a bit of wasted memory
> since they don't need this metadata.

That would seem most natural to me.  We'll need to figure out how we
can do that without bloating vm_struct too much.  One option would
be a bigger structure that embedds vm_struct and can be retreived using
container_of().
