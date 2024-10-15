Return-Path: <bpf+bounces-42101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFE99FA27
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6850C1C2295D
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D71D63D0;
	Tue, 15 Oct 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8WGou7G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A41D63C1
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028116; cv=none; b=lJg+z41pxy4GRTN+pP8S9eHr7o/ICd3emnJWIi9DHFEMrPQ7MLlg6rOz8bwqzX6yih7s3/50nJxy+W8pma3Fi8M0K2ji8WQ9YzxS15i1XoY489grAoG7DSRn9CIU4Gt09in8SZYRDtxB5tiR5PAno9rcEcqcS5TnlDN6GXMhrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028116; c=relaxed/simple;
	bh=5RdE2giy8562Re85BOJOeN1jSHndB0nsjR+HuEWxMxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc17zlc1npHGyEoKWxmZ1nCR7yjYE2kKKV6M7+XV9ss/lGo4q+qGqngwn4aVjtVHf3yHqNWOTd+E6Nd0saY1nHDeUxK77vFYgYh7VgtzJqwQSTjBdbdPoMSreeqv/GSEc8VabEXXYWawPZNlusfwWbRFLIisI+BJAYdmjg0WJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8WGou7G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43115887867so1826725e9.0
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729028113; x=1729632913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cDEfr7iJlpKvtJVFohMO4qPIkLlNxE55wjSbGdWPJU=;
        b=O8WGou7GLjMgdIdUdUomXivxyYp98pBwM1pyq0ytQL97K30tlrh+uwUBGYsYNdPCqL
         rOUidrMsg6EZtFEjSIM8mnuljIbD6gWQ85YWuWRegaJAM7pdbA6A7xys2NCYjLIcRQVd
         rr8cvMLAmG9JQhv1yys6GoPc/XOCmTuJeZKktJVffyHDel5+EQgEwbiEAQThmN+O+Wfy
         5OymtG3Zf5jmMONn2ujSYMlLXFImTBawYv/vVbLqZaS/zFlhUHxzgoXcihkPiXvpRVty
         WXGK0xtBSWRtDVRpZT7ZETdzdPZlgImCL6R8ITBV0HhpSSu1TKTohuPaVLyq9B9JX+hE
         8NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028113; x=1729632913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cDEfr7iJlpKvtJVFohMO4qPIkLlNxE55wjSbGdWPJU=;
        b=rTSExxvUoEkmA6dkOaQyeEoaJrAd0FHjOd/U7AZIgqbEgtXkPlzAPgQNA4uE19A+Zp
         o0MGpgzgbUnTG3SykcxGNeqH/FyUQLOc9gmqmG838O82ieZl1Yg+Fjyj7D4WaXKymwzO
         izCOglu9fubdAmX2tNEbOGXs3Icj1wHLCtQxkpwAbAAJlambYS1RZGGejNKbhNOJ/eZL
         oZRRKPq0xD3lDHox2SQm+E94n3/wa1gt3lZz4aY4kqgwDtglAcrLCMAz8bOI/us34oL7
         4O/NSG4XeFrFLfte1smpyoyygUQVTuBYZ6uYj3b7Q4jSCd99wDagTrQc/N5Y6efcBV4X
         tapg==
X-Forwarded-Encrypted: i=1; AJvYcCVNEOcv11aPtFm2kzOBrjhz36mPVAFS+QhcgqZm42CXDjkxBk8K/RFmcXreQmr0SUTftUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JsNMzzRMJgf9A6o+CgkehywWs7XmMJ9va8dZyLgFPbGvpQZo
	kjImpdX0qY5Ane2M6eAsjqUCcvHUOHnuPsjx8+qd7Lyh3QCLPvENYI3F9WcWHKD7EVGFhJT41bE
	vI71mVOwuQNMBu6grg2zc4AaFFyk=
