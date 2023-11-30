Return-Path: <bpf+bounces-16254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 737207FED80
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC8EB20F3A
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77D3C07E;
	Thu, 30 Nov 2023 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20230601.gappssmtp.com header.i=@anyfinetworks-com.20230601.gappssmtp.com header.b="Yy5Caf9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E28D50
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 03:06:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-285afc7d53aso839471a91.0
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20230601.gappssmtp.com; s=20230601; t=1701342419; x=1701947219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VK0p3Vrg4Gg8051ZETfeUKQ1X0pr423KlXMEXlRIo0=;
        b=Yy5Caf9yYmWIl0m8QuLvT9qJchaIADVeNjZCHGcdU7ctBUJyPL5IZZWy8ko9QHSsDl
         EqTCvEdCJdXV7JVsoIXslpFBugY7ObhtVqaZIiI5+ZzPDAcPGsXiIaKmNepQNRfZc9qX
         STFuDQPRXGIbcT4XR7zUoSE1fEmAvItjpuWbErKCPxwLQXC3aEO3kH5NYA3KKf5Gav2D
         pH3i5C6yfxMULIyAob54BWCAAu3OFRTLr1NH1Umxx2W50vOuvWd2T519eN3W+LC0nGkG
         GkH9c7+5xI9HdFgwuc8IWtjb/bRvvc1BbysI/o32uK0XGkA7xBPpMs5qaTm3YIMMPUXt
         XJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701342419; x=1701947219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VK0p3Vrg4Gg8051ZETfeUKQ1X0pr423KlXMEXlRIo0=;
        b=WKrufUIvHd1/yMsapLTZwFKmWU3TyZVA81pN+pJokgsaoBh7hjtak69vO2vWdmFQ4e
         mmioTz990iQX+D833tbSFIKWPhkSmA2ucCMPPy3+zxyz7tcSdrVp+Sr6Uv4otM8wh+Ux
         p5fADEMVj3X/Kb6bPrQ2Ejslrs1sQpFTFHvEHnW8EGG4eaY/ubr0ZpP6BTCJIf4dul6T
         g+e9WqTj6UEDullCiPG1lhlvmHvJgeBAmmwIJImr+QH1NZfM/Ty8ML7HkYkuYRKo+jLw
         vAo3qAGuIkWR0om5lXfyb/FwbtE65woxNGXQzRR6CIkXvfmYcqcxYch9IUKDMaaF8Vmr
         DxqA==
X-Gm-Message-State: AOJu0Yx3HSLA634xL4a7P8PoLqqxnUqYRqF3VTBJf7zlrF+N6SCkRCen
	dA8RKcC7OgiJiPg6N5BpbUJlyCoawSnNitHRmCBIbeyZ6tVYKUqXDqE24A==
X-Google-Smtp-Source: AGHT+IGRG2Kj3feKGEFU/XQUFejAMZBBDZm96Wb9G5ijegmK6KOjleBmGWbmZIs+ys/Nrx4T+FyGQgH52OMPGySu6Jg=
X-Received: by 2002:a17:90b:38c7:b0:286:49bf:b215 with SMTP id
 nn7-20020a17090b38c700b0028649bfb215mr172414pjb.25.1701342418824; Thu, 30 Nov
 2023 03:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130034018.2144963-1-yujie.liu@intel.com>
In-Reply-To: <20231130034018.2144963-1-yujie.liu@intel.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Thu, 30 Nov 2023 12:06:47 +0100
Message-ID: <CAM1=_QQJxwt7sYVWOpE93xv9R79WUJ3aocLKP3ZE+MZzHS7tpQ@mail.gmail.com>
Subject: Re: [PATCH] bpf/tests: Remove duplicate JSGT tests
To: Yujie Liu <yujie.liu@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 4:44=E2=80=AFAM Yujie Liu <yujie.liu@intel.com> wro=
te:
>
> It seems unnecessary that JSGT is tested twice (one before JSGE and one
> after JSGE) since others are tested only once. Remove the duplicate JSGT
> tests.

Looks like a copy-paste typo on my side. Thanks!

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

>
> Fixes: 0bbaa02b4816 ("bpf/tests: Add tests to check source register zero-=
extension")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  lib/test_bpf.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index 7916503e6a6a..87a4ebcc65be 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -12215,7 +12215,6 @@ static struct bpf_test tests[] =3D {
>         BPF_JMP32_IMM_ZEXT(JLE),
>         BPF_JMP32_IMM_ZEXT(JSGT),
>         BPF_JMP32_IMM_ZEXT(JSGE),
> -       BPF_JMP32_IMM_ZEXT(JSGT),
>         BPF_JMP32_IMM_ZEXT(JSLT),
>         BPF_JMP32_IMM_ZEXT(JSLE),
>  #undef BPF_JMP2_IMM_ZEXT
> @@ -12251,7 +12250,6 @@ static struct bpf_test tests[] =3D {
>         BPF_JMP32_REG_ZEXT(JLE),
>         BPF_JMP32_REG_ZEXT(JSGT),
>         BPF_JMP32_REG_ZEXT(JSGE),
> -       BPF_JMP32_REG_ZEXT(JSGT),
>         BPF_JMP32_REG_ZEXT(JSLT),
>         BPF_JMP32_REG_ZEXT(JSLE),
>  #undef BPF_JMP2_REG_ZEXT
> --
> 2.34.1
>

