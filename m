Return-Path: <bpf+bounces-57605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E646AAD2D4
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9225616CA60
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3561482F2;
	Wed,  7 May 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaZZGMi/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2679E1
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581634; cv=none; b=A5Z0j/AfHtRaIqhDuYGI4g0l1kUM7FAtos0ZYjkezjluO702497nRa3c2qVwPHfqZR/ISODJTBlnVo9ryFHa6DliNRqCMjvg3zusNurSt1rNMFWlvOgItHwbSSikaQVL5+CI6XiJMm/Is2YQBNsPkCuEpGORV3zb4IAbbLejxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581634; c=relaxed/simple;
	bh=maTjyUiNxcd3tvQKfKzU0u/dUNDBsFElofAaKfOnP3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSh4Xq54DFbEYeupGGw7zd4Yv/sVAQHFyVw/q1NbgHNk6SG6pjrP1O9OezM43laGMKkHDQUM5KHZdhKKQsWe4f623ww8nBqF1QooT33r0k7E8Icd0Hu0tA10wl2oUpZTMFHwghtqBWuDhVrUxrhkOU0mEYea29WOWPPQvyybL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaZZGMi/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso261545f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746581631; x=1747186431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maTjyUiNxcd3tvQKfKzU0u/dUNDBsFElofAaKfOnP3A=;
        b=kaZZGMi/hD+BO3KU5ncBT2TrVUYpY1FLGBnU+vUhJT1x3O7yCmaPclN6DJ//NNV3sW
         PHc3WBT7K/VLvUGXzcJNLYgEe8cIk8HNDpgJjZXi2lCAyfKxOFJtaoQjDIoc0rcbYRc5
         P+iQR4kGOtb+lEwgt66YcB6nL5acxrbizDxgWbFDefRx7FxrdG5yxV+NfXNcUkwDjAjw
         qlQzqslXoHef+1RHjwPmN/3EvA4T8mClQK70Kf1N8RTtYPuORqlY8oo7bDIfImhEhnZp
         URtaoEJHLsjbUZKTsOX0KO8gIvVKuRgFdUtUjvxeWLN/2EW3RHDPBiJEW1RA89zNnH/q
         lImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581631; x=1747186431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maTjyUiNxcd3tvQKfKzU0u/dUNDBsFElofAaKfOnP3A=;
        b=nla1AfWaXCaXbtfK06GGoIORfvvi+onuTyHPVLUo6rQFyfQxsoY2maeARI7hDTr9b8
         owLR9TWzQjNhs3ct39CwvasCtmoMFhl+cEIFks3T1hihI6veAC5eIfGSRqmpwoAapAwT
         tV3Q3fnajMbbVnf14sfeejGABhC838YlJfKUzYeTngNRW9KdyGpEewm/cIl4kSRSJhUd
         cQaF28O6zFw0sryu/uJAAa0MbKUIAnttsu9DhicO3dWOjlfosyjkS1bKjW2nc4GlVbO3
         RG0l83CMhN1BOLugJxl0e0V0gFKgjD4EtIQ6KkJGnCy0fkBwuv0+fig+hJG3Y5qXHw+h
         YVBw==
X-Gm-Message-State: AOJu0YypQcNTWDv7vrMycaaK7xX/GfsmR9EQIVzuSmQ+0uVqJOlpuHDl
	4wC5xQb+qpKjHNxJ0+JscpVbKrlQeMyrf4HRenFzAy9CCg3pOEuzdRTFhiW6cMRR/JUt1FTxOh5
	IFW4sC7N0oTNDL36Z25ZuYzUzcww=
X-Gm-Gg: ASbGncuEJeH9TSA/FMRNl+I86N/lNcm3CW/Mwo98T5z0d6d/ys0c000HvRsqXaUKkMT
	wg5IRGTmmFnIuhVALZ/s/XPfwEWN7azWe87Be21YZJWtHElcfVTUrJV725XUupBXIRXPypqFbdu
	4PtLK78tFKosNvCAJLL3DUi3ra6YPZ9hlWyJ6RLbffwx7Fu9g9zA==
X-Google-Smtp-Source: AGHT+IFEPi7oh+x6E7M9tKFRCM84BhMer8ejItmikmAIiY4/nRMwLByQbAvDz2cXAmPujCmxo4haDkaveJriCcMJ2E4=
X-Received: by 2002:a5d:5885:0:b0:3a0:9dda:c2e2 with SMTP id
 ffacd0b85a97d-3a0b53eb0b8mr903829f8f.22.1746581630461; Tue, 06 May 2025
 18:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-6-alexei.starovoitov@gmail.com> <f70740d9-5b37-48f1-bf60-653332085696@suse.cz>
In-Reply-To: <f70740d9-5b37-48f1-bf60-653332085696@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 18:33:39 -0700
X-Gm-Features: ATxdqUHp3PFOseewnhmEgL_lUuxY8YaPU7QqQjAt5xbagmP1UBdKa67T0T-AVSQ
Message-ID: <CAADnVQL6QYijLsOwEY75N8S0t6xx9fKfy8TXbH_OwX-L-0GE-g@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: Allow GFP_ACCOUNT and GFP_COMP to be used in alloc_pages_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 1:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 5/1/25 05:27, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Allow __GFP_ACCOUNT and __GFP_COMP flags to be specified when calling
> > alloc_pages_nolock(), since upcoming reentrant alloc_slab_page() needs
> > to allocate __GFP_COMP pages while BPF infra needs __GFP_ACCOUNT.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> I would rather see __GFP_COMP implied as we don't need any new users of
> high-order allocations that are not compound, and alloc_pages_nolock() is=
 a
> new API.
>
> IIRC it would be more important in some early version where
> free_pages_nolock() was different, now it just calls to ___free_pages()
> which has the tricky code for freeing those non-compound allocations.
>
> But still, I'd really recommend that approach. Note __GFP_COMP is simply
> ignored for order-0 so no need to filter it out.

All makes sense to me.
Will make __GFP_COMP a default for alloca_pages_nolock().
From the bpf side there is no use case for order > 0.
I'm adding support for __GFP_COMP and order > 0 only
to call it from alloc_slab_page().

