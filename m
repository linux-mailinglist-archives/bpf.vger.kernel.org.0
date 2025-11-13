Return-Path: <bpf+bounces-74356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39697C5645D
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 09:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF033ABC04
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A732F773;
	Thu, 13 Nov 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxUaeeNe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A47DDD2
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022203; cv=none; b=KQKcexaL+zori2dUWujK2T/syuyT3wrVBkgOSW0aCaww4Q7hNfRzlC4SGvoZfZq1Nw2DpJksFbb9dnDInILGx/Q7XULhtdvLCNlhA3se4yrK8FURQS6Z0j5khMtJ0hNzYjTWiCT0/YruSY8nYIxjeKjXfWQIhuTeM5LFxG/HnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022203; c=relaxed/simple;
	bh=K8xFaUM45Rc2eym91RaAXlCY2N2WZaUBd8uJ7LstWEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzeR+vgswmJFmqrO/fae1mOGhboSBdZ+KngZw0Q2kNXOoMsczsvtaX+J9rkWDzmRCU6pyd2ykhDyQG7HR7FhE+J52NpAfaNYJd4sH+xH/8zM+gyEtaV9WLhnGMklbvaeheeIlOWYHqq/KqThJNvBhoqufGHkonyV3gzzItiClbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxUaeeNe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so882152a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 00:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763022200; x=1763627000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTQvzXen4jMzNUuA8MVAmEa0VA06kmSQN8VHIBNXvGI=;
        b=kxUaeeNeExHl3WAd1TvEh91k10qtuvvRJMd8yOG9gzQ9bO2TSl4Ifane5BKippkudj
         oAUaUVWWsRPQgM/NbVb4GtjaadA4P2yiNWcZ644qiBVJisa62Btv0qaizaM2qhR23RfH
         XTZgME6Bhgrd5PR+oWN1JL0blIu+JSqF020RJgtBECVsQmshRf8S0FAnmxemmBf4qZEh
         iVVOhrb2781BplPLE7bF76WXLBt45yqp754yeZRRcPfKMGZrsRAQg0HVgwlVmyEIJRNn
         Hx4E1RqhaJzU1xe7Ygb5sY6iVzIhSpH0LmHjxbctYtw7NrelHWzNdELTr/dXpkZstXnc
         Q96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022200; x=1763627000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTQvzXen4jMzNUuA8MVAmEa0VA06kmSQN8VHIBNXvGI=;
        b=c24Vs0HdQAzfiLXNXy+JzIFAP3SlatQfLfJs9QEpBL8fdiWR0Piu/jEfGjp9cd9oBi
         0z9zbiFvLsngQVe9bi5MJecRCxzf/PX+NniXyhkBrdgHCJHGVzch7xzP1C2aVjuOltH2
         ovDrO/6YNaMLccxM3NPh6fApa2vIWZxPvsq8UW+IGcxKA04HQw4FRUTAxRy2VlQttyn1
         l0Ii5qMwyNPaDss5+tkt946Pw7DXs65nxJ7xX/n48txpEKOoTLVJmqg5Snz13V/YcDTJ
         CFPDv3asNfYqZ+uqS6/ycX3020xrBuCwFNaPF5d5yeV8c+cKc5VCwcmjrrmb3yKfVfNO
         a5Cw==
X-Gm-Message-State: AOJu0Yw/TyVpUc5gLdnLVNynDCTSDsDPlMeB9h002VQ94oF5A0inDpTC
	VPlCX+wR0H3GkdL2B2abO6ytSBNSYXCtBRvv2lBbHe7RvSQaUI8aB/XNpIfSUl4atg==
X-Gm-Gg: ASbGnctIe/uAT1ZMUd6ZWhoR4N8zAY8sq2ticB2+5t0qwPuOp0ScYTvLyt89aXsugh6
	Ssd3wSKe2Fm1gq/MT0fF8KwsO/kgLNoptYlNO2Du+BmfuglkfTwYkVlLhbF5iz4rzVcIU0iBABz
	dZh+arQfQ9UNHm3xKoewvK/5j4mLQYXYRwMW2DUjB20O9IwgSIMAoO442lTKPo2HquaVZiIHkHm
	qxZW1S9T0Pb2hx+bFVklC5TehNKeUQ1KaKXM41XfJXvHjOqi6IHWsZU5ml5Xz+amK7aNjJ0grVD
	vNHHkgbcmRCC6GaNc4t1Q2+ejuVHLPFwEaUFeMjqIFXofKdFpkZUKn1heUMMEjrJloV1J/vxvvb
	UC4hP7MR+LdT52tWQPPvuuSsZEENYQZuA16fT/PtEQzUoVRA6OHqkzsVUPTltIa5aOePFSaPV87
	k2EZcOEEN32Mb8ykWbMk4STWiQn8OHdT49P0pF4zQ6SX+iFYyPGOmFjZz2rzP1jS9HkS0=
