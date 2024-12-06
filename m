Return-Path: <bpf+bounces-46225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E29E637B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62B91655CD
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4713C8F4;
	Fri,  6 Dec 2024 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKWBgwvh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008576048
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449256; cv=none; b=nRCtYGj2QlYvDH4+sDsXo0u5coowxT826oTq0gBPt8A1VtlCAKAcit1AIh1zcGG7y9bXkKeKdPET/trweqkqFvAjeMmRQUAj3m0vz092npGBwIt7THcU1EYYxXzwFHpA/4QhyzDWuxh/UtuHBNCxwYSCDDyVSXsYcOv1lnoNCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449256; c=relaxed/simple;
	bh=9RSQKui+PEJIoP2yPcwXFD6HDVIiSGfhrNG1hUL1bUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNPo2eJnaXu96pVg1veQSlZiMBncLI+R4IKt19ZWaZNoQXAreVEddRsErv60vTLRSxvKJVDYwXO9hTm0sJUOB+S6fDzwu3nxCiak/ExBBK4Pxvf08aVrlVfLJ2+CA5Rd74VMrZgfJ4npgedyUlQeyJNJRezfBa2IstFSXQgDFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKWBgwvh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so161333f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 17:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733449252; x=1734054052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSYGXlTsKKdQHk1Dayk9GwQPi+OMsAHKuztQbCJ+Ym8=;
        b=nKWBgwvhB84w2VqiiYAQzcUq6xvF2PgWrUvlxiH1CAQVi4TZkgruMpJtYybkDtw5Io
         6nfnCgVgbALYxKy7g69x7V3gAKMbHAsF2lDGes0UncRhHZGbLU06z2F5zwQU+ZExmrcN
         Smjc8CXQddYXK4sbvs8g4ldWL7F1x8dexmCDT/ETXiNILB+4IsmlRdYxdbXJAZ3ukG2b
         XVAkWkikn1PKQTAMyVgDPezDRIYICWow9AJkcbPC9AqljUukubh5KZR154HQrTC5LQI5
         XroSNJj7VyrACFMzl3REengy+lA0XDH69Kkr2HUokqep5kRTil+6x/MTlS5AABwuNTGB
         APbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733449252; x=1734054052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSYGXlTsKKdQHk1Dayk9GwQPi+OMsAHKuztQbCJ+Ym8=;
        b=QuW84bKylli37/P+jpFpbKUnznpJoS9BoBo1ECqIhWGhFuBlerPYqAh41UCaWRsnLC
         DoH2QjyVCqglAyb3vr8wR+wUvffOwh9Ld3ePjr1ZdO21VRMTC1m3e03quB7GwPWOkErd
         TLKsaSKnDh64AXOJPK7ljHc+Lk6NPpwGuwzAC1Km5GgL85oXsfRwEKOfbKfE0bOjw9Uo
         KV8AOz7GvPzD4H5epv8UDoK/M6vm4srcKS66QxhRboeaOgvE2UvgvWhXwlFCUdckiSGC
         hax46zpkoBa2Ai3rxQIhH3UkHMgj1ohE5zZAPC+TYdkvnYZpQrmudVMzPENgcjt+EJqD
         siAw==
X-Forwarded-Encrypted: i=1; AJvYcCXS11CCG5ZkbuZmM5wJHVO4vilOvNIbxiq1d0xmSjbZ2OsRrpvXh4YaJ7HBzxkFHo0F7GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyVLnqEgFi7ORGfsmKlxQb8RpbYsXmFmZIS8tVMGfEcS5oFvE
	tVEaTrMCXpVYuo+Sqg+OjQvlTYg2/W424nnbwKweLqptSTGXtqpkQDIWxM8UJirmY2b/JGqmISu
	HAcnHValR6IGQxGsY13DJ/jtfCPo=
X-Gm-Gg: ASbGncuIC1t1AHMMDGzVMPlArjqt7vH2AOiy27iyYUG2oHBlTJWwowhjZ5tjWDlHKew
	6j8WgUyT6nVi4avDSFfd2YhoWHL7fexwg6jpLezBauIA76PU=
