Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB70C622996
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 12:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKILGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 06:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKILGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 06:06:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D31A3AA
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/IkzV8yvUA7Vr60S7GhslnSnuxhvF+TnodYNUtT0N3w=; b=XQUqPUgFP1vxme1fsqnx7sKOhx
        Nr7tsJDn+TYxTMKfu6e5+brc+Xj8cIPgJhtKXcsB6BhkmuHPKrFJWuBp9Krf5K5QKTMSF1HLqApnu
        FvHi437aH0q0khheqttPUzdjbbM5Js6ibx9i5S/3M08cW55gHl9V71AsiXjqdwKERObB4TNlpV7UO
        hK8spPSjHjUD2OjFuKWZVZKj+sodv4dVEq6tXzkZ39XQ3Twc1p4yF5KELCmiGVvnzeDAoo/xo4wTj
        EZoJODw46Pj4z+pg/OgTKFoGga/MzVcd2RE5HWx7fKqxX/v/HupMl5czCunaAjuMCaRAeOHu8/ZU8
        4uuhmhfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ositx-00B7Pe-OB; Wed, 09 Nov 2022 11:05:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45D4930036B;
        Wed,  9 Nov 2022 12:05:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F01AE20264769; Wed,  9 Nov 2022 12:05:40 +0100 (CET)
Date:   Wed, 9 Nov 2022 12:05:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Aaron Lu <aaron.lu@intel.com>, Mike Rapoport <rppt@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2uJhFEY+1XDJHiL@hirez.programming.kicks-ass.net>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <Y2pNyKmMnOEeongp@ziqianlu-desk2>
 <20221109065512.GA11254@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109065512.GA11254@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 07:55:12AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 08, 2022 at 08:38:32PM +0800, Aaron Lu wrote:
> > set_memory_nx/x() on a vmalloced range will not affect direct map but
> > set_memory_ro/rw() will.
> 
> Which seems a little odd.  Is there any good reason to not also propagate
> the NX bit?

Less executable ranges more better. That is, the direct map is *always*
NX.


