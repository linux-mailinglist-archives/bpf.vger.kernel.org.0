Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA10D8A90
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbfJPILT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Oct 2019 04:11:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389335AbfJPILS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 04:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yhp7/wioyWdXQ41hYrVkjHUb5LQ88gTZsVFVxqZKTWk=; b=GY891JeYC2clnL7e+YPp0VCD4
        rHxKPcTwcGHFJ4Jdkx8VbhwuvztYlZ5GVzfxjhY66QeRmebKcEc/rwaxjbO1G1NDuWAo7UMD5Yyma
        fm/dQx5Eu6TdhNaymWtYNr0vu9QCqFiZtWaQNiLRewZGRuJWBscXxOE3q/TyYih0/EzM1iXEc7QgT
        D7Jl9mW+p5tfUYF8L4IaOJVmBwzIS7A7e9O6M4sMDqFGefPIppiuThSr3rhY7kZKaeWClElJ/kI/A
        j5yDOsZIr0jmreVFFVXnOyO5V9GGhHyDqGuHUlCYXCNedfsSE2ngWoapfXC97wvkTSv2Qaeg2vsA2
        k/H4sivjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKeOH-0003kn-Al; Wed, 16 Oct 2019 08:10:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFB60305BD3;
        Wed, 16 Oct 2019 10:09:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B806020B972E4; Wed, 16 Oct 2019 10:10:36 +0200 (CEST)
Date:   Wed, 16 Oct 2019 10:10:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, primiano@google.com, rsavitski@google.com,
        jeffv@google.com, kernel-team@android.com,
        James Morris <jmorris@namei.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v2] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191016081036.GN2328@hirez.programming.kicks-ass.net>
References: <20191014170308.70668-1-joel@joelfernandes.org>
 <c5bd06a4-54a4-b56e-457c-df36f05d2e3f@tycho.nsa.gov>
 <20191016003500.GC89937@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016003500.GC89937@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 15, 2019 at 08:35:00PM -0400, Joel Fernandes wrote:
> Peter, if you are Ok with it, could you squash the below diff into my
> original patch? But let me know if you want me to resend the whole patch
> again. Thanks.

Folded thanks!

I had assumed it was required such that selinux/apparmour/etc.. could
use these values from their policy.

If that is not required, then moving them private is indeed the right
thing.
