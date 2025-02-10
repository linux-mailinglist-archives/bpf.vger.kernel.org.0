Return-Path: <bpf+bounces-50933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD38A2E586
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2205A164300
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA11B2182;
	Mon, 10 Feb 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBD7Io96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2E1ADC86
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173096; cv=none; b=TKc9DNBM8UU8X1vsnJzNXL7IhYdyt8xGiiy5/8SLct8nxwrIIPiF7V8yU2nK+W9WUyQbAWGUk13XdwWqRRwej7sQ+T0O6FkGg5nvkFSBPLV6L8tQyvHlnLb1B45JrsKOTNFMPxjCGC4pLiOFI1hQGBcdZA1LJUslMi1s6MirqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173096; c=relaxed/simple;
	bh=aa+yDfbuXkbFiCT4dMy5mVXFmy7/LfkweX8PXy5FnG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0M7H4efGeRkazU+D6gPYJem9Z286mhxjpPFERRgskC6Ouk++dRBH+sa9NEllL8UsGL6/FRfZe65Wxe4fED4vY0mGmwO1e9r5kbhpMYL3z2i3ERJTPvxw7CjeFIRtye48D3wKZEpCAXkSPOWWNLHXyXdJbSM7jBjgi4xH2iOe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBD7Io96; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so4108965e9.0
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2025 23:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739173093; x=1739777893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WVx6P8+xc1y2bWX2S2s0Ch0U+hucKJhPXo+wkWufCA=;
        b=EBD7Io960pp1Pg12NzUREF7eW8Lnl89K2gSg5iPOMFiV3TcKRpGT8H8mlt4jbbGGQp
         iVohkAnhZeLG4wkC0ty8A0ldca5I8aiSmrgv4uY74haK9IO2WMxyi9HVNnu7UulcUedh
         VjHmKVcU6qIeKDtiTu0WSPYAmAz9rLEi4bOdZXHyabFZDhKoYBeZTSy2p35Wkqivk1bA
         KYkccQRIFUtUyF5/CYQ6N3W/o+GbZGGpGAUT+eZpuq7zl2Lf+2QakOkWv3XegBEsDVID
         tT9ERSy+D+awCUUzwtzkvUN8wcSKosWkeMiaPdWnbw22TeDQJZ4ekgPvkk5wDb1rHubp
         m+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173093; x=1739777893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WVx6P8+xc1y2bWX2S2s0Ch0U+hucKJhPXo+wkWufCA=;
        b=kE8BcLGnz5uH+gGaO1MUyLo2tJnA7rd3K5PyZJD5ZPBWmpGEN9b7px/wM2pIefKHHF
         MBYSxvgn+v8GW/JxMYdZQyF7kUWVJgruHvSCeObD/SImeE9JOE0WsNGPf3v8++CGKOiI
         8bg7Wf5rCYTUGF+310wWiQIC8etFS418ugVunJq8xzHBfRRKtiIczmA0hxHfKZpmtiai
         PUr/fD4wgHJjRi/VKBNEuCpPSPGMtjry+4dG32+IweY4sUTSihVew+xPSL15QBsX+I9V
         INfvuT/7QvO27ZvhsAcxodS2OltkaWGtANVs+BTefmqWoF7ykZTW1m5Le0QEWlS2get3
         PlTg==
X-Gm-Message-State: AOJu0Yx53YhddEkN4WRTrUKdzqH9fU2pzbvFXJ5s2/enDnmQRKiVKzwu
	7M7f3LRcCCOpUkk5Mezrwhi6B/Pl6nTDJb9UNfrDt/DD5pa8aNbp5QSrtXdtQLV1fDcPvCrY6/W
	ofh53Gru8leeN+URWK5p6NMmXB5Y=
X-Gm-Gg: ASbGncu53Q3owZVTnuP/7mlFA6SGCq6O1eHzWQYy2hkyV3GhsSUkOQBDsKi9zk6YMBX
	tv5FFRxObbk73w24t0ZhCq0O/r2fIhYaWsMOBIM6tWSIgof4DIX2S6m5CbjJurYkg6cXbmkXjnI
	1KZCRC9O9lbgbGLOSwMdZJ31gbAKLx
X-Google-Smtp-Source: AGHT+IHzpyrZRBwF37KYAFCc8OOs9F+4IppJtkKQY5hm0+HexFrafz+jzB8wCGJ67UTQCX7SUZbkyXy/WBrXSBlacDA=
X-Received: by 2002:a05:6000:1448:b0:38b:da31:3e3e with SMTP id
 ffacd0b85a97d-38dc90ee504mr9150809f8f.28.1739173093192; Sun, 09 Feb 2025
 23:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210073509.232007-1-yangfeng59949@163.com> <20250210073509.232007-3-yangfeng59949@163.com>
In-Reply-To: <20250210073509.232007-3-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 9 Feb 2025 23:38:01 -0800
X-Gm-Features: AWEUYZky_1rAF4l_zfSvKXS8QqrCvBumUhZjdXJ5lT5WIXD_bIXilQfHMyAwVNE
Message-ID: <CAADnVQKPnUwiQtPSRXEU7uFLJsh+esCnVDpOizJhuB+MsR+6xQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Revert "bpf: Support __nullable argument suffix for tp_btf"
To: Feng Yang <yangfeng59949@163.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 11:35=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> This commit 838a10bd2ebf
> ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
> has already resolved the issue, so we can roll back these patches.
> This reverts commit 8aeaed21befc90f27f4fca6dd190850d97d2e9e3.
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  kernel/bpf/btf.c      |  3 ---
>  kernel/bpf/verifier.c | 36 ++++--------------------------------
>  2 files changed, 4 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9433b6467bbe..e66f98b493d0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6683,9 +6683,6 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>         if (prog_args_trusted(prog))
>                 info->reg_type |=3D PTR_TRUSTED;
>
> -       if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
> -               info->reg_type |=3D PTR_MAYBE_NULL;
> -

Nack.
This is still useful and necessary.

