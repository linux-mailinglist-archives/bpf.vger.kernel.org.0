Return-Path: <bpf+bounces-46813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCBE9F0324
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3112A281B20
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0AA15573A;
	Fri, 13 Dec 2024 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d90Q51fp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504513C918
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061154; cv=none; b=KKPSkWUh89XfENdO0CHwZviswXn8QLu++9MInCiMtiqioj+w+wh/znnz88Sgmg6Z5p7DyLL2Sq+BmzN6h2OBxorLHOJEhdPPit04VYa+NM5mfU3oFVDhjpefPpRYG1D371wlwfqQeo4CBUpXtn1WVgEh1xJ7KyEligp4HseNTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061154; c=relaxed/simple;
	bh=GkwXbMz+cyEHbDmiau87y31GV51ewOc6dij0g85kUJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuq+y/Kf63k1TGxIkuF23Ckzw5u8XB8U2Sd4M3TRnqjIr+jp5co9knC0G8BtqQKl6RxdsJkAyfylLKQT7x1K5YrOHCJrKNgj3dTVl1kzEJmS+lypF9txaXh4Rt6x5UVKhBOW+RyVvenBQOPyN36I0ovKNiUrtL6NcBtExRjBCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d90Q51fp; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4b24bc0cc65so709908137.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734061152; x=1734665952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkwXbMz+cyEHbDmiau87y31GV51ewOc6dij0g85kUJY=;
        b=d90Q51fpi+FxUrpbnXWIz1vkgtblpXhlm7WJOiCCWYP760i95Yjvotm0RxE3/VuweC
         eLs/idDJ+PREXKI+r+pe4XYG/w7UWCoJ5JakfLPVodec/xrf6KXd1aLiTKwjeblJirAq
         G7ai2h8noA58M/YbB8VIh/lZzIfMXfOBcq1577DXs8In/JeGd0C1+bAJfclLCD74P5hg
         4t3qAkSP4iHUGNpd3hynQwf0NkeVnCEQvq9eER89cSN0LTaCu6yHgCy7KAO+9zUszpO8
         3WD7wsxxAY4JIMa/n+6YUhs/nB2CJIMc+gNr2WZNR9LJGYUlhkcg3iIVCGvGGZuc/rfl
         J4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061152; x=1734665952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkwXbMz+cyEHbDmiau87y31GV51ewOc6dij0g85kUJY=;
        b=mFsW5RCIQlIGdXJYNEsjtTILfzqaVLGMRGs9H2jcJGB1k9dWzdSFSVr5NA+coutn6o
         qIKu635GhYpNR/rOh2ExENYWIvdJeZtkIoeUF+EqcEZbq4AmrzSuK9tILZ4gNpiCAXhv
         5S4pOiZ6sh6etb4x3h7WUxnNaWh7AsOHu+MpBIGYWR8AG2N7a2p+K7jXmSRZ4+PArTxL
         q45Tco8qHF5rRRzyin8ct3vrxM8w52wO6btNTAiMyrdC0GWm2McqCqGU10n6m2aDqFYU
         plbMz1gVlzWxbRcSBQkFJSBDkjru+xcRw3zS0I+ccuawWKCXsLUl6TzKeAVSTSVZk/YD
         BVNw==
X-Forwarded-Encrypted: i=1; AJvYcCXx+7bKq0hNS2nVoayuWATZ/Qx0xUXy+/ZK7RRPmDY0TOyCc80LeZitb2Bpq/H2Lyhswxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqfpf80gyoqCk/6FPCXPwVsRxp6eEaYdh+TmQUCWgvqSwdarr
	9OihHqatKoVnDuVFJV1LDKOcTpE7BSzMT9cbXmWxZTx95Ff0/dBenxmG+AWOgmDHKlk5xvdNeH4
	EEcwiGFlkKo22Nqhu9AbsKmzwlA4=
