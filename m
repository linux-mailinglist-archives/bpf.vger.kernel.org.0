Return-Path: <bpf+bounces-46822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D19F042C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 06:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204DE188AB7D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 05:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28E318871E;
	Fri, 13 Dec 2024 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnBKmUHs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A201822E5
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067673; cv=none; b=FcLcv51AnEwH0u30co+NLSMmpJwwn7HMkZoJYRYEbXMafiVi85afjHIWFm52mCG1e5m8pMZUvTbVH8MzaAcwbzWDKV4HjekOkIqD2AjT4ezJeZi/GubSm7adyq1+vv6IZAX8SEsr0JG3rrCxs2euG4ueC4w0NIr3QbzQDkn73jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067673; c=relaxed/simple;
	bh=cze7Vc9SctYOQfNE9CgtDvxA3KrhlppSqnYKM5ALE+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGZC5dheJAqkFD0v5Ly8FJUoTPKyKTdoPPyS3omZOf/bH2tcNW3JQ6SS5mVlFntILJarGNAyf61IjajNerZ+vFanSDIYOyLT9dP5LQ3L/HGXlzSU/q/H5A0jsq+vCf3o8pMnHBwhupKP7+nQubqmldP+kATgG3ZoaQG0L5rUbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnBKmUHs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so12650895e9.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 21:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734067670; x=1734672470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cze7Vc9SctYOQfNE9CgtDvxA3KrhlppSqnYKM5ALE+M=;
        b=cnBKmUHslfBddvVwr6PmMxcVnWeaZ1MGPKnyjz1XhfQhnSXoz+7aD8q3J95KDGJaEc
         YTk6ELsexcetUtkDPB/3clvpDzEX2riIFhYJIB7W41wnAkCpbBYwS4lOBO89s5ujrvLh
         trrij6vdIku7pKX4jBemWBkQeZVVebPQhbm571Jxi/vReSPfjH/UJ0jhMWhxCd371jnH
         8St4U3YeEBRzw5xev1s6FdMpIjDhFwMn9LRtAWNAoCnX8A4SPjuoa4hPkbLjAAihXE4h
         AJ8fJdcztxU8SM6dRvAh4XNsoAemxIkAEFrv3cGcMBSni78G3UB0scCF29uO3CnQFKSl
         0Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734067670; x=1734672470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cze7Vc9SctYOQfNE9CgtDvxA3KrhlppSqnYKM5ALE+M=;
        b=Tgv0cQFUs36rf8Y2dL54KTKhX/cP/TULliQg71muPYN/3svpWqrflYhGJzYZdI7coV
         hNgAOcq1YNuw3GhVEzKp6+Ct8FvAZHmz7Ue2ei/08zjdVVrLbGC8qEWtDy6xHmtE9d/u
         QjNKIWpuBElJRxL7CYs/mi6qtepMStg7+rlaFt5EDL53Zh4t+7ESzh6gWMBTrrZyRkTD
         mbaPwBplFqIy2587Sy+NUyIDTVzD0wjY2l7JNdiFp31YN7T+akdB4nNRRJ0i6xmrtblS
         74l94n4nJ7DiuKL8mLqre6siuCfCOG8EgTIPWibErQ9qX+P3rb6wx1OOgZeuP5sMJiCn
         qvZw==
X-Forwarded-Encrypted: i=1; AJvYcCXyWtNfSQWv009OkR2UtWBIB+f2PxMloVlTEWDc3O572A+4KiGSbNTZe2PMHG006qMm9Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvnpj4M1ao9dQcxiYAShzefrzEHjFQtGUrnGDlVr+6zVFqQPJd
	1TginJS0mTWclCTVgiDrqP7eXIc1BJW0DNBkCJVCB8d92Ur4lbsGp0q1XlHBsGcvKZBjPndnTFJ
	5qclv4hst36XijpnQIIZba6P5c5AEaA==
X-Gm-Gg: ASbGncvfHVBMXZmwU+gXeDb2K2v4sWvVbXc2931byctCvwIuN9f3Rm323ZgC1Um7am/
	ybz36QtMxLYG5wHTt06bTCNHaDg64MRYyPRJgiGpi+oZKb9inVmKoiQFvGOoPC8T8ybyYsQ==
