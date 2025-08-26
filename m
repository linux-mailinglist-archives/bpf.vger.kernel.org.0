Return-Path: <bpf+bounces-66540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D85DB35ECA
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B84162171
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15D307AE8;
	Tue, 26 Aug 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QspdVunW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101B2D191E;
	Tue, 26 Aug 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210048; cv=none; b=NjtbZFm8ptG42tGWgBiu1fgbWuv6kQ0fPFMLzrrRc1smu2XR977SS6E70JNqpGRAFt8ouhyh9A+QKBaST+5ncsW5J4kNoJzZF1RF+IcSuCRWrY04hFz2OBYiVzWqmHVMx2cWt5tOU4tgNxflB3Dz+leBJ3RNDihZAmGhFY3mDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210048; c=relaxed/simple;
	bh=ZFDpsRYroXi5afzGVAcwh8upOEupVtg/PqRbfYVLEgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoHT3u4SscYMPqCgc+IOnMOeBhFeCguJ2O7SdMS2OYO06Vyf9tyCn1BRUpryA4U9cL+oAq30Fdv5LrMHy4eKv5xj++JkeJAzeAy2d/fwy8J9D8OkbGtw/1Dj4q1FC7CW3LS0bYACtWQFZE3xLBrLWgk3S1gsYmZ8EL7JFZdqH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QspdVunW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70d9eb2eb55so21378476d6.2;
        Tue, 26 Aug 2025 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210046; x=1756814846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxc6shgrlQUVKkH8+ZjtV/WRz8nJSbsiLyiErGrHdIc=;
        b=QspdVunW3Ah7bQygw2k1T4Z9BLbH0Ku6wGn1uS6IKCrZ1vGJU9Ulqf/gqtCaY3wv4f
         GqlZrcI1KgpPI0cPEC2B3nmIWbOFP49lWBtDskJozTspoVdW1mWzg7X0dz7gkzA9+89u
         j7FDucK8aCkQRicve+CthuMGZ+H3iLiTk8crC07XD9xTUogHiVeKIkluAXOy75PJ3wrM
         ingeJBzSPa0vI4q3Cx6D+HeUBda6KhO8QA5+MuBVmVcqON+Kc21byGHFmYGsXuWddnPM
         qYJFa9nbELPwF2o+Ub3E55oGqw7blRLq+zKgM6Puu6sfEaBjX/AJTeOJOFddLU+x1+FL
         SXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210046; x=1756814846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxc6shgrlQUVKkH8+ZjtV/WRz8nJSbsiLyiErGrHdIc=;
        b=Y0LN2cEJU9GPfNl1u9bVMUZ3iSisJPgD5hvNKtCA6R+e463kUg3DrSbwpTaM3eZc7I
         TxBpa/YxobCKjdRxW0Vu1Q5U0zv8rA0IG6qr+QZKo3Zcm3bU6LTkOXZqqNgYXmge7YsW
         l5s0u5DJIasqN0KMrjVAkhmYTATAmgGojo6cHt4b/oHp/jKU0hMVaw2efQR+IN1xtA06
         NaG7PGwY02TQiNdDDBCLzmE6N5j3yvLkYkVuSupmhBsuL595y9Z6VQulJ/qx0+kBzPG2
         pL3hVrZ43FeA2jL6MLT61okJxQ3e+dX95SMV4qIT4anG6iJufLz1bDoeXbiQt/lTjDF6
         ooPg==
X-Forwarded-Encrypted: i=1; AJvYcCUObX7dTP9C3yxEaz1F9+lCQwkA1weCguIHVbrLUdY3T/4Z/XBtXhERNySqUvVWvhbFB6bwbf9JaAQV@vger.kernel.org, AJvYcCWYmCZPLKDJDHnpnUixjLzJHob5x6wXxHI2oChA2akrDGteDemxLpPotOmOYZwV1fHNq1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHR2HUQ6h7y1t58QnUxMvQ/US9qHQhZfoyENU/E5OGm/3TLSQ
	GNr8VJHoWbCnf27SlOoWYrweNvlY0vdO6DuQsWSzX24nL5VUq/KNJLxXVf1in6sPmpAJjX5cMMc
	uSjXthz3CC8jjSYb001Ond6qYr5UtyTk=
