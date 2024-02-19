Return-Path: <bpf+bounces-22249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0685A2C0
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BF71C23241
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0562D05D;
	Mon, 19 Feb 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftin1CVU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9431A7E
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344072; cv=none; b=h/04IXeVspAPXy//tnTWEMqtkPwKYtVSBnJmKGCD92cEVSVgQ0583uqYeJiRytbJ3YHN8cEK+F9YqoUtc0UdRLo6LXoHCU1vF3Mo+Ztkn/EBzSOdZHhV4SeHK3HDembCtrpKQi8zwJGHBmiGs4Kuq8z8TztQYR60ZomE4A+o8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344072; c=relaxed/simple;
	bh=jcPUZ4TxQOpR2NzD4n7Rws/E8Tg5Yfzs7nzAjerdB2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8vreZzF5Jbej5Fc9hBhoVyNCkXtbMjBVl4TgfpbTtz4rSfzrW+Btrr/gcQI6dl7BQ+zMngH0oJ4f7V0P32UKC9as/bMcTKCtkavFKSTIRmPkfh1P8U0Q7CvM98V7HO6qkBxRXE+ThlCyW3maE1s+9ZDv/DYWEeGDGuoi2fORYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftin1CVU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso98154366b.0
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 04:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708344069; x=1708948869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qt3Ss/M1/Wwx/wa66H+LxwiQNuNz2NWDDnsc241y+Pk=;
        b=ftin1CVUbkgb7HVmLTQXrAVLUlvb0N2Yz6WQSwQpF/uPuVBV98Hqy6mCKRKaYUy6mu
         lrO0uWqmhkBE1nv0+fjIm4Qpw3zC3BW31YuEp06GwpyQjMQQxNwDinKeamNQObamliwN
         xk9liTDhSY4u2wg7UnqUoZ3d8JwZyQ80q4MmLgvNZnqH7oNG7XL/1SJPGDRcJnGy4slr
         F/6YY2b77iyUD6LAsICsxaKMZqJspcMVmgYEXfk5DvIz7M0CYLoB1awmSkjCxvbFJHiy
         SIh2kanzJIk2OwA2c+cehokn8OoKGamu1YlvH7rg/IDdkFwPPKkSWyHXf120rgxIH21L
         MMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344069; x=1708948869;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt3Ss/M1/Wwx/wa66H+LxwiQNuNz2NWDDnsc241y+Pk=;
        b=Bj4t3abmv5GAZ9CXKqDFclHm8pcjQXnQBlowTW+IiU/DndliF/e+VSHqOTCcgSQ1VJ
         bgLu8ZXkpbDfVIBOy9mi/EjvNO3G//+tqgrAZF5+/KE4bHB8oPyITew4lflme8GsizNp
         hkOPbMct3pQxUYtBCkkCkqJC1HqLM1vTTOLHE+cWp1kkKoABEAH+dDy/9G79TMg9D5MP
         /VC4WpMMbfzgwZ/SEwu3NFbIOxACmyB7ZEN63Ffv7J5Ppa7a4YqIDYwYWYCacVU2LWpE
         srXNIyPQEgW+XFdPtdqYJ07r4sYIbjX5EXXyXG5a7qZ0lSJaXyuzOphj4RZSpi4TcC7Q
         4PXg==
X-Gm-Message-State: AOJu0Yz609dvd268IMHf61LXfjuwMnVmpmRMIJ6k8cZ8npZX1E5nv/YI
	PtK2JDSuy0WmmfQKkc28eMXEkXmMRvH2qv9Lh397KLD5dhpEPiIn
X-Google-Smtp-Source: AGHT+IG7s0r9rpkiptsknX3h8cR9P9wvlq+OlD9qAH3jASEpaFDYANqGNtgbvmhmROeG19CL1nkVyQ==
X-Received: by 2002:a17:906:1312:b0:a3e:9e4d:dafb with SMTP id w18-20020a170906131200b00a3e9e4ddafbmr1279524ejb.29.1708344068666;
        Mon, 19 Feb 2024 04:01:08 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907890600b00a3e1b4575dfsm2539935ejc.2.2024.02.19.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:01:08 -0800 (PST)
Message-ID: <f7896b196d3b6a10c2e834e6e66caa087e94d27c.camel@gmail.com>
Subject: Re: [RFC PATCH v1 10/14] bpf, x86: Implement runtime resource
 cleanup for exceptions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet
 <void@manifault.com>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>,
 Dan Williams <djwillia@vt.edu>,  Rishabh Iyer <rishabh.iyer@epfl.ch>,
 Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Mon, 19 Feb 2024 14:01:06 +0200
In-Reply-To: <CAP01T76w4vUpsMrvfk1UfDp4yA6ND-Jbw0UZYXLynF8351OJaQ@mail.gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-11-memxor@gmail.com>
	 <4c3b58902d28550551c61a2a001d3ec54beac65d.camel@gmail.com>
	 <CAP01T76w4vUpsMrvfk1UfDp4yA6ND-Jbw0UZYXLynF8351OJaQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 23:28 +0100, Kumar Kartikeya Dwivedi wrote:
[...]

> > Question:
> > Maybe I missed something in frame descriptor construction process,
> > but it appears like there is nothing guarding against double cleanup.
> > E.g. consider a program like below:
> >=20
> >    r6 =3D ... PTR_TO_SOCKET ...
> >    r7 =3D r6
> >    *(u64 *)(r10 - 16) =3D r6
> >    call bpf_throw()
> >=20
> > Would bpf_cleanup_resource_reg() be called for all r6, r7 and fp[-16],
> > thus executing destructor for the same object multiple times?
>=20
> Good observation. My idea was to rely on release_reference so that
> duplicate resources get erased from verifier state in such a way that
> we don't go over the same ref_obj_id twice. IIUC, we start from the
> current frame, and since bpf_for_each_reg_in_vstate iterates over all
> frames, every register/stack slot sharing the ref_obj_id is destroyed,
> so we wouldn't encounter the same resource again, hence the frame
> descriptor should at most have one entry per resource. We iterate over
> the stack frame first since the location of registers holding
> resources is relatively stable and increases chances of merging across
> different paths.

Oh, right, thank you for explaining.
At first I thought that release_reference is only for verifier to keep
track if there are some resources that bpf_throw() can't cleanup at
the moment.

