Return-Path: <bpf+bounces-21754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C26851CA0
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439F91C21E1B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5A3FB3A;
	Mon, 12 Feb 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWGxHviW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC73FB2E
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762100; cv=none; b=l6ehuDRCx8ms5IaOaP0RDOVvDUlSXRuoJspC80qQKejvshfRIlUl7b5Z4CxgxCSj6C6kP+J1B5DTYhACZbJh1p5auiBbA3csaUCmpy3IFc+mqiET9ic10h5BXLR3rEWLRuaNa1rolMlHa/iz/0Q7+orFUnm7sZl4eFs+AnaCD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762100; c=relaxed/simple;
	bh=0u/mnqYWI45lyZB60y3ICaYS3nY00uiM3qP2/Wq4tK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zro9+qFQj/QF1IuekdstG/UDhFr/8WSmcSAuQgfobNyFKMUy6vjYyRTGWBKMLpEgLkIT7Cm1RuFhMcdvBXChBcKxrPh5O2cRHOsExFRsilsp2UWGYIC2PonMVAgx7yGQYbiDWSBB74x4vnTsGGVMeFAk0ykunQLc+l0xpC7Em5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWGxHviW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410e676c6bbso421505e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 10:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707762097; x=1708366897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u/mnqYWI45lyZB60y3ICaYS3nY00uiM3qP2/Wq4tK0=;
        b=GWGxHviW1qPefeIRwSl1tMm3JLgzyTG1bRopDUt2ztQnlq24WTz0wVwxtLcO5haJMX
         N5G2qU62nsLiATDqR3/mGz9FN8nS9jKR2DlIGDmrNIwm9IrGOm93HK2T/YQ8AJ32k4If
         mp8kvUlAnT0eVf9gMlxzQznvTBvJJT5Uh5TpjZALAu2NCOI33S5bKqnbIKovgeuoOxS4
         T38XJRc1Dx8yBe+Az3HWznDCRYoQZxWYVRDjZa1vFcEHQKAs8KsWd8S2ATVOh9jvuEP8
         kSU4xaFVvPfw+X0Xjzj7Vb8uszZ8WdMt1I9xiGwvti+NSLk8CryMLdYUM+mc1EMngylf
         m/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762097; x=1708366897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u/mnqYWI45lyZB60y3ICaYS3nY00uiM3qP2/Wq4tK0=;
        b=xEMUidOiHX+FSkbJyjGeZ6m3bnOsc8Yn/gbL+obBR0H1tO+CZBL/YnYiM6pk9HDWrY
         wmv0ie52Zp7kVysWjUYGI1y5Xs3CeI/B0cHXPVZfbE+ZBqDhEx6tXbNh0wSzkKFx7HWf
         RoZ8Xnp7867vRPsmcZWYE9sr66GiVA0CwdGKJtKYjjqv742qvx9IX7M5nmz9ljJR1yqi
         vKU8IaSBYguctfuQPmB32fl7fCkRHc56hCNAdW3Ecjl2N+bKxsNArXBjx7DuTqDnWBaG
         HhpFxCXEAqhVtdC9galiQQcLZ8Z9HQr7KSg1uMomEQa7h/Wtxw3HOAJjfBsuZjjMs8oE
         VVBg==
X-Gm-Message-State: AOJu0YyjkJou5nIWo+1pyPiZZu0NcogTgER/TBvchtPDr/NjGD6HsmG6
	YzNTovn1uR88k1xRxOP8h8lY6MYzVqZK8tLGT8SJiuiMCjWJ26JRxCLADxfrnYj0Kw5LxY+xD7g
	bRGxpnsDiV82nTXSm0H79gt4ubWQ=
X-Google-Smtp-Source: AGHT+IHGH5+wxFiJIzJz1GrRtKkM3SP8B4KSnxxzJK/OaI7rpcGD7sM8Dok0V6Ggq/eViFkfCqTQmB8kjNnrj++v+Aw=
X-Received: by 2002:a5d:6e55:0:b0:33b:3c79:9182 with SMTP id
 j21-20020a5d6e55000000b0033b3c799182mr5473051wrz.3.1707762097193; Mon, 12 Feb
 2024 10:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com> <CAP01T75y-E8qjMpn_9E-k8H0QpPdjvYx9MMgx6cxGfmdVat+Xw@mail.gmail.com>
In-Reply-To: <CAP01T75y-E8qjMpn_9E-k8H0QpPdjvYx9MMgx6cxGfmdVat+Xw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 10:21:26 -0800
Message-ID: <CAADnVQJhxUdkFrnO3PG=2M1Tt38xD250w+nv2z0OxZsAxfpoPg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:41=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> A few questions on the patch.
>
> 1. Is the expectation that user space would use syscall progs to
> manipulate mappings in the arena?

any sleepable prog can alloc/free.
all other progs can access arena.

> 2. I may have missed it, but which memcg are the allocations being
> accounted against? Will it be the process that created the map?
> When trying to explore bpf_map_alloc_pages, I could not figure out if
> the obj_cgroup was being looked up anywhere.
> I think it would be nice if it were accounted for against the caller
> of bpf_map_alloc_pages, since potentially the arena map can be shared
> across multiple processes.
> Tying it to bpf_map on bpf_map_alloc may be too coarse for arena maps.

yeah. will switch to memcg accounting the way it's done for all
other maps. It will be similar to bpf_map_kmalloc_node.
I don't think we should deviate from the standard.
bpf_map_save_memcg() is already done for bpf_arena.
I simply forgot to wrap alloc pages with set_active_memcg.

> 3. A bit tangential, but what would be the path to having huge page
> mappings look like (mostly from an interface standpoint)? I gather we
> could use the flags argument on the kernel side, and if 1 is true
> above, it would mean userspace would do it from inside a syscall
> program and then trigger a page fault? Because experience with use
> case 1 in the commit log suggests it is desirable to have such memory
> be backed by huge pages to reduce TLB misses.

Right. It will be a new flag.

