Return-Path: <bpf+bounces-60559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A2AD7FCD
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E763B68FC
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CF1B0420;
	Fri, 13 Jun 2025 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuM2C9eI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231B1A3161
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776054; cv=none; b=XKGwffwpPgboXPhdKyPNudW4KDbGIuqELOOfWM+IdaYgcZOTr2zcmokX9sA1FR0/Cb3EdYFDuT166d30icptN7XLJgpUJ7pHRiFk4WYzdT49i9hT45sQwysRBDqWQ9vBpOj6uwOPmskmvBvQXYYe3vevfhxFQiz2llziJar0oIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776054; c=relaxed/simple;
	bh=3LhHtgtR8wC8DyUWTylcIMXiDF6RccGf4Q/xMUS4+zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaDL7KqGbR/OFY2aDMiY2Ntcq5DF9sGrPD9+qhMjUNd/RjBX3uL1H08iIiSz9f5N3M8E6P4KLzwKLnWrM7U/1p2VtnfN3wg4Ihr9eMTG30XADUa/mRAwUbDxbbw65VhW4Sw3yKZ+fR9BiEflrc2WWzYrLNYkOymzvxybwBxbja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuM2C9eI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so890450f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749776051; x=1750380851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22UTCPGms/Ay4tkXxYZ6Q7dqCJ0hDCL3wk9TuZRuH2k=;
        b=FuM2C9eIVymofeMzS2Pzkm8n+bdaHJ3wTAYckrImKd5Y9RzcW4/OqxTXmfGg/3Wfgv
         10/+AMeMljy1aEKIp2rwN9X3qjnb5ZmMTzjNeyePw7+AJfJgvNdpNsGxzaeD8j7HN0eB
         iW0KgG6iov0O89gOVa7P+1Gh3nPidPN2zRYYrur1FRkV77U13hVgbvzsNMZFl7otN61e
         a/UTPkSDf1ShHmxQtiQkhxDMkAspJKhsvKswKRgLFaTKFTTUNa0sC2E/I7WjHXrtC+D0
         Sn7D8ysrUpwTXbPQREXm1QrliKYDWWtogCZWXesybU1Q9geQGyIu8NFbPZNnqaDPpEpd
         Liqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749776051; x=1750380851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22UTCPGms/Ay4tkXxYZ6Q7dqCJ0hDCL3wk9TuZRuH2k=;
        b=NRN3iyyHUU3ieDXRsI2TNljQwgW4hyK9IDVdrrVARb3Jrlf4FT9mnidG34UELr0+hm
         YvnTQV8Ae7kLj3ZpabupAuCPPIndV+ZDkeyCWJDNAwUkj6D1SClxSJSDepraXga7l05t
         FLIQo4xLvckVPBYuiH4o4/DwmywqA/4BTstRp2/By7Ycx7LT+eCaSnbTVxRagXiTsuPE
         Mp3EXF/m+ecifQmad6snYUQScPU8FtXmnkQQIHljN+xa4D55rY4Mz+Sta+YVSAvk6uzL
         kSmdb6Oo50o6GtTmOw9CemBNeXGZeplFCn8vhaJVER3cX31MrZi7XR2wXi89HuVqUqlH
         HWoA==
X-Forwarded-Encrypted: i=1; AJvYcCU0kmEbEEnXPw5TiHxfwm9j4mMHJFX9hMExYItHFw2+PpD0WRegiRU33PBXUfbUf9rYmcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvZ+4Tpfq8KIPaB4SDhqoUCC+z0Ik1g02RGi6O/rYxj5LFIVu
	eH262xFO+RvEGpLOQfjSOa3CpXEP1UwEwv+wqTFmJPUysX5PT3a/sC3tMOIWeb7IYGTiusXYLCs
	XPb72yg8Mm/C2reZNXKiWknf/vm//jYc=
