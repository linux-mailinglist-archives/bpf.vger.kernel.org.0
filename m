Return-Path: <bpf+bounces-26112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E36589AF71
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BF11C21375
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B910A22;
	Sun,  7 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HqVcuMZ5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A01879
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477409; cv=none; b=pmTLWjrIMg8Xy0usPWZitPHyYz+QTsFWMqf+Zt0Cd77Wzqjq/ULb3EyGzM5ha0+6qNvB16zJHLoXI72uQEgRmAYBOT0blV6C8TBkbPWEwznNfeMAbCjoxTpZ3Xf/v7WR9mcis5fky0hz6j4baVpS3QQeYKKPNTrscYy6alTPsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477409; c=relaxed/simple;
	bh=VBnMmaY/jSdSTkC4TB/mxJq/6u5SVhMScG2xHkwOpHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoHJuLHn6UeBz1OlGLIVP1HzoAkO7sZcesANptSR158gIp7RaFsnAdn17+ZQLnZ+UUlOQW8MZGuKjYQkqgEtxlUq9sAbNIl35zNZmNjQYBKu2cc4WgJHMRAOErdkwnFmPV6jvikw/4VTCRJ1O9tHUwKkaUPeKviTWl7lh5f7VQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HqVcuMZ5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D3FEF3FB79
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712477398;
	bh=MRAOR6NXs+WDh7P3Pk4nsf9IHt46kV2t0C6KeL8Xd0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=HqVcuMZ5uuB65vHwZavVByWoTKVIEdwiiA8QwkgBCkE2j4Vu62CuBTu4Yo5ucygeb
	 o0O8zExLUUwD7ZcgVJzSjGHEWVK3Qhkukey/OcKUtLMXrnuTVzhlpxsKMNBid7mdbz
	 9BB0jx4ZmfwCzBIqxARAIVmLpkWzEZHTb2SLK+zOoPg0VIlwn9f7zYnHzplZY33jDr
	 EW1P90teBBTQ2l2BHa4U+LHHgAFT6BAO1QdZHaj33iXPIeGoqHPXi0pIlInaVMH/U8
	 zepJ6kYGoGJ1EslMeKnHY4pzVE53YKaRwQglomQcN9pdy7frUcacRiRlnO7Zr3OxIA
	 v2fBXkwiz7xow==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343da0a889dso1826747f8f.0
        for <bpf@vger.kernel.org>; Sun, 07 Apr 2024 01:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477396; x=1713082196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRAOR6NXs+WDh7P3Pk4nsf9IHt46kV2t0C6KeL8Xd0c=;
        b=OiLtikEVvwEIMNCq35I5ly1tPIHNmFxoc5poQipW/2tULoXrveE/ZNdAZwjQJAE0CO
         KsfCiXf/8EBoflbtR079Ssg0PMQVWl3eY5x1bZBmh38pf2CX2/DWU/y/AFGUG2tgsLww
         8lJXD9f+I39qAv6Rfpa0Xx9l7FkryJ55Vu6IY3OBWv6NedtCxL/MauYaBSIqC+fKQmZE
         dqbwsOxBUypWSrrulkmiAcNxSrfbGIfL2Oq9mgCid9sZuqYQazvWqNbhYjJX+9qvbAlv
         2oyzxckn1PKlEcFvbKLVT9Xdv2ByNprTpibfk9Pu1sjMVpONU5hvHJphQbk6a7fm96dR
         XLOg==
X-Forwarded-Encrypted: i=1; AJvYcCUUR0tiVwjPcn5FWOqsZkL2AKosCTRS5TYjTRu9U3Oc+SqakR6ReMOrAG2Fm6aa01Gzj6HTwkOr87XIym8A2UHLERAE
X-Gm-Message-State: AOJu0YxIIoWZQGNfB+Cx9MzgERHtdrR1F61wQ5hIMlErQOXYYqJ5ohSq
	1VPQRa2xMxIBx7Eh3jzBEgkrJSujfsTAFBMmzg/mShJQmmxpt+vMBCEvgUbadZOXHVnuKUBi+6/
	8y6wvZTeSKcqoPCKwSF9Eo1gQ7lrOxCnNo+Y3pcIZxejVrKybI9GkIfza0fvQXGfDjR2oT4ALUc
	DR
