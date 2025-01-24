Return-Path: <bpf+bounces-49680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34A5A1BAD7
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2363A5131
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC215A86A;
	Fri, 24 Jan 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg6sj/Ox"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978331459E0
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737192; cv=none; b=ddHp5SdOZWDSpa62dcEO7j3UcufJbCotMeO+5I5O7ZLUGpeMIAWEsUJ9DXMXpgeCrH+BmbhFaQLnkrlsK4JvpakneMe35VzA01ESx9X7IjIqjhTJcARBjicXCAbx70U5YOYFn4KQrqOwa8cKWeALsNQHnX1wQ6lorUpIoy3ePl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737192; c=relaxed/simple;
	bh=ZNqhy3Wcm2npqR84shnCSvtgTBAP9i0t7NnihrwPt/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpEdUF+0R0IL3/NUY21UFrQSux5/2dcMaRPQF8U5qxt/OSeEd9MPEarZG6COq9bm635Y+8Bs4ePuIaPM2O07rmVYOvWazJ2O/JCGmfAdgPYtrs1bhKRCkJ9+fLlon4IHwD2Rz503iSGlJtPpqgka8S1TH2KFUtWmnOVMKwTrQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg6sj/Ox; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43618283d48so16892515e9.1
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737737189; x=1738341989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIOdVq0vV7wf8pNdPBX3WFTF0TOx7BFGfhlZUudS4M0=;
        b=cg6sj/OxRgLQ1uH8kDlLUiSooVvot6WVzg9fbXfzJLFhFfhbzTKYOH5La54Nk2Fy1a
         6ewCepZDajEvzcqvPAZlaVURuwUytUB/WAfesgwyTktNxuEWWER/sJUKlZ44e6GmWXt/
         RqG3phj1vNRBFktfHbI3FbdxC7ipTEiUGEJEHtykZnJgM5o9ak2M5G+W4uPXphEV10mm
         qGjD/LcPDi2ce+6kuZDtIwgOOcWaQ5/teSTojSgNrt0qOfwL7wVwCT2t486HGKp4CyKi
         A4/8I/zEdvNQCxoVnpaKwxtlJ5mlxo1ry7dpHZlm3kb7mID8qDGVGDFkCOar+nFdJhs1
         ljug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737737189; x=1738341989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIOdVq0vV7wf8pNdPBX3WFTF0TOx7BFGfhlZUudS4M0=;
        b=upF0vd8Ma3oQHHNvmFaOWv4FpaI8tP1uUhN0iS6ezpaPSic4nLGIl7xTtzdBEJOfWd
         v7K/tc+ZuMxGe4q/KDUoHQALJiGQod3P6cTTTmA0YmMxydyxdfWz1dTzAWVT4ZQgCD9n
         wVUsD7txAHB2DU6DHYS7r2bLiB0XjPXrm3WoAoh/D2La0+pQrB5Q6yrIKsK/BKTNRvXG
         4ow6g0BA6ETivS02+lRwdHtHiZr+nrSMW2zD9Dm4FYQmCbJPkINthcrjz25cHMqw2CU6
         DC3IwCZwNxS8KwWvyrlI1ETi1rNDlh3Qix1+Fxqc8JToWuC9PZ7R+GpZ8KI09k7PcHMt
         pTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKd85Td6rphIjg0NCo9aKhhaMAx92ipvDADIFhv5/wGHHcw+gPnlufz+jU8VTwrqcQRgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9JvCAj+6IsYeyT4ITYiOjfghRwCC23dVA9YgvyvoKChrsMGhN
	awwwdSUWdhkV6GriRvEJin9TcpuplBVuWl/w7rbSKugQjrVC2hRGevqW2/vTSj64NJoKdV4Dcvc
	zItyjUkI0zNoGZxZPLwtRd5SzEWQ=
X-Gm-Gg: ASbGnctTAfvQYYbo2ZWEKo/CkpHqwBKOAboJcg1dOwp5cJhn5wGI/LYVbe4FvdLy6Xg
	sxpC7OdwkozWJYSjvHs6EbZ7DoflOKUmfUOY37Tp3gG5loSgqIVod6fvpSkB0EQ/6EoTFRV+w5p
	cJxdSrnHrKKiRznwFIDw==
