Return-Path: <bpf+bounces-57324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB16AA8B1F
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 04:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C001170C10
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7AB18E377;
	Mon,  5 May 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev2NRFl1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97248C0B
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746412544; cv=none; b=LoubWcgTXZLLvWZcTfQBiodsz61RBYaTvkxwxmNUm4hHqLpl8o1U4UaUFcpeZQLPj3d3WfLZGYMOGNJ0xsR2HCfAZhvBRsMCVgT4p6qibonb5nLMP7x1sD4ONPNXWGD3kx9wcbEya1jLRyCNF8zBq94pW+cR4K7MLCsCpVnqqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746412544; c=relaxed/simple;
	bh=eeSU7Tj2fvw4VcNWILgYc/hPQQcu98jHIrjyVUDz+s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wnfyb6X14FUMJesKwH+RHLyH9EjFXJKSwRztvwfHe3u6hn/W5r/A0cz7eN4rpDDGnSmlKEjwOkBrbgtFTHpoVKpiaLq5AAU2GPLkeBxLxhtngyAOLgMQnEOEjm24AE/kdY4zacympJGLZKcq7aZZ0SmJ9zIQrFTbQNer7en4tSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev2NRFl1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f0ad744811so30958976d6.1
        for <bpf@vger.kernel.org>; Sun, 04 May 2025 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746412541; x=1747017341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nxtVU6N/RrAV5d6XTHusC6YZMAk4OkqLoS2AeBCFQM=;
        b=ev2NRFl1IKvovCtyVNBJQMGqcN5yO/Eej6TPuEvpDegGt+w1HUOLhMNkbnhO9Bml/9
         UNeAHQU2IGtwzlg4G902RrKqg99BFsmy8Q5/S4H6UuVA8TJ4BXAQ9MiGrBHIaGPdpX0L
         pfI3IlJ68TPTEjFM2GGH1D/RDIFwKSfk0Rwejd5qKf87d/qz4Agt0iGjnlX2MqfBQZrr
         ydxzKagw5rgfajTDh/VThWIgjhBTI+tH/1hIPa9d9kzDUQdxzeDtDGQpXBTc9Qon9jXA
         I1dutsSuq7B1q4mRJPC+gUYfqNZW0S42mtAHpvb8aMtLrXGg1rh/1wJqpLeSEvLXKzsn
         Ms/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746412541; x=1747017341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nxtVU6N/RrAV5d6XTHusC6YZMAk4OkqLoS2AeBCFQM=;
        b=LRDh/bJuv4+kJNVgza4+kKQaLciZR7PhLZ56ARQAKSG3pznEyzM8W2ME39yigOatvM
         4QBFdh15/HodAjegrhj6/uwEH5w/s6zlQBmUUabEdo4CG68a+ZZFMUNUHZkwq1ATAL24
         XAIwc+E82oWLDFBsTTWn+8HaaKpO+unbbpXxt54sOQLsnxLayGdOaAGRsQ+DkcdzxoqC
         DPYwFTbNxYtk0NVM5+yzphRMII0PpLf/aEMghLiPK/D4ppWoZ+tWhLuMZ58Az6sq11Y9
         7hHPp8/TXRkUa0AoXPa7ijCUwNAVGntSqcFtBaUCV7vgWlHKJxv5xyV8GWL45k8/eR9h
         29IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOzOmIbdhsggzGVj7AHijF81YtrN4HoxCVcre8kRbEma/OB11Iqt3oMPDyGlXCgh+T+g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXzyr6kQVhXctlxdU85/ksULZ8rrMVTwSIWAbC/s5g4VLFj1l
	qxSIMdxlsSwyBb4w9LHHqnGV3lQIQqgzqTeGDhVhAJvGCCwnb5hV/Lpc7hwQbWD/WtWLfnGTMu8
	uRUb2RiHY4DQnTX2UuWRXyXAUdJ0=
