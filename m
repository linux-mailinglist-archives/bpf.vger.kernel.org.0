Return-Path: <bpf+bounces-44434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BF9C2F6F
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B261F21AC5
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C3019F42D;
	Sat,  9 Nov 2024 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKKnwUM2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9C13D502
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731182834; cv=none; b=c5AZ5lOmJDue/DoPY3QVSi9s/a2kuiMBTiYrA/ws1/7J4j1nNPrZEUH36ePA7Nr+73LnyXCW54QmpO5EJAVtNuKSluWRp0grnoLt3sfxlsPDY5P/PJ42kfxXGGZkQOQBmPhw8Vd0vPQ6yxikRJhNIHlMj1skFZb8KsnQg63+F8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731182834; c=relaxed/simple;
	bh=Wey3Izot175JmC/t8HYgVV+V84ihr+JapoWBUSnIY/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8Z30G1ebcpVI4h0uKGvoAde+Bzp3+jV7KXnFLV9NFz2CaKfGqHdB6Q6OT1kt+9aGIlRwNZZ6nndce72lOaiHQGD5msmWftqoTCBiOx1vBoKfexJWDbhyO0F0obAL0xqmyjuA66qw8aq9jhqA8/aba6/y9JeMeTEXiqGJAPjUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKKnwUM2; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a99cc265e0aso504727166b.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 12:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731182831; x=1731787631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BToEawLEBzh2YLR/zt4bmHvtLEjLTMkDmmzVsBBUhnI=;
        b=fKKnwUM2YHJMMyv9Jm2xNk/EYlYBVFY0nYx9FUTbWaABHL1nYmKS8kOesrnid8KymW
         JYr2/6Fe+y/8K3sechc0AI8BOqYmbfTzZF993q7OLGuUfq3JrzD19+krearfXNRxoM84
         9gzNg/hV/hrW7QED+4rnnGuaGj86iediXpJNT53ZOX0gdRkvEgpqd0dcjjufCGfzXIgs
         xgBKggpoPOCls/8CzF00I5GW0nItk7r0w3Eh+N0U2kKbu3n+8bQnc+UWmxgsl+0IsgPQ
         6j5bLuyNCSsuU8lgiFQuNSijKyqbPSdADU4T74/XET1Ya4VedCY5uDTuCb9zeftFclvG
         xuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731182831; x=1731787631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BToEawLEBzh2YLR/zt4bmHvtLEjLTMkDmmzVsBBUhnI=;
        b=NTtF07gkajcorfbsqy41X4TmNEU2GIi6a8I4pCI7TKJngiqoWUJJwP8MLKm2mNAobn
         8XbbjaySChd0sofY1uBaSQtF1Bj7JMt9AxK1hTJiUb5++EAeK8siBc7nxQ3PK2RNiMpo
         Wm53lTQ/KNMMyERK/oD04CAvuNOGxCB4HGU1AxFFsK/jrxUvWJTqCSuBNEovTZ0sDU1i
         r7cZ2Ac9maYDXTpUe78oAm2L3XtFisoqbrwm6iN6jwSKBWnG4kwyPalTRd7+dYPsb2M7
         5CBKEdHhGqLNu/Wb/qS31SXG7EQhBiMUriHnc4jvxW1WnWdaDJFGgh9NOBClLmRblctU
         Gjuw==
X-Forwarded-Encrypted: i=1; AJvYcCWCOeNjszI4vHMMWl1fZ/9bV74RfjHcVas2zaWJWayTWGS8vfbw3F4jDHFhU50EV4j2q64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKf0KFG8elMq1q6fiUSZ6BdiHbHO7hetgJeegAGejkkvBJ3i5
	FxbbLNQCLaWnZpJIcoenfGoSGtGXyIjmPTFLDgQgA//GWRP556Hf77L3qiH/jeJEnB0h5yLqDU7
	5LhAcxGHu+F8tq6SoyWnKH8rH0Ys=
X-Google-Smtp-Source: AGHT+IFZgQJFtUoiWzzFjWaQimxTT0vQ3uRAbJIhyWoziSKFN66LbcKQO92wwH6ZytaJDxB22Sl8U7igqiNE2McVHVE=
X-Received: by 2002:a17:907:3e8d:b0:a9a:b70:2a92 with SMTP id
 a640c23a62f3a-a9eeff0da7dmr744544866b.16.1731182830783; Sat, 09 Nov 2024
 12:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107115231.75200-1-vmalik@redhat.com> <940bc790-62ea-44c6-bd7c-e8bb1f747678@linux.alibaba.com>
In-Reply-To: <940bc790-62ea-44c6-bd7c-e8bb1f747678@linux.alibaba.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 9 Nov 2024 21:06:34 +0100
Message-ID: <CAP01T75BUcPJ22fgGRPSEXzgBbzjy6EPehBxUVYRY-5vMt=eqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip the timer_lockup test for
 single-CPU nodes
To: Philo Lu <lulie@linux.alibaba.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 05:41, Philo Lu <lulie@linux.alibaba.com> wrote:
>
>
>
> On 2024/11/7 19:52, Viktor Malik wrote:
> > The timer_lockup test needs 2 CPUs to work, on single-CPU nodes it fails
> > to set thread affinity to CPU 1 since it doesn't exist:
> >
> >      # ./test_progs -t test_lockup
>
> nit: s/test_lockup/timer_lockup
>
> >      test_timer_lockup:PASS:timer_lockup__open_and_load 0 nsec
> >      test_timer_lockup:PASS:pthread_create thread1 0 nsec
> >      test_timer_lockup:PASS:pthread_create thread2 0 nsec
> >      timer_lockup_thread:PASS:cpu affinity 0 nsec
> >      timer_lockup_thread:FAIL:cpu affinity unexpected error: 22 (errno 0)
> >      test_timer_lockup:PASS: 0 nsec
> >      #406     timer_lockup:FAIL
> >
> > Skip the test if only 1 CPU is available.
> >
> > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > Fixes: 50bd5a0c658d1 ("selftests/bpf: Add timer lockup selftest")
> > ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
>

