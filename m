Return-Path: <bpf+bounces-22037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36838556CC
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 00:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6650A1F22536
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1538128388;
	Wed, 14 Feb 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gt5CNsqr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18F2E629
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951753; cv=none; b=inJ6ptNP6uzyR4bgSXwIQ+smy1tF+SXydIYXMo1PFjSrg2v2BmyEjcOTCeHZY1U/3N+wbALuMxNhdOvofT+diwMTfJMsvfM14sps88Usq3ewVEkGmind1Y6098G2WnRjHR5sGu6xhoYJS1S7sRUX8ud3Bz7VKb8QQS4FhxCEL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951753; c=relaxed/simple;
	bh=cqWEKTv+pK5/gmdVatT0ND12R+9NOiP4SAY4OtzSw/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fxsmQV0jNh1mMhVvLok8bp6iEYmcEghZsh0P9vO/9rV5sxMKRM5D+J5rOrF0N9hG17+uDQoppJYJ56XtO+Flgz2Icm7vYiTuHE4kX6BMJ2jWNj7QzZCCU8b6e/fKFo/n5iuOSVSikxyv87z8w5QZxB4lWvlG3YF/fC08oAdiRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gt5CNsqr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707951750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqWEKTv+pK5/gmdVatT0ND12R+9NOiP4SAY4OtzSw/0=;
	b=Gt5CNsqrMA2KY6/kegyD6QHn77uRRDIV+ofhJz5maBjFozUud2flJ6uH4rtrYGob/CrQY0
	LvgPs0PRwalRcKBIflMW8FDoXe7HSv5AERw3aB3pTT1hNRkfMJU+GWYZ7GaKYWSwcAQJw5
	QleoQY2RF+AcBVeo4axekgIam8SX0OA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-c8xi79b-MjyzOf0q6f00tg-1; Wed, 14 Feb 2024 18:02:29 -0500
X-MC-Unique: c8xi79b-MjyzOf0q6f00tg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3d821780f3so6256966b.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 15:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951748; x=1708556548;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqWEKTv+pK5/gmdVatT0ND12R+9NOiP4SAY4OtzSw/0=;
        b=MMbEfWpLrGP3ksmREy5a0hT5gsA7vlM6KddI353qWmd/tN2/kGdE79EBmhvHOmgDT+
         GqG7tszzxkU75mSUv3Qp4wvkjM1a4cZHTUGYf2MFCIkVbGY285Z69mpU2VSi4aG2Zx3b
         1+OopCrIzywN69YXi+wdm3yPta6SsT0dvo3NKSaqDeZt9faEgsx8CJ+CTlFH/YxOfSV3
         4nlRnIz8XqcTOUgzy+vW+SEdjvPslPix18dywxFirTpvUgzqrwYJFgi51rbjHdRBQkVF
         9DDyW6ZRs5DUjT1ct50uLvrD+qB5aRTorJSeML4l/oUCZaHHxlg5vnCkvAfcMpSe3Gmx
         XqRg==
X-Forwarded-Encrypted: i=1; AJvYcCXANdzcgGLqGU1N58vcOzRIs4Jyt6InOvxljap2uYKJG3yp11J06mnzTm2SqMfDIptjxDjqfWI0IDkesxpt8kyEr3Yp
X-Gm-Message-State: AOJu0Yzd7ss1CSp7iRzdi7jXJFjtvW/ol/kDID4qpv7iv149FgO1ZSGP
	UamcDk6m81kVcAtfg9jw52OFeGr7KqNwGoeMVqvuUcWoMNdSWQXcrMCluakySRDLiXRoCFcrkkj
	/r1JWhIrRj45EuxDvbgFsAiUHV/K/g8Fq5YVyna0hPvukD/mXzQ==
X-Received: by 2002:aa7:d952:0:b0:561:ced:4093 with SMTP id l18-20020aa7d952000000b005610ced4093mr22860eds.36.1707951748117;
        Wed, 14 Feb 2024 15:02:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwAbv0p8XEb5CZdU5nMo7RDOF7CDGsdXTO6nSa/5ofpKs9OFHHVE7UovDzYvqv85RDWD1I6A==
X-Received: by 2002:aa7:d952:0:b0:561:ced:4093 with SMTP id l18-20020aa7d952000000b005610ced4093mr22849eds.36.1707951747837;
        Wed, 14 Feb 2024 15:02:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfRik3tmJcJzfVLZR6jJMe8DjlZAARqkTe6s9rFnew4TeesqnMQI7SKcYnc+489yEQ+47mclWuRfTvyjJ2qhtRz9XjmQMpyNpxiG/KOrikjIJmvs/tb8ON0jVFmdLUGdoR/E38cMmNcI+woJxddxG/r0VSibLUsEpBh6YNmv7Npoo+BXO/y+Nrz5xlei8Mo3ETAqGPocxvL01Tn1xJyb8T6guNzM3qComNvvjdwG6iZCcHQD/TI53QRL9xXaK3R+SDTrvHM0lLnMj25yL5+VbaG0CXlH0n9KbHgLZRrCr83aImuRMkjzF1erFFbrJv1RrhNtf+YssD
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c37-20020a509fa8000000b005639c8b6922sm333804edf.52.2024.02.14.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:02:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1630A10F586A; Thu, 15 Feb 2024 00:02:27 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf/test_run: increase Page Pool's ptr_ring
 size in live frames mode
In-Reply-To: <87cyszdnrz.fsf@toke.dk>
References: <20240214153838.4159970-1-aleksander.lobakin@intel.com>
 <87cyszdnrz.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Feb 2024 00:02:27 +0100
Message-ID: <87y1bmd4zg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>
>> Currently, when running xdp-trafficgen, test_run creates page_pools with
>> the ptr_ring size of %NAPI_POLL_WEIGHT (64).
>> This might work fine if XDP Tx queues are polled with the budget
>> limitation. However, we often clear them with no limitation to ensure
>> maximum free space when sending.
>> For example, in ice and idpf (upcoming), we use "lazy" cleaning, i.e. we
>> clean XDP Tx queue only when the free space there is less than 1/4 of
>> the queue size. Let's take the ring size of 512 just as an example. 3/4
>> of the ring is 384 and often times, when we're entering the cleaning
>> function, we have this whole amount ready (or 256 or 192, doesn't
>> matter).
>> Then we're calling xdp_return_frame_bulk() and after 64th frame,
>> page_pool_put_page_bulk() starts returning pages to the page allocator
>> due to that the ptr_ring is already full. put_page(), alloc_page() et at
>> starts consuming a ton of CPU time and leading the board of the perf top
>> output.
>>
>> Let's not limit ptr_ring to 64 for no real reason and allow more pages
>> to be recycled. Just don't put anything to page_pool_params::size and
>> let the Page Pool core pick the default of 1024 entries (I don't believe
>> there are real use cases to clean more than that amount of descriptors).
>> After the change, the MM layer disappears from the perf top output and
>> all pages get recycled to the PP. On my test setup on idpf with the
>> default ring size (512), this gives +80% of Tx performance with no
>> visible memory consumption increase.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> Hmm, so my original idea with keeping this low was to avoid having a lot
> of large rings lying around if it is used by multiple processes at once.
> But we need to move away from the per-syscall allocation anyway, and
> with Lorenzo's patches introducing a global system page pool we have an
> avenue for that. So in the meantime, I have no objection to this...
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Actually, since Lorenzo's patches already landed in net-next, let's just
move to using those straight away. I'll send a patch for this tomorrow :)

-Toke


