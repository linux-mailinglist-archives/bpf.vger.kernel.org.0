Return-Path: <bpf+bounces-45224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C58139D2ECA
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 20:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC5CB28A69
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 19:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454691D1729;
	Tue, 19 Nov 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NThIaAIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6C1448F2
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043820; cv=none; b=sHwZ+/4d7+GIc6EMZstisk3vwfXSCg1yuVB+o9Que0frQDuBsnLNswGInKyrBZxkz61rZA1fCXTKSvdX+il9mOxYbVXFC6ankV9L56yIZhCngt++QIFF+FgGKGCnE/MQXzw7U/ASZmF/NVw57Avzu5iHIUy81Xw1X3vCJTe+nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043820; c=relaxed/simple;
	bh=sp06ODnnvoKvR7J2Tbl5/pwiUYGmM2D6lPTlEdPibCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiGFUwOEZ54sCC5jcUXxzx4L2zOMPVN92bph3G1iFHGt+S9ovEbQkdnVu3sUKX4yGfeVyudWWmjsN1hsXBI5Ax5oBBZIAaNHIFQRoS/IXB0Hin+fAtb33P9cUKG5JEU6b2XcIHWBrk1wGw8MIjZId+e6doZYrcs10qDDb9dtQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NThIaAIp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so3696684a91.3
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732043819; x=1732648619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpgUUXSXr5U3+nq4G1ZbLzC5xWINFHd7OynoAjh1DrA=;
        b=NThIaAIpplto8FvCCNYletJsPcProaccLzhCtOoreKczg6hODmBJ48yuqJuQbeYgoY
         tOo22BTCmfZY+d2uApaICn9KigO3sjuvFO0YB1NEeX5u7IDh3T8QVg6xyL3Jq+N+SKHb
         HXmIr1YHm02gA5unXZRqYq+QAAC33SEt7yGgV4FBhF4I3paTV9ZL6VzG7mQo/QOj1ckv
         rXIwUkdXgNPU0JJn2bJp7CWayYK6jx40fPNZ7+qqRd4Ays971gNamWDqvHIHW6c0sNaa
         pAQIN4cdvs4MlIpGoHCcZz5mP1hbzYZ68KSZDJGp21icDnplJqVSWPYcDCrImqg0Qjex
         qDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732043819; x=1732648619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpgUUXSXr5U3+nq4G1ZbLzC5xWINFHd7OynoAjh1DrA=;
        b=THhKP/rzbgq3idD1yXv/Hz5HLnTSbXadri7erU8ie+5nG9Sy87u/FvpPTWTUn/oizu
         IN1gNEsF6MZVwNaFNSZXX3lQh3RhoJdhSSD3NrzVi0qqL5oIcYaEPDnsxaeXnefbwl2f
         ApwhjKHSXt7kWa/ol4QP+KfJ5L7WgYWBJ3De8QGELjEqwukZ6aWqBpRUfdQGu52Zznqk
         NzckEcdE7Gy7LvLOZXBlANE418lpMEtfETi+csnZEAnbEBsaE34pdi6CuEjmjFvaJ2Pi
         SpicL0mCXJ7OX7T1Y2kjkIi8nV+Fnim53ZYid7btFkJRSq5zYWnT3GZk6dWzKqmCN6n0
         AlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTBKBBgy53zT8PwSREa4kyE8TfkarTdIZ/UuEfXZRvOnwomYe8XnxlWT9OIPWXdGyc8WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfELQa/3qOxD0xQh2+ORyX4aHIWvPPcdr3Q2aCKspcbMv4pdi
	6kPw4t8Gr+nT9xhcmXN9ocLony3U9G6zkq8NSUENR+4ITK5fuBGcjgu9ChAgErd7Yw/tGrmSMzd
	s18jUXU+uusLp273xS0lKp9PkfDQ=
X-Google-Smtp-Source: AGHT+IGVQiYiWRxAhZbv0ycFxA4n1L4hcZgGIBdJKKFNBTD1cjhP6zhlPufUbUmQlpclVhSnlcHGDhZUdg4FzVT5irM=
X-Received: by 2002:a17:90b:4c50:b0:2ea:79c6:8d2f with SMTP id
 98e67ed59e1d1-2ea79c68f64mr9150596a91.11.1732043818560; Tue, 19 Nov 2024
 11:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118185245.1065000-1-vadfed@meta.com> <20241118185245.1065000-2-vadfed@meta.com>
 <20241119111809.GB2328@noisy.programming.kicks-ass.net> <bade75b3-92d2-42e8-aede-f7a361b491a9@linux.dev>
 <20241119161753.GA28920@noisy.programming.kicks-ass.net> <6d525549-b623-4292-b700-ee94eb313eb1@linux.dev>
In-Reply-To: <6d525549-b623-4292-b700-ee94eb313eb1@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Nov 2024 11:16:46 -0800
Message-ID: <CAEf4BzbK5JS6dXxOcXJ344KE1mDcH-sHKX+b+U8k_9FyQ4jW6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>, x86@kernel.org, 
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 10:03=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 19/11/2024 08:17, Peter Zijlstra wrote:
> > On Tue, Nov 19, 2024 at 06:29:09AM -0800, Vadim Fedorenko wrote:
> >> On 19/11/2024 03:18, Peter Zijlstra wrote:
> >>> On Mon, Nov 18, 2024 at 10:52:42AM -0800, Vadim Fedorenko wrote:
> >>>> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, =
int *addrs, u8 *image,
> >>>>                            if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC=
_CALL) {
> >>>>                                    int err;
> >>>> +                          if (imm32 =3D=3D BPF_CALL_IMM(bpf_get_cpu=
_cycles)) {
> >>>> +                                  if (cpu_feature_enabled(X86_FEATU=
RE_LFENCE_RDTSC))
> >>>> +                                          EMIT3(0x0F, 0xAE, 0xE8);
> >>>> +                                  EMIT2(0x0F, 0x31);
> >>>> +                                  break;
> >>>> +                          }
> >>>
> >>> TSC !=3D cycles. Naming is bad.
> >>
> >> Any suggestions?
> >>
> >> JIT for other architectures will come after this one is merged and som=
e
> >> of them will be using cycles, so not too far away form the truth..
> >
> > bpf_get_time_stamp() ?
> > bpf_get_counter() ?
>
> Well, we have already been somewhere nearby these names [1].
>
> [1]
> https://lore.kernel.org/bpf/CAEf4BzaBNNCYaf9a4oHsB2AzYyc6JCWXpHx6jk22Btv=
=3DUAgX4A@mail.gmail.com/
>
> bpf_get_time_stamp() doesn't really explain that the actual timestamp
> will be provided by CPU hardware.
> bpf_get_counter() is again too general, doesn't provide any information
> about what type of counter will be returned. The more specific name,
> bpf_get_cycles_counter(), was also discussed in v3 (accidentally, it
> didn't reach mailing list). The quote of feedback from Andrii is:
>
>    Bikeshedding time, but let's be consistently slightly verbose, but
>    readable. Give nwe have bpf_get_cpu_cycles_counter (which maybe we
>    should shorten to "bpf_get_cpu_cycles()"), we should call this
>    something like "bpf_cpu_cycles_to_ns()".
>
> It might make a bit more sense to name it bpf_get_cpu_counter(), but it
> still looks too general.
>
> Honestly, I'm not a fan of renaming functions once again, I would let
> Andrii to vote for naming.

Let's go with bpf_get_cpu_time_counter() and bpf_cpu_time_counter_to_ns().

