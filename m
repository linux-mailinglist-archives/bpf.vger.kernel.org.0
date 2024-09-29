Return-Path: <bpf+bounces-40471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6C99892B2
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 04:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29B2281D74
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 02:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851818643;
	Sun, 29 Sep 2024 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIm/6YTK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287917580
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727577388; cv=none; b=oIjBDxTXcVqCUZEJuFheW7Ib2/sxAtX4QCKCnKp1VJPtmjRit6Eccrx5EHihhzKgUO1JoufNZJdaYO1Api7QTfxsickPfGY/oPJgjAiLegb7SHa4QCzRQVpufHVg7z5+iaaHekbvbJomqlgjpF32R+tONpOpVlKnmawQZcqeEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727577388; c=relaxed/simple;
	bh=59mvwWi6RQzoPbPg5e+KkwJP1DJZ3g6dTtA+cKqSdGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDuUtUOknJL/D6HCY6AhGLLUxk7J8XTa1GopOZa//PvApMVfMdf9pqUwfP+19HQMmqn/VnUHTg2/j0Gcw/kF9GLe8gC4Q3WtahAC4GtV3fLNvZByFbnQxo763bkP+lxxTN73nJ/QZJeLrgFQ+8UBIe11NcKWFlwUxce5eYNV3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIm/6YTK; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2aaf4a73so33429346d6.2
        for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727577385; x=1728182185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59mvwWi6RQzoPbPg5e+KkwJP1DJZ3g6dTtA+cKqSdGw=;
        b=AIm/6YTKkcnvkSIifxX+y1IV0miPDuO1+lXqe1OAEb6RXG5C4YDhftZhVNEESmzv5g
         x1YoMv9WvLteVOopyF67BlL1M5/kYCGXAN0m4KCGlHTSdjVwh8GuVI71gRtojHbjVBDC
         xtzaye9UjSDiDeBRHOheK0mJneL9W4Y5MifvCNTitXK8gtI0rH/6e8zhT6c6VH2ke/8q
         0DKKC7iRiJU63jXW8T073f6AYaVKguRt0OES2DHMe/NQy9JB9tUVz+60liqCmAqv24Io
         /P8nHkRFkajnMZAlagWoF0IaYsWYEPnv67IIf31X2YuDV7fZTsIADvkF6sLgC/5ZXe8O
         Jmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727577385; x=1728182185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59mvwWi6RQzoPbPg5e+KkwJP1DJZ3g6dTtA+cKqSdGw=;
        b=LxY+u6+ObEytnNoUFPtVBAjXWAT1bVXiYvH5mehAb2Pc4IXBdGEUdr5jUrxbv2u11T
         sczVEaQC1DbKwdZ2SaOBTfRX+W4JOCtb7FGj7EPQxVkpp72Qg6eRLEkWDm5lWw2ZB5bZ
         CQwFkqlO4XuxM4NTD/sw53stY0QQSBSF9kuxG466MRy+DK///vLiL4VKUV8nr+zimv96
         5n+7sx1OIoBIbzLhPaPNu74zhRUzXWwk6cPiaAT3Pro7uCnPo//jS8rXgIQZaUYtukQM
         HlEkegq6SzAZGN3T4dt8Anc6qvN9I9KaFvRX3hthV6beRCRe6yiRKiK1Flzro/ABdlAg
         mxew==
X-Forwarded-Encrypted: i=1; AJvYcCV8fap7+7ALAtfmf81H7Xz3KgzVpoPOwJm9wbVSyegXdAibWrypdsj0HbjZDG2L4IMi4Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIap8sHhDfuuLJPNlUMliqgtVJfykSg+c9T9ZVviqne4R6KzGB
	Q5ron0km2Mga0bXFYfBLFW3mpBdbIl1UgB10unbKcB2o4h+G2MVq1+Zonk3Geu+BlGHmoG13rvX
	Zr/4mhZa44GqjyD0Mq2bm4829BFNeKcoxG5g=
X-Google-Smtp-Source: AGHT+IE23PAsfFq/+xWxfN+cB/wsJE4BNmo51E9hWeFSIMTWqBwQBIzjxnuAPunOnnWffcb1bMshOzSUdRfdzN+kdlo=
X-Received: by 2002:a05:6214:3a8c:b0:6c3:5c75:d2bc with SMTP id
 6a1803df08f44-6cb3b66fab3mr136766536d6.47.1727577385531; Sat, 28 Sep 2024
 19:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABVU1kWEHkt+z1c0vu1bXMn81iY8rDjwU=B6KPi2dPVvgeZUPw@mail.gmail.com>
 <CAEf4Bzbeqj3qneOEvKqcMf2XYx-1E=RKcAMo2L2oJz4qqqKbuA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbeqj3qneOEvKqcMf2XYx-1E=RKcAMo2L2oJz4qqqKbuA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 29 Sep 2024 10:35:49 +0800
Message-ID: <CALOAHbBTLXWJ5EnXUzD-nGFxes-Q+Wu_-KPDZWHUKFfXsvdM0w@mail.gmail.com>
Subject: Re: bpf_link_info: perf_event link info name_len field returning zero
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tyrone Wu <wudevelops@gmail.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 7:14=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Sep 22, 2024 at 12:59=E2=80=AFPM Tyrone Wu <wudevelops@gmail.com>=
 wrote:
> >
> > Hello,
> >
> > When retrieving bpf_link_info.perf_event kprobe/uprobe/tracepoint
> > data, I noticed that the name_len field always returns 0. After some
> > digging, I see that name_len is never actually populated, which
> > explains the 0 value.
> >
> > I expected it to function similarly to
> > bpf_link_info.raw_tracepoint.tp_name_len, where that field is filled
> > with the length of tp_name. However, I noticed that the selftest
> > explicitly asserts that name_len should be 0. I was wondering if
> > someone could clarify whether it is intended for the
> > bpf_link_info.perf_event name_len field to not be populated.
>
> This sounds like a bug. It should behave consistently with the other
> users of input/output string buffer size fields: on input we get
> maximum buffer size, on output we should put an actual size of the
> string (especially if it was truncated).
>
> Yafang, Jiri, WDYT?

The reason name_len is 0 is that the user did not set both the buffer
and the length. IOW, this happens when the user buffer is NULL and the
input length is 0. However, we should make this behavior consistent by
returning the actual size to the user if both the buffer and length
are unset.

I will submit a fix.


--
Regards
Yafang

