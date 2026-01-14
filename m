Return-Path: <bpf+bounces-78792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F454D1BE28
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0209A3026ADB
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F452264AB;
	Wed, 14 Jan 2026 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N81vBgDO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F801B6527
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352767; cv=none; b=QoITi8AtNhc66j41CNI8TuNpx6xKar6aL0DXmWjofqWYCsmNpA0bOXsznoIr/lKsSGc98Hr61tUGv9N2bQVCimL237cz9W8f04LsRxWwk+MVj+OekvMlPTA/10qGGiQ92323QCbRtSHLjzDw+KVFDlKzJ9bEIjYzJakQzh2z8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352767; c=relaxed/simple;
	bh=F0MA++L1zSE6cZA/Gd+u1+s2DraR/NZOJLoDeRsNESw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQw4HPzYD99Cup9DMD2nHdJmuO4aHOKdaVlzgEcuQzINHq5YNqZyjiwRvyVhJNRctzSyx6iA1lfHyTwj2I0NnUGHX0PDJ3dc7noJF8bQIoynXrfD7WHR+XkH7fgPy+zYfiP4nKv3FFv+/wV8MbicGSkuTyjNH4gSuHw4eAUd7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N81vBgDO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so6462828a91.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768352765; x=1768957565; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c3zz/uR4XC6DTt4ifQZ0dcMHOsCy5LDTuF26jxx7ZX8=;
        b=N81vBgDOidwbWegdOLTzxZRlkJsuRzkf2m1Ac3RyTnuoid5sGLxIr8Kp/N6U+lX+9L
         gpYjaJIsFOHcjh3hXfIjkcVoZRaHkz3EHcr60ybtpC6kHCBG+FQeT+nmIagQOF75ZjrV
         S/0GIxlRNzM0qtuMy76aY9Mw8WgqwvB2gS23FGcuVBtrHxZljQ2tQ+bbW06VrK6u/0yW
         VoeY5pCZ1w7AKNKK2HHc3LmZVARxb3PGrwpml3BbTxtdTC6TusHyd5H7QvhLzuoDnqyQ
         Zy8s3+/RqlVjnIKkyKKXb+jOpb2g4gprhwM9yjO9ki96PEamrCw7C9X6Ma+QBShSPf+i
         D9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768352765; x=1768957565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3zz/uR4XC6DTt4ifQZ0dcMHOsCy5LDTuF26jxx7ZX8=;
        b=Xsp8MhF3DwOzGQJw3ODskflxOM+eGKOhYJApZGmHm3teuxUYOy9w8kHBksjaOX8atx
         ddGj81WUckFl5b9CjSiR2rBkY8LB8eNHqk8RUyZYiEniQSGuKc/ywT0dBjb1g+rDF1VJ
         B9af0V0hX9pBYTHzqXpQ3Gndgvqk7e987Gu4d/i3DPCbfcCJ8iT4YwoFYAxRS28uKQlw
         xCKdGPshTSbly5A/fGFtSlIZ84dllyQsN/pUqDjV2CU8watdn9ktPvDC50vZk3Ikbgek
         FAxacf/vLlyBiK6cfOoqEruyQhQsJwyStoaWq5gx7uKZ9MN0+Azj/bIi65GC49p4OrSh
         O4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG26bN6towpXWZtz0+BXGbdPYI3EXbEb34sjQxrruUc3vY3Gatf2Rfqenq3PW+yBg7y7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAquVK0P9CTxWwJX4FH23MOfg+O2TZoneY43iUPHVcJdgPrpF
	w9xpaDYKkW8FdDacYnF+RSkjJcjyPiOpZK2XTtNK+vegTcpNXVGHz7I1
