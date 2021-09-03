Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D541F3FFC40
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhICItF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhICItD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 04:49:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2764C061575;
        Fri,  3 Sep 2021 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRuSYLlOgO1jvya073Bh7Tpm8VI1vmVBgnv4q9HH8uo=; b=jhTR6SBpkVS6jms5GAwXgbKG5s
        uuVmf8stn8TaZo6/Q6MKUq7TgbgUrZ/3h6EXaXbPsQnm/O9jog8R1vgjM1G7ObQmeeBXE/TXqZVeD
        EcufrQD5ZEumO7Gt9Lg3LvalHSHI/y6SqOg8eBYVfQ5jwFuyJNk96DlqJkFrODeE4sQiuKAk/lWUO
        QzZdwY2eEj2937mp2U5ro7N5vp/PePTEN6IWPBNff/fNALN1zvxw5iLBw5fISkic8LPddrohHaUHw
        iryjCnRDK1bCHs7HaUKnsugiuF+JxVShxX/ytyZJe5f+Jp8QXLCuxDW9utLIFNsrF9kKbL6tn7Fvu
        Mkurbs/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM4rc-000JaS-0a; Fri, 03 Sep 2021 08:47:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CF6030024D;
        Fri,  3 Sep 2021 10:47:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 702B828B658E9; Fri,  3 Sep 2021 10:47:55 +0200 (CEST)
Date:   Fri, 3 Sep 2021 10:47:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Message-ID: <YTHhOy1gqr44C1bI@hirez.programming.kicks-ass.net>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902165706.2812867-3-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 02, 2021 at 09:57:05AM -0700, Song Liu wrote:
> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
> +{
> +	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> +	u32 entry_cnt = size / br_entry_size;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (!buf || (size % br_entry_size != 0))
> +		return -EINVAL;
> +
> +	entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);

That's at least 2, possibly 3 branches just from the sanity checks, plus
at least one from starting the BPF prog and one from calling this
function, gets you at ~5 branch entries gone before you even do the
snapshot thing.

Less if you're in branch-stack mode.

Can't the validator help with getting rid of the some of that?

I suppose you have to have this helper function because the JIT cannot
emit static_call()... although in this case one could cheat and simply
emit a call to static_call_query() and not bother with dynamic updates
(because there aren't any).
