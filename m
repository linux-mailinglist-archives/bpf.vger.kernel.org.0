Return-Path: <bpf+bounces-45380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3EB9D4FCB
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999A4281D38
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB116A397;
	Thu, 21 Nov 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrA0ehL6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185513AD3F
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203329; cv=none; b=nKOIyFOEfH2HY9JAEmQxfhzdJSwo0/ALXFVtbCUrscyQ8Gh57tmZR3HOvM7jU7LSRKPytK2rxT0YtHFmW/Yb413DpNvC1f9Bid170aNE2o4FtaqnlO381+Wbv4QKyXqUYurOJjSbtir7b71PufdAZVg8cyBpabqtnZVRfp+o740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203329; c=relaxed/simple;
	bh=SsArjD+1glKC3LFuUTU1qcWsOXBbI35QwXJjYvQPPgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLXLSoTAuHxTomUM5Ye6zp4W3AuC4Xqi0g6rOH2GcTpcU3hKpA0wWb2atitB4nUXa2WnyKXi54hZi8vEY6IF3QQjKGb5zS0dIRDL1lS7SVQzsvTbOL2jCKeaXS4qW4trHtz88z/MaUZYaA4lH04GFdPvxQCRSaXTHgIfPl3SEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrA0ehL6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460969c49f2so310311cf.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732203325; x=1732808125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=547IccmQdfQpz/uAg3RPtdIl621CchRTsFZX3/wSte0=;
        b=LrA0ehL6FTKR5tjVH6H7Sz1LsI2UZxFCr7xYy40jxgryu6zR+aFZvSqmA9N9f5WCz2
         DJLxu053DEtZRDaNl3XQFC7VO8uV78F7xuNwvJXBz0OJsw5PgxKS0poXzu94reKRWxfm
         ry/pGpd8aAvjCW83om3onFTfX9EqavzbXADID/DMmfphL3zwBF6UULv0/Jdp/cKpR3MW
         Unw2X0eleCHKBGMQS17yQncoihX8fdf2SHUGXXew/rnzGuAAxpPkZl93Xs8ujHAsDPWX
         4IY4tUCljB511KYHE4agp51sowqB4Oo9+rg1GOtWhccOc5KlpMYh7Gy0GS95nk/l1ENx
         mW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203325; x=1732808125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=547IccmQdfQpz/uAg3RPtdIl621CchRTsFZX3/wSte0=;
        b=hAvOezrxRJ2Wjv9hQp+rkJluW6HOUweCjmQnz6EQs4mBEQablDCE9pur1fpRvTWtFn
         J/hJU3jdgs3r12tRRYThSVTNiJMEsBgAJ37a+jiQqHfUiZL0sN5eY21BZgQhTZbL9bav
         RcDLbOMP3QhHyt6hX083JKKsUUk/wUUiZ8HNQZTZ75z9oz5ihzQNYFFt+sJ7H5a+4n1q
         oPfoIGnsIAb/tpbTNnJLQEsBovLgpMZFH6OcvqgnVR/bhThFfbnBw8sL3CkeU5hzvJyD
         lAU2JKXLC5v+Mg8m7xnzwco8yNJZDJgLVrZLHRCo/O7ZLWDjtIjqV1kiS7qUBf2cDAXK
         ETmw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZyfOBno6DBeQ2rcvvcWmKgV9pJH9l1uTgVUGx3SnLBZYnvzOSkDfjXDDA8sApJTqHUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxBIICuE4z5WAxjC9BTOvLz4nZEXagueNMqhL8jq+vADCOMOW
	ywlZXGYi400yhpCU+9PfdWLC+neNQ75HIDrcdEtf2DBdjIgzDyShHURWLE/uWPVdPiMVpuHWHZ3
	iNm/yOiNndR0zH2zUt0hwqFIN1/7XfLe8Wegd
X-Gm-Gg: ASbGncvXAEoOXh5E5W5IkQkqrSzPClbbeq/ykqXV27KTYdlkExK4PteyFtrpzsaPVVJ
	xrc40kEgsbsOlTpehf0b2FF2Xwgt0VjKtyI0jfWcDKeJV+llVNmh1muZq+XX0
X-Google-Smtp-Source: AGHT+IFADvU4IPxoEGDBvsiWv2fnt3CEBsmaslZcEQXF5z8gP7iOsIe3UKpqtmvlizSwxHzRxnFWvsa1H0vOdEmntPk=
X-Received: by 2002:ac8:59ca:0:b0:461:6e0a:6a27 with SMTP id
 d75a77b69052e-4653bd848d4mr96191cf.20.1732203323364; Thu, 21 Nov 2024
 07:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-2-andrii@kernel.org>
 <20241121124011.GK24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241121124011.GK24774@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 07:35:12 -0800
Message-ID: <CAJuCfpEBJsR803Ac-cwN0MWadzWW_WKZchaexdJauYETaww40w@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 1/4] mm: Convert mm_lock_seq to a proper seqcount
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 4:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Oct 27, 2024 at 06:08:15PM -0700, Andrii Nakryiko wrote:
> > +/*
> > + * Drop all currently-held per-VMA locks.
> > + * This is called from the mmap_lock implementation directly before re=
leasing
> > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > + * This should normally NOT be called manually from other places.
> > + * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > + * *all* VMA write locks, including ones from further up the stack.
> > + */
> > +static inline void vma_end_write_all(struct mm_struct *mm)
> > +{
> > +     mmap_assert_write_locked(mm);
> > +     /*
> > +      * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
> > +      * mmap_lock being held.
> > +      */
>
> You can write:
>
>         ASSERT_EXCLUSIVE_WRITER(mm->mm_lock_seq);
>
> instead of that comment. Then KCSAN will validate the claim.

Thanks for the tip! This one looks not critical but I see there are
more important comments in "mm: Introduce
mmap_lock_speculation_{begin|end}". I'll send a new version shortly.

>
> > +     mm_lock_seqcount_end(mm);
> > +}