X-Gm-Gg: AY/fxX7yd8H4rN91sOwr0R3G7a8nimnKxx+2Z59RVrC8kBRLVFkK1mRuB4i+2dv7GD6
	7rkdbQ891LH6C3VEp7EwB/Y1/cwUZTuO8IlJ+krUyclm79T6jwg7Zw6uEZWeWTLsWonIjfLf+Wg
	0UDpE6G2QDAMsKr50k+i4OV+rgd27aDGnxLAneM8VPRbhe3banEX3Gsf2PVpvMr0w7WtnFcficl
	vmEzIxI+Kw4wme+rwp+cwxxnvchE047zf20ABx0JT62JRHEeSe9pCZ6IzmZV0EOF2kdF4cj3pL4
	GPrwRtxWDef6NOFkD2GfpOm77gyNWmIK8MkT7gD4fCuOLJNnkAs/4L8rDVnlYdnK4LJ8//4B7JD
	Q4zgotmpunhXfWRaXIf5QWjmNwZBEoUQC/HWiqdsqbpBrDMDG07NXs6umzdbDj9zDpZfCef15yD
	yEKKUAKbyDL2stXI90jbOp+JnVi1VnVZTt01rPnAcT
X-Received: by 2002:a17:90b:3890:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-3510913e139mr874413a91.32.1768352765322;
        Tue, 13 Jan 2026 17:06:05 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-351099d0913sm322048a91.0.2026.01.13.17.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 17:06:04 -0800 (PST)
Message-ID: <5027595d4eff50d423af8ebc5fecd6a0f7229d60.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 17:06:02 -0800
In-Reply-To: <aff8eeed-414c-49b3-b7f0-c8c328ed5199@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
	 <18d9b15319bf8d71a3cd5b08239529505714dc96.camel@gmail.com>
	 <aff8eeed-414c-49b3-b7f0-c8c328ed5199@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 16:03 -0800, Ihor Solodrai wrote:
> On 1/13/26 1:59 PM, Eduard Zingerman wrote:
> > On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3271,6 +3271,38 @@ static struct btf *find_kfunc_desc_btf(struct =
bpf_verifier_env *env, s16 offset)
> > >  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
> > >  }
> > > =20
> > > +#define KF_IMPL_SUFFIX "_impl"
> > > +
> > > +static const struct btf_type *find_kfunc_impl_proto(struct bpf_verif=
ier_env *env,
> > > +						    struct btf *btf,
> > > +						    const char *func_name)
> > > +{
> > > +	char impl_name[KSYM_SYMBOL_LEN];
> >=20
> > Oh, as we discussed already, this should use env->tmp_str_buf.
>=20
> The env->tmp_str_buf size is smaller:
>=20
> 	#define TMP_STR_BUF_LEN 320
>=20
> *And* there is already a local char buffer of size KSYM_SYMBOL_LEN
> already in use in verifier.c:
>=20
> 	int bpf_check_attach_target(...) {
> 		bool prog_extension =3D prog->type =3D=3D BPF_PROG_TYPE_EXT;
> 		bool prog_tracing =3D prog->type =3D=3D BPF_PROG_TYPE_TRACING;
> 		char trace_symbol[KSYM_SYMBOL_LEN];
> 	[...]
>=20
> Since these are function names, the real limit is KSYM_SYMBOL_LEN,
> right?
>=20
> Sure >320 chars long kfunc name is unlikely, but technically possible.

320 is good enough, you'll be able to cover this:

kfunc_trace_long_descriptive_kernel_symbol_for_tracing_scheduler_memory_io_=
and_interrupt_paths_during_runtime_analysis_of_latency_throughput_and_resou=
rce_contention_on_large_scale_multiprocessor_linux_systems_using_bpf_and_kp=
robes_without_requiring_kernel_recompilation_or_system_restart_for_producti=
on_use_cases_v2x

But not this:

kfunc_trace_kernel_scheduler_and_memory_management_path_for_observing_task_=
lifecycle_events_context_switches_page_fault_handling_and_io_wait_states_wh=
ile_debugging_performance_regressions_on_large_multiprocessor_systems_runni=
ng_preemptible_linux_kernels_with_bpf_tracing_and_dynamic_instrumentation_e=
nabled_for_deep_visibility_into_runtime_behavior_and_latency_sensitive_code=
_paths_without_recompilation.

Should suffice, I think.