X-Gm-Gg: ASbGncvZHk4S6IHLXQ1mrIafqzG4j2Qk4WRTsRMtn5OsQEErt7vDBGrbELJ1MHeZFmt
	TG5RAswSVrqhXSjWycVCvvFoWS6PuFtnZV9P5r99Y69BAtWMrENhIphMlOKCoHhW9F/z+CSy4r3
	fr7mVRgkvAJve04CRKz2fJSRqyrXCK3HIrBEkP861ksdCFOHxAscHDdSVAyKfduz9WrPiQrV37
X-Google-Smtp-Source: AGHT+IEjkZuX9r2pXyLhBMe7J7twLa9tv1jBJmTjjxg8M7zObtx3NG5S26rQGWloPdJ9lHNfeCJ6lwrC7hrpx0EkKYc=
X-Received: by 2002:a05:6000:230e:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3a56870835emr899851f8f.45.1749776050582; Thu, 12 Jun 2025
 17:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612130835.2478649-1-eddyz87@gmail.com> <20250612130835.2478649-2-eddyz87@gmail.com>
 <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com>
 <1cd8ae804ef6c4b3682e040afea7554cb3bde2f8.camel@gmail.com> <CAEf4BzbSy_imqzs3Z+GAb1iA1WKs+vDkO1Q6pDmd3zzL-Ttzdg@mail.gmail.com>
In-Reply-To: <CAEf4BzbSy_imqzs3Z+GAb1iA1WKs+vDkO1Q6pDmd3zzL-Ttzdg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 17:53:59 -0700
X-Gm-Features: AX0GCFvafdOFRygc8KqbKY2XZpemqlfAEkz0Frsa8jR2jsEKC4Bu0weLPwmcKfA
Message-ID: <CAADnVQJxQMEdbdTrDSZyb+SWxdwjJYWx6F6jmkff=OAeEoSTPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: include verifier memory allocations
 in memcg statistics
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:18=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 12, 2025 at 5:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2025-06-12 at 17:05 -0700, Andrii Nakryiko wrote:
> >
> > [...]
> >
> > > We have a bunch of GFP_USER allocs as well, e.g. for instruction
> > > history and state hashmap. At least the former is very much
> > > interesting, so should we add __GFP_ACCOUNT to those as well?
> >
> > Thank you for pointing this out.
> > GFP_USER allocations are in 4 places in verifier.c:
> > 1. copy of state->jmp_history in copy_verifier_state
> > 2. realloc of state->jmp_history in push_jmp_history
> > 3. allocation of struct bpf_prog for every subprogram in jit_subprogram=
s
> > 4. env->explored_states fixed size array of list heads in bpf_check
> >
> > GFP_USER is not used in btf.c and log.c.
> >
> > Is there any reason to keep 1-4 as GFP_USER?
> > From gfp_types.h:
> >
> >   * %GFP_USER is for userspace allocations that also need to be directl=
y
> >   * accessibly by the kernel or hardware. It is typically used by hardw=
are
> >   * for buffers that are mapped to userspace (e.g. graphics) that hardw=
are
> >   * still must DMA to. cpuset limits are enforced for these allocations=
. a
> >
> > I assume for (3) this might be used for programs offloading (?),
> > but 1,2,4 are internal to verifier.
> >
> > Wdyt?
>
> Alexei might remember more details, but I think the thinking was that
> all these allocations are user-induced based on specific BPF program
> code, so at some point we were marking them as GFP_USER. But clearly
> this is inconsistent, so perhaps just unifying to GFP_KERNEL_ACCOUNT
> is a better way forward?

Beetlejuice.
1,2,4 can be converted to GFP_KERNEL_ACCOUNT,
since it's a temp memory for the purpose of verification.
3 should probably stay as GFP_USER, since it's a long term memory.
GFP_USER is more restrictive than GFP_KERNEL, since
it requires memory to be within cpuset limits set for the current task.
The pages allocated for user space needs should be GFP_USER.
One can argue that bpf prog is not accessed by any user task
and prog itself is more like kernel module, so GFP_KERNEL is fine,
but it will require a bigger code audit.

