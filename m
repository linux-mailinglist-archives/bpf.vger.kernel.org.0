Return-Path: <bpf+bounces-52711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3158A471EF
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 03:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6B016467A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9294D54670;
	Thu, 27 Feb 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwBjn93x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739394683
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622067; cv=none; b=MJ5LXomXDlJM7pdutdewK0SZPNnD41X7/vk49h20NkMJSNJXOmjIWM87LjdV8iO5SFZ+qvjEUD+mykP21j68ivNXcMAM367WN469P42FoYeqYW2nwrVZTZC5otqP/UehRVG5IEhzyA/8/krf9qyOCCYP4SLYN9u742XLYJXokHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622067; c=relaxed/simple;
	bh=argCNlVnOk+Y0c53jVwAIJoBOFJW3ju5xKDbJbMd8Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEufzogH1iSzRzK9gB5Lx36orovD0Xj8slGC9AQwWJbq9uWhNbXfPfvU76Xste8afN7hJrkkSgHiYcCp+I9XaZVumuQ7JdhDTRzizaVfJ9qO8MtdpGGFCa/nIDSz0oiPaZ95+0Ciixg/AFVDhutyYT9goeG/0yNWdrUJL9H4LIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwBjn93x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4397dff185fso3949715e9.2
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740622064; x=1741226864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCSmeF9tLwr/pqUZcK0GbEP66MYsnW4eQxFP9ntC94Y=;
        b=IwBjn93xV2REcEEKrYb7sMk1nW3+vActRmOkMnq9Xo9WyqeLNQswHddN772va7JHxa
         nSWpgoJC6ZWmcFlBDWBLUNeqtWG4wVuI6AZorE3rXsEINOtYc5UApxibH0y1tO3rIQ26
         rPXE2ZJWfktgWx6G1ypSLGUQ14v7NDYyQBe+kDisCwY+9nACBKO7c9P/EY61QBFnZYK6
         Od6fMHkqr8PSyAVfINgAVNcrcuoPlQkGCyGUFxu8gHTZ9l62OSpZKrsXyGv+xuyVa49v
         2s+lRI+mFbbiHa5ie5S4q7cJb4VggVm9Fxq33Hsb6uFCELciESGr4IuCa4A0n/MQiae/
         /KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622064; x=1741226864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCSmeF9tLwr/pqUZcK0GbEP66MYsnW4eQxFP9ntC94Y=;
        b=CtZjvhXdkiiKJ7wVrk6BY0r9bt3ZJMEi9hqSRvKlZ8yHr+HkK4SdBUX85T/Afzjhei
         pqBHe4i/mudjLFKG9TFYZ/QTrR7hknPINLr3XKN95hHbnJzrqqvxpWzmFl7gIQ/HPhxw
         Fk2iEn6sGPD4M2lcBwQ0VNacRild/m77zCGOdm9MhDMLIejS82ZiMPRvk6direz9y0AS
         C4D2spRM7CTz+re0lItzfWO218qmq4v+z+UGce+jOo6EspwqeBhVG6BSOfQvjKOknC8T
         MHc2cIJXYkGpnlF5fMmUA/qgTZmclTtlqq2SvR4qxO/BhWLFhvMrjAY+mozBbB1cGlSm
         qCww==
X-Forwarded-Encrypted: i=1; AJvYcCUCDn1l2IkkR/Au4ivDCh0as/dingfSdKB/ecaBAFpHCx1zudv/G0T6e5cX27MnJe6+Le8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywer5Fkpx4d6jJCLpvJATxTtrv1FuzpEMi4MGSLQSv1pbgw9YYb
	rwcIWYIFih2ZH0hwHJ/pltSBPe5u7qxevhOvpHgl0mt//DnIipzKG6GuSXgbJjqFKsKkUbbiT+3
	qh6cawAgzoAGD8Nh9pYVbQaHd3pg=
X-Gm-Gg: ASbGnctXiekDf7RHp2zdIUjD6k4ScmgJXAR55rKIZcX1b4YcfX70gE5bhmf7YDWQRq3
	SVj5whZxeMudkuON0XWjbffKGbnAtUjb+3Zde2tQmphENKn9Put9RZyhXWNbt9zf2pccIc/K/07
	JD2xFD8PDp69orgYwwuzbDxVg=
X-Google-Smtp-Source: AGHT+IGYPoUhqHzJ1757HWv7fSCcFfr0WoX2tS9iJiEpcRvkdnGLVjKDeZrby77hKWM3i/46R5+Qr2Pg1D4U9rfwvcU=
X-Received: by 2002:a5d:5f4e:0:b0:38f:4a0b:e764 with SMTP id
 ffacd0b85a97d-390d4f4306cmr4933878f8f.28.1740622063655; Wed, 26 Feb 2025
 18:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7zsLsjrldJAISJY@bkammerd-mobl> <ed150c6e-7987-4729-8a6b-e1e9e38823cb@linux.dev>
 <c19ee119-a463-f4bb-d15d-b7fae0a1ff4a@huaweicloud.com> <Z73svxvnH4dW9PZH@bkammerd-mobl>
 <07491b89-cf95-b467-e670-dddd470bd572@huaweicloud.com>
