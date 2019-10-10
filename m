Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC72D2F4A
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfJJRKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 13:10:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfJJRKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 13:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2ORhkw5GPRBxZuF/xlv/BjcMDmGKtcdp+AMxb3+giRk=; b=Do8hAovh7JWYg3ucRGcXnRKlp
        Hk/Mdo6HvHbjjzVB2oeN73Lg3ScBEwJ7yLS2xEExgXEBE42Ov7eTrryiUc+6flTBzVMEVyngCfmr0
        7DveBBO5dhInqtgUEe9a8uF1I+nODwJYoFohx1pWitYKqMGQnFzbQK9pZt+qPCF7MLYHxa6iEwG/W
        8B6jY4hY9N4UfA4dnrnri9GsVVNzoPzINpuJzJ263r3CONhT24WWKWVS0iUkTf0g+msab95XEwsqm
        robs5JYWD7vsNoTe5jx1EFbG3TPye9jJ4o0v+nT1wPbMgJAT9He3Ach8nHO3p/htt4/oIuFjVH/eV
        AslgJc8fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIbwl-0004bm-V5; Thu, 10 Oct 2019 17:09:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0E243013A4;
        Thu, 10 Oct 2019 19:08:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29D5A21492B14; Thu, 10 Oct 2019 19:09:49 +0200 (CEST)
Date:   Thu, 10 Oct 2019 19:09:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191010170949.GR2328@hirez.programming.kicks-ass.net>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <20191010081251.GP2311@hirez.programming.kicks-ass.net>
 <20191010151333.GE96813@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010151333.GE96813@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 10, 2019 at 11:13:33AM -0400, Joel Fernandes wrote:
> On Thu, Oct 10, 2019 at 10:12:51AM +0200, Peter Zijlstra wrote:
> > +static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
> >  {
> > -	return sysctl_perf_event_paranoid > 1;
> > +	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> 
> Here the sysctl check of > -1 also is now coupled with a CAP_SYS_ADMIN check.
> However..
> 
> > +	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
> 
> >  }
> >  
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c

> > @@ -5862,14 +5859,8 @@ static int perf_mmap(struct file *file,
> >  	lock_limit >>= PAGE_SHIFT;
> >  	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
> >  
> > -	if (locked > lock_limit) {
> > -		if (perf_paranoid_tracepoint_raw() && !capable(CAP_IPC_LOCK)) {
> > -			ret = -EPERM;
> > -			goto unlock;
> > -		}
> > -
> > -		ret = security_perf_event_open(&event->attr,
> > -					       PERF_SECURITY_TRACEPOINT);
> > +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> > +		ret = perf_allow_tracepoint(&event->attr);
> 
> In previous code, this check did not involve a check for CAP_SYS_ADMIN.
> 
> I am Ok with adding the CAP_SYS_ADMIN check as well which does make sense to
> me for tracepoint access. But it is still a change in the logic so I wanted
> to bring it up.
> 
> Let me know any other thoughts and then I'll post a new patch.

Yes, I did notice, I found it weird.

If you have CAP_IPC_LIMIT you should be able to bust mlock memory
limits, so I don't see why we should further relate that to paranoid.

The way I wrote it, we also allow to bust the limit if we have disabled
all paranoid checks. Which makes some sense I suppose.

The original commit is this:

  459ec28ab404 ("perf_counter: Allow mmap if paranoid checks are turned off")
