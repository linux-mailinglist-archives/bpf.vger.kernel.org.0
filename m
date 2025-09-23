Return-Path: <bpf+bounces-69320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4DB940C3
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04A42A5D59
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 02:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A9273D9A;
	Tue, 23 Sep 2025 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2e7WA2r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A501D63F5
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596030; cv=none; b=EkVC1Qr0pOK9fjaig9EqeI31lTECqCuy/9By2w51A4uG1jh/n9dlGNJ9PUAhu0IYknHMSjmsD6UBa2VZa+biSw4rMOG8lJ1I9FzQvFMC6+OBsrIi5Ox3bAWfUEMNHVbexH1mxo0kwqvbBOE+2XNFulNKZFXC0WDvQTuCdthqwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596030; c=relaxed/simple;
	bh=4KL5v3OTEDwbPW2YYJKsjCzONjJMxy1fcQiPQrMYEq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpCarN2MgMaq9XT88KM2AdFzeWhQ74LSPquLDb0ds+xD785maur0UYhLJ24al9+oA48oHtHK0M8i6tBtHsnXTFLVjJqpTbPwOF/vGLQDfinGTCoHJD1W6au1ddRz92SMRsrFH60orWJ9xiqYfEqhIfZJ866Cg9elEBmOf+P8Xgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2e7WA2r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2607773f8f.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596026; x=1759200826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woHeSz+wN8VLZBX1PJ6mCkAi00YzbMjWoGGz/eAoJTo=;
        b=I2e7WA2rcN/NthinaUjp0Vr/GE3zHducsKM0DvTj9ZB4DO3l/GzIxby72VbegFqeXa
         YkNRu8b+gATiCxEFTrrTrxeC0k/laOP/csWMozRecNgplquJcmOXV9i+fwidcW5uenV6
         EF9wlUF/xOy2WJy1DTAWlfeizlh/oqRZoANb9Dk1aOK5n50niMQAa79r2Hg/wQGPL+Zx
         jLGTskPt4WH7VCFongQN55TP85a/acNIu0eV8eG51aFEtHDGWfR5Ahr/mjwhuNFqLWqL
         WLRQLS+ZpUiIqnla3wKA5Vn8FzDS6DW1t427QPUQSfiS4kFFLhQj8x5PmH3DET5SRm3i
         nPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596026; x=1759200826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woHeSz+wN8VLZBX1PJ6mCkAi00YzbMjWoGGz/eAoJTo=;
        b=ETKIb7QNpA5oOASj3lqesa/68eMxJ5hbjU/uJXxbuJdiqdyGnl92BMSAgXbiyh9qMf
         YgJGLjTNaKATACOM99CO2b/of4/BKHT45flqlq3UbFSJ7OI2Bo/pw2/7PbT67Lze+kfX
         d/pXQJxAz3pyM7tLOLpEqt9phjX2uVkIfFf6gDF2kN/Nc2bcpAkCmqGtEAdnDt+3OA63
         fMAtnW0So3MnIHKqA6aJOQkUhh6HKVoFBEAlfrGazyLn+lbXmhkZIJRNPNEb+1rCWDt0
         /t2EnSLR/3IZbsQrW1smtOOOoQAYtsSnFJW+O3TLwBMrOuOEqh5pCx32AMpsrKaREJMG
         8zLA==
X-Forwarded-Encrypted: i=1; AJvYcCVJgdWZtBUCDKZJRUhbmTVl/9Iga1P91KkZKvzfmB5goET1QUnTP66ZRfLwBCH2/qD6w68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeBn9sSKnEEl6jxVJYvEFDJJToYw1GgDjR4+th0VLGjvWKthh
	jPPI2MNuqqRayXbxQTNatGlf8XRXxnnDC9pZqnj03JMhuZooMxmgaMGZu4aHfq9EQDLWqwgETDZ
	tjedKH3jNXmmXpGLriRGTu5RbpkFVK58=
X-Gm-Gg: ASbGnctCNsVed0UB/HF1cBmOlCkKwe7AOkecPgmE9d9Wad39v1Z2iWM3R5e4tljILdf
	VDW/v8epyoe+ah6KbxOobu3MYp9Z6CDqfgAQDVOpD8gNt41Y7tN5wau3mgWSKAXY2Z5q7+hKrTj
	ZI1p2bk3BUDi/Ke7rZ7I5IPhURvFD+J0UJv7rywfN46ooFNb4XBHeH7DzkBqMyI+xwahshoycVd
	zV7nLiropH3a41R8k6ebnDpiIiGxzE1B6Z/v5VG
X-Google-Smtp-Source: AGHT+IHCLyj57vgWvMHGuc9+n8xyMBPrUAj3lSER1jbbCPJgW8Up2JuNBFO+TEIk+iCTBVYGf1v1oerNxYwQ1LGj0Gc=
X-Received: by 2002:a05:6000:40dc:b0:3f7:4637:f052 with SMTP id
 ffacd0b85a97d-405cb7bbb1bmr605565f8f.44.1758596026347; Mon, 22 Sep 2025
 19:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922075333.1452803-1-chen.dylane@linux.dev>
In-Reply-To: <20250922075333.1452803-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Sep 2025 19:53:35 -0700
X-Gm-Features: AS18NWC4b7F3GzLWN_qWwWaDX6YXSurSDS7Ypc-IAWe_3G5_P_08uwhLNGAtxwk
Message-ID: <CAADnVQKtOCXdv-LJ-T6K_meAS26C_i4Yc0hOpYS46umsPmuQAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add preempt_disable to protect get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:54=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> As Alexei suggested, the return value from get_perf_callchain() may be
> reused if another task preempts and requests the stack after BPF program
> switched to migrate disable.
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 2e182a3ac4c..07892320906 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -314,8 +314,10 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, =
struct bpf_map *, map,
>         if (max_depth > sysctl_perf_event_max_stack)
>                 max_depth =3D sysctl_perf_event_max_stack;
>
> +       preempt_disable();
>         trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
>                                    false, false);
> +       preempt_enable();

This is obviously wrong.
As soon as preemption is enabled, trace can be overwritten.
guard(preempt)();
can fix it, but the length of the preempt disabled section
will be quite big.
The way get_perf_callchain() api is written I don't see
another option though. Unless we refactor it similar
to bpf_try_get_buffers().

pw-bot: cr

