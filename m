Return-Path: <bpf+bounces-38780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA696A13A
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D71C2401B
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5706156673;
	Tue,  3 Sep 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNi45Pn8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F7155742
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375195; cv=none; b=gj/frp5+cpJH4Leoxz2dlbrVU75fNjRCHbtI9pZylqFfLRkjexQjfL+Y5/9Y/K65oDuTotNRA3zLtlqma98FTFmDw9DzDE4BZs+gafZylP+XiOnmd45N3slveQ8IK/muJC0qR+pkCdMvtPJVgZ6dd7MU27cS0rY2EJYhrlVUPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375195; c=relaxed/simple;
	bh=WRQQsYTFPIqdfljpnFqsqwxecCmVr7UiZUlJ8Kg/zA4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uauqQjHssC7HTIQLIkEAnA66xW/k057U/bD+sz7BeHvk91nz2pCXqfX7IhBuCiXQIlOph6WcpXkDtFRDbX/7vVemo0unNJFTa7K9TUV7wGYwSBVX0x9pDBt9Tz80G9+jdRrLmC0keFzCrKIpxI95M+85otMlUso831wcWAiu1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNi45Pn8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso44628745e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725375192; x=1725979992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1Xju45l3tjrY5pPxr4JJ9alU7u1o74hSY9OtQR6Nq4=;
        b=KNi45Pn8+F+52jc+hfrD8n4hize44tOcJRnGKt1hsfvzyQGs+Qd9zwskLQL7zXcghW
         YiwtstMnCOADpSYFPUfCUrUslNwEnTDsSbsGgl4ApxPLvJPZ/LuCLAY5DKjsmPvhbsoi
         beBAiekAplZn5kLbga8EWfnQJnCpEDXaUYtcP+cjI5GKMtZszzPHyN0IhYk34MMweH2b
         2/afoRQothVoNCCavtMh+8dtNRqthUnLIN9pkA+ImatSerpn5rKvkuq7e+F7t8wQMxi4
         eUDqGr7EftNO69oUuvSV1DVOxxvLwXYGFU0Q9/+/TQpHq192o+Qjs3P+2SwpBWXwfSTL
         AY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375192; x=1725979992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1Xju45l3tjrY5pPxr4JJ9alU7u1o74hSY9OtQR6Nq4=;
        b=P2MvBfSg1dRv76DJlO0pzKUFDcfN92qOCFpQaQkok9vd2Oqnq5TVyMGWTE25dOJE3Q
         u9u3qibmOd8+wyXUGl9qSsaWfixFv0eeLplVoV7mlv7CWn/lhBFcm+NcPXOHrxs+YUzH
         Sdb4E2fq4on4vKjTt7a8US7OJnf2ELFVjqcPJoL95cfWr0nUxLpp7+jLiMei2Ckv2/fT
         i2dvsXwGdK8jcv4XpALlR3EionzabJMcVMqf/BjUEhAXtTcgiXN3Qy6trMSm+Z/A39Tb
         sZ52IIut+QPNAqIrUiV1Igp/gbKYCYlzZb0rYZ9tWXwpCn0Rok17GK/YrnHJ+G4ZbJWP
         zm0g==
X-Forwarded-Encrypted: i=1; AJvYcCXLGT4/NXoF2yQSB/gEdvn3YcIQxjYG17TEdYhzFalQFoufLghM1z56WZlCkN7xe9yt84s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNRYJYs08HZGxs39VsEyDgkL+yYCukk6yQpUwO0s7dr1XErv6
	4xFyr0JA5FmheRypu9F92CG/mNhAMOFmyR+UC2XDhMO8xX8oBe8U
X-Google-Smtp-Source: AGHT+IFw0pJJw4UTqLzSVcBofCxq99iGtkW8Dl0/puY6lYEumm8nnfiH2WSfbkVSubwfz7SX2tEyVA==
X-Received: by 2002:a05:600c:1e09:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-42bbb436e04mr90236095e9.24.1725375191598;
        Tue, 03 Sep 2024 07:53:11 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273bcsm172907745e9.31.2024.09.03.07.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:53:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Sep 2024 17:53:08 +0300
To: Viktor Malik <vmalik@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC bpf-next 1/3] libbpf: Support aliased symbols in linker
Message-ID: <Ztci1L3aWX_zGsER@krava>
References: <cover.1725016029.git.vmalik@redhat.com>
 <87e9970b63dede4a19ec62ec572e224eecc26fa3.1725016029.git.vmalik@redhat.com>
 <ZtbwBA8CG8s--8dt@krava>
 <19327b3c-efe0-4242-a8bc-5ede33570cf9@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19327b3c-efe0-4242-a8bc-5ede33570cf9@redhat.com>

On Tue, Sep 03, 2024 at 03:08:25PM +0200, Viktor Malik wrote:
> On 9/3/24 13:16, Jiri Olsa wrote:
> > On Mon, Sep 02, 2024 at 08:58:01AM +0200, Viktor Malik wrote:
> >> It is possible to create multiple BPF programs sharing the same
> >> instructions using the compiler `__attribute__((alias("...")))`:
> >>
> >>     int BPF_PROG(prog)
> >>     {
> >>         [...]
> >>     }
> >>     int prog_alias() __attribute__((alias("prog")));
> >>
> >> This may be convenient when creating multiple programs with the same
> >> instruction set attached to different events (such as bpftrace does).
> >>
> >> One problem in this situation is that Clang doesn't generate a BTF entry
> >> for `prog_alias` which makes libbpf linker fail when processing such a
> >> BPF object.
> > 
> > this might not solve all the issues, but could we change pahole to
> > generate BTF FUNC for alias function symbols?
> 
> I don't think that would work here. First, we don't usually run pahole
> when building BPF objects, it's Clang which generates BTF for the "bpf"
> target directly. Second, AFAIK, pahole converts DWARF to BTF and
> compilers don't generate DWARF entries for alias function symbols either.

ah ok, sry I misunderstood the purpose.. it's about the bpf code
generated in bpftrace

jirka

