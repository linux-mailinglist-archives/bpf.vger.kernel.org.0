Return-Path: <bpf+bounces-47880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF0A0162C
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 18:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C88A163781
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127A1CDFC2;
	Sat,  4 Jan 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP/PDCEs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52291C5F1D;
	Sat,  4 Jan 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736013176; cv=none; b=CJy6SYeZIACGH0d4n4RNR4Zhlr/Yl7hkMQSY4bQUXB6qTNG30KPWYNAVA31qvvJG6bMOUKSgpHx8q/n72XqngaYq4Hizk8TGiirs6JWpn8bEe1ODguqL351LOs0k0qNoKM9ORi1EVdu+Y7l5UWSXjbh5/q+HOidlDSbydtYPjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736013176; c=relaxed/simple;
	bh=mSgp80ZWf5vN4PcBPj5bIokW4wJz12MpukMGR8EW56c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfDOYB1GGil0aifGdp04iEtUAYjwIaUb0TPPHUTXNMFyzDziUkS4As5NGiSTQK1AslS4/V1n3CraMkP68d+Fg6oKDOgmIQF6UpNflcsJ/eY6sesqnNCjH3rHkmCThqomRvIF3BtK/bcQ+of2OrtQm/4dhlBJqFN9EehC6aeCzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP/PDCEs; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549dd7201cso1293436276.0;
        Sat, 04 Jan 2025 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736013174; x=1736617974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUjkPGj47hm11KTQsm2hKqLSxMMo/hgYDvHHmf6hkiE=;
        b=IP/PDCEsd0PVRsWsHD0JmXSRKSEwEO1HcGf6VnDvvvjMw0z5SiNrnrsnFzM+hKIcL4
         0idEuJQELCrbUDcXnFTxTQLRnkfnlczbXDdVeWhw+NKbYCF9gFhq9jZijwfQsHmuy3XJ
         xoIpXdU4AhkADryqy8LegOAsNuXgW0d+g+M9aMENw9T8Gx5Bc4DsuogE8qIwqsWJWqr1
         16ibO8psp8ROAJMwMuHbwkriKxPU2HTFAqSFh1aw77pf/S11uFB0pSX0T3izotuCqott
         wsA6H3vl4h2vYz4s2yRXf2ZY46V+8tE79m38OGrD7CMjlA3rU8gy/fdfCSb/w9DITXL8
         Z2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736013174; x=1736617974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUjkPGj47hm11KTQsm2hKqLSxMMo/hgYDvHHmf6hkiE=;
        b=EbUx6eoifXEeqSoR53W2aqillTqCl2xTfJ3OPRWALhzVUfF3GQezAo3U5AtACPjZXR
         bnGY6NMpCCr49+VQVUwlGWO57l6PWwyJYgVzuxHNH5mMyEfp8QiNmys3PxkuKTiOOl48
         kerNCeECuEQ17JAUJAT9t64kv/zt+YhQ9pGFwkVUYSO/nItXqVjutVi4+0Qw3s+stNbn
         eMk6cyRtHrQHf6uIm2a2QadsHNS2L5dozRX6Kh+YG1aZJAtlZLbXJHMUQTeSMt8t7CNC
         qIomOjGwgyC80oGnW/DUWTYNdIkKSvOvpPxdql3Fp+BOR9Gm7icx3OADVpZFPr75NPa9
         hKAA==
X-Forwarded-Encrypted: i=1; AJvYcCUVs4OQ2H6bdqXaH4ZaXIyZWxQDAE6Wgk3PReBeuaV88bFxoxzhV5GQwgBryW9Dw0/euRY=@vger.kernel.org, AJvYcCXrdIQvnASAj2PWdanLjSZDG4DqLYnXiek1p3q+9AFnLzSpNY9NoL+2oKlm9Gewe+U+vImX47Tu9fl79Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqu5bFIfVlSgudb23LgmQ0ieknNml+tTdRyCc6shueEIaDX59b
	RrEOx328ApnKTCEtY9X4FnwQMKEINNZ3HawBAjr/JCrngWhIMl1DdEnNZRG6hvz5RfJ9rNEHwQ2
	8qrC+qppsqTmu4R+oO+ZqzaiwgiY=
X-Gm-Gg: ASbGnctOzdMY7Xrs6/TC5ECqfw2zxJwMnF992snGZ6EK6Ml5hHdV10JZIEgxujmzV1Z
	DT4yB42a2t924hH3AQjjtZA7ztx7+v68lTuBevkdG
