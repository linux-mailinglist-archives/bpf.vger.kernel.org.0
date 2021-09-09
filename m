Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99C9404312
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 03:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348315AbhIIBoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbhIIBne (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 21:43:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC41AC06115C
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 18:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZyX4M69HKrevcTDt5hkWJXKw8C4aMMkVnPFPlPbnHVA=; b=XSCXbbhFc90w6nzz53Uml5cnwp
        Ac57r5+rJEYXxCWxALnofzk3jBSYfJNYWAevVU2V70oToF9xj5t62Gsb7g5JhTUDaEJ/3y43NdcEt
        jWXfJ906hU58Rxfaq7eSG/tPvv67X7GDy8dR1wD/F9GwM5yDgk/Oz+BKeINeIb2b5JWbULrtcVxVu
        Sbj+IYGNwf01MhxKV8h5G/wt9kGya3E93k88+xV45ycHHdpJMU8p6L/YlO8Zppfi2QAHD7LGlC7LF
        SpiAIzRxdTM7xvjrVGmX0u5RFf3XV+2ZjQpgxVNBjFIRMOBnLOdA1yoqq7pdOdSUDwHWa4xTSvBeO
        uWsSrUgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mO91J-009LJY-W0; Thu, 09 Sep 2021 01:38:35 +0000
Date:   Thu, 9 Sep 2021 02:38:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Luigi Rizzo <lrizzo@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH mm/bpf v3] mm: bpf: add find_vma_non_owner() without
 lockdep_assert on mm->mmap_lock
Message-ID: <YTlllQenVPeNNxIF@casper.infradead.org>
References: <20210908224438.391816-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908224438.391816-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 03:44:38PM -0700, Yonghong Song wrote:
> +extern struct vm_area_struct * find_vma_non_owner(struct mm_struct * mm,
> +						  unsigned long addr);

 - extern is deprecated
 - no space between the '*' and 'mm'.
 - no space between the '*' and the function name.

> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +{
> +	lockdep_assert_held(&mm->mmap_lock);
> +	return find_vma_non_owner(mm, addr);
> +}
> +
>  EXPORT_SYMBOL(find_vma);

No blank line between the closing '}' and the EXPORT_SYMBOL.
