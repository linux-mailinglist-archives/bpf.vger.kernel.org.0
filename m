Return-Path: <bpf+bounces-56161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03906A92C05
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 22:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7178A6C94
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EA42063C0;
	Thu, 17 Apr 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWR4dmp2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BB2AD0C
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920459; cv=none; b=kscNpCKM1/m+gh2GibZ5Wq0QujTRBfizRjheK9FkUpy7U/S+DEVCrVcizlK4EUVxAybbC50LhfdogZ9Xv8viCtaWlmJLWsSaQoA6l65ZHy0S98HdVRpSJc+SqM1lXKQ5iUu7e7CzgUvXrI0oPpyACvWmfVOHKTosR81UlBIB8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920459; c=relaxed/simple;
	bh=7L0OtmfYYoGbtfAJDFZHvsGXOWd0JIGfIsS/w5pvmh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k36QErro5I+OX9ulpamYXA4HB3rpw5ELEYVCTUQtCHaVEdxqgmeZjoTNRrXrXcPMgJjn1CTbHa9GMvWMC9aWSjMUuqraUnrKvVnxsWAYsswma9C5DOpghjHiPLZfmE102T4XhWSWa2ujRaDEJx+Y3+DwVJgxN8ybuWmPcqdL31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWR4dmp2; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-acae7e7587dso182291166b.2
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744920456; x=1745525256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CN/aABpuZMLB+jRMfqcEegqrUrXSp+KIPUOdr/G7A2s=;
        b=aWR4dmp2wf8ehof7Jm2qFLj8OFD643kEINTaB3eYTGMsj9hcAQYb0Ksurr6oJuHiuC
         KzJaRxsSiJfGjY/+FVuKepbJnONuHSh9SvXrihQD7iGnE8ZaxpSbxPfp3NGw+sOL3ToR
         8JGky2N4d1VRISf6r2H93a3IXuhB4wb7Br5pZx3jFxaBcBSbF56uLcDUx/zMFw0NHJMQ
         UiYsY3bAErkLcVYaJ0zrHBArkrdiOifmKoeMkTUpmP7t6z++Pu36WfBfx/h8AY4dFxTq
         8hBz5Li27tKsuWxtpUhw1emHR3TfsoUwkAI8ucrhZbSXL0bPIzwbKKpDooBL0dm9CdOf
         hQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744920456; x=1745525256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CN/aABpuZMLB+jRMfqcEegqrUrXSp+KIPUOdr/G7A2s=;
        b=rTFRTc3gcLWUmc+rq1op8YJPfb0eloRB8Qk2hZgQsquzuknxDiKb6U0hgDqq967uUU
         KN2fG6X8gtzG84wh+e6QmFPirW7CeOq0eR6mgzKHrucsoqRXwMi/tbu3pTBruHJo1uqK
         nxIz4hoEvfpSpJL4aQDu8u/oev9OpfVQ4OyoKqg28a0nReb3jWGPeU4pdWhEZ5brgSvc
         IR3xaTfWxM32PAD7WOubMW/Y16gExnpkfaRosVjSYRNsJOz2ane4yDBiXL7DHzOyx8eq
         iqOcoAuC5MnFQ1jHjiIRDfXD3Uj1Q+93eGEjPfl/j7Culmy4wuD8sfT99YIR55wv7kQO
         28gQ==
X-Gm-Message-State: AOJu0YzeRaI8DrLAj5R0FhVTB+HO1msjXsStNKoUgE4BYXW/XJvIsbQi
	1Zv5sBdr4/nX3P4cZywtYgG7Cgksv20DJhjXBxAuTzyKBTL0mtsx1oqBoCth0qYydGEP649equ3
	9GxIj9WlFdh6+WmTglM7VVcEBWok=
