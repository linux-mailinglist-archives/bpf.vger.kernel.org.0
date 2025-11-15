Return-Path: <bpf+bounces-74602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F66C5FC8B
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE9C3BB977
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2517C220;
	Sat, 15 Nov 2025 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdZdGCji"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51428F49
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763168206; cv=none; b=QAyyF6PBk0qMxJ4rV4AiWm1catGDIbOk8kO+Y9cYMCqEhFvRsPlIEj1ybEUcb0r/ixMOBFmN5dZJkEFbA12WbuLBrS2Ep6isDFnw7KZ9GFQM9zvYybix232iydttMqTVc6u+iLuThkfxd0vZXnia3Kc/sYwzFb+RLXuFCw6RUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763168206; c=relaxed/simple;
	bh=irVxfoOLYlnJqrML6VaQ5El39tjAePn23NsYZ6RRNAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9c4bgzIgWFVgsVPziaxgF5ZqoW5ctlG+tfu8i9o6XaUcRiOG5yVPJWNo1mdAScSkC8LNocD6ryO0kZbhBZewTycfHJwvPlH10PM1XRSnNLHqrhXpX7hnK2e9mDdDzUWAvapGrxaVjqtBQKe98GQln3vyW1Z+kK+2BK/i5qUoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdZdGCji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343CCC4CEF1;
	Sat, 15 Nov 2025 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763168205;
	bh=irVxfoOLYlnJqrML6VaQ5El39tjAePn23NsYZ6RRNAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sdZdGCjiVODd9QjeBy9MoommVSQX4naGr/Zun5VRABoEw5FFMJmPDtKhUsP+TrABW
	 ++uTtW6SB0LlZu4sXkhevlcbLsQkW4GZPeBJckLnC16fE2xJjoLhwl8GYRGKYcbJYK
	 slTD/iqV77H0LzOF3VQu9fpJQ1UatbxQ73V94LJFxUeBGf9Aa5lVJnMaEzZPRua3o/
	 ePJC/xGAp1ez0kTfapZ9y2BBRlBCb/HfMuOjAWb/6+WKRThV0zgHUMVFcqtXyCG03d
	 6i23/74MIcm7URoaw0J+V8/iM1CQopPrPTq6mm6dRddYEsUYJ+s1c9iE9XSdWxeDhh
	 r3iqbDOjpis8A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any
 context safe
In-Reply-To: <CAADnVQLyv-90hcgrp+DkmSv1b3bt4V8Nz6mdeiLJxV-w0oztjw@mail.gmail.com>
References: <20251114111700.43292-1-puranjay@kernel.org>
 <20251114111700.43292-4-puranjay@kernel.org>
 <CAADnVQLyv-90hcgrp+DkmSv1b3bt4V8Nz6mdeiLJxV-w0oztjw@mail.gmail.com>
Date: Sat, 15 Nov 2025 00:56:41 +0000
Message-ID: <mb61p8qg83ygm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Nov 14, 2025 at 3:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>>
>> +       init_llist_head(&free_pages);
>> +       /* clear ptes and collect struct pages */
>> +       apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_S=
HIFT,
>> +                                    apply_range_clear_cb, &free_pages);
>> +
>> +       /* drop the lock to do the tlb flush and zap pages */
>> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +
>> +       /* ensure no stale TLB entries */
>> +       flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
>> +
>>         if (page_cnt > 1)
>>                 /* bulk zap if multiple pages being freed */
>>                 zap_pages(arena, full_uaddr, page_cnt);
>>
>> -       kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
>> -       for (i =3D 0; i < page_cnt; i++, kaddr +=3D PAGE_SIZE, full_uadd=
r +=3D PAGE_SIZE) {
>> -               page =3D vmalloc_to_page((void *)kaddr);
>> -               if (!page)
>> -                       continue;
>> +       llist_for_each_safe(pos, t, llist_del_all(&free_pages)) {
>
> llist_del_all() ?! Why? it's a variable on stack. There is no race.

Yeah, I should have used __llist_del_all() which doesn't do an xchg() or
in this case I can just use free_pages.first

