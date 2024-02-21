Return-Path: <bpf+bounces-22455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5785E6DE
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 20:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B6F284CE2
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2285949;
	Wed, 21 Feb 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmuEcNpo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEC80C07
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542324; cv=none; b=sSZhfw2EgchVc+MBuPhIeb+0oSWVxJVmZ1YdthjzTloINyrKCYiZRfQ5AlptCizOGZnwUkemoXE4N81eFAKACN1ryIyy8PLoh2GgMkUws/MUsFLkdXoS/MiBSbgnWoY3CAj9VdUAi3m5rjybwAPx3PvRRv/f32UiL1C331wWB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542324; c=relaxed/simple;
	bh=xOybeqGeBhqzTbfq3rJ46av/vPgv+KF1TyNR3xSHbQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr06Y+qtveTiGrbmP1G6ib5ofHyuuZAqBTiJsNAJ2iBXz4hQUlUoY3EUsAehy3T63HLGvWVpnJG5xP/wTylhHUAXCMYE1yoZeUloEkOoUcUk2C5o6as5VSNiun4dtxi70IHWOOzh40eGlMajJao3p2yWO5L28T9DpuDqDK1a4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmuEcNpo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41275855dc4so7271585e9.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 11:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708542321; x=1709147121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sja2zbt3rEOa8Avi/qXGyDB6MFdPpzWjHQILVKnQ8bk=;
        b=kmuEcNpoHl+jv6OHbBWIrwa9xIfZbTG7onIBsiYztM8Q5ZTIJXXmcyHW5yRPVq9qV9
         6EzBTojFx+95oEDFjV4pMrEFCTzGPzihuDuiXcerzgv+6UsTW/d8V+zXF8LBsBkEV8we
         h2b9YR1eGYt79CX8E/klTecx+MGXGpyUlzZittjOYJDcdLuK+9DkM7okj5am61fINlG6
         hFHXLSZJ2pU8Y3jAY+CtpdjA2fr6/Jp4xf0f+LNyo7/buS1kB851wdo6APXrAvsRY46Q
         4mDZ+4UZji4+a7RXCgiSKmRTkPpfxGVZLJtOYHEwdhlfx6CHZFunChhVN7FcUSgQqCKu
         20Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708542321; x=1709147121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sja2zbt3rEOa8Avi/qXGyDB6MFdPpzWjHQILVKnQ8bk=;
        b=WGcRcA6CkLr/dyKkavaR8q0blLBxYXMFYAGbFEUUsGJi+zZ4+Byc/3XSF0A1AgbiU3
         MwlIBFFDu1AXzpovLgnQ/Z5KuiDZCEfZiqlXxWQazoihztzleUahk0EWXskqI/pKj5rG
         bhiMMpYjYl1PlmarI/S7JEtQlooC7LSVZYe8z7cNiMzlmMzgzLp0/CRyIMqPMPQLJ0Ai
         /HB5aowgLq2q61mOK3dF5w4TXKqbStiVkndtU3W7cedu5rGjUSJQgo/0F5FPDT0yu0ju
         N+OptHvbE3Br4oPDxsOC5ApcROms8TmTT7B4xpOGj+IHm85fRlmMCZUiZJitNOnffvjP
         MCdA==
X-Gm-Message-State: AOJu0Yzmfoa4UGTQsNTZSdHCZ0bDpOTGTqpVCrtitPqXneDD2V4Vdrt+
	ucKkVGgi3vMdEwohn1kOo27WvAP3To5JksSb+Gy4R7Ys1c2UW/6K+wBVSjo7D/rFEQZGf5qQJ+3
	NKhI5hrfMS3CD593Gec/mvjmGUYo=
X-Google-Smtp-Source: AGHT+IH4OpfT+YGkYMhhDR2Euz6SXzY0iXevzboZ2yy0+99M/24qMSrjS4feQAc65Yt0v7PKH3ikGlt3+TSDGVKxUiM=
X-Received: by 2002:a5d:5402:0:b0:33d:3b19:a2c3 with SMTP id
 g2-20020a5d5402000000b0033d3b19a2c3mr8327469wrv.57.1708542320538; Wed, 21 Feb
 2024 11:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220192613.8840-1-alexei.starovoitov@gmail.com> <ZdWPjmwi8D0n01HP@infradead.org>
