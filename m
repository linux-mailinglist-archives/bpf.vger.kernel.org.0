Return-Path: <bpf+bounces-58552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89156ABD802
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A21178B6C
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329F27C863;
	Tue, 20 May 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP1xTjl4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819026B2A9
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742820; cv=none; b=rD0fA0KQuWquYIg2ss7eWjLzSpjoNb+Xt5UWAwzuxrIyxuGe+cLNYnSLiJYcFBGE9lky+vXVE50Y6ZhXOL3eSgrZpnoxfMZ8+KSdm3pzArnBibzQZlcPxid3kPtDRxIBVhPfkoeBqFEe3N0XPj8Mpq4FMyqnAzHeXC5QTSmIMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742820; c=relaxed/simple;
	bh=uawf6IInxlFD5XQ+Zo8gfn/3GyjOudh7Roi/AjAtF3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmEsae5IpICVihQLnHQSoUdsBRl0BoDznFpTEtjXVdFnT4SpEctGQ7wez1HwDfcz2RZRV1QcW0Can5+h1Ov0wnF2uRpyVOR3kLxG8yFPm9Qb9AgQT8rPmLBL1s1kn0SlEfMpWLKJMjYvWwGCyYTvg6zyCqJzvTJHqJ7tCYus1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP1xTjl4; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f8c46455f0so33627196d6.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742818; x=1748347618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uawf6IInxlFD5XQ+Zo8gfn/3GyjOudh7Roi/AjAtF3A=;
        b=TP1xTjl4UqCMg+RgpeiIPVpUhOnXusF4O53dxJF4eK8e40wkEQ8/WTCuCUXP5mLmV2
         1q6+gfAIM5nl2RLEXr7VqGAI+ncnVCdy2GxhPAVsuSKEmnRXyx1qQ1FvKLgz2ihGz/mE
         FANSxb60BMJsY8rIz7LoEYYSTndJsciPZHcrVMNmxLSQwi9vO/YHPprA1q1n62xql6M4
         dhQWJuON0akYd7IUpVKUxMq3D/pMneWZley1SUQlqHBqgsT+Tr75NC/d6WMm+gDnsudl
         noGjk9FBPpTr5dLr5GhMjJsFKex3Vl4CsWqTMHtnWo1l6JO/xSa+KiM2TsI1f3DPPhVy
         FBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742818; x=1748347618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uawf6IInxlFD5XQ+Zo8gfn/3GyjOudh7Roi/AjAtF3A=;
        b=aB2HtSwKoBk3vetAZUPUVVauh+EZbuhtSGFB0e5TqjvUHXCk/FvapQjDmfoqjuRbO/
         +DZEsRpObz9m0NJDZ7gyFQzk/RgAZyNSM1wzPvDvVh2MwZfQXmsRxZBPhOL5DaQkFyK3
         WSrzmyvktwIZXOTDgyLeV7THPQKrQeWWYuKpy3YvxImBq1JFXjwPQTG66cKS0/WYXEh2
         woCrYUK7loPAETjh78PpRmWsW5iV0M8bHmELt2hryH24N6SEIgHYeBZF/5JryrcVcYWM
         bndITQECnatDoiIFi92+PesrvlfEvx/DFReUtjb5hlcGjecdrs6bJKUHvSD/l2XEkLxB
         R1ow==
X-Forwarded-Encrypted: i=1; AJvYcCVcbn0dV0nA4CSp8k0APaypY6855phpFBAaZSzOjFaaBYs4YyXDovGatXjAKpndOm6Unyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMFpX8CYTBGa1QPGvAdCJS82Sc9fIn5iJ0JtYGMMBgMHE48J/
	KIorQqbxgZJlvHNnTtMHRHcCLd1zSpG0LkV04kfwyQIexFzhJmBjBghKiJnTPtJYQ69jPLlnzIg
	On94QWVyR6hQhIIm3BGxzP60/tM8P9Ho=
