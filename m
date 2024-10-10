Return-Path: <bpf+bounces-41659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33043999577
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBC3286289
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40A1E4121;
	Thu, 10 Oct 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxVlRfRz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB714D6F9
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600744; cv=none; b=dTffGLs6t9NnJobPM8UYWstZMiu8CVTqBYOlS+khrCpjjEZgfoPaky+MWNErU4b3eiTTAodY59qnn3XUEtEWTrZriTNT+65cn2paLpb29I8B+RQCGTrNWll0OtzhvSCNsm1UN08zs48L9/7Qdtv5gsh4pDU59HpGiWlbkD7ITcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600744; c=relaxed/simple;
	bh=P43YRNXAcxh2dC9FT5t+GWisSaerqjMZsScOLTwENag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYRgJXu9twne1356/yb4ozeB83OJaGnwl3wT8rooZeME5LIOCLTwa3FeT7Pk/LA6DlBWt3RTqewwPiq/Lj/nFCu6pccb3p73FhW4pSGkNzoSfIJLySiMuxUbv7W0uGEzwbUJRWehV2TFnRB042NlmhQSY2D+BSKQmnqBDv4Gd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxVlRfRz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e3296e273so609513b3a.3
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728600743; x=1729205543; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P43YRNXAcxh2dC9FT5t+GWisSaerqjMZsScOLTwENag=;
        b=DxVlRfRzc9+XVMUwIXFvRjYrLkpT8fUyeLFe5bKOMwVQqbN26kCt9Yt+FW15VDtsHf
         0hchVnSPGSzIKhU1WyjFwpHsv7m8+hUZwUSJ/M1LZp24FRVic7S+5lTUttR3WbRfG1nh
         v4qiZgWN11HX7AMXrvLsA0MRKl8gImQ92IIAnfpAavftcbF+idkWmu0WmnfL1pzJDGr+
         MqpwNc6i3olglvarFdHJf5k0jTic9kzxDxVjVrEsDemQrvj9vYydnhy8sdrw7DimdScc
         qZOjxBXwCbiNLXRGoyY+CDmOVKZ1xCPt8RZafk+2MoVmfzVGhbYY3T/dN0cw5K9S4AEn
         WX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728600743; x=1729205543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P43YRNXAcxh2dC9FT5t+GWisSaerqjMZsScOLTwENag=;
        b=Z3/dG2AoSSLC1xaMUl5NpN7J3MREL1yS6eTJ9DHMuxXGLozDHFfmFE4D0QoiuafHiP
         w6ntF94O/6u0SbGLSrEb51ygqJtvq64fIkgkgjas+JdrQbubxEOo2+/utX1zQqZvsqjf
         gIG3eCPsWXZ36xE6dg0vj+nFf0I6Zff6AYnknLiPScdOdUgBx8yYvOUCm9fLmUEXJmgX
         Csu1rVfbCWQfltOJDHnQ8FOecS9XeVqiVtZGMf9SjzjPD3cMKN0OhhFiW7kRn3VBlQrU
         qYhfgkCZzfmYWnE3+Z93mFNus4b649lG4izqoHp0YxB5kRlgNdyWQT2SW9RwLTJ+Zovi
         uPfw==
X-Gm-Message-State: AOJu0Yxs0xGaA4JRRrGBFRSWUoQ0mICFBMFluhvEPf9Acx+htlbmb6Fn
	3AGpMT+wvqEyrFc1h9X90GYzcOvWS2ixhVHJeovaebZ+nJ5hB/Zx
X-Google-Smtp-Source: AGHT+IHCSmgKZ82xVcpJON5RLkFxNvFih+RrGz+S8A5FTJBYYTmQtqUZPZiQZA+B5wBi3F2sjW66kw==
X-Received: by 2002:a05:6a00:b55:b0:71e:ed6:1cb2 with SMTP id d2e1a72fcca58-71e380985a6mr849448b3a.20.1728600742787;
        Thu, 10 Oct 2024 15:52:22 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:b5a8:9248:40d3:6020? ([2620:10d:c090:600::1:770c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e9790sm1545564b3a.26.2024.10.10.15.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:52:22 -0700 (PDT)
Message-ID: <be3d3c31438727096c9bc79f6761865574477a71.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop
 back-edges
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 10 Oct 2024 15:52:19 -0700
In-Reply-To: <5c4eca8da640c4be42edca1fc3ffcd0650f69b08.camel@gmail.com>
References: <20241009021254.2805446-1-eddyz87@gmail.com>
	 <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
	 <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
	 <CAEf4BzZf1qr-ukaSHkv=pgCfEN5LQER7b4EovUM-TVtdwgJrZw@mail.gmail.com>
	 <5c4eca8da640c4be42edca1fc3ffcd0650f69b08.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 15:40 -0700, Eduard Zingerman wrote:

> I think this would bring significant speedup.
> Not sure it would completely fix the issue at hand,
> as mark_chain_precision() walks like 100 instructions back on each
> iteration of the loop, but it might be a step in the right direction.

In theory, we can do mark_chain_precision() lazily:
- mark that certain registers need precision for an instruction;
- wait till next checkpoint is created;
- do the walk for marked registers.

This should be simpler to implement on top of what Andrii suggests.

[...]

