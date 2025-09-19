Return-Path: <bpf+bounces-68921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C44EB887F1
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002591C85BFE
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BF62F3637;
	Fri, 19 Sep 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehuxSC37"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0B2D061F
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272344; cv=none; b=GYXcT9aLL80Cw+KvLP6aayR+kbuSkr9EebaC7uGHSrKVxYAqwaeM5YBOlz2+Ik0ROdI5fyA5zjF4QKcMBtGCW8mEYKH7Vvyv/gvGZJD3FYLcs40/2buov56xweS1m2zWTn3bZVt2SxVqlbJpRsWsCWE5WoWwYK9JwzZIHrs3nhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272344; c=relaxed/simple;
	bh=4uHiAhmjz4HvvsRR+6QXMejTe1kxUEwD4XDNCTHMwUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlv2/ZgRjRYbwT+hDyyH9XnFRcDYDZFqUpJ0BHkmzxzzbQPFofqEBeUrqJ90uitMjnksERfR6tPFVZn9RoCzXdTdvRyuYAXsJiDpTFDWy2iEJxNuMxEdq4iaiwkcWFR3smJhuukiBtDp8slUeHzvk5XvXaSwPBjJ44rOvfRwL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehuxSC37; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77e543e41e9so582400b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758272343; x=1758877143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQy537aqBM0rrRlMX24xhM+FaVzNB12yBLDzIALSRMo=;
        b=ehuxSC37XC8HX9cS4RTJunDrj43oYCoqGukVH3AZHe9RkFvluNWtUMz5tK6yD5u8oW
         8PzUOxjGmYAirVa5Z8ttX0xvO9nGfbK71sPoF/hw/n8L3cbFxUJ5PSzB85l77O0tI/4q
         8AljbVM/wATf0LfOylFRxWnhoSZ7HUNanT4NxjMf1+F6Myol2K2z/qozOjSXQ/aKFNeb
         PLNCfrkdgc8+LwZ2oKSJObRRbSKHbHQtUzDkkAzQIm2sANTjwXeb53G9VUXc/JSjIcmn
         W/sLPLHPrDqTY5Y6bUaBSl0GNCGEuW1jxodjAAWzn6Nvy/HXCVjTnP/6G09qsBc+lWFS
         z75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758272343; x=1758877143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQy537aqBM0rrRlMX24xhM+FaVzNB12yBLDzIALSRMo=;
        b=Ed9ajcbhFb0R+WcMcfWU83zihM/hvqEevzEZFyud+mMyAIaCBKoCfJJOPI6lqs5xAv
         ELuttWnFPrto4zOvwBtkPoTQk/zvhvdkglFByksY2xgA/tJgmqLnoKnoy9fPOGAFQ/OM
         yI6ZKtg7ArHnehXaUOZjOdL+gWMkwx2AM1V5bAGikSbNm8jtWdqQHDvURMVA9ArCLaSn
         GSszeEYAYyEfgoyEh7wsZBsXV3f3RQDsTDbUqJozeAUF+i0kNWlW3z6Aev9gdVLTo44a
         n9QbY6xbVJ9dfVCPZ+UdYtbBEhhTx/heQFmpdO9I1ZBitAt9BuC0y9ISyN20DAlO4RRV
         TQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm9tpIetC5I7OovHVVReFzF+mTStfAgj4L3htyruWyFKsY6cfWKbw5T4Zy3QucHHI0nX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBCudBOtQgOrcWuJaRskgdpDJyXq4ueJAZP59AKPtR/WAsMQk
	gXt2F/e0NBiAktIVulE6+psfYvGy0zixVGtrgCRiQDAoM8RgkA21opZ5
X-Gm-Gg: ASbGncsyPLmvJUArBzLvDy4sqZdpFH8QUYP/bVOVqNwzy8mVyi6vF2inbYK0Y0XaJBv
	JEWdxKLKatdE+1WEV5lCs0e+PcHGIrp4cji/Hl6D0IXb9q2uvKkOdeI8PmHpJAOpMtbIJ90ufJo
	nTUMNgULO3tY0Qx09BIaM8s7M9Eplxoe/7dbzEyf/FMMKFiziiIjkvwZIWMFLBx1CEt858uLxKX
	9O4411wyEwesvmpEocqeEf9MBJkIo2QnDADJI9Ed+otcVKZmWssYp47pHNiWq3ojLeGH/yrEC9l
	UtyLRoGQBRqoSgfpo8+6QyK/9G7jd5N+lhfvzdeYofDXwZRP+VQQwlrIC36kAgnus4xqsRS1ayB
	3uo0l/q5NHc6lj2JbRvsZ1/WQvUemNVQI
X-Google-Smtp-Source: AGHT+IHoc0/EfneCAyEuRmzL/rc1AObl5i8C5aTuBs/BR4Vdss/Bsj6ETsMBplHwinvw4h0Em3nQSg==
X-Received: by 2002:aa7:88c9:0:b0:776:1dbf:375b with SMTP id d2e1a72fcca58-77e4d31b70emr3946944b3a.6.1758272342702;
        Fri, 19 Sep 2025 01:59:02 -0700 (PDT)
Received: from 7940hx.localnet ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7aba3sm4631771b3a.15.2025.09.19.01.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:59:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kees@kernel.org, samitolvanen@google.com, rppt@kernel.org,
 luto@kernel.org, mhiramat@kernel.org, ast@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Date: Fri, 19 Sep 2025 16:58:57 +0800
Message-ID: <5925436.DvuYhMxLoT@7940hx>
In-Reply-To: <20250919175255.f7c2c77fa03665a42b148046@kernel.org>
References:
 <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250919175255.f7c2c77fa03665a42b148046@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On 2025/9/19 16:52 Masami Hiramatsu <mhiramat@kernel.org> write:
> On Thu, 18 Sep 2025 20:09:39 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> > kprobe_multi_link_exit_handler -> is_endbr.
> > 
> > It is not protected by the "bpf_prog_active", so it can't be traced by
> > kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> > make it notrace.
> 
> Ah, OK. This is fprobe's issue. fprobe depends on fgraph to check
> recursion, but fgraph only detects the recursion in the entry handler.
> Thus it happens in the exit handler, fprobe does not check the recursion.
> 
> But since the fprobe provides users to register callback at exit, it
> should check the recursion in return path too.

That's a good idea to provide recursion checking for the exit handler,
which is able to solve this problem too.

If so, we don't need to check the recursion on the kprobe-multi anymore.
Do we?

Thanks!
Menglong Dong

> 
> Thanks,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 