X-Google-Smtp-Source: AGHT+IF2Kp2GTLo6ntpcWsWlhQCupHPpHPOO59aRPI7RMeZTdCr4Z+QyH3AxnHN/2ReSYQpGauhccpeoj2xZhc9K0po=
X-Received: by 2002:a05:600c:3548:b0:435:14d:f61a with SMTP id
 5b1f17b1804b1-4362aa9de27mr6780055e9.25.1734067669521; Thu, 12 Dec 2024
 21:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
 <CAE5sdEjZCDqgtvAFd_MpTyc+68UMLDufbsS9H2wMOLJiHQJQyw@mail.gmail.com>
 <CAADnVQKSTqJOU_B7MQ-+Byt4GXLNFVv=ce32Y74F3=8DCWL05Q@mail.gmail.com> <CAE5sdEiCyF5rkDe7gq8ZKV4w5C_70Gorkc+uoO2MS+ZGekOeMw@mail.gmail.com>
In-Reply-To: <CAE5sdEiCyF5rkDe7gq8ZKV4w5C_70Gorkc+uoO2MS+ZGekOeMw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Dec 2024 21:27:38 -0800
Message-ID: <CAADnVQJcizoR59sbksJX_u=i=2Fg9fkufbc0cXkYx4Yt49broA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Avoid deadlock caused by nested kprobe and fentry
 bpf programs
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Priya Bala Govindasamy <pgovind2@uci.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:39=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Thu, 12 Dec 2024 at 22:26, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 4:41=E2=80=AFPM Siddharth Chintamaneni
> > <sidchintamaneni@gmail.com> wrote:
> > >
> > > On Thu, 12 Dec 2024 at 18:58, Priya Bala Govindasamy <pgovind2@uci.ed=
u> wrote:
> > > >
> > > > BPF program types like kprobe and fentry can cause deadlocks in cer=
tain
> > > > situations. If a function takes a lock and one of these bpf program=
s is
> > > > hooked to some point in the function's critical section, and if the
> > > > bpf program tries to call the same function and take the same lock =
it will
> > > > lead to deadlock. These situations have been reported in the follow=
ing
> > > > bug reports.
> > > >
> > > > In percpu_freelist -
> > > > Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjq=
v1WjB1pP9AzJLhKuLQ@mail.gmail.com/T/
> > > > Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-P=
iKX9jy0MuL8LCXmCrQ@mail.gmail.com/T/
> > > > In bpf_lru_list -
> > > > Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=3D6A7KKULd=
B5Rob_NJopFLWF+i9gCA@mail.gmail.com/T/
> > > > Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9=
b9U0OLJJYvRoSsMY_g@mail.gmail.com/T/
> > > > Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1=
Nuzk3_oLk6qXR7LBOA@mail.gmail.com/T/
> > > >
> > > > Similar bugs have been reported by syzbot.
> > > > In queue_stack_maps -
> > > > Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@goo=
gle.com/
> > > > Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sin=
a.com/T/
> > > > In lpm_trie -
> > > > Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47=
fa38@google.com/T/
> > > > In ringbuf -
> > > > Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sin=
a.com/T/
> > > >
> > > > Prevent kprobe and fentry bpf programs from attaching to these crit=
ical
> > > > sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
> > > > bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.
> > > >
> > >
> > > I think the current solution is to use a per-CPU variable to prevent
> > > deadlocks. You can look at the hashmap implementation for reference.
> > > However, ABBA deadlocks are still possible, so to avoid these, I thin=
k
> > > the BPF community is working towards implementing resilient spinlocks=
.
> >
> > Right. The resilient spinlocks are wip, but in the meantime
> > we need to stop the bleeding.
> >
>
> Ok I can resend the patches I was working on.
> https://lore.kernel.org/all/202405041108.2Up5HT0H-lkp@intel.com/T/

No need. It's just more to revert later.

> I remember that you shared the RFC patch set for resilient spinlocks
> with me, but I didn't get a chance to check them at the time. Now that
> I have more free time, I'd be happy to help you test that work if
> you'd like.

That would be great. Pls help review when they are posted publicly
hopefully in a couple weeks.

