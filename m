Return-Path: <bpf+bounces-42805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A49AB56E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168282818E2
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4191C2DCC;
	Tue, 22 Oct 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC33xv4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA313FE55;
	Tue, 22 Oct 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619246; cv=none; b=jxCMvcDq2dYeece9/GrV1CSF4AJM4rLlte0lr/zGaWnD2gSLgWP4wn1VvU1nuX/6rsGt0iphGCBb6Edy11SzQ+7ydwInGseqeX4eGHs8zcgt09iJn/SSJ3LCExtAk3oJtojXiyfnIbyD2a3VtpYR2oMLuwUScBXChbCKlFkhv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619246; c=relaxed/simple;
	bh=raYP82xdEbL7nQYAeHkY+SkxWx7riZAwYtNgws8ZUiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6TuDHopDxb4HYyyrlTz72rziy+w3S7oHXMhFrnwynYzlHupZJoNoXbOWPUI2tu/u8yK1n9ZirjyAAomeMZdlRNKg6cO/YwiMmzZUBwXnzrR9xsKbtNWrmvoRqsIJVouVZdOX9b2lEJ/BRgcpzsIVGhd5oF+2ftFpi67+9SQYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC33xv4B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e625b00bcso4350851b3a.3;
        Tue, 22 Oct 2024 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729619244; x=1730224044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ddUMQ7YsPimbk4F7Nb5pyH2YBrKesDZgI8kYiDJ2Fc=;
        b=HC33xv4BzmaatrvM7il8uEj0yCZSgMJCRolOU/vbvFla8mm+5BIeLqGOZRkUR0jWlt
         EVc6dJOziRhipD464C7VTCpDKNVyCBJfqQ5J/U5b+K3iRF2iF8hDBUt1xvTK6Ng5GiAT
         z/iDToj4ltDefyZJLfcGNO/OXwhqw8GGQCmxMIymEjHSzP+39BapW/72TZfwnhAleoWd
         fsYZ3EOwb9tuJieNV0cqADNJL8rNQzSp3tXlaruH3JixKb/5cTsW6QZZtIyHONuCDGSN
         tjIVCuYrFhxbR9K9dhDOgIzldjUknZjauvgnCTths+xPI5mT/sIuia8kfBFVvfLE6vYq
         VsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619244; x=1730224044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ddUMQ7YsPimbk4F7Nb5pyH2YBrKesDZgI8kYiDJ2Fc=;
        b=rWfbjTVR9AEC25yDLfH1PWaQJFULgbgqd8cOtiL++3ueNFKMozZtVvDYJ5fp13sID8
         OgddFeRtTikIRZ3ZkMDbobFgmdFPmbt5hx6yC3/+soZGZcVAKNeaef1ZFZhexlwv4mVZ
         8infYEI/8fI/v630gF4jm+xFYccZ1CXjrNCwVxN0L5eg6b1zrigjPGmj8yQDMhoATL2d
         CPxuDZC109KKLJgh6WVF7b2cnzaT5VCxq4SvV9wbfNj9h3bMhy+rBmxQ5aapDNuW9VJu
         Nq/p3CKReAg8Yy3DYCUgRpIHx/y8Qo78vPfV5WL77bDXtMCU70TwqIXE+mH+zNz4/vOr
         b8dw==
X-Forwarded-Encrypted: i=1; AJvYcCU/F63HMePTwWSeTs2Muk+MBvN3ftyvEpfG+xvtEKomdBlMAJytkw9aMU2MJgG4Gua2JbM=@vger.kernel.org, AJvYcCU1WNjuN6ZH3czy+Fwqb1mDLbSzhi9Shrx9uagjaroTkypjRwwB/Ocncv8klLVExyCKlw54L1PFfaPVl2sK@vger.kernel.org, AJvYcCUKE6NRXkv8MrdaxLZC7U6AJYpov4JuI3LfxVWjoPR1ZxLIlcjbrVgO4e31pradMB/FQFcx91BX@vger.kernel.org, AJvYcCUXdpPZDlCkEM+e89GRhgcFw066CjAHG+G3mloYUB6FM0aZTpzDoUhqXSWk65xUYQunJttve9cZh9IuyGPu@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUNFzsBdTuk9JkXZJHKvrnU1rCu1NQrAMg9XLvxUPT/tlg1On
	dJpww5XHjZVHfxFziYQhkPaKJnX2LuHTEkvHxOe5os5rudAmUxFb7Gyh3SGEIXsS/kujx3Nln6E
	3m5fw7qPyG5c4RVl86s7UL1APrxM=
