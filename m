Return-Path: <bpf+bounces-64035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9AB0D8CE
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7A2188B408
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4EF2E49A5;
	Tue, 22 Jul 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMlrX8Yk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C4243958
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185774; cv=none; b=AkiwyHXD+kWqlBvXbsPlUqq+q9CPxxuUCIAiu7NXZY5n9Qeaj4inH3kTnAcEQXtOpNNAXn82KyXoljrsd4e+5CED/+UNi/BjBcKOwzXiswq8upaCPf7de8wI61Bz+fGINgbSjegi3Y5QLQ5DLsnqtN4huxC5b65UwT+bR+RtH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185774; c=relaxed/simple;
	bh=O1Rbb//LGn2cX1HNOw7Ni4d+CUv/1OLBW6Hdjf2INnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSDsuFWm3a7dB/v4i2truVV1dKqcZTla98/2OhH3ZC5nfP7aAXsxtvmi4nCfExXaTQZWCr15QGl/iwK8d6Gwh887a384/qQna+qhb4cFIKbk491LOvabt1lK0IFE9R1xnDEE4E4nu7+SZOvLvuvY4IPKAmggv/ySNFbKoZDAE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMlrX8Yk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7048d8fec46so65435766d6.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 05:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753185772; x=1753790572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1Rbb//LGn2cX1HNOw7Ni4d+CUv/1OLBW6Hdjf2INnY=;
        b=LMlrX8YkRGbzpNZfcB7lhiYv9zgMzZ4bYYu4FjHhE6j6+ByQux0cKSe+HhO9/wQecQ
         swaNr9UDygS8fTI2yi3yZ9v5SNiQ0UAfx2E9llf1JewrasX+msvBFcHo1RT+miSqnGQv
         uXG+NPZzEZJjJfaaL3YHELRg7w2Pp9YjXX6h5PYY4NU+sBOAIMOb8lqPwXsw+lGRzF8Y
         pRf2fUlWPZ9QKhlhiKMYe6ogYzXZB+x/P20BLPlaw91MMZjtPIgznU8COej610tf07qR
         t+BqpD3Zet8tKnXDb93QGv25SHxq5pQhCAsCuETPzid5XcL1vd437FW9NTr9NCzqKafh
         i0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185772; x=1753790572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1Rbb//LGn2cX1HNOw7Ni4d+CUv/1OLBW6Hdjf2INnY=;
        b=Uy6cMhzZesjCEaYEIVNhRt3UyksidqQr0Dd/xmm2o4moN0cjpJspehYKdcGHXfs8r5
         9kazlzD8Z2Rj2Vwc5CyYB0cDfY9zTb0e4uTnxhljJIkXQFt4fwA7kBMi2iWqaKzx2tUa
         BRWc82YXgbzGKGHZk3ByJb//vO3kzIS6swLJk2MF9G5QCKrOqBhYsvmAyvP+XKJH+A83
         cv8Cvwk67M71DNN5JX5u1z9gWeiv9E6LxJ9wKOwVIF7N2gcANy3fDy7QUEUOZpTo+APv
         +t93rPtx4jNb3REnhgdfARw+wIHaJvcti/uTgoP/c+jg+iDhvwWChtQuvVU+0fqFfNNo
         6ifA==
X-Forwarded-Encrypted: i=1; AJvYcCXFTvz3twrU4Iv55KJGgPuy4PUGBLdZZZKr0llZCb6j3hxVyZc0J3JNEls3U0NiduCNO60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAondXz9PoQjVoYzIX3c2mmahRmFRBdj70YRlqDHHCQdq7Pyz4
	KLMt8nWYywNq8Z/bq7CPHZz+kW7JqUYcIwS0HPwe+k1nZFpq/Tve+1nm7byEEFse3KG1AFNdAJ9
	zuU28croFr54PVmjT1jVFsvGkOG/DzB0=
