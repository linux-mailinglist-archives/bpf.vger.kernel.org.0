Return-Path: <bpf+bounces-70570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5DBC3406
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 05:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D02934E92DE
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 03:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFE2BE053;
	Wed,  8 Oct 2025 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g26q1F5t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA328FFF6
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895463; cv=none; b=AKMrDScb54VY9MaqSfPbIP6ukvT6iYiYDOMRhP/VHSLofZlZvnllhKS1ISRDTVVnb1/L4CqbYzC4f1MGSjbRAi49v2rYD5waH9dYTnmTjVtf/InTd1kzBqQuLyDlnE7KcXms1HveB59ntghbeKdZGTf8RxG6pw/Y3K8GvbXZTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895463; c=relaxed/simple;
	bh=901RhySNqmrBkBO4w25nUFBvli0tFgYz0eeMo+iVEWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0HhojCVkFgHPcjc1Y5e73vR9nhPURAfBOii7ASB3+dVvkCbBg8/evH6RGW/6Pbd+R5lkeO6R7g3SJxpcJ1a5JyP3KAR/+3UjJ8nC1RrfPvy5mklsTFc6rlYVBDuctOOaIgx04plqKDzDYR46j5/G2NtOFnSQQ/QbR5/Gk5X9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g26q1F5t; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-81efcad9c90so78894796d6.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 20:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895460; x=1760500260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+jx7n3Xx/N7Z5ReLNJDr8EPoJ485g4LVFHysMmcuts=;
        b=g26q1F5tJ9fddPqlCdRqko+c60Pw4p7iqGbZEB1YgrTKfCBz/01a66NdoR/XuyCnge
         mfRzuZ53tpvnx6hqYKVNYA4tCtLEyIPSSf4JfSHVeM7/8M+0VUHNKkn21HLcDX6It7gW
         ZXNm6RxOLnL44075fAwmpxAPesTG84fCn+mLM20kJf20aFFxftJ8blYHVuUsB8DFyj7/
         vf/MwnN36j4SavmKr14avJyca0go9Mjttnh/OYexfbmVH0zh0Q3Bo33zr18QndVpLDJC
         /b/uVbTKi7TxdrKbtWey3uVQ6iRFkzz0w/zhTQ8olMlf/AL6CGZZKCAp7hV33fkJQ5tx
         hHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895460; x=1760500260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+jx7n3Xx/N7Z5ReLNJDr8EPoJ485g4LVFHysMmcuts=;
        b=IEbqSFky0ZIY+HNppVA7kyOvwmh23XozDI+QkqtJAXhb20knMQb4uAxWPq9FdLmRD0
         VMB4XY0AvkpilFxzW8YMQ3FoujQQNJAehWceX3AW4P3MaLedYsOUYMYSvMy4zDE/ZaZC
         RVNJsWoEBZnCaPZKOTsgVg33jMpAwMD+3//TT/7WhjARRblMQY4CEDsxvv+VntLN/024
         faH89FXOENAC42+OoyIunNFQWjo8tCNbbq7gOxZKkEPI7GtirNLay9N7U8KZ1Tbw9c7r
         RjqYHOlKEzogG1bWdWhoxWDilpJWr6GKCeBY/Lg7uaSi80ExJR59k1eP0L+dxnzUC6Nc
         k0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVpv2LCrxYPrV5onoYkzGsdsD5ZT/ilXan/emuyFULkgy7hODghgp2mS4+NKtyFUQRmXsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oVryD+a/8bnqMul3FjaIx9OGThUUhcwo3Oq2E1DadGkN6dOn
	bQAAhFVDLTnvAsVLuMkjC2/Xw7LZf14PmY9sfsDxK9cgOG86DMqJLPEZjLeRm//g5Hw3xoL5SwE
	oMRuioAnPdfZkqBUMas+3ondS9xTmExE=
X-Gm-Gg: ASbGncsv2VqwH9LmlIImam0NgDF68in0+Lh/cZ2BbXKU0E4L/wjg1ZOyuwQqHlwqcWZ
	sK1oI+xSM0naTDZy0HQDvxo2GfJ8zPZp+ecjSdST9/nsl+gef7FjqLq1lONZD6dL8/nCe2rODlB
	RD3P6xnS4BwgqJGHoRSV1a6wgSDk6W3vX21jxu1Ic0Pd9PvIJIUNgXavfG7XyDI8IWY62PdGIvY
	euyFQ+jH4gNA6XlmYz55TMEb9JdxkukDkLE1qEiP0ovxo25Owk4/v2op+UdIP5x
X-Google-Smtp-Source: AGHT+IHII1V1w94JvtgMvnbeLHT8eBxHxQJa6TROlR1NDzQLk2GySyA7HWBaodCNt5MXTv85m0/XMhRKG6JZ8VcoTLM=
X-Received: by 2002:a05:6214:1301:b0:7e7:a043:59d1 with SMTP id
 6a1803df08f44-87b2ef36f58mr22758916d6.44.1759895459595; Tue, 07 Oct 2025
 20:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com> <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
In-Reply-To: <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 11:50:22 +0800
X-Gm-Features: AS18NWDo6G0yUgBTxh8Ver-mea44VVIk72GGjRNlFLV7d6fNMUbUH3UgINnuRYw
Message-ID: <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> > has shown that multiple attachments often introduce conflicts. This is
> > precisely why system administrators prefer to manage BPF programs with
> > a single manager=E2=80=94to avoid undefined behaviors from competing pr=
ograms.
>
> I don't believe this a single bit.

You should spend some time seeing how users are actually applying BPF
in practice. Some information for you :

https://github.com/bpfman/bpfman
https://github.com/DataDog/ebpf-manager
https://github.com/ccfos/huatuo

> bpf-thp didn't have any
> production exposure.
>  Everything that you said above is wishful thinking.

The statement above applies to other multi-attachable programs, not to bpf-=
thp.

> In actual production every programmable component needs to be
> scoped in some way. One can argue that scheduling is a global
> property too, yet sched-ext only works on a specific scheduling class.

I can also argue that bpf-thp only works on a specific thp mode
(madvise and always) ;-)

> All bpf program types are scoped except tracing, since kprobe/fentry
> are global by definition, and even than multiple tracing programs
> can be attached to the same kprobe.
>
> > execution. In other words, it is functionally a variant of fmod_ret.
>
> hid-bpf initially went with fmod_ret approach, deleted the whole thing
> and redesigned it with _scoped_ struct-ops.

I see little value in embedding a bpf_thp_struct_ops into the
task_struct. The benefits don't appear to justify the added
complexity.

>
> > If we allow multiple attachments and they return different values, how
> > do we resolve the conflict?
> >
> > If one program returns order-9 and another returns order-1, which
> > value should be chosen? Neither 1, 9, nor a combination (1 & 9) is
> > appropriate.
>
> No. If you cannot figure out how to stack multiple programs
> it means that the api you picked is broken.
>
> > A single global program is a natural and logical extension of the
> > existing global /sys/kernel/mm/transparent_hugepage/ interface. It is
> > a good fit for BPF-THP and avoids unnecessary complexity.
>
> The Nack to single global prog is not negotiable.

We still lack a compelling technical reason for embedding
bpf_thp_struct_ops into task_struct. Can you clearly articulate the
problem that this specific design is solving?

--=20
Regards
Yafang

