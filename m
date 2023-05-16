Return-Path: <bpf+bounces-601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90A704476
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 07:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7961C20D0C
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 05:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B318C26;
	Tue, 16 May 2023 05:10:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11629B0
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7F8C433EF;
	Tue, 16 May 2023 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684213832;
	bh=u8Y2f4n10KnprdRg9KnWZid4H6uSUjozETMEXBKEsbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y2iQpsFIET1oRKmwR8Jo+fs/oUtNa1g3ar6V/YM9cpNrB3twVL8Vn4xNBd0JN0aVs
	 53vqNLhRsiFc8EI6xwZuTZzJqmwJQ8XG20/K7ZfPnncSaORAND10oAcO8I9oRu1qeg
	 kwQXLVgZRRwRfGNJXBY+xMLY2mZ0LWZnCFIF7BvOBy/duUaJx4KPpLdf1Gnd9foN0T
	 pl5X+7mfqNzx+GgKP0n6h/O4rnBdyFMV04iJLaHSrUM5LDTnhI7IoTNue4nPlLjfEO
	 2NkAt6bV6sb+ujrfQmBI51PVh3UGMJP2XbIav1KiXHZAT4WvF9UlS2MxzNBn3rPi+f
	 5wqtxb/KTjSkA==
Date: Tue, 16 May 2023 14:10:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Yonghong Song <yhs@meta.com>, Ze
 Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, Song Liu
 <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Ze Gao
 <zegao@tencent.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to
 avoid recursive trap
Message-Id: <20230516141028.d3a9cb541bf1b7ef0deb79c3@kernel.org>
In-Reply-To: <20230516133153.9627751457e0050159f077ab@kernel.org>
References: <20230510122045.2259-1-zegao@tencent.com>
	<6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
	<ZFvUH+p0ebcgnwEg@krava>
	<CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
	<ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
	<20230513001757.75ae0d1b@rorschach.local.home>
	<20230516133153.9627751457e0050159f077ab@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 May 2023 13:31:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat, 13 May 2023 00:17:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 12 May 2023 07:29:02 -0700
> > Yonghong Song <yhs@meta.com> wrote:
> > 
> > > A fprobe_blacklist might make sense indeed as fprobe and kprobe are 
> > > quite different... Thanks for working on this.
> > 
> > Hmm, I think I see the problem:
> > 
> > fprobe_kprobe_handler() {
> >    kprobe_busy_begin() {
> >       preempt_disable() {
> >          preempt_count_add() {  <-- trace
> >             fprobe_kprobe_handler() {
> > 		[ wash, rinse, repeat, CRASH!!! ]
> > 
> > Either the kprobe_busy_begin() needs to use preempt_disable_notrace()
> > versions, or fprobe_kprobe_handle() needs a
> > ftrace_test_recursion_trylock() call.
> 
> Oops, I got it. Is preempt_count_add() tracable? If so, kprobe_busy_begin()
> should be updated.

OK, preempt_count_add() is NOKPROBE_SYMBOL() so kprobe_busy_begin() should
be safe. The problem is in fprobe_kprobe_handler() then.

Thanks!

> 
> Thanks,
> 
> > 
> > -- Steve
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

