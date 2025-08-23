Return-Path: <bpf+bounces-66368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585ABB32B17
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E4C3B38EF
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40460228C9D;
	Sat, 23 Aug 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pp0P7H8d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799D1F76A5
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967764; cv=none; b=kTblnOXbwKyJ4ma3C+iOgUEuZSPVw0R01PtrBn3qSzte+gT467bnvRw351oxZAe2IeKnlTbP+DC5dizE3a3xuUyNj/ODoX9uiu2JrRO07LFnCWwouZ6x+5u9Cj48hkrzU5UNX5hbLNpspN6KUJrBgzkf+K0ptd6pxTnZwCAjIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967764; c=relaxed/simple;
	bh=8YpxJPRMsJBkynas/VbqXASvJV+LVskvWZ5lioILCQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H91kckXE8/oTDgtczImZo2T72fDl56C48c3Nj+PWFDVVlqqNNE+I/rEh6/wix1LTq0s9asLcrtIcCORz/W6VkPH4Sr0x6xrW8k+pr6/LC9OQJQT5oS5jpIDR3JYVThVehLzOIWTD9LVylZNg6icuK7RMK3SjibeOw8BNgb1T/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pp0P7H8d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-246257e49c8so125555ad.0
        for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755967762; x=1756572562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YpxJPRMsJBkynas/VbqXASvJV+LVskvWZ5lioILCQw=;
        b=pp0P7H8dG/khRsKBG3fY035Vq/ukNYIfFWKuBVC/kDd2lyjs/z4sIDMFfPOwdubAVx
         yx4JVCdlp8ExSYDzyMeFLFBVBYxj8uyZBAlvryFxeQeVro+4l3so+DZo2HNJlK5zPHh3
         qz1glcaq0X2ph+FuV8s5XUKFYDttu9cEBuYw8IzdGZhMbWu49yrlq6sdDPUy1Bt4hgIc
         PGl6km7+A6WaC9VGX9PWEztmVlCwYzzbUj7iabyCl1wmJh4C8XJR5tHRIUN4SDd58CPL
         7EZMPYR59jGltEHVgwY+rdiRHpqjfjTNFtAUAp4nW16AyI9vl9AIjBkw4lP2J4uRMhrm
         sM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755967762; x=1756572562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YpxJPRMsJBkynas/VbqXASvJV+LVskvWZ5lioILCQw=;
        b=xKXHep/BF2A7flchcHucUj7sgk66t4L1HTJcjrQmgZj3T+Ks+tdGUy+jDc7Q13MAsL
         FUmZldlGiT9qCeX6rkDRefOtOlWP9Y36FI2fWEgoSbWtx1SotClxEnrunEcuHKY97vMH
         2a+XRV4xqVT6Y5YRgE0fjCKMzSZARYnG9Z/wKL5wcU/OLHe1j0t+mkujNem/XwibC/gq
         lQTXh3g6Oq+m5Vz3HhRN5OrJf+PRoXzbM+Zdpi/Y71zD47YsnH71UZKNjJa5GvBInu0j
         RF4txRdcD90eTRXP99ISoYKaCWnxtfwj7DttvJ2J9sDkUCIO7t+bXpOxbJfbc54b1nKT
         kTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvpGtPoG23m9M7eVhD6qy0NlFCuXlaLylWsYJd4EmiPdPF+XfSfGCeAP7UkJrKarJe7UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGon+ARQX4ssYFcTXiMjOse7keUbswgXNeRbOAED5sw7mRQRZ
	E0uxRnvSEMblbxzUao7tKMaQYFsJBH4hmhjPmlFA2Y13mtECp4c8KPksN57u3Pt9kl1WFDeeW5d
	3aAKumLLyw76Lel+Sw8O5994sdG1cluNKkvPjZrOP
X-Gm-Gg: ASbGncuFzg2S0w9Ep4DFursrNAapVyfQ/oCi9/6HaZ3fAkHYYAMI946HKpUYjPlfZq4
	sIqAmM5HH9tyFRyp58xZx2ERvLgwdCbk9CzrOSIT6UTb34rvQQmd2ZohE3sutcVHOClCXAw9sh8
	TmXm4dD7GpBb5zB7YE4FLocxZR+ELkNMC4F+oz8cfizydhtGIeNnLLDtdtWylfd/Qf48vJE2y+8
	1vOSNOgWPGDBA==
