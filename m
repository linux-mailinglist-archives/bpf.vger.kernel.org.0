Return-Path: <bpf+bounces-35028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA493705C
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6694A1F225AE
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E8145B28;
	Thu, 18 Jul 2024 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEVFuuUc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045813DDAA
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339989; cv=none; b=uW3YKUyBwrV5Ab/WJDXSbyB2capZRd69MPMzQnODHZDQrQWIliuVmfmIbQyTShU8eP4KciwzKIXD1V2S7Bgq2AYS5AAIw/y2NJwvhIa6GMD15KX/x3hEK9AG/qJ0E6Zg1WgeTNMGwhknHamU2sN2mTxVcvS504oBrkIc6J+1VmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339989; c=relaxed/simple;
	bh=b2ddbXonVrUppSNxfhRGc7ngpie0gAWI1Y5TkhWvjMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbfhV8nkqwNxuEFLabMBuFZf3/3ge/8SOAED8KmUMd+NPtKuCo3cqrehrfmibs+IDUucZsy+tMAbRUzj0N/2S1DSLtiz7wLvcNDCHTDm2PMdJI7ZTjTvFiTMVhYY8WDFwdAXB3kqFiJHv5YDl+/UVj6gzMhUCB+CCTuUNG/1T4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEVFuuUc; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a77c080b521so127184866b.3
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721339986; x=1721944786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIT7qiHknjo3RPh5p+iL8RdSXl5nTmsEwTZ8DVlPuW0=;
        b=lEVFuuUcL6mAj+vlSZuXfDNLLb5YBzXZeO93qOdsXGir2y571eRyBePDySGPHeFicx
         CPw5yANqJnn1XvsClP5u7xZUkWm1cVXGZ+xfDcruQJv7S3YuzB91G+6E85uEfFt8Uz6j
         HjqrlXjjGS1d8bI+LGhNyLNvV35p/8u2j45wB0rjyOvEGfSC42O2uHzXJg2Ov1iTrVFR
         Nhae/YoeTuR1ql2efrhRq7GDZ/Ardp249cbl4q1hhP2gsX5JquKIuwAe50Ii+A/N8IiQ
         e4zOL3luwM8wgHmY9hxJFfywftsjeG+yCKKvUQocXOcSmNtka17L696auskJ2XF3ikTq
         hdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339986; x=1721944786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIT7qiHknjo3RPh5p+iL8RdSXl5nTmsEwTZ8DVlPuW0=;
        b=RDNrJgSAOPCB4450w8r7bDc/+apn7OyKLbRkzuRntCbVqsnpdh39wXCloMgDWs6ADu
         EsGB2lb861exj2eGk2nKeKYqqyp5ft/pzvcypWJcsUoVJyusu4txGS+euVTd0FsnCv2Y
         +RILagsKZG4de1p19OYcjt4RLlHmnwCOVxoMeY5TjPFMVDPZO1c6jPGeQrpjvbOixDjj
         vvMKjyjOsZWh8l4Dcq/QcRKnmg//+47rt/EWgnmK4AaLke+iCSB1tVBJRdZsz3GbgtEM
         UolN60Zl8mgwaPr1Zk+6kz8nUkoEHEznGju04tqkZlVB5+qkREDwEKMvTAgXbeJnqAQ1
         hSpA==
X-Gm-Message-State: AOJu0YwmEX/VLe6Dek2M4ihN/h5XrqYWUmPvI2GUzKnXQtrn5OiN6ltb
	GzKHdxfk8Ec7n0VJ/3BX7awsT19sQI5vYc8r89UUHgWt/Q/oJtJTUyCP07DmVN1Oq1TKxyK9rvk
	vxuf+B8LdL1+YugvIIIH42cxdw74=
