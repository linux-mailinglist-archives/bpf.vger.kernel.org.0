Return-Path: <bpf+bounces-16614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DEF803E3C
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943C1B20A18
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3931727;
	Mon,  4 Dec 2023 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogvbZv28"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB3D5
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 11:18:40 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d852e06b07so1729139a34.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701717520; x=1702322320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWNzZv699g9WmaMge8Xt2XGWr8M2fBvBoGU1E608xn8=;
        b=ogvbZv288l9hOeOHP58Zsi8eOI/g8vnxaXwHTjoqELNgUGTZgezgFk8KTjOp/RoZmW
         BUgwfSSHi+95sYPbKRxXNe3SBZHlJV5b8I4OyPrFAII4FClPXkyvp+sucAIs5ATbMw1p
         m1iQJ/9Pl1KNn6Ye0XjtCFzhIKMLx6f5mF5bwrFR9dyEgPoq82kZzZiDmGuFFu/pOn2o
         A+PcH7g7LKPt8qT+J2SAOxG5++6Iut2Fbt7iV71mBD2pOt2p3XqPEeexJiFraWg1/Wz7
         bvsRLwqVld+vT2Z7FUQQlIFANn00FnRQ+2td9V1obTI2aXDM9boRIyJoNZGEaW3qlf7W
         WrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717520; x=1702322320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWNzZv699g9WmaMge8Xt2XGWr8M2fBvBoGU1E608xn8=;
        b=mMC5Xe1BiFsYmdsptKeG3ytTg+CFacRbnOfyCbt5Ae+xw8Q30/Cq4mytDQfOjVZo6x
         Qi8iOB9EkHbKFXQjSyvXBudpPQQo3SMEe5tuQImZy8C+I+0N+l/i0/Iy1BQtS83Al+d5
         J5VqNvpQT2cmBCuYJXmaehYh6ntk5Q7qsNVSRElBPSS+BBxR1aRFhxEblQfSaj0jS2nC
         yQAjB7O1S5rNHtJ9oJorN22JnU5a5zy6XT+7KzoU0ucXS0MAHOUigNcF6V8QyE2rBoQ1
         g4kaI9Aq8zFMEA2+W+YliHYQoKbordmkNv/8m5lQIOLRsM7acQbFVCSq1m9nnE2cxgJo
         SJZA==
X-Gm-Message-State: AOJu0YxMNrWSC0Q9+VrNDpON0OaCN6zLV5W748cDMZKnWGR3YrZK8zOo
	Q5pXCrsBbDUYCgG3K7pqhxMixO2S07q4cBUhCxvdQQ==
X-Google-Smtp-Source: AGHT+IHyqGlUNEc09zfk+7C7spFR2KrAlLytNjHQMZMVaTcBh0jkMo0aAva0Taxeji7L30FkvzDde4ybRx0p4piiiZw=
X-Received: by 2002:a9d:4d02:0:b0:6d8:75a8:8455 with SMTP id
 n2-20020a9d4d02000000b006d875a88455mr2668679otf.50.1701717519644; Mon, 04 Dec
 2023 11:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130133630.192490507@infradead.org> <20231130134204.026354676@infradead.org>
In-Reply-To: <20231130134204.026354676@infradead.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 4 Dec 2023 11:18:03 -0800
Message-ID: <CABCJKufv1z0-+an7iws8J2v-c_Jg1Nfu47Um9rhCnVLxQfC6ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cfi: Flip headers
To: Peter Zijlstra <peterz@infradead.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	davem@davemloft.net, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, keescook@chromium.org, nathan@kernel.org, 
	ndesaulniers@google.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, jpoimboe@kernel.org, 
	joao@overdrivepizza.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 5:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Normal include order is that linux/foo.h should include asm/foo.h, CFI ha=
s it
> the wrong way around.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/riscv/include/asm/cfi.h |    3 ++-
>  arch/riscv/kernel/cfi.c      |    2 +-
>  arch/x86/include/asm/cfi.h   |    3 ++-
>  arch/x86/kernel/cfi.c        |    4 ++--
>  include/asm-generic/Kbuild   |    1 +
>  include/asm-generic/cfi.h    |    5 +++++
>  include/linux/cfi.h          |    1 +
>  7 files changed, 14 insertions(+), 5 deletions(-)

Looks good to me, thanks!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

