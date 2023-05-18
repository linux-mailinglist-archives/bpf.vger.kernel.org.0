Return-Path: <bpf+bounces-835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D77076D0
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1591C20B81
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 00:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA50196;
	Thu, 18 May 2023 00:14:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2263160
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 00:14:31 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 494D0E40;
	Wed, 17 May 2023 17:14:30 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5995920F32BA;
	Wed, 17 May 2023 17:14:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5995920F32BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684368869;
	bh=VVEoDio0arKGJFJsHofzfO3jj1x9hJ9mzHCNy2yQvWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtF2J0ma4ETtlJcLPLfrQQfHtw/SSMOAS7sR7k/hbQMqv5qDIHWANdlW2fw+3BXVH
	 s5tve9kbRFKZV6QSlY/WpHVtLI/5Kcl6IwzwsmYBVyu4Ntl8ALEc2sw0H8gA0b0EfX
	 QNFNsjWBO8HWt4WQo7sT49CtShgqJaFFOwDbwLjE=
Date: Wed, 17 May 2023 17:14:22 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>, dthaler@microsoft.com,
	brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230518001422.GA254@W11-BEAU-MD.localdomain>
References: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain>
 <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain>
 <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
 <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
 <20230517230054.GA195@W11-BEAU-MD.localdomain>
 <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
 <20230517192528.043adc7a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517192528.043adc7a@gandalf.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 07:25:28PM -0400, Steven Rostedt wrote:
> On Wed, 17 May 2023 16:14:43 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Wed, May 17, 2023 at 4:01 PM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > >
> > > Do you mind giving me your Signed-off-by for these?  
> > 
> > Assuming you have some test-cases that you've run them through, then yes:
> 
> Beau,
> 
> Can you update the tools/testing/selftests/user_events/ to make sure that
> it triggers the lockdep splat without these updates (assuming that it does
> trigger without these patches). Then add these patches to make sure the
> splat goes away. This will confirm that the patches do what is expected of
> them.
> 

Yes, I have run these through selftests with CONFIG_DEBUG_ATOMIC_SLEEP=y.

I can confirm without the patches it splats with that setting. When
these have been applied, the splat is gone.

> I usually run the selftests for tracing and for your user events with
> lockdep and prove locking enabled. But it may have triggered on something
> else disabling it when I ran my tests, in which case I sometimes disable
> that and forget to re-enable it.
> 

Do you run with CONFIG_DEBUG_ATOMIC_SLEEP? It will not splat with just
CONFIG_PROVE_LOCKING and CONFIG_PROVE_RCU, which bit me here. I'm now
running all three now that I know better.

> -- Steve

Thanks,
-Beau

