Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED6424DFA
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhJGHVA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 03:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhJGHVA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 03:21:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA3C061746;
        Thu,  7 Oct 2021 00:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2JHJIpAWgccBA6pQAUlpOyYTSFGIlpbAsVVUO6XyK3w=; b=METMHJ4Uwgejg7yLQ0FdhlSqDc
        4RiF0XPAjwCu6Xr0VclcBmAeaY6XVFwAdTvn7RPokVchywNUZolBdvwzV1/nc6oYuiriVu/Ka2DeA
        KiWilHlTFcsK0KkivmGPGjKA1jD86Rz9LRzmphAr37VejYH87iZ+wPXnfzzRnm8yx+1b4kntO+nHM
        ld9gORc2HXAcPf9VdhhPNxHyDhY97n8btaLu7A1zqJjyVRb2vygP3c1O5ddEb9aa39iWt5HxDH6eg
        Lsa+U5UAvf30UkdOy2pYK7O8AmzwvHs+xWvuIPgCDCpTGluf/tRlT4nO38ZGmhb3SdWvq2BsA47q8
        ERRrMV3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYNg9-008Qna-2g; Thu, 07 Oct 2021 07:18:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FFC698623A; Thu,  7 Oct 2021 09:18:56 +0200 (CEST)
Date:   Thu, 7 Oct 2021 09:18:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: introduce helper bpf_raw_read_cpu_clock
Message-ID: <20211007071856.GM174703@worktop.programming.kicks-ass.net>
References: <20211006175106.GA295227@fuller.cnet>
 <CAPhsuW5Uq78wqK_waeLPpyY6PNgzgtCZkZ4-FFWcF00Pez6cmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5Uq78wqK_waeLPpyY6PNgzgtCZkZ4-FFWcF00Pez6cmw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 06, 2021 at 02:37:09PM -0700, Song Liu wrote:
> On Wed, Oct 6, 2021 at 10:52 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> >
> >
> > Add bpf_raw_read_cpu_clock helper, to read architecture specific
> > CPU clock. In x86's case, this is the TSC.
> >
> > This is necessary to synchronize bpf traces from host and guest bpf-programs
> > (after subtracting guest tsc-offset from guest timestamps).
> 
> Trying to understand the use case. So in a host-guest scenario,
> bpf_ktime_get_ns()
> will return different values in host and guest, but rdtsc() will give
> the same value.
> Is this correct?

No, it will not. Also, please explain if any of this stands a chance of
working for anything other than x86. Or even on x86 in the face of
guest migration.

Also, please explain, again, what's wrong with dumping snapshots of
CLOCK_MONOTONIC{,_RAW} from host and guest and correlating time that
way?

And also explain why BPF needs to do this differently than all the other
tracers.
