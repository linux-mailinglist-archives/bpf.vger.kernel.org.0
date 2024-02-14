Return-Path: <bpf+bounces-21926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5BA8540BD
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC231C2687D
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB738C;
	Wed, 14 Feb 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TavFXGML"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8E7F
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869673; cv=none; b=kUHR/pdjScjxxkdZi/UxaQGW5Sfxee8ID2u0q39fVqbxgwn04xbC7Yy79LoH3LEGB+2jwow4L/4OHV4t/kedN3QKTkfAAKnDXYl2Wliu2cqugS66s+WAlX76EIcaHpZzUfrwvyEfCKlRWWPsEv8TarnSlMDxKB67qhQwG2QgD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869673; c=relaxed/simple;
	bh=/2k88/yxm7fzHtWywI+VJqjaSVwvWn3CQn1lFucmC30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSa2UWo3Mhu6gS35QUCgXGZ6UWr5G4Xo51krQAEjzoSLXPfPh60Zt/aW3np22iBoeLKRDhW26uC5bZliyKLQO5igiapWMzi1EYd0fD3wCouyLlbkuPZwZXdjcnlgwKNeN8jkxr7nsNsZKrovzsC1ratJa6P2EZS/pIdedoQ7efw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TavFXGML; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so113905f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869669; x=1708474469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc+O9q6hIgFG10VrfDiFaXzJXDzf9vcNE39s4lLSzCA=;
        b=TavFXGMLycrhJi9EK6rcq3j7ycXChFyfm2841d7RiisEyG0p+hCMu9UUrNePX8jnJx
         a6pEWFHMSf/Mc/xQFngYD0rAq3hLU91muGFqgylICMkxtU+lYyNIHGyKMuRBHvnWwRSw
         iQktFwd1xXAi2VnU6JgCO6eCPYfmtnhRgZEjPlhMUey+snHb4vTyNci6itt/0ZNCwnlt
         +GemtkkbOoqVl7Sh0+Q6ZIFV2UXoQsLzrRznL7i7dU7eOM6QDDNPXJfGVaOgCkEk5HaM
         2Dg26gmnRoBsByJNjv0rFdF8KJbkIMjwR9vQWsJwl3vwqLGixB/KIaUvbJt6aFPE2lDT
         tovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869669; x=1708474469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc+O9q6hIgFG10VrfDiFaXzJXDzf9vcNE39s4lLSzCA=;
        b=IXgvHS3tk3fLmclBT3UTT/crWtOtOrArNNlzY8p/v23SrNpN3HTMpUXqFeWi99Ek3J
         EWuj7N/oB+eoj+T1Am0dBI5H9DkvU9AQMkfgsJ0UYxFAFgIS3FrhN0Vev754IN0Zw2W0
         afTUro0ZB7Ja4FaF4S7A9zsgPx8mXtA3Bk8pPh2YVg0G/qCgnChnmg6UONY07LZ9WZaJ
         tSXLqchGIdUVEGMgHX0LtBGUGga1E4z/G/XaWkeYZz2WjazGpMOHkMq79jOh3vuFQ8K3
         nqTn9KkwXJEUCwdmik2Kh8zsHcjcvjfqbyPN579izDOkSwahFKGKdpZyDrFiuzJGWLz7
         B1YA==
X-Gm-Message-State: AOJu0YxU5j3MKH0D9HjATXCNq/tDD75C21I1KOTWc/YsEvEepHnH6Kun
	qDM93pjbrqKz8gnr7kkA3/5+xxdukkdCILmSEvxH68gnkX8Ay80K3LxMUsznlVtvXw/g/39evkA
	Mr5FYLlCn6kyp2GLxPS22dnlRQrk=
X-Google-Smtp-Source: AGHT+IFGl/Jw0Ab1n+hPkLoPWIHoPEA3rQXbNC/eTiiIsKH4OYhHr6xkGRvkjpitqEAmDWqBjdoWqTed/uki1opGMrw=
X-Received: by 2002:adf:a406:0:b0:33c:e1d3:6e8d with SMTP id
 d6-20020adfa406000000b0033ce1d36e8dmr275672wra.30.1707869668792; Tue, 13 Feb
 2024 16:14:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com> <CAEf4BzaGT3cSVo=XsD6d4bgR-8JVx8z=Pgi9RkdHseui9MPMvw@mail.gmail.com>
 <CAADnVQL_92=DQovMhcgjjN-aaLVERU9HGd1i=aGfkxe2pfSveg@mail.gmail.com> <CAEf4BzYX8=nYcJQEuz2L2X3+vQKDezRGyJM4wVQaXyLbhLuZYQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYX8=nYcJQEuz2L2X3+vQKDezRGyJM4wVQaXyLbhLuZYQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 16:14:17 -0800
Message-ID: <CAADnVQKA3jMA-ofMwPfBkEYrdYmE7txjQ-wNQU=W3enYdAk+rA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
 > > > +       apply_to_existing_page_range(&init_mm,
bpf_arena_get_kern_vm_start(arena),
> > > > +                                    KERN_VM_SZ - GUARD_SZ / 2, for=
_each_pte, NULL);
> > >
> > > I'm still reading the rest (so it might become obvious), but this
> > > KERN_VM_SZ - GUARD_SZ / 2 is a bit surprising. I understand that
> > > kern_vm_start is shifted by GUARD_SZ/2, but is the intent here is to
> > > actually go beyond maximum 4GB by GUARD_SZ/2, or the intent was to
> > > unmap 4GB (MAX_ARENA_SZ)?
> >
> > here it's just the range for apply_to_existing_page_range() to walk.
> > There are no pages mapped into the lower GUARD_SZ / 2 and upper GUARD_S=
Z / 2.
> > So no reason to ask apply_to_existing_page_range() to walk
> > the whole KERN_VM_SZ.
>
> right, so I expected to see KERN_VM_SZ - GUARD_SZ, but instead we have
> KERN_VM_SZ - GUARD_SZ/2 (so we'll iterate GUARD_SZ/2 too much, into
> upper guard pages which are supposed to be not allocated), which is
> why I'm asking. It's minor, I was probing if I'm missing something
> subtle.

ahh. you're correct, of course. braino.

