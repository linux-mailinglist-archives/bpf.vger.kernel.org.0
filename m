Return-Path: <bpf+bounces-30862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477C8D3E50
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 20:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76A42880BA
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A031C0DF7;
	Wed, 29 May 2024 18:27:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DC15D5A1;
	Wed, 29 May 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007250; cv=none; b=pyn1Mf5ok6OPqm+q5rCvJNauM4ZH1o5Qdsz+ekTy303EJBGPovAPaHl8vYsFEx4JrBkt00bzEbdmen6iABcjBnsISyX+jo6D/AhhTzZEQzp3FpYR9szVdJfqM1dLR6izFqHUkTQhovHzVPpJwyVkdVbUB2Oa9PzA3uT3LSKHpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007250; c=relaxed/simple;
	bh=k7g7GDca72KtY7wZrsm0Zqr6CCkZXZ3ooFMOR2lk5QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea0DHOnoikSHZPEzsLFDbnLmKva2Y28gAvlji14CR81NHwoCm+wGoV4m6zhfsXn9oE/4aSSRsVOqX/Vbio5lpRYjn4glBJeoJYywSDl4BpvgZYVcyyVgbUfwzHoahEoQusyRCaqHA5G0g2DcySzOuuGQEi2BwReuPFhoiRoi3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c1a5913777so1097a91.2;
        Wed, 29 May 2024 11:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007248; x=1717612048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD9+m2uRH+Hg4qe+386Ai932VFm1j7AF3HmzviPsoPg=;
        b=oeituTrkKZNFdbJdV+6foIvzRNzdu0yJoQtGbQUQD2EvN73M2y4Xwg0JBDkvNufSTW
         LjTolhuyM8W2FTKiD540+IwpRM/dQc2/7i07/eYeq4/SY30n/3Fh+kkCR3UxRpJf4RuJ
         eKOWj2QeT4NTp9V0sFfIN2vRgqbdq0k+mBqMRZmUsfOs+tethfSMLjwbYwFrlD1zxbus
         Z8zJkps+FGkGFzllbFarmSNqtnBdcLl7BwNlheU/B9ZjFDtokNneMnAlsi3+o+2Q00eD
         cmmneFfOsWc6y2Nu90TOn3I3CptL1zrKq2Bm/Uc6aavWmwCJVaVtwCxs8qQsqKs4ZUQF
         HmyA==
X-Forwarded-Encrypted: i=1; AJvYcCWYOpvNojZ3NzSO7SPWUNZfJJ4FxwTCyiZOKIgfESxzozIhQc12oZf0VIFpn40lh6i2VwfWbhNHhzJPq+bWGeLkNIKbETsiGS/iaJQcyxDCAktxXY86G3RSRf4JK3AqyZWs
X-Gm-Message-State: AOJu0Ywbw/qDKD4j/lRKbyXMHPfmpclZkXgFb+SEqbd1O97rDfU3UZ/o
	Kd925h/VxB/g9d1vcHubhKX19q+yn9Nhrgy+hhrIVPPJRD2qR2QN9cSp6yqGKS06z6jFUA1KTnR
	uHl02YhudkrYSCr0ggmNCklkHIS4=
X-Google-Smtp-Source: AGHT+IGCkhpw1ET2HQ8G/tRKNoHqVOGe682S5VSxTyrmki/emXC2yFlqKU9n/kS0HLtjaMkupAFyOepx6HYv8dX62Q4=
X-Received: by 2002:a17:90b:33d2:b0:2bf:ebf5:c9d4 with SMTP id
 98e67ed59e1d1-2bfebf5cb71mr8364249a91.42.1717007248347; Wed, 29 May 2024
 11:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529065311.1218230-1-namhyung@kernel.org> <Zlbn3DOGrzHlw95h@krava>
 <CAM9d7ci0g+ObA7w-tXU9cyjzRUFgXjZ4b9Atx2+oV4Anhraeyg@mail.gmail.com> <CAADnVQ+qqx8=WjpMjZyqzCb+02zpw9=wVAwWfyHL_O4Xpadukw@mail.gmail.com>
In-Reply-To: <CAADnVQ+qqx8=WjpMjZyqzCb+02zpw9=wVAwWfyHL_O4Xpadukw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 May 2024 11:27:17 -0700
Message-ID: <CAM9d7cgDcczbo9s+J9TpoQhfHCTeJws=L5bpV458rbo4WTi-aQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Allocate bpf_event_entry with node info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Aleksei Shchekotikhin <alekseis@google.com>, Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Wed, May 29, 2024 at 10:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 29, 2024 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Jiri,
> >
> > On Wed, May 29, 2024 at 1:31=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Tue, May 28, 2024 at 11:53:11PM -0700, Namhyung Kim wrote:
> > > > It was reported that accessing perf_event map entry caused pretty h=
igh
> > > > LLC misses in get_map_perf_counter().  As reading perf_event is all=
owed
> > > > for the local CPU only, I think we can use the target CPU of the ev=
ent
> > > > as hint for the allocation like in perf_event_alloc() so that the e=
vent
> > > > and the entry can be in the same node at least.
> > >
> > > looks good, is there any profile to prove the gain?
> >
> > No, at this point.  I'm not sure if it'd help LLC hit ratio but
> > I think it should improve the memory latency.
>
> I have the same concern as Jiri.
> Without numbers this is just a code churn.
> Does this patch really make a difference?
> Without numbers maintainers would have to believe the "just trust me" par=
t.
> So..
> pw-bot: cr

Ok, then I'll come back with numbers later.

Thanks,
Namhyung

