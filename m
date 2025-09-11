Return-Path: <bpf+bounces-68191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5192B53DC6
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 23:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628DF16C967
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640D12D0639;
	Thu, 11 Sep 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu3GBJqk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102D27462
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626385; cv=none; b=LZsjbcEW2rT/ClwW6K3yCUpQOJqHhipKM4JL6Hw6f6CVL+pXEn7Nb0IqLWV0iEyq8swv752yF+vfDP9YJRbKq8W7a41hauSZEUt3wN+NKG3oVHbDcW1xUsDWYio+uzgnGzyrI81p8RRxnysbTeuvMP1B1kaKhPDDAjbHA1vE+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626385; c=relaxed/simple;
	bh=mMDuOdMBXJA5N9wowbNH/bb0hca66+v5IblIkJk+Az4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYgJiYw6mdZ0r0VemHBu6FXrP5LsW5fjpjU7JHmgr3j/YZcVrEmLBozyLjPupBfUpOuIhXLJ7YRBU6SJeI8mE/CbgA7djuMwA4acEos2e5ql9RWdTb1z2gkeXbj/M1cESO1a1pblhKfmkkAdR3I47n/cjSbjsRY9V35g4nJCPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu3GBJqk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dad6252eacso522317f8f.1
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626382; x=1758231182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqdp8b7vRe4NMLG+7lZHLpyTlOK3FilBcAjAkt/pIEE=;
        b=Eu3GBJqkwqvyW4s9aSiNECfM3aITskNLlrtWjxR02NmxEibndwbZqvw/L71F8Uu1AJ
         8jnGWPlTee+boNXSnjfRLgYJ4fd+lyLc2SskOzHPT6nEpnTnBAaRYtJAhUA5AqLm0zjV
         wshANAPRl9IC+TfdCAfZhI8Qey7/4qh4XVy5YQxrOVMoe7uVKNt+Fh2Z0qC9Pw+54svd
         ZHKHO4fXCRsOpA8F7w2bfuMB/niDlcvZtEs7rQr7pRXsf9YslkD6IGh64oDf46foWUXD
         YN0MAFN/XOtLAa5iNoJ/Y9Zd04gj5sAmVy8u42ujKjrQc0sKzeMnbtO8zkfHs/CEtum9
         lCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626382; x=1758231182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xqdp8b7vRe4NMLG+7lZHLpyTlOK3FilBcAjAkt/pIEE=;
        b=v+tTk/Ol0BuvREi5EyhAACOMAaEOmN0n9buc3QWPhC2MmLmbaqmlHkPiRKoaO7p3lA
         TuWxbxwCuE4CYMN9iDD0sINV63F0sVH7mxzadMz91IB9zViZIHGpbaH6guUrvzvZOSGS
         yPt06+KgDL+i1Iue5Ctww+xXjsFk+8nKbrmrykP4Ip36JxwfsTSzGGs75shlpFmzUTtO
         vSe6x49WQTXSjqRxBfebmT1kGb3BV1TaFR1xc9IUlYZGcx0Uom+hBh+QmdlZcV1zSmz5
         kdPEGPK29ahV7+oozAAiXdX5pQSogRxLLpONLPZJPvI+rtD51STXEZr6eMJ7Ik+bdBrH
         qQ3w==
X-Gm-Message-State: AOJu0Yy4hBPCSaNoeG1EVpGiUES3xh+gppZp5mOCHhih3BOR0e4OMOKW
	RCc8fRMxvC/EGFFgFRtWL33VjhoKWB6RlBQ0b/L5mioKeh2+1hXB2iCh2F4ry8mp9wWe9eJBhi9
	Zg2MU30X9/Je+6xBMLNq1m4CH6Oi4Ibair7yJ
X-Gm-Gg: ASbGncux/zN56UrBTKNuQIRyq6FMrfacAo+ZrAk6nQ4ih2pJcthzN/YsnvshnBzxsjA
	t+Xar0K/Y1qp+/kpX9DGkG2UxTy4AjzikgaQGzpj9i3MOmwBRG1LJFMB+zUpJAqWCwdEUoH9f9i
	wqyrzPolPrCQ02/aWkgsV42Vxm4rqVe4cl4gYcjqPPSqugU4LAqs2/C1MBtnMVV8vapMNYdaHhr
	0ohx7aGj1Bo/nuDsM6WwMHjTJ8dxA1yaKle6VxN4z5d+Pw=
X-Google-Smtp-Source: AGHT+IEsTZhqIAETiX1/HroXPvnZ19frZVS3yVp6BcOp19BbAO5KYqAXya5CiuZvvKJCc+LT8q9S8X3w9CmgXZKMry0=
X-Received: by 2002:a5d:588a:0:b0:3e0:c28a:abdb with SMTP id
 ffacd0b85a97d-3e765a0b156mr653851f8f.61.1757626382304; Thu, 11 Sep 2025
 14:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQLcMi5YQhZKsU4z3S2uVUAGu_62C33G2Zx_ruG3uXa-Ug@mail.gmail.com>
 <35d7e2b8-c090-46fc-8f45-b976ffbd5dce@kernel.org>
In-Reply-To: <35d7e2b8-c090-46fc-8f45-b976ffbd5dce@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 14:32:50 -0700
X-Gm-Features: AS18NWB9xGKpMJWg8fzKJXCMm58Oh_xjFA1piCC6q0Zz3Y95IvSWgK9l5aoqqx0
Message-ID: <CAADnVQL=FE0veZUFuHnwfyNix8_yU8x4_3QdtSp85G6mfYTgxA@mail.gmail.com>
Subject: Re: bpftool uses wrong order of tracefs search
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:03=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2025-09-11 10:27 UTC-0700 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
> > Hi Quentin,
> >
> > since last merge window bpftool triggers a warn:
> > $ bpftool prog tracelog
> > [   72.942082] NOTICE: Automounting of tracing to debugfs is
> > deprecated and will be removed in 2030
> >
> >
> > I suspect it happens because get_tracefs_pipe()
> > accesses debug/tracing first which causes automnount
> > and triggers this warning.
> >
> > Pls take a look.
>
>
> Hi Alexei, sure, I'll look into it.
>
> I haven't tested yet, but the check on /sys/kernel/debug/tracing is
> likely to be the cause indeed. If that's the case, would that be OK to
> move it to the end of the "known_mnts" list in the function? Or do you
> prefer to avoid the warning completely, even at the cost of missing the
> tracefs on older systems?

Older kernels won't have this warn.
Also I don't know what these are:
                "/tracing",
                "/trace",
I think the fix would be to do:
"/sys/kernel/tracing",
"/sys/kernel/debug/tracing",

