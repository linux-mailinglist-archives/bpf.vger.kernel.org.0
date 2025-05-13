Return-Path: <bpf+bounces-58140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B64DAB5E56
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 23:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC1E1B4564B
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 21:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A41922FD;
	Tue, 13 May 2025 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMXTsazQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0952201276;
	Tue, 13 May 2025 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171168; cv=none; b=lc3wsYdiE+Y6cLeLgCZL49suc92eASjUA9e83w4PBr4ND4KZFQYracxRb+XqS9kqOAf/wJT3a+dxAzJjpVGFClkeiUGYShnESa9BpVYw9bxhzZUlR+Vh+SHNoqU8wFplCr6g+5oN7LFFqMiJqnb6hf41nQdZQFZd9pGXCF4fFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171168; c=relaxed/simple;
	bh=wwsaxtDJcxn+aKUGiPx/Z5SuIDpjkZ03+jZq2w/rpx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhM06LTZ4WPDOv7GIXWayFizIcPlDFNRLB00Hgq39X/su/YjOZMPffGqFlzslhjbYSXldo2qlJhNJTwn7VyPxU3GlmAZrDvnBg4enOaENeVUg8UZuhhcdZcBZ6Sff4zKhViOLRJT2ZqMqsXQ80ECi2Fc8aRwWYQmKoBN02Mf3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMXTsazQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a20257c815so3187487f8f.3;
        Tue, 13 May 2025 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747171165; x=1747775965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqUOcURsI9IKQK470d3iHtcaSNqZOk2/X15O9wFfFLs=;
        b=MMXTsazQOQZCnpTLqK6N2pTDLNUtQkqHtlR6F7vupfwhIx3Cmh5wAsiiEOd3yPGDtR
         2V1aPIC2UmZ3YD6A2NjXdxq0m8e3t3h4opi6U+gbwXl0AM8/9fxFEY2/JzUCmb2hR60M
         V1t+hgO389l4k+B2WMdCMTKONE15Qhc3CyQ+SGcPS5U8HeZ3XJgIo8T3NxVEn3Z4QNaw
         EonX/hV0qQm7J0et8VD3VL3v/vLpFWsizXZ3dYmEl2IX2u3NSyMTkGWHY5VlZXcEyEi8
         w7lCN4hnwryGTcPj1jHBvqvwApf47VPi48mqnbEJCDoFukrSATCNvQJBTeKlC7+iYMuq
         PaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747171165; x=1747775965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqUOcURsI9IKQK470d3iHtcaSNqZOk2/X15O9wFfFLs=;
        b=BToLlSty4qW0sC1UCUsnbFixcIgkjUnbgVfz+tcFTIPsXXJ7qW/Ldu77ud6qv7Hx/L
         5pTtNr46O4KWLRkpdlNqyCU8vh2QAxlnNUgw6ugwE3obhSKjk4gzIQL39PopgnJsCHNs
         TatMQTnsfBMuwyDGUoYh91rlu3PmvGZWxptBops4acI06plnXjWO+l2CXSksv7ZcOhyh
         EuwE3wFVZalyFnsJR3AGB837jrWUaDsqyBTgiHIql3XQqVOrHbVOKV6fpvmkWGeENJ8X
         ZI534gxhj5cP/0g/s+LuXMJZ4ueJjkwvS7jWMgIVFVFPTMty9HizUZEdX+ZfUk88vxNe
         TSPA==
X-Forwarded-Encrypted: i=1; AJvYcCV49swy24kAUZpD5uApiYVb5kTlYz6GWzh3R1zFLNEUIBoL75mQR9iWTCFwXgLQxdwki/FeGum9Oqv0TWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ymlKaFZThYl64SggePWD85hSAwbUQ9+FI4byeaOG1X7t5gQL
	zUtT7oErQQtJCbjyVXGtRcAFtlUaMw7iXx5UG/eRpl7XoiLHBw9jGjbk2EwHSZ9JSQPxMcY0FQa
	YFomvBK0jn69SU0Gyxa94Qx1AgZk=
X-Gm-Gg: ASbGncvADOm8bFz9VOvXUCDE4/LaTwCf7nw5Si8QYc2FPhxdFI5B75UIpjIUvXwMIXv
	6KpCBT4UMIGOEEKpOdpunOuXbaV8Jdd56YCzljhmwy7VzXpRh6LncBc0n0xQh0hjrkLNfHhhSEX
	gQ1Oe8KNusUYRZ9MqR5wnZCpSIYi1w7sm3xOX6HVSNW6wsKztIwHqMqvQ5icdnNg==
X-Google-Smtp-Source: AGHT+IFkGg/2/Tmg0ij8JNRWus+ukKu5WP7alYp+YXdMtIs23VZa3IEQOnh7v5Vy066vjyM/47xFmO6y1S0+upzDZJw=
X-Received: by 2002:a05:6000:430b:b0:3a1:fdff:5394 with SMTP id
 ffacd0b85a97d-3a34994ac63mr624066f8f.57.1747171164770; Tue, 13 May 2025
 14:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513035853.75820-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250513035853.75820-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 May 2025 14:19:13 -0700
X-Gm-Features: AX0GCFvukt8CRdCACG4Y3UMwQBoo9HF66fpgYu5mj5tVDj2sXIzKNf1pgXKAssM
Message-ID: <CAADnVQJJ7pLsm0UTzPOj1H+rdaaY7Lv0As0Te-b+7zieQbntkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for custom BTF path in
 prog load/loadall
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 8:59=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> This patch exposes the btf_custom_path feature to bpftool, allowing users
> to specify a custom BTF file when loading BPF programs using prog load or
> prog loadall commands. This feature is already supported by libbpf, and
> this patch makes it accessible through the bpftool command-line interface=
.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/bpf/bpftool/prog.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index f010295350be..63f84e765b34 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char **argv=
, bool first_prog_only)
>                 } else if (is_prefix(*argv, "autoattach")) {
>                         auto_attach =3D true;
>                         NEXT_ARG();
> +               } else if (is_prefix(*argv, "custom_btf")) {
> +                       NEXT_ARG();
> +
> +                       if (!REQ_ARGS(1))
> +                               goto err_free_reuse_maps;
> +
> +                       open_opts.btf_custom_path =3D GET_ARG();

I don't see a use case yet.
What exactly is the scenario where it's useful ?

