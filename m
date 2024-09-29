Return-Path: <bpf+bounces-40478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9AF989369
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 09:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58018B23959
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554913A271;
	Sun, 29 Sep 2024 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCAUGEGl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282C2B9BB
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594369; cv=none; b=ptXlqG2/UCs6BWqxuKcuPzryqxB97WX0BAKCX+5FxSIHVkM4b/kzbfdhotHGCjQhppZXG/1N51c/k5Pxyn3qNzamIqywgRco+dbt3ksQgl+ADUkwyvyVUwvCGVZ6FXs3Xu49hAJVVvE2Kp9dhZPFuPiHztbtoZZegR7I6spnmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594369; c=relaxed/simple;
	bh=nZy09d4cw6Wq1RlXKHinEZMdmEdR4p9R4lXxTT47MMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6GLOG7qxVn8/etiiU1cE0U5bQydAReKaB5+pup0znghB9jYHy/MiQcfN+NLGoU1CHJd4CPWTKe4NPgN7Ks4ajaaHHu7Fn7gLTviK4+DYygjOvAWpO1lt8a2FZUA0q26hfqq2KxOGujCOV1PWrHwU15DzIvPYh3yCKNrAVpS91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCAUGEGl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71b20ffd809so2332479b3a.0
        for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594367; x=1728199167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZy09d4cw6Wq1RlXKHinEZMdmEdR4p9R4lXxTT47MMw=;
        b=lCAUGEGlle/ioCALT095TizTrdI6gWJRJ5m+hwr5ZlMN6lByLdtwHuBIFknh1W57kv
         HPzRvh/PwX5OfN7uIkJqC43gW7uYV1bZcze7MOJ4iGU9o1uhiV7dvmCwkgeYvlKNP9Iu
         1N+YrqL0/SY1KGHnizaM3Gog4sYk64c/esZZZ1XDKPyYL/8XsWJ07UIpK7L+pngr7p08
         zzwVWDdZgW4FBZO/bpNCnIP3nb6KTTnQ3m131aKvTBv/04+b8xucWqXbDazbxIXsjYn4
         P5lpBR+1x6AGyQSSV9P7iHu2woSpCBYFNBdeGLS59xB7nn3aqx4z1DrxrYUrxYxSwwvM
         CMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594367; x=1728199167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZy09d4cw6Wq1RlXKHinEZMdmEdR4p9R4lXxTT47MMw=;
        b=oTqhjxcHh95JZ28/9x58e5RRHseOL0P2XfA48NND/WcY5YOn+fxzzmnH0IuHOpDQ5W
         oKhMHOz6h+MCftvgPD64yumdqcnTgTu92+4WK/AS98Ty1x5DstmJXpdkSz4V0SQaoRzq
         zeVqokn0eLQ450sZkte5NLNl8n4+YFWEIh2X5lnXeh0+2YVUWckv0w/3EHzQ4h0HTCrB
         sb3uu+eGih9qxvP82oLebylILGbYyOXP0+afmDk167kXjOHw2CHyW3Qw+mBNKJWe8RMr
         xUnohgS0aj4bz50p/TZrWz7a50ivRotvH+0UUv4VVV7g3JeX2rj6qNHUiaiTJF0t7Ebf
         6SSA==
X-Forwarded-Encrypted: i=1; AJvYcCUM9M0LwLhtjlmxzqygwpBqnFy9e44F5CSw6MFACW/xuBWHrfccLVij0MOxStpjj+dlvQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwFFZcPTS1pXkNU1gSH2+rJj2TClAlH+GlZlD++Hd/LTsfddsH
	3dwD++C/c/UlPqDOR5JpTtiY+qDs8ScfKS5MaNE7KX4mWt3V+sSgTQT5dNOldo7tvItHA4aocpC
	wrZns0bGPF3H34qIREcBANsdbGrQLWs+Ngl8=
X-Google-Smtp-Source: AGHT+IHBaX7zToremk/eIcYJc0mZkosIgQANFk8r/j2Xc5ueYJYRcOmH4TWt8kecNIiq1A0kMoF/aA9ieu29mf7N5Nw=
X-Received: by 2002:a05:6a00:9a3:b0:714:2014:d783 with SMTP id
 d2e1a72fcca58-71b25f275aamr12910498b3a.2.1727594367018; Sun, 29 Sep 2024
 00:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABVU1kWEHkt+z1c0vu1bXMn81iY8rDjwU=B6KPi2dPVvgeZUPw@mail.gmail.com>
 <CAEf4Bzbeqj3qneOEvKqcMf2XYx-1E=RKcAMo2L2oJz4qqqKbuA@mail.gmail.com> <CALOAHbBTLXWJ5EnXUzD-nGFxes-Q+Wu_-KPDZWHUKFfXsvdM0w@mail.gmail.com>
In-Reply-To: <CALOAHbBTLXWJ5EnXUzD-nGFxes-Q+Wu_-KPDZWHUKFfXsvdM0w@mail.gmail.com>
From: Tyrone Wu <wudevelops@gmail.com>
Date: Sun, 29 Sep 2024 03:19:15 -0400
Message-ID: <CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com>
Subject: Re: bpf_link_info: perf_event link info name_len field returning zero
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The reason name_len is 0 is that the user did not set both the buffer
> and the length. IOW, this happens when the user buffer is NULL and the
> input length is 0.

Thank you both for the follow-up.

> However, we should make this behavior consistent by
> returning the actual size to the user if both the buffer and length
> are unset.
>
> I will submit a fix.

I actually made a small patch for this when I was initially exploring
this behavior. If it's alright, I can submit this after some clean-up.
:)


On Sat, Sep 28, 2024 at 10:36=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Sat, Sep 28, 2024 at 7:14=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Sep 22, 2024 at 12:59=E2=80=AFPM Tyrone Wu <wudevelops@gmail.co=
m> wrote:
> > >
> > > Hello,
> > >
> > > When retrieving bpf_link_info.perf_event kprobe/uprobe/tracepoint
> > > data, I noticed that the name_len field always returns 0. After some
> > > digging, I see that name_len is never actually populated, which
> > > explains the 0 value.
> > >
> > > I expected it to function similarly to
> > > bpf_link_info.raw_tracepoint.tp_name_len, where that field is filled
> > > with the length of tp_name. However, I noticed that the selftest
> > > explicitly asserts that name_len should be 0. I was wondering if
> > > someone could clarify whether it is intended for the
> > > bpf_link_info.perf_event name_len field to not be populated.
> >
> > This sounds like a bug. It should behave consistently with the other
> > users of input/output string buffer size fields: on input we get
> > maximum buffer size, on output we should put an actual size of the
> > string (especially if it was truncated).
> >
> > Yafang, Jiri, WDYT?
>
> The reason name_len is 0 is that the user did not set both the buffer
> and the length. IOW, this happens when the user buffer is NULL and the
> input length is 0. However, we should make this behavior consistent by
> returning the actual size to the user if both the buffer and length
> are unset.
>
> I will submit a fix.
>
>
> --
> Regards
> Yafang