X-Gm-Gg: ASbGnct1u4uDzWsQo847GwXh82uS6ncuDgb5nNh5VY5usDZvcHZApqiQ2KZx/OM0JEy
	fzImVbCZjCI+EEv1kxhUdEFI4f2KxnOp77BdCug8/qvv/Oo+geXWyRoOl+elOn/nsEBmfTS49HD
	QwbOW5O/G0+mcuGbBjDCspxCHBoNixyB+oVQZFhu7EXtheKVAAoLy1MQ==
X-Google-Smtp-Source: AGHT+IEXcMrSbnk+00mfDZ4z8NoXhLFjqjcKr1QCFPfYCf8k1YxGo5Q/3xG89W4moQSrqTKVdxl3RdGEHq7ErC57WaU=
X-Received: by 2002:a17:907:3d94:b0:acb:34b1:4442 with SMTP id
 a640c23a62f3a-acb74d879c0mr11915966b.48.1744920455660; Thu, 17 Apr 2025
 13:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-8-memxor@gmail.com>
 <m2plhbu68v.fsf@gmail.com>
In-Reply-To: <m2plhbu68v.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 22:06:58 +0200
X-Gm-Features: ATxdqUE1oP_Va_KFMWEU3CB1g_oC4a_d2qZOTzaTSERS2ofBztzrdpk1MyyZny4
Message-ID: <CAP01T77jqjoO3pc-V7qvsck1A9KJ-1u60ryouLL68ctHz2M=mQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 07/13] bpf: Introduce per-prog
 stdout/stderr streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 23:49, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Introduce a set of kfuncs to implement per BPF program stdout and stderr
> > streams. This is implemented as a linked list of dynamically allocated
> > strings whenever a message is printed. This can be done by the kernel or
> > the program itself using the bpf_prog_stream_vprintk kfunc. In-kernel
> > wrappers are provided over streams to ease the process.
> >
> > The idea is that everytime messages need to be dumped, the reader would
> > pull out the whole batch of messages from the stream at once, and then
> > pop each string one by one and start printing it out (how exactly is
> > left up to the BPF program reading the log, but usually it will be
> > streaming data back into a ring buffer that is consumed by user space).
> >
> > The use of a lockless list warrants that we be careful about the
> > ordering of messages. When being added, the order maintained is new to
> > old, therefore after deletion, we must reverse the list before iterating
> > and popping out elements from it.
> >
> > Overall, this infrastructure provides NMI-safe any context printing
> > built on top of the NMI-safe any context bpf_mem_alloc() interface.
> >
> > Later patches will add support for printing splats in case of BPF arena
> > page faults, rqspinlock deadlocks, and cond_break timeouts.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> [...]
>
> > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> > new file mode 100644
> > index 000000000000..2019ce134310
> > --- /dev/null
> > +++ b/kernel/bpf/stream.c
>
> [...]
>
> > +static int bpf_stream_page_check_room(struct bpf_stream_page *stream_page, int len)
>                                                                               ^^^^^^^
>                                                                      len is never used

Yeah, I will get rid of the parameter.

