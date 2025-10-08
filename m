Return-Path: <bpf+bounces-70573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD2BC3547
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 06:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341E419E0EDA
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 04:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0C2BEC5A;
	Wed,  8 Oct 2025 04:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDrxZhd7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630682BEC26
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898365; cv=none; b=e/FyfgB0OhNXvvUWR1cOE6RbQB9iTksKXZQDzE0ybJNKUOHL8ZTqeKXbw8UQhK11Ez63E5pHf2c0bNnbFevRFs2eO9byBdWg1MLV1BdtuJVhmUIe18Wg5m5VhH/PQQamYx2dek3C516P8SljftV+E5PiBYxzMNMj513VivpC+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898365; c=relaxed/simple;
	bh=Rm3GhlyZsgjNHwG8nD1ukkMMPB/ILNmwuDjzy2VbVTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhAXVDp53dtiFUgJ2FfMoEwmTA/QsAHkohsnpWN9PnSnrG8ozs8IJAxlLQFTpnEB9T6DC2aICxUXPrOVNRaMBr7TN4BtXiD1XU4UhmSkQS530SLW9rNK+853/65CJ1Xtnddl8GaC6JuCaPfO/jBPivZWZweEtr41Td0mTP/otw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDrxZhd7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4988560f8f.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759898360; x=1760503160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm3GhlyZsgjNHwG8nD1ukkMMPB/ILNmwuDjzy2VbVTE=;
        b=LDrxZhd7ewlwU/7+v5hH+trhWFZ8PO/eFe9ge/Rl5Sr5PokQ8ZJ7O0447Q7tC0w3cv
         Jjqh1csIA1Mlyz+FZrTzUtw22/GqPLFrGdpzzk3SDhnii9rnROLSDNfI/5ZxCJdGGfq6
         olA6gnmJ1Qjk1D9Yv+hnk8y1sEnOqmjYN9aifckndFmU/Q+varK2nW9n6a1Rgp2LZjp/
         6soVStwb7WMj95C/B2/gTZBGQHTccZnvb236ciIBBUaF8+5Dcl/K7RHZTD+qtChK6np9
         0752Rs96/JIyR1arQHkPv6UuBOZCa8KkJSzDYZRBnVaU+o/Vz88AaOOzuVCqIR3r0TTF
         tZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898360; x=1760503160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm3GhlyZsgjNHwG8nD1ukkMMPB/ILNmwuDjzy2VbVTE=;
        b=HuhGaOsxIQhslrtKYkE7hpES4sj0BosqKuYkZFpBuRjtG3Tp25yOdOkJdyov2HfBa1
         zYWWzeKq+gd6ze9I6oJdNfzDzMluQ1zRxkNjwR7vjZHTT+OZuX+bCQmFFvbyYcs5Hwwc
         jJR0nunrXJ3rNrdY/1dbCJpLm8llDFkR1rbVSHgLWREsHQiLMeMRD8oqcOCZGL+Fh2/q
         +jcePlO8eG/DnSXaZZONzNKvWN0ZHkqEj63nXVr97JNqqggEOP5DJJsEZqBS3v2X57UT
         r+J8OL8ux2ErpXKgaGIORT2o+TAojPRqsrnvfB6wbDG7YRQMhilXET0FSgCMSL5bcGRV
         tYmA==
X-Forwarded-Encrypted: i=1; AJvYcCX/xEgDZkkVfwDfQDFs5xUvmCkfXzPxgUh3sxCmOQtGgp8+P4xmT0cKcoJJDofzP1PbI84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMTVuqUILxXhZQs49stAO6+wUnMFu86X6p2HjYpHU6PIizKKc
	YbQ2f2jdob2aimFYgbBx+qfnpae8lxI77rNt/GdjMB949Zefcdip7Q+e/XMQsm93o4o1z7i81/E
	H2KvoTGMqlOT53yNOep2+sqSXIyIYee0=
X-Gm-Gg: ASbGncuoigqIPu5MTxtL1KxYT4SiYaAO2AhYXB6jY+9XdKGimuzyEahGhgmxSB5aBH2
	M24FI6Knj57kRTFdHJY8+f3Jt5OmfsdpCGF8hgB0czqPX9tDTsMg+D0uq5AlcfGoQEyZ7b6SVHn
	6UJfLCxQtSw2UsM7ZYfrHsKGXBszahv21NGFueA5kvjCxxEMEihMVHyMZ9zKh7p0Wj+xi4bgObP
	0e4x15D/GSQzk2ZY7sB6mk/gCuYZmvNXOrtsyP8BlOMNE2N5bMw+7XCO2dgcIMu
X-Google-Smtp-Source: AGHT+IHVEHG1C3LKLnJ8DwT6l1r997HA+wzMKAexilSB8QteathZvj8Spsg01noOe1OnIJsIlqfqCOjIexAD1RZW1Rs=
X-Received: by 2002:a05:6000:26ca:b0:400:1bbb:d279 with SMTP id
 ffacd0b85a97d-4266e7d44f1mr925348f8f.39.1759898360484; Tue, 07 Oct 2025
 21:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
 <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
 <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
 <CAADnVQKzW0wuN3NfgCSqQKVqAVRdKVEYMyJg+SpH0ENKH6fnMA@mail.gmail.com> <CALOAHbBzS2RunZzEk8-rkU60M8jKEJ8FwiPgZqNeoXDy++L5hA@mail.gmail.com>
In-Reply-To: <CALOAHbBzS2RunZzEk8-rkU60M8jKEJ8FwiPgZqNeoXDy++L5hA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Oct 2025 21:39:08 -0700
X-Gm-Features: AS18NWC8ZPttD2mQYRSD8-3WnTYDsNM_I1o2QCoCf1odJXXOlkBQmZekv5Q9hPQ
Message-ID: <CAADnVQKLbc4iZDGWbbhqwr8hKhAZhyLjiZuuz_RBd2f9LH45rQ@mail.gmail.com>
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

On Tue, Oct 7, 2025 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, Oct 8, 2025 at 12:10=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 7, 2025 at 8:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > > has shown that multiple attachments often introduce conflicts. Th=
is is
> > > > > precisely why system administrators prefer to manage BPF programs=
 with
> > > > > a single manager=E2=80=94to avoid undefined behaviors from compet=
ing programs.
> > > >
> > > > I don't believe this a single bit.
> > >
> > > You should spend some time seeing how users are actually applying BPF
> > > in practice. Some information for you :
> > >
> > > https://github.com/bpfman/bpfman
> > > https://github.com/DataDog/ebpf-manager
> > > https://github.com/ccfos/huatuo
> >
> > By seeing the above you learned the wrong lesson.
> > These orchestrators and many others were created because
> > we made mistakes in the kernel by not scoping the progs enough.
> > XDP is a prime example. It allows one program per netdev.
> > This was a massive mistake which we're still trying to fix.
>
> Since we don't use XDP in production, I can't comment on it. However,
> for our multi-attachable cgroup BPF programs, a key issue arises: if a
> program has permission to attach to one cgroup, it can attach to any
> cgroup. While scoping enables attachment to individual cgroups, it
> does not enforce isolation. This means we must still check for
> conflicts between programs, which begs the question: what is the
> functional purpose of this scoping mechanism?

cgroup mprog was added to remove the need for an orchestrator.

> My position is that the only valid scope for bpf-thp is at the level
> of specific THP modes like madvise and always. This patch correctly
> implements that precise design.

I'm done with this thread.

Nacked-by: Alexei Starovoitov <ast@kernel.org>

