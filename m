Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1170926952
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfEVRpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 13:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfEVRpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 13:45:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86DFB3084039;
        Wed, 22 May 2019 17:45:24 +0000 (UTC)
Received: from treble (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 697CA54389;
        Wed, 22 May 2019 17:45:20 +0000 (UTC)
Date:   Wed, 22 May 2019 12:45:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kairui Song <kasong@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190522174517.pbdopvookggen3d7@treble>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 22 May 2019 17:45:24 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 22, 2019 at 02:49:07PM +0000, Alexei Starovoitov wrote:
> The one that is broken is prog_tests/stacktrace_map.c
> There we attach bpf to standard tracepoint where
> kernel suppose to collect pt_regs before calling into bpf.
> And that's what bpf_get_stackid_tp() is doing.
> It passes pt_regs (that was collected before any bpf)
> into bpf_get_stackid() which calls get_perf_callchain().
> Same thing with kprobes, uprobes.

Is it trying to unwind through ___bpf_prog_run()?

If so, that would at least explain why ORC isn't working.  Objtool
currently ignores that function because it can't follow the jump table.

-- 
Josh
