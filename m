Return-Path: <bpf+bounces-42682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E07F9A91CF
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB06628414A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97831E1A18;
	Mon, 21 Oct 2024 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEX9dUqW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6561C7B63
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545209; cv=none; b=UkRb+E7ahgnjWlcZaXY4amyeDwB25OQQkeuIna28ioqCMXEHBlQJwQOF2lqrqClkfsLftker9vF1f7GhfJClkbs8lLtlJdzQzM0tsANjnaYTf9nL66WRJD3aFDlIEDgZJ044foXWEECBaEnqfre7MI8QuHqeWEWPUnjZ1aMK4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545209; c=relaxed/simple;
	bh=kmmcMBKcrX0tIEnjkXOrjjaLyJTuDIkQch+2LA/tfTs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXf3Lxhcft8qco9ryPY1wJKCPOFgkFnjQw5lVo8dC2coHKbmcbJQRzHeRXduRblBl9KD9ZiZeJzfXZm9LEX9iL7cIkLV7zKShiWRLnrCdAGp0wuSojuRyOYS87y8aIkm1CXNYRiXhfKHHsz0Wcr7e0ntwf9fjyM5aE8uz+9eXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEX9dUqW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso10044510a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729545205; x=1730150005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFBvPTaFABPO0AijNmK7s472O+WqCprQ8s4EfvXjaZI=;
        b=EEX9dUqWXBb+r2uskvopshQph+EiFbIg06iLfqyu8tLusuXdKlMcSYiaKgfKqKXSnm
         cDigA93P26Pj5CHPbJi6B5b8kJNZTHcIuycojYj8XiN/Klu1E/3wGxweWMXRlWZTF+sQ
         Ky2lLDVcVTpjTzex70xMjiexbwEHydundJmk++furkk0E6YlBWJv9dMkryHXcs086ghF
         6S4bgZLllnhjAm6uHwSuKErI8GiNSklPanOTvhGQXBC3kHg+4InPgABrPiT93kEfeI4W
         DATBtrTcLrYoRWn0moLKWvhpaYChigPpjzGwBCOScqhGT4EXCcZvyNBe/GOG2uZGefcx
         dPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545205; x=1730150005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFBvPTaFABPO0AijNmK7s472O+WqCprQ8s4EfvXjaZI=;
        b=T0P6oaN/pBF5gIOnmFqDrHMD4SytFw+9Ih1/ikPF0f6f6YIhKIcOjXJDsU+Fdql1AP
         AZnCmu1XGhSfYk1olR252rCe0Y/++3IhqhY1ns1Z5fRu4HHjzkmPdzkkCBoSKOHwj0+S
         Q1lqqmjgOTQkXjQG5UStrLw5JmpGVWSccxPUpzp1I87oqhyLGT2bwahKxhcPs/A0E3po
         PXdPfYeKglR1IakN1K8Bty2M1zOVoHEQ2mr4BS15MbWmLuepLsuEifXLyEh1C0ZYp+c0
         6xMbUHozVsPgOdjJKSl31okeF69+FsmbLd3qYyf1SXxcQQQ5lFWNOr8uHV8ZrOJAkFXl
         /VJg==
X-Forwarded-Encrypted: i=1; AJvYcCViVntEaRvih//7iKnB2f+9dbBbt6PI0Y+jOGx1yJQMfIjC2hakn12PLfDPtEjRhVcAwII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2OaX02pj1tWP+BmniiAfYwvWpFaR1ODln+0zzFFu8wmtAD7s
	kju/kmdLqllp1ZWoGYRKUTEp2ApTxRhLp1R+qnIlGQY930CDhBUX
X-Google-Smtp-Source: AGHT+IGd/1pfOeJmQ4kdnkzJleMGnVMvQeSFEJRzMVIBUBEs0ge088uupgNM8MCBezU8EM1+8V/yXg==
X-Received: by 2002:a05:6402:270c:b0:5c9:813a:b1c1 with SMTP id 4fb4d7f45d1cf-5cb7944cd65mr1084395a12.1.1729545204485;
        Mon, 21 Oct 2024 14:13:24 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb675eb1bdsm2321059a12.10.2024.10.21.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:13:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 23:13:21 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v6 8/9] selftests/bpf: Add tracing prog private
 stack tests
Message-ID: <ZxbD8dfC5ucuUQRb@krava>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191431.2108197-1-yonghong.song@linux.dev>
 <ZxV9KUHDcRPC5s9_@krava>
 <2b304d79-80a7-4366-8267-7e3d724f6e86@linux.dev>
 <ZxYvkmP39zbCUGwd@krava>
 <72039787-a0a6-470c-8610-a813f12d2223@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72039787-a0a6-470c-8610-a813f12d2223@linux.dev>

On Mon, Oct 21, 2024 at 09:19:57AM -0700, Yonghong Song wrote:

SNIP

> > > In my system, the gcc version is 13.1. So there is no need to explicitly add
> > > CONFIG_X86_KERNEL_IBT to the selftests/bpf/config.x86_64 file.
> > I had to enable it manualy for gcc 13.3.1
> 
> IIUC, the ci config is generated based on config + config.x86_64 + config.vm
> in tools/testing/selftests/bpf directory.
> 
> In my case .config is generated from config + config.x86_64 + config.vm
> With my local gcc 11.5, I did
>    make olddefconfig
> and I see CONFIG_X86_KERNEL_IBT=y is set.
> 
> Maybe your base config is a little bit different from what ci used.
> My local config is based on ci config + some more e.g. enabling KASAN etc.
> 
> Could you debug a little more on why CONFIG_X86_KERNEL_IBT not enabled
> by default in your case? For

ok, I think I disabled that manually

> 
> config X86_KERNEL_IBT
>         prompt "Indirect Branch Tracking"
>         def_bool y
>         depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
>         # https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
>         depends on !LD_IS_LLD || LLD_VERSION >= 140000
>         select OBJTOOL
>         select X86_CET
> 
> default is 'y' so if all dependencies are met, CONFIG_X86_KERNEL_IBT
> is supposed to be on by default.

ah right, that should work then.. thanks for the details

jirka

