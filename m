Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB76D39CC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfJKHGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 03:06:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 03:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B7tSt4++AeNClEYMJ6vFiBHpS1WJihxuciejr2hX7bs=; b=GvnBbSeRL2D7Djol5QJK4MqT+
        f5pua78F2o9VGO8YAmoQv16DV8cOvHSqAM9e+4JIHcuJk2nKDeKvCJgnjYK3SQmzdBKk/2cWLMjoP
        pqAr/BidNI3as9nX/sJ7HaZqkEUiPCJGbFRFWV43iqClh+ek5Zjd5NrBpLm9I3OBWbx3fFeSgpjPZ
        3HFr+5JoDrvRlwuZm1pms3rRyfSGcNJfzUjfRAw364CFb46QXZD81LBxKBMsyJSDD+zBjU7daKMVD
        1mOylo3pTqay0R17ca4hZEsnO/6nJZdOUAJMyDqQ3vsoeecqLMGUu0QG3I3eSmhNIyAVAAMK79Ql9
        tk4BJxQ0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIozh-0004C0-Du; Fri, 11 Oct 2019 07:05:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6927301224;
        Fri, 11 Oct 2019 09:04:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FEF021492B15; Fri, 11 Oct 2019 09:05:43 +0200 (CEST)
Date:   Fri, 11 Oct 2019 09:05:43 +0200
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
Message-ID: <20191011070543.GV2328@hirez.programming.kicks-ass.net>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <20191010081251.GP2311@hirez.programming.kicks-ass.net>
 <20191010151333.GE96813@google.com>
 <20191010170949.GR2328@hirez.programming.kicks-ass.net>
 <20191010183114.GF96813@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010183114.GF96813@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 10, 2019 at 02:31:14PM -0400, Joel Fernandes wrote:
> On Thu, Oct 10, 2019 at 07:09:49PM +0200, Peter Zijlstra wrote:

> > Yes, I did notice, I found it weird.
> > 
> > If you have CAP_IPC_LIMIT you should be able to bust mlock memory
> > limits, so I don't see why we should further relate that to paranoid.
> > 
> > The way I wrote it, we also allow to bust the limit if we have disabled
> > all paranoid checks. Which makes some sense I suppose.
> > 
> > The original commit is this:
> > 
> >   459ec28ab404 ("perf_counter: Allow mmap if paranoid checks are turned off")
> 
> I am thinking we can just a new function perf_is_paranoid() that has nothing
> to do with the CAP_SYS_ADMIN check and doesn't have tracepoint wording:
> 
> static inline int perf_is_paranoid(void)
> {
> 	return sysctl_perf_event_paranoid > -1;
> }
> 
> And then call that from the mmap() code:
> if (locked > lock_limit && perf_is_paranoid() && !capable(CAP_IPC_LOCK)) {
> 	return -EPERM;
> }
> 
> I don't think we need to add selinux security checks here since we are
> already adding security checks earlier in mmap(). This will make the code and
> its intention more clear and in line with the commit 459ec28ab404 you
> mentioned. Thoughts?

Mostly that I'm confused by the current code ;-)

Like I said, CAP_IPC_LIMIT on its own should already allow busting the
limit, I don't really see why we should make it conditional on paranoid.

But if you want to preserve behaviour (arguably a sane thing for your
patch) then yes, feel free to do as you propose.