X-Google-Smtp-Source: AGHT+IGGKzyig0sJhIDWW/nSQxj4OQzvDA0OPRGfLHvzMGNVvjSyeTmmkEB5lOEbZ5yCPiIdJ8wlqYpa3Scf59bznr8=
X-Received: by 2002:a17:903:2f82:b0:240:520b:3cbc with SMTP id
 d9443c01a7336-2466fa251e2mr2803115ad.14.1755967761957; Sat, 23 Aug 2025
 09:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldnacz33.fsf@gentoo.org> <87cy8mcyy4.fsf@gentoo.org>
In-Reply-To: <87cy8mcyy4.fsf@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Aug 2025 09:49:10 -0700
X-Gm-Features: Ac12FXx_I9TlyYoS8Acvvq3h2swrT6lD-bRfYeprBApJYtrL-ohu-WwZy8Q9SnA
Message-ID: <CAP-5=fV+-VZ+SsGL1SJGYMEv-gwkv1AKk_6MZJ4tLBrCXFnMQA@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Sam James <sam@gentoo.org>
Cc: acme@kernel.org, adityag@linux.ibm.com, adrian.hunter@intel.com, 
	ak@linux.intel.com, alexander.shishkin@linux.intel.com, amadio@gentoo.org, 
	atrajeev@linux.vnet.ibm.com, bpf@vger.kernel.org, chaitanyas.prakash@arm.com, 
	changbin.du@huawei.com, charlie@rivosinc.com, dvyukov@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	kan.liang@linux.intel.com, kjain@linux.ibm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mark.rutland@arm.com, mhiramat@kernel.org, 
	mingo@redhat.com, morbo@google.com, namhyung@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, peterz@infradead.org, sesse@google.com, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 11:52=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>
> > A few months ago, objdump was the only way to get
> > source line support [0]. Is that still the case?
>
> ... or is this perhaps handled by "[PATCH v5 18/19] perf srcline:
> Fallback between addr2line implementations", in which case, shouldn't
> that really land first so people can try the LLVM impl and use the
> binutils one if it fails?

So my opinion, BUILD_NON_DISTRO isn't supported and the code behind it
should go away. Please don't do anything to the contrary or enable it
for your distribution - this was supposed to be implied by the name.
The forking and running addr2line gets around the license issue that
is GPLv3* but comes with a performance overhead. It also has a
maintenance overhead supporting llvm and binutil addr2line, when the
addr2line output changes things break, etc. (LLVM has been evolving
their output but I'm not aware of it breaking things yet). We should
(imo) delete the forking and running addr2line support, it fits the
billing of something we can do when capstone and libLLVM support
aren't there but the code is a hot mess and we don't do exhaustive
testing against the many addr2line flavors, the best case is buyer
beware. Capstone is derived from libLLVM, I'm not sure it makes sense
having 2 libraries for this stuff. There's libLLVM but what it
provides through a C API is a mess requiring the C++ shimming. Tbh, I
think most of what these libraries provide we should just get over
ourselves and provide in perf itself. For example, does it make sense
to be trying to add type annotations to objdump output, to just update
objdump or have a disassembler library where we can annotate things as
we see fit? Library bindings don't break when text output formats get
tweaked. Given we're doing so much dwarf processing, do we need a
library for that or should that just be in-house? We can side step
most of this mess by starting again in python as is being shown in the
textual changes that bring with it stuff like console flame graphs:
https://lore.kernel.org/lkml/CAP-5=3DfU=3Dz8kcY4zjezoxSwYf9vczYzHztiMSBvJxd=
wwBPVWv2Q@mail.gmail.com/
So I think long term we make the perf tool minimal with minimal
dependencies (ie no addr2line, libLLVM, etc.), we work on having nice
stuff in the python stuff where we can reuse or build new libraries
for addr2line, objdump-ing, etc. Use >1 thread, use asyncio, etc.

For where we are now, ie no python stuff, BUILD_NON_DISTRO should go
away as nobody is maintaining it and hasn't for 2 years (what happens
when libbfd and libiberty change?). We should focus on making the best
of what we have via libraries/tools that are supported - while not
forcing the libraries to be there or making the perf binary massive by
dragging in say libLLVM. The patch series pushes in that direction and
I commend it to the reader.

No, reordering the patches to compare performance of binutils doesn't
make sense, just build with and without the patch series if you want
to do this, but also don't do this as BUILD_NON_DISTRO should go away.

Thanks,
Ian

* (As I understand the issue IANAL) GPLv3 and GPLv2 can't be linked
together. Why not just use GPLv3? A major issue for me is that GPLv3
adds a requirement for =E2=80=9CInstallation Information=E2=80=9D to be pro=
vided,
which means placing a binary in a cryptographically signed OS
partition you'd need to reveal the signing key which defeats the
purpose of signing the partition to ensure you aren't hacked. I like
open source and using the code, I don't want to be hacked by giving to
the hackers my signing keys.