X-Google-Smtp-Source: AGHT+IHYzZ1MPfouURSpXauQvjKpAqxHOZgCBInLj8fQ2B+q8L2j1IhoGXxHbfumGhFT2TP8+T2OX/YchRKQE6e2aiM=
X-Received: by 2002:a05:6a20:d528:b0:1d8:a899:8899 with SMTP id
 adf61e73a8af0-1d96dece18cmr3235223637.29.1729619244353; Tue, 22 Oct 2024
 10:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021122112.101513-1-puranjay@kernel.org> <20241021122112.101513-5-puranjay@kernel.org>
 <CAEf4BzY1LgCF1VOoAQkMdDTx87C0mfyftMvhvVU4GpsFc6fw5g@mail.gmail.com> <mb61pa5ewbfpk.fsf@kernel.org>
In-Reply-To: <mb61pa5ewbfpk.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 10:47:12 -0700
Message-ID: <CAEf4BzZ-gfBqez-QJCSRVOPnvz-inaiVdNGOFRCdc2KQbnmeZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add benchmark for
 bpf_csum_diff() helper
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, 
	Helge Deller <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:21=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Mon, Oct 21, 2024 at 5:22=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> Add a microbenchmark for bpf_csum_diff() helper. This benchmark works =
by
> >> filling a 4KB buffer with random data and calculating the internet
> >> checksum on different parts of this buffer using bpf_csum_diff().
> >>
> >> Example run using ./benchs/run_bench_csum_diff.sh on x86_64:
> >>
> >> [bpf]$ ./benchs/run_bench_csum_diff.sh
> >> 4                    2.296 =C2=B1 0.066M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 8                    2.320 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 16                   2.315 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 20                   2.318 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 32                   2.308 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 40                   2.300 =C2=B1 0.029M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 64                   2.286 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 128                  2.250 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 256                  2.173 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> 512                  2.023 =C2=B1 0.055M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >
> > you are not benchmarking bpf_csum_diff(), you are benchmarking how
> > often you can call bpf_prog_test_run(). Add some batching on the BPF
> > side, these numbers tell you that there is no difference between
> > calculating checksum for 4 bytes and for 512, that didn't seem strange
> > to you?
>
> This didn't seem strange to me because if you see the tables I added to
> the cover letter, there is a clear improvement after optimizing the
> helper and arm64 even shows a linear drop going from 4 bytes to 512
> bytes, even after the optimization.
>

Regardless of optimization, it's strange that throughput barely
differs when you vary the amount of work by more than 100x. This
wouldn't be strange if this checksum calculation was some sort of
cryptographic hash, where it's intentional to have the same timing
regardless of amount of work, or something along those lines. But I
don't think that's the case here.

But as it is right now, this benchmark is benchmarking
bpf_prog_test_run(), as I mentioned, which seems to be bottlenecking
at about 2mln/s throughput for your machine. bpf_csum_diff()'s
overhead is trivial compared to bpf_prog_test_run() overhead and
syscall/context switch overhead.

We shouldn't add the benchmark that doesn't benchmark the right thing.
So just add a bpf_for(i, 0, 100) loop doing bpf_csum_diff(), and then
do atomic increment *after* the loop (to minimize atomics overhead).

> On x86 after the improvement, 4 bytes and 512 bytes show similar numbers
> but there is still a small drop that can be seen going from 4 to 512
> bytes.
>
> My thought was that because the bpf_csum_diff() calls csum_partial() on
> x86 which is already optimised, most of the overhead was due to copying
> the buffer which is now removed.
>
> I guess I can amplify the difference between 4B and 512B by calling
> bpf_csum_diff() multiple times in a loop, or by calculating the csum by
> dividing the buffer into more parts (currently the BPF code divides it
> into 2 parts only).
>
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  tools/testing/selftests/bpf/Makefile          |   2 +
> >>  tools/testing/selftests/bpf/bench.c           |   4 +
> >>  .../selftests/bpf/benchs/bench_csum_diff.c    | 164 +++++++++++++++++=
+
> >>  .../bpf/benchs/run_bench_csum_diff.sh         |  10 ++
> >>  .../selftests/bpf/progs/csum_diff_bench.c     |  25 +++
> >>  5 files changed, 205 insertions(+)
> >>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_csum_diff=
.c
> >>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_csum_=
diff.sh
> >>  create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_bench.=
c
> >>
> >

[...]

