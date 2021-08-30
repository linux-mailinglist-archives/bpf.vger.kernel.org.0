Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099553FB418
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhH3Kto (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbhH3Ktn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 06:49:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611AC061575;
        Mon, 30 Aug 2021 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dKqKLIxUsagVJumO62jXGIe/loCKVk6eG2zNzXoCLu0=; b=DC1+bjb6VW4EnFq6o2tl/PH/Oy
        fF+RTWPCypJoRXwG2Ig8NW8E59NULCElV9jlXYE7WnGrgdE8TVIcu+YNjTBkivSpXJnDG7WzFA9gW
        V3NDQ7h+ZPbZhp13UNT6Qyrhzzm7QwfkMdqwQ4pAZogK+P8SXl6daRmA36sjueqjiYp3osCoD5WfK
        fMI/k2HCyuXVDY+NuFQ5E3Im9kW9aVGsIxWY7tTydUW3s4xFYE8+VLLTETw+tNm1LDFTLQdV4u3OV
        tYg6nPFjsAzhyH0FLxJv/+z4ol/Ty4zKdUreqqVL8VcEZ1AsC6k9pBvWZMZ9rObSewbAFHXqyxLv4
        E/wQc1ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKepJ-00021g-Cf; Mon, 30 Aug 2021 10:47:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFAD498186D; Mon, 30 Aug 2021 12:47:40 +0200 (CEST)
Date:   Mon, 30 Aug 2021 12:47:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        acme@kernel.org, mingo@redhat.com, kjain@linux.ibm.com,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Message-ID: <20210830104740.GK4353@worktop.programming.kicks-ass.net>
References: <20210826221306.2280066-3-songliubraving@fb.com>
 <202108272326.sMsn5b1g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108272326.sMsn5b1g-lkp@intel.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 27, 2021 at 11:10:39PM +0800, kernel test robot wrote:

> All errors (new ones prefixed by >>):
> 
>    riscv32-linux-ld: kernel/bpf/trampoline.o: in function `.L57':
> >> trampoline.c:(.text+0x34c): undefined reference to `__SCK__perf_snapshot_branch_stack'
>    riscv32-linux-ld: kernel/bpf/trampoline.o: in function `.L61':
>    trampoline.c:(.text+0x360): undefined reference to `bpf_perf_branch_snapshot'
> 

This a build with PERF_EVENTS=n, I suppose you'd better make calling
perf_snapshot_branch_stack() dependent on having that :-)
