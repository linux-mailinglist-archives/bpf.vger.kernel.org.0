Return-Path: <bpf+bounces-66785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902AB393AA
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A58A169F29
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215F274B2B;
	Thu, 28 Aug 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQC+8WQD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C37222575;
	Thu, 28 Aug 2025 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361571; cv=none; b=UonP2NdWv2P9A9TPYjRCojpKXigbqA+1RLCGygqBfCTHwy2T2rrO3MIwTLME3zFcZ8tmdjmXTV07anmj8Ey09nAqPWsq5EiswDI+E3MJthxozFPckbZn8BwxYup8JSQxPu+pIBuJCTkTdR/U0kN2Rwqe5FwZ2r2C2omBbnk0PL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361571; c=relaxed/simple;
	bh=cnbLMdPiCwmvYLji+zAdnqkI0zKaKd1dlWQ6sfyOcHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK6eEEyZlr8EXpsEJiomxOyPHb0h+oEJmmWQwASa2a4PwtDNU/7eK007kmz2NFSL5v6h9Y0OrBFN2wd36G4fOAWIidVynQBh5GoO7gXkVZ+m6infmU4f99oZHm1oiYPTe//No0Y02CrL4q7koGhLUFJcS9YsDvLmMLGt508BHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQC+8WQD; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70de9ffcfffso6104956d6.2;
        Wed, 27 Aug 2025 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756361569; x=1756966369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnbLMdPiCwmvYLji+zAdnqkI0zKaKd1dlWQ6sfyOcHc=;
        b=VQC+8WQD1YmzxM1IfDIAsvfgpw19V4FMhtMogLmsIK6cm0b71hI7DgEKTuODiLapi/
         8rr8+Fao4OdiTLsRZWW1Rjs1dFAcu7Y5x3ISn73hdczoRA+9IvOA8bKy4Gu844gXJE3M
         5PB3QnKKiNg54Mye2degQWs7TSBq/tZuGLqc99eAmiRgUlaAzizzQp5+wjHWzLbXycDp
         zaKgtHJOwPEuWcvvSRW/nSzWYbunzZyjOMLmFAqA87md8dKVGVeB5yyOo+Gx3WRwy6GF
         Ctrp2Vt9Xxxwj/sOLL6dpYzs2e4Zr/DX0Wbryt2n71nThf9Q2T3s4axGMkKo4xLqTK9F
         Oinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756361569; x=1756966369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnbLMdPiCwmvYLji+zAdnqkI0zKaKd1dlWQ6sfyOcHc=;
        b=L12m+Sa7+uU3+br5y88i47lVXE60cbCGlvQ+oGuWHdKtA2yUBscuUm77ojmYk8n2JD
         DVya2cV5sZkczrLoPwJ8BlWiRoVULu+rlUe6WYAPOu7Vj9sV/5vFWT97JC80mJCq6xTd
         m4uAXYq70CcN8uTfEUN9MwC44EVA8/CuUhJcDjiMWtjhqwvok0IV2VGrDUgcQ9IoC23j
         o+KiFknVouKCxDaOW11C/AVm97PxSRr7uYPi66nmXWlFpK1UAulzwv3pqO/DsjSuj7HA
         ygY6xLpM5f9MqWu19XRmRWwAzSRaS89OHNhm2YybVFzezrcLcrdkEhvI/BJyURSzqjdL
         hfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUyMYHlaNqKvMUoqm1j0ReHPWrvpc7iEcOZIzNHfEp4pY8iyzFiGzkFqAZXOkW6BfAB54=@vger.kernel.org, AJvYcCXCcOFdSTyHKHjI8O1ykv9Xe2DBLewgr0b8dz9eol7Rw/MUguBitep2m5tkcw4fKs4th6F7ayDKYKjv@vger.kernel.org
X-Gm-Message-State: AOJu0YyC11EyboDTLlZNxkyhvdyvOQznVFuwsJSLSfQgBVI1bETagDJm
	tFCIyoQJuw+bExNG2/nUfLo7rTDDJgzVxGCV72Y9vG/NER3D6ttHlCKxisbtBPVD6GO9AUbbHh1
	CdwTIBROHI7s19zjzueQAO6dAIZmuywE=
X-Gm-Gg: ASbGnctqraYxpxw06Sa5RqV60KVjmhZOKEfoQfIaqoS7qLfI37zanYgpE4JBs+Tx0Ng
	Wb3DSo4EaZa3gjV0TPiNd1BkyFe4d4FkKvRLkir4FfuLk4fmAeBTyfne7GgHWEOn3VzKlxFuwXK
	4mGxL+SDJW+789mqXeY84w1LTUcaDIc+tAkyvB1X+01O0ifAqraywsuZInQMw7RneShcx9JdHwI
	p47yWHtuMuc8yIXpwiwdAj3Ks8NZMF1uPjN8Ig=
X-Google-Smtp-Source: AGHT+IHWEqZvffeKo8kRXTyycXIE2aUiikzOvRaEpoYzy2gliBcy83nY3larYygf49dGuEclkaz2O/Wg5aGu2qNho5M=
X-Received: by 2002:a05:6214:3293:b0:70d:9f91:642a with SMTP id
 6a1803df08f44-70d9f916d1bmr193078726d6.56.1756361569344; Wed, 27 Aug 2025
 23:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-5-laoar.shao@gmail.com>
 <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local>
In-Reply-To: <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 14:12:12 +0800
X-Gm-Features: Ac12FXwA8AE2T9DT0lZOOileufyZaAaDfXMTycJckIK5rbkI3PvbmFzzlT8sNXM
Message-ID: <CALOAHbDxxN8CsGwAWQU4XRkG8NvU-chbiDv=oKW0mADSf1vaiQ@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 04/10] bpf: mark vma->vm_mm as trusted
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:46=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 26, 2025 at 03:19:42PM +0800, Yafang Shao wrote:
> > Every VMA must have an associated mm_struct, and it is safe to access
>
> Err this isn't true? Pretty sure special VMAs don't have that set.

I=E2=80=99m not aware of any VMA that doesn=E2=80=99t belong to an mm_struc=
t. If there
is such a case, it would be helpful if you could point it out. In any
case, I=E2=80=99ll remove the VMA-related code in the next version since it=
=E2=80=99s
unnecessary.

>
> > outside of RCU. Thus, we can mark it as trusted. With this change, BPF
> > helpers can safely access vma->vm_mm to retrieve the associated task
> > from the VMA.
>
> On the basis of above don't think this is valid.
>

--=20
Regards
Yafang