X-Google-Smtp-Source: AGHT+IE7BI6HNRvEYsbjvR7JB35pW97LgmJJTBXuV+FrmneMEc4oxMxZS6v6dB1H6kH/U6SDBGKlBQoEzbsb0fCA/SU=
X-Received: by 2002:adf:fd84:0:b0:385:faf5:eb9f with SMTP id
 ffacd0b85a97d-38bf57c91e7mr30145364f8f.48.1737737188639; Fri, 24 Jan 2025
 08:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <Z5OgvePdlqRoKMyx@casper.infradead.org> <e5c1eed1-3ea2-4452-a871-3308c90e932b@suse.cz>
 <CAADnVQJhU3EYp3fWYcTFtZobJUAaWRQmjjBSw5te9OpUaM8TNw@mail.gmail.com> <2b2e6e04-b91d-4d9d-9cf9-5c690abe6746@suse.cz>
In-Reply-To: <2b2e6e04-b91d-4d9d-9cf9-5c690abe6746@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Jan 2025 08:46:17 -0800
X-Gm-Features: AWEUYZlJcdB9HixE4QFfndGOLwTnL9deAZ-R_-JU658ZMyXYSWK_edNK6hnlkKE
Message-ID: <CAADnVQJ3WCHjPD4EKUK-fdy-hW1rDTD=AwYtrDJ=_RztcGDYFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/6] bpf, mm: Introduce try_alloc_pages()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 8:28=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/24/25 17:19, Alexei Starovoitov wrote:
> > On Fri, Jan 24, 2025 at 6:19=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 1/24/25 15:16, Matthew Wilcox wrote:
> >> > On Thu, Jan 23, 2025 at 07:56:49PM -0800, Alexei Starovoitov wrote:
> >> >> - Considered using __GFP_COMP in try_alloc_pages to simplify
> >> >>   free_pages_nolock a bit, but then decided to make it work
> >> >>   for all types of pages, since free_pages_nolock() is used by
> >> >>   stackdepot and currently it's using non-compound order 2.
> >> >>   I felt it's best to leave it as-is and make free_pages_nolock()
> >> >>   support all pages.
> >> >
> >> > We're trying to eliminate non-use of __GFP_COMP.  Because people don=
't
> >> > use __GFP_COMP, there's a security check that we can't turn on.  Wou=
ld
> >> > you reconsider this change you made?
> >>
> >> This means changing stackdepot to use __GFP_COMP. Which would be a goo=
d
> >> thing on its own. But if you consider if off-topic to your series, I c=
an
> >> look at it.
> >
> > Ohh. I wasn't aware of that.
> > I can certainly add __GFP_COMP to try_alloc_pages() and
>
> Yeah IIRC I suggested that previously.

Yes, as a way to simplify free_pages_nolock().
Hence I looked into it and added the above comment to the cover letter.
Now I see that there are more and stronger reasons to use it.

> > will check stackdepot too.
>
> Great, thanks.
>
> > I spotted this line:
> > VM_BUG_ON_PAGE(compound && compound_order(page) !=3D order, page);
> > that line alone was a good enough reason to use __GFP_COMP,
> > but since it's debug only I could only guess where the future lies.
> >
> > Should it be something like:
> >
> > if (WARN_ON(compound && compound_order(page) !=3D order))
> >  order =3D compound_order(page);
> >
> > since proceeding with the wrong order is certain to crash.
> > ?
>
> That's the common question, should we be paranoid and add overhead to fas=
t
> paths in production. Here we do only for DEBUG_VM, which is meant for eas=
ier
> debugging during development of new code.
>
> I think it's not worth adding this overhead in normal configs, as the
> (increasing) majority of order > 0 parameters should come here from
> compound_order() anyway (i.e. put_folio()) As said we're trying to elimin=
ate
> the other cases so we don't need to cater for them more.

Understood.
I also agree with Matthew comment about page corruption.
Whether compound_order(page) or order is correct is indeed a question.

I'll wait for review on patch 3 before resubmitting with GFP_COMP included.

