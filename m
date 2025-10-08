Return-Path: <bpf+bounces-70569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5058BBC3391
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 05:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9223B1AE6
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 03:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7A29E0FD;
	Wed,  8 Oct 2025 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izS7O8Nb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DA29E109
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893943; cv=none; b=McIl7VjlB8TlByk4Ez+Q1kVeqQYVm/y/ykN07PukLBLO0UixkKUJ/skvFqK8EvfkN5dAvgDTscSFlXJCDPH+bLlSdgKBJ8Deuv67v+x9eCfviLKvCQxcQnm/6nmyYULGH1tPNru3sDo5JOEDZ70qgpyNXrkUg6N2+VBMXSakteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893943; c=relaxed/simple;
	bh=Aq7/8dQHrmRmSKQ6xABjHJxjL0wL6AjJEcMgMgkiMrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMyvNk9PN+jv14bGeSm8kAVdOb2d+Csykh0g1440g3S03z2eDmqQzYV0CmvCMj3bGTycguuyiyK0EC5AKbKDhGeqJJAKDVsjaIK4xa5lRlaccX0/IqkDD68ei5a4Ah9gBqca06vN5dkWHnytHKUAFdetsG4GqDgIe0u5EPfhy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izS7O8Nb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4958684f8f.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759893940; x=1760498740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq7/8dQHrmRmSKQ6xABjHJxjL0wL6AjJEcMgMgkiMrU=;
        b=izS7O8NbWYd+JSuU5aTA2hEJWpUrKX29TsPeun8AgpoaWyq3lQCmWi2HlRDzFg4PU6
         1kBe4Wl0BsGB7vMbK59U1/S3nRlXIwYrHCaRwg0TFEiVfvn0z587IyJhv1+IZc4MaV9o
         sBr5nybTfNEI35upT/LeA2lGAiIGSEFP2EkH4ETqyVGyok6LsvovkIRWpAls5vGuWkyk
         kbp6uAbjs6i2nKLWtHcd+s0SdepO7n13cLWdp+XwwlSRCLM+p4jm7AwQxb6Tnwpvzo1C
         7iWmbOEdzCBgm6MnTt6cn5QO+qGgelEt6FW4cyKxeZuPUnYgRw/Jj47WzzyYxrDyjk20
         XoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893940; x=1760498740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq7/8dQHrmRmSKQ6xABjHJxjL0wL6AjJEcMgMgkiMrU=;
        b=saILwuEUPMqPwpDuKSxgw+Wab/IoE1QNkQE7KfJwVwmUFnIxYGKLIOSUup5xUrLYUr
         BpNO+b7jVXvLN9/NTRqjqfhQeo/MYzERWR9FubS52nnmncdg/h2sqcVMZs8uZdy55ttY
         nx13uuh9UiIJV2d1wqnm+j2CVjjk/NQwFjKRIIX8ZI2VQV2/uyTSqNH5nHJD6F+TEC/P
         6K7NQo9kjZaWFLJ6v1X1y70TmmU0UIZH/73oB102wYuKL7H8BaPbPmIP/EcPhxkVjpis
         n41XnNG2gYdcUc/rj1e+BW+IAoFPIPNhCrTQEH3MTkhBpybafI922SWwNazGkmgGlU3c
         lnJg==
X-Forwarded-Encrypted: i=1; AJvYcCVPMt0EUYC2/BQBqi/JS8MHxAsQvn5MgBxX5WCwvWz1p+zr0lsWzdWPO7YwJGh7ZOpCBnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9O7DGWkPVrjkcON/6g/9t3Gl3oaV2Eib1pJFpQlJhSKf6bxWd
	OHXIhI9MvDa8kjPD0wy5VYprroDtdvBbpPfHvhHE1c4PGurh6HZsfqkEdmDHicMXJgtpJ6AoA3s
	gUsH1aCTbOkrGqU9RfdP0K6rAfHrgzfk=
X-Gm-Gg: ASbGncutbKtAkBrA1rimgr3Chv8TQ39I7LGLgF8Nb0rfigEdVlY4DQaRvjQD3scpcVB
	EOXfFVQe7VaWvDeDc/1Q3Cd+7M2knV5s4XuuHtpFqK0W4UFOuOxcdJGXvuOZVdagMU8G6LpzWrk
	uUKtfw1xYbEjYxDQsnscW2rzp00nLOdA/BBTOA55oj2X8+AVHh8rnUMEWSYH5DaNrtupse3t7T0
	k962VJoIeKLEOyXd10HZU/tJFXf46PjJ10MvKzKXOB6ypTHL4aEY6OXnC3bLhWu
X-Google-Smtp-Source: AGHT+IHeswXWseQTzOZVDgPDpClSJjRdYqa3Gk+TNJHyXQ0PCdIukEVOo3TQExJxoJHeGY0CBioSlo3kBJaFQswByNk=
X-Received: by 2002:a5d:5d02:0:b0:425:7c1b:9344 with SMTP id
 ffacd0b85a97d-42666ab87c3mr807115f8f.15.1759893939583; Tue, 07 Oct 2025
 20:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com> <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
In-Reply-To: <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Oct 2025 20:25:28 -0700
X-Gm-Features: AS18NWATPwVk-W8hdC0xrQiJYrJaEbx7Di3QWbBv11leFl2ACmYaQhhy44lYgpI
Message-ID: <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
> has shown that multiple attachments often introduce conflicts. This is
> precisely why system administrators prefer to manage BPF programs with
> a single manager=E2=80=94to avoid undefined behaviors from competing prog=
rams.

I don't believe this a single bit. bpf-thp didn't have any
production exposure. Everything that you said above is wishful thinking.
In actual production every programmable component needs to be
scoped in some way. One can argue that scheduling is a global
property too, yet sched-ext only works on a specific scheduling class.
All bpf program types are scoped except tracing, since kprobe/fentry
are global by definition, and even than multiple tracing programs
can be attached to the same kprobe.

> execution. In other words, it is functionally a variant of fmod_ret.

hid-bpf initially went with fmod_ret approach, deleted the whole thing
and redesigned it with _scoped_ struct-ops.

> If we allow multiple attachments and they return different values, how
> do we resolve the conflict?
>
> If one program returns order-9 and another returns order-1, which
> value should be chosen? Neither 1, 9, nor a combination (1 & 9) is
> appropriate.

No. If you cannot figure out how to stack multiple programs
it means that the api you picked is broken.

> A single global program is a natural and logical extension of the
> existing global /sys/kernel/mm/transparent_hugepage/ interface. It is
> a good fit for BPF-THP and avoids unnecessary complexity.

The Nack to single global prog is not negotiable.

