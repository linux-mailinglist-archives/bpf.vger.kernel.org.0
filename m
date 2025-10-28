Return-Path: <bpf+bounces-72649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B0C1756F
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE0B1AA8334
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640C36A618;
	Tue, 28 Oct 2025 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bHOGkYGl"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664534575E
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693864; cv=none; b=HcHGBvC3+HvyMOwMjw65YLdZHMu4NTZWHGkSBtpLQ1KHzL5m80RvSYW+ItMoa6BuKJVGPZE0CPAUmtXM3JcA96iFY60tErzkLS1sNBtIDfQIizyztS71LxjcAleb/IKHXeTpmVnR/zJod2AuWTV/qoYSDzrK5j+uE1GQmm1k1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693864; c=relaxed/simple;
	bh=xADNPBQhTc3x0r+Uhy35KcjJVB8WvPcuvGGoxZTvq3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhAdI9FHdGKN6MLJWHNfu2L3HSnNkc5/73X+UXk6+Ih6OI5grxj8neIA28/A0F0q17/ucoq2ZW+LX53+rMdTTbL5wfyiqpTu5uiWZx71/wnyHuxK8tfmHQfvhPgesHVlShzuDx9uUhPx6q43FsRrszIrXgYTMeoa/QwHTSobRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bHOGkYGl; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761693850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlB9WJAF3YhOSJlj9moFGTAHILvUEPk36z3X23Y7y8Y=;
	b=bHOGkYGlqdYJuvtiAR/iv2AxNepGg0f5rNp8FrpwUHBrwiPDOVfZTtBT7gAhQftp/LaWRK
	tkTBQeL5oFLzo4UE11YBLEIi9jliZWh71t8hN9r23n5Bn+fHdTYokChGvi/23PJv6usiFX
	ESFA0MReO2ShiGO48zjD5eGfewGK3Fk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Song Liu <song@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
In-Reply-To: <CAHzjS_vrNZpEbBuHLhHwHaGzLaF3QEeKWz-VikCm0bYrFBq4UA@mail.gmail.com>
	(Song Liu's message of "Tue, 28 Oct 2025 14:33:43 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-7-roman.gushchin@linux.dev>
	<CAHzjS_vrNZpEbBuHLhHwHaGzLaF3QEeKWz-VikCm0bYrFBq4UA@mail.gmail.com>
Date: Tue, 28 Oct 2025 16:24:04 -0700
Message-ID: <878qguobjf.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Song Liu <song@kernel.org> writes:

> On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> [...]
>> +
>> +struct bpf_oom_ops {
>> +       /**
>> +        * @handle_out_of_memory: Out of memory bpf handler, called befo=
re
>> +        * the in-kernel OOM killer.
>> +        * @ctx: Execution context
>> +        * @oc: OOM control structure
>> +        *
>> +        * Should return 1 if some memory was freed up, otherwise
>> +        * the in-kernel OOM killer is invoked.
>> +        */
>> +       int (*handle_out_of_memory)(struct bpf_oom_ctx *ctx, struct oom_=
control *oc);
>> +
>> +       /**
>> +        * @handle_cgroup_offline: Cgroup offline callback
>> +        * @ctx: Execution context
>> +        * @cgroup_id: Id of deleted cgroup
>> +        *
>> +        * Called if the cgroup with the attached bpf_oom_ops is deleted.
>> +        */
>> +       void (*handle_cgroup_offline)(struct bpf_oom_ctx *ctx, u64 cgrou=
p_id);
>
> handle_out_of_memory() and handle_cgroup_offline() takes bpf_oom_ctx,
> which is just cgroup_id for now. Shall we pass in struct mem_cgroup, which
> should be easier to use?

I want it to be easier to extend, this is why the structure. But I can
pass a memcg pointer instead of cgroup_id, not a problem.

Thanks!

>
> Thanks,
> Song
>
>> +
>> +       /**
>> +        * @name: BPF OOM policy name
>> +        */
>> +       char name[BPF_OOM_NAME_MAX_LEN];
>> +};
>> +
>> +#ifdef CONFIG_BPF_SYSCALL
>> +/**
>> + * @bpf_handle_oom: handle out of memory condition using bpf
>> + * @oc: OOM control structure
>> + *
>> + * Returns true if some memory was freed.
>> + */
>> +bool bpf_handle_oom(struct oom_control *oc);
>> +

