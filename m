Return-Path: <bpf+bounces-22969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECCA86BC79
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395CB2875D6
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C68A38;
	Thu, 29 Feb 2024 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/9pn3Pj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDFE57E
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164971; cv=none; b=UaLcsi/k1sMPOBcAYOCtAsiY9sQjGRID5XP7mxqszQKjind8aFOqQuPenxFYCEbaxncP5aLcCkNh7f4yd9s2EFEivVeUD5BV//MhFFNhrmQsxurb8wK6WGYwqP0Gy2Er/7JCup2RnZQErWinnXp/PsZ7cqQCOMibjybJ8gX4L88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164971; c=relaxed/simple;
	bh=aP/Ftn65PpCtUI0VIBSTh3dvygMWrNmC6gxSaIZKoww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxJuYV8oxc122dKnz/HSa/tlINsMsDDNMJ1Dcbq4N92AdnKKe6kxUObg11klSJXa23ASIAFO/v7QoSAwdCUAJjCqIIf3ZsPv6v4GsYFem6CT/Jrmt9YzkMREnW3asDbHShh9nMmLDhUnIy2Lm1rtGpdEuOGXX7D2emFg5JHyDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/9pn3Pj; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3657dbe2008so2045985ab.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709164969; x=1709769769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz03nten6+vLEMc6xmIp62ZzX7pRR70vw5fFfgvS04E=;
        b=K/9pn3Pj/XHdBffKb3979LxUT5W5eQKDWDQRygJ04xR9IiHrmFihCi09oVsjfAeb5M
         GgL599MPMaD4v8qxbW63BFgFZxmUr19BlBq2/swqKEuxk+XPTdNOMa4ao5YobVvNx+Pr
         +kF8WnVn7ogvyd0pVezJVInwSeiE4Snvb5+wn7cajrPZRcMYDtlV1/7Z0WqsNJeU46Em
         nOMvhRzDYFNReT2uecrVGAI31LR09wt8f3IRhgRE4j63AoQIS/6DU4key7DS7TP8e4AK
         mz3tKZDsKrKDaBM1ZrsFgKT9n64mmzJUuKE07o17JpqC8Er1GJyUq59HJgMdshSHKiu2
         z2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164969; x=1709769769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vz03nten6+vLEMc6xmIp62ZzX7pRR70vw5fFfgvS04E=;
        b=OmjYmbIElYsq+pU959fXl+FKHevZ+CNammcw05lDFHb8gXuHwKeELgwaD80M1Tsic/
         gh66M7tgDFB68UrxD6UgKSbzEBfZQFDc2xGbqmukLqQ6DqsjWZyj3e1wsVTQ940rIihN
         T33mDwg+xzcW7ZIpVFLj9BPjQvwglJVkjkLbKy1W83MlJRjdXWllwmQYV3K2jV6Ab/aD
         Cp68ifxbgeCMlXWeYPhK8XwZM43CtRDTrouVCltsCenLbMwAL4S1QWLSzzcTXo4zPOEv
         Q/5Y0DJawt3SCwEKj/0HezIEvarNPnzmFPRKfSLmooGBZM5C+vS0/D9idNNjCwFWeSKp
         FOiA==
X-Gm-Message-State: AOJu0YyXS5EirerEX8Olg0JP30+A+51L8kT4urYBwX12s9NgDyhLJ1L1
	V79YecMeB2q7gjAtlmM4fqaUPAJx9T6xnlImwE3gn3jLZoL5TNI662uFtA50Uzp/tRZO4eA2ORU
	/SosSYNkrIR5pcsgezQatgI/byyQ=
X-Google-Smtp-Source: AGHT+IHvZUIy3YbEOdFOCMlJdUbOQF8ym6l6R5e2JiTOyDSQ4ncGjE7/8LbyPCOFoy/tysJtRRYx8eJ3K/ZPYUpD1MM=
X-Received: by 2002:a92:da06:0:b0:365:b56f:ff8 with SMTP id
 z6-20020a92da06000000b00365b56f0ff8mr936321ilm.15.1709164969501; Wed, 28 Feb
 2024 16:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-7-eddyz87@gmail.com>
 <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com> <d5fda01ecfac47e096e741a68ac8a1d2d726fc16.camel@gmail.com>
In-Reply-To: <d5fda01ecfac47e096e741a68ac8a1d2d726fc16.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 16:02:37 -0800
Message-ID: <CAEf4BzYRS-wd_FTi-_=1t9mjgMp3P6yrTqbkQ+359aKmcjZDNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 15:43 -0800, Andrii Nakryiko wrote:
> [...]
>
> > > +static void can_load_partial_object(void)
> > > +{
> > > +       DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> >
> > nit: prefer LIBBPF_OPTS() over DECLARE_LIBBPF_OPTS()
>
> Ok
>
> [...]
>
> > > +void serial_test_struct_ops_autocreate(void)
> >
> > same as in the previous patch, why serial?
>
> Because of the print callback hijacking.
> Also, what would happen when two tests would set struct_ops for same
> attachment point?

I'm not sure, Martin?

But if this is a problem, then perhaps it's best to combine all
struct_ops tests that use bpf_testmod into a single test as multiple
subtests. And this use non-serial overall test approach.

>
> [...]
>
> > > +SEC(".struct_ops.link")
> >
> > can you please also have a test where we use SEC("?.struct_ops.link")
> > which set autoload to false by default?
>
> As far as I understand, that would be a new behavior, currently '?'
> works only for programs. I'll add a separate patch to support this.
>

Yep, thanks!

> [...]

