Return-Path: <bpf+bounces-46164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27D9E5C8A
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC76728227C
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B8224AEF;
	Thu,  5 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3/wCkWK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44F222578
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418431; cv=none; b=b+gY20a1Kxkk/4AMa+Wd9EoOaextggDH6ay0bCtq4GF87Or9Wg/ltOzAnr4H4RdcK7RtaKOuSN095Lg7/Dd8OP9P957i3b8gEcNaQTEC8xK28vCRgnccDmoBb590JfNhXEr3WkjiIvkoYeGPkvf1eJ4NhAbWk7uU4PIZPELQF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418431; c=relaxed/simple;
	bh=glK+AHLXKeJQC5ZfaFi+M8jYSVrE9I9Wwr2Ye8s07ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgWHrD4tlrxd/iIZgXHagdAfKE6gfUc6v4rPkb4MKMuuHz7uLwlYvRyYSNLDopcxgx5oLXNPQ31G1Qs8HAKtrfWhmgbFbFzpDEAPv3TqtxZ+X2FZIAjqmMu0q7pU1ltNZwkJNVp/FNV/t0vcRQmfi1RPKU4I+sA03BoSV8YBn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3/wCkWK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e27c75f4so957528f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418428; x=1734023228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glK+AHLXKeJQC5ZfaFi+M8jYSVrE9I9Wwr2Ye8s07ks=;
        b=Y3/wCkWK8YopSonb/HnKZeNLP6bD4WFiOaHxs/3sLwxMQW53PBmVvfCSc4lyrCm/oo
         OOfOab1uR/rRR1BC1hvCPIscs+Hvr6bTjD1dcdlpqhlk0/TxSGIW24JW9P7yblakjUHe
         /XGZ+cW33V22plNSLk/KlTwSI9fOVEaG1VN0SooiBnKJ3QSjaqbrheO8cZT8HDWP3DJv
         eUqXBOQiQ8n1vy3DTh1G3odHXCeBFU4AkEv5pwNfq6aDeGbAlCtdXWFoO8X5kKwk8sqS
         YCU3032q2DEzuXObSd9zWsnLH5xrEmlA11eT13gOlRqU7hMhKwASjICGWRT43TkZpSMU
         Cq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418428; x=1734023228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glK+AHLXKeJQC5ZfaFi+M8jYSVrE9I9Wwr2Ye8s07ks=;
        b=XGuBMk+TQe80VxNslihpeG/yvpUl/iX1pWcNdTRbrH0pV4dCnfSfgu3J4Yp0PAjMOR
         IAeQXLP+Vilt2pKfBvY7KU+wu8uWcrmIaOAZn2LjNdotj+LLjvV4EoeAlQZYC002VzpD
         6WjcFwY3ToZsSFx0GNswH/5TUZ61whMl2hlL+u3Q4P6D+nfvb+0RqQ9ba3ZhwEcDo/yQ
         OJKTH+mDd9rcHFfBC8cjVDIKLEOnpgEwF3ZJM9NMnBxnUcNTFvPtZkiGAnwZkCMzcmHN
         DdH3BN6aF88JbdCJdCmemX5Ufiej6qTd5NIwgOE20O8FUdsEllzI4glvlQZqRDWtAiOw
         MfOg==
X-Forwarded-Encrypted: i=1; AJvYcCXJxPlBqDSy9buBLAyOwfl/FfpxGezIJ9tbRedgLZWHo3g/3Ti0eXKXgfTYx1NHv/uUNKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRK5p5QtETmwV602hMVR4BhDhgDeM+ZoYTn+HbdAB6cDs4/m1w
	bzXjbLo5qXf2RGO9Mnj7/vTgzcUiJq62a8OfORI+H3/REnZB2j5WICff3G+M1rv5YireRCEM3lW
	c/oqCORMnDrYRj3M/VaYm3UXsEtQ=
X-Gm-Gg: ASbGncu/ymVCNJ4A+yCA8LcV5XZI9MiCDBE1T77/aiLVk5tUut9OkOG8JwoX1fsaKbn
	T4HfWkX2pbIxwFFKCbCnOz2WdZ822EpGUdDkMigWBv5qpxBY=
X-Google-Smtp-Source: AGHT+IFMz/W3Dqtfl7eq1yTQLFNmnEgWwQFqtjGPRlp//YfiiPfBjLBoIuNxPvYJpYD2cZZ2No8oINSki1lt70PZTVQ=
X-Received: by 2002:a05:6000:18a3:b0:385:fabf:13ca with SMTP id
 ffacd0b85a97d-385fd3edac8mr8534876f8f.32.1733418427606; Thu, 05 Dec 2024
 09:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com> <87frnai67q.fsf@toke.dk>
 <CAADnVQLD+m_L-K0GiFsZ3SO94o3vvdi6dT3cWM=HPuTQ2_AUAQ@mail.gmail.com> <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com>
In-Reply-To: <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Dec 2024 09:06:56 -0800
Message-ID: <CAADnVQLab0+JfMUy9RzU27hNsFfON1eu7Ta3VvzBAQp9R1m55w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 7/9] bpf: Use raw_spinlock_t for LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 12:53=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 12/3/2024 9:42 AM, Alexei Starovoitov wrote:
> > On Fri, Nov 29, 2024 at 4:18=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >> Hou Tao <houtao@huaweicloud.com> writes:
> >>
> >>> From: Hou Tao <houtao1@huawei.com>
> >>>
> >>> After switching from kmalloc() to the bpf memory allocator, there wil=
l be
> >>> no blocking operation during the update of LPM trie. Therefore, chang=
e
> >>> trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable =
in
> >>> atomic context, even on RT kernels.
> >>>
> >>> The max value of prefixlen is 2048. Therefore, update or deletion
> >>> operations will find the target after at most 2048 comparisons.
> >>> Constructing a test case which updates an element after 2048 comparis=
ons
> >>> under a 8 CPU VM, and the average time and the maximal time for such
> >>> update operation is about 210us and 900us.
> >> That is... quite a long time? I'm not sure we have any guidance on wha=
t
> >> the maximum acceptable time is (perhaps the RT folks can weigh in
> >> here?), but stalling for almost a millisecond seems long.
> >>
> >> Especially doing this unconditionally seems a bit risky; this means th=
at
> >> even a networking program using the lpm map in the data path can stall
> >> the system for that long, even if it would have been perfectly happy t=
o
> >> be preempted.
> > I don't share this concern.
> > 2048 comparisons is an extreme case.
> > I'm sure there are a million other ways to stall bpf prog for that long=
.
>
> 2048 is indeed an extreme case. I would do some test to check how much
> time is used for the normal cases with prefixlen=3D32 or prefixlen=3D128.

Before you do that please respin with comments addressed, so we can
land the fixes asap.

