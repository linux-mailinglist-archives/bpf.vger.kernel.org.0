Return-Path: <bpf+bounces-54085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B273A6236F
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 01:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CA819C633E
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A7946C;
	Sat, 15 Mar 2025 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEen3sdu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC704A06
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999881; cv=none; b=u750q3GGeAuErIE6tZ1EQW+q/XTlhCnVSGR/TchZq2xSeN4ropmgn0fqBXSrGQwDQ10l0oHbo5o5N85K314qP1VwAkYGDtr6rlvHNovTyVUl6+EkIuxAvi4Xz7UUS2oYj4ktDlNFwlT6F0aAGzExRNvV/mq89SOI3ueYSWZTztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999881; c=relaxed/simple;
	bh=c4CfLFZ1mKXC7I/n7dd3yWZpbXHGoSRioKsbbASS0Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfDPHT188+J137EjzUAXDo7bIERHwOfsxzpSmX2TjxsmMp9xX8yKSkur9TpZLijcaVaLuXPP4NwarLji7vNMnvyYfTjGCtgOQcoTbscBwRmipKWA1skflPuGuOXdv1V2yciQz7nWqrP3pbzw8P2ETQ+wHKx+lMr4qTE2kzJhDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEen3sdu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so1566474f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741999877; x=1742604677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfrltfsopWOEkDdkjziSnRiumJrMPq0vZWhc3RqItwo=;
        b=gEen3sduR7OwvZRe1spkR1164ovkrYrZ/eJWHIZNbngtt60STLI4EymC05Kjx/mAYb
         X92W/2LX9kBgjFrZAE3IFHRQ7RLX1VZsx2I/5mI7o7Y9CO/Z5Q0R8Cjlj1kiYQBkBmyw
         JThe0Y0z3UwYS05et+LHyLEXC9Z9c4L+pGHn4nfqTLGCbLhH1gcHpZUqgalXOD8mf9P9
         d9zCZHIm5jCPlfFDLEWHKOuTaI7X00w498dOVKTPb3LpWPqh/lTmx7fp/cT6pAw2w3or
         BC+ie4InR415QKrOdgmggEX9n0qI1EQTBHbbXtcGzcRhDiCpiS2kqqajOAZ8mm4SwICo
         REIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741999877; x=1742604677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfrltfsopWOEkDdkjziSnRiumJrMPq0vZWhc3RqItwo=;
        b=QJyRB6D668Cri1KmrJXkJ99neAxP3Ih0OZXQmkz+bvMjNyU6MbViZSDEtZuA0Jk5jW
         HcemD++xuFfsd94PJ1VrYswx2RqSbBqQI08F84mrqo7YlH4k4b7kRLQw47CsJteXEdBV
         rYl/sPgTvrqCd7bxY208szAGWNuVTSHqn4F2/af+elwq161JghE+/KW36cnDlZai47pQ
         pFux3MWRyzQHUcPDq47gpsrekzjcf5H9cvturFWICsuj87x3F8hgMWxrSkMN5aK2vsXd
         eIQoAX/y76LDZQQBaOTYTCbWr6BvLXrgqztsNMccN5TCcx+osh89qT0Ufd9PhmLs8Une
         1L9A==
X-Forwarded-Encrypted: i=1; AJvYcCVuNBw+imJ8NjVvpxjQaqk7AlZkNmNgodg/Fn+cpqKvR/3Yu2WvkYYrcNiSz5GM1Fvkhhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+DgoZF4iwFK/kI1RTQKg0A7Mds3P20DYjXHR3fWWZd0ne2Oy
	7J7iEvvJprnXJYK8OznWt/5h694+b66paWgAHQtv6cRgiJ80HnLrNrL6qEafUkRJec67F2IDQsN
	j+eLSKThnQ6o5U3ZE3gPjyDPeVFk=
