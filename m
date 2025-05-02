Return-Path: <bpf+bounces-57220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45A0AA718E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40F74C6711
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1925522E;
	Fri,  2 May 2025 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7kRK5D5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347F02550D7
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188331; cv=none; b=i7LI6JJVWDMkB37+8g+aqVs722LcKHgDUImJP39hlYbOE1wfnfByaFMp3Lh6kMiYlvnXLwKJ1ZH7zVKKC+cfdBgWZs8zVwE1ZUC3PxEJkyqwI0bypxTD6DR4CfMEALw4xF0P/7Sj+2n6fM0J3NnH+QUplkCijzXQDvBBkBEsN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188331; c=relaxed/simple;
	bh=OH01qvX277HwR90sX/laucyMzK8VaZGihTtju19yniE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epQRWyqc3k05PZLdjE1HIczh/RYAVfhjjMz3yL1fNMubXBnhyKIZzmLnQtTsDoZtbU/3lz4X3eQ0/4NBTZ8PZGWBlLXsun0uxf2NDR+u+82mR/+PpNoykyGVMGoeiheKR4BuPqyTJwfJdxTqr19fltH8Iy+zQqdrCaiIO00Qy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7kRK5D5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f8657f29so20346586d6.3
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746188328; x=1746793128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qnYssvigqQWiexsb57cBRhvr2T5TwZbcMMOB+hK+DE=;
        b=m7kRK5D5s/6IECHUqUHjW4zq4YlaYMfT6R+mJFVZH9Z2rU5ZHrSitce2BzhGXv9+rt
         7dEYuG0mjPedHbLf5O5hrd6KO4bOw/qqZEP4h6ncGwfgNtX1y4mXfGHyKvhZo2L7ncn7
         7LmRh/u8sTmdD/SqP2iWKVEWRDTIL55MAP5KYZLlj8hMsJAHvZvoAnKFR3Lf5whJJQMQ
         3LZX710qXuiivFrIcq7Q3ENAYrpLNseItrtUSkaSr17xon85S64k8iCjlT+DxUgoQX3P
         S2xHge0MAz7gi2+99tOnCTdWxgbX6YEDdi33cp/PUoWF/tdlYfrz1zGFczQpJ78OZ5Zr
         YRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188328; x=1746793128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qnYssvigqQWiexsb57cBRhvr2T5TwZbcMMOB+hK+DE=;
        b=CwVUM8gpqjsrgxkfLdUnOTSFEmM0hvei9dr0SkHMRp1JGM6uta8jG7ow3Ap5URkHTS
         H9qamx/mqXIJE9NSOW9KBj7B8YUynu1IQTegaEtWyRPFJzpPQfO8EuXJHsmsiiyJdvso
         q5V/dfBOkP74tOSW0XHP//HGA9JsQs//F0XgsEN5RB2Vt2612bp0T5cYNmjcXJFtTk9z
         Ag6kABfDU1Zl9iUs+OW4OgHeyhUVkgqoNBoAPIXeItQ3c46tmVHVwfwmvlxGpDcdviBc
         A8imhSUf0Kn0W0hdbrDSkRbMS8wnSXEsLcX+0bdw90Hq0Z/v+f9FgPKEG58uWnqSAPb4
         N+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWfP21eDE53ym1AXsHgIovopcS4w/2/V8AUWTy202J9q7Jwk470q37WbQFb8Er1k+Ze0iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQcd/fPFjL6swNDn9vPJe6RFuzgASQ8iAJPOLb3aFWVHio/Wq
	rKf4AVg7xYXVq8jNbiTNpi41Wo+PgzenvAbHgKLL4P8aoWj7nbJuIedJD5GKo1H0DUL3KOFb0vm
	bOjsMcwaGqZQPIQ7nrmZzKx26ffAAVOcEs+Gv7w==
X-Gm-Gg: ASbGnctaVMyy3G7aeU375OI4RgApoBI8Kfd0FyxqBSXen+hXT43BxG/Qg9wL6Pxwe9u
	/2S1b9Epz8V6fpyhTNJo+QgvVeIpOa+jJ1NeM1MLWQSuBYi7RRh1dzQJ70axwkjVofYNtZpFNl/
	G5rjraaKp8MtOYob6HJZY31d0=
