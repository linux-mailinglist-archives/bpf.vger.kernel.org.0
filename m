Return-Path: <bpf+bounces-57916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173FAB1D22
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DE93B5584
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174C24290C;
	Fri,  9 May 2025 19:05:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F92367CB;
	Fri,  9 May 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817555; cv=none; b=YAiV6+pMKMCGli3RRJGgEhvDDPuO1Cgm9Ac3cueklOE9FqNRg8xrYwpo5Eps8GnGnmdy+dv8ufqimfsjy9siqb6Zr1PSqb19KLI5rpfYbTdc8iHBdsOutdJ8Hm+PamuR/0r2nG7t2tp+uAXiHgV3i4LzGKXjv0LftyKIReh+MKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817555; c=relaxed/simple;
	bh=6qekO40XHU+e21rQEBlBsBg67fGBnBKtjTzK+qcS46c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAm+hEN6mncbQy4iz4bIQgsJX3NCsPkqZ8g+PR+C12oQNjlcIDYsGPe28MFpjCFSfRL5NP4SnVDwk7kVY0BOZWaqWTu4jFbwrPWH4ucwX2rkncH7I/dqBQ3dmqYumSAQU5+xhTHPEBL0dBLMT5NWxg1zkiOLoenG77f9RMnQKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0166C4CEE4;
	Fri,  9 May 2025 19:05:53 +0000 (UTC)
Date: Fri, 9 May 2025 15:06:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, netdev
 <netdev@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, David Ahern <dsahern@kernel.org>, Juri Lelli
 <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Gabriele Monaco
 <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
Message-ID: <20250509150609.5cb7c7a8@gandalf.local.home>
In-Reply-To: <CAEf4BzZxDPpsTnger+UXL9wbrpK5gf_9YD2fD0VNA1nC7bcwUg@mail.gmail.com>
References: <20250507162049.30a3ccae@gandalf.local.home>
	<CAEf4BzZxDPpsTnger+UXL9wbrpK5gf_9YD2fD0VNA1nC7bcwUg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 11:27:22 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> > index aeef86b3da74..2bac14ef507f 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> > @@ -42,7 +42,7 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
> >
> >  struct sk_buff;
> >
> > -DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
> > +DECLARE_TRACE(bpf_testmod_test_raw_null,  
> 
> here "raw_tp" is actually part of the name (we are testing raw
> tracepoints with NULL argument), so I'd suggest to not change it here,
> we'll just have trace_bpf_testmod_test_raw_tp_null_tp() below, however
> odd it might be looking :)

Thanks for letting me know.

> 
> >         TP_PROTO(struct sk_buff *skb),
> >         TP_ARGS(skb)
> >  );
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 3220f1d28697..fd40c1180b09 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > @@ -413,7 +413,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> >
> >         (void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
> >
> > -       (void)trace_bpf_testmod_test_raw_tp_null(NULL);
> > +       (void)trace_bpf_testmod_test_raw_null_tp(NULL);
> >
> >         bpf_testmod_test_struct_ops3();
> >
> > @@ -431,14 +431,14 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> >         if (bpf_testmod_loop_test(101) > 100)
> >                 trace_bpf_testmod_test_read(current, &ctx);
> >
> > -       trace_bpf_testmod_test_nullable_bare(NULL);
> > +       trace_bpf_testmod_test_nullable_bare_tp(NULL);
> >
> >         /* Magic number to enable writable tp */
> >         if (len == 64) {
> >                 struct bpf_testmod_test_writable_ctx writable = {
> >                         .val = 1024,
> >                 };
> > -               trace_bpf_testmod_test_writable_bare(&writable);
> > +               trace_bpf_testmod_test_writable_bare_tp(&writable);
> >                 if (writable.early_ret)
> >                         return snprintf(buf, len, "%d\n", writable.val);
> >         }
> > @@ -470,7 +470,7 @@ bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> >                 .len = len,
> >         };
> >
> > -       trace_bpf_testmod_test_write_bare(current, &ctx);
> > +       trace_bpf_testmod_test_write_bare_tp(current, &ctx);
> >  
> 
> please update the following three lines in selftests to match new names:

Will do.

Will put together a v3.

Thanks for the review!

-- Steve

> 
> progs/test_module_attach.c
> 22:SEC("raw_tp/bpf_testmod_test_write_bare")
> 
> progs/test_tp_btf_nullable.c
> 9:SEC("tp_btf/bpf_testmod_test_nullable_bare")
> 16:SEC("tp_btf/bpf_testmod_test_nullable_bare")
> 
> 
> just add that "_tp" suffix everywhere and CI should be happy
> 
> >         return -EIO; /* always fail */
> >  }
> > --
> > 2.47.2
> >  


