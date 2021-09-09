Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822E34046BD
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 10:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhIIIG5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIIG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 04:06:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52093C061575
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3qrQB6d8ePB9z+YR7DZ4I3k8HfDrD/7XELuX2rFMGOI=; b=HmnBaS1EnmTSlK05RhgfftlS7K
        5OYfMBtEm2Whmgf+lIKtnz9u591s1YKoqY6DC+50rVbFumsF2rLIEcAbtugjcHELn52WF4Elhwxqd
        iGWN8VIKQqC6k/eurIVUZkE+lgumt48EZ36swXJFOmbNpBHpw4SM5yT1SF0t+xQ4nD0HIJZZzKy4w
        vUdqL9+QHo6T3/1RcnWpfAo45ds+SG7j7UeIQZHARTciMxYrKTKMIlGrnbNJnvSF+uNGR/pLxqdBU
        iQfg3Yreu/t6kQPWO4hp097Lz6gbvbgOwqdk2ZsnQLpcGmF1H9LmBciPSnfhUyON+fF9LTau50wHH
        ihT1Y4hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOF3q-001pJO-6N; Thu, 09 Sep 2021 08:05:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FC763001C7;
        Thu,  9 Sep 2021 10:05:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49CA429DD60A4; Thu,  9 Sep 2021 10:05:29 +0200 (CEST)
Date:   Thu, 9 Sep 2021 10:05:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "walken@fb.com" <walken@fb.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-ID: <YTnASdwzG2DS5lrc@hirez.programming.kicks-ass.net>
References: <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
 <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
 <20210908183032.zoh6dj5xh455z47f@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908183032.zoh6dj5xh455z47f@revolver>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 06:30:52PM +0000, Liam Howlett wrote:
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);

NAK.. do not ever use the _is_locked() trainwrecks.