X-Gm-Gg: ASbGncvdoj8EKeIbbuw2KD4LPz3mS2qiCLCE6cLU4Qqg8wZjcu2C9prIROav+utilgS
	1ugEXebFlM1kRbSfbn9rcxI4bsIZTPOdDtznhPfcfW24vv1G8yPGPftWo+9rp0BJK+L7l1MVL6Y
	xlaJuau07r6F0xegxe23h9LHm+2mbEkbgE5HQXygwAh8VcgJLvHiz7QQ2OfUN6LJrGoCBIHLTqL
	kmpk87IiyOO/TCtlZH1XQRlnB8CCXKggNy0xsxb
X-Google-Smtp-Source: AGHT+IEIM2EgMj1lrnPfc/QLZaI/SIuaTUMHPn65O0erOt+9ClYGQVe1+p6+wCBP890WHjKTvNzMiK21AyXb7Ep4gFQ=
X-Received: by 2002:ad4:5cad:0:b0:70d:6df3:9a88 with SMTP id
 6a1803df08f44-70d973f45e1mr137706786d6.56.1756210045540; Tue, 26 Aug 2025
 05:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <d8f723c4-4cb0-431d-9df2-ba4ec74c7b43@redhat.com>
 <0398bfc4-49f5-4a7c-abba-90151002ff82@lucifer.local>
In-Reply-To: <0398bfc4-49f5-4a7c-abba-90151002ff82@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 26 Aug 2025 20:06:49 +0800
X-Gm-Features: Ac12FXw1g5xEZf3xxD5gs1s1dLXr_RGo94IW44IbmphAAO8l9ciefTUsmal1AOk
Message-ID: <CALOAHbD+qoqHSGCRRy5082x0z1SbhZt5XqsPYoL7GsrDDoto-w@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:33=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 26, 2025 at 09:42:30AM +0200, David Hildenbrand wrote:
> > On 26.08.25 09:19, Yafang Shao wrote:
> > > Background
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Our production servers consistently configure THP to "never" due to
> > > historical incidents caused by its behavior. Key issues include:
> > > - Increased Memory Consumption
> > >    THP significantly raises overall memory usage, reducing available =
memory
> > >    for workloads.
> > >
> > > - Latency Spikes
> > >    Random latency spikes occur due to frequent memory compaction trig=
gered
> > >    by THP.
> > >
> > > - Lack of Fine-Grained Control
> > >    THP tuning is globally configured, making it unsuitable for contai=
nerized
> > >    environments. When multiple workloads share a host, enabling THP w=
ithout
> > >    per-workload control leads to unpredictable behavior.
> > >
> > > Due to these issues, administrators avoid switching to madvise or alw=
ays
> > > modes=E2=80=94unless per-workload THP control is implemented.
> > >
> > > To address this, we propose BPF-based THP policy for flexible adjustm=
ent.
> > > Additionally, as David mentioned [0], this mechanism can also serve a=
s a
> > > policy prototyping tool (test policies via BPF before upstreaming the=
m).
> >
> > There is a lot going on and most reviewers (including me) are fairly bu=
sy
> > right now, so getting more detailed review could take a while.
> >
> > This topic sounds like a good candidate for the bi-weekly MM alignment
> > session.
> >
> > Would you be interested in presenting the current bpf interface, how to=
 use
> > it,  drawbacks, todos, ... in that forum?
> >
> > David Rientjes, who organizes this meeting, is already on Cc.
>
> If we do this, would like an invite to it also!
>
> Have been meaning to take a look into this in detail while in RFC but mor=
e so
> now obviously :) as discussed in THP cabal, I am broadly in favour of thi=
s as
> long we get the interface right.
>
> Anyway let me have a look through...!

Thanks in advance.

--=20
Regards
Yafang

