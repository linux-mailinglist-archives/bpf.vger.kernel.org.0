Return-Path: <bpf+bounces-58551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF4ABD78D
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E6A17B9FE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58C27CCEA;
	Tue, 20 May 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1M8rXNL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40736BB5B
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742398; cv=none; b=IK6iblMP5onkHhAdGqFkas8R06Ns0As/MO5fQY5B+mntFoWsohpdUEUQ1XcZ0NYwYXpu24KWdkX8gqxIhzgS1pasvj5eO+WVeUMX2wEYv6UAuehmKrX0QxUo4QwHM9LW1D7h7rM3FBAIcFEwjBc9Z2iGmxjj5FJpDJepFKwqc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742398; c=relaxed/simple;
	bh=aAfjHAOO1R1seYRFdJPd96VGKxzjMihOC6LYwwsYzlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTyeLcVOtZpMhMt4KBN5ceC9bEkhlUdT+vNV0A6nbY0ybIPZI17Ea2CfdNZfkiL0GZdq80sj+iuY/2ScoARB8H8ee6aUwLVJC/8UHIdt0u2+tV9XIxdDUYGt3Db1G4upWyd1pmCcxSAEjoFrwvvRehqcR12lmJ8VI0a6/T0X+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1M8rXNL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8c3db8709so40351576d6.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742394; x=1748347194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmzmXWOCOLKudRaM4GnsN1lpbqwMoGYTGHPcZHsICw0=;
        b=D1M8rXNL7JTusPPMZEWXi/G5a2bQuI27jqFguqcurzPnm/jdIxYSs3UKzLNjZfoyLF
         d7WCBYK0swdQlA98PvGeYE1qD9RETw/pFl5inKMq4U3H0pHb2T7kU3d7BNqqGNl3QHw2
         CsBL0rWquAQogRAh3h6ZtpnkVwHvkjo+HjzMdPedVGcmVXApJG2fYQMrGWtMoFIUsdfi
         Hh/ob4aJVHnJNEB7W9tQwpd6p16sI4CB7i2j1+d5M7uaUbzoH3Nf5YnHj1LF8XhJwnE3
         o7VOsgAegAOyKX+bWnCOqR9RpDyaCYz2GlIgguYk+n9tMjM25/OpsjiKbwRnQOIfdoH2
         gkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742394; x=1748347194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmzmXWOCOLKudRaM4GnsN1lpbqwMoGYTGHPcZHsICw0=;
        b=ICjoqamMly9eu8toGqPg+cK7/j6sxC73oHoJvNN97UickW4Duozwb7HbpwjTJBNDBb
         K8ilN3TR7UKfT/ams/LeFg8UqC4dtRsiGqLWaz4bpwefjsrVDx6o1O4x5y3TGTppPlOS
         KE7YCxhdm2t1phk3cDKgI5/AMxZcz2hS5MWMbwYsVnB6lkwV3JzXASibIkM7KDmBkTcL
         7TJVlSmvFcKCcJsfPM2YhYqA0iLaIvdlqPY+BfPFsCsJBkKxYrG+4kkZcRr23Xfj34uh
         OyQTj+2SE9Q+udQFh2zGsfnWf7IkY0wg4Cs/1IvVNW/CcbOhrjWNPu3WaZ9atCqzPGvQ
         uFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyW0hxP4skWX+9NGaJWCuaBcA+VI8vVy3FPG/XXSEu1OBMPWUn2Bkp4l2Q22ehKmTVQDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxapfDBZwAHRO+C8/LvZ3B+7GJprZ8ZetXR9TdBNYIt7IBJTvBY
	EifvSYPwvR1sQPLxwCYfYOfLqhLKWnxBZLIs/LcUJq52DnRVq1hyvqMYvpQyUdGvE86SMqgu+3v
	S70bIMBOKmRzb+iCLrB1Rh3ydAvf0QXk=
X-Gm-Gg: ASbGncuj6y962l5akJ/4PZL/1eQV8Gk49RTJpCJ/76ko54oU4XyrYu2fPVl0V6P3tiH
	aZdmqSX+n0v6SKHZ32k7f5yuoQ9sTn/zLZt1McwgCkZq03vjqpOg57hKUMVcsU9ycqRj3hDILFb
	3gG7u6ReL2aLUsinelNa8st0gFfd1sKfQslw==
X-Google-Smtp-Source: AGHT+IFNPeUYtvfTVRQGODFgUWvwLuCkeD/5EPnj2TsmUa/Q272Nqt3jsCaUdF9FaATdXEwuheRojNCH1Vlm0XC/nuk=
X-Received: by 2002:a05:6214:1c8e:b0:6f8:db05:98fa with SMTP id
 6a1803df08f44-6f8db059b73mr91967966d6.7.1747742394411; Tue, 20 May 2025
 04:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
In-Reply-To: <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 May 2025 19:59:17 +0800
X-Gm-Features: AX0GCFsl0S56xt1j_JmLA_4B2jAubwAHuSPAcX88fYOPoMl7YlTchSbp0Hgjhg0
Message-ID: <CALOAHbC8UV0uKwTFBC-wBhd673aShQEiYOJ-Q9b4xE0nBwRFjg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:44=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> > Conclusion
> > ----------
> >
> > Introducing a new "bpf" mode for BPF-based per-task THP adjustments is =
the
> > most effective solution for our requirements. This approach represents =
a
> > small but meaningful step toward making THP truly usable=E2=80=94and ma=
nageable=E2=80=94in
> > production environments.
> A new "bpf" mode sounds way too special.

Alternatively, we could simply hook 'madvise' to define a BPF-based policy.

>
> We currently have:
>
> never -> never
> madvise -> MADV_HUGEPAGE, except PR_SET_THP_DISABLE
> always -> always, except PR_SET_THP_DISABLE and MADV_NOHUGEPAGE

If BPF had been invented before THP, we likely would have only three
modes=E2=80=94without PR_SET_THP_DISABLE, MADV_NOHUGEPAGE, or MADV_HUGEPAGE=
;-)

never -> never
user -> user defined per task or per vma THP mode selector, based on BPF
            We can select "never" or "always" for a specific task or vma
            The API is as follows,
            bpf->per_task_mode_selector(task);
            bpf->per_vma_mode_selecor(vma);
always -> always

However, it=E2=80=99s not too late to introduce a new BPF-based mode for TH=
P,
especially since future adjustments to THP policies are still
expected. Regardless of the specific policy, two fundamental
principles apply:
1. Selective Benefit: Some tasks benefit from THP, while others do not.
2. Conditional Safety: THP allocation is safe under certain conditions
but not others.

Given these constraints, we could abstract stable APIs that allow
users to define custom THP policies tailored to their needs.

>
> Whatever new mode we add, it should honor PR_SET_THP_DISABLE +
> MADV_NOHUGEPAGE.

Yes, the BPF only selects different THP modes for different tasks,
nothing else won't be changed.

>
> So, if we want another way to enable things, it would live between
> "never" and "madvise".

Yes, BPF only selects the appropriate THP mode for each task=E2=80=94nothin=
g
else is modified.

>
> I'm wondering how we could make that generic: likely we want this new
> mechanism to *not* be triggerable by the process itself (madvise).
>
> I am not convinced bpf is the answer here ...

I believe the key insight is that we should define a generic, stable
API for BPF-based THP mode selection.


--
Regards
Yafang

