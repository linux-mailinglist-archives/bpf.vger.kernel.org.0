Return-Path: <bpf+bounces-16454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3298013DA
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC98281D49
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DDE52F8C;
	Fri,  1 Dec 2023 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmBFQjGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA46FA
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 12:02:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c4f95e27fso1418234a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701460939; x=1702065739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7r2ts1xnds0RpXfxcUnT0eohKacvvikP/pi/3JLyulw=;
        b=JmBFQjGvvIYvSGJAMk5v5Pph2d+AH3JYdDhADAEinF7PGLAFPEatWT1ZBbw44kC7pL
         8mFcEP/niKPNBIK45qYKzTD6WWXnb0TMkC7DlwrWbSa/fPetLXZ/9hJ3eETrYn33pN3Y
         RnBBKJTyWUUBYILMl/NzrpyAGRtYfz6zv2Ua8gsa3VmXb5jTE67zk89zPbx+4Ql287j1
         rCITNqlKCAeqXc+EihtE3vlK7qxcs1HvkgfGdGTb2zHsQ4CxBJSfQNk/J4zijvy7Sfx3
         GTbo697mQDNxH0nxoALXrf6dprNm++O9xM395btpxMqWUwQ/Bq1aXQ4rY6hogy0RJY2k
         gpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460939; x=1702065739;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7r2ts1xnds0RpXfxcUnT0eohKacvvikP/pi/3JLyulw=;
        b=E4x+BNxp8gTuGlxyQquc1E1wUQBlr+V3vlg4hUjWqTtffeQYyuta/WX2crqY7nQHFR
         fNXhDILZAxlWlVv7iNivLKxew3FLnjften2wSWgf0JlA8OFDd5epvTvVHcdSCe9iMYFh
         U5Rj0r/0SvFREB1wOiBZMdcN9iSCa4vLivD9nYSWRXKirj/YXKyT2EtjGeptc6V8risi
         0WWF3fBgAZ815kqtPKAwxHdKTGrII6OOjrv4hkqSOQMkKsXPaSYpQHINDYPW5E9/LrOZ
         SeF4F4atfVVPnityVHuG/iT4MKkfnbGFk0MTQdjEl0GDZvEeNeTnFJhFusSxhG2gyWaD
         uP6A==
X-Gm-Message-State: AOJu0Yws/fxwfLisIYVwz0WzkgNb4Hlijj91bv9+LSQwOSn7XZn6GcGv
	JenYV48e6zSKqqG09Czv4Lv62ONjopJeyA==
X-Google-Smtp-Source: AGHT+IGpxjasJG1qZLfCYJ+b9qxkA4/UrvHAnhDli4sF32jZ7ad+NUCTGv3XDqq55NgSWpgnwHWSsA==
X-Received: by 2002:a17:906:191:b0:9b2:d554:da0e with SMTP id 17-20020a170906019100b009b2d554da0emr2468767ejb.69.1701460938549;
        Fri, 01 Dec 2023 12:02:18 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jg41-20020a170907972900b00a046a773175sm2240247ejc.122.2023.12.01.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:02:17 -0800 (PST)
Message-ID: <9f5877a0a1e8b7949813411aacb46e16ce33f630.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Fri, 01 Dec 2023 22:02:16 +0200
In-Reply-To: <CAEf4BzacfRnmmYV+_qKhFX0Ydw7zmsJjm_YxVNHDWxF6E9Pd-Q@mail.gmail.com>
References: <20231201013006.910349-1-andrii@kernel.org>
	 <68fc1915f6d0fec5d4503052dfabe0f0f9fb6d91.camel@gmail.com>
	 <CAEf4BzYgdX4m15fV9Xujk8RRDbwNH5zWuV6Wb+k2+NXigJ5nNA@mail.gmail.com>
	 <583eb34882904c94f74a737650c20ac2d2fe18fa.camel@gmail.com>
	 <CAEf4BzacfRnmmYV+_qKhFX0Ydw7zmsJjm_YxVNHDWxF6E9Pd-Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 11:26 -0800, Andrii Nakryiko wrote:
> > [...]
> > > > Nit: the log is not printed if verbose tests execution is requested=
.
> > >=20
> > > I'm not sure I understand. What do you expect to happen that's not
> > > happening in verbose mode?
> >=20
> > I tried running this test -vvv and it did not print verification log
> > (admittedly this is the case with many tests in prog_tests/*.c).
>=20
> I think that's the test_loader.c feature, plus maybe some other tests
> support this. This is not expected to magically work for all tests.
> But also in this case we explicitly intercept the log, so it would be
> too much trouble to both intercept and print it at the same time, IMO.
> But if this assertion fails, we'll see the log, which is the most
> important part. Also one can use veristat to get the log.

Well, yes, that was the point of my rumbling.
When it's necessary to debug some such test one needs to modify it to
use *_opts() load variant etc. Veristat makes sense, however, so not
an issue.

> > > > Nit/question:
> > > >   Why change prototype from (void) to (int) here and elsewhere?
> > > >   Does not seem necessary for test logic.
> > >=20
> > > I had some troubles attaching freplace initially, but my freplace
> > > skills were rusty :) I can try undoing this and leaving it as is.
> >=20
> > No strong opinion, just curious.
>=20
> I undid it, it all works now. As I said, I had freplace troubles and
> was poking around with different aspects.

Thank you.