In-Reply-To: <ZdWPjmwi8D0n01HP@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Feb 2024 11:05:09 -0800
Message-ID: <CAADnVQLrUpJizoVeYjFwSEPg1Eo=ACR-Gf5LWhD=c-KnnOTKuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] mm: Introduce vm_area_[un]map_pages().
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:52=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Feb 20, 2024 at 11:26:13AM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > vmap() API is used to map a set of pages into contiguous kernel virtual=
 space.
> >
> > BPF would like to extend the vmap API to implement a lazily-populated
> > contiguous kernel virtual space which size and start address is fixed e=
arly.
> >
> > The vmap API has functions to request and release areas of kernel addre=
ss space:
> > get_vm_area() and free_vm_area().
>
> As said before I really hate growing more get_vm_area and
> free_vm_area outside the core vmalloc code.  We have a few of those
> mostly due to ioremap (which is beeing consolidate) and executable code
> allocation (which there have been various attempts at consolidation,
> and hopefully one finally succeeds..).  So let's take a step back and
> think how we can do that without it.

There are also xen grant tables that grab the range with get_vm_area(),
but manage it on their own. It's not an ioremap case.
It looks to me the vmalloc address range has different kinds of areas
already: vmalloc, vmap, ioremap, xen.

Maybe we can do:
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 7d112cc5f2a3..633c7b643daa 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -28,6 +28,7 @@ struct iov_iter;              /* in uio.h */
 #define VM_MAP_PUT_PAGES       0x00000200      /* put pages and free
array in vfree */
 #define VM_ALLOW_HUGE_VMAP     0x00000400      /* Allow for huge
pages on archs with HAVE_ARCH_HUGE_VMALLOC */
+#define VM_BPF                 0x00000800      /* bpf_arena pages */

+static inline struct vm_struct *get_bpf_vm_area(unsigned long size)
+{
+       return get_vm_area(size, VM_BPF);
+}

and enforce that flag in vm_area_[un]map_pages() ?

vmallocinfo can display it or skip it.
Things like find_vm_area() can do something different with such an area
(if that was the concern).

> For the dynamically growing part do you need a special allocator or
> can we just go straight to the page allocator and implement this
> in common code?

It's a bit special allocator that is using maple tree to manage
range within 4G region and
alloc_pages_node(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT)
to grab pages.
With extra dance:
        memcg =3D bpf_map_get_memcg(map);
        old_memcg =3D set_active_memcg(memcg);
to make sure memcg accounting is done the common way for all bpf maps.

The tricky bpf specific part is a computation of pgoff,
since it's a shared memory region between user space and bpf prog.
The lower 32-bits of the pointer have to be the same for user space and bpf=
.

Not much changed in the patch since the earlier thread.
Either find it in your email or here:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=3Dare=
na&id=3D364c9b5d233d775728ec2bf3b4168fa6909e58d1

Are you suggesting the api like:

struct vm_struct *area =3D get_sparse_vm_area(size);
vm_area_alloc_pages(struct vm_struct *area, ulong addr, int page_cnt,
int numa_id);

and vm_area_alloc_pages() will allocate pages and vmap_pages_range()
them while all code in mm/vmalloc.c ?

I can give it a shot.

The ugly part is bpf_map_get_memcg() would need to be passed in somehow.

Another bpf specific bit is the guard pages before and after 4G range
and such vm_area_alloc_pages() would need to skip them.

> > For BPF use case the area_size will be 4Gbyte plus 64Kbyte of guard pag=
es and
> > area->addr known and fixed at the program verification time.
>
> How is this ever going to to work on 32-bit platforms?

bpf_arena requires 64bit and mmu.

ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
obj-$(CONFIG_BPF_SYSCALL) +=3D arena.o
endif

and special JIT support too.

With bpf_arena we can finally deprecate a bunch of things like bloom
filter bpf map, etc.

