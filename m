Return-Path: <bpf+bounces-51664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A29A36F0A
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E411894B48
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4421DE2A5;
	Sat, 15 Feb 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dg7opRyJ"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7A42AA5;
	Sat, 15 Feb 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632645; cv=none; b=tisg8hjK9gcB2hxeQf3en49+6Ve8cBXTe1aOf2qI1aJCWni+SQCduU+7wI55vAX/R9mtfAQUXz3KhXh7LVH/PL8vpXtYZz/qBfnZOyjHkS1zXuzmZ1T0QhDJaLSuDNjO2g2m6HdCS8WAJQNtysJz1viwoZb11E+/D0qqQmfBij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632645; c=relaxed/simple;
	bh=12D54tSqZYYM94NSTY49DMrJ8u9BJDLtE0yKjHfwIoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKmrR34uE1qJD+jeRQhlhQSahUm1HwJf2FiNGxtWQE8ymNaPeVpjo8JPKV1eW0STTiX96xjPnNSJtkVcSwC23WwT5K9d4abHRAzaStBUo8kUB0Y3nOll+2uugGI85QBhqxwDlyw3+lr//EWKZ+Y0/PuHLrpr5Bt4bg5FCTuJNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dg7opRyJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RVHUTIkovelkcVcjpfjCsd7fs8jwD3h1GnA4cAJiVMA=; b=dg7opRyJyzXQS/ijLpY6yVjfse
	y0xiZSai6ir1hv53xjC04L7tKk7jUwdthNjnu6+3MoZHil9g61/njVIigEWQqplQBwHg4YPCTj69R
	XVqr2Z8B2+j0RhvgMrVANU81GEWgYuOz6S/FCnQltOY6lUuz53o6cChvNwMU/0XWsP3xAPRlCJVAl
	0dPikczG5BrOz/p0vm+FIrT4ZtZ7Etf5NCK7RMkCjTZpkYo0SURvtT/JKdYX3Ww9pIHI4FH0o5BIG
	WW8exkUchA24xaIJ3trqItrV5euoRgM1tiWpFRlb3suc8bysL0NRXjy1geDU6bB4JyrXFvi350FSS
	TUMvJcMw==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tjJuT-003xbB-B7; Sat, 15 Feb 2025 16:16:55 +0100
Message-ID: <6632e26d-996c-432e-956f-5be178722e5b@igalia.com>
Date: Sun, 16 Feb 2025 00:16:43 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Tejun Heo <tj@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, kernel-dev@igalia.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250212084851.150169-1-changwoo@igalia.com>
 <CAADnVQLRrhyOHGPb1O0Ju=7YVCNexdhwtoJaGYrfU9Vh2cBbgw@mail.gmail.com>
 <4fd39e4b-f2dc-4b7d-a3be-ec3eae8d592a@igalia.com>
 <CAADnVQL5dt7_S-zFSh-ps7uPfL2ofYs0vo1fFuFBwiz0=DV2Vw@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAADnVQL5dt7_S-zFSh-ps7uPfL2ofYs0vo1fFuFBwiz0=DV2Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 25. 2. 15. 12:51, Alexei Starovoitov wrote:
 > On Fri, Feb 14, 2025 at 1:24 AM Changwoo Min <changwoo@igalia.com> wrote:
 >>
 >> Hello Alexei,
 >>
 >> Thank you for the comments! I reordered your comments for ease of
 >> explanation.
 >>
 >> On 25. 2. 14. 02:45, Alexei Starovoitov wrote:
 >>> On Wed, Feb 12, 2025 at 12:49 AM Changwoo Min <changwoo@igalia.com> 
wrote:
 >>
 >>> The commit log is too terse to understand what exactly is going on.
 >>> Pls share the call stack. What is the allocation size?
 >>> How many do you do in a sequence?
 >>
 >> The symptom is that an scx scheduler (scx_lavd) fails to load on
 >> an ARM64 platform on its first try. The second try succeeds. In
 >> the failure case, the kernel spits the following messages:
 >>
 >> [   27.431380] sched_ext: BPF scheduler "lavd" disabled (runtime error)
 >> [   27.431396] sched_ext: lavd: ops.init() failed (-12)
 >> [   27.431401]    scx_ops_enable.isra.0+0x838/0xe48
 >> [   27.431413]    bpf_scx_reg+0x18/0x30
 >> [   27.431418]    bpf_struct_ops_link_create+0x144/0x1a0
 >> [   27.431427]    __sys_bpf+0x1560/0x1f98
 >> [   27.431433]    __arm64_sys_bpf+0x2c/0x80
 >> [   27.431439]    do_el0_svc+0x74/0x120
 >> [   27.431446]    el0_svc+0x80/0xb0
 >> [   27.431454]    el0t_64_sync_handler+0x120/0x138
 >> [   27.431460]    el0t_64_sync+0x174/0x178
 >>
 >> The ops.init() failed because the 5th bpf_cpumask_create() calls
 >> failed during the initialization of the BPF scheduler. The exact
 >> point where bpf_cpumask_create() failed is here [1]. That scx
 >> scheduler allocates 5 CPU masks to aid its scheduling decision.
 >
 > ...
 >
 >> In this particular scenario, the IRQ is not disabled. I just
 >
 > since irq-s are not disabled the unit_alloc() should have done:
 >          if (cnt < c->low_watermark)
 >                  irq_work_raise(c);
 >
 > and alloc_bulk() should have started executing after the first
 > calloc_cpumask(&active_cpumask);
 > to refill it from 3 to 64

Is there any possibility that irq_work is not scheduled right away on 
aarch64?

 >
 > What is sizeof(struct bpf_cpumask) in your system?

In my system, sizeof(struct bpf_cpumask) is 1032.

 >
 > Something doesn't add up. irq_work_queue() should be
 > instant when irq-s are not disabled.
 > This is not IRQ_WORK_LAZY.> Are you running PREEMPT_RT ?

No, CONFIG_PREEMPT_RT is not set.

Regards,
Changwoo Min

