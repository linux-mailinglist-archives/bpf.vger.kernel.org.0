Return-Path: <bpf+bounces-60616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D015FAD9379
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ABB3B6CC7
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D3221727;
	Fri, 13 Jun 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8mQteoO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400891E51F6
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834364; cv=none; b=hatWcTWONSfUV+azPZIOm0iHfnAnfncSsKnbDtnFCCO+hIehKJxJMSlJtPgeyUPlo5l85pGSwSj4Dk9vfDW61e1gmQzCRPXBmPZStpSAWJfamIMlG3RAuGOpG0gELPRSbVs9Ft1AwoxK0mUs3p/FPd1yORuBguuX/R1Zmk1w63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834364; c=relaxed/simple;
	bh=ew0DV2QaFRa0o3nMt3BOZ9kwHeU9qmhao6OOejzQ55c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1Rbv/yyXw+3CV0nTgGLmawpH/ZeT7ok2xvkiSIL8kLUyz7jvp4sYBbFIY+aePTowfqZNqwMb0pKi6uVXI9x0aXN5wdTg2uzqrd5K+c6UNKdFcI/wOpz0Vqd2IKjTBtlMiw5KxSnS1FwXY7PP47Nwrtz65YBUr0IKkCZVqIReao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8mQteoO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c27df0daso1922770b3a.1
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749834362; x=1750439162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0+ySANOfzKHrFAPGslwkv8ytwbnZv14m9d3Q3tX6+U=;
        b=P8mQteoORTp3jf6uzmnnCZa35aO5zSAJBo7VvY6PZpiv9YydCZlC6TuZJVIW7yca7U
         vkZgs1bzf2F1OrePJBu3gQzqqNMKcQ9PG4lifCNniWs93u9x6aFAVIowIglteXO0d1n3
         VJds6UO8B7akfwtjOpzeYQteJwt0DGuathFTwzhv9r/cbv39VWV6luY1iDmIPR8LPXn7
         OusUlxWix6v38BuqBrHFP0p1PMcIwhC552Q/Pi2sdzE1XbvMufEd05KNwNHd4kXCQK9l
         a2Fv3AvCq7+62xFXt8ymcZ4YkSrgFkaDlt/THznxiZ8ltJZB13OhhgY+pmGr3UXValSd
         KLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834362; x=1750439162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0+ySANOfzKHrFAPGslwkv8ytwbnZv14m9d3Q3tX6+U=;
        b=Brg7WC0g4BxUJSVdaFNi/VdEtYRIJ3VRUToCrT6w8FQUTHTD9HCirJUNNR1IzbyPXO
         sosOw21Xk9/qoVdYqMDMiGn5AD8VkkWUkI8DAFFXu59laMrPBzQetFfWTOhxqh0HhE/1
         bD7Klypc4rLtg9tSrld6m0Tv5cvjV12G8qX95EJu52mvoOz49NopwqXEIStc3501pbK0
         B6a4WbxN6qzPOSNrNCcBStV/dPFVcywsu17ka6aBlxX4S3NGLvWy/nhaaFIPEfrh2Wnn
         zh/9mrL/8T9+8XpYtWN0qebX/dmSBALP8C2URsWC4xDpeSo+RIUyQIhRnOcNW5kEHig1
         XCiQ==
X-Gm-Message-State: AOJu0YzTqt1yDgw9tro4emKtK+Wqm3i5IOaH3yGF197r01zbXg0+b1oH
	DYUzv2XgZ/W4aAm1ANRoyqtLEjggaltuFZ3ff6B/EuUx26DQGOMK0IVCle+p37u9QVAFEf4XdxQ
	RRE7vqyCv54O5hU7IvixqBd7gZiZ2/Ac=
X-Gm-Gg: ASbGnctkvcHzixQuQYtksF1sPaoeui6aN/1Q35ZA8hiyyD9EZPIPTlziF7qmQ3g8jGg
	yWjBpwJVcakIvTcBwx62ElJx2vjdpf0nglsZMU+yJmHA0H/agKu3EzGJ1NQs/qxdyMBfehUyNzA
	iUH8kXfEssVpq4Ne0EUoUr+9uzcKnUli7qih7KNWmU6W9sZZnooHhU1SGubIM=