> > +{
> > +     int min = offsetof(struct bpf_stream_elem, str[0]);
> > +     int consumed = stream_page->consumed;
> > +     int total = BPF_STREAM_PAGE_SZ;
> > +     int rem = max(0, total - consumed - min);
> > +
> > +     /* Let's give room of at least 8 bytes. */
> > +     WARN_ON_ONCE(rem % 8 != 0);
> > +     return rem < 8 ? 0 : rem;
> > +}
>
> [...]
>
> > +static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
> > +{
> > +     const int max_len = ARRAY_SIZE((struct bpf_bprintf_buffers){}.buf);
> > +     struct bpf_stream_elem *elem;
> > +
> > +     /*
> > +      * We may overflow, but we should never need more than one page size
> > +      * worth of memory. This can be lifted, but we'd need to adjust the
> > +      * other code to keep allocating more pages to overflow messages.
> > +      */
> > +     BUILD_BUG_ON(max_len > BPF_STREAM_PAGE_SZ);
> > +     /*
> > +      * Length denotes the amount of data to be written as part of stream element,
> > +      * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
> > +      * accomodate, therefore deny allocations that won't fit into them.
> > +      */
> > +     if (len < 0 || len > max_len)
> > +             return NULL;
> > +
> > +     elem = bpf_stream_elem_alloc_from_bpf_ma(len);
> > +     if (!elem)
> > +             elem = bpf_stream_elem_alloc_from_stream_page(len);
>
> So, the stream page is a backup mechanism, right?
> I'm curious, did you compare how many messages are dropped if there is
> no such backup?

You can try disabling the backup allocation path. You will notice that
the selftest starts failing.
When IRQs are disabled (so arena page fault path or rqspinlock with
_irqsave), we won't be
able to refill bpf_mem_alloc() cache, and will end up dropping the
message on the floor.

> Also, how much memory is wasted if there is no
> "spillover" mechanism (BPF_STREAM_ELEM_F_NEXT).
> Are these complications absolutely necessary?

There's no way to know.
It depends on the free space and the message size, right.
Say we have 128 bytes left in the page, the message spans 156 bytes,
is it better to write 128 bytes and move the rest to the new page?

Say we have 100K messages sitting in the log that followed this
pattern, let's take wasted space on average per message as 32 bytes,
then that's 3.2 MB of unused memory.

>
> > +     return elem;
> > +}
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
> > +{
>
> This function accumulates elements in &stream->log w/o a cap.
> Why is this not a problem if e.g. user space never flushes streams for
> the program?

It is certainly a problem, hence this bit in cover letter:

> * Enforcing memory consumption limits on the log usage, so that
   in-flight log memory is bounded at runtime.

For now I will do a capacity counter per log, but maybe we want to tie
this to memcg? I am not sure we can charge it in any context, but was
hoping to get more opinions.

>
> > +     struct bpf_stream_elem *elem, *next = NULL;
> > +     int room = 0, rem = 0;
> > +
> > +     /*
> > +      * Allocate a bpf_prog_stream_elem and push it to the bpf_prog_stream
> > +      * log, elements will be popped at once and reversed to print the log.
> > +      */
> > +     elem = bpf_stream_elem_alloc(len);
> > +     if (!elem)
> > +             return -ENOMEM;
> > +     room = elem->mem_slice.len;
> > +     if (elem->flags & BPF_STREAM_ELEM_F_NEXT) {
> > +             next = (struct bpf_stream_elem *)((unsigned long)elem->next & ~BPF_STREAM_ELEM_F_MASK);
> > +             rem = next->mem_slice.len;
> > +     }
> > +
> > +     memcpy(elem->str, str, room);
> > +     if (next)
> > +             memcpy(next->str, str + room, rem);
> > +
> > +     if (next) {
> > +             elem->node.next = &next->node;
> > +             next->node.next = NULL;
> > +
> > +             llist_add_batch(&elem->node, &next->node, &stream->log);
> > +     } else {
> > +             llist_add(&elem->node, &stream->log);
> > +     }
> > +
> > +     return 0;
> > +}
>
> [...]
>
> > +BTF_KFUNCS_START(stream_consumer_kfunc_set)
> > +BTF_ID_FLAGS(func, bpf_stream_next_elem_batch, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_stream_free_elem_batch, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
> > +BTF_KFUNCS_END(stream_consumer_kfunc_set)
>
> This is a complicated API.
> If we anticipate that users intend to write this info to ring buffers
> maybe just provide a function doing that and do not expose complete API?

I don't think anyone will use these functions directly, though they
can if they want to.
It's meant to be hidden behind bpftool, and macros to print stuff like
bpf_printk().

We cannot pop one message at a time, since they are not in FIFO order.
So we need to splice out the whole batch queued and reverse it, before
popping things.
It's a consequence of using lockless lists.

The other option is using a lock to protect the list, but using
rqspinlock to then report messages about rqspinlock sounds like a
circular dependency.

>
> [...]
>
> I'll continue reading the patch-set tomorrow...