X-Gm-Gg: ASbGncunG5QBrKTmrNNsqJjUnheuYMrqWYFpj6ln6P1ZsvcCCeoe7/FdafwnDkjpGzf
	F4WyNPmJVLoNsS3jcDNLWc1oqb84VCJATa8srXzdwoCpVijK6sMYbDRSfGHOjCuwSF3BIxhk6io
	8DlDHYC9/BjmWpQXXRTbC5yvpKyFtp/CkUDKzmzGdzv8pi75ZyR9Oc2zyVdU/RhYMc5zEhobb6K
	2D0piTOXomBzv1c/w8=
X-Google-Smtp-Source: AGHT+IELaEEUYF8vstdB4TA+iN1z2ZG+kTtjGdNOa7umJ/+UeqcV9yaPQ0nvlDd0by7NCY+z8+9pZoO2w5qFPmAcYms=
X-Received: by 2002:a05:6214:4ecf:b0:706:f190:f2ec with SMTP id
 6a1803df08f44-706f1910739mr21320536d6.19.1753185771886; Tue, 22 Jul 2025
 05:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com> <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
 <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com> <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
 <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com> <CALOAHbDMxVe6Q1iadqDnxrXaMbh8OG7rFTg0G7R8nP+BKZ9v6g@mail.gmail.com>
 <fa81148d-75ac-490d-bca3-8b441f2afe1c@lucifer.local>
In-Reply-To: <fa81148d-75ac-490d-bca3-8b441f2afe1c@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 22 Jul 2025 20:02:15 +0800
X-Gm-Features: Ac12FXwCTK8hUlqlY1CJV3ls2pACth6o10Ozmv4Oz4rZ3NeP-gCWHkv0sd3AtHo
Message-ID: <CALOAHbAkR_A48r6Y_vikAgcifnK9cBhgAc5t=jdi0jTN695m-A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 7:55=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Jul 22, 2025 at 07:46:57PM +0800, Yafang Shao wrote:
> > > So for these kfuncs I want a clear way of expressing "whatever the
> > > kfuncs doc says, this here is completely unstable even if widely used=
"
> >
> > This statement does not conflict with the BPF kfuncs documentation, as
> > it explicitly states:
> > "This means they can be thought of as similar to EXPORT_SYMBOL_GPL,
> > and can therefore be modified or removed by a maintainer of the
> > subsystem they're defined in when deemed necessary."
>
> Except that's not how EXPORT_SYMBOL_GPL() works at all, we can remove at
> will and are only required to update in-kernel users.
>
> So that comparison is simply bogus.
>
> >
> > There is no question that subsystem maintainers have the authority to
> > remove kfuncs. However, the reason I raised the issue of removing
>
> Except the documentation that seems to very strongly suggest otherwise?
>
> > widely used kfuncs is to highlight the recommended practice:
> > - First mark the kfunc as KF_DEPRECATED.
> > - Remove it in the next development cycle.
>
> This seems reasonable, but I'm not in the slightest confident in us just
> relying on this.
>
> >
> > While this is not a strict requirement=E2=80=94maintainers can remove k=
funcs
> > immediately without deprecation=E2=80=94following this guideline helps =
avoid
> > unnecessary disruptions for users.
>
> The documentation doesn't state this, you are surely just inferring it?

As noted in the other thread, the maintainers ultimately have final
say on this matter. I'm simply sharing my perspective here.

>
> >
> > --
> > Regards
> > Yafang
>
> Overall I think we need a different mechanism in addition to this, such a=
s
> a very clearly described CONFIG_ option that makes it ABUNDANTLY clear th=
at
> the config and thus the related BPF hook may be removed at any time.
>
> Ideally with 'experimental' or such in the name, or perhaps even tainting
> the kernel.

Agreed.

>
> We definitely need something better than what this documentation is sayin=
g,
> sorry. I am not in any way confident in relying no what this document
> states.

The documentation has always been difficult to understand ;-)

--=20
Regards
Yafang

