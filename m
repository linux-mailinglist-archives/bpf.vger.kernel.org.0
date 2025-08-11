Return-Path: <bpf+bounces-65384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD9B21660
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2137A1904315
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4432D9EEC;
	Mon, 11 Aug 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1EFgn95"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D187311C13
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943890; cv=none; b=ZzV0ZYPYwk0k/9KAb9I6eYUjr4xROs8z1qSaiBKFnm8nLNaUmQzuS5QGrytGmhdH8mkrHaO5N5EOctEXAQHOQg52KOksNHoF1UPqcIqAmCiuxDa5TcIO+Yh/o/ek+xrLiOKqN9NvXLACPJiP2qfkyIDO4WcpiBUPbW7fG6jux6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943890; c=relaxed/simple;
	bh=9p7gS9riHUjxw+wCr6oM6UjZJ5CNzJIQb2CJdryhGIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLufE9ra+8mEx4Ydkm1VGLIht/cef6Wr7m7xlUJX4bof0Q+ilkxN9N47dd8r87p4fVGqEM8q0+6tacZ3Ki7BjPgIlqMtvKirRkxzhTdo/mWVrENOs+BThUqFIMmEAb9o6cQ3go/OU8kwKSWHpY2HdW9BfBGDYPcVPuL0TGKVOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1EFgn95; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-af97c0290dcso839726066b.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943887; x=1755548687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/Tf6fpIt1GEC1WByx8xdQD3O1S0eNbduyPAQG4IzuQ=;
        b=Q1EFgn95lKz0PyD1yjhEODQhgDWbvBIC0h2PtZWi8cnI/bOrcOEjLmD+qRrNGYmzDd
         MTklLbaYr8vMN4R39J5TPP2jR+7KmQI+q6CshCTehvdQWkKXxFPjkluk7SxS7YAaImce
         KC63eDU05Up/7gW7Yolntgm5I78P0by+Fs45D7Tuv/vNVarjuKLIj7aY34dmDm5VFe2q
         dsDJA+Yuswb18lZTsVaPtUQcCcHuUU6ymZExyPQmVbXJTJxZD3yBT/UnMgj+KfRcKIMQ
         CGRaBqvt8M/kkeyzanXeRP+K3EH2rzVfoyo5KajOhgNoMtE2Cf091fL5EWZQDVjNeiAF
         gqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943887; x=1755548687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/Tf6fpIt1GEC1WByx8xdQD3O1S0eNbduyPAQG4IzuQ=;
        b=tyXJYvHmU7wKlpRf0uLdcc0HUY1WpviUUx5a4kFR2jOfOCcDXk/5mMXEKtZ6cCc7Hu
         fFTRWQ7Ju+ra6jAS5QaFuW52vbriWZ6JRKB1KVJ3iFLo/sHYxzShII52qXyS/5zquS7U
         N4wCNlaoqyBAEVpUr1L5Zy90lR1PcQUHKXVv8mu7pQ4C4rTaUHU3TBRBFhNeN+JM4xvO
         wcLaZjn11Nbfg17vEuq9qvANRbhugRwNLAi+XR/Ll/1ciU1ix+RKYOyy1m9EQYQdVP4G
         j0CeYcHtQysSzM4N6egIbEqPlL9XzYCAl3/C9QF1xh4l/rp/3xziuPSqG2cZaC60TF8i
         rETg==
X-Forwarded-Encrypted: i=1; AJvYcCW1qqJ0u+gOToplm/XPgSEcWuYluZeSv/wLhOlnHzBZs6t8srcsYv08WtUz57p+v6jkL4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JlxqTO/PRLQtz5lHnRgZ7BvA1eY6xRDLkj8NVQ96MRe+tLnh
	4lVBm4tG7sq/2Rero//tf8TuP0dLCftUi8an9r6TXq96vMGesIk2lOTLJi8yzMBefSFGXdLQjjr
	ec+1MUKBy23eGV0diVaHWUIurysakBbU=
X-Gm-Gg: ASbGncvBQlzg0CixjHyXe52DeI07/JiqY23yW5qe2gnb8PHbOKmsZ2jgS2zspAxftSn
	sZRDw1cRPg4sj5E+66Vb0YWDg+UOdcXxANz6t4rH330HwTEMFOOKQvyFiKgXZC/7Wj3QC5he5eE
	V0JY/scCndxjhG3MgISeJvUOdsekdliDFjKFTYFt2PlioIRFwGWJteRCLvZaTtHxkzUJ4mqQbYr
	0VcttSlwpNDS9e/j23EJEDpayApJPRzRQGZjEJN
X-Google-Smtp-Source: AGHT+IF7wnd/NXyUcLbTs/7RYhdXzERgTdA63pD0KEYZHyAs87ygE12yTYaQjEGlVsoteymfjXlzP1glxwv95tHvLw0=
X-Received: by 2002:a17:907:980d:b0:aeb:fc49:3f56 with SMTP id
 a640c23a62f3a-afa1dfea15emr76229466b.15.1754943886562; Mon, 11 Aug 2025
 13:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809204833.44803-1-puranjay@kernel.org>
In-Reply-To: <20250809204833.44803-1-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 Aug 2025 22:24:10 +0200
X-Gm-Features: Ac12FXxoDTN6w9MePTj69lSGzgI969xP75uh0lMipmAijZIXjKwwaYy0EebihGw
Message-ID: <CAP01T76nRF81KDYL=44YQa2o-2uGSq6CapmDpD85JXtp05vK4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf, arm64: support for timed may_goto
To: Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Aug 2025 at 22:48, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Changes in v1->v2:
> v1: https://lore.kernel.org/bpf/20250724125443.26182-1-puranjay@kernel.org/
> - Added comment in arch_bpf_timed_may_goto() about BPF_REG_FP setup (Xu
>   Kuohai)
>
> This set adds support for the timed may_goto instruction for the arm64.
> The timed may_goto instruction is implemented by the verifier by
> reserving 2 8byte slots in the program stack and then calling
> arch_bpf_timed_may_goto() in a loop with the stack offset of these two
> slots in BPF_REG_AX. It expects the function to put a timestamp in the
> first slot and the returned count in BPF_REG_AX is put into the second
> slot by a store instruction emitted by the verifier.
>
> arch_bpf_timed_may_goto() is special as it receives the parameter in
> BPF_REG_AX and is expected to return the result in BPF_REG_AX as well.
> It can't clobber any caller saved registers because verifier doesn't
> save anything before emitting the call.
>
> So, arch_bpf_timed_may_goto() is implemented in assembly so the exact
> registers that are stored/restored can be controlled (BPF caller saved
> registers here) and it also needs to take care of moving arguments and
> return values to and from BPF_REG_AX <-> arm64 R0.
>
> So, arch_bpf_timed_may_goto() acts as a trampoline to call
> bpf_check_timed_may_goto() which does the main logic of placing the
> timestamp and returning the count.
>
> All tests that use may_goto instruction pass after the changing some of
> them in patch 2

For the set,
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Xu, can you also provide your acks before we land?
Thanks

>
>  [...]
>

