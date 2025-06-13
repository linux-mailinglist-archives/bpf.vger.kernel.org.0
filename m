Return-Path: <bpf+bounces-60562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55431AD8044
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 03:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B893B1410
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABE1D61BB;
	Fri, 13 Jun 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF2LmgXR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487B72636
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778181; cv=none; b=QrxkwgpUdpkX6q/oizuGTa9qWrHWz9xVEoMiZ54vR3JC+CwNtUqP1oGHT57rxWN7KGuMMh0w3gWakwA02EkRnqA/GIAODhwFjCjCbwvXB2K5JqgYmDPozwOf6s/tl2MVvSLQPGbGATLMi0xKH/1sT0wLSjQ3WM5HDXb20fjClwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778181; c=relaxed/simple;
	bh=adG/o9bp23oUhH+NojikQT9CFP3S4zTejsGym/1Njpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hrv6FyOpDL9uvP1CDVGYExlhGRSeFAwbbU1TgIjeGkNvKAqWJ+8RX3hRL+wAVVQCItcaCd2BTeRJ0UCJtTjRTs77efDPKGpqcHkrZI3w4lyo/y7plUkGRx8HeGoUlRtnUx3rC3o9c2mEdBu75mPAxMf+Zh7iH4k2Gy2I4SkAm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF2LmgXR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c49373c15so1188071a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749778179; x=1750382979; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GWLjKnLMCdq2wY0BVYr/ebx4xP63IeHDVYsGAaE9mTc=;
        b=LF2LmgXR5LHpdDY2Qbu2JjutRprav+e95fRSZ1W272DW7j90+vKAKwyNpplPY/oI9q
         Ms4KG/WOS8pX7DHnbUToOcQCxfOWE88bk0WGcIgc1KS53KTBFIMa28qo55FZQzj7qjfq
         NrK7eQM+VlvhaB7eEt4PXc878ca8X/Bz6Osl7g00uaM7ApfAjDXTXGBp41RDOz7rapus
         CRKfCRBWuONjEVaYOxFH1vB0OPhxs22yzXI0wyw3WUcv+Pu8RPSn1QScAeHx3MNrMr0K
         WKy9dx1IZxAMwlRcx794jah8HJyGolm6HBezkD4RP9wjxQXTLzBrnOoI5g40ptRHY7bv
         ZXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749778179; x=1750382979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWLjKnLMCdq2wY0BVYr/ebx4xP63IeHDVYsGAaE9mTc=;
        b=TV1VXI2iw39eYAaHTd/oy7FTAS45qZTiBBTGuKr35H3eDV5Awd/UknjK+WoECRuzIE
         HiB7Y5xtZQAOFg3zjPIg3dqrBAUq5DmnVuk6WA2eaRiZcYiv3CX4SSY/zndlSIABzBeJ
         bEasBe73hZg86eEo32srYz80RshGk/5Z/1fp0/BjgAAWW/8SkKCr70ZYYK0VN9l9rG3g
         2/CQmm3aCMp/60f2865iB49EzXvVIoMcz6HU7GRU5rqcxkjaSElYUJhv5LunVr9LQ+Rg
         H0sKlRCGM+6q1Hzt739a09/6mIcJSDHnfjkHR2oO0nI/05wc/vid4qkavxKfjKPH7imp
         B57A==
X-Gm-Message-State: AOJu0YyIIQq1wLAQi85yki9O8cyAzw6yJBM5j28go2GVHKRp2ANK5VTG
	KHY407CFKMNMPPt+K7Cvs9U45C+y42mV06Zo7iPqMMosTbrZlGW+t49P
X-Gm-Gg: ASbGncusL7J/vtU67QDOEOshZPc/0MqTmSxnViUpa2qHwMSEdiS1QCj6TJzaAm1DAmO
	u2hOX5PJZsO9iaxg7rpUUYqFhnOUGrGN4GZfbyPlUOd/GFrrE169HyWuHiShYSzTaBJ1FxIajaA
	KmFrFG6n2p/+Cnn+Jwp/pV1cEORwhWQ6FEmSnf8Pi464wK8H/3P9s5j0A5Gt1bqrfpey4fDtTrV
	o8mzSvelVVEzNcdqXMcQZmnXcRAmiYXcZWjjlnRjL4HIy5l65mfOYvHdr8TL7O1+nXpOIOoCgAe
	PHU4apUrtn15V85M1TZbkWq7PpvIzKGZoIaS1Ii2NN3wuIUjurKc3Rn8vHJs4UstP1t99Q==
