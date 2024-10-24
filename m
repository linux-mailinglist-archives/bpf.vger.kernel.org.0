Return-Path: <bpf+bounces-42985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55479AD90E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42EDC283675
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 00:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A1BA4B;
	Thu, 24 Oct 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2GxXa68"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7011018035
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731401; cv=none; b=C0jjQFcEBL6QcKewTKfESnPvLfqkMSzI0Rde/MLKjk57GCemN3ABXxMMrpr9HGvxsKz1VvGsyBufuTvII+u+0VLwVTiKNeF4LDydlilxcVwYT/sGiq90RMcREaXsxJTjZVyIEmLTcAvX0jKmBCaA7h6Uv4/PfUjIsknrcLHaiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731401; c=relaxed/simple;
	bh=SQfxKjWkjYYEdeECVK8wdsyQOhnFnmkfg4+vuiNOick=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIN5BnxtZOiduRex/nr7wqzu+NfLKNdBz9BWk2Qi7QjuzvYgNx1UZlao+fmwfj5pX5ZdNtW7ovSXZSGaxwwXrsV7bbaCwKRU97Zub2WVo8VUE12+/s8qvWcKq3LPPsgJ6GcDQwxdVcuv1ve8Dl7t9pknwqGjSSsCeWWJQ8jTE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2GxXa68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D877AC4CEC6;
	Thu, 24 Oct 2024 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729731401;
	bh=SQfxKjWkjYYEdeECVK8wdsyQOhnFnmkfg4+vuiNOick=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2GxXa68w8ovQvsQGavOSEnqoeYM0JRRYr2UP6sOIUvqBqS7iqg9e7nwyq5UjWcwJ
	 mLjIcWy3Y3al7WM353AlBbI5KNKCNkw5PNCAvCgrN/g2dXg6CpViAwSQzPM4QvSSho
	 SH3Ry1CqP6aMShApT/bzPodYnisv5ze16i5gImEJqLYPZyiHcKZ0N/rBiX7tissPbb
	 TCCuzrdT0SenUENDcHGHkCsGzyYpNW35xECD7m+D4hC8cIXFuWxp5PcnVVKjOWcArH
	 J4A5Dc3OOffnEpZSvzUKxiErFYguxzK8oemlTNhA7Ew+trmWqWmbmdTWlFgbJt9toa
	 XfT7bdnPXM6QA==
Date: Wed, 23 Oct 2024 14:56:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kernel Team <kernel-team@fb.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v6 3/9] bpf: Support private stack for struct
 ops programs
Message-ID: <ZxmbSO1DCcs5nCle@slm.duckdns.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191400.2105605-1-yonghong.song@linux.dev>
 <CAADnVQ+o35Gf3nmNQLob9PHXj5ojQvKd64MaK+RBJUEOAW1akQ@mail.gmail.com>
 <b280e12b-b4e8-4019-ad29-23808d360aee@linux.dev>
 <CAADnVQLEy+VXVeP96DK=U8wTL7Yj_=bTuxz5FBcVgDT346-2qA@mail.gmail.com>
 <ZxlkA7AiHJkG8r9M@slm.duckdns.org>
 <CAADnVQJLmBuzMJAp5h-QAcO1zvbuBUkprib3HZ7nUAfTeHGAug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJLmBuzMJAp5h-QAcO1zvbuBUkprib3HZ7nUAfTeHGAug@mail.gmail.com>

On Wed, Oct 23, 2024 at 04:07:49PM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 23, 2024 at 2:00 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Oct 22, 2024 at 01:19:58PM -0700, Alexei Starovoitov wrote:
> > > > The __nullable argument tagging request was originally from sched_ext but I also
> > > > don't see its usage in-tree for now.
> > >
> > > ok. Let's sync up with Tejun whether they have plans to use it.
> >
> > Yeah, in sched_ext_ops.dispatch(s32 cpu, struct task_struct *prev), @prev
> > can be NULL and right now if a BPF scheduler derefs without checking for
> > NULL, it can trigger kernel crash, I think, so it needs __nullable tagging.
> 
> I see. The following should do it:
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 3cd7c50a51c5..82bef41d7eae 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5492,7 +5492,7 @@ static int bpf_scx_validate(void *kdata)
>  static s32 select_cpu_stub(struct task_struct *p, s32 prev_cpu, u64
> wake_flags) { return -EINVAL; }
>  static void enqueue_stub(struct task_struct *p, u64 enq_flags) {}
>  static void dequeue_stub(struct task_struct *p, u64 enq_flags) {}
> -static void dispatch_stub(s32 prev_cpu, struct task_struct *p) {}
> +static void dispatch_stub(s32 prev_cpu, struct task_struct *p__nullable) {}

This is a lot neater than the existing workaround:

  http://lkml.kernel.org/r/Zxma-ZFPKYZDqCGu@slm.duckdns.org

Thanks!

-- 
tejun

