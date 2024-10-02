Return-Path: <bpf+bounces-40751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A998CED1
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC05B1F213B4
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F56F195FCE;
	Wed,  2 Oct 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVSH3XHP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54619580B
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858164; cv=none; b=MQtvprDm6Q2mTynvZFUW4DtufAUkrIFEkHl5TtAMXQGRt/z5uc7F4xDYAUgb0SOCpDlim5aGCr3cYkkxT9JmtU0xRa6iCZwbKAhQPBtNmBYVrDy73f5k1mHQULwn1kNJLezZSZJT9ysDN7dF5hIy8/37f7xtVSCEi1PpSE4vt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858164; c=relaxed/simple;
	bh=3Lqi/OXxA00eaLf8XiOP46D2ukKfPmvmLfoAbIztisU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XFMeHGFd4on9MmNmNKldLfqBW3fXl84QKvWE5L3Mt5RQIjTEdgvnRyhX1OzF2ygr+9FA0Zd+Si85+7T5S8RIxs4KW5PWt24IHAEcqkTPuEv+aSVjfJdYBFn04up7d3JvxWtolQsuABk3mwpDYMPhFxw3wknrSbMhlks4da7N7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVSH3XHP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727858161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0mOeG6DrEcLzm/NhKgCIaXI+fTzk5B5rgZ8qzhrCw4=;
	b=fVSH3XHPlBWXmQpxeYg4N59NBTzE6dVImyMfQsAoK4jB7dUpc3bvjtqJ5MEOjpCnrEkQIU
	4XA6NJj3TRMeG9fqmlnZ0BjTiOfMTM4tTMwqb+kL/BJTDsQcFQGw8XfYjLtw79fw8IFMIX
	iSYNKSIgNdp1UqoCHt5O3slcGJGvnGI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-z3wi85X2M7ma7vS43NuPPQ-1; Wed, 02 Oct 2024 04:35:59 -0400
X-MC-Unique: z3wi85X2M7ma7vS43NuPPQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c80d23d501so734541a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 01:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858157; x=1728462957;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0mOeG6DrEcLzm/NhKgCIaXI+fTzk5B5rgZ8qzhrCw4=;
        b=Cj4s/Hpm2YieQIVyfTY1pVsMvVTjrNLHFZzMYgBVvUrMHppTIe4EiueYzcyvYMJ/k7
         29H14U5wRxfYcHOnZwNiVDqjV1vagXA5SrJGfm0w3f8ItZdTu5d/AmWviPR3gYRDjsSN
         kRmr2rK04cdTksp7baVIixkprNDfTQjtN6nX+m150Q1uDHR6nKPaIJNU5krPdV09nWG3
         O9nbscluszbBDJPtZmOW0eryQa8qvAbpqdfEcHZu/23Xi86LhzCvF8JZR+CvtV5Y/Wke
         qXx5ONxHBl7D5iyyawDDezA2iF0u7XJfcyGI9gzliEczpN6AXSJP1VRwBsK7Lherjh45
         tQpg==
X-Forwarded-Encrypted: i=1; AJvYcCVGcCbw9QFH1wMU+mUI+UjRjuEynsLsgj+V8/Cgig1Zb1QLjNFuRGzek7BPyYc/Dy5vPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuE8rYDvcit3lgb9ZxnyrVnO2pIr0R2zqbAWPbY7mThpY0jtM
	tKukYu66+PK9H8bLZ7DBUtRzXn0oTc0PKYKglZR+gaFsvfWppfMKzFu93m767L4keu7cmf7jgfJ
	YobeWPqgmqjUvAkGKML0LZMRPhbtwcqnxeXNJ2XdMxTSKqHASGw==
X-Received: by 2002:a05:6402:5191:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c8a29f7c88mr5800962a12.2.1727858157431;
        Wed, 02 Oct 2024 01:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe9afha6qgSKtgnEwfoZIrqaGl4NvYrwm0BQ8Yeh1sL2Q9OmJ7WOhS8LXAKyAkwfZGwz/sjg==
X-Received: by 2002:a05:6402:5191:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c8a29f7c88mr5800928a12.2.1727858156917;
        Wed, 02 Oct 2024 01:35:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882495491sm7278037a12.87.2024.10.02.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:35:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2FFE2158026D; Wed, 02 Oct 2024 10:35:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Jesper Dangaard
 Brouer <brouer@redhat.com>
Cc: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Make sure internal and UAPI bpf_redirect
 flags don't overlap
In-Reply-To: <4e04ef28-6c82-4624-ba40-c6072f8875a5@iogearbox.net>
References: <20240920125625.59465-1-toke@redhat.com>
 <4e04ef28-6c82-4624-ba40-c6072f8875a5@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Oct 2024 10:35:55 +0200
Message-ID: <87r08yq4us.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 9/20/24 2:56 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The bpf_redirect_info is shared between the SKB and XDP redirect paths,
>> and the two paths use the same numeric flag values in the ri->flags
>> field (specifically, BPF_F_BROADCAST =3D=3D BPF_F_NEXTHOP). This means t=
hat
>> if skb bpf_redirect_neigh() is used with a non-NULL params argument and,
>> subsequently, an XDP redirect is performed using the same
>> bpf_redirect_info struct, the XDP path will get confused and end up
>> crashing, which syzbot managed to trigger.
>>
>> With the stack-allocated bpf_redirect_info, the structure is no longer
>> shared between the SKB and XDP paths, so the crash doesn't happen
>> anymore. However, different code paths using identically-numbered flag
>> values in the same struct field still seems like a bit of a mess, so
>> this patch cleans that up by moving the flag definitions together and
>> redefining the three flags in BPF_F_REDIRECT_INTERNAL to not overlap
>> with the flags used for XDP. It also adds a BUILD_BUG_ON() check to make
>> sure the overlap is not re-introduced by mistake.
>>
>> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast suppor=
t")
>> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Dcca39e6e84a367a7e6f6
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>   include/uapi/linux/bpf.h | 14 ++++++--------
>>   net/core/filter.c        |  8 +++++---
>>   2 files changed, 11 insertions(+), 11 deletions(-)
> Lgtm, applied, thanks! I also added a tools header sync.I took this into=
=20
> bpf tree, so that stable can pick it up.

Great! Thanks for the fixups :)

-Toke


