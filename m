Return-Path: <bpf+bounces-58965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E6AC47C5
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 07:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A853A7D42
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 05:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01D1D416E;
	Tue, 27 May 2025 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk3AacUA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCECD2F29
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748324800; cv=none; b=vBtNaN4LF/Xlc8V1KzkGPeg88sZhHRRjo7e2XD5CVneQFKAwGnxYcHsjd9ckb9K1bAQ+g8l8a+/z/lPB71X4Px694Di1Wn1j/61RhZTT3Nhfzu23KAsImxRVxG6d82DExJ8C/nE95SAmM1LLCMsph1GD+xsNcAAAWxoypAf4kgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748324800; c=relaxed/simple;
	bh=6fyjvr1EyBNhefZXAAGUEI92ndBu7h5UC5abYfiM2zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSPa1QCMqI0zd1QtZUtGj2oL05bwtve1mf+tj94xzY5sV4QV9foiOnnTNFbvBOrGNWjtmduN465pgzWi6bJDVSzjWqnXOgfkIO5xIPKq2Symi1k9+QYkfPVvyVP0H9Kki6yG3gg4nJHC/vNKpF82j+dJCrthrw4KciVv32qSCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk3AacUA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6faa19e0661so24706206d6.3
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 22:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748324797; x=1748929597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJCbc0a/7ZaQAm2xUfaAihletUL+93qyJ5pWtxixAyM=;
        b=Nk3AacUAQyMIDB8k2LTnuPfGiOtuFTwyXZ5Gha6ibSPG1Zcmw8GnDxYW2LI9au09hT
         WErrMszxTG2sY5dVnBGBfGagkEq5MjaQC9r2borpg6C4ZqIksk8Q6MHj2mHYRL/K5QDV
         FhdBu/NZrl3Ud5iAmrZly006K6p5AaNVwX0YaynyyBjsxm2il5s5Y4hjABIPr9AsP0iT
         ZvJFzBCrFoUwVz5KqEgSfV6CJwGMYKNP+txf5s77Y0qvqdkjBKx2+NI9FyLnA0q+tIVv
         wU9rnV9EpooZlsWnY6BeE6n+qIj0xsmvxhBoMTfK2Lh0dUInGlax1aukNKNNQ5mkg44U
         s72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748324797; x=1748929597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJCbc0a/7ZaQAm2xUfaAihletUL+93qyJ5pWtxixAyM=;
        b=TU3aiRQdAQ+FWkw3IFk5W+0ea/b7i6Y0R144KdoOiMJatG0hgqXCwwwthtGbs3UFzn
         hSmgpz6PWZpUkBOIyJ43yAAy/kSJepkn3/ZfDMO//AsWlTkztFN8+LenKk0pc4+VnMzQ
         gHOQAPEVRAaOheNxqARzSKeEknO8p9jYvBImhHNOBu40Ac/6i70GOK3+ZxHDCvycFTNU
         6mrL2R5b0G63/cbMve2sjgLBbo8w7J3Er5LozjrBuppWQ8/rSwCTzG4ZIlfVLkJlMH8e
         8FcE/8dsUHzaq+Sk4Pvf4ifhDC5jWtcWN/Xmcyqul+I3gk5M1EUp+0WKJ728KQ01evEy
         NM2w==
X-Forwarded-Encrypted: i=1; AJvYcCXgxjcctWXc3A9cm2e2dquy3tpGMViLk9FqSkdU2/JFNPL0JrAxV7hcdUoVYTldMU9HtFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+nr4/kCn4oVmsPsNHcG8gLIbDnihLrp2/BkACAkvB56fYPb0
	LOy7UU9NbPsecEFiGMztiJtJv2VJ0eVIgyr5QsB8OPltZC5vmIPiGhbijqqdnqrZHO7pTXFATNx
	Coi4TXrRBj1z4TgepruTjZA2PtB8rgR8=
X-Gm-Gg: ASbGncuPRHMVfyLr9UKc+Yxk8Ph6+ZrJx6guHeUC2OKkG1At2nueZOcGHoD5j/dtMv0
	LI/WD+WpawY6YfyQB9U+L1R3e5ZRbOesfT6NmUkXhqgT8dcc4maoIAMGe9DOz0pKE1/dQdBOumv
	O9Q6qPBceE+k1ycV+UYaWdxD10Hl96LHbe6g==
