Return-Path: <bpf+bounces-57101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD86AA591C
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 02:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE24E3EC1
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15119F42D;
	Thu,  1 May 2025 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV9vnRUb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E972DC76A
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746060079; cv=none; b=LtdsHuI/yBK+cFH8QRgmGaS5PPrXqlu19fIOqtmmJOHaDo3DfV5e3DrLGhUZxvtguEFykjikAvdt8jFMckoCgADzXJbzAbKK3elpVSnX4RIczuC7d9Tf8Z+SJa1oz8Q5/qEC57DBCy4hXu5mlb7t/zIXFl/sONdHjXZynPumUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746060079; c=relaxed/simple;
	bh=N+WZXGwb58/3SG5GqLqXNmJuLmQfgaLqqTnUc7KKPYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgIHq/KmJSu67I1upsLy5MJ9/0GNwvm3u69BojiaAmRIHi093mU2Nv7Z+xaN4IBBrNm3nLlme8FVJsDSkKl0GvKnWUSwqEuA0X8/MQ9N4wYubTgn2cGpKjZiuHJOSZFLEcvU1jjEbhNDRgFbRsrK32xTEiRqxxW/037JfaolNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV9vnRUb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476ab588f32so7398011cf.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746060075; x=1746664875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+WZXGwb58/3SG5GqLqXNmJuLmQfgaLqqTnUc7KKPYQ=;
        b=lV9vnRUbeEbaGJ8wJZTzVNhZpgD7higquiayWjUk9cBwisCCMaYJA9Pj9yXSekszHX
         i4nsJUr+q09NV7tHnuCsCOlgozcVsZm8F1XATqVbE0a8QM3qDkKeDLOtn+tBYfKf0ckP
         g0AoT9WnNTN5h2ZBl4dq83dQwHW1s9Awp30QK3o8Tzm+HqzoRRzamcQrr9644JbSQfJl
         vEk5Jk5xDO5NxYQOhEZEq504Ec7kcttUsB329lm0AiJqkDn9nhm7HWzKko90OG8ZO1eL
         1skeVXnGkpsrZxFdaE+jmeS3qt1lGNWnJYx/KZloZrDFNYyToobdr06AfIAETko9D/ZI
         xE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746060075; x=1746664875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+WZXGwb58/3SG5GqLqXNmJuLmQfgaLqqTnUc7KKPYQ=;
        b=QK4VbEoanU+saATOZXJozXevl94GEp2RwiaAs7dADtEnPJ8tic4PIHaAlJOnq1RQu7
         i7g+nJ4GG74pP3Db04lKhVjKnrSXyS44ll5s1amSubFaNqjUy5FBzZxW+l4HdmoVC37r
         6EYZUQ4MYNfWQ9sSRYv8hNeCjihxogauzE7gOxkdQEe5Dg4dHQel7oRh8TEYsZzf++RZ
         NpT0RZ8eg1gRPM3AyW9aMWESjr2Xas1vlPKALemvTsinjHwDSkRpsIEotQx4wxOCnwL8
         Y8lXBp434SXlbQz4EwmB8QzdDIxfJAo2AssAsQOOPL75TFWT0eYAB2s+v56+PPMvNimv
         C27g==
X-Forwarded-Encrypted: i=1; AJvYcCVRKi2Az6MwcI352aVKwdxMmniiXh12jV5PXw6GeCf/McaqNePRU0DwqzmQCwjMuIjqd3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1W68IvHyoT9PU7NuwScjcGSEfwnQorm6x3Cgi8qL2TjysHg7K
	1KyhvZV+7Fd+7/h363HHT7VG1ftLks049bL6iFg4NQMuXsrCBPh8iDVNgVrqAIgw9JkXMax3Gg6
	rwqzRr1vw7KPVJwPmuxNRkLE+HUg=
X-Gm-Gg: ASbGncsn8Im7urMfSeNhrsDDAuWY1XbXOjJIfFge3+FCgX3ak3tRNqAd1khNO7J043o
	2wQFQSS00ypuc3YYgJU6ytUI2+HOaRcfOultVnvcT3PLJ5r+F398bMOM6cBrU2U9QyipWFqTgqA
	4/nDm6lQuV4/BHICsHoCFCIZ4=
X-Google-Smtp-Source: AGHT+IHkT9mIv6SE6GkHQhPe1AagpNBj3fzSES5u/yUEQMnLFZtUj5ir7WWCl0i0x9xAGmA/XdATAn0uInqcHbodP/Y=
X-Received: by 2002:a05:622a:1f8d:b0:476:a6bc:a94d with SMTP id
 d75a77b69052e-489e4a8df67mr89129631cf.19.1746060075264; Wed, 30 Apr 2025
 17:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com> <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <20250430175954.GD2020@cmpxchg.org>
In-Reply-To: <20250430175954.GD2020@cmpxchg.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 1 May 2025 08:40:39 +0800
X-Gm-Features: ATxdqUGuvZE0etm8BHikrEA8IzDx90CAots4PaATaHpw9ej-FRfv6RrSq8cBWFE
Message-ID: <CALOAHbCXMi2GaZdHJaNLXxGsJf-hkDTrztsQiceaBcJ8d8p3cA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 2:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, Apr 30, 2025 at 10:38:10PM +0800, Yafang Shao wrote:
> > On Wed, Apr 30, 2025 at 9:19=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> > > For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
> >
> > You=E2=80=99ll need to modify the user-space code=E2=80=94and again, th=
is likely
> > wouldn=E2=80=99t be a concern if you were managing a large fleet of ser=
vers.
>
> These flags are propagated along the process tree, so you only need to
> tweak the management software that launches the container
> workload. Which is presumably the same entity that would tweak cgroup
> settings.

Right, we can modify the parent process code. In a containerized
environment, that would mean modifying the containerd source code.
However, deploying such changes is far from simple:

1. We'd need to deploy the modified containerd to our production servers.
2. All running services would need to be restarted.
3. We'd have to coordinate with teams whose services don=E2=80=99t benefit
from THP to ensure their cooperation.
4. Only then could we set =E2=80=9Cthp=3Dalways=E2=80=9D across our product=
ion servers.
5. Next, we=E2=80=99d annotate the services that do benefit from THP, resta=
rt
them, and monitor behavior.
6. If anything goes wrong, we may have to repeat the process.
7. For systemd-managed services, we might need to implement a separate solu=
tion.

This is a painful and disruptive process. In contrast, with the
BPF-based solution, we simply introduce a plugin. Only the services
that want to use THP need to restart, and they=E2=80=99re generally willing=
 to
do so since they benefit from it.

As you mentioned in another email, this entire process is
experimental, so it=E2=80=99s very likely that we=E2=80=99ll encounter unex=
pected
issues. That=E2=80=99s why flexibility and ease of adjustment are critical.

By the way, I have another draft that hooks into the fork() procedure
using BPF to adjust per-process attributes of services, aiming to
simplify deployment=E2=80=94but that=E2=80=99s a separate topic.

>
> > > For service-level control, there was a proposal of adding cgroup base=
d
> > > THP control[1]. You might need a strong use case to convince people.
> > >
> > > [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierre=
z.asier@huawei-partners.com/
> >
> > Thanks for the reference. I've reviewed the related discussion, and if
> > I understand correctly, the proposal was rejected by the maintainers.
>
> Cgroups are for nested trees dividing up resources. They're not a good
> fit for arbitrary, non-hierarchical policy settings.

Thanks for the explanation.

--=20
Regards
Yafang

