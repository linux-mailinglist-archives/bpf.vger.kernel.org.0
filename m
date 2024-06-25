Return-Path: <bpf+bounces-33005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D125915D1D
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 05:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2471F26933
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D73481DD;
	Tue, 25 Jun 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MKOuIs7v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622E1BC4E
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284461; cv=none; b=pkaevGF0vBxq5J8HtHCaj+wZeP9Sa3htgcX1FGqVOjC+MHVkzukctu1SBclNxW5UwqzMJ+nzWLh1VE7MgA9UEe/aSsXRx10LVDPtylu+F//zqU/ocH8Rmf9pziOYnsJ3s5BZC3yH5NKcs+/1yowDIox3BUmD0wch14TOUsjfpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284461; c=relaxed/simple;
	bh=zCywv/26MnAcDELnhXlz4QfhMlYk3Hwo/ASChN+uSFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSNXoPgyqpWYuBs1YdvRzbGt/1gcc5TTJ6tvKsMjD0cJxSytAe7u3EY3ftkdF/EW7Wq+0CZn4d6JeLXIdT2bc4weidVBbNDgM6YxWMmPPCQIBvKrdsUW/ITVqSH8l2f3kGemqnqDPN3bSEwD/c6RxX59Fi42EhkiCKBW/6tL0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MKOuIs7v; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so5296226a12.3
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719284458; x=1719889258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDEbQTg5rjrKHPmeslGhj0qLn8Bi1wMk8fBJxe+Fhhw=;
        b=MKOuIs7vBFHxkZuywxVlkhHwEkENqnAseHWGznieFyC6Z2iSghr1DXQZthXNTTzj8A
         JcSovlvN7VXQSyS1AmK5B2Qp3nDAgN4PDmPaAEHMprS5MM1AXerEPICC4zkCxtn0JCos
         B9h1dikaI5PfewQ+6j+O4mE5ZKF6NE9C5NA8784Nj1XRlkQBKtoffqEI6ScsjlZugMY+
         uNBFk1WfgUkXsIiCmyQBAH9Xb7XY8TjcbJyXKxnB5EQcIaQPXjw3KuYpod26GFgV+pdI
         cSO4LLhFSkicuxuK424wP8hh1re0mWuTZJdqT+cwcL7ksPVdu7ABoreK5ogq1CpIj4uv
         hFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719284458; x=1719889258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDEbQTg5rjrKHPmeslGhj0qLn8Bi1wMk8fBJxe+Fhhw=;
        b=sVPpQfPlBLvK9uaNPTTaB9rO9lDWyqYVcKv2MMJ3pajgyN0pY5RjC1TN3G3qatjOU1
         aRuiL6DDOnu6bAAMdVauOChGyORp0wvT6QfbjI0lqSC1jFkkv4IBOfTG/eLLdwyDL0bs
         mKtRDx0uo14eKbVFfFm62mqqWa2DNqZr5cqRTWc0IsUXzgpIoVenzZ7M+H0/vJyKpjed
         TCacNJlaWZkln4qAosPzdnUg73Ade9I6iP2SwUi2BGRXi5NJPGvT7Fo/Jlns28IZiyj5
         SB2E6/1PD8VPXo9Dy2drPDG0jdf/YvWvAugXSr6T85cPZX+sPQzy3Vof8SMyfCw/4kPy
         UBJQ==
X-Gm-Message-State: AOJu0Yy7up3Q2GIG9SttHmZ+vn0mRe3NDt3+n7/LPrx0zY8D8cka/3Ih
	xP76PSb65UnJDucTyk6RQH8DjRvHo1gRL8VNUHQSvrwGvpSJ8k+fNUHdDhPxufVESVhQZ59JL69
	VaxzUWV6D4qdyXPB0xilqtGgj9H3QljyV+ROIuQ==
X-Google-Smtp-Source: AGHT+IEitG0JQleQ/vZFXAUvv2wiKqGD1UejnV57HaC0FguQLodsAUL9ZgwklDMKrmIdxfcq3oWEnsRnE7R0D3aeSto=
X-Received: by 2002:a50:d719:0:b0:57d:444:c457 with SMTP id
 4fb4d7f45d1cf-57d4bdc9f4emr3775989a12.28.1719284457641; Mon, 24 Jun 2024
 20:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmIyMfRSp9DpU7dF@debian.debian> <CAEf4BzbpSYmsTYSgMws7p8B2i1ihFZum0zge5W7DCo0FR8pSyA@mail.gmail.com>
In-Reply-To: <CAEf4BzbpSYmsTYSgMws7p8B2i1ihFZum0zge5W7DCo0FR8pSyA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 24 Jun 2024 22:00:46 -0500
Message-ID: <CAO3-PbqJudq8EjJUN0ax8OqVy6vRd+VLozCzyLsG+wST8taX9A@mail.gmail.com>
Subject: Re: Ideal way to read FUNC_PROTO in raw tp?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 5:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 6, 2024 at 3:03=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrot=
e:
> >
> > Hi,
> >
> >  I am building a tracing program around workqueue. But I encountered
> > following problem when I try to record a function pointer value from
> > trace_workqueue_execute_end on net-next kernel:
> >
> > ...
> > libbpf: prog 'workqueue_end': BPF program load failed: Permission
> > denied
> > libbpf: prog 'workqueue_end': -- BEGIN PROG LOAD LOG --
> > reg type unsupported for arg#0 function workqueue_end#5
> > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > ; int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> > 0: (79) r3 =3D *(u64 *)(r1 +8)
> > func 'workqueue_execute_end' arg1 type FUNC_PROTO is not a struct
> > invalid bpf_context access off=3D8 size=3D8
> > processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> > libbpf: prog 'workqueue_end': failed to load: -13
> > libbpf: failed to load object 'configs/test.bpf.o'
> > Error: failed to load object file
> > Warning: bpftool is now running in libbpf strict mode and has more
> > stringent requirements about BPF programs.
> > If it used to work for this object file but now doesn't, see --legacy
> > option for more details.
> > ...
> >
> > A simple reproducer for me is like:
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> >
> > SEC("tp_btf/workqueue_execute_end")
> > int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> > {
> >         u64 addr =3D (u64) f;
>
> you can work around with:
>
> bpf_probe_read_kernel(&addr, sizeof(addr), &ctx[1]); /* ctx[1] is the
> second argument */
>
> Not great, but will get you past this easily.
>
Yes that works, too. Currently I am using the regular tp to
workaround. That said, I am more interested in the verifier side of
this. I am happy to add it to my queue if no one has signed up to
support func_proto type in ctx. Would maintainers welcome RFC patches
for this or is it something that you prefer to leave for now?

best
Yan