X-Google-Smtp-Source: AGHT+IHFv8XfeiCYCS6zO0b40EF+rNhPdykuEeUe5/KMpUgIAYcJjX/h1tjox31xMMH7KohYXXBjHoGZ1/gM/+uGgBw=
X-Received: by 2002:a05:6214:1d23:b0:6e6:6964:ca77 with SMTP id
 6a1803df08f44-6fa9d29c58dmr192563776d6.28.1748324797546; Mon, 26 May 2025
 22:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com> <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
In-Reply-To: <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 May 2025 13:46:00 +0800
X-Gm-Features: AX0GCFv-hbtWMTLiDK07hhh-THJXY8FnrcFFxVUq6drCNZyBETIZNFd3z_p_uq0
Message-ID: <CALOAHbBjueZhwrzp81FP-7C7ntEp5Uzaz26o2s=ZukVSmidEOA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 6:49=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.05.25 11:37, Yafang Shao wrote:
> > On Mon, May 26, 2025 at 4:14=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >>> Hi all,
> >>>
> >>> Let=E2=80=99s summarize the current state of the discussion and ident=
ify how
> >>> to move forward.
> >>>
> >>> - Global-Only Control is Not Viable
> >>> We all seem to agree that a global-only control for THP is unwise. In
> >>> practice, some workloads benefit from THP while others do not, so a
> >>> one-size-fits-all approach doesn=E2=80=99t work.
> >>>
> >>> - Should We Use "Always" or "Madvise"?
> >>> I suspect no one would choose 'always' in its current state. ;)
> >>
> >> IIRC, RHEL9 has the default set to "always" for a long time.
> >
> > good to know.
> >
> >>
> >> I guess it really depends on how different the workloads are that you
> >> are running on the same machine.
> >
> > Correct. If we want to enable THP for specific workloads without
> > modifying the kernel, we must isolate them on dedicated servers.
> > However, this approach wastes resources and is not an acceptable
> > solution.
> >
> >>
> >>   > Both Lorenzo and David propose relying on the madvise mode. Howeve=
r,>
> >> since madvise is an unprivileged userspace mechanism, any user can
> >>> freely adjust their THP policy. This makes fine-grained control
> >>> impossible without breaking userspace compatibility=E2=80=94an undesi=
rable
> >>> tradeoff.
> >>
> >> If required, we could look into a "sealing" mechanism, that would
> >> essentially lock modification attempts performed by the process (i.e.,
> >> MADV_HUGEPAGE).
> >
> > If we don=E2=80=99t introduce a new THP mode and instead rely solely on
> > madvise, the "sealing" mechanism could either violate the intended
> > semantics of madvise(), or simply break madvise() entirely, right?
>
> We would have to be a bit careful, yes.
>
> Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because
> these options also fail with -EINVAL on kernels without THP support.
>
> Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
>
> What you likely really want to do is seal when you configured
> MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.
>
> >>
> >> The could be added on top of the current proposals that are flying
> >> around, and could be done e.g., per-process.
> >
> > How about introducing a dedicated "process" mode? This would allow
> > each process to use different THP modes=E2=80=94some in "always," other=
s in
> > "madvise," and the rest in "never." Future THP modes could also be
> > added to this framework.
>
> We have to be really careful about not creating even more mess with more
> modes.
>
> How would that design look like in detail (how would we set it per
> process etc?)?

I have a preliminary idea to implement this using BPF. We could define
the API as follows:

struct bpf_thp_ops {
       /**
        * @task_thp_mode: Get the THP mode for a specific task
        *
        * Return:
        * - TASK_THP_ALWAYS: "always" mode
        * - TASK_THP_MADVISE: "madvise" mode
        * - TASK_THP_NEVER: "never" mode
        * Future modes can also be added.
        */
       int (*task_thp_mode)(struct task_struct *p);
};

For observability, we could add a "THP mode" field to
/proc/[pid]/status. For example:

$ grep "THP mode" /proc/123/status
always
$ grep "THP mode" /proc/456/status
madvise
$ grep "THP mode" /proc/789/status
never

The THP mode for each task would be determined by the attached BPF
program based on the task's attributes. We would place the BPF hook in
appropriate kernel functions. Note that this setting wouldn't be
inherited during fork/exec - the BPF program would make the decision
dynamically for each task.
This approach also enables runtime adjustments to THP modes based on
system-wide conditions, such as memory fragmentation or other
performance overheads. The BPF program could adapt policies
dynamically, optimizing THP behavior in response to changing
workloads.

As Liam pointed out in another thread, naming is challenging here -
"process" might not be the most accurate term for this context.

--=20
Regards
Yafang