X-Gm-Gg: ASbGncu28heUFp0NN/f6QIqOYyLw45Vld/DvxdLSH76tFhXzlMGASoPMRNg+765tBVT
	NiG/xGFgqKr5KB2OrZ8iMEVGPiRIAEmZ1D7SRS0s65/GA3tIOC/0CG17V/9Ehuu2AMI1YrU+kMg
	0abUb83Di6AbuJSgD7BBqKzUVQ/3Fv7btq5Q==
X-Google-Smtp-Source: AGHT+IHZnzQTk5sIW+u0v7W/D6wS+iYmmxrSh08v6I6mL1fjQBiVJA8AJwFzsvVM2LKUBBYjYIseb2UEzQp7zmo1aWw=
X-Received: by 2002:ad4:5748:0:b0:6f8:d14a:f793 with SMTP id
 6a1803df08f44-6f8d14af9demr136091396d6.21.1747742817800; Tue, 20 May 2025
 05:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
 <c77698ed-7257-46d5-951e-1da3c74cd36a@lucifer.local>
In-Reply-To: <c77698ed-7257-46d5-951e-1da3c74cd36a@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 May 2025 20:06:21 +0800
X-Gm-Features: AX0GCFu4_c7f2wCIxPd-Als2KQ2nxgmg7i43lBUhtR4539oEk2sI1xpn5z-IGNE
Message-ID: <CALOAHbCZRDuMtc=MpiR1FWpURZAVrHWQmDV08ySsiPekxU2KcA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:49=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, May 20, 2025 at 11:43:11AM +0200, David Hildenbrand wrote:
> > > Conclusion
> > > ----------
> > >
> > > Introducing a new "bpf" mode for BPF-based per-task THP adjustments i=
s the
> > > most effective solution for our requirements. This approach represent=
s a
> > > small but meaningful step toward making THP truly usable=E2=80=94and =
manageable=E2=80=94in
> > > production environments.
> > A new "bpf" mode sounds way too special.
> >
> > We currently have:
> >
> > never -> never
> > madvise -> MADV_HUGEPAGE, except PR_SET_THP_DISABLE
> > always -> always, except PR_SET_THP_DISABLE and MADV_NOHUGEPAGE
> >
> > Whatever new mode we add, it should honor PR_SET_THP_DISABLE +
> > MADV_NOHUGEPAGE.
> >
> > So, if we want another way to enable things, it would live between "nev=
er"
> > and "madvise".
> >
> > I'm wondering how we could make that generic: likely we want this new
> > mechanism to *not* be triggerable by the process itself (madvise).
> >
> > I am not convinced bpf is the answer here ...
>
> Agreed.
>
> I am also very concerned with us inserting BPF bits here - are we not the=
n
> ensuring that we cannot in any way move towards a future where we
> 'automagically' determine what to do?
>
> I don't know what is claimed about BPF, but it strikes me that we're
> establishing a permanent uABI (uAPI?) if we do that and essentially
> promising that THP will continue to operate in a fashion similar to how i=
t
> does now.
>
> While BPF is a wonderful technology, I thik we have to be very very caref=
ul
> about inserting it in places that consist of -implementation details- tha=
t
> we in mm already are planning to move away from.
>
> It's one thing adding BPF in the oomk (simple interface, unlikely to
> change, doesn't really constrain us) or the scheduler (again the hooks ar=
e
> by nature reasonably stable), it's quite another sticking it in the heart
> of a part of mm that is undergoing _constant_ change, partly as evidenced
> by the sheer number of series related to THP that are currently on-list.
>
> So while BPF may be the best solution for your needs _right now_, we need
> be concerned with how things affect the kernel in the future.
>
> I think we really do have to tread very carefully here.

I totally agree with you that the key point here is how to define the
API. As I replied to David, I believe we have two fundamental
principles to adjust the THP policies:
1. Selective Benefit: Some tasks benefit from THP, while others do not.
2. Conditional Safety: THP allocation is safe under certain conditions
but not others.

Therefore, I believe we can define these APIs based on the established
principles - everything else constitutes implementation details, even
if core MM internals need to change.

--=20
Regards
Yafang