X-Gm-Gg: ASbGncscFP/JINaQ472h16/oen+a48Havi8xfFKq9fZ8JqnvFUU8h/l7T6xNfwmNr8Y
	y/qDVaD8q9SptxkYvuDkZFBvDvLPS5IEMvjiU1LD8evxY3bcR3RjtJJhWW5EWZTS2jcKxb2U=
X-Google-Smtp-Source: AGHT+IETzyh1DGOn+w5VpuCXv57S+SMV6M0I5E35dUvSYiRyaxhgeCgQojBt1G3Y/RaFQNH5XGo8S2kzbXoCjCXuIG4=
X-Received: by 2002:a05:6102:32c7:b0:4af:f8b9:bea3 with SMTP id
 ada2fe7eead31-4b25dcf1f72mr1449422137.15.1734061152271; Thu, 12 Dec 2024
 19:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
 <CAE5sdEjZCDqgtvAFd_MpTyc+68UMLDufbsS9H2wMOLJiHQJQyw@mail.gmail.com> <CAADnVQKSTqJOU_B7MQ-+Byt4GXLNFVv=ce32Y74F3=8DCWL05Q@mail.gmail.com>
In-Reply-To: <CAADnVQKSTqJOU_B7MQ-+Byt4GXLNFVv=ce32Y74F3=8DCWL05Q@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Thu, 12 Dec 2024 22:39:01 -0500
Message-ID: <CAE5sdEiCyF5rkDe7gq8ZKV4w5C_70Gorkc+uoO2MS+ZGekOeMw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Avoid deadlock caused by nested kprobe and fentry
 bpf programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Priya Bala Govindasamy <pgovind2@uci.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Dec 2024 at 22:26, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 12, 2024 at 4:41=E2=80=AFPM Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > On Thu, 12 Dec 2024 at 18:58, Priya Bala Govindasamy <pgovind2@uci.edu>=
 wrote:
> > >
> > > BPF program types like kprobe and fentry can cause deadlocks in certa=
in
> > > situations. If a function takes a lock and one of these bpf programs =
is
> > > hooked to some point in the function's critical section, and if the
> > > bpf program tries to call the same function and take the same lock it=
 will
> > > lead to deadlock. These situations have been reported in the followin=
g
> > > bug reports.
> > >
> > > In percpu_freelist -
> > > Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1=
WjB1pP9AzJLhKuLQ@mail.gmail.com/T/
> > > Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiK=
X9jy0MuL8LCXmCrQ@mail.gmail.com/T/
> > > In bpf_lru_list -
> > > Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=3D6A7KKULdB5=
Rob_NJopFLWF+i9gCA@mail.gmail.com/T/
> > > Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9=
U0OLJJYvRoSsMY_g@mail.gmail.com/T/
> > > Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nu=
zk3_oLk6qXR7LBOA@mail.gmail.com/T/
> > >
> > > Similar bugs have been reported by syzbot.
> > > In queue_stack_maps -
> > > Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@googl=
e.com/
> > > Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sina.=
com/T/
> > > In lpm_trie -
> > > Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47fa=
38@google.com/T/
> > > In ringbuf -
> > > Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sina.=
com/T/
> > >
> > > Prevent kprobe and fentry bpf programs from attaching to these critic=
al
> > > sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
> > > bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.
> > >
> >
> > I think the current solution is to use a per-CPU variable to prevent
> > deadlocks. You can look at the hashmap implementation for reference.
> > However, ABBA deadlocks are still possible, so to avoid these, I think
> > the BPF community is working towards implementing resilient spinlocks.
>
> Right. The resilient spinlocks are wip, but in the meantime
> we need to stop the bleeding.
>

Ok I can resend the patches I was working on.
https://lore.kernel.org/all/202405041108.2Up5HT0H-lkp@intel.com/T/

I remember that you shared the RFC patch set for resilient spinlocks
with me, but I didn't get a chance to check them at the time. Now that
I have more free time, I'd be happy to help you test that work if
you'd like.


> > I was planning to send patches for some of these bugs earlier. I'm
> > wondering if per-CPU checks would still be valid once resilient
> > spinlocks are introduced?
>
> The wip patches with res_spin_lock remove these per-cpu
> recursion counters from hash map and other places.

