Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323BD35482F
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 23:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbhDEVdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 17:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhDEVdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 17:33:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6CC061756;
        Mon,  5 Apr 2021 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wry8Jt8iN0Mer/EWMWcLYvNntsxmxMJzoHKncgg0YMw=; b=j5tqFDtw4Ez6xytQb1FvHDf3pZ
        xDE7Axs2HVnmrdwKBV8FeyDDGhNEv7QvdwERMdg4ub6YpCPR/uVl+7GLIxb7ASSMutEg9+P6hSKG+
        HrvwVOzB/6mi2+38HIJwSR0b1UCACmXsdKVxFd1RfOmtaigK2J1CteIXCxtF8K3FQel68F2uYetkv
        /FC4JQype1iNxgL5cJsHvsynb5ay8dVX+sPuTATljSIO68GPnkWPNFjNCDgdea4fbHkvBC7cbtfZh
        ySIZZGrcHdotRW2PfmjuV2vN79a1USCcMz4fhpEtpZmHmWAiwc6c4lnfHYMblpVUvT3wHY31VhZ6v
        9hWcj8YA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTWq0-00Btzh-KR; Mon, 05 Apr 2021 21:32:52 +0000
Date:   Mon, 5 Apr 2021 22:32:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, hch@infradead.org,
        x86@kernel.org
Subject: Re: [RFC 2/3] vmalloc: Support grouped page allocations
Message-ID: <20210405213248.GN2531743@casper.infradead.org>
References: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
 <20210405203711.1095940-3-rick.p.edgecombe@intel.com>
 <971aae01-32a0-3f45-1810-010e3295b1c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971aae01-32a0-3f45-1810-010e3295b1c4@intel.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 05, 2021 at 02:01:58PM -0700, Dave Hansen wrote:
> On 4/5/21 1:37 PM, Rick Edgecombe wrote:
> > +static void __dispose_pages(struct list_head *head)
> > +{
> > +	struct list_head *cur, *next;
> > +
> > +	list_for_each_safe(cur, next, head) {
> > +		list_del(cur);
> > +
> > +		/* The list head is stored at the start of the page */
> > +		free_page((unsigned long)cur);
> > +	}
> > +}
> 
> This is interesting.
> 
> While the page is in the allocator, you're using the page contents
> themselves to store the list_head.  It took me a minute to figure out
> what you were doing here because: "start of the page" is a bit
> ambiguous.  It could mean:
> 
>  * the first 16 bytes in 'struct page'
> or
>  * the first 16 bytes in the page itself, aka *page_address(page)
> 
> The fact that this doesn't work on higmem systems makes this an OK thing
> to do, but it is a bit weird.  It's also doubly susceptible to bugs
> where there's a page_to_virt() or virt_to_page() screwup.
> 
> I was *hoping* there was still sufficient space in 'struct page' for
> this second list_head in addition to page->lru.  I think there *should*
> be.  That would at least make this allocator a bit more "normal" in not
> caring about page contents while the page is free in the allocator.  If
> you were able to do that you could do things like kmemcheck or page
> alloc debugging while the page is in the allocator.
> 
> Anyway, I think I'd prefer that you *try* to use 'struct page' alone.
> But, if that doesn't work out, please comment the snot out of this thing
> because it _is_ weird.

Hi!  Current closest-thing-we-have-to-an-expert-on-struct-page here!

I haven't read over these patches yet.  If these pages are in use by
vmalloc, they can't use mapping+index because get_user_pages() will call
page_mapping() and the list_head will confuse it.  I think it could use
index+private for a list_head.

If the pages are in the buddy, I _think_ mapping+index are free.  private
is in use for buddy order.  But I haven't read through the buddy code
in a while.

Does it need to be a doubly linked list?  Can it be an hlist?