X-Google-Smtp-Source: AGHT+IHqbK4ZuU6whuG1aaB4mqbXVMZHOPktn4ERWLnnIB0YBqVLnHx/r6NjkZeXmm88j20izt3acG0nH7pOgAOkGJ8=
X-Received: by 2002:a05:6214:ac1:b0:6e8:fb94:b9bf with SMTP id
 6a1803df08f44-6f5152625bfmr44877126d6.4.1746188327124; Fri, 02 May 2025
 05:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com> <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com> <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
 <20250430174521.GC2020@cmpxchg.org> <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
 <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
 <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com> <3006EA5B-3E02-4D82-8626-90735FE8F656@nvidia.com>
In-Reply-To: <3006EA5B-3E02-4D82-8626-90735FE8F656@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 2 May 2025 20:18:09 +0800
X-Gm-Features: ATxdqUE0qTTPNY8ygjxDlSsNmJN8mrMYfKnGNPgqVWC3S_BBYEo1fY5SaTREsqY
Message-ID: <CALOAHbA6uWTGZ10n3Lk2Jm5xBPC5ob9aw87EHmkvm6__PYJ_5g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Zi Yan <ziy@nvidia.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 8:00=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 2 May 2025, at 1:48, Yafang Shao wrote:
>
> > On Fri, May 2, 2025 at 3:36=E2=80=AFAM Gutierrez Asier
> > <gutierrez.asier@huawei-partners.com> wrote:
> >>
> >>
> >> On 4/30/2025 8:53 PM, Zi Yan wrote:
> >>> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
> >>>
> >>>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
> >>>>>>>> If it isn't, can you state why?
> >>>>>>>>
> >>>>>>>> The main difference is that you are saying it's in a container t=
hat you
> >>>>>>>> don't control.  Your plan is to violate the control the internal
> >>>>>>>> applications have over THP because you know better.  I'm not sur=
e how
> >>>>>>>> people might feel about you messing with workloads,
> >>>>>>>
> >>>>>>> It=E2=80=99s not a mess. They have the option to deploy their ser=
vices on
> >>>>>>> dedicated servers, but they would need to pay more for that choic=
e.
> >>>>>>> This is a two-way decision.
> >>>>>>
> >>>>>> This implies you want a container-level way of controlling the set=
ting
> >>>>>> and not a system service-level?
> >>>>>
> >>>>> Right. We want to control the THP per container.
> >>>>
> >>>> This does strike me as a reasonable usecase.
> >>>>
> >>>> I think there is consensus that in the long-term we want this stuff =
to
> >>>> just work and truly be transparent to userspace.
> >>>>
> >>>> In the short-to-medium term, however, there are still quite a few
> >>>> caveats. thp=3Dalways can significantly increase the memory footprin=
t of
> >>>> sparse virtual regions. Huge allocations are not as cheap and reliab=
le
> >>>> as we would like them to be, which for real production systems means
> >>>> having to make workload-specifcic choices and tradeoffs.
> >>>>
> >>>> There is ongoing work in these areas, but we do have a bit of a
> >>>> chicken-and-egg problem: on the one hand, huge page adoption is slow
> >>>> due to limitations in how they can be deployed. For example, we can'=
t
> >>>> do thp=3Dalways on a DC node that runs arbitary combinations of jobs
> >>>> from a wide array of services. Some might benefit, some might hurt.
> >>>>
> >>>> Yet, it's much easier to improve the kernel based on exactly such
> >>>> production experience and data from real-world usecases. We can't
> >>>> improve the THP shrinker if we can't run THP.
> >>>>
> >>>> So I don't see it as overriding whoever wrote the software running
> >>>> inside the container. They don't know, and they shouldn't have to ca=
re
> >>>> about page sizes. It's about letting admins and kernel teams get
> >>>> started on using and experimenting with this stuff, given the very
> >>>> real constraints right now, so we can get the feedback necessary to
> >>>> improve the situation.
> >>>
> >>> Since you think it is reasonable to control THP at container-level,
> >>> namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
> >>> (Asier cc'd)
> >>>
> >>> In this patchset, Yafang uses BPF to adjust THP global configs based
> >>> on VMA, which does not look a good approach to me. WDYT?
> >>>
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierre=
z.asier@huawei-partners.com/
> >>>
> >>> --
> >>> Best Regards,
> >>> Yan, Zi
> >>
> >> Hi,
> >>
> >> I believe cgroup is a better approach for containers, since this
> >> approach can be easily integrated with the user space stack like
> >> containerd and kubernets, which use cgroup to control system resources=
.
> >
> > The integration of BPF with containerd and Kubernetes is emerging as a
> > clear trend.
> >
> >>
> >> However, I pointed out earlier, the approach I suggested has some
> >> flaws:
> >> 1. Potential polution of cgroup with a big number of knobs
> >
> > Right, the memcg maintainers once told me that introducing a new
> > cgroup file means committing to maintaining it indefinitely, as these
> > interface files are treated as part of the ABI.
> > In contrast, BPF kfuncs are considered an unstable API, giving you the
> > flexibility to modify them later if needed.
> >
> >> 2. Requires configuration by the admin
> >>
> >> Ideally, as Matthew W. mentioned, there should be an automatic system.
> >
> > Take Matthew=E2=80=99s XFS large folio feature as an example=E2=80=94it=
 was enabled
> > automatically. A few years ago, when we upgraded to the 6.1.y stable
> > kernel, we noticed this new feature. Since it was enabled by default,
> > we assumed the author was confident in its stability. Unfortunately,
> > it led to severe issues in our production environment: servers crashed
> > randomly, and in some cases, we experienced data loss without
> > understanding the root cause.
> >
> > We began disabling various kernel configurations in an attempt to
> > isolate the issue, and eventually, the problem disappeared after
> > disabling CONFIG_TRANSPARENT_HUGEPAGE. As a result, we released a new
> > kernel version with THP disabled and had to restart hundreds of
> > thousands of production servers. It was a nightmare for both us and
> > our sysadmins.
> >
> > Last year, we discovered that the initial issue had been resolved by th=
is patch:
> > https://lore.kernel.org/stable/20241001210625.95825-1-ryncsn@gmail.com/=
.
> > We backported the fix and re-enabled XFS large folios=E2=80=94only to f=
ace a
> > new nightmare. One of our services began crashing sporadically with
> > core dumps. It took us several months to trace the issue back to the
> > re-enabled XFS large folio feature. Fortunately, we were able to
> > disable it using livepatch, avoiding another round of mass server
> > restarts. To this day, the root cause remains unknown. The good news
> > is that the issue appears to be resolved in the 6.12.y stable kernel.
> > We're still trying to bisect which commit fixed it, though progress is
> > slow because the issue is not reliably reproducible.
>
> This is a very wrong attitude towards open source projects. You sounded
> like, whether intended or not, Linux community should provide issue-free
> kernels and is responsible for fixing all issues. But that is wrong.
> Since you are using the kernel, you could help improve it like Kairong
> is doing instead of waiting for others to fix the issue.
>
> >
> > In theory, new features should be enabled automatically. But in
> > practice, every new feature should come with a tunable knob. That=E2=80=
=99s a
> > lesson we learned the hard way from this experience=E2=80=94and perhaps
> > Matthew did too.
>
> That means new features will not get enough testing. People like you
> will just simply disable all new features and wait for they are stable.
> It would never come without testing and bug fixes.

Pardon me?
This discussion has taken such an unexpected turn that I don=E2=80=99t feel
the need to explain what I=E2=80=99ve contributed to the Linux community ov=
er
the past few years.

That said, you're free to express yourself as you wish=E2=80=94even if it
comes across as unnecessarily rude toward someone who has been
participating in the community voluntarily for many years.
Best of luck in your first maintainer role.

--=20
Regards
Yafang

