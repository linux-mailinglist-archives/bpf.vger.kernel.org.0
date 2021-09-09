Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C87405916
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbhIIOdg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245508AbhIIOd2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 10:33:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C21C00F767
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LymjhqFPErmB71T4SArEOYRvy1OFs+5watamyFLdueY=; b=MSZvGW8r0K42nd6yod4edEfhnU
        qhI8OKS0XfBwLMJaSb8OZVJwlqheoZAICnYskvYSDLyA6lkoutv353tGnHAu4u0U/qyV6V4JCdYT0
        Vo28SX7QGuzqw3q5t4b+0pKukv9+tIaVf0pEq7QG8XWjzEIwW1Skpttgb6Bz12CLVcz10POkHxqOq
        d1gGlMO5wbUkYS91AH5KQkKbi522TNfHfZcBnU/oeajAXqrU9mtnzxORBW3tqILVDsfD8bqssqEGm
        Wi5ZWKvq2tHwlLGyd/sPNykHfEo5kLRuP4ea3ii9eUrrkmT0Ejv202oHmQ+5wFLeWBlt4ooY6+aIw
        AuwPycmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOKB1-009xTj-Jh; Thu, 09 Sep 2021 13:33:27 +0000
Date:   Thu, 9 Sep 2021 14:33:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Luigi Rizzo <lrizzo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH bpf-next v4] bpf: fix lockdep warning triggered by
 stack_map_get_build_id_offset()
Message-ID: <YToNG9HaJYfGHusw@casper.infradead.org>
References: <20210909060245.2966358-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909060245.2966358-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 11:02:45PM -0700, Yonghong Song wrote:
> @@ -204,9 +204,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	}
>  
>  	if (!work) {
> -		mmap_read_unlock_non_owner(current->mm);
> +		mmap_read_unlock(current->mm);
>  	} else {
>  		work->mm = current->mm;
> +		rwsem_release(&current->mm->mmap_lock.dep_map, _RET_IP_);
>  		irq_work_queue(&work->irq_work);

This needs a comment before the rwsem_release().  Something like:

		/*
		 * The lock will be released once we're out of interrupt
		 * context.  Tell lockdep that we've released it now so
		 * it doesn't complain that we forgot to release it.
		 */