X-Google-Smtp-Source: AGHT+IG7KRbfgRYvJrxcZgctdUiqfo+/iWiuWGtHyeYRqcBAPLNuiD8tFKWpsZsOjnyhO1nbDBXrZ5pr9sZU7MnA6P8=
X-Received: by 2002:a05:690c:7109:b0:6ef:6178:404a with SMTP id
 00721157ae682-6f3f820d3a0mr354863937b3.33.1736013173669; Sat, 04 Jan 2025
 09:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
In-Reply-To: <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Sat, 4 Jan 2025 23:22:40 +0530
Message-ID: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Song Liu <song@kernel.org>, hch@infradead.org, yanjun.zhu@linux.dev
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you all for your valuable feedback. I'd like to provide more
technical context about our implementation and the specific challenges
we're facing.

System Architecture:
We've built a block-level continuous data protection system that:
1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sect=
ors
2. Captures sector numbers (not data) of changed blocks in real-time
3. Periodically syncs the actual data from these sectors based on
configurable RPO
4. Layers these incremental changes on top of base snapshots

Current Implementation:
- eBPF program attached to block_rq_complete tracks sector ranges from
bio requests
- Changed sector numbers are transmitted to a central dispatcher via websoc=
ket
- Dispatcher initiates periodic data sync (1-2 min intervals)
requesting data from tracked sectors
- Base snapshot + incremental changes provide point-in-time recovery capabi=
lity

@Christoph: Regarding stability concerns - we're not using tracepoints
for data integrity, but rather for change detection. The actual data
synchronization happens through standard block device reads.

Technical Challenge:
The core issue we've identified is the gap between write completion
notification and data availability:
- block_rq_complete tracepoint triggers before data is actually
persisted to disk
- Reading sectors immediately after block_rq_complete often returns stale d=
ata
- Observed delay between completion and actual disk persistence ranges
from 3-7 minutes
- Data becomes immediately available only after unmount/sync/reboot

@Song: Our approach fundamentally differs from md/raid in several ways:

1. Network-based vs Local:
   - Our system operates over network, allowing replication across
geographically distributed systems
   - md/raid works only with locally attached storage devices

2. Replication Model:
   - We use asynchronous replication with configurable RPO windows
   - md/raid requires synchronous, immediate mirroring of data

3. Recovery Capabilities:
   - We provide point-in-time recovery through incremental sector tracking
   - md/raid focuses on immediate redundancy without historical state

@Zhu: The eBPF performance impact is minimal as we're only tracking
sector numbers, not actual data. The main overhead comes from the
periodic data sync operations.

Proposed Enhancement:
We're looking for ways to:
1. Detect when data is actually flushed to disk
2. Track the relationship between bio requests and cache flushes
3. Potentially add tracepoints around such operations

Questions for the community:
1. Are there existing tracepoints that could help track actual disk persist=
ence?
2. Would adding tracepoints in the page cache writeback path be feasible?
3. Are there alternative approaches to detecting when data is actually
persisted?

Would love to hear the community's thoughts on this specific challenge
and potential approaches to addressing it.

Best regards,
Vishnu KS


On Sat, 4 Jan 2025 at 06:41, Song Liu <song@kernel.org> wrote:
>
> Hi Vishnu,
>
> On Tue, Dec 31, 2024 at 10:35=E2=80=AFPM Vishnu ks <ksvishnu56@gmail.com>=
 wrote:
> >
> > Dear Community,
> >
> > I would like to propose a discussion topic regarding the enhancement
> > of block layer tracepoints, which could fundamentally transform how
> > backup and recovery systems operate on Linux.
> >
> > Current Scenario:
> >
> > - I'm developing a continuous data protection system using eBPF to
> > monitor block request completions
>
> This makes little sense. It is not clear how this works.
>
> > - The system aims to achieve reliable live data replication for block d=
evices
> > Current tracepoints present challenges in capturing the complete
> > lifecycle of write operations
>
> What's the difference between this approach and existing data
> replication solutions, such as md/raid?
>
> >
> > Potential Impact:
> >
> > - Transform Linux Backup Systems:
> > - Enable true continuous data protection at block level
> > - Eliminate backup windows by capturing changes in real-time
> > - Reduce recovery point objectives (RPO) to near-zero
> > - Allow point-in-time recovery at block granularity
> >
> > Current Technical Limitations:
> >
> > - Inconsistent visibility into write operation completion
> > - Gaps between write operations and actual data flushes
> > - Potential missing instrumentation points
>
> If a tracepoint is missing or misplaced, we can fix it in a patch.
>
> > - Challenges in ensuring data consistency across replicated volumes
> >
> > Proposed Improvements:
> >
> > - Additional tracepoints for better write operation visibility
> > - Optimal placement of existing tracepoints
> > - New instrumentation points for reliable block-level monitoring
>
> Some details in these would help this topic proposal.
>
> Thanks,
> Song

--=20
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