X-Gm-Gg: ASbGncuzzjO6bJNjQp3pjcbAl/oyE4uYpfc31rzqwDx3pHvqafePlarVIhgunSgkVTg
	RgJWQAWvMtQ/FlzyHsu5dJe33LH1cBo8Og/Wcj8lAvIod7yUPOYdXYHIlCIhSRoe2hZ8kKyIakY
	CUh7RrwdEfm4k4lNMLZz7Vfnv9sGOWhIYykYbLgbU00Q==
X-Google-Smtp-Source: AGHT+IFS3nOsiYjzKrdQuDRfcPwmywgny0tg84IsYCcaHKUdTlTlGBczedIn8pKY0TIKQ+/ZOfpsJ9aKkUPW2YTQdwU=
X-Received: by 2002:a05:6000:4012:b0:391:4bfd:6de with SMTP id
 ffacd0b85a97d-3971ffb3a4amr5885661f8f.46.1741999877524; Fri, 14 Mar 2025
 17:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com> <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com> <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
In-Reply-To: <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 17:51:06 -0700
X-Gm-Features: AQ5f1Jo6apmq0POZDPJ9QQGxvg-t4s6RoF24DdcgRda3D2gW12kCapbDmnMKnoQ
Message-ID: <CAADnVQLrk1fcvLOgsoZR-+mcKkQ+-APEyT2yCFzGkxcw_6yURA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 3:00=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/11/25 14:32, Alexei Starovoitov wrote:
> > On Tue, Mar 11, 2025 at 3:04=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> >>
> >> On Fri, 21 Feb 2025 18:44:23 -0800 Alexei Starovoitov <alexei.starovoi=
tov@gmail.com> wrote:
> >>
> >> > Tracing BPF programs execute from tracepoints and kprobes where
> >> > running context is unknown, but they need to request additional
> >> > memory. The prior workarounds were using pre-allocated memory and
> >> > BPF specific freelists to satisfy such allocation requests.
> >>
> >> The "prior workarounds" sound entirely appropriate.  Because the
> >> performance and maintainability of Linux's page allocator is about
> >> 1,000,040 times more important than relieving BPF of having to carry a
> >> "workaround".
> >
> > Please explain where performance and maintainability is affected?
> >
> > As far as motivation, if I recall correctly, you were present in
> > the room when Vlastimil presented the next steps for SLUB at
> > LSFMM back in May of last year.
> > A link to memory refresher is in the commit log:
> > https://lwn.net/Articles/974138/
> >
> > Back then he talked about a bunch of reasons including better
> > maintainability of the kernel overall, but what stood out to me
> > as the main reason to use SLUB for bpf, objpool, mempool,
> > and networking needs is prevention of memory waste.
> > All these wrappers of slub pin memory that should be shared.
> > bpf, objpool, mempools should be good citizens of the kernel
> > instead of stealing the memory. That's the core job of the
> > kernel. To share resources. Memory is one such resource.
>
> Yes. Although at that time I've envisioned there would still be some
> reserved objects set aside for these purposes. The difference would be th=
ey
> would be under control of the allocator and not in multiple caches outsid=
e
> of it.

Yes. Exactly. So far it looks like we don't have to add a pool of
reserved objects. percpu caches are such reserve pools already.
In the worst cast it will be one global reserve shared by everyone
under mm control. shrinker may be an option too.
All that complexity looks very unlikely at this point.
I'm certainly more optimistic now than when we started on this path
back in November :)

> But if we can achieve the same without such reserved objects, I think it'=
s
> even better. Performance and maintainability doesn't need to necessarily
> suffer. Maybe it can even improve in the process. E.g. if we build upon
> patches 1+4 and swith memcg stock locking to the non-irqsave variant, we
> should avoid some overhead there (something similar was tried there in th=
e
> past but reverted when making it RT compatible).

Sounds like Shakeel is starting to experiment in this area which is great.
Performance improvements in memcg are certainly very welcomed.

