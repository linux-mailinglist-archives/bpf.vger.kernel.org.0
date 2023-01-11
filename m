Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC8665BDE
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjAKMzt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 07:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbjAKMz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 07:55:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC819285;
        Wed, 11 Jan 2023 04:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VKsur9CfmJqd7RUyGBR9q++t3bYeorhbrnyT99ptMKU=; b=gVROtrLBNj1yG8sCxjN9JxNi4e
        C9VB0rnlQ1k5fVCeA+nQ6FfyjaSOsRXlsRbOZ/Je/JlPZH+x+zZ5JcUy3epn/kPCP56GGmesEFS78
        X1lY/6W0wZ2fqf7ihnUyqwuaMfvqlhK3WWwRF8gSFVWLoESF8L0cVzRy3auzjG6l1n7LKKqn0L3RT
        yDIRAzkOOHrqJx9MBpDae7IY/Q5zXTlThhaahQ5Z+ocWKTuPuGJbTuC06PWDoFZZZOTBhupesObT4
        54p3OGyHtdFHkS4h1SRWye6GNFWI+0WaJmFI2GfpuDRfWegdhhHQok6tLAWhq6N6FZUa5YVGhmdvo
        lq9nsCYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFacy-003gFb-2p;
        Wed, 11 Jan 2023 12:54:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63BDF3001F7;
        Wed, 11 Jan 2023 13:54:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 466A42C9F6B72; Wed, 11 Jan 2023 13:54:54 +0100 (CET)
Date:   Wed, 11 Jan 2023 13:54:54 +0100
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
Message-ID: <Y76xng1U6UYpIGaW@hirez.programming.kicks-ass.net>
References: <20221229204101.1099430-1-namhyung@kernel.org>
 <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net>
 <Y7x3RUd67smv3EFQ@google.com>
 <CAM9d7ciVZCHk0YqpobfR+t0FPN_-tpnLgNbN981=EygkM_riDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciVZCHk0YqpobfR+t0FPN_-tpnLgNbN981=EygkM_riDg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 10, 2023 at 12:06:00PM -0800, Namhyung Kim wrote:

> Another example, but in this case it's real, is ADDR.  We cannot update
> the data->addr just because filtered_sample_type has PHYS_ADDR or
> DATA_PAGE_SIZE as it'd lose the original value.

Hmm, how about something like so?

/*
 * if (flags & s) flags |= d; // without branches
 */
static __always_inline unsigned long
__cond_set(unsigned long flags, unsigned long s, unsigned long d)
{
	return flags | (d * !!(flags & s));
}

Then:

	fst = sample_type;
	fst = __cond_set(fst, PERF_SAMPLE_CODE_PAGE_SIZE, PERF_SAMPLE_IP);
	fst = __cond_set(fst, PERF_SAMPLE_DATA_PAGE_SIZE |
			      PERF_SAMPLE_PHYS_ADDR,	  PERF_SAMPLE_ADDR);
	fst = __cond_set(fst, PERF_SAMPLE_STACK_USER,     PERF_SAMPLE_REGS_USER);
	fst &= ~data->sample_flags;

This way we express the implicit conditions by setting the required
sample data flags, then we mask those we already have set.

After the above something like:

	if (fst & PERF_SAMPLE_ADDR) {
		data->addr = 0;
		data->sample_flags |= PERF_SAMPLE_ADDR;
	}

	if (fst & PERF_SAMPLE_PHYS_ADDR) {
		data->phys_addr = perf_virt_to_phys(data->addr);
		data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
	}

	if (fst & PERF_SAMPLE_DATA_PAGE_SIZE) {
		data->data_page_size = perf_get_page_size(data->addr);
		data->sample_flags |= PERF_SAMPLE_DATA_PAGE_SIZE;
	}

And maybe something like:

#define __IF_SAMPLE_DATA(f_)		({		\
	bool __f = fst & PERF_SAMPLE_##f_;		\
	if (__f) data->sample_flags |= PERF_SAMPLE_##f_;\
	__f;				})

#define IF_SAMPLE_DATA(f_) if (__IF_SAMPLE_DATA(f_))

Then we can write:

	IF_SAMPLE_DATA(ADDR)
		data->addr = 0;

	IF_SAMPLE_DATA(PHYS_ADDR)
		data->phys_addr = perf_virt_to_phys(data->addr);

	IF_SAMPLE_DATA(DATA_PAGE_SIZE)
		data->data_page_size = perf_get_page_size(data->addr);

But I didn't check code-gen for this last suggestion.
