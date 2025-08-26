Return-Path: <bpf+bounces-66541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6D4B35EDE
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC8176421
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF43283FDF;
	Tue, 26 Aug 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr5Vk+VG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEB2BE65E;
	Tue, 26 Aug 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210283; cv=none; b=JfkY7be3n2PR/pVCZW7DscJ4/HRmdvW1IzVKj0zxdKxe5qbD96vbO6dYChV1faHKhkwJfxaifuUIGEryV6sfk+6ttmcQaVysVKTTsc7Sw/ahgbsK1StymHtSmEwBqvm/518TcSzSBsCUvQc8VNlXxlnR2uGRw0pqKW2FU1rYpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210283; c=relaxed/simple;
	bh=tipYMmdsLBgTBftBP3YvTSH3R4gUZBdkBpMU8Rtydsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiOBlgJmtwxwrrLG0Su3XJa+E83Rar2PtRwfQNrnNd2nZwcyAykUzhcjdrU3G43w5gZFP2DfTv+N0P+40Fk/TX/N1CHedczXCW/pvef4LelsqtUuK5up6OdipZU43lK81Q0FPRUspxVX5DJWL864DMqk5e93WoJztHIkYJCFzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr5Vk+VG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70d9eb2e655so45752386d6.0;
        Tue, 26 Aug 2025 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210280; x=1756815080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImL/pg0xdjCGRWENhybt6xqpo1ixfGJNV4xBI1zktCQ=;
        b=Nr5Vk+VG+AxcedxJz5kN9hJHh291ICE1XhFNscG9jetWwBIXKGpV5Bh6fgioB9Ll/t
         HGzEy80au/ZsJxmSTIvBsEK+lX/IRPSSMHPOjHEuztg2gAf+JBykUpGTwFVPA7GZVNyN
         3lk/XoPqxu0CVRKn6LQHRPP9ndFpUn3lw7nbDfWisb6gLWEjDGwtX8wZza1nFw/Ymj46
         kCD41U1TnOWaUEO/SykIlDoPOswJ2Z/40hKGNqymu/kPxPJnk4/yxMlAfOUT+8TEK/Pv
         6kOtr5VUs1F/CfI9D0zf5qabGyO+gN42m6eDMVC7S0TK2uZqU3vYWdHSJ531jIj8A3Oi
         L/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210280; x=1756815080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImL/pg0xdjCGRWENhybt6xqpo1ixfGJNV4xBI1zktCQ=;
        b=kUl0I2QOunZb2pLsqzOUBucVrALsQdZpvR50fkNcg6f7od7aoL0P952BufqYL30xYl
         ZU5o9TXOYKlkWzcn5Kg8OwvtOeJCnyO0/fJZyFxKXdKGuRA4gQgClYXCEo6Fpk6OvFQN
         FTQ8tOBxpR8EvkbEwszCX9RAmqSeDvbf0fNS8Uum4Xi6MiwqARbyiq+JJu9F8DJsaoi6
         EP+D2Sxx49oFAlXyUWQTzRH6lZB6FY0yGH3oicTUI5pcdVVbdy58UaT2v2B0WSLizZVd
         ylbdsS+8M1AFxprlHT6h819RychkbdL5lnUdJdyTm5LJ1qcBE5S6+i+yrzqN7yeHhAhn
         xftQ==
X-Forwarded-Encrypted: i=1; AJvYcCViXLrqvlI2DFLvXh+sl+NZLPxAdnR+zNfXi7nnpUT0KWqKEoFR2R17SuElfyNP1sMys+jwyjIYJ24J@vger.kernel.org, AJvYcCWFJZGGJsJKF9MMGR/uX0edwvMUxM93KgkW68cTxN2bzsA5T/qGqICmhXQK6erxFyghqVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiuvQdCA+0D3IHzOe68l8Fuf3wOTctQruLi49A1iDKJe1zfoZB
	Ym8DgFcrjsXSZyolHPzTEeFoLZMY92EgGQ53x80rI5LkGblRK07noMOy4VBal48MubUoDtNbdnf
	D25ILcOLWnyrWaBEMx3vZKyRejcvYRSM=
