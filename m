Return-Path: <bpf+bounces-22579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4F8610D3
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD9B8B260C9
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886227AE7C;
	Fri, 23 Feb 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE97SZJr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD57A722
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689182; cv=none; b=urSfAnArsbzK/z0kDh3+BxdG6C7WVBRFuRMpKD/wyPTWpX6MRAGyUBSy4hJVZux+lbmoWJ4W4jXqCtcz9Dx4Ehz6+47m1wrYP+a+nDanpyVDPzfKvGAGh/Xfe8fmbg1JK4hBT41vF9Wr+nq/MRGyqAp6kpFMRdjO6qoblq1RKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689182; c=relaxed/simple;
	bh=768y69AzLCU3jZ9H+ybYN5xjfOcMBhnlv/tyocsNyoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUfgpjsiDreayEUyj4QxbvmFt7NR+WJQCH5bLGELj4icAhOMEKIDhWfEeIPx58XXS/bUbH+LoS5ItemPK2zQAh3E8QlehENuKQkqkuAb1LmCD+Lb/ETBuQIpUIw944NjZ9de3qx0AIlWOhr1lm2NVUnU57h3WZCe5ZAcoS7U7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE97SZJr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5654621d62dso714918a12.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708689178; x=1709293978; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/neqfVROv5KzxkUykjYw3SOXQB/ytTvxft0LAhzTmk=;
        b=FE97SZJrXd70mjwhr0bjIELxs+yElZmKgJtOfECRBjXXIB/Z5MwCwW9KZ/0husqiJF
         14y+AYgjbI/rAc93552e72yynpla0ChntgXKhyLvtUsguNx3ZD5ZIiFU+GeVu6Gw/LRo
         vl/bbbaW9M1GgFqQsm0b4BsrBZg502uAMT2mi/2klYKOG4lrglWZNKRK+8D0Phn1ALr9
         B5YuuZGDYYaKmBXczqR+2OpEHw0737JJVaU7roUBIPe+DLUAZ/RFOoP0oFFJCN7hvV1w
         44HOyLjAO2JIkBO7X69/4/AQxQUibupwRHIaPrM6zP2y6+N7I1FATvurHbZg5v7BTxZB
         r9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708689178; x=1709293978;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/neqfVROv5KzxkUykjYw3SOXQB/ytTvxft0LAhzTmk=;
        b=sfE9cqIZuyzfNPxjmrTu6HsfgdG7+uQsOOl+l/8qswSjXkA12L2PjLPFn7C7cPXgGG
         FYFLPPRP23srV9Omven6uB4H3MueIhYkTWzPwWhUfy+V/3EEMrsRapzSYM6Rym+S/LVN
         sAOVobSiSfuX8WxtlgdiYvC1RyN1N1UaPSjejPNg5USJ+Sr6rCZYMsmynQ22VUsdq67W
         B4MKuK9QgY1gZ54/+oa4onDKDP7PwuRlzvrCFkTP6l1mF5j41dmTikDg+C8dK3DnznBZ
         WahXdyFVxaKt3MxK7jZQfCMuO/YdLfoHa4KHGv6/iWZJh0jsTT6sHes9AjNH9oa9/oS4
         qiWw==
X-Forwarded-Encrypted: i=1; AJvYcCUMyF5W+By+t0EdE+Zn3TMdTEVlG0ZkwDpZI4wKEfFkcn5vWoZVfGDs54iiA9rXSBFG24PMu6gcSucvIiCNOqvMhRHJ
X-Gm-Message-State: AOJu0YxbMEQVFrkh3SGmT9OXjbn8FVXz1TJ4BTexfDjPr7jTuRxB6Wju
	ZiGRqQGTn22OlkdeaaaHeJFuYMJpbDYboZrSxzalnCipjraMkAFx
X-Google-Smtp-Source: AGHT+IHIYuYWAGTR0htEfUtEiX06RU25NVmhUkHYvZa/I8/4fq7gNb0XNucnopmbRJP6n8oSirisVA==
X-Received: by 2002:a17:906:3bd9:b0:a3f:21ca:3a81 with SMTP id v25-20020a1709063bd900b00a3f21ca3a81mr1165258ejf.32.1708689178114;
        Fri, 23 Feb 2024 03:52:58 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s5-20020a1709067b8500b00a3f63b267b0sm1903650ejo.101.2024.02.23.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:52:57 -0800 (PST)
Message-ID: <26ceafc98a4408884e707314d3eb9cbf8c0b6d58.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for bits iter
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Date: Fri, 23 Feb 2024 13:52:56 +0200
In-Reply-To: <CALOAHbCSXrX-igGH0TJTWcKSGg7u6KOfGQrqpwymxf4y1+f2kQ@mail.gmail.com>
References: <20240218114818.13585-1-laoar.shao@gmail.com>
	 <20240218114818.13585-3-laoar.shao@gmail.com>
	 <CAADnVQKYWm0PrkZH05q133FwaD5zrDSuBH1sJ5aXxGrVua2SsQ@mail.gmail.com>
	 <CALOAHbCSXrX-igGH0TJTWcKSGg7u6KOfGQrqpwymxf4y1+f2kQ@mail.gmail.com>
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

On Fri, 2024-02-23 at 10:29 +0800, Yafang Shao wrote:

[...]

> > The patch 1 looks good, but this test fails on s390.
> >=20
> > read_percpu_data:FAIL:nr_cpus unexpected nr_cpus: actual 0 !=3D expecte=
d 2
> > verify_iter_success:FAIL:read_percpu_data unexpected error: -1 (errno 9=
5)
> >=20
> > Please see CI.
> >=20
> > So either add it to DENYLIST.s390x in the same commit or make it work.
> >=20
> > pw-bot: cr
>=20
> The reason for the failure on s390x architecture is currently unclear.
> One plausible explanation is that total_nr_cpus remains 0 when
> executing the following code:
>=20
>     bpf_for_each(bits, cpu, p->cpus_ptr, total_nr_cpus)
>=20
> This is despite setting total_nr_cpus to the value obtained from
> libbpf_num_possible_cpus():
>=20
>     skel->bss->total_nr_cpus =3D libbpf_num_possible_cpus();
>=20
> A potential workaround could involve using a hardcoded number of CPUs,
> such as 8192, instead of relying on total_nr_cpus. This approach might
> mitigate the issue temporarily.=20

I'm sorry, but is it really necessary to deal with total number of
CPUs in a test for bit iterator?
Tbh, cpumask_iter / verify_iter_success seem to be over-complicated.
Would it be possible to reuse test_loader.c's RUN_TESTS for this feature?
It supports __retval(...) annotation, so it should be possible to:
- create a map (even a constant map) with some known data;
- peek a BPF program type that supports BPF_PROG_TEST_RUN syscall command;
- organize test BPF programs so that they create bit iterators for
  this test data and return some expected quantities (e.g. a sum),
  verified by __retval.

This should limit the amount of code on prog_tests/*.c side
to the bare minimum.

