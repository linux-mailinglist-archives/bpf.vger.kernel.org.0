Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69598EB3
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfHVJGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Aug 2019 05:06:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfHVJGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Aug 2019 05:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jQUmhm+crCMl7aYhsmY917C2u3wYSGbnGiCkrOsABG0=; b=H96MoQ+Xd3KhAeEuhp3KuJohI
        7ynuQoFB+FMMXI0yuJcBPGyPNWoozF3fDKL9kl4B1XlMv3+6HktRE1qRLl7vo2y5kWQsZ1DyZye2c
        D9kG9tcMcVvyCEkQ+xqenprcGbr2Gvn0PAaMxckZsZrBkOjWWIh522IzryqmQX0oBFf0K/llZ93O6
        ZDU/ioNYP/VUNvq59utMpn18uDg7xZOFlRcstWcRz1zfQ9Ez0NQEKeBhW+jmRezsiZrZTxj3r+RT6
        zHReVu6e3nCBZlm6teISKVXXZnYetDwGV4kJGAqQtH/SBfvLNvHDE5vEekVryI6QFRfDmLqGtuE0V
        KC4nhDu6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0j2c-0000zc-VK; Thu, 22 Aug 2019 09:05:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82957307145;
        Thu, 22 Aug 2019 11:05:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8000620A21FDF; Thu, 22 Aug 2019 11:05:55 +0200 (CEST)
Date:   Thu, 22 Aug 2019 11:05:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Yonghong Song <yhs@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Message-ID: <20190822090555.GJ2349@hirez.programming.kicks-ass.net>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
 <20190821183155.GE2349@hirez.programming.kicks-ass.net>
 <5ecdcd72-255d-26d1-baf3-dc64498753c2@fb.com>
 <20190822074737.GG2349@hirez.programming.kicks-ass.net>
 <E9CB8C05-8972-4454-9D19-FA2D0D94F32D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E9CB8C05-8972-4454-9D19-FA2D0D94F32D@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 22, 2019 at 07:54:16AM +0000, Song Liu wrote:
> Hi Peter, 
> 
> > On Aug 22, 2019, at 12:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Aug 21, 2019 at 06:43:49PM +0000, Yonghong Song wrote:
> >> On 8/21/19 11:31 AM, Peter Zijlstra wrote:
> > 
> >>> So extending PERF_RECORD_LOST doesn't work. But PERF_FORMAT_LOST might
> >>> still work fine; but you get to implement it for all software events.
> >> 
> >> Could you give more specifics about PERF_FORMAT_LOST? Googling 
> >> "PERF_FORMAT_LOST" only yields two emails which we are discussing here :-(
> > 
> > Look at what the other PERF_FORMAT_ flags do? Basically it is adding a
> > field to the read(2) output.
> 
> Do we need to implement PERF_FORMAT_LOST for all software events? If user
> space asks for PERF_FORMAT_LOST for events that do not support it, can we
> just fail sys_perf_event_open()?

It really shouldn't be hard; and I'm failing to see why kprobes are
special.
