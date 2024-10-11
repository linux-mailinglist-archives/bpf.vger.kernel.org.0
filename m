Return-Path: <bpf+bounces-41697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A5999B20
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 05:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32BBB228A4
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF181F4FAF;
	Fri, 11 Oct 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib0jyekl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE151C6F45;
	Fri, 11 Oct 2024 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616877; cv=none; b=DvAXE+R4RtQOnuLDs8L4sOHNB43ENnga53qaQMrQ5yF5cRaxQeh23qCr5J+qJL5Y+Z7LXqEAmc6H+Utk+acGV/kAVm0C04z2IbIVxy6Nh12W34I10/tJ0DT3RzQvQtKHYzfRXyanFnwxndpL59JYjvv3OUIcUOKs9z+0Cn9VfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616877; c=relaxed/simple;
	bh=Wz843ZEoE6Co1+9ZGpKSROQ9s0eSEZhLhjVEPASeFZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3DZWB5F0pM/UpDMgXsvx+2l/OwnrasadQYLlppPvGhpm7u1YJqNpa/fePFQqbbsR4iV9nKaz2fQQPcZ3iDksE1fSrBm0OdwbRyFkDH8YrSo1urNaQSXQ5o5eRyZ7uzlx6f/tQR8hHe7qj9RuTXKckJILrLmtiTBwbXSwlrxzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib0jyekl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37969C4AF0B;
	Fri, 11 Oct 2024 03:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616877;
	bh=Wz843ZEoE6Co1+9ZGpKSROQ9s0eSEZhLhjVEPASeFZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ib0jyeklehdp1qZvMSj3AS7Xvm/Eb53kVgFYCwCXo8bzJHxVBguRterE6bgqdmHEi
	 915TZ3m+LGKVFDF31E7SMWCthRFfM0f6ecRqX/LYDazttpONFisE+AXXvdFkmgk2Wj
	 vOQzabgbTh9L5AaN4tXHXrP/iGTMvP4tI8JwA2fwyvcJpSE+ArHQmLr72tY0xg/HrV
	 4BSdIdTu3Tuz5ZUrcOksVAWGkslfJVr+JqrhnmoeN80da1ktpyXrlj6buZsSEM5MTe
	 V4V8Aga+a7IVW9hojsmAWo6EWRyidhUIPYl7wy8u/uZPcS7hVmjRgK3dKsVHXC7Hxj
	 DYV4nf9ELyo+A==
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso5883235ab.3;
        Thu, 10 Oct 2024 20:21:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTeJ500XzvDo/QXfF9qEr8/Jk3Wck5grCad54+QbVFJ6ALRDstExefAbeFUeVng99IQ7U=@vger.kernel.org, AJvYcCUiFYBqejMs4DwpGAZxQGHovSTjMue3YGRbZFJYsO7Q6ez1wxjTW/svXbzkJ31Z5bNOsM/iPZ2P5VhgL68A@vger.kernel.org, AJvYcCWIdWoMjxncAQBGC9MaHbvNlnltrAWoOf3CxGBREQkUFRS6LrT7DScEzwD+Fzdg4hZj66MBbzMZI4w3ov31czVlHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBf0pCmQ6bmvcoO6C2jLqT9eVlE1E0ysshWxx+QiE8Yjx8ewzA
	b5SP0f0RCp446y3OPxDVJ3SbavRecYJE4MA6u8RjOzZFNkkeAOabrk/L4NkYiCR9fFhKQlOOYIt
	vVTCUAJKAWskDKoHTxlVpA16LcL8=
X-Google-Smtp-Source: AGHT+IGt2v+ksKuhaQZQ6g9XzeZtqz5GkflBKVAAd5kXsKbezDvjt07Yz9Cyq7E3U/SQtA+B2Ol60IPJGUIMo7hThJQ=
X-Received: by 2002:a05:6e02:1548:b0:3a3:6045:f8bd with SMTP id
 e9e14a558f8ab-3a3b5f7845dmr11636495ab.5.1728616876488; Thu, 10 Oct 2024
 20:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
 <20240916014318.267709-2-wutengda@huaweicloud.com> <CAPhsuW6wrwcMYLufVfu-R9OzPBfspJD0w-pZUr68UBRSZExc=A@mail.gmail.com>
 <ZwcgZhOC_gq9kToT@google.com> <a98f599f-ea6e-4c7f-b39d-44e6cd2a9f20@huaweicloud.com>
 <3b45a6bc-f95a-4f87-b727-34ac7929c18b@huaweicloud.com>
In-Reply-To: <3b45a6bc-f95a-4f87-b727-34ac7929c18b@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 10 Oct 2024 20:21:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4rckuK7m2jk_Jy4BOqW=Z6AWG+7e7Tghr4xy8_SWyPdg@mail.gmail.com>
Message-ID: <CAPhsuW4rckuK7m2jk_Jy4BOqW=Z6AWG+7e7Tghr4xy8_SWyPdg@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/2] perf stat: Support inherit events during
 fork() for bperf
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 8:07=E2=80=AFPM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
[...]
> >>>>
> >>>> +struct bperf_filter_value {
> >>>> +       __u32 accum_key;
> >>>> +       __u8 exited;
> >>>> +};
> >>> nit:
> >>> Can we use a special value of accum_key to replace exited=3D=3D1
> >>> case?
> >>
> >> I'm not sure.  I guess it still needs to use the accum_key to save the
> >> final value when exited =3D 1.
> >
> > In theory, it is possible. The accum_key is currently only used to inde=
x value
> > in accum_readings map, so if the task is not being counted, the accum_k=
ey can
> > be set to an special value.
> >
> > Due to accum_key is of u32 type, there are two special values to choose=
 from: 0
> > or max_entries+1. I think the latter, max_entries+1, may be more suitab=
le because
> > it can avoid memory waste in the accum_readings map and does not requir=
e too
> > many changes to bpf_counter.
> >
>
> Sorry, I was wrong. As Namhyung said, 'accum_readings[accum_key]' saves t=
he
> last count of the task when it exits. If accum_key is set to a special va=
lue
> at this time, the count will be lost.
>
> So exited=3D=3D1 is necessary, we can not use a special value of accum_ke=
y to
> replace it.

Got it. Thanks for the explanation.

Song

