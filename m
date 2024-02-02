Return-Path: <bpf+bounces-21101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF556847C23
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E43528B566
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F459839F9;
	Fri,  2 Feb 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idycecY1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FF8175D
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912347; cv=none; b=a60EqNWlQ3Uz12Ont6q8MmYH4fa8DB6n9vDqXT3o1FMut5DFvx/AgKtN5FDsw8MY0GTdlPtTbX38z3HWCxo1xaelM+vS1ykBI5bMNE5UjidKX1WcuDL9iyFa5COtvsFgFGxJWmyXC6LpyXD+lDyAW7tsopv8f7uj67PVr7pS0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912347; c=relaxed/simple;
	bh=kftixdxexulYCk07LfGbm5dX3kpffYVLK6nqNGmgSOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/qSmPhoVlZUp2HRm6WaBv+NQZIwd2OUsnc30OMq1qJ0dlcUrPXeVRVUf6ZfLPBOWtY8MAtOe7JEA3leBhh5DMFEpKOWxsTFd+8S5Xa5ldvYUy+VlL0l0w/qY3fxF4QRuTelLoE/rJHlLAN2C7BwtReFEM673kHs9I2YFVwNUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idycecY1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2963cc5e8acso946309a91.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706912345; x=1707517145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mArRLx7fRpyYkNyCAVt8FKRyJLW5hjYw8TAdHphUVSE=;
        b=idycecY1IPaYx6RNcq1fTt/3P/y6efaZ85//y9vuQGik67eN3v47y+ThnWHiy9Togc
         WnSwGEm5NBO9ubaQc9yssIeRz7yQrO7t1VYeNpNaeSlypr6G5Dvm8H2+L8q+MjZ7xLr0
         Qm4+mTV/3DiccdyBPLax5H5pn14Di90/3aFeVS9CaFuHswpLsT8n8OOQZCEazTPYC6AY
         GR2/cw8yvlcSH52fVvFmr6YV5oj0slqonZbiWi1nfKKnd1McWk0zPyQNFUlQhtRzPqC4
         lAa0OfdknuiM7H+H+2aIwK0NN3mAOiBPcU0+I/CR8+GAD1gIDbnVc0r7QvdWMFiukeH4
         87cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912345; x=1707517145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mArRLx7fRpyYkNyCAVt8FKRyJLW5hjYw8TAdHphUVSE=;
        b=pC1YweUePmx9V58xP9cUvMMj5IPkbUoGKVrDk5kTHl40+J8s1WLGF9/jk3eqojSqYe
         bP7M0EczZO7i9kb5cP5JsAwZ1zYNjq0FMS3XognTSRNp8o5dmduNC8dJWKL+ehvrUaHA
         hcMDbwF4pw51Fp1ALOm7s+zSJNiwjIVYEaD6Suyvmz/m/Kwob17EbueMaj4I5eStGphP
         fsYVjBxuvxAKdys/7dHGaDKwXQZU+RxwWzRDXmAABYrOxPY6pw5kY7hC82QRsL9DzgmS
         7HrfjOBfESKMS0LnCu7D1NCJMB6YO5xufKXlBVx7orC9LIYKPcDk4Y2LnKMTDTc0uLwG
         +nRA==
X-Gm-Message-State: AOJu0Yx6ZzdtjeKsaq27u+sR2HFwLY2GKMYcT5TFS7fMdjOxYZnTq+5Z
	9WAzdg2cD7MuArLO6+KVq7e2pKpNeoAG02eeeTikpblF/hR0tSskeKEMI1eT+np5pQwAONx32mn
	+a3OesxHZCSmMroP4pLuWk5opK3o=
X-Google-Smtp-Source: AGHT+IHqVKMkqcqE8lJVGti8U3qYvyw5y8HgyH4jN1KclBknRqBLSUY/wzaLZsbaBoW8P4JJMViVnphkWYQgvMb91fY=
X-Received: by 2002:a17:90b:911:b0:296:286c:4dd6 with SMTP id
 bo17-20020a17090b091100b00296286c4dd6mr3604333pjb.46.1706912345553; Fri, 02
 Feb 2024 14:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131155607.51157-1-hffilwlqm@gmail.com>
In-Reply-To: <20240131155607.51157-1-hffilwlqm@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:18:53 -0800
Message-ID: <CAEf4BzYsYHi1s_7PZ5QknUg+Oe9drN0OSXbxT06WDB57o0Ju9w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: Add generic kfunc bpf_ffs64()
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:56=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
> This patchset introduces a new generic kfunc bpf_ffs64(). This kfunc
> allows bpf to reuse kernel's __ffs64() function to improve ffs
> performance in bpf.
>

The downside of using kfunc for this is that the compiler will assume
that R1-R5 have to be spilled/filled, because that's function call
convention in BPF.

If this was an instruction, though, it would be much more efficient
and would avoid this problem. But I see how something like ffs64 is
useful. I think it would be good to also have popcnt instruction and a
few other fast bit manipulation operations as well.

Perhaps we should think about another BPF ISA extension to add fast
bit manipulation instructions?

> In patch "bpf: Add generic kfunc bpf_ffs64()", there is some data to
> confirm that this kfunc is able to save around 10ns for every time on
> "Intel(R) Xeon(R) Silver 4116 CPU @ 2.10GHz" CPU server, by comparing
> with bpf-implemented __ffs64().
>
> However, it will be better when convert this kfunc to "rep bsf" in
> JIT on x86, which is able to avoid a call. But, I haven't figure out the
> way.
>
> Leon Hwang (2):
>   bpf: Add generic kfunc bpf_ffs64()
>   selftests/bpf: Add testcases for generic kfunc bpf_ffs64()
>
>  kernel/bpf/helpers.c                          |  7 +++
>  .../testing/selftests/bpf/prog_tests/bitops.c | 54 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bitops.c    | 21 ++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bitops.c
>
>
> base-commit: c5809f0c308111adbcdbf95462a72fa79eb267d1
> --
> 2.42.1
>