X-Received: by 2002:adf:fed1:0:b0:343:a183:4218 with SMTP id q17-20020adffed1000000b00343a1834218mr4431411wrs.52.1712477394382;
        Sun, 07 Apr 2024 01:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7O+B0XCMESRc4pHeuqRzfZFND+/CmarJwhrJTwar81zScxLL0MtBoOtKhKPuUzsu2gsRPkA==
X-Received: by 2002:adf:fed1:0:b0:343:a183:4218 with SMTP id q17-20020adffed1000000b00343a1834218mr4431370wrs.52.1712477393487;
        Sun, 07 Apr 2024 01:09:53 -0700 (PDT)
Received: from localhost (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id q13-20020a056000136d00b00343e3023fbasm5866411wrz.34.2024.04.07.01.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:09:52 -0700 (PDT)
Date: Sun, 7 Apr 2024 10:09:47 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and
 ring_buffer__consume_n
Message-ID: <ZhJUy6nWFOFi8oT_@gpd>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
 <20240406092005.92399-5-andrea.righi@canonical.com>
 <CAEf4BzanzbBaVgP7Qu8v4jnfsWt+9vJqB6D9G7NjE5QL+3iKXQ@mail.gmail.com>
 <CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com>

On Sat, Apr 06, 2024 at 10:52:10AM -0700, Andrii Nakryiko wrote:
> On Sat, Apr 6, 2024 at 10:39 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Apr 6, 2024 at 2:20 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > Add tests for new API ring__consume_n() and ring_buffer__consume_n().
> > >
> > > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > index 48c5695b7abf..33aba7684ab9 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > @@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
> > >         err = ring_buffer__consume(ringbuf);
> > >         CHECK(err < 0, "rb_consume", "failed: %d\b", err);
> > >
> > > +       /* try to consume up to one item */
> > > +       err = ring_buffer__consume_n(ringbuf, 1);
> > > +       CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
> > > +
> > >         /* also consume using ring__consume to make sure it works the same */
> > >         err = ring__consume(ring);
> > >         ASSERT_GE(err, 0, "ring_consume");
> > >
> > > +       /* try to consume up to one item */
> > > +       err = ring__consume_n(ring, 1);
> > > +       CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err);
> > > +
> >
> > Did you actually run this test? There is ring_buffer__consume() and
> > ring__consume() calls right before your added calls, so consume_n will
> > return zero.
> >
> > I dropped this broken patch. Please send a proper test as a follow up.
> 
> Sorry, technically, it's not broken, it just doesn't test much (CHECK
> conditions confused me, I didn't realize you allow zero initially). We
> will never consume anything and the result will be zero, which isn't
> very meaningful.
> 
> "Interesting" test would set up things so that we have >1 item in
> ringbuf and we consume exactly one at a time, because that's the new
> logic you added.
> 
> I think it will be simpler to add a dedicated and simpler ringbuf test
> for this, where you can specify how many items to submit, and then do
> a bunch of consume/consume_n invocations, checking exact results.
> 
> Plus, please don't add new CHECK() uses, use ASSERT_XXX() ones instead.
> 
> I've applied first three patches because they look correct and it's
> good to setup libbpf 1.5 dev cycle, but please do follow up with a
> better test. Thanks.

Yeah, sorry, I tried to add a minimal test to the existing one, but I
agree that it not very meaningful.

I already have a better dedicated test case for this
(https://github.com/arighi/ebpf-maps/blob/libbpf-consume-n/src/main.c#L118),
I just need to integrate it in the kselftest properly (and maybe
pre-generate more than N records in the ring buffer, so that we can
better test if the limit works as expected).

I'll send another patch to add a proper test case.

Thanks for applying the other patches!
-Andrea

> 
> >
> > >         /* 3 rounds, 2 samples each */
> > >         cnt = atomic_xchg(&sample_cnt, 0);
> > >         CHECK(cnt != 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
> > > --
> > > 2.43.0
> > >