X-Gm-Gg: ASbGncuIahnVf65VNJ4vU/CTsPHQsXKohdUTKCLEwzkJv5qM4aELz0yPHOV09GRoU6T
	FhwKx/3yau7IXsaJeK5JyV3pL6srHIw3KO+hbhXeIU2vDTBgd4ZqBbP1VmYVl31Jwv/FK2NLlCV
	NkGmOqI5+sfWvAu0fa+bfzf/4=
X-Google-Smtp-Source: AGHT+IH+g6n4EubsnN8ph+rM2FXcVsRR1u0bbnz+JilLAYhB1a5u8eaZ6e2q2R8nzaZkJYE7By5wVBkJ/UnhBdHzdGk=
X-Received: by 2002:a05:6214:762:b0:6ed:1651:e8c1 with SMTP id
 6a1803df08f44-6f528c53ed6mr85159676d6.13.1746412541464; Sun, 04 May 2025
 19:35:41 -0700 (PDT)
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
 <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
 <3006EA5B-3E02-4D82-8626-90735FE8F656@nvidia.com> <CALOAHbA6uWTGZ10n3Lk2Jm5xBPC5ob9aw87EHmkvm6__PYJ_5g@mail.gmail.com>
 <4883bdec-f7f2-4350-bf72-f0fa75c9ddd5@redhat.com>
In-Reply-To: <4883bdec-f7f2-4350-bf72-f0fa75c9ddd5@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 5 May 2025 10:35:04 +0800
X-Gm-Features: ATxdqUFfIUgQJBw89A40HdwZQ27xd8C9VQ8oBQ7228ueTQD_frv68dsIALp5p2g
Message-ID: <CALOAHbA-PvLmzuv4oWenBRjvRM0KQiDa2nV0OsdTFr5czuLMUw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Gutierrez Asier <gutierrez.asier@huawei-partners.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 9:04=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 02.05.25 14:18, Yafang Shao wrote:
> > On Fri, May 2, 2025 at 8:00=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 2 May 2025, at 1:48, Yafang Shao wrote:
> >>
> >>> On Fri, May 2, 2025 at 3:36=E2=80=AFAM Gutierrez Asier
> >>> <gutierrez.asier@huawei-partners.com> wrote:
> >>>>
> >>>>
> >>>> On 4/30/2025 8:53 PM, Zi Yan wrote:
> >>>>> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
> >>>>>
> >>>>>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
> >>>>>>>>>> If it isn't, can you state why?
> >>>>>>>>>>
> >>>>>>>>>> The main difference is that you are saying it's in a container=
 that you
