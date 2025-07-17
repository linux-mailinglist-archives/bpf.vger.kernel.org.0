Return-Path: <bpf+bounces-63557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB9B08374
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97363169310
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E91F3BA9;
	Thu, 17 Jul 2025 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FusCoqje"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61931DA62E;
	Thu, 17 Jul 2025 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752723218; cv=none; b=Xfq0zntsxD5FKf1N7I/kEoFp9MjGBTeChGvoqKfvwnp1jVTEtdlhaLUZn54oxXzr8dQ56HZrSSXE/xjJb9DuoLavmakMeL1XGlAkOA+77Wo4NoKMhRUTmR0iHLtmRVYzNBToWG0svVXti2N+ZHxKVDHb4akCd16o5PiNy8+P6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752723218; c=relaxed/simple;
	bh=NxcYhOyfWQrT7mpklE3E8/PuJaPlbavmD2SNVWaOFb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9GjSL/131fM+YQvUUDBmwELilG378mIApsuGc4+YbWlLxRrnxsWQ52xE7Q1xtItRzGG4vsRVdl/q7g9yygG0pdC1yQiGIbquQk0DPia7jKFZ3f7kzfOgjMLtTz3+qkfZmM/7DvF3ge5/2H50tFb3L8NXdSPYtJMf4aC/cJoH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FusCoqje; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45555e3317aso2556375e9.3;
        Wed, 16 Jul 2025 20:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752723215; x=1753328015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oA8y14yagrQ5k6xSbfVfV7QH4qEs2A8CSReVFmZTWA=;
        b=FusCoqjegfZkj22l4PYv4+tvsTL5O9ZDaKyp7dtES3fS9Rf7RBqt7ui00zXW+fOou4
         ko3NFa1inqgSwmFcyxFAEDZUai6noX4a/n8/L6gKIkiXvC9q0qunJGgkrjepKY/qMjac
         oV45Ptcl0hM09TW+VAlWaU0gtwdSzKPgiiOLn2X1xbaQExpPIyaTJnHXrDJ/SGHCKBk7
         7Z+9GGsMDXsMvC9YBjdp3jVeSG8RP7shgZpWkEAOdnKS1QLIWIqbtgLJsOcwlzoSQIwC
         AaqDfg5uELNRQSPqXP+AfrhMKWKfu9OnFlMmX6X8DBlfXzWR31TTf96CaED6qJXk/1GC
         2Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752723215; x=1753328015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oA8y14yagrQ5k6xSbfVfV7QH4qEs2A8CSReVFmZTWA=;
        b=kcJIdKLnE9IPeq6t9s+2KNGZbwaD10Mi7T50hICGhMbl6jQNjGt+Q8D3fZoBz0+PsN
         LVrJOJ6dOWfu6PtGFphVxUzUoKdKoV5RiPhbt2hVzR/A8MNKd5U1M6Sw6h5HvlC+CSiS
         IByYmTNFItGoMRH1mZIMANKLqvOrjhhZgEBoiB1a1dDME/kAG/xb3URaOxsO/M2zitUj
         g5qUtPqdyPeBctHKPb0TUkuShoJNavxBZo8MDJI+r+YKGJKfaLp9z9RDqTi+V7e8HNWJ
         z+b1pXQL64rEJjrXisDPy5Yvvo693mjU0Bb42AM58GMnl2ZOAKOeFrx3J3fZINNRXi3C
         z2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUJuih9g7Khn1KOsAePWnJ66eq+ao0yn5koO9lKQgG4KqXqBtDOtaOCNk1YoZA32OtC/rw=@vger.kernel.org, AJvYcCVAQrjdISAzAVjt5XUyNngdpfFPIZ+y/a+x4eE5ei9+ChEOEXG+fZ1C3e4ZrCaSy061KS7nk7u6Yuula6uU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DJnE81fbEoqsYchySFYqWsyW9wxQWFMtdzlDTsftI25mbxQ9
	ol9u/ZvFVBiw7Q915qrLebsfUjLncv3+OtffrdawZDCgbebsIlmpMm7+WOPDhgGO9glHoqIFHG5
	WFXCjClPk2kbfPOEeNBmtgZGz6XtexDw=
X-Gm-Gg: ASbGncv/wiWVUNB6Rwp9+FSFCQCOK1AzrFwSNYX2i2gALuZqBP9dxNpPlxjaw1xA66L
	GgtSVZXBOAJ9dZgyGF6IwmkEZHl17wBGwwP6677DgMs7Hh9dww9JxG1M/eyRiPRujH9uDgxn2f9
	RU5JoRLhzua1PN0UA6lLJoKjgXaZlivf0r7fkHd5q0/9cHSrdFc87onWkDXi1FrWj2N8vfyRunh
	uiVC16U8YqXI4r98Rd6urKuOFUly9EhRiiS
X-Google-Smtp-Source: AGHT+IG+pmFZbAAM7Z9l3eMc+Veb/P/zicLt/6saYIOedxnEL29h5HnKsL/4dSTZ6zRwHN779i9D9qxS7EslSQ7ngVY=
X-Received: by 2002:a05:600c:4688:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-4562e3548e5mr51501185e9.9.1752723215028; Wed, 16 Jul 2025
 20:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717032828.500146-1-yangfeng59949@163.com> <20250717032828.500146-2-yangfeng59949@163.com>
In-Reply-To: <20250717032828.500146-2-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 20:33:23 -0700
X-Gm-Features: Ac12FXyw-BcEEGJjU0Q-RBC4WK4I7LITosRIzBxYH8dQ4nYSu_X4D71WO5qzivo
Message-ID: <CAADnVQL2OWzpEujGafMObS-V6LKbJsg5rLDEG7b9L2VfJ0uS8g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix macro redefined
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 8:29=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> When compiling a program that include <linux/bpf.h> and <bpf/bpf_helpers.=
h>, (For example: make samples/bpf)
> the following warning will be generated:
> In file included from tcp_dumpstats_kern.c:7:
> samples/bpf/libbpf/include/bpf/bpf_helpers.h:321:9: warning: 'bpf_stream_=
printk' macro redefined [-Wmacro-redefined]
>   321 | #define bpf_stream_printk(stream_id, fmt, args...)               =
               \
>       |         ^
> include/linux/bpf.h:3626:9: note: previous definition is here
>  3626 | #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, _=
_VA_ARGS__)
>       |         ^
>
> The main reason is due to below in sample/bpf/Makefile:

No. We're not going to change kernel code because of samples.

--
pw-bot: cr