X-Google-Smtp-Source: AGHT+IFB5GBXY7df8hYQM3l8cdd2SksStJYmufB3uksqLmPT40FfnX0t+14smIgtCTL3dEjRdardyQ==
X-Received: by 2002:a05:6a21:8cc3:b0:216:1c88:df46 with SMTP id adf61e73a8af0-21fab5f84a4mr1943120637.0.1749778178619;
        Thu, 12 Jun 2025 18:29:38 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1639fe0sm469426a12.14.2025.06.12.18.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 18:29:38 -0700 (PDT)
Message-ID: <60dc085263d7d746f5c223f8df85f55679786c7f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: include verifier memory
 allocations in memcg statistics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 12 Jun 2025 18:29:35 -0700
In-Reply-To: <CAADnVQJxQMEdbdTrDSZyb+SWxdwjJYWx6F6jmkff=OAeEoSTPQ@mail.gmail.com>
References: <20250612130835.2478649-1-eddyz87@gmail.com>
	 <20250612130835.2478649-2-eddyz87@gmail.com>
	 <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com>
	 <1cd8ae804ef6c4b3682e040afea7554cb3bde2f8.camel@gmail.com>
	 <CAEf4BzbSy_imqzs3Z+GAb1iA1WKs+vDkO1Q6pDmd3zzL-Ttzdg@mail.gmail.com>
	 <CAADnVQJxQMEdbdTrDSZyb+SWxdwjJYWx6F6jmkff=OAeEoSTPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 17:53 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 12, 2025 at 5:18=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >=20
> > On Thu, Jun 12, 2025 at 5:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >=20
> > > On Thu, 2025-06-12 at 17:05 -0700, Andrii Nakryiko wrote:
> > >=20
> > > [...]
> > >=20
> > > > We have a bunch of GFP_USER allocs as well, e.g. for instruction
> > > > history and state hashmap. At least the former is very much
> > > > interesting, so should we add __GFP_ACCOUNT to those as well?
> > >=20
> > > Thank you for pointing this out.
> > > GFP_USER allocations are in 4 places in verifier.c:
> > > 1. copy of state->jmp_history in copy_verifier_state
> > > 2. realloc of state->jmp_history in push_jmp_history
> > > 3. allocation of struct bpf_prog for every subprogram in jit_subprogr=
ams
> > > 4. env->explored_states fixed size array of list heads in bpf_check
> > >=20
> > > GFP_USER is not used in btf.c and log.c.
> > >=20
> > > Is there any reason to keep 1-4 as GFP_USER?
> > > From gfp_types.h:
> > >=20
> > >   * %GFP_USER is for userspace allocations that also need to be direc=
tly
> > >   * accessibly by the kernel or hardware. It is typically used by har=
dware
> > >   * for buffers that are mapped to userspace (e.g. graphics) that har=
dware
> > >   * still must DMA to. cpuset limits are enforced for these allocatio=
ns. a
> > >=20
> > > I assume for (3) this might be used for programs offloading (?),
> > > but 1,2,4 are internal to verifier.
> > >=20
> > > Wdyt?
> >=20
> > Alexei might remember more details, but I think the thinking was that
> > all these allocations are user-induced based on specific BPF program
> > code, so at some point we were marking them as GFP_USER. But clearly
> > this is inconsistent, so perhaps just unifying to GFP_KERNEL_ACCOUNT
> > is a better way forward?
>=20
> Beetlejuice.
> 1,2,4 can be converted to GFP_KERNEL_ACCOUNT,
> since it's a temp memory for the purpose of verification.
> 3 should probably stay as GFP_USER, since it's a long term memory.
> GFP_USER is more restrictive than GFP_KERNEL, since
> it requires memory to be within cpuset limits set for the current task.
> The pages allocated for user space needs should be GFP_USER.
> One can argue that bpf prog is not accessed by any user task
> and prog itself is more like kernel module, so GFP_KERNEL is fine,
> but it will require a bigger code audit.

Thank you, I've converted 1,2,4.
For 3 I'd avoid accounting same way I avoided it in jit, assuming that
this memory does not belong to cgroup, but to some common kernel pool.

Looks maximal memory consumption did not change by much compared to
measurements for SCC series, top consumers for sched_ext:

Program                          Peak memory (MiB)
-------------------------------  -----------------
lavd_select_cpu                                 42
lavd_enqueue                                    41
lavd_dispatch                                   28
layered_dispatch                                28
layered_enqueue                                 12

Top consumers for selftests:

File                     Program                         Peak memory (MiB)
-----------------------  ------------------------------  -----------------
pyperf600.bpf.o          on_event                                      267
pyperf180.bpf.o          on_event                                      213
strobemeta.bpf.o         on_event                                      199
verifier_loops1.bpf.o    loop_after_a_conditional_jump                 128
pyperf100.bpf.o          on_event                                      118

