Return-Path: <bpf+bounces-35135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEEC937E96
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 03:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9879F1C206A3
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1534A22;
	Sat, 20 Jul 2024 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKX78uhy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877C137E
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721438416; cv=none; b=N6WVT6Q734pBLmSPDnGmZnO+7oRGv+FqfGdGlvsccinc7T4KnWESP1IvLAG2/KNuukn4qtNA3wcpZUOmqfzAnMffEbKXi9TlVJV1UZobvxAyq4/3rpXZXqobdpIKrtA7z+cGDxFoJbJ5mx6S+nLhGH4LoUxVKWgdr6Fh6JLowIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721438416; c=relaxed/simple;
	bh=jDDWlhOPd9p5laiX26HoQT4lg0SDo8oDuwfcNKJbe+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVqz1sIc1yAtlcT3q6jUEHaL/q0D9s+uP7XaWNEYB40Rgn3HTDS1fWpdigveH//iEUfHNNJaED69UE/ZrQwRQUXmYmzISJ0a/oADPRvK7HK6klys1JneSvwCidheFF5B2Ef/suYRI3a85ZKPHvH5SDVU49cAeKww8RXauQSixgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKX78uhy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso16533275e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721438413; x=1722043213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EnhpRHHFeiUN0P1kueRwaaNcw6CDlqefq6wPjdm7rY=;
        b=NKX78uhy54Ryr+yzJrZD0n2HnGgAAfw/t/13daiqTF7fQZeO9GJI4BttETSQuUVQvS
         s5+RoYTcOZUJEIqixukG5ZxAM59cUsk6MeDJZdA1CGovBoY3h3x9tFO4ZzliXm/So87R
         hoGkkmXp+cTnHCQs3Rx7ttJKWXAQY1GSlH/TVgTmHf43x61TVqGWskHlDUQyN/jPO55l
         LIRpnB1E5l9RpYkKSwx3zC/hbVJoQM9C0SdV6FJRfoB4x9M+uP9sh07NeLA8xPQjse+B
         /YbQ/09bMd3cSjKXSQEn9XEGuIuygg2s1VT2epgd9VTkDofpJ5JZOiHvfZkduyjfCFV6
         pjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721438413; x=1722043213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EnhpRHHFeiUN0P1kueRwaaNcw6CDlqefq6wPjdm7rY=;
        b=A+sliByl/IDg3qgoL65veoOJD3cCcgs4201HlASMRTEXHA/8bBEqqUYiIhgWeUxmdS
         SQInJbcIohICTUoQY+MZOLCexFJPHf2n2AEB8H1dmH3GbfQGN6zgyB6HleAqCnWwIA5N
         BYt7S/tFPnNCzTOqXtAr4cPqlVVxZ0mb++3VEcyY5nTNe2xazDxkuO5BTBkoOR2vS7Ep
         Voaeio4+Rodt5kiEccmxJXqtGAv9+dZTAACzaj3Xgtsby0CEEDn1G9sQ0/AfBIHDOJ0V
         2OjNM+/ZrtxVY9IrY0I34XTZDAWvAT5UN15T08TZsYewhSGTxyhI3obrWeQLaXg6fjxN
         VcFA==
X-Forwarded-Encrypted: i=1; AJvYcCUiLKcV5hJNuuMPQHsgFConFZrMmVlGfuaXx1bP1dkznAFcKYlCnqY7wJk6EH5NjE8lobiOAYj+A1d8WRNwAmQ9hKvI
X-Gm-Message-State: AOJu0YzkDhFf+QjFiz4oenFNsIelKikaYJmqXBQFvrW7MBNIiRTgmQMW
	Stcb5JGSNm7SnZWFaT2LrJh7lcYfAaCrfxD2ziD1w7Op7K+wBlITsbOHiOC1PFTI1oJq5axfkSG
	GHMlLFlI7kvgtum2cu0tsPoZ51PqODW0+