X-Google-Smtp-Source: AGHT+IE5xQy4rltuEInp09rMuIpKlNuh+aYfvzAkYuxQDdmBkOpVLR2Xn9YD8YOKTpcxzyNspu4jzOCzwO02fc8dAmw=
X-Received: by 2002:a17:906:7c3:b0:a6f:5698:ab5b with SMTP id
 a640c23a62f3a-a7a01130f82mr436605466b.8.1721339985707; Thu, 18 Jul 2024
 14:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <20240718205203.3652080-1-yonghong.song@linux.dev> <1297da19-18a7-4727-8dab-e45ef0651e14@linux.dev>
In-Reply-To: <1297da19-18a7-4727-8dab-e45ef0651e14@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 18 Jul 2024 23:59:09 +0200
Message-ID: <CAP01T74UdrhC3FXbSYzi91r47n=RMj0XR=R+54YVD4jhsCy3Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2024 at 23:44, Yonghong Song <yonghong.song@linux.dev> wrote=
:
>
>
> On 7/18/24 1:52 PM, Yonghong Song wrote:
> > This patch intends to show some benchmark results comparing a bpf
> > program with vs. without private stack. The patch is not intended
> > to land since it hacks existing kernel interface in order to
> > do proper comparison. The bpf program is similar to
> > 7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel BPF trigger=
ing benchmarks")
> > where a raw_tp program is triggered with bpf_prog_test_run_opts() and
> > the raw_tp program has a loop of helper bpf_get_numa_node_id() which
> > will enable a fentry prog to run. The fentry prog calls three
> > do-nothing functions to maximumly expose the cost of private stack.
> >
> > The following is the jited code for bpf prog in progs/private_stack.c
> > without private stack. The number of batch iterations is 4096.
> >
> > subprog:
> > 0:  f3 0f 1e fa             endbr64
> > 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> > 9:  66 90                   xchg   ax,ax
> > b:  55                      push   rbp
> > c:  48 89 e5                mov    rbp,rsp
> > f:  f3 0f 1e fa             endbr64
> > 13: 31 c0                   xor    eax,eax
> > 15: c9                      leave
> > 16: c3                      ret
> >
> > main prog:
> > 0:  f3 0f 1e fa             endbr64
> > 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> > 9:  66 90                   xchg   ax,ax
> > b:  55                      push   rbp
> > c:  48 89 e5                mov    rbp,rsp
> > f:  f3 0f 1e fa             endbr64
> > 13: 48 bf 00 e0 57 00 00    movabs rdi,0xffffc9000057e000
> > 1a: c9 ff ff
> > 1d: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> > 21: 48 83 c6 01             add    rsi,0x1
> > 25: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
> > 29: e8 6e 00 00 00          call   0x9c
> > 2e: e8 69 00 00 00          call   0x9c
> > 33: e8 64 00 00 00          call   0x9c
> > 38: 31 c0                   xor    eax,eax
> > 3a: c9                      leave
> > 3b: c3                      ret
> >
> > The following are the jited progs with private stack:
> >
> > subprog:
> > 0:  f3 0f 1e fa             endbr64
> > 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> > 9:  66 90                   xchg   ax,ax
> > b:  55                      push   rbp
> > c:  48 89 e5                mov    rbp,rsp
> > f:  f3 0f 1e fa             endbr64
> > 13: 49 b9 70 a6 c1 08 7e    movabs r9,0x607e08c1a670
> > 1a: 60 00 00
> > 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
> > 24: 02 00
> > 26: 31 c0                   xor    eax,eax
> > 28: c9                      leave
> > 29: c3                      ret
> >
> > main prog:
> > 0:  f3 0f 1e fa             endbr64
> > 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> > 9:  66 90                   xchg   ax,ax
> > b:  55                      push   rbp
> > c:  48 89 e5                mov    rbp,rsp
> > f:  f3 0f 1e fa             endbr64
> > 13: 49 b9 88 a6 c1 08 7e    movabs r9,0x607e08c1a688
> > 1a: 60 00 00
> > 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
> > 24: 02 00
> > 26: 48 bf 00 d0 5b 00 00    movabs rdi,0xffffc900005bd000
> > 2d: c9 ff ff
> > 30: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> > 34: 48 83 c6 01             add    rsi,0x1
> > 38: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
> > 3c: 41 51                   push   r9
> > 3e: e8 46 23 51 e1          call   0xffffffffe1512389
> > 43: 41 59                   pop    r9
> > 45: 41 51                   push   r9
> > 47: e8 3d 23 51 e1          call   0xffffffffe1512389
> > 4c: 41 59                   pop    r9
> > 4e: 41 51                   push   r9
> > 50: e8 34 23 51 e1          call   0xffffffffe1512389
> > 55: 41 59                   pop    r9
> > 57: 31 c0                   xor    eax,eax
> > 59: c9                      leave
> > 5a: c3                      ret
> >
> >  From the above, it is clear for subprog and main prog,
> > we have some r9 related overhead including retriving the stack
> > in the jit prelog code:
> >    movabs r9,0x607e08c1a688
> >    add    r9,QWORD PTR gs:0x21a00
> > and 'push r9' and 'pop r9' around subprog calls.
> >
> > I did some benchmarking on an intel box (Intel(R) Xeon(R) D-2191A CPU @=
 1.60GHz)
