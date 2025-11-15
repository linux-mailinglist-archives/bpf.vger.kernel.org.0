Return-Path: <bpf+bounces-74610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96F8C5FD56
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC4D3BADE5
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA81DC997;
	Sat, 15 Nov 2025 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hthcC5Tx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AF224D6
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170114; cv=none; b=rJPobL87uoT8CAOcx6nPKa/Adm2hTFvLIKceyTDJx5Qe7LvQ6dnIP5Cw79vAmCT2x8rqQjW1+e+vx3dt/7tRVSwm77aVJWJjYuI2UEjvkgBlwek5XnmUjW2gkGzJrFSfCiynAhRdSaHY7SF5kpAGtNrYtT1ZHyp88u2buwo1Udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170114; c=relaxed/simple;
	bh=YnaVSj8yADVQUmQp28lsoLztmyuw6NCNuUNpgdI51RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5Iq3k8GkEqXPJZ7WWtcg16F0dE6NNpXB/a8AiktsvQkPsilCM2aZJ3mOgTos5Ww4Wqk0Y5A1Jv9JkhR7r/sgact9A4+efOrJ9UMKMGmBO2bDe+QJiyW/lYka/UZreHSgpiLf7uT9aSMqtYc/7TPtWZAyJc9srpHil0t0ngm8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hthcC5Tx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so18378905e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763170111; x=1763774911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO2aIGpEQBMBFUxzvU7FUJsMFELNUwwDn6axnPvHhyE=;
        b=hthcC5TxxB+Wh5oz/EDz4oJbpdI5RPa4Lef36YQR6sdvFniF41M+ZCHgqaMuZ/5yPh
         QlZYKLL3uLHnx5kfN6/Aop+nFglGrZeOfmF4WOXUTHF8UzbZlo3mvDfB3L5Tquqg6yzU
         xj7jQ66kZs6Vk3Qc7zG/vjMuAAlWvTigvG6AZuPz4vwpIigb4XxbfXmEt/SOTnjn8R7b
         qtm9kyZQGcxypAAFj6lOWUltXK/Mk7o4id8jrADlQlS8IQA9x7+ly9aA0pEtiwQC0Iig
         4pFy1E9GwDYeDGI1xbcH3/wSre0UAgN83JBW6IsR+PRdjb0UYUQ5ZMA0XdL56AsQejne
         EE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763170111; x=1763774911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pO2aIGpEQBMBFUxzvU7FUJsMFELNUwwDn6axnPvHhyE=;
        b=nZfbpex6Bf/6IPzGLQLxJkpK05Mv1+5HJUz/zT56x2ey/NN8M7HouSvmbHzoQWZ/jQ
         68ALUEY88CGyMvlM7XFmD/UztV1bUZEqMsZSFLR3idvdm8GF0qLDf0kvSg/MXBQ0BwDP
         0pQoWY7wmXZ/M6fe6rhQzPdqw5jSVqcuw/R9dWbPU+F2iPAoCEkjCt8ffGe15cq5JdOt
         OUDpEYb0ZPLOxbV36CMsHJIwWm0bKBv5QWc2KK9L+uCQIhLgBf/qC/V3JVFwwCfYEfnI
         UWMz3BcQgh247zC07tt66+Rby51jEzM3ws1EcTq+kYsWZ05idfigr0MXKEPoCztQvJzc
         xBsA==
X-Gm-Message-State: AOJu0YyjpsX+lScI4gxk8B7FgA75F6RaBbC5w+kS+F/h4gXYjz4YfyeB
	BPGI4F5M5WkMjP63+OMevK1gziZonZM4el2aEDHhre8yKyUa3UwAnds96rGPbejop1GSO5WA32O
	B3MP6QUVe3CiQzt97MNqSJo4izNq/COE=
X-Gm-Gg: ASbGnctLcOER7QBqJk5ddG8FBxUy4TjT4w333DfBgWZI2ai6q6nuW0v3OH2IfwWS/BF
	ggQuO/N8xzlXslTsVfpeOoBXYhMHGapeHF5IX+fq3TD9I401p3vJtpoGlETz/7ua5X4743B4sxr
	8qPCuvcNbkulMRJfn7r7dD6UaGZdMd5hcejjq1ZCruIzNh0o/5KXqADg7RGPyebr5W7Gw8z77rM
	vHrkgpG0feKmV3YaDQF7LycugfWj0ICmyrkDsTJxTo7zdMEmmSO9ZMBKtM5PxTOtl02jgauvwrq
	ie1ZoKcb/Nvobzq44f6+fl3wyWPWivwTv5ZbFgg=
X-Google-Smtp-Source: AGHT+IFlWZ60c8zRKMBukb/LZO+midunpx3KIwo4jEs5aNxTyQIdQXe0ws53xQrwqD2/LSZL8cVy1gcZZtgmstqWrN0=
X-Received: by 2002:a05:600c:4fd2:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-4778fe62164mr45052705e9.15.1763170110919; Fri, 14 Nov 2025
 17:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114111700.43292-1-puranjay@kernel.org> <20251114111700.43292-4-puranjay@kernel.org>
 <CAADnVQLyv-90hcgrp+DkmSv1b3bt4V8Nz6mdeiLJxV-w0oztjw@mail.gmail.com> <mb61p8qg83ygm.fsf@kernel.org>
In-Reply-To: <mb61p8qg83ygm.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 17:28:19 -0800
X-Gm-Features: AWmQ_bkHTH7FOPcyZRzG_26fUJlq8YVS7ab58q4HYl-ObQAO9oeeWADtbI3-72M
Message-ID: <CAADnVQK3ta20iz48Z_kQj__gkyP4c6MXxapeqt-25VUcsO1VkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any context safe
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 4:56=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Nov 14, 2025 at 3:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >>
> >> +       init_llist_head(&free_pages);
> >> +       /* clear ptes and collect struct pages */
> >> +       apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE=
_SHIFT,
> >> +                                    apply_range_clear_cb, &free_pages=
);
> >> +
> >> +       /* drop the lock to do the tlb flush and zap pages */
> >> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> >> +
> >> +       /* ensure no stale TLB entries */
> >> +       flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
> >> +
> >>         if (page_cnt > 1)
> >>                 /* bulk zap if multiple pages being freed */
> >>                 zap_pages(arena, full_uaddr, page_cnt);
> >>
> >> -       kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
> >> -       for (i =3D 0; i < page_cnt; i++, kaddr +=3D PAGE_SIZE, full_ua=
ddr +=3D PAGE_SIZE) {
> >> -               page =3D vmalloc_to_page((void *)kaddr);
> >> -               if (!page)
> >> -                       continue;
> >> +       llist_for_each_safe(pos, t, llist_del_all(&free_pages)) {
> >
> > llist_del_all() ?! Why? it's a variable on stack. There is no race.
>
> Yeah, I should have used __llist_del_all() which doesn't do an xchg() or
> in this case I can just use free_pages.first

Either one works. Slight preference for __llist_del_all() to avoid
peaking into llist details.