X-Gm-Gg: ASbGncsVqjFpK2chZNw55HdPebMmMW+OrrGHyt5htGxSc/OzlfVsSk9Nxt51VMRokSZ
	rBcv2Kc0xUXDPVv6w2f4oTaXwfZWXQ/RWAJiWMvWX6kmzoeJgWbm8PC/1rCVslMjFGPq4SNu/Mq
	0BSE5oApOxwMReL52I/qJU6wKLV0DlaWfkPBtRHlAB6BNpbMsq/F3dI6ShHm7I+bwcmx4G5EmcZ
	ubsN4UkcUchA7Vngq7YrG2Kzhlh+pBayICeGJHV
X-Google-Smtp-Source: AGHT+IEJAG2qKNzxlah6l/w2L3/KsxC8SauReCHdhKHjO7bLzRLIuTYZp5EjbFuJL94qP6L3iBxwYtkrnQTe9YDl6e8=
X-Received: by 2002:ad4:4f09:0:b0:70d:9b08:8df4 with SMTP id
 6a1803df08f44-70d9b089047mr125928626d6.67.1756210280301; Tue, 26 Aug 2025
 05:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <d8f723c4-4cb0-431d-9df2-ba4ec74c7b43@redhat.com>
 <ed4fc853-97ce-47b3-be80-4de9627c3276@gmail.com>
In-Reply-To: <ed4fc853-97ce-47b3-be80-4de9627c3276@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 26 Aug 2025 20:10:43 +0800
X-Gm-Features: Ac12FXzZZhivnVJyBOI8iejkd_haUHtgHc6xuPfqezPTB1X-J44KnLBSJW6VTiM
Message-ID: <CALOAHbB=b4wCT9WFOyRUgWo08=tBvnMQrBWrfAKM0mgJxEB2og@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:52=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 26/08/2025 08:42, David Hildenbrand wrote:
> > On 26.08.25 09:19, Yafang Shao wrote:
> >> Background
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Our production servers consistently configure THP to "never" due to
> >> historical incidents caused by its behavior. Key issues include:
> >> - Increased Memory Consumption
> >>    THP significantly raises overall memory usage, reducing available m=
emory
> >>    for workloads.
> >>
> >> - Latency Spikes
> >>    Random latency spikes occur due to frequent memory compaction trigg=
ered
> >>    by THP.
> >>
> >> - Lack of Fine-Grained Control
> >>    THP tuning is globally configured, making it unsuitable for contain=
erized
> >>    environments. When multiple workloads share a host, enabling THP wi=
thout
> >>    per-workload control leads to unpredictable behavior.
> >>
> >> Due to these issues, administrators avoid switching to madvise or alwa=
ys
> >> modes=E2=80=94unless per-workload THP control is implemented.
> >>
> >> To address this, we propose BPF-based THP policy for flexible adjustme=
nt.
> >> Additionally, as David mentioned [0], this mechanism can also serve as=
 a
> >> policy prototyping tool (test policies via BPF before upstreaming them=
).
> >
> > There is a lot going on and most reviewers (including me) are fairly bu=
sy right now, so getting more detailed review could take a while.
> >
> > This topic sounds like a good candidate for the bi-weekly MM alignment =
session.
> >
> > Would you be interested in presenting the current bpf interface, how to=
 use it,  drawbacks, todos, ... in that forum?
> >
>
> Could I get an invite please? Thanks!

IIUC, a Google Meet link will be shared publicly on the upstream
mailing list, allowing any interested developers to join. If the
session is invite-only instead, I will make sure you receive an
invitation, given the significant help you've already provided for
this series.

--=20
Regards
Yafang