X-Google-Smtp-Source: AGHT+IH8NwmaiC5u+U75e76VtJ8ErPb+wicjTSNjLrmjfmnadVbrCKHZYOcDUwSunP0O75MlfYtbRdjqYq1i0EmIpo8=
X-Received: by 2002:a5d:6584:0:b0:367:9769:35b0 with SMTP id
 ffacd0b85a97d-369bae4a188mr86283f8f.4.1721438412767; Fri, 19 Jul 2024
 18:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com> <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com> <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com> <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com> <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
 <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com> <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com> <CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com>
 <ce6f4648-9073-fd5b-a26b-187863e7070e@huaweicloud.com> <CAADnVQJ0gLSNNCnKeWMrHeoGG8DRG8kBoWxo3y0ubat-PgBcMg@mail.gmail.com>
 <90a50937-cca2-101a-799a-daf65956e6c1@huaweicloud.com> <3bf6cbb1-45f3-a338-81b8-28275526af70@huaweicloud.com>
In-Reply-To: <3bf6cbb1-45f3-a338-81b8-28275526af70@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jul 2024 18:20:01 -0700
Message-ID: <CAADnVQJirpYURVO-Njg=097L0T1mhkwO7dO2kXjnm4bCz9=mHw@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
> I had hacked bpf verifier (mainly check_stack_range_initialized()) to
> support variable-sized key for both qp-trie and hash-table. For now,
> only one bpf_dynptr is allowed in the key. I also update the benchmark
> in qp-trie patch-set [1] to compare the lookup performance between
> normal hash-table, hash-table with variable-sized key (namely
> dynkey-htab), and qp-trie. The key for hash-table with variable-sized
> key and qp-trie is shown below:
>
> struct test_key {
>         __u64 cookie;
>         struct bpf_dynptr_user desc;
> };
>
> For randomly generated dynptr key, when the max length of ->desc is big
> (e.g., >128) the performance of qp-trie is the best and it is 20%~80%
> faster then dynkey hash-table. Not sure about the reason why dynkey-htab
> is slower, it may be due to the overhead of hash function or hash
> collision. The performance of dynkey hash table is only 5% good compared
> with the normal hash-table when the max length of ->desc is 128. When
> the max length of ->desc is 512, dynkey hash-table will be 20% faster
> than normal hash table as shown below:
>
> | max length of desc | qp-trie | dynkey-hash-tab |normal hash-tab |
> | ---   |  ---         | ---      | ---     |
> |  64    | 7.5 M/s   | 7.1 M/s  | 8.3 M/s |
> | 128    | 6.7 M/s   | 5.3 M/s  | 5.3 M/s |
> | 256    | 4.9 M/s   | 3.4 M/s  | 3.2 M/s |
> | 512    | 3.5 M/s   | 2.1 M/s  | 1.8 M/s |
> | 1024   | 2.5 M/s   | 1.4 M/s  | 1.1 M/s |
> | 2048   | 1.7 M/s   | 0.9 M/s  | 0.6 M/s |
>
> When using strings from BTF, kallsyms or Alexa top 1M sites as the
> dynptr in test_key, the performance of qp-trie is about 40% or more
> slower than dynkey hash-table and normal hash-table. The mean length of
> strings in these input files is about 17/24/15 respectively. And there
> is no big difference between the lookup performance of dynkey hash-table
> and normal hash-table. It may be due to the reason the implementation of
> dynkey hash-table, because it invokes jhash three times to get the final
> hash value.
>
> | input | qp-trie | dynkey-hash-tab |normal hash-tab |
> | ---      |  ---         | ---      | ---     |
> | BTF      | 4.6 M/s   | 7.3 M/s  | 7.4 M/s |
> | kallsyms | 4.7 M/s   | 6.5 M/s  | 6.5 M/s |
> | top 1M   | 2.4 M/s   | 4.4 M/s  | 4.3 M/s |

Thanks a ton for doing this analysis.
This is very encouraging.
Clearly we need dynkey support in both hash and qp-trie.
Some users will use it to store filenames,
so the average might be > 128 and qp-trie will have an advantage.
In other cases the strings might be short and hash with dynkey
will be useful.
Also let's not forget that it's not only the average that matters.
Right now users need to bump the key size in hash map to a max
possible string while the average might be a fraction of that.
In such case dynkey-hash will outperform normal hash.

Looking forward to patches for qp-trie and hashmap with dynkey.

