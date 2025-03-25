Return-Path: <bpf+bounces-54725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC0A70BBE
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2859A175BD8
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672F266B41;
	Tue, 25 Mar 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YRxWaJdv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68A2E3383
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935680; cv=none; b=fwaChjsC9IH9s1d0+dfv/9G3Z+i0wxMXVT6YPWRTWUxLGfpLvaRZddACDdhc9mFQpEfqrm4JGw5fwHM3XaPe/2CD6cLm0Vdo7xkrpnSpatIolFnk0NqVWdlZpW7aWi7DZdqxKmG+7AfxyHDSCzU9Ug2Zf/6Z9H3vfC8//LzoJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935680; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUcRb7ov5i0ZT+2cERqrF0BN6rdkS99G5TYfq59+IpUZuFl3ujO+nt/d1I41zRP3AeiOy7T+guOuVEzhqManc74UNp15eAfpAOb5RY0DhV7WtSfM1KKOlkx2KewwyCZ6N0geR2mQtHnSCBT+cZbTtFQAbyUtYKoAPSu1Hpj6x1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YRxWaJdv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso58929501fa.3
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935677; x=1743540477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=YRxWaJdvxe37p+I2JhwNtZW1sCjm10NN/PTtAPnCnriUgIIcYN3aozbNgmyRczNcwb
         Emv5n7K77Wzn9XXDeQekLGNr9XapoQEWT6AWTmT8swZ0oRE86xRl0Xr3LQdceXwCOWzQ
         3XHANMamPh+q4jbROoJrbUnoRWKNiG3CZ/f2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935677; x=1743540477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=h4Y1DvxBCbPqmDGDB1yzLnpqb3lMMkG6ZHIL3qMlj4vWWczSlKTwWAQFWPhLyXGFxq
         mDxrb1omHGidOWMcQ0uHN+NrLw7wssrojA17ET8PHyHquqExA3NfEHaccMaSQaR3Tlm8
         aPGN73jvhPES/pj1onr0fuGieKNW6hjQ4hD4avRh2OjOdBFUP9ARouBISW6RSqiHF8V7
         jTrODbvtEH/kl0fPchKurwtI7SJUJTVtGJejgckhbPhtdJRErb0ns/sEdIfWyIAirkDU
         z3wMAOqg4EzMSOfr1pvk2WPdkgVbT3Jz6JpETI66NYwfT2/wLlsE3r/fPc0DAsg3KJxa
         xc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAEIx+jZX6Rf1kgpGJW8zsH/Hhx1UbkkyWc3aauUIknPuzSQKtwvfbzxBguvs27Pb/6IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQ7prlcMKPgZKmD5Vr9VM94VakK/1dipwA9V56hN9udEkzPHi
	LVqaIceMuZ3F2iHFagDkaFw212ocLHqTEYY6Hq9m//3oxOknCcQaoyejYaQhFOz636MYWDi71TD
	eDvfoxw==
X-Gm-Gg: ASbGnctXR/FuT1Ciy7krTc0xCWP0YXguAroetK4EDjTImmTYvmSq3U/bvjR0CWAYoZh
	Im03pVuuoIJ7oNztkdNRHAlcaoY/NaWXX+Rp09kQKnW/0P7+3eiI3H7pWyvcI2iD12A3ekAkNrA
	ZVhpc6Dx+KeDgVWBjqNZwWutZ1S0LOKpbOS4ANAY6PDwykF4mUjXTqk/n5uzTSK4NTx1O+c286Z
	BLaaQskYwDFoP0SICXgGJLdyB28GoxMKLK1ADdKZaj4Voq2yiwFI+ySeICMCsu3aqFviUl05lhX
	axJ4JSGC/8qQZ7gCJLWxCEr7ekbK936lOjBkSKrONObwleLqe/CX1bSiKzvqS6SmU11kGpITDf4
	PFmoEZ3SnNAhdlUgS25gGWNtRjZgz35ae9Q==
X-Google-Smtp-Source: AGHT+IELg0o8fRHHGNyNocqWeI9x24ZAgPyoXLBAbDHWPps1wgc7Am7wH+WB+ip8XXEYAQu3HnkXgA==
X-Received: by 2002:a05:6512:3f1e:b0:545:cc5:be90 with SMTP id 2adb3069b0e04-54ad64f5976mr6855630e87.35.1742935676715;
        Tue, 25 Mar 2025 13:47:56 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbcafsm1600345e87.150.2025.03.25.13.47.56
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:47:56 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so61224511fa.1
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 13:47:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk78edgHp+XNkzml+T2fklwfVSgksOH35KSEEe96EFuT5v+btgYT+K0giC4+2e0rMLNVA=@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