> > which has 20 cores and 80 cpus. The number of hits are in the unit
> > of loop iterations.
> >
> > The following are two benchmark results and a few other tries show
> > similar results in terms of variation.
> >    $ ./benchs/run_bench_private_stack.sh
> >    no-private-stack-1:  2.152 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000=
M/s)
> >    private-stack-1:     2.226 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000=
M/s)
> >    no-private-stack-8:  89.086 =C2=B1 0.674M/s (drops 0.000 =C2=B1 0.00=
0M/s)
> >    private-stack-8:     90.023 =C2=B1 0.117M/s (drops 0.000 =C2=B1 0.00=
0M/s)
> >    no-private-stack-64:  1545.383 =C2=B1 3.574M/s (drops 0.000 =C2=B1 0=
.000M/s)
> >    private-stack-64:    1534.630 =C2=B1 2.063M/s (drops 0.000 =C2=B1 0.=
000M/s)
> >    no-private-stack-512:  14591.591 =C2=B1 15.202M/s (drops 0.000 =C2=
=B1 0.000M/s)
> >    private-stack-512:   14323.796 =C2=B1 13.165M/s (drops 0.000 =C2=B1 =
0.000M/s)
> >    no-private-stack-2048:  58680.977 =C2=B1 46.116M/s (drops 0.000 =C2=
=B1 0.000M/s)
> >    private-stack-2048:  58614.699 =C2=B1 22.031M/s (drops 0.000 =C2=B1 =
0.000M/s)
> >    no-private-stack-4096:  119974.497 =C2=B1 90.985M/s (drops 0.000 =C2=
=B1 0.000M/s)
> >    private-stack-4096:  114841.949 =C2=B1 59.514M/s (drops 0.000 =C2=B1=
 0.000M/s)
> >    $ ./benchs/run_bench_private_stack.sh
> >    no-private-stack-1:  2.246 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000=
M/s)
> >    private-stack-1:     2.232 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000=
M/s)
> >    no-private-stack-8:  91.446 =C2=B1 0.055M/s (drops 0.000 =C2=B1 0.00=
0M/s)
> >    private-stack-8:     90.120 =C2=B1 0.069M/s (drops 0.000 =C2=B1 0.00=
0M/s)
> >    no-private-stack-64:  1578.374 =C2=B1 1.508M/s (drops 0.000 =C2=B1 0=
.000M/s)
> >    private-stack-64:    1514.909 =C2=B1 3.898M/s (drops 0.000 =C2=B1 0.=
000M/s)
> >    no-private-stack-512:  14767.811 =C2=B1 22.399M/s (drops 0.000 =C2=
=B1 0.000M/s)
> >    private-stack-512:   14232.382 =C2=B1 227.217M/s (drops 0.000 =C2=B1=
 0.000M/s)
