Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34594439521
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJYLrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 07:47:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:37514 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhJYLrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 07:47:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="228391476"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="228391476"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 04:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="446195657"
Received: from boxer.igk.intel.com (HELO boxer) ([10.102.20.173])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2021 04:44:42 -0700
Date:   Mon, 25 Oct 2021 15:44:24 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YXa0uH0fA0P+dM8J@boxer>
References: <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
 <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
 <20211021233852.gbkyl7wpunyyq4y5@treble>
 <CAADnVQ+iMysKSKBGzx7Wa+ygpr9nTJbRo4eGYADLFDE4PmtjOQ@mail.gmail.com>
 <YXKhLzd/DtkjURpc@hirez.programming.kicks-ass.net>
 <CAADnVQKJojWGaTCpUhkmU+vUxXORPacX_ByjyHWY0V03hGH7KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKJojWGaTCpUhkmU+vUxXORPacX_ByjyHWY0V03hGH7KA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 08:22:35AM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 22, 2021 at 4:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 21, 2021 at 04:42:12PM -0700, Alexei Starovoitov wrote:
> >
> > > Ahh. Right. It's potentially a different offset for every prog.
> > > Let's put it into struct jit_context then.
> >
> > Something like this...
> 
> Yep. Looks nice and clean to me.
> 
> > -       poke->tailcall_bypass = image + (addr - poke_off - X86_PATCH_SIZE);
> > +       poke->tailcall_bypass = ip + (prog - start);
> >         poke->adj_off = X86_TAIL_CALL_OFFSET;
> > -       poke->tailcall_target = image + (addr - X86_PATCH_SIZE);
> > +       poke->tailcall_target = ip + ctx->tail_call_direct_label - X86_PATCH_SIZE;
> 
> This part looks correct too, but this is Daniel's magic.
> He'll probably take a look next week when he comes back from PTO.
> I don't recall which test exercises this tailcall poking logic.
> It's only used with dynamic updates to prog_array.
> insmod test_bpf.ko and test_verifier won't go down this path.

Please run ./test_progs -t tailcalls from tools/testing/selftests/bpf and
make sure that all of the tests are passing in there, especially the
tailcall_bpf2bpf* subset.

Thanks!
