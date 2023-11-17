Return-Path: <bpf+bounces-15278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE147EFB05
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4C280C44
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1439630FAE;
	Fri, 17 Nov 2023 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkW6kEB3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F6D6D
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:50:20 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c594196344so31889731fa.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700257819; x=1700862619; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=COJRsSkz2aOcxreLbthFf3i+JZ2k5F3TvGTb/H0SCZI=;
        b=fkW6kEB3qQZgEsz5fe/f61GQqaQwKib48ffZ88CdyKhtk7zoABjhmKhpY37wn/nqxV
         DunvPgLeipuXCBY/bHEmsuf9+YEegbNKgF2laxEhJDfE9V+z3glHohHtlDOa0EfGVW2x
         nWYREK1wmIsVmq8LWtYeyAzwzb+6NzULZyca/jI8u8Nu5EUg+Mrhq8FsOiKPvhw87UU6
         0s/TXfMKopfZ/EgOkrUcKcjD4ocXivXX3TLlDAWNiechGcTljPHH6vcf1amXvErMq55t
         L2bWLdjhIu8MWckxcJ2wUq3e/9dSspO8ddG8WBLcrBbxh+KYZIpPtFHEfo3G9IlHmO5V
         Vmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257819; x=1700862619;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COJRsSkz2aOcxreLbthFf3i+JZ2k5F3TvGTb/H0SCZI=;
        b=Rb0bDRxebUXC4RGCYthc1Ldxa15oLKXMJl3VIGDI/mFRRzdAnU+pq3+MLcUvz0jwSe
         TG2W6fu74cabu3xjgXgVr2Nny9fqrPMJ7ip/J7agFV2Pjl+iDViW9yybwImXh4MuxB+F
         lp1iQeP14GRNZ7j33lb7HZu076BRDM1UiGAt0/BfQ9jAH71KkTdT/c9trciZ0e+FjUBo
         sggm9RaTt0Od7nHFSWG0FkdHn4yZnne3W4U7KwpybyEMXkz1nuV7DY8FeaAz/jzdBfZ8
         bqVLevPjxhZJWoT5NuW70tl2L58D1OeWLIz7OiPuafwe7nItgPTugqIhQLkR+tKewjxt
         lTlw==
X-Gm-Message-State: AOJu0YzrmnfBn1Rd6ObeS/3GmPzkDRcS6vGIBHjgNEda/yaaXeic8ckj
	ANhm00WIIwLMj389aZBzO9Jcp1s0TZo=
X-Google-Smtp-Source: AGHT+IEaszwkWQXsgxcOBkOQNRYv+LATFy6R4eypvI57xZUOz2GAvV/ZFEXQyJ7PthtpGc9Cr5Jhww==
X-Received: by 2002:a2e:3805:0:b0:2c5:24a8:c22d with SMTP id f5-20020a2e3805000000b002c524a8c22dmr606897lja.3.1700257818841;
        Fri, 17 Nov 2023 13:50:18 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090632d000b009ddaf5ebb6fsm1197192ejk.177.2023.11.17.13.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:50:18 -0800 (PST)
Message-ID: <98121f5fd31d67825f4869acd02d1c672f13772c.camel@gmail.com>
Subject: Re: [PATCH bpf 03/12] selftests/bpf: fix bpf_loop_bench for new
 callback verification scheme
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Andrew Werner <awerner32@gmail.com>
Date: Fri, 17 Nov 2023 23:50:17 +0200
In-Reply-To: <CAADnVQJ-ujkk0CKD6=J2dXhd2gJGp-nsnCcRAHBB_6+FBB=xOw@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-4-eddyz87@gmail.com>
	 <CAADnVQKr+OwMKY6OofP8JiJjrEF9wmSF0+68h0o4yeNXCFvEhg@mail.gmail.com>
	 <89c592a523d68713a2d3a6c8f3bbe858ff75d069.camel@gmail.com>
	 <CAADnVQJ-ujkk0CKD6=J2dXhd2gJGp-nsnCcRAHBB_6+FBB=xOw@mail.gmail.com>
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

On Fri, 2023-11-17 at 13:47 -0800, Alexei Starovoitov wrote:
[...]
> > This is patch #3, and actual changes are in patch #6, I can change it t=
o:
> >=20
> >   A follow-up patch "bpf: verify callbacks as if they are called
> >   unknown number of times" changes logic for callbacks handling.
> >   While previously callbacks were verified as a single function
> >   call, new scheme takes into account that callbacks could be
> >   executed unknown number of times.
> >   ...
> >=20
> > Would that work?
>=20
> ... or just drop it. The commit log typically describes only what's
> happening in this commit or links to prior commits.
> Future commit references are unusual.

But there needs to be some justification.
Since this is not a test, maybe move it after patch #6 and refer to a
changes from a previous commit?

