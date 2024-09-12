Return-Path: <bpf+bounces-39681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD431975EE9
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 04:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528A52820EB
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089F2D05D;
	Thu, 12 Sep 2024 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMO+bMWW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75C46BF
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108285; cv=none; b=odODnYtV81/bjQ1LKop/bQTs4Yd9IMV+mNIQGkdMFHvR+QMeTRv0ufEZBLhnI1cBNKyhVMoeUAsSPw9V4QsKggIJDumR1c75YN2LsrKEFFfnbbszy9hoYSomqD8fc3T2pThkHVLqptWjljnCmTJ5HzHr85cMBugIU1x2Wwn+k1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108285; c=relaxed/simple;
	bh=+DapJB+FIdI4j6fQCHDVor5tAs8MUymD3EprXUgphjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbFGwxYzjS1fbs+aNXCOhh+PYsjKbfHSX82iJgs73rJP3vkfYQkLrKweL6XnoSMBEkTGLSA3Q21pIS9nSqgQUWCprYbuDnm5dHyyw35FAyoilcxK5WGp1oOFPj9cjWUblygaojyRXPZkbY68FV1aViR1b31EBD0C83JPtOwwnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMO+bMWW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20696938f86so3945405ad.3
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726108284; x=1726713084; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sSfI5CuJpaAk4DrDoC9RA+0eQSa8ZrUm0YJlq5XuOQE=;
        b=JMO+bMWWaAzEyhBwJXY2b0NfZdzu9gbFjmHc5XYEi9z5ZVRcpqJ7ppwTwKp2CmeIdf
         b6NVzhlIm5/j5sVIQDIxzIxmuvR8N3df0SWm1RWI7hkdaWVgruB1uCM4HRNfcP7w5OhT
         UP48RyGk/GILWYUOsWjGvSXfqVobIQ0RNM+CTbX9bp/OqyBoEONM+yOUhxDk6VNty44x
         et2pcCJPjyzL+4fTZ8xi1QCN7S+Nyy4+Qlbdl+r1WpXQ7vvEJVl65NvTcbJD2gPEb5Fv
         t6sqYr3c/bPEyzkFDGisVZvSOKzeYkYvAM5WLebKbLO508VJxzAO6R9GGeGwOGdfv0Di
         NRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726108284; x=1726713084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSfI5CuJpaAk4DrDoC9RA+0eQSa8ZrUm0YJlq5XuOQE=;
        b=h5uzV1BdoQ98UwovakcIPXrwGLMDJaz0NWEmJMbTJia9tF5PRUysAEN68cfeN0kyNE
         00o9jHq14l1ydk/iDWrFGaMHd9ugbRUDNWC0px91UAdhaGXUzEjFTAzw0l7ZuaeLS69j
         ahxdUhC+gPMAugufVzhcZtVfPHFyXZg2aViA2an6naqpGVfgXA9lyPu3YyQmxqveoyCj
         Cy6HxTxFO4SdU4cOGSZn+V02iOejqkyE8TMiKJn5EoSXoDo/I4hWCOkTFKawSz4OK8oC
         0QnbDtLr1NPyt3JCW/JCFIkCgbzTUL+mxi/8hj8KyfM/2APtcitTGqtgW5ivHvQLM4Pd
         xZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHuqekyEjaQAhB5N9N8IUVaHcm+THoMa8Q/JSbfuK006owMcsNCGQm6z14YDwdnbIQ/lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0YjyzxoIG7tSiRXQV9+lO+jswpe6pNd5eI9QzYjpoCQakNge
	z/U/1R0fpkkur6nO/uJGgDRuRKZna4SXx5cgYhWRh2ZxZB0R70Tt
X-Google-Smtp-Source: AGHT+IHSP69qwYVLqkhr+zk3BCHF1WqWcv9woHy6w2Ay3DIco+lJrjz/79S0Bmm7O9qhjdAN3dasPw==
X-Received: by 2002:a17:903:24c:b0:205:656a:efd6 with SMTP id d9443c01a7336-2076e45ced7mr17222485ad.53.1726108283515;
        Wed, 11 Sep 2024 19:31:23 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b009867sm5554215ad.296.2024.09.11.19.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:31:22 -0700 (PDT)
Message-ID: <5886886d412f2314c0df5c8b1e8da57f4b4ef51b.camel@gmail.com>
Subject: Re: [RESEND][PATCH bpf 2/2] selftests/bpf: Add more test case for
 field flattening
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 11 Sep 2024 19:31:18 -0700
In-Reply-To: <f5d93124-0f9d-dca8-a11d-a1d21bdf6432@huaweicloud.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
	 <20240911110557.2759801-3-houtao@huaweicloud.com>
	 <4a46fa4393545f54a76f0ffd2fa19d3f0a978d1f.camel@gmail.com>
	 <f5d93124-0f9d-dca8-a11d-a1d21bdf6432@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 09:05 +0800, Hou Tao wrote:

[...]

> > progs/cpumask_failure.c:19:33: error: use of undeclared identifier 'BTF=
_FIELDS_MAX'; did you mean 'BTF_KIND_MAX'?
> >    19 |         struct kptr_nested_array_2 d_2[BTF_FIELDS_MAX + 1];
> >       |                                        ^~~~~~~~~~~~~~
> >       |                                        BTF_KIND_MAX
> >=20
> > [...]
>=20
> BTF_FIELDS_MAX should be defined in vmlinux.h. Could you please check
> whether or not it is present ? It seems that BPF CI reports the same
> problem for=C2=A0 build-x86_64-llvm-17/build-x86_64-llvm-18 [1], but othe=
rs

(did you mean to specify a ling for [1] ?)

> build are OK.=C2=A0 Do you know=C2=A0 is there anything special about
> build-x86_64-llvm-17/18 ?
>=20

Hm, this is interesting. I use LLVM 20.0.0git.
For BTF_FIELDS_MAX to be present in vmlinux.h it first has to be
present in vmlinux DWARF. However, the following output is empty:

  $ llvm-dwarfdump vmlinux | grep BTF_FIELDS_MAX

While picking some other enum literal:

  $ llvm-dwarfdump vmlinux | grep BTF_KIND_INT
                  DW_AT_name	("BTF_KIND_INT")
                  DW_AT_name	("BTF_KIND_INT")
                  ...

Produce output.

Looks like LLVM20 drops info about BTF_FIELDS_MAX for some reason.
I will take a look at compiler internals, but you would need some
workaround for the test, unfortunately.