X-Google-Smtp-Source: AGHT+IHxLcxl6enluDjUhPJsAplPafUkDZt5tKRVDtuSiNBwI+frJndkXJ8DTdDUqpLWQOcZT2C0Dw==
X-Received: by 2002:a17:907:1c25:b0:b6d:2c75:3c57 with SMTP id a640c23a62f3a-b7331a970demr622477466b.39.1763022200060;
        Thu, 13 Nov 2025 00:23:20 -0800 (PST)
Received: from google.com (166.173.90.34.bc.googleusercontent.com. [34.90.173.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad800dsm116711566b.29.2025.11.13.00.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:23:18 -0800 (PST)
Date: Thu, 13 Nov 2025 08:23:15 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: retry bpf_map_update_elem() when
 E2BIG is returned
Message-ID: <aRWVc1tne5vNffqU@google.com>
References: <20251112083153.3125631-1-mattbobrowski@google.com>
 <CAHzjS_s=+qgkt0RRFqvVORhWBt8jsFS8RDy4Kq1Vwr8fPRzfag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHzjS_s=+qgkt0RRFqvVORhWBt8jsFS8RDy4Kq1Vwr8fPRzfag@mail.gmail.com>

On Wed, Nov 12, 2025 at 05:00:50PM -0800, Song Liu wrote:
> On Wed, Nov 12, 2025 at 12:32 AM Matt Bobrowski
> <mattbobrowski@google.com> wrote:
> >
> > Executing the test_maps binary on platforms with extremely high core
> > counts may cause intermittent assertion failures in
> > test_update_delete() (called via test_map_parallel()). This can occur
> > because bpf_map_update_elem() under some circumstances (specifically
> > in this case while performing bpf_map_update_elem() with BPF_NOEXIST
> > on a BPF_MAP_TYPE_HASH with its map_flags set to BPF_F_NO_PREALLOC)
> > can return an E2BIG error code i.e.
> >
> > error -7 7
> > tools/testing/selftests/bpf/test_maps.c:#: void test_update_delete(unsigned int, void *): Assertion `err == 0' failed.
> > tools/testing/selftests/bpf/test_maps.c:#: void
> > __run_parallel(unsigned int, void (*)(unsigned int, void *), void *): Assertion `status == 0' failed.
> >
> > As it turns out, is_map_full() which is called from alloc_htab_elem()
> > can take on a conservative approach when htab->use_percpu_counter is
> > true (which is the case here because the percpu_counter is used when a
> > BPF_MAP_TYPE_HASH is created with its map_flags set to
> > BPF_F_NO_PREALLOC). This conservative approach approach prioritizes
> 
> s/approach approach/approach
> 
> AFAICT checkpatch.pl also warns double "approach", as well as line exceed
> 75 character above.

ACK. Will respin with nits addressed at some point today.

> > preventing over-allocation and potential issues that could arise from
> > possibly exceeding htab->map.max_entries in highly concurrent
> > environments, even if it means slightly under-utilizing the htab map's
> > capacity.
> >
> > Given that bpf_map_update_elem() from test_update_delete() can return
> > E2BIG, update can_retry() such that it also accounts for the E2BIG
> > error code (specifically only when running with map_flags being set to
> > BPF_F_NO_PREALLOC). The retry loop will allow the global count
> > belonging to the percpu_counter to become synchronized and better
> > reflect the current htab map's capacity.
> >
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> Other than the nitpick above, this looks good to me.
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> 
> > ---
> >  tools/testing/selftests/bpf/test_maps.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> > index 3fae9ce46ca9..ccc5acd55ff9 100644
> > --- a/tools/testing/selftests/bpf/test_maps.c
> > +++ b/tools/testing/selftests/bpf/test_maps.c
> > @@ -1399,7 +1399,8 @@ static void test_map_stress(void)
> >  static bool can_retry(int err)
> >  {
> >         return (err == EAGAIN || err == EBUSY ||
> > -               (err == ENOMEM && map_opts.map_flags == BPF_F_NO_PREALLOC));
> > +               ((err == ENOMEM || err == E2BIG) &&
> > +                map_opts.map_flags == BPF_F_NO_PREALLOC));
> >  }
> >
> >  int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >

