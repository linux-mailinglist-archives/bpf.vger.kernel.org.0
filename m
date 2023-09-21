Return-Path: <bpf+bounces-10588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5377AA160
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D261F217B3
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9EB1945C;
	Thu, 21 Sep 2023 21:01:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65751802D
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 21:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE5FC433C9;
	Thu, 21 Sep 2023 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695330063;
	bh=hCh/xnZDThu8X/r1W4mPrKSTQRTLFP9JJ4UDYRkUvbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DqPL41QgTABzGsEhvTxDLB7u9AiNv6mUDN2hd+WFgvFtTr60bTbKxld9+hl6yUlFN
	 Ft1AgbQZTwybqWV7DXGNeo3s0CMlSagOOTjdPDp4pYDq07srlGRIX0MyuBLClhG9LT
	 FDNhmmGG9IaPaaoHkvnspTMhtjraXdZURls655C+nYvvcTG3YHrxkp5ihUvmBKGO29
	 nwyiUyA8aM3DIZXLI3Y0oWzI5CvAgx1K5vYuWq6awKAuAwegV+Sc20RFVfDFdd6Nmb
	 8wUwXZj9Oz6wyTt5Zs2HN5OW+Q2wAQBrqGU/bTB0044W1zkyL6HqFndFw751iEBoH6
	 ifLpItc3EXIiQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50317080342so2516240e87.2;
        Thu, 21 Sep 2023 14:01:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxlq7vEISfiQWjvnA7gdj1TsxEv4vK8emXrlEpqTXEVMHP+S04e
	F1hJ1HGawlV63Elfbsgy/vqLW3znO5xV5nEuWzQ=
X-Google-Smtp-Source: AGHT+IFpiqWyDk5PR4hGq5PJ62am/Spvox/vLEeSXDTXmvYDCxXg7SmHSiR9Bse9DJNp2oHzW0gNcWK6TWoFJB3UsmQ=
X-Received: by 2002:ac2:58ec:0:b0:500:75e5:a2f0 with SMTP id
 v12-20020ac258ec000000b0050075e5a2f0mr5446791lfo.51.1695330061487; Thu, 21
 Sep 2023 14:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-2-kpsingh@kernel.org>
In-Reply-To: <20230918212459.1937798-2-kpsingh@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 14:00:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW619HF=NNXFpiF3COzHZk3ASfUM4Dvzu5v_4dU9dwG41g@mail.gmail.com>
Message-ID: <CAPhsuW619HF=NNXFpiF3COzHZk3ASfUM4Dvzu5v_4dU9dwG41g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] kernel: Add helper macros for loop unrolling
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 2:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> This helps in easily initializing blocks of code (e.g. static calls and
> keys).
>
> UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
> argument as the index of the iteration. This allows string pasting to
> create unique tokens for variable names, function calls etc.
>
> As an example:
>
>         #include <linux/unroll.h>
>
>         #define MACRO(N, a, b)            \
>                 int add_##N(int a, int b) \
>                 {                         \
>                         return a + b + N; \
>                 }
>
>         UNROLL(2, MACRO, x, y)
>
> expands to:
>
>         int add_0(int x, int y)
>         {
>                 return x + y + 0;
>         }
>
>         int add_1(int x, int y)
>         {
>                 return x + y + 1;
>         }
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>

