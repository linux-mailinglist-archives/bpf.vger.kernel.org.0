Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99C98C93
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 09:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfHVHrw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Aug 2019 03:47:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfHVHrw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Aug 2019 03:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EmuC6Fpk11rSVocpKbT8KYAej4t4mP+c/Oiv8Dne6MM=; b=0QYEvGjuKtc+q7j2b3hiPyDeJ
        mg+zKCYg+iMWtehpQ0UGDVQL+lL8lvCqx+Ir/+dDLouDYR3kku+370uVmT8IlsWWLWt5c+aUW1S2+
        sOf23i/MrMkrfQ3ovgUWXSatBtVcvNoZYkZ+e9qSoJlBEqe6YW68A9ifz1pjxe2WlqFJuT0vxJl89
        9e6aFuKufIXKwAkuD2WVUHN8ZjgzpMaRbhcLwTCUVlOl7Vp8CJDYIR3QjhwrUYjDwK2y+ME2HWrQd
        gbAWnBGY7KAl4H/UwgZJ5Jc+UznTzMhWTu+YeFw0vsuYvWqRu4Lnv6yiSZxHdOzfxg10axRX22vH1
        EX2KcvCgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0hoq-0000Bt-PY; Thu, 22 Aug 2019 07:47:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E693A307598;
        Thu, 22 Aug 2019 09:47:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9034020C3BF31; Thu, 22 Aug 2019 09:47:37 +0200 (CEST)
Date:   Thu, 22 Aug 2019 09:47:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
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
Message-ID: <20190822074737.GG2349@hirez.programming.kicks-ass.net>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
 <20190821183155.GE2349@hirez.programming.kicks-ass.net>
 <5ecdcd72-255d-26d1-baf3-dc64498753c2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecdcd72-255d-26d1-baf3-dc64498753c2@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 21, 2019 at 06:43:49PM +0000, Yonghong Song wrote:
> On 8/21/19 11:31 AM, Peter Zijlstra wrote:

> > So extending PERF_RECORD_LOST doesn't work. But PERF_FORMAT_LOST might
> > still work fine; but you get to implement it for all software events.
> 
> Could you give more specifics about PERF_FORMAT_LOST? Googling 
> "PERF_FORMAT_LOST" only yields two emails which we are discussing here :-(

Look at what the other PERF_FORMAT_ flags do? Basically it is adding a
field to the read(2) output.

> >> Maybe we can still use ioctl based approach which is light weighted
> >> compared to ring buffer approach? If a fd has bpf attached, nhit/nmisses
> >> means the kprobe is processed by bpf program or not.
> > 
> > There is nothing kprobe specific here. Kprobes just appear to be the
> > only one actually accounting the recursion cases, but everyone has
> > them.
> 
> Sorry to be specific, kprobe is just an example, I actually refers to 
> any perf event where bpf can attach to, which theoretically are any
> perf events which can be opened with "perf_event_open" syscall although 
> some of them (e.g., software events?) may not have bpf running hooks yet.

Yes, BPF is sucky that way.

