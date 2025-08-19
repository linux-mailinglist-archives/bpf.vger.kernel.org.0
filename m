Return-Path: <bpf+bounces-65959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60585B2B728
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 04:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF4D1B66446
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E525B663;
	Tue, 19 Aug 2025 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfdgddhZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0D3595D
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571316; cv=none; b=Lyhu5u94fjWaqBr9HX+io60nN6xYrueZQlamQ+h1lBkX7N+hAVUGwKKKDShq8/pE40F4Z7cITDa+Uq3A/lJ+Zj6i/RQCsEjAt/QHccPaEDCpx2lYEO5sVAq+muN9LTkyWShygeigW+/pRpSgpah+B3mpe4K9yDGbZjEzyskmrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571316; c=relaxed/simple;
	bh=FBBMnupy1miWtjK3mHXaKyhcuVNHUdzgLcvS1MICxAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0ZdNEy9nqXtbfUpG0TxyU6QwZOeNfCFK4kIbHI3BHAGFC1QfPTpXEQFEEFxgp3YUAigoFlJJnvGQG5ttNCN5vJgsAKKAwuxc4GftwsR1W4KzPpy9Qqnzin+t1zAfetdYYkciwHXLuinD5ro5bkCFL/mbpEgcuEv8iUreaBTzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfdgddhZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a9f15f15fso38570796d6.2
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755571314; x=1756176114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onFaYc8Oi6sRPr9JC4nOACA346CgKiRanyJ+ix+sgzw=;
        b=bfdgddhZY0IxbpmOnD/HsWMW8wGRdnqIDv3W4NOizknbQsCI/BhLfGW8t2/+srIuEa
         IlEkDu7QQJNE0e00cpKeSbuh1ckVYNqs81QGqeXFFWMvhSWoCWebIZcwAJ5o4y1HOWJa
         BeoxskzjNulLJqQHxfIJLJLUcRlVanxT9rjE9Uz81nEzQUG8s0urPnZcfVOZwazQ2saH
         QO24TpkyStnPpqyZ5Uq3MFauIBPxtCGnfFGslpPZ8YRheJDpn9xd4Swgdj8vfK9Gqdb2
         603X6erYKNaSketl4HfZlUmhoAa3jocRwA/bhx6xKp6eu9NZALec1JkujJbuFB8lvnje
         ieDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755571314; x=1756176114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onFaYc8Oi6sRPr9JC4nOACA346CgKiRanyJ+ix+sgzw=;
        b=FygFkGuqXM6yTvp8juJ1Hw/Av6e8ED9ocnJhUPBMVxoX5JSywhP1RWNffRzmZ1TgBh
         /Mc4wg09ljC9dY5HlYsthK8/MrGTt/RNia2T+jdAMlA62EiUjvuEqLto75pSejNNyQJ5
         w1yLDlBtY6Aogi48AHBhcYS8K7jNHwP6Lk2Qhkacji7ah6cHXxBEqpnGOGWfE36DvjWQ
         mQ5M2E7mMuj/K5+AOqFy6rGSttj3aEp8Pf5CVtUKQdEdzJMKIznIqGdgfmVsgBgJ4YXV
         gglDNQnqXeI+tUWbYiw2v2/nH/uoVIdIEgIz3SRgdGF02/ibrdEs04ywVsh82F0Y/bT6
         14NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDsp6J0tuyh2CM7oDxcMkKSrR0AJreylFj2QPwK3nTagFY/LSKtKjvmcvnEZGN8rQsko4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMnLyALth5RlF64wgU0Aps8IwMcA+Y/JeQIR7Bv1n9fXFUXRK
	BBY7vqkKgP+GCmucgIVPdFY/8WTw2H/HGG5q681sF3TxgwBLM5VrYPM3ek35mviLNBoFzXzecu9
	RhBDUVNG4CzpabXN1XPPpTE/FNw9HZK8=
X-Gm-Gg: ASbGnct4505B/kP11EXyhVgiQ8v6H2Y9sP7ufO4hAvcHUPGooEMlycbopnXLPRGeuH/
	VO+rt2rX7IwoDe59a6Y4bkWZH0WH79NvywiYrXDubr62tAmFnwW4t8y0S6qVNoOHX/bCWttHulg
	qX2XoAECyPIAf9P3hvGD0A26Hxj5F7cp6uAXnlmrj/D/HCkcFoGqvyQjaNwM5KlBY48yADwsg3z
	opze3xm+bkb+sW7aJ+i3wq+8LgQKA==
X-Google-Smtp-Source: AGHT+IG2MXlbLljqpPYVKfINgcapRgtWELmnw39RaPgPOUN9RmrIkyy05SHyRlG7ZN69YOO4d+fangxxrTuPcoI+Z3I=
X-Received: by 2002:a05:6214:1c8c:b0:709:76b4:5934 with SMTP id
 6a1803df08f44-70c35d3b94dmr11874506d6.53.1755571313802; Mon, 18 Aug 2025
 19:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818055510.968-1-laoar.shao@gmail.com> <36c97fc6-eaa9-44dd-a52f-0b6bf5a001d9@gmail.com>
