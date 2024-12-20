Return-Path: <bpf+bounces-47380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1A89F890F
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 01:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B7B1895319
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5DA2594AE;
	Fri, 20 Dec 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKiqNVsk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66513800
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655332; cv=none; b=hHC2JRG2PAt8KJ2e7ZMKS1jJ0HM4RYPBZ4fWGxt8zHIQPHGDPl6tpnQFy7KX62ZZDlkRXqVVPNSjwjt1YRO863OAWrek9PRzyRIngPkTS2LOv4XtKtI6C0Iwa7B3hGLYQKzBDL6dI4ybAyzcmsiPAXlxSclbOILRGmVTeE0zXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655332; c=relaxed/simple;
	bh=bHhmf9XVLXmKXvlBWDnvJ/nk1pYg5VVHIGvLzJQcejQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8PvmdXlUWAWTC7LiU0csyK4JrdFA3s9o2ixGUuxw7+zJgyXBkcJk47lTOZecNTkyqqUeuLY74apKm2KNXvpq4V39jrT3sN2DeBCj52Wvrmy7OdsQFAL0c9vqLrowv7k+0ZmJbz/C9JBg1vJNwxgmSVDV1AiU1BoUO+1w+q61mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKiqNVsk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso9739915e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 16:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734655329; x=1735260129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHhmf9XVLXmKXvlBWDnvJ/nk1pYg5VVHIGvLzJQcejQ=;
        b=KKiqNVsktqM2/CQlGUzJEH8E5aJ9oJfEK7o1robo4Pp3gAzhSEGC/NXRxd4LwlRRSe
         CQw6CbKsg76UXl4MdGcZhso4VCuDXd1Jb5UVwWCxBmOcqu859j34Xl+U8CXsSO3dxIqK
         oxLf4ccOSCDmJDtThHwwfkgQvU7M/lYT0rJNSzjhO/U/vP74TT4lJIet5Z/8ofJp/VM7
         CY4tWFiSJiWT9zmBFLLMAREHkHtrag63zMq51M7kERbGSF5ytQg81LAyR/MwrFpFsH2K
         6DmE573DLsohv2JWhDdbg5C7ZqUXCU9TjN24ccmtJ6/UEi/fDVavPezymkRfyYh4R/H9
         xKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734655329; x=1735260129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHhmf9XVLXmKXvlBWDnvJ/nk1pYg5VVHIGvLzJQcejQ=;
        b=T1PGtDvZ9QJM5KslTIRPL07AdH+qnJBgCQl2r5p4ZFzpNGb4aQWWYvSaZsbrKGT3Uc
         Gkfh0OtefTX80EXOQ8Fo7ZxPVvf6cppyggW5//eEn7zaMd16wfWWMAOBLDwAcEtqwJmw
         v1CUQM4SuddrncQURPyGAWj2/G45HB2m1qJUZK54RG7odOybHOnIcIlFis3Ounb+UXHV
         pMc30+FV8Zjxhr/2pV3ghqGuyvqRonj45zSwH0Tx43fzT/N3XZ/089H9m4/rZVLHNaQ7
         8gsXIkKOTjSZTLj4RW2/h/J1vkdh1lnrraC8/J6d+I50qpzkfrEBm+KUOKqZkGDKNd3C
         Z0+A==
X-Gm-Message-State: AOJu0YzDj15teqm8Ix5lu/q6BpCrMFhHykHrC7yjdmhpesQvQ0EBfs/g
	s7Xl9kOROPJh8DPf6uQ51Qrz1TJ+pWS8dhYmZ94UJvJiSUV9uLqEJiw8ETsnefP9sr4mgnMGeGk
	3QFXAv7lMoBxYfATpLO6Yib5mdBVi0n6r
X-Gm-Gg: ASbGncsLJR5Soeto7VbmwFD5Wba5WESgcXVhljW9eBOEh3OBOu4nTTdkS8zsxM03T3n
	hPy5inXBHV9J+gp/7JpTMkjRLN/7P3KH04rwx3g==
X-Google-Smtp-Source: AGHT+IHUD+JTXe0nVUd0lrS/9fxN31nBybiiYbiKwmE7v8jMPU8wOAR0acoMLQ50lfVXK8BRPXNVGZZ1sgjqS2WlxeA=
X-Received: by 2002:a05:600c:4f51:b0:436:1b7a:c0b4 with SMTP id
 5b1f17b1804b1-4366854850emr4860785e9.1.1734655328726; Thu, 19 Dec 2024
 16:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com> <Z2KyxEHA8NCNGF6u@tiehlicka>
 <CAADnVQJDTjKJXzFm80UwFpV1gJHgboQ72eJ5hOai3seJ6Jf-iA@mail.gmail.com> <Z2PHt6-rdkC3f_tQ@tiehlicka>
In-Reply-To: <Z2PHt6-rdkC3f_tQ@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Dec 2024 16:41:57 -0800
Message-ID: <CAADnVQJUZVqWcqVvCikKxAhiSsyWJ0D5ALa_Yz=gtiS0F=QTYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Michal Hocko <mhocko@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 11:14=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> > As I mentioned in giant v2 thread I'm not touching kasan/kmsan
> > in this patch set, since it needs its own eyes
> > from experts in those bits,
> > but when it happens gfp & __GFP_TRYLOCK would be the way
> > to adjust whatever is necessary in kasan/kmsan internals.
> >
> > As Shakeel mentioned, currently kmsan_alloc_page() is gutted,
> > since I'm using __GFP_ZERO unconditionally here.
> > We don't even get to kmsan_in_runtime() check.
>
> I have missed that part! That means that you can drop kmsan_alloc_page
> altogether no?

I think it's still necessary.
kmsan_alloc_page() still needs to do the zero-ing.

