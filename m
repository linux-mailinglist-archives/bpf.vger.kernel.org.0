Return-Path: <bpf+bounces-41062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED74991D1D
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3D81C216F6
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62616DC15;
	Sun,  6 Oct 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA+8zoMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4015A85E
	for <bpf@vger.kernel.org>; Sun,  6 Oct 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202370; cv=none; b=Emeaw/+KKl9PkH5hQZ9DWbS/CoupTbiQIqV/HtTZqPgfn3xKFeT23GNi3yZVmzzYdctXy97p819N9e3cHQdN+PidmhqTVonifP66+jvOYfbEDH538MCvC2Qz14WBPNnYZkRmSHbKwjW+GXOuX4vLzTSnKgDdINmoaeJIlr5PFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202370; c=relaxed/simple;
	bh=UW6WULyxA5d21naeIcPOkzJwk3mWNfV9FkFdRKfbtU8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY0fT+po6iQB1U5sLtZ9G9XERLWPpxnSWCqxyxUZtS0/O0MY+qfpBGmz6DGKjczkHOCwGHqss1lWDLBJVdCtXwdYlcuHwFHVtHpy2Te3xtzQLKtn9seoq3xRmASp+U3l0yK0RwK6UxMWDua4y+u8jKnuBE6w89ebcW3WtQLDEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA+8zoMH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71df04d3cd1so1298906b3a.2
        for <bpf@vger.kernel.org>; Sun, 06 Oct 2024 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728202368; x=1728807168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=artPkW41Z61ETQcwHg2u7enDqp/1J6zZ1cX6U7ejan8=;
        b=CA+8zoMHVFHUgktHL5fRrWh9UhcbtrsLxtMMhyRt4wF19sfOsk9POiOK+LJ57sD3Wx
         90QSKox3dFbjAFCSoCTbAELQUD2Nlc1Dx7SOboVJQsCMwK2nGBIC0ohl2NlVphF1Asct
         Dz1XXvYcSlG9Fd5vBqgGvcwWKlPSNs+cOe1M2oDSpgtH4Cnna/TQrbnyzdeqapSnmxOZ
         fZwrTi5G86PVFAb6JkG+pGlsqgMA9SsnsP96YAOFwgkcTVvboFA5WFCWJzq7reAnBB84
         Dt+NOX4w5XC/aBYaiEeQhZbyGoZ8zXDmMfCKXsc0H9/wmo7K1F6R2lbxnJXbqFrTdsGm
         kD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728202368; x=1728807168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=artPkW41Z61ETQcwHg2u7enDqp/1J6zZ1cX6U7ejan8=;
        b=pR3+sXKnAnCDL8FpiYZRweyHzG6srxAQTIVZEdkdP1OQiLIEwqsD4lXnHiydL4Ovka
         5g7/oJdSo7EZe5SWqdEzH5mv7vEm+OjHy0QbLiy1w9kpqr1rt//nbmStDkohwfFDeWhd
         NBhyKurNFgCvuampJUSnnFcACVyp/slqgrKHRRkiQ0WuMqo8IR85ZlsZN3Wdr1VtBXhK
         LtsSZrmPA0NaFXZGxFtlAZ0x/4oKz4CEVtQAR8+d1Dz7JGYztEVCy9MSMbS3CRxZ14KM
         usutH3H4HKjLKf6bVzcJoIgGQ1mK8Zsaer6OE6aESW00mx+UH6FY//pewCBxkZCEvq8u
         jBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu2uDcY27+h2CkhwTWXloa+vsXTU38u3DoH39tZ8+nW7GlnIQJUOW/jpnTQT+JXOFEmJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgUMZEeMafsiv5t4Z/TxfjXeBn/iKmPORsXnjUA7nggVklWgh
	0JMNYDBFIZM8Y6latTysi9UgfY7rKd+MjzXhuf0dtD6z+AXZotoR
X-Google-Smtp-Source: AGHT+IHNMyE+7I+4fBtilCGY5EQJo1jhWPtEufNfn0u+TtSTGGmRXbM99zu7QaWjIRu1oIU0JQoFjA==
X-Received: by 2002:a05:6a00:2304:b0:717:81b3:4c6d with SMTP id d2e1a72fcca58-71de22f1b4emr14226763b3a.0.1728202368055;
        Sun, 06 Oct 2024 01:12:48 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccea54sm2466696b3a.68.2024.10.06.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:12:47 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sun, 6 Oct 2024 01:12:45 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	kernel-team@fb.com, yonghong.song@linux.dev, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf] selftests/bpf: fix backtrace printing for selftests
 crashes
Message-ID: <ZwJGfZvfH/8rKAsK@kodidev-ubuntu>
References: <20241003210307.3847907-1-eddyz87@gmail.com>
 <e5ef86e9bed0f3e1f4a7ad81301e0fe0a0063bb2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ef86e9bed0f3e1f4a7ad81301e0fe0a0063bb2.camel@gmail.com>

On Thu, Oct 03, 2024 at 02:07:23PM -0700, Eduard Zingerman wrote:
> On Thu, 2024-10-03 at 14:03 -0700, Eduard Zingerman wrote:
> 
> [...]
> 
> > Resolve this by hiding stub definitions behind __GLIBC__ macro check
> > instead of using "weak" attribute.
> > 
> > Fixes: c9a83e76b5a9 ("selftests/bpf: Fix compile if backtrace support missing in libc")
> 
> Hi Tony,
> 
> could you please double-check if your musl setup behaves as expected
> after these changes?
> 

Hi Eduard,

I discovered building for musl has broken over the last month or so, and
it took some time to find fixes and workarounds before I could retest.

Since glibc execinfo.h also defines its functions as weak, and given the
linking issues that can cause, I think changing the #ifdef as you did is
the right approach. But could you leave the fallback stub functions as
"__weak" like before to simplify overriding in the non-GLIBC case?

Otherwise:

Reviewed-by: Tony Ambardar <tony.ambardar@gmail.com>
Tested-by: Tony Ambardar <tony.ambardar@gmail.com>

Thanks,
Tony

> Thanks,
> Eduard
> 