> >    no-private-stack-2048:  58342.372 =C2=B1 81.519M/s (drops 0.000 =C2=
=B1 0.000M/s)
> >    private-stack-2048:  54503.335 =C2=B1 160.199M/s (drops 0.000 =C2=B1=
 0.000M/s)
> >    no-private-stack-4096:  117262.975 =C2=B1 179.802M/s (drops 0.000 =
=C2=B1 0.000M/s)
> >    private-stack-4096:  114643.523 =C2=B1 146.956M/s (drops 0.000 =C2=
=B1 0.000M/s)
> >
> > It is is clear that private-stack is worse than non-private stack up to=
 close 5 percents.
> > This can be roughly estimated based on the above jit code with no-priva=
te-stack vs. private-stack.
> >
> > Although the benchmark shows up to 5% potential slowdown with private s=
tack.
> > In reality, the kernel enables private stack only after stack size 64 w=
hich means
> > the bpf prog will do some useful things. If bpf prog uses any helper/kf=
unc, the
> > push/pop r9 overhead should be minimum compared to the overhead of help=
er/kfunc.
> > if the prog does not use a lot of helper/kfunc, there is no push/pop r9=
 and
> > the performance should be reasonable too.
> >
> > With 4096 loop ierations per program run, I got
> >    $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D4096 no-priv=
ate-stack
> >    18.47%  bench                                              [k]
> >    17.29%  bench    bpf_trampoline_6442522961                 [k] bpf_t=
rampoline_6442522961
> >    13.33%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_p=
rog_bcf7977d3b93787c_func1
> >    11.86%  bench    [kernel.vmlinux]                          [k] migra=
te_enable
> >    11.60%  bench    [kernel.vmlinux]                          [k] __bpf=
_prog_enter_recur
> >    11.42%  bench    [kernel.vmlinux]                          [k] __bpf=
_prog_exit_recur
> >     7.87%  bench    [kernel.vmlinux]                          [k] migra=
te_disable
> >     3.71%  bench    [kernel.vmlinux]                          [k] bpf_g=
et_numa_node_id
> >     3.67%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf_p=
rog_d9703036495d54b0_trigger_driver
> >     0.04%  bench    bench                                     [.] btf_v=
alidate_type
> >
> >    $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D4096 private=
-stack
> >      18.94%  bench                                              [k]
> >      16.88%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf=
_prog_bcf7977d3b93787c_func1
> >      15.77%  bench    bpf_trampoline_6442522961                 [k] bpf=
_trampoline_6442522961
> >      11.70%  bench    [kernel.vmlinux]                          [k] __b=
pf_prog_enter_recur
> >      11.48%  bench    [kernel.vmlinux]                          [k] mig=
rate_enable
> >      11.30%  bench    [kernel.vmlinux]                          [k] __b=
pf_prog_exit_recur
> >       5.85%  bench    [kernel.vmlinux]                          [k] mig=
rate_disable
> >       3.69%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf=
_prog_d9703036495d54b0_trigger_driver
> >       3.56%  bench    [kernel.vmlinux]                          [k] bpf=
_get_numa_node_id
> >       0.06%  bench    bench                                     [.] bpf=
_prog_test_run_opts
> >
> > NOTE: I tried 6.4 perf and 6.10 perf, both of which have issues. I will=
 investigate this further.
>
> I tried with perf built with latest bpf-next and with no-private-stack, t=
he issue still
> exists. Will debug more.
>

Just as an aside, but if this doesn't work, I think you can have a
better signal-to-noise ratio if you try enabling the private stack for
XDP programs and just set up two machines, with a client sending
traffic to another and run xdp-bench [0] on the server. I think you
should observe measurable differences in throughput for
nanosecond-scale changes, especially in programs like drop which do
very little.

[0]: https://github.com/xdp-project/xdp-tools