X-Google-Smtp-Source: AGHT+IG3KZdBxbPiJLR3rUkfTSJs+UvU+dTKtxInE8gAmqiT0uo9EskI9cEYCEGCX8KeNZ3qkAwDwpCDh0eeFuFRtDU=
X-Received: by 2002:a05:6000:184d:b0:385:f47b:1501 with SMTP id
 ffacd0b85a97d-3862b379eacmr733295f8f.32.1733449252336; Thu, 05 Dec 2024
 17:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com> <87frnai67q.fsf@toke.dk>
 <CAADnVQLD+m_L-K0GiFsZ3SO94o3vvdi6dT3cWM=HPuTQ2_AUAQ@mail.gmail.com>
 <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com> <CAADnVQLab0+JfMUy9RzU27hNsFfON1eu7Ta3VvzBAQp9R1m55w@mail.gmail.com>
 <1cddf09f-5da6-63e6-7317-33907e196767@huaweicloud.com>
In-Reply-To: <1cddf09f-5da6-63e6-7317-33907e196767@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Dec 2024 17:40:41 -0800
Message-ID: <CAADnVQJcemLLK5MQgT6gtChqL6Hocuz+ez_QGedNnw0nBvVZKQ@mail.gmail.com>
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

On Thu, Dec 5, 2024 at 4:48=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 12/6/2024 1:06 AM, Alexei Starovoitov wrote:
> > On Thu, Dec 5, 2024 at 12:53=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 12/3/2024 9:42 AM, Alexei Starovoitov wrote:
> >>> On Fri, Nov 29, 2024 at 4:18=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> >>>> Hou Tao <houtao@huaweicloud.com> writes:
> >>>>
> >>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>
> >>>>> After switching from kmalloc() to the bpf memory allocator, there w=
ill be
> >>>>> no blocking operation during the update of LPM trie. Therefore, cha=
nge
> >>>>> trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usabl=
e in
> >>>>> atomic context, even on RT kernels.
> >>>>>
> >>>>> The max value of prefixlen is 2048. Therefore, update or deletion
> >>>>> operations will find the target after at most 2048 comparisons.
> >>>>> Constructing a test case which updates an element after 2048 compar=
isons
> >>>>> under a 8 CPU VM, and the average time and the maximal time for suc=
h
> >>>>> update operation is about 210us and 900us.
> >>>> That is... quite a long time? I'm not sure we have any guidance on w=
hat
> >>>> the maximum acceptable time is (perhaps the RT folks can weigh in
> >>>> here?), but stalling for almost a millisecond seems long.
> >>>>
> >>>> Especially doing this unconditionally seems a bit risky; this means =
that
> >>>> even a networking program using the lpm map in the data path can sta=
ll
> >>>> the system for that long, even if it would have been perfectly happy=
 to
> >>>> be preempted.
> >>> I don't share this concern.
> >>> 2048 comparisons is an extreme case.
> >>> I'm sure there are a million other ways to stall bpf prog for that lo=
ng.
> >> 2048 is indeed an extreme case. I would do some test to check how much
> >> time is used for the normal cases with prefixlen=3D32 or prefixlen=3D1=
28.
> > Before you do that please respin with comments addressed, so we can
> > land the fixes asap.
>
> OK. Original I thought there was no need for respin. Before posting the
> v3, I want to confirm the comments which need to be addressed in the new
> revision:
>
> 1) [PATCH bpf v2 6/9] bpf: Switch to bpf mem allocator for LPM trie
> Move  bpf_mem_cache_free_rcu outside of the locked scope (From Alexei)
> Move the first lpm_trie_node_alloc() outside of the locked scope (There
> will be no refill under irq disabled region)
>
> 2)  [PATCH bpf v2 2/9] bpf: Remove unnecessary kfree(im_node) in
> lpm_trie_update_elem
> Remove the NULL init of im_node (From Daniel)

Looks about right. That was 9 days ago. I cannot keep ctx for so long.
Re-read the threads just in case. If you miss something it's not a big
deal either.