In-Reply-To: <36c97fc6-eaa9-44dd-a52f-0b6bf5a001d9@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 19 Aug 2025 10:41:16 +0800
X-Gm-Features: Ac12FXyJHg8YZsqiYvuaFXELA4COS9RCAKmGCWSNlwvRg3bmiOgm4T6wEBjyqco
Message-ID: <CALOAHbAQ=51mfszBN+Bvb9z+ZDyTBuCW_s0EKi+5rDghFvRZzg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 mm-new 0/5] mm, bpf: BPF based THP order selection
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:35=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 18/08/2025 06:55, Yafang Shao wrote:
> > Background
> > ----------
> >
> > Our production servers consistently configure THP to "never" due to
> > historical incidents caused by its behavior. Key issues include:
> > - Increased Memory Consumption
> >   THP significantly raises overall memory usage, reducing available mem=
ory
> >   for workloads.
> >
> > - Latency Spikes
> >   Random latency spikes occur due to frequent memory compaction trigger=
ed
> >   by THP.
> >
> > - Lack of Fine-Grained Control
> >   THP tuning is globally configured, making it unsuitable for container=
ized
> >   environments. When multiple workloads share a host, enabling THP with=
out
> >   per-workload control leads to unpredictable behavior.
> >
> > Due to these issues, administrators avoid switching to madvise or alway=
s
> > modes=E2=80=94unless per-workload THP control is implemented.
> >
> > To address this, we propose BPF-based THP policy for flexible adjustmen=
t.
> > Additionally, as David mentioned [0], this mechanism can also serve as =
a
> > policy prototyping tool (test policies via BPF before upstreaming them)=
.
>
> Hi Yafang,
>
> A few points:
>
> The link [0] is mentioned a couple of times in the coverletter, but it do=
esnt seem
> to be anywhere in the coverletter.

Oops, my bad.

>
> I am probably missing something over here, but the current version won't =
accomplish
> the usecase you have described at the start of the coverletter and are ai=
ming for, right?
> i.e. THP global policy "never", but get hugepages on an madvise or always=
 basis.

In "never" mode, THP allocation is entirely disabled (except via
MADV_COLLAPSE). However, we can achieve the same behavior=E2=80=94and
more=E2=80=94using a BPF program, even in "madvise" or "always" mode. Inste=
ad
of introducing a new THP mode, we dynamically enforce policy via BPF.

Deployment Steps in our production servers:

1. Initial Setup:
- Set THP mode to "never" (disabling THP by default).
- Attach the BPF program and pin the BPF maps and links.
- Pinning ensures persistence (like a kernel module), preventing
disruption under system pressure.
- A THP whitelist map tracks allowed cgroups (initially empty =E2=86=92 no =
THP
allocations).

2. Enable THP Control:
- Switch THP mode to "always" or "madvise" (BPF now governs actual allocati=
ons).

3. Dynamic Management:
- To permit THP for a cgroup, add its ID to the whitelist map.
- To revoke permission, remove the cgroup ID from the map.
- The BPF program can be updated live (policy adjustments require no
task interruption).

> I think there was a new THP mode introduced in some earlier revision wher=
e you can switch to it
> from "never" and then you can use bpf programs with it, but its not in th=
is revision?
> It might be useful to add your specific usecase as a selftest.
>
> Do we have some numbers on what the overhead of calling the bpf program i=
s in the
> pagefault path as its a critical path?

In our current implementation, THP allocation occurs during the page
fault path. As such, I have not yet evaluated performance for this
specific case.
The overhead is expected to be workload-dependent, primarily influenced by:
- Memory availability: The presence (or absence) of higher-order free pages
- System pressure: Contention for memory compaction, NUMA balancing,
or direct reclaim

>
> I remember there was a discussion on this in the earlier revisions, and I=
 have mentioned this in patch 1
> as well, but I think making this feature experimental with warnings might=
 not be a great idea.

The experimental status of this feature was requested by David and
Lorenzo, who likely have specific technical considerations behind this
requirement.

> It could lead to 2 paths:
> - people don't deploy this in their fleet because its marked as experimen=
tal and they dont want
> their machines to break once they upgrade the kernel and this is changed.=
 We will have a difficult
> time improving upon this as this is just going to be used for prototyping=
 and won't be driven by
> production data.
> - people are careless and deploy it in on their production machines, and =
you get reports that this
> has broken after kernel upgrades (despite being marked as experimental :)=
).
> This is just my opinion (which can be wrong :)), but I think we should tr=
y and have this merged
> as a stable interface that won't change. There might be bugs reported dow=
n the line, but I am hoping
> we can get the interface of get_suggested_order right in the first implem=
entation that gets merged?

We may eventually remove the experimental status or deprecate this
feature entirely, depending on its adoption. However, the first
critical step is to make it available for broader usage and
evaluation.

--=20
Regards
Yafang