> >>>>>>>>>> don't control.  Your plan is to violate the control the intern=
al
> >>>>>>>>>> applications have over THP because you know better.  I'm not s=
ure how
> >>>>>>>>>> people might feel about you messing with workloads,
> >>>>>>>>>
> >>>>>>>>> It=E2=80=99s not a mess. They have the option to deploy their s=
ervices on
> >>>>>>>>> dedicated servers, but they would need to pay more for that cho=
ice.
> >>>>>>>>> This is a two-way decision.
> >>>>>>>>
> >>>>>>>> This implies you want a container-level way of controlling the s=
etting
> >>>>>>>> and not a system service-level?
> >>>>>>>
> >>>>>>> Right. We want to control the THP per container.
> >>>>>>
> >>>>>> This does strike me as a reasonable usecase.
> >>>>>>
> >>>>>> I think there is consensus that in the long-term we want this stuf=
f to
> >>>>>> just work and truly be transparent to userspace.
> >>>>>>
> >>>>>> In the short-to-medium term, however, there are still quite a few
> >>>>>> caveats. thp=3Dalways can significantly increase the memory footpr=
int of
> >>>>>> sparse virtual regions. Huge allocations are not as cheap and reli=
able
> >>>>>> as we would like them to be, which for real production systems mea=
ns
> >>>>>> having to make workload-specifcic choices and tradeoffs.
> >>>>>>
> >>>>>> There is ongoing work in these areas, but we do have a bit of a
> >>>>>> chicken-and-egg problem: on the one hand, huge page adoption is sl=
ow
> >>>>>> due to limitations in how they can be deployed. For example, we ca=
n't
> >>>>>> do thp=3Dalways on a DC node that runs arbitary combinations of jo=
bs
> >>>>>> from a wide array of services. Some might benefit, some might hurt=
.
> >>>>>>
> >>>>>> Yet, it's much easier to improve the kernel based on exactly such
> >>>>>> production experience and data from real-world usecases. We can't
> >>>>>> improve the THP shrinker if we can't run THP.
> >>>>>>
> >>>>>> So I don't see it as overriding whoever wrote the software running
> >>>>>> inside the container. They don't know, and they shouldn't have to =
care
> >>>>>> about page sizes. It's about letting admins and kernel teams get
> >>>>>> started on using and experimenting with this stuff, given the very
> >>>>>> real constraints right now, so we can get the feedback necessary t=
o
> >>>>>> improve the situation.
> >>>>>
> >>>>> Since you think it is reasonable to control THP at container-level,
> >>>>> namely per-cgroup. Should we reconsider cgroup-based THP control[1]=
?
> >>>>> (Asier cc'd)
> >>>>>
> >>>>> In this patchset, Yafang uses BPF to adjust THP global configs base=
d
> >>>>> on VMA, which does not look a good approach to me. WDYT?
> >>>>>
> >>>>>
> >>>>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutier=
rez.asier@huawei-partners.com/
> >>>>>
> >>>>> --
> >>>>> Best Regards,
> >>>>> Yan, Zi
> >>>>
> >>>> Hi,
> >>>>
> >>>> I believe cgroup is a better approach for containers, since this
> >>>> approach can be easily integrated with the user space stack like
> >>>> containerd and kubernets, which use cgroup to control system resourc=
es.
> >>>
> >>> The integration of BPF with containerd and Kubernetes is emerging as =
a
> >>> clear trend.
> >>>
> >>>>
> >>>> However, I pointed out earlier, the approach I suggested has some
> >>>> flaws:
> >>>> 1. Potential polution of cgroup with a big number of knobs
> >>>
> >>> Right, the memcg maintainers once told me that introducing a new
> >>> cgroup file means committing to maintaining it indefinitely, as these
> >>> interface files are treated as part of the ABI.
> >>> In contrast, BPF kfuncs are considered an unstable API, giving you th=
e
> >>> flexibility to modify them later if needed.
> >>>
> >>>> 2. Requires configuration by the admin
> >>>>
> >>>> Ideally, as Matthew W. mentioned, there should be an automatic syste=
m.
> >>>
> >>> Take Matthew=E2=80=99s XFS large folio feature as an example=E2=80=94=
it was enabled
> >>> automatically. A few years ago, when we upgraded to the 6.1.y stable
> >>> kernel, we noticed this new feature. Since it was enabled by default,
> >>> we assumed the author was confident in its stability. Unfortunately,
> >>> it led to severe issues in our production environment: servers crashe=
d
> >>> randomly, and in some cases, we experienced data loss without
> >>> understanding the root cause.
> >>>
> >>> We began disabling various kernel configurations in an attempt to
> >>> isolate the issue, and eventually, the problem disappeared after
> >>> disabling CONFIG_TRANSPARENT_HUGEPAGE. As a result, we released a new
> >>> kernel version with THP disabled and had to restart hundreds of
> >>> thousands of production servers. It was a nightmare for both us and
> >>> our sysadmins.
> >>>
> >>> Last year, we discovered that the initial issue had been resolved by =
this patch:
> >>> https://lore.kernel.org/stable/20241001210625.95825-1-ryncsn@gmail.co=
m/.
> >>> We backported the fix and re-enabled XFS large folios=E2=80=94only to=
 face a
> >>> new nightmare. One of our services began crashing sporadically with
> >>> core dumps. It took us several months to trace the issue back to the
> >>> re-enabled XFS large folio feature. Fortunately, we were able to
> >>> disable it using livepatch, avoiding another round of mass server
> >>> restarts. To this day, the root cause remains unknown. The good news
> >>> is that the issue appears to be resolved in the 6.12.y stable kernel.
> >>> We're still trying to bisect which commit fixed it, though progress i=
s
> >>> slow because the issue is not reliably reproducible.
> >>
> >> This is a very wrong attitude towards open source projects. You sounde=
d
> >> like, whether intended or not, Linux community should provide issue-fr=
ee
> >> kernels and is responsible for fixing all issues. But that is wrong.
> >> Since you are using the kernel, you could help improve it like Kairong
> >> is doing instead of waiting for others to fix the issue.
> >>
> >>>
> >>> In theory, new features should be enabled automatically. But in
> >>> practice, every new feature should come with a tunable knob. That=E2=
=80=99s a
> >>> lesson we learned the hard way from this experience=E2=80=94and perha=
ps
> >>> Matthew did too.
> >>
> >> That means new features will not get enough testing. People like you
> >> will just simply disable all new features and wait for they are stable=
.
> >> It would never come without testing and bug fixes.
>

Hello David,

Thanks for your replyment.

> We do have the concept of EXPERIMENTAL kernel configs, that are either
> expected get removed completely ("always enabled") or get turned into
> actual long-term kernel options. But yeah, it's always tricky what we
> actually want to put behind such options.
>
> I mean, READ_ONLY_THP_FOR_FS is still around and still EXPERIMENTAL ...

READ_ONLY_THP_FOR_FS is not enabled in our 6.1 kernel, as we are
cautious about enabling any EXPERIMENTAL feature. XFS large folio
support operates independently of READ_ONLY_THP_FOR_FS. However, it is
automatically enabled when CONFIG_TRANSPARENT_HUGEPAGE is set, as seen
in the 6.1.y stable kernel mapping_large_folio_support().

>
> Distro kernels are usually very careful about what to backport and what
> to support. Once we (working for a distro) do backport + test, we
> usually find some additional things that upstream hasn't spotted yet: in
> particular, because some workloads are only run in that form on distro
> kernels. We also ran into some issues with large folios (e.g., me
> personally with s390x KVM guests) and trying our best to fix them.

We also worked on this. As you may recall, I previously fixed a large
folio bug, which was merged into the 6.1.y stable kernel [0].

[0]. https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi=
t/?h=3Dlinux-6.1.y&id=3Da3f8ee15228c89ce3713ee7e8e82f6d8a13fdb4b

>
> It can be quite time consuming, so I can understand that not everybody
> has the time to invest into heavy debugging, especially if it's
> extremely hard to reproduce (or even corrupts data :( ).

Correct. If the vmcore is incomplete, it is nearly impossible to
reliably determine the root cause. The best approach is to isolate the
issue as quickly as possible.

>
> I agree that adding a toggle after the effects to work around issues is
> not the right approach. Introducing a EXPERIMENTAL toggle early because
> one suspects complicated interactions in a different story. It's
> absolutely not trivial to make that decision.

In this patchset, we are not introducing a toggle as a workaround.
Rather, the change reflects the fact that some workloads benefit from
THP while others are negatively impacted. Therefore, it makes sense to
enable THP selectively based on workload characteristics.

>
> >
> > Pardon me?
> > This discussion has taken such an unexpected turn that I don=E2=80=99t =
feel
> > the need to explain what I=E2=80=99ve contributed to the Linux communit=
y over
> > the past few years.
>
> I'm sure Zi Yan didn't mean to insult you. I would have phrased it as:
>
> "It's difficult to decide which toggles make sense. There is a fine line
> between adding a toggle and not getting people actually testing it to
> stabilize it vs. not adding a toggle and forcing people to test it and
> fix it/report issues."
>
> Ideally, we'd find most issue in the RC phase or at least shortly after.
>
> You've been active in the kernel for a long time, please don't feel like
> the community is not appreciating that.

Thank you for the clarification. I truly appreciate your patience and
thoroughness.

--=20
Regards
Yafang

