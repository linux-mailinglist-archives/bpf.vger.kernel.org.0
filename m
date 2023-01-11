Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551D16660E9
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAKQqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 11:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjAKQp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 11:45:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E26E1B;
        Wed, 11 Jan 2023 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/zqkC0892nBvrzYj8I4E+E+GwZS3RoYTgsGXNXbQl80=; b=Lal16jcupYrWfDauUZEA3dTJOI
        ZmMZ4GF9bkozac3T5YXCKX3pQ9m1UTNLttQI1FaYNCvIDgikYoJ8R9FwOb03EZJwSb0XrEMtK25/t
        pw2gT4Gxr22m7l2P05qdM5xrEW11MVEhs9hX8HFSF+yVSEU1w8JzL69YKNDvV3DgKEZpoCdPrX8GM
        v6QPUSWOatzEFLmBZ9J/l+y5Gwx7yjx2fr5NKLUw1Fr+QDrOCCJC4XMxLg0lQbFZgtsAzdQeYj3zW
        pDFRftSobCC8nLN5jbiyjglbVy9TsRDQj2A+ATcuuCFp3eU1nA4CBHrv0qw2o+zqd7IFRKUUGCv28
        T+wKPzIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFeEd-004Ip4-7M; Wed, 11 Jan 2023 16:45:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76F40300472;
        Wed, 11 Jan 2023 17:45:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DDF22CA25088; Wed, 11 Jan 2023 17:45:39 +0100 (CET)
Date:   Wed, 11 Jan 2023 17:45:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in
 perf_prepare_sample()
Message-ID: <Y77nswJ7gMWekXTt@hirez.programming.kicks-ass.net>
References: <20221229204101.1099430-1-namhyung@kernel.org>
 <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net>
 <Y7x3RUd67smv3EFQ@google.com>
 <CAM9d7ciVZCHk0YqpobfR+t0FPN_-tpnLgNbN981=EygkM_riDg@mail.gmail.com>
 <Y76xng1U6UYpIGaW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y76xng1U6UYpIGaW@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 01:54:54PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 10, 2023 at 12:06:00PM -0800, Namhyung Kim wrote:
> 
> > Another example, but in this case it's real, is ADDR.  We cannot update
> > the data->addr just because filtered_sample_type has PHYS_ADDR or
> > DATA_PAGE_SIZE as it'd lose the original value.
> 
> Hmm, how about something like so?
> 
> /*
>  * if (flags & s) flags |= d; // without branches
>  */
> static __always_inline unsigned long
> __cond_set(unsigned long flags, unsigned long s, unsigned long d)
> {
> 	return flags | (d * !!(flags & s));
> }
> 
> Then:
> 
> 	fst = sample_type;
> 	fst = __cond_set(fst, PERF_SAMPLE_CODE_PAGE_SIZE, PERF_SAMPLE_IP);
> 	fst = __cond_set(fst, PERF_SAMPLE_DATA_PAGE_SIZE |
> 			      PERF_SAMPLE_PHYS_ADDR,	  PERF_SAMPLE_ADDR);
> 	fst = __cond_set(fst, PERF_SAMPLE_STACK_USER,     PERF_SAMPLE_REGS_USER);
> 	fst &= ~data->sample_flags;
> 

Hmm, I think it's better to write this like:

static __always_inline unsigned long
__cond_set(unsigned long flags, unsigned long s, unsigned long d)
{
	return d * !!(flags & s);
}

	fst = sample_type;
	fst |= __cond_set(sample_type, PERF_SAMPLE_CODE_PAGE_SIZE, PERF_SAMPLE_IP);
	fst |= __cond_set(sample_type, PERF_SAMPLE_DATA_PAGE_SIZE |
			               PERF_SAMPLE_PHYS_ADDR,	   PERF_SAMPLE_ADDR);
	fst |= __cond_set(sample_type, PERF_SAMPLE_STACK_USER,     PERF_SAMPLE_REGS_USER);
	fst &= ~data->sample_flags;

Which should be identical but has less data dependencies and thus gives
an OoO CPU more leaway to paralleize things.
