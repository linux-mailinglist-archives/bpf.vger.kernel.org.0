Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E824071FE
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 21:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhIJTaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 15:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbhIJTaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 15:30:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233A3C061756;
        Fri, 10 Sep 2021 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6jlEs7B165almJRLRE31tW+xA96GS78RIfJR4xnCYbg=; b=PL265S7y2ZrKBxAQknmUxxk6IB
        Aguj777Hn3MNTpKzo4XgmpG3fkwj5QEPCohKYCOKBOp92wiIPxFnr1dSYYv+wIgCXd/qRYPuiPcX/
        HcFkxsCp4UTc/iYvtsb7Jg814M7S5lXI5sS6rHb6Hoaqu5XGCFYrBREwCEI5AzKSC4DFgyXXA2j8E
        J8yUeX4WkSUKCkCfpaxR1bu2gUpVf/tQwLnWbdWacIYf05oUSwCUHkw9xn6CxrRfpEAkWElIHdnK4
        ILdqf7NBdUP+g7nRdZyNG0lHwLN38GrVDQLu66NfJJupMdQ6NCFKSLJQU16oogf5UyE1ly7MFYUCp
        66tc4f7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOmCb-002CZS-PL; Fri, 10 Sep 2021 19:28:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3557898627A; Fri, 10 Sep 2021 21:28:45 +0200 (CEST)
Date:   Fri, 10 Sep 2021 21:28:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v7 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <20210910192845.GT4323@worktop.programming.kicks-ass.net>
References: <20210910183352.3151445-1-songliubraving@fb.com>
 <20210910183352.3151445-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910183352.3151445-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 11:33:50AM -0700, Song Liu wrote:
> The typical way to access branch record (e.g. Intel LBR) is via hardware
> perf_event. For CPUs with FREEZE_LBRS_ON_PMI support, PMI could capture
> reliable LBR. On the other hand, LBR could also be useful in non-PMI
> scenario. For example, in kretprobe or bpf fexit program, LBR could
> provide a lot of information on what happened with the function. Add API
> to use branch record for software use.
> 
> Note that, when the software event triggers, it is necessary to stop the
> branch record hardware asap. Therefore, static_call is used to remove some
> branch instructions in this process.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
