Return-Path: <bpf+bounces-12687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC27CF49C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 12:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AE6281F22
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2D179AF;
	Thu, 19 Oct 2023 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIrX8mlD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4E1798C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:05:08 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5811B
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 03:05:06 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d0252578aso42618046d6.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697709905; x=1698314705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3bjb9rubAXmEx3BuTMzb9DXzA+Icb3ceQsdxtJC/Jk=;
        b=EIrX8mlDk8ECbca87bJB42E8VlrXgUt7jw8+X+XGllferEcuW+KyKqHjk0BRtjXEai
         FHl82SRF9F2bBWCbf57lppJbAGfn5ex/88GqWJk/3aSsPSM4T7feYntd2cttpQlauj1M
         c49p20BP/PkZzyluI9TFOYE6J2vAecTVXDrB/i7WvMPbTyCjD6scho+MGGUBPhCEwdc2
         bkvMaFerPcE37lFun3Q6QVsed1BLdctBI2CKNK09stSs+smmGpZCKuFTAQRqZyJVaFrf
         MoGLm0gGX7RIqSldC9T7QeOXI0qitEtkmySHaKyTsxFaMjEimSphrTzrP5lkad0LunYQ
         BFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709905; x=1698314705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3bjb9rubAXmEx3BuTMzb9DXzA+Icb3ceQsdxtJC/Jk=;
        b=Ym0ITNXtEJ3425ORlNKfpPTcLzMg2FjRtiq5K1hqQnrdKKgA5JNcoShj68UyBG5u8s
         NL0y2VqULjN8ners1AMoBgJ3/AzWJoytcRmZ3n5xbF5CC7Qeo3YIKrXHA6QKFTjgB4Ri
         205NKLX5LUDvMKJHSN5RX0Vrf+eb2OzPFRmx+SXqZxb04BNzpCncWIGEehEXiWztovSE
         F0rttGnFOyhnadDbm1+zPFxP9Zmf+od9yr5Fa3c/++fVhIKK7C8vXK3RELQ9roDWipEs
         tbLzma3gyS8CoYYgsMKTmllm+2ztobh0qNE+smDjn7ocMkOx9frm/D+L9PgY875TAA4w
         w07g==
X-Gm-Message-State: AOJu0YwFTTyKqOWsw6Azn+CWgzYPZRxWsLM/rmZr5RWyHkL3SDZnVfxm
	1BDrejNxvNdjIcuivx1A6wk46wHz5nAAAfg0s3LZmQ==
X-Google-Smtp-Source: AGHT+IH6FHJbxjRMVCH1yb8tkbndeFnPREHuEjI+EYywqZ7BjmHUvnxgyZZpMGESGZMAgQQUcjtqiwGQIFSoapndiHM=
X-Received: by 2002:ad4:5f0b:0:b0:66d:1624:2200 with SMTP id
 fo11-20020ad45f0b000000b0066d16242200mr1943369qvb.13.1697709905579; Thu, 19
 Oct 2023 03:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018182412.80291-1-hamza.mahfooz@amd.com> <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
 <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com> <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 19 Oct 2023 12:04:23 +0200
Message-ID: <CAG_fn=XcJ=rZEJN+L1zZwk=qA90KShhZK1MA6fdW0oh7BqSJKw@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org, 
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <keescook@chromium.org>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Li Hua <hucool.lihua@huawei.com>, Rae Moar <rmoar@google.com>, 
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> > > Are kernels with KASAN || KCSAN || KMSAN enabled supposed to be bootable?
> >
> > They are all intended to be used for runtime debugging, so I'd imagine so.
>
> Then I strongly suggest putting a nonzero value here.  As you write
> that "with every release of LLVM, both of these sanitizers eat up more and more
> of the stack", don't you want to have at least some canary to detect
> when "more and more" is guaranteed to run into problems?

FRAME_WARN is a poor canary. First, it does not necessarily indicate
that a build is faulty (a single bloated stack frame won't crash the
system).
Second, devs are unlikely to fix a function because its stack frame is
too big under some exotic tool+compiler combination.
So the remaining option would be to just increase the frame size every
time a new function surpasses the limit.