In-Reply-To: <07491b89-cf95-b467-e670-dddd470bd572@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 18:07:31 -0800
X-Gm-Features: AQ5f1Jomn41-ovfzsk6p6NpaYs40INcRf6c3B-_m6ltOEbNy1xwej73wVbjRgMY
Message-ID: <CAADnVQLSgTDyddxANS76M0ctf_gSz-pGCCZhqfM9v32GGtUh6A@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix possible endless loop in BPF map iteration
To: Hou Tao <houtao@huaweicloud.com>
Cc: Brandon Kammerdiener <brandon.kammerdiener@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 5:45=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/26/2025 12:15 AM, Brandon Kammerdiener wrote:
> > On Tue, Feb 25, 2025 at 08:26:17PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 2/25/2025 3:13 PM, Martin KaFai Lau wrote:
> >>> On 2/24/25 2:01 PM, Brandon Kammerdiener wrote:
> >>>> This patch fixes an endless loop condition that can occur in
> >>>> bpf_for_each_hash_elem, causing the core to softlock. My
> >>>> understanding is
> >>>> that a combination of RCU list deletion and insertion introduces the=
 new
> >>>> element after the iteration cursor and that there is a chance that a=
n
> >>>> RCU
> >>> new element is added to the head of the bucket, so the first thought
> >>> is it should not extend the list beyond the current iteration point..=
.
> >>>
> >>>> reader may in fact use this new element in iteration. The patch uses=
 a
> >>>> _safe variant of the macro which gets the next element to iterate be=
fore
> >>>> executing the loop body for the current element. The following simpl=
e
> >>>> BPF
> >>>> program can be used to reproduce the issue:
> >>>>
> >>>>      #include "vmlinux.h"
> >>>>      #include <bpf/bpf_helpers.h>
> >>>>      #include <bpf/bpf_tracing.h>
> >>>>
> >>>>      #define N (64)
> >>>>
> >>>>      struct {
> >>>>          __uint(type,        BPF_MAP_TYPE_HASH);
> >>>>          __uint(max_entries, N);
> >>>>          __type(key,         __u64);
> >>>>          __type(value,       __u64);
> >>>>      } map SEC(".maps");
> >>>>
> >>>>      static int cb(struct bpf_map *map, __u64 *key, __u64 *value,
> >>>> void *arg) {
> >>>>          bpf_map_delete_elem(map, key);
> >>>>          bpf_map_update_elem(map, &key, &val, 0);
> >>> I suspect what happened in this reproducer is,
> >>> there is a bucket with more than one elem(s) and the deleted elem get=
s
> >>> immediately added back to the bucket->head.
> >>> Something like this, '[ ]' as the current elem.
> >>>
> >>> 1st iteration     (follow bucket->head.first): [elem_1] ->  elem_2
> >>>                                   delete_elem:  elem_2
> >>>                                   update_elem: [elem_1] ->  elem_2
> >>> 2nd iteration (follow elem_1->hash_node.next):  elem_1  -> [elem_2]
> >>>                                   delete_elem:  elem_1
> >>>                                   update_elem: [elem_2] -> elem_1
> >>> 3rd iteration (follow elem_2->hash_node.next):  elem_2  -> [elem_1]
> >>>                   loop.......
> >>>
> >> Yes. The above procedure is exactly the test case tries to do (except
> >> the &key and &val typos).
> > Yes, apologies for the typos I must have introduced when minifying the
> > example. Should just use key and val sans the &.
>
> OK
> >
> >>> don't think "_safe" covers all cases though. "_safe" may solve this
> >>> particular reproducer which is shooting itself in the foot by deletin=
g
> >>> and adding itself when iterating a bucket.
> >> Yes, if the bpf prog could delete and re-add the saved next entry, the=
re
> >> will be dead loop as well. It seems __htab_map_lookup_elem() may suffe=
r
> >> from the same problem just as bpf_for_each_hash_elem(). The problem is
> >> mainly due to the immediate reuse of deleted element. Maybe we need to
> >> add a seqlock to the htab_elem and retry the traversal if the seqlock =
is
> >> not stable.
>
> The seqlock + restart traversal way doesn't work, because the seq-count
> for each element will add 2 after the re-insert and the loop will always
> try to restart the traversal. I have another idea: how about add an
> per-bucket incremental id for each element in the bucket and during the
> traversal, the traversal will ignore the element with id greater than
> the id of current element, so it will ignore the newly-added element.
> For example, there are three elements in a bucket list: head -> A [id=3D3=
]
> -> B[id=3D2] -> C[id=3D1]
>
> (1) pass A to cb
> current id =3D 3
> cb deletes A and inserts A again
> head -> A[4] -> B[2] -> C[1]
>
> (2) pass B to cb
> current id=3D2
> cb deletes B and inserts B again
> head -> B[5] -> A[4] -> C[1]
>
> the id of A is greater than current id, so it is skipped.

This looks like unnecessary overhead that attempts
to reinvent nulls logic.

At present I'm not convinced that lookup_nulls_elem_raw() is broken.
The only issue with bpf_for_each_hash_elem() that loops forever
in this convoluted case and _safe() is the right fix for it.

