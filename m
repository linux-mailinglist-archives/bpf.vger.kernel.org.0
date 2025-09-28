Return-Path: <bpf+bounces-69918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E2BA669C
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F9417D38C
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7379C2494ED;
	Sun, 28 Sep 2025 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK2vPX3Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DB24468C
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028370; cv=none; b=Kh+4lmUzVc70ToueUhB+4mewKtaAewbBUbnfw848krqkKpt6s7ajyOihywkX9sf5+wuFnoHmABG2ffdaylF3ArhDAAaxH82J6YLcb+hCjCdfzp/7JZ4tArYpIWo43nPGqvFUBgXnePog7oY6VDqbe/A6wz6AGrBe3J1q0LsoSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028370; c=relaxed/simple;
	bh=ZxzPhH8msAHrLGbslPHCpiVKvLZwqZuC0UrHyj7DJI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvsfzo6h0RF8Xv9f//y1+jiTXpmlEVnmdBLQaVesuLE9pH5bNDGOYqUpfhmQt73SAtx2nlVDbRSFOfJ91vsStFZHp2HO8Q8PmrTryNmUbwBGf9bute+bUfQA6xCJxG5tpX6hidcBQldh2DIgs6mx/fQTsCP0r7b1IW+woSfxHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK2vPX3Q; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-79599d65f75so28222606d6.2
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 19:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759028367; x=1759633167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbYlG8kir9C4NWsQtGw4HVo4aLYIvyfCcEM9DUL4BGE=;
        b=HK2vPX3Qv0m6wIIAZHw8I/Ya56qgewHWk9hhhzhNoT1eVRMHLIKQS4Z3Oy1dw5RDGT
         FhrBouWzMpVGzyQOjwJcVu1qIoVMdmW3BCISsJLRQJRbAMe2d8s8VoEcg3zWpFHtp1xP
         dVknVMWKquZUunjQPoGNYyCu9++CTlqLl/VxMxl8/Ogsx/NgYYjPZLWu5KiRt2ExMRPz
         juxZNceWA36XE3DqyY/r7WFwJg2vgODFhtMXiVROnxMzvynXiD9T3yqgeR/lg9FFOlEp
         3LY7+fTUNZ6kZ0SI7D6c2ceNYAo/YFWFMYOgW+AMs5avXp7gGz28couaTFmLRDLBivt8
         5Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759028367; x=1759633167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbYlG8kir9C4NWsQtGw4HVo4aLYIvyfCcEM9DUL4BGE=;
        b=QV3iXVnN+LcOOK46pX89KwqsEQ836NUEr61rHfr7N07zXnE2/T6/TTnnGUhj94tKl+
         EOnfHixS8UaTehZDw98yY8Z2Owf/OBklU049CCqMSoWVGkzzd6+8D2DaA7Js6VkXKMWY
         jLXiTMT8BH2+aLEMUOes19f+dDpejYVOM/hxD/eH6btB98xGeJ/qo6MFZE+Esxl02b0r
         Rae207+pMBPOb19zIRSliFT1FV7NkqmTTJSL3im//BOGo2OIbs5Sjq1RAVNdcJUOannm
         BOGMCjVqyLy6V7WnPJC28fkPMcgGD2hJIijNdRjznGTUB+h2+FSUMHsc/vJVB3//pWsu
         sBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqov2BZLQDoCuXb6MKA4cQiciWgNKvLPBjcD7FzlZh9URcgpduLGDschC4Y1gx7dax/7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YypzM1WaHqVT0LS4nevcim+ISTJkIW6ZeHpWwHfkogcLDWqFD8X
	oR8bBPNXbkfqtt2iGrPRSS9ruPJoTvj12ecGU3wPoVlk9RENpMsnVVXUydNm8RNWiN1E0L4etXD
	HbpJ5p+CGhK5m/zIMAAPca25ERF5CIpI=
X-Gm-Gg: ASbGncuPgEIzL3b8vP7NLLkVFRcGkvCsPdT85np1bvyEMHf6a6AofqW7ybboHSZ2gYn
	5HZt4ZKFU5+rBKakGABdnOMw6Mnq+V3K1er1V6oLf40Z+8exArPIHBb2OzRXGnGpMfFL/8Kika8
	7rfIN+NsUiuVHDQGjHenTxPAqpCJZSgKwMvB87WFtyxGh83LpSNLlEzIq8P455CrgnVMbTVoeTI
	hm+93LFyScdz+SfuWwx1cec08b4TsRMxWAtDWHM
X-Google-Smtp-Source: AGHT+IFdRnFXl3N8Jp4Haml4M1RRKvlW3m2kzWVSMSBoU9EF1uuyEHWcCvydfgCbA9/kyPP0cUmHnjEU6SbmvUelvBA=
X-Received: by 2002:a05:6214:4001:b0:70d:6de2:50c0 with SMTP id
 6a1803df08f44-7fc43a4e9e0mr153355586d6.61.1759028367220; Sat, 27 Sep 2025
 19:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093343.1000-1-laoar.shao@gmail.com> <20250926093343.1000-7-laoar.shao@gmail.com>
 <035a8839-c786-45b6-8458-87ac1c48f3bc@gmail.com>
In-Reply-To: <035a8839-c786-45b6-8458-87ac1c48f3bc@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 28 Sep 2025 10:58:51 +0800
X-Gm-Features: AS18NWAAfWsnD0j5sPrJc3hEg82Xq_xZbRib5fRTmJ2-Yy1bnBsvdtfvitUBea8
Message-ID: <CALOAHbApB53XJBvkomsbRcvAFr8rzUajjB1vJDL92b+9cYgHgw@mail.gmail.com>
Subject: Re: [PATCH v8 mm-new 06/12] mm: thp: enable THP allocation
 exclusively through khugepaged
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:27=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 26/09/2025 10:33, Yafang Shao wrote:
> > khugepaged_enter_vma() ultimately invokes any attached BPF function wit=
h
> > the TVA_KHUGEPAGED flag set when determining whether or not to enable
> > khugepaged THP for a freshly faulted in VMA.
> >
> > Currently, on fault, we invoke this in do_huge_pmd_anonymous_page(), as
> > invoked by create_huge_pmd() and only when we have already checked to
> > see if an allowable TVA_PAGEFAULT order is specified.
> >
> > Since we might want to disallow THP on fault-in but allow it via
> > khugepaged, we move things around so we always attempt to enter
> > khugepaged upon fault.
> >
> > This change is safe because:
> > - the checks for thp_vma_allowable_order(TVA_KHUGEPAGED) and
> >   thp_vma_allowable_order(TVA_PAGEFAULT) are functionally equivalent
>
> hmm I dont think this is the case. __thp_vma_allowable_orders
> deals with TVA_PAGEFAULT (in_pf) differently from TVA_KHUGEPAGED.

Since this change only applies when vma_is_anonymous(vma) is true, we
can safely focus the logic in __thp_vma_allowable_orders() on
anonymous VMAs. For such VMAs, the TVA_KHUGEPAGED check is strictly
more restrictive than the TVA_PAGEFAULT check. Specifically:

- If __thp_vma_allowable_orders(TVA_PAGEFAULT) returns 0 (disallowed),
then __thp_vma_allowable_orders(TVA_KHUGEPAGED) will also return 0.
- Even if the page fault check returns a set of orders, the khugepaged
check may still return 0.

Thus, this change is safe. I'll clarify this in the commit log. Please
correct me if I'm missing something.

--=20
Regards
Yafang