X-Google-Smtp-Source: AGHT+IHLRUc1Ec23KLiUOkghWeXdlcRGPg6C+Rcu2iVcrsQ5Zn/gWAvnd8DS+MCf8jBT5xgXNq9Sb/QxJLFdemejXic=
X-Received: by 2002:a05:600c:1991:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-4314a29f55cmr16611555e9.3.1729028112580; Tue, 15 Oct 2024
 14:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
 <20241010175628.1898648-1-yonghong.song@linux.dev> <CAADnVQJMuR_riNLghmr0ohrEZSj-8ngcFQRn3VkdDyJAFakqKQ@mail.gmail.com>
 <96556ec2-f98c-444b-b0aa-ddf71e185c7d@linux.dev> <Zw7cDCpYE_WyFPSM@slm.duckdns.org>
In-Reply-To: <Zw7cDCpYE_WyFPSM@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Oct 2024 14:35:00 -0700
Message-ID: <CAADnVQK0eGi84RxnXNmi9MGDQFKLs4VJLFoWPxEbLZL=ZdejFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/10] bpf: Support calling non-tailcall bpf prog
To: Tejun Heo <tj@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Oct 10, 2024 at 09:12:19PM -0700, Yonghong Song wrote:
> > > Let's get priv_stack in shape first (the first ~6 patches).
> >
> > I am okay to focus on the first 6 patches. But I would like to get
> > Tejun's comments about what is the best way to support hierarchical
> > bpf based scheduler.
>
> There isn't a concrete design yet, so it's difficult to say anything
> definitive but I was thinking more along the line of providing sched_ext
> kfunc helpers that perform nesting calls rather than each BPF program
> directly calling nested BPF programs.
>
> For example, let's say the scheduler hierarchy looks like this:
>
>   R + A + AA
>     |   + AB
>     + B
>
> Let's say AB has a task waking up to it and is calling ops.select_cpu():
>
>  ops.select_cpu()
>  {
>         if (does AB already have the perfect CPU sitting around)
>                 direct dispatch and return the CPU;
>         if (scx_bpf_get_cpus(describe the perfect CPU))
>                 direct dispatch and return the CPU;
>         if (is there any eligible idle CPU that AB is holding)
>                 direct dispatch and return the CPU;
>         if (scx_bpf_get_cpus(any eligible CPUs))
>                 direct dispatch and return the CPU;
>         // no idle CPU, proceed to enqueue
>         return prev_cpu;
>  }
>
> Note that the scheduler at AB doesn't have any knowledge of what's up the
> tree. It's just describing what it wants through the kfunc which is then
> responsible for nesting calls up the hierarhcy. Up a layer, this can be
> implemented like:
>
>  ops.get_cpus(CPUs description)
>  {
>         if (has any CPUs matching the description)
>                 claim and return the CPUs;
>         modify CPUs description to enforce e.g. cache sharing policy;
>         and possibly to request more CPUs for batching;
>         if (scx_bpf_get_cpus(CPUs description)) {
>                 store extra CPUs;
>                 claim and return some of the CPUs;
>         }
>         return no CPUs available;
>  }
>
> This way, the schedulers at different layers are isolated and each only h=
as
> to express what it wants.

What we've been discussing is something like this:

ops.get_cpus -> bpf prog A -> kfunc

where kfunc will call one of struct_ops callback
which may call bpf prog A again, since it's the only one attached
to this get_cpus callback.
So
ops.get_cpus -> bpf prog A -> kfunc -> ops.get_cpus -> bpf prog A.

If kfunc calls a different struct_ops callback it will call
a different bpf prog B and it will have its own private stack.

During struct_ops registration one of bpf_verifier_ops() callbacks
like bpf_scx_check_member (or a new callback) will indicate
back to bpf trampoline that limited recursion for a specific
ops.get_cpus is allowed.
Then bpf trampoline's bpf_trampoline_enter() selector will
pick an entry helper that allows limited recursion.

Currently bpf trampoline doesn't check recursion for struct_ops progs,
so it needs to be tightened to allow limited recursion
and to let bpf jit prologue know which part of priv stack to use.