X-Google-Smtp-Source: AGHT+IHD5taQEDip+6eJVTdo2delZQL9QIvwsp0p9xv5LeThRPVn5pZ0CBYRTlEOmYUw9h97rT/6hHYAW19TGpYNzd0=
X-Received: by 2002:a05:6a00:a8e:b0:748:2e7b:3308 with SMTP id
 d2e1a72fcca58-7489ce07d29mr212635b3a.6.1749834362478; Fri, 13 Jun 2025
 10:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613153446.2256725-1-yonghong.song@linux.dev>
In-Reply-To: <20250613153446.2256725-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Jun 2025 10:05:50 -0700
X-Gm-Features: AX0GCFulHkjKMtdkH3VRMNq4MjNIiNlgGV51IT_KrGoqBJ3pRRmpW24nxm_QzLU
Message-ID: <CAEf4BzYk_Oh+0TVbJBRd-g+EEamgKmXMHhLVUqL4FEVvjzkw0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix usdt multispec failure with
 arm64/clang20 selftest build
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 8:35=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> When building the selftest with arm64/clang20, the following test failed:
>   ...
>   ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
>   subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
>   subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0xa=
aaad82a2a80
>   #469/2   usdt/multispec:FAIL
>   #469     usdt:FAIL
>
> But gcc11 built kernel/selftests succeeded. Further debug found clang gen=
erated
> code has much less argument pattern after dedup, but gcc generated code h=
as
> a lot more.
>
> Below is the test:usdt_100 stapsdt's with clang20 generated binary:
>
>   $ readelf -n usdt.test.o
>   Displaying notes found in: .note.stapsdt
>   Owner                Data size        Description
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x0000000000000024, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[x9]
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x000000000000003c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[x9]
>   ...
>     stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe des=
criptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x0000000000000954, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[x9]
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x000000000000096c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[x8]
>
> Below is the test:usdt_100 stapsdt's with gcc11 generated binary:
>
>   $ readelf -n usdt.test.o
>   Displaying notes found in: .note.stapsdt
>   Owner                Data size        Description
>   ...
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x000000000000470c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[sp]
>   stapsdt              0x00000031       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x0000000000004724, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[sp, 4]
>   ...
>   stapsdt              0x00000033       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x000000000000503c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[sp, 392]
>   stapsdt              0x00000033       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_100
>     Location: 0x0000000000005054, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
>     Arguments: -4@[sp, 396]
>
> Considering libbpf dedup of usdt spec's, the clang generated code has 3 s=
pec's, and
> gcc has 100 spec's. Due to this, bpf_program__attach_usdt() failed with g=
cc but succeeded
> with clang. To fix the test failure for clang generated code, make bpf_pr=
ogram__attach_usdt()
> succeed with necessary macro guards.

This is not the right way. We can just override BPF_USDT_MAX_SPEC_CNT
#define in the BPF code instead. It's set to 256 by default, seems
like we need more due to the unique set of stack offsets.

But it's kind of surprising that GCC generates such a suboptimal code
where each value is in its own slot on the stack. Look at
trigger_100_usdts(), we just call the same USDT with x + i, where i
goes from 0 to 100. I guess it's because it's debug mode, but still a
bit surprising, IMO.

pw-bot: cr

>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 495d66414b57..7429029cbd63 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -272,12 +272,19 @@ static void subtest_multispec_usdt(void)
>
>         /* we'll reuse usdt_100 BPF program for usdt_300 test */
>         bpf_link__destroy(skel->links.usdt_100);
> +
>         skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.usd=
t_100, -1, "/proc/self/exe",
>                                                         "test", "usdt_300=
", NULL);
> +#if __clang__ && defined(__aarch64__)
> +       if (!ASSERT_OK_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
> +               goto cleanup;
> +       bpf_link__destroy(skel->links.usdt_100);
> +#else
>         err =3D -errno;
>         if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
>                 goto cleanup;
>         ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
> +#endif
>
>         /* let's check that there are no "dangling" BPF programs attached=
 due
>          * to partial success of the above test:usdt_300 attachment
> --
> 2.47.1
>

