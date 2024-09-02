Return-Path: <bpf+bounces-38702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C9996847E
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B03B24826
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB10D13E02B;
	Mon,  2 Sep 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGipgYWx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4B2C6AF
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272419; cv=none; b=SkDWdwvvMTfbvACEb+ySQi0iMrIxbpA2TXqDke2bXLCUkdCnFQKaE4ZG2C5GtulEwwbsQ+QgQCy0iR1pfXmlUyqyRJFD+3j1Bri2v4y0OfEua6aRarzErpS9n5CMTy0hGdlfTQryKEg8g8K+eXix1knrJS7O3x9tXfRa0EG3Afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272419; c=relaxed/simple;
	bh=H2J4laZsPY5wIhagz1aJtOzexyE2e2vIbN5n45Edse8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h6lCSHuHP0sLaLoczQHbcV7Oi7WpsXgknrfozpWyA7UT4IwK8rr5TV4B5+1uBkiLGWr5nYd4H51BwaHr+9zBsYnCHQC6g1XczuNvtpZhl/n8nTscwA6KC2tFi7mr+bJIJB/ZrMA4D9cgXXG6TT9LuDr5g/T4XHU6/GW73XO26O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGipgYWx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725272416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2J4laZsPY5wIhagz1aJtOzexyE2e2vIbN5n45Edse8=;
	b=ZGipgYWxdUwDORwIXKBeHeWDYn36y/TixldVN3XPCASMcJSB3cYjURhXK7LiAN5LS1jX7E
	qL9XbjWGAPSWu4X4OMrjcVvgakRz/3Lv6Xg7jmTgVwqqomGWHL9ykSuStGx302z5M2FA+f
	rNQacFYAF/lNyzLCI9+5Xh4NsW0Jr+Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-dvWGASy0PtSPNBpx6rEujQ-1; Mon, 02 Sep 2024 06:20:15 -0400
X-MC-Unique: dvWGASy0PtSPNBpx6rEujQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f515891a64so38100101fa.2
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 03:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272414; x=1725877214;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2J4laZsPY5wIhagz1aJtOzexyE2e2vIbN5n45Edse8=;
        b=cxR5tWFi/+WZCmvglAwdILO0PAK5GyhJU/PhKs44PRgRID2F8fDQtTjt59Yh6VV8kD
         cgWOThXvWWt9m+vHrrfcqTn9TvFcerFXBFG7TAS7XsmriyCtJlyyuf03gA2D0J8k6tqS
         sIMEaiaUQFYXjTpUYU9PrpaHpPV88SO0mfb749JHciAlOj5jE7xKELPHi4b5rnpEC/8Q
         VhZBkc6bhCAPtHOsaC4u6beRmrz/jCaazjEv8vEn7ANoO6TWhMZ6KJ68pJaygTWoyc++
         rlhNJPKrhCrkiS7IgzZcp6vGMZaDiaVFQvONMx3NP/dttoVWiUVSFUlqxJR39nx8DZBw
         +Kmw==
X-Forwarded-Encrypted: i=1; AJvYcCXTWahGFCPPZ0T1At9q65cJJoGGzyJBZQ2hgdb7dJ3P5hBQvy7qRG7lSUEs7yGqfBqjoW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUEG/xi+tdG69nEMqcBRRo65spmEVFV2I8ZVY+r0xjng4JK89
	jOtFWrs7wFhc01mHsk+dDlJQs69ZEHc0jpJGaiQdAuRza1mJDl0ttF+GslDNHvkOsY288eBFo+M
	xnFm/pmwxHZhC2srGPYs0jtBLbWJGYMgCVHK8WMSxZguPBDfR+A==
X-Received: by 2002:a05:651c:4ca:b0:2f1:6821:d163 with SMTP id 38308e7fff4ca-2f636a2a9ebmr23571701fa.21.1725272413948;
        Mon, 02 Sep 2024 03:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqfJc6R94ky2mfJXu7nOLjibeZP8AoRx0EMlwMWgMSJEelammMyWwJM7n+Z640jomy1GQmnA==
X-Received: by 2002:a05:651c:4ca:b0:2f1:6821:d163 with SMTP id 38308e7fff4ca-2f636a2a9ebmr23571421fa.21.1725272413338;
        Mon, 02 Sep 2024 03:20:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226cd2d6dsm5057386a12.68.2024.09.02.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:20:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 12AB514AE421; Mon, 02 Sep 2024 12:19:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon Hwang
 <leon.hwang@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Puranjay
 Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop
 caused by freplace
In-Reply-To: <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-2-leon.hwang@linux.dev>
 <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
 <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev>
 <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 02 Sep 2024 12:19:55 +0200
Message-ID: <87mskquzlg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Aug 27, 2024 at 5:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> > I wonder if disallowing to freplace programs when
>> > replacement.tail_call_reachable !=3D replaced.tail_call_reachable
>> > would be a better option?
>> >
>>
>> This idea is wonderful.
>>
>> We can disallow attaching tail_call_reachable freplace prog to
>> not-tail_call_reachable bpf prog. So, the following 3 cases are allowed.
>>
>> 1. attach tail_call_reachable freplace prog to tail_call_reachable bpf p=
rog.
>> 2. attach not-tail_call_reachable freplace prog to tail_call_reachable
>> bpf prog.
>> 3. attach not-tail_call_reachable freplace prog to
>> not-tail_call_reachable bpf prog.
>
> I think it's fine to disable freplace and tail_call combination
> altogether.

In the libxdp dispatcher we rely on the fact that an freplace program is
equivalent to a directly attached XDP program. And we've definitely seen
people using tail calls along with the libxdp dispatcher (e.g.,
https://github.com/xdp-project/xdp-tools/issues/377), so I don't think
it's a good idea to disable it entirely.

I think restricting the combinations should be fine, though - the libxdp
dispatcher will not end up in a tail call map unless someone is going
out of their way to do weird things :)

-Toke


